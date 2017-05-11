//
//  main.swift
//  swift_2
//
//  Created by fly on 2017/5/11.
//  Copyright © 2017年 石峰. All rights reserved.
//

import Foundation

/*
 1.创建数组
 
 */
// 创建一个初始化类型为Int，数量为3，初始值为0的数组
var someArray1 = [Int](repeating: 0, count:3);

print(someArray1)

// 创建一个含有是三个元素的数组
var someInts:[Int] = [10,29,38];
print(someInts);



/*
 2.访问数组
 */
var someVar = someInts[0];
print(someVar);


/*
 3.修改数组
 */
var someArray2 = [Int]();
// 给数组中添加元素
someArray2.append(20);
someArray2.append(30);
someArray2.append(40);
someArray2 += [10];
// 数组拼接数组
someArray2 += [60,20];
someArray2[2] = 3;
print(someArray2);



/*
 4.遍历数组
 */
for item in someArray2 {
    print(item);
}

for (index ,item) in someArray2.enumerated() {
    print("在\(index)位置的是\(item)");
}



/*
 5.合并数组
   我们可以使用加法操作符(+)来合并两种已存在的相同类型数组
 */



/*
 6.count属性
 */
print("someArray2的元素个数为=\(someArray2.count)");



/*
 7.移除数组中的元素
 */
someArray2.remove(at: 0);
print("someArray2的元素个数为=\(someArray2.count)");
print("\(someArray2)");


/*
 8.isEmpty属性
   我们可以通过isEmpty来判断数组是否为空，返回bool值
 */
print("someArray2是空的吗=\(someArray2.isEmpty)");



/*
 9.创建字典
 */
var someDic1 = [Int:String]();
var someDic2:[Int: String] = [1:"one",2:"two",3:"three"];



/*
 10.访问字典
 */






