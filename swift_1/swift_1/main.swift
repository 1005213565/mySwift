//
//  main.swift
//  swift_1
//
//  Created by fly on 2017/5/11.
//  Copyright © 2017年 石峰. All rights reserved.
//

import Foundation


/*
   1.类型别名
 */
typealias Feet = Int;
// 通过别名来定义变量
var distance:Feet = 100;
print(distance);


/*
 2.类型安全
   由于swift是类型安全的，所以它会在编译你的代码时进行类型检查，并把不匹配的类型标记为错误。
 */
var var1 = 4;
//var1 = "This is hello";
print(var1);


/*
 3.类型推断
   当你要处理不同类型值时，类型检查帮你检查错误。然而，并不是说你每次声明常量和变量的时候需要显示指定类型。
 如果你没有显示指定类型，swift会使用类型推断来选择合适的类型
 */

let meaningOfLife = 42; // meaningOfLife会被推断为Int类型
let pi = 3.1423; // pi会被推断为Double类型，当推断为浮点型时，Swift总是会选择Double而不是Float
let another = 3 + 0.33434; // 原始值3没有显示声明类型，而表达式中出现了一个浮点型字面量，所以表达式会被推断为Double类型


/*
 4.变量声明
   变量声明的意思就是告诉编译器在内存中的哪个位置上为变量创建多大的储存空间
   在使用变量前，你需要使用var关键字声明他
 
 */
var var2 = 23;
var var3 = 34.000;


/*
 5.变量命名
   可以使用以前学习的方法，也可以使用Unicode字符（例如：汉字）
 */


/*
 6.便来你那个输出
  变量和常量可以使用print函数来输出
  在字符串中可以使用括号与反斜杠来插入变量
 */
var name = "菜鸟教程";
var site = "http://www.run.com";
print(name+"的官网地址为："+site);
print("\(name)的官网地址为：\(site)");



/*
 7.可选类型（Optional）
   可选类型类似于OC中的指针nil值，但是nil只对类有用，而可选类型对所有类型都可用，并且安全
 */
var optionalInteger1: Int?;
var optionalInteger2: Optional<Int>; // 可能有值，可能没有

var myStr:String? = "sdf";
if (myStr != nil){
    print(myStr ?? String());
}else {
    print("字符串为nil");
}


/*
 8.强制解析：
   使用叹号（!）类获取一个不存在的可选值会导致运行时错误，使用!来强制解析之前，一定要确定可选类型包含一个非nil的值
 */
var myStr1:String? ;
if (myStr1 != nil){
    print("可选类型的字符串是=="+myStr1!);
}else {
    print("字符串为nil");
}


/*
 9.自动解析：
   你可以在声明可选变量时使用感叹号(!)替换问好(?),这样可选变量在使用时就不需要再加一个感叹号(!)来获取值，它会自动解析
 */
var myString:String!

myString = "Hello, Swift!"

if myString != nil {
    print(myString)
}else{
    print("myString 值为 nil")
}



/*
 10.可选绑定：
    使用可选绑定(optional bingding)来判断可选类型是否包含值，如果包含就把值赋给一个临时常量或者变量。可选绑定可以用在if和while语句中来对可选类型的值进行判断并把值赋给一个常量或者变量
 */
var myStr3:String?
myStr3 = "你好，哈哈";
if let yourStr = myStr3 { // 如果myStr3包含值（包括空字符串），则把它赋值非yourStr
    print("你的字符串值为=="+yourStr);
}else {
    print("你的字符串没有值");
}



/*
 11.字面量：
    所谓的字面量就是指特定的数字，字符串或者是布尔值，能够直接了当的指出自己的类型并为变量进行赋值的值。
 */

let aNumber = 3; // 整形字面量
let aString = "Hello"; // 字符串字面量
let aBool = true; // 布尔值字面量



/*
 12.整形字面量：
    整形字面量可以是一个十进制，二进制，八进制或十六进制常量。二进制前缀为0b，八进制前缀为0o，十六进制为0x
 */
let num1Integer = 17; // 十进制
let num2Integer = 0b1001; // 二进制
let num3Integer = 0o32; // 八进制
let num4Integer = 0x11; // 十六进制


/*
 13.浮点型字面量：
    浮点型字面量有整数部分，小数点，小数部分及指数部分
 */



/*
 14.字符串型字面量
    字符串型字面量由双引号中的一串字符组成
 */


/*
 15.字符串长度
 */
var vara = "1234567890";
print("字符串的长度是==\(vara.characters.count)");


/*
 16.字符串比较
 */
var var_1 = "哈哈哈";
var var_2 = "啦啦";
if var_1 == var_2 {
    print("var_1与var_2相等");
}else {
    print("var_1与var_2不相等");
}



/*
 17.Unicode字符串
 */
var unicodeStr = "菜鸟教程";
for code in unicodeStr.utf8 {
    print(code);
}


/*
 18.字符串函数及运算符
    1.判断是否为空  isEmpty
    2.hasPrefix(prefix:String) 检查字符串是否拥有特定前缀
    3.hasSuffix(suffix:String) 检查字符串是否拥有特定后缀
    4.Int(String) 转换字符串数字为整形
    5.utf8  您可以通过遍历String的utf8属性来访问他的UTF-8编码
    6.unicodeScalars  你可以通过遍历String值的unicodeScalars属性来访问它的Unicode标量编码
 */



/*
 19.遍历字符串中的字符
 */
for ch in "Runnob".characters {
    print(ch);
}



/*
 20.字符串连接字符
 */
var var_a: String = "hello";
let var_b: Character = "G";
var_a.append(var_b);
print(var_a);






















