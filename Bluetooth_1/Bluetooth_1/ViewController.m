//
//  ViewController.m
//  Bluetooth_1
//
//  Created by fly on 2017/5/17.
//  Copyright © 2017年 石峰. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h> // 蓝牙核心框架

// 如果不是把手机作为中心设备，那就没必要加下面的宏定义
#define KPeripheralName @"myBick"  // 外围设备名称
#define KServiceUUID @"" // 服务的UUID
#define KCharacteristicUUID @"" // 特征的UUID


@interface ViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate,UITableViewDelegate,UITableViewDataSource> // 中心管理者代理、外围代理
@property (weak, nonatomic) IBOutlet UITableView *bluetoothTable;
@property (weak, nonatomic) IBOutlet UITextView *resultTextView;

@property BOOL cbReady;
@property(nonatomic) float batteryValue;
@property (nonatomic, strong) CBCentralManager *manager; // 中心管理者
@property (nonatomic, strong) CBPeripheral *peripheral; // 外围设备
@property (strong ,nonatomic) CBCharacteristic *writeCharacteristic; // 特征
@property (strong,nonatomic) NSMutableArray *nDevices;
@property (strong,nonatomic) NSMutableArray *nServices;
@property (strong,nonatomic) NSMutableArray *nCharacteristics;

@property (strong,nonatomic)NSTimer *myTimer; // 定时器
@property (assign,nonatomic)BOOL isStartTimer; // 是否开启定时器
@property (strong,nonatomic)NSOperationQueue *queue; // 请求队列
@end

@implementation ViewController

/**
 *  蓝牙的分类：
 1.中心模式：常用的（其实99.9%）就是使用中心模式作为开发，就是我们手机作为主机，连接蓝牙外设；
 2.管理者模式，这个基本用到的比较少，我们手机自己作为外设，自己创建服务和特征，然后有其他的设备连接我们的手机。
 
 在做蓝牙之前，最好先了解一些概念：
 服务：蓝牙作为外设广播的必定会有一个服务，可能也有多个，服务下面包含着一些特征，服务可以理解成一个模块的窗口
 特征：存在于服务下面也可以存在多个特征，特征可以理解为具体实现功能的窗口，一般特征都会有value，也就是特征值，特征是与外界交互的最小单位
 UUID：可以理解为蓝牙上的唯一标识符（硬件上肯定不是这个意思，但是这样理解便于我们开发），为了区分不同的服务和特征，或者给服务和特征取名字，我们就用UUID来代表服务和特征。
 
 蓝牙连接可以大致分为以下几个步骤：
 1.建立一个Central Manager实例进行蓝牙管理
 2.搜索外围设备
 3.连接外围设备
 4.获取外围设备的服务
 5.获得服务的特征
 6.从外围设备读取数据
 7.给外围设备发送数据
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    // 设置中心管理者的代理
    self.manager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    _cbReady = false;
    _nDevices = [[NSMutableArray alloc]init];
    _nServices = [[NSMutableArray alloc]init];
    _nCharacteristics = [[NSMutableArray alloc]init];
    
    _bluetoothTable.delegate = self;
    _bluetoothTable.dataSource = self;
    [self.bluetoothTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
    
    // 创建定时器
//    [self createTimer];
}
- (void)setUI{
    NSArray *tempArray = @[@"搜索设备",@"连接设备",@"断开设备",@"暂停搜索",@"车辆上锁",@"车辆解锁",@"开启坐桶",@"立即寻车"];
    float unitWidth = [UIScreen mainScreen].bounds.size.width / 4;
    for (int i = 0; i < tempArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        if (i < 4) {
            button.frame = CGRectMake(i * unitWidth, 20, unitWidth, 40);
        }else{
            button.frame = CGRectMake((i - 4) * unitWidth, 60, unitWidth, 40);
        }
        button.tag = 1000 + i;
        [button setTitle:tempArray[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnActions:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}


#pragma mark --CBCentralManagerDelegate--
// 检查蓝牙状态
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
        case CBCentralManagerStatePoweredOn: // 蓝牙开启
        {
//            [self updateLog:@"蓝牙已打开，请扫描外部设备"];
            NSLog(@"蓝牙已打开，请扫描外部设备");
            // 开始扫描外部设备
            [self startScanPeripheral];
        }
            break;
        case CBCentralManagerStatePoweredOff: // 蓝牙关闭
        {
            NSLog(@"蓝牙没有打开，请打开蓝牙");
        }
            break;
        case CBCentralManagerStateResetting: // 蓝牙重置
        {
            
        }
            break;
        case CBCentralManagerStateUnknown: // 蓝牙状态不知道
        {
            
        }
            break;
        case CBCentralManagerStateUnsupported: // 蓝牙状态不支持
        {
            
        }
            break;
        case CBCentralManagerStateUnauthorized: // 蓝牙状态未经授权
        {
            
        }
        default:
            break;
    }
}

// 检查到外置设备后停止扫描，连接设备
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{
    NSString *tempStr = [NSString stringWithFormat:@"已发现 peripheral:%@ rssi:%@, UUID:%@ advertisementData:%@",peripheral,RSSI,peripheral.identifier,advertisementData];
    NSLog(@"%@",tempStr);
    
    _peripheral = peripheral;
    // 连接外部设备
    [_manager connectPeripheral:_peripheral options:nil];
    
    // 停止扫描
    [self.manager stopScan];
//    if (self.isStartTimer) {
//        [self stopTimer];
//    }
    
    BOOL replace = NO;
    // 之前匹配过的设备
    for (int i = 0; i < _nDevices.count; i++) {
        // 取出外部设备
        CBPeripheral *p = [_nDevices objectAtIndex:i];
        if ([p isEqual:peripheral]) {
            [_nDevices replaceObjectAtIndex:i withObject:peripheral];
            replace = YES;
        }
    }
    
    // 如果以前没有匹配此设备，那么添加此设备到数组中
    if (!replace) {
        [_nDevices addObject:peripheral];
        [_bluetoothTable reloadData];
    }
    
    // 开启代理的定时器
//    [self startTimer];
}

// 连接外设成功后，开始发现服务
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
     NSLog(@"%@", [NSString stringWithFormat:@"成功连接 peripheral: %@ with UUID: %@",peripheral,peripheral.identifier]);
    
    // 连接成功后，设置外部设备的代理
    [self.peripheral setDelegate:self];
    // 外部设备发现的服务
    [self.peripheral discoverServices:nil];
    
    NSLog(@"扫描服务");
}

// 连接外设失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"连接外部设备失败");
}

// 已经断开连接的外部设备
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"已断开与设备:[%@]的连接", peripheral.name);
    for (int i = 0; i < _nDevices.count; i++) {
        // 取出外部设备
        CBPeripheral *p = _nDevices[i];
        if ([p isEqual:peripheral]) {
            [_nDevices removeObject:peripheral];
            [_bluetoothTable reloadData];
        }
    }
}

#pragma mark --CBPeripheralDelegate--
- (void)peripheralDidUpdateName:(CBPeripheral *)peripheral{
    NSLog(@"外部设备已经更新名称");
}

// 已发现服务
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    NSLog(@"发现服务");
    int i = 0;
    for (CBService *service in peripheral.services) {
        [self.nServices addObject:service];
    }
    
    for (CBService *service in peripheral.services) {
        NSLog(@"%d :服务 UUID: %@(%@)",i,service.UUID.data,service.UUID);
        i++;
        
        [peripheral discoverCharacteristics:nil forService:service];
    }
}

//已搜索到Characteristics
-(void) peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
 
    NSLog(@"发现特征的服务:%@ (%@)",service.UUID.data ,service.UUID);
    
    for (CBCharacteristic *c in service.characteristics) {
        NSLog(@"特征 UUID: %@ (%@)",c.UUID.data,c.UUID);
        
        if ([c.UUID isEqual:[CBUUID UUIDWithString:@"FF01"]]) {
            _writeCharacteristic = c;
        }
        
        if ([c.UUID isEqual:[CBUUID UUIDWithString:@"FF02"]]) {
            [_peripheral readValueForCharacteristic:c];
            [_peripheral setNotifyValue:YES forCharacteristic:c];
        }
        
        if ([c.UUID isEqual:[CBUUID UUIDWithString:@"FF04"]]) {
            [_peripheral readValueForCharacteristic:c];
        }
        
        if ([c.UUID isEqual:[CBUUID UUIDWithString:@"FF05"]]) {
            [_peripheral readValueForCharacteristic:c];
            [_peripheral setNotifyValue:YES forCharacteristic:c];
        }
        
        if ([c.UUID isEqual:[CBUUID UUIDWithString:@"FFA1"]]) {
            [_peripheral readRSSI];
        }
        
        [_nCharacteristics addObject:c];
    }
}

// 获取外部设备发送过来的数据
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
}

// 从外围设备读取数据
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    if (characteristic.isNotifying) { // 通知已经开始（相当于数据包在连接着）
        [peripheral readValueForCharacteristic:characteristic];
        NSLog(@"外围设备和管理中心连接着，有通知");
    }else{ // 通知停止，因此断开了和外部设备的连接
        NSLog(@"外围设备和管理中心断开着，没有通知");
        // 取消和外部设备的连接
        [self.manager cancelPeripheralConnection:self.peripheral];
    }
}

// 用于检测中心向外设写数据是否成功
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if (error == nil) {
        NSLog(@"发送数据成功");
    }
    
    /*
     写发生时,需要设置一个重读的地方CBCharacteristic更新它的值
     */
    [peripheral readValueForCharacteristic:characteristic];
}

#pragma mark ---tableView代理---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.nDevices.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
    CBPeripheral *p = _nDevices[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@:%@",p.name,p.identifier];
    return cell;
}

#pragma mark --按钮的点击方法---
- (void)btnActions:(UIButton *)sender{
    switch (sender.tag) {
        case 1000:
        {
            // 搜索设备
            NSLog(@"正在扫描外部设备...");
            [self startScanPeripheral];
            
            double delayInSeconds = 30.0;
            // 相当于30秒之后执行下面的代码
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.manager stopScan];
                NSLog(@"扫描超时，停止扫描");
            });
        }
            break;
        case 1001:
        {
            // 连接设备
            if (_peripheral && _cbReady) {
                [_manager connectPeripheral:_peripheral options:nil];
                _cbReady = NO;
            }
        }
            break;
        case 1002:
        {
            // 断开外部设备的连接
            if (_peripheral && !_cbReady) {
                [_manager cancelPeripheralConnection:_peripheral];
                _cbReady = YES;
            }
        }
            break;
        case 1003:
        {
            // 暂停搜索
            [self.manager stopScan];
        }
            break;
        case 1004:
        {
            // 车辆上锁
//            [self lock];
        }
            break;
        case 1005:
        {
            // 车辆解锁
//            [self unLock];
        }
            break;
        case 1006:
        {
            // 开启坐桶
//            [self open];
        }
            break;
        case 1007:
        {
            // 立即寻车
//            [self find];
        }
            break;
        default:
            break;
    }
}


#pragma mark ---private---
- (void)startScanPeripheral {
    // 扫描外部设备
    // @[[CBUUID UUIDWithString:@"FF15"]]是为了过滤其他设备，可以搜索特定表示的设备
    //            [_manager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:@"FF15"]] options:@{CBCentralManagerScanOptionSolicitedServiceUUIDsKey: @YES}];
    
    // 开始扫描外部设备
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber  numberWithBool:YES], CBCentralManagerScanOptionAllowDuplicatesKey, nil];
    
    [_manager scanForPeripheralsWithServices:nil options:options];
}

// 创建定时器
- (void)createTimer{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSTimer *timer = [NSTimer timerWithTimeInterval:3.0f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        self.myTimer = timer;
        // 将定时器加入到runloop中
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop] run];
        
    });
    
    
}
- (void)timerAction{
    if (self.isStartTimer) {
        static int tempNum = 0;
        // 定时器在子线程中执行
        [self startScanPeripheral];
        tempNum++;
        if (tempNum == 100000) {
            tempNum = 0;
        }
        NSLog(@"定时器执行了%d次",tempNum);
    }
}

- (void)startTimer{
    self.isStartTimer = YES;
    [self.myTimer setFireDate:[NSDate distantPast]];
}
- (void)stopTimer{
    self.isStartTimer = NO;
    // 关闭定时器
    [self.myTimer setFireDate:[NSDate distantFuture]];
}

// 车辆上锁
- (void)lock {
    // 在和硬件之间的数据发送和接受，都用的是btye数组，最后，添加一个存储已经连接过得设备
    Byte byte[] = {3, 1};
    if (_peripheral.state == CBPeripheralStateConnected) { // 先检查外部设备的连接状态
        [_peripheral writeValue:[NSData dataWithBytes:byte length:2] forCharacteristic:_writeCharacteristic type:CBCharacteristicWriteWithoutResponse];
    }
}

// 车辆解锁
- (void)unLock {
    Byte byte[] = {3, 0};
    if (_peripheral.state == CBPeripheralStateConnected) { // 已经连接了外部设备
        [_peripheral writeValue:[NSData dataWithBytes:byte length:2] forCharacteristic:_writeCharacteristic type:CBCharacteristicWriteWithoutResponse];
    }
}


// 开启坐桶
- (void)open {
    Byte byte[] = {4, 1};
    if (_peripheral.state == CBPeripheralStateConnected) {
        [_peripheral writeValue:[NSData dataWithBytes:byte length:2] forCharacteristic:_writeCharacteristic type:CBCharacteristicWriteWithoutResponse];
    }
}

// 立即寻车
- (void)find {
    Byte byte[] = {7};
    if (_peripheral.state == CBPeripheralStateConnected) {
        [_peripheral writeValue:[NSData dataWithBytes:byte length:1] forCharacteristic:_writeCharacteristic type:CBCharacteristicWriteWithoutResponse];
    }
}

// 将字符串转换成二进制的算法
- (NSData *)hexStrig:(NSString *)hexString {
    int j = 0;
    Byte bytes[20];
    // key的Byte数组，128位
    for (int i = 0; i < [hexString length]; i++) {
        int int_ch; // 两位16进制数转化成的10进制数
        
        unichar hex_char1 = [hexString characterAtIndex:i]; // 取出字符串中对应位置的字符，作为两位16进制数中的第一位
        int int_ch1;
        if (hex_char1 >= '0' && hex_char1 <= '9') {
            int_ch1 = (hex_char1 - 48) * 16; // 0的Ascll是48
        }else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        else
            int_ch1 = (hex_char1-87)*16; //// a 的Ascll - 97
        i++;
        
        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        else
            int_ch2 = hex_char2-87; //// a 的Ascll - 97
        
        int_ch = int_ch1+int_ch2;
        NSLog(@"int_ch=%d",int_ch);
        bytes[j] = int_ch;  ///将转化后的数放入Byte数组里
        j++;
    }
    
    NSData *newData = [[NSData alloc] initWithBytes:bytes length:20];
    
    return newData;
}

#pragma mark - 命令
#pragma mark - 鉴权
-(void)authentication {
    Byte byte[] = {1, 1, 2, 3, 4, 5, 6, 7, 8};
    if (_peripheral.state == CBPeripheralStateConnected) {
        [_peripheral writeValue:[NSData dataWithBytes:byte length:9] forCharacteristic:_writeCharacteristic type:CBCharacteristicWriteWithoutResponse];
    }
}

#pragma mark - 写密码
-(void)writePassword:(NSString *)initialPw newPw:(NSString *)newPw {
    Byte byte[] = {2, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8};
    if (_peripheral.state == CBPeripheralStateConnected) {
        [_peripheral writeValue:[NSData dataWithBytes:byte length:17] forCharacteristic:_writeCharacteristic type:CBCharacteristicWriteWithoutResponse];
    }
}

#pragma mark ---懒加载---
- (NSOperationQueue *)queue {
    if (!_queue) {
        _queue = [[NSOperationQueue alloc]init];
        [_queue setMaxConcurrentOperationCount:1]; // 设置最大并发数
    }
    return _queue;
}
@end























