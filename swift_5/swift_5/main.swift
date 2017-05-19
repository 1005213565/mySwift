//
//  main.swift
//  swift_5
//
//  Created by fly on 2017/5/12.
//  Copyright © 2017年 石峰. All rights reserved.
//

import Foundation

/*
 1.下标脚本
   下标脚本可以定义在类（Class）、结构体、和枚举这些目标中，可以认为是访问对象、集合或序列的快捷方式，不需要再调用实例的特定的赋值和访问方法
   语法及应用
 */
// 实例1（结构体）
struct subExample {
    let decrementer:Int;
    // 它相当于一个通过下标访问结构体的方法
    subscript(index:Int) -> Int {
        return decrementer / index;
    }
    
}
// 相当于初始化上面的结构体，初始化的时候必须有参数
let division = subExample(decrementer: 100);
print("100 除以 9 等于 \(division[9])")
print("100 除以 2 等于 \(division[2])")
print("100 除以 3 等于 \(division[3])")
print("100 除以 5 等于 \(division[5])")
print("100 除以 7 等于 \(division[7])")

let result = subExample(decrementer: 40)[10];
print(result);


// 实例2 （类）
class daysOfWeek {
    private var days = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","saturday"];
    subscript(index: Int) -> String {
        get {
            return days[index]; // 声明下标脚本的值
        }
        
        set (newValue) {
            self.days[index] = newValue; // 执行赋值操作
        }
    }
}

var p = daysOfWeek()

print(p[0])
print(p[1])
print(p[2])
print(p[3])




/*
 2.下标脚本选项
    下标脚本允许任意数量的入参索引，并且每个入参类型也没有限制
    下标脚本的返回值也可以是任意类型
    下标脚本可以使用变量参数和可变参数
    一个类或结构体可以根据自身需要提供多个下标脚本实现，在定义下脚本时通过传入参数的类型进行区分，使用下标时会自动匹配适合的下标脚本实现运行，这就是下标脚本的重载
 */

struct Matrix  {
    let rows:Int, columns:Int;
    var print:[Double]; // 结构体里面数组的个数
    
    init(rows:Int, columns:Int) {
        self.rows = rows;
        self.columns = columns;
        print = Array(repeating: 0.0, count: rows * columns);
    }
    
    subscript (row:Int, column: Int) -> Double {
        get {
            return print[(row * columns) + column];
        }
        set {
            print[(row * columns) + column] = newValue;
        }
    }
}

// 创建了一个新的 3 行 3 列的Matrix实例
var mat = Matrix(rows: 3, columns: 3)

// 通过下标脚本设置值
mat[0,0] = 1.0
mat[0,1] = 2.0
mat[1,0] = 3.0
mat[1,1] = 5.0

// 通过下标脚本获取值
print("\(mat[0,0])")
print("\(mat[0,1])")
print("\(mat[1,0])")
print("\(mat[1,1])")










