//
//  main.swift
//  swift_3
//
//  Created by fly on 2017/5/12.
//  Copyright © 2017年 石峰. All rights reserved.
//

import Foundation

/*
 1.函数定义
   定义函数的时候，可以指定一个或多个输入参数和一个返回值类型
   每个函数都有一个函数名来描述它的功能。
 */
func runoob(site:String) -> String {
    return site;
}

print(runoob(site: "我是形参"));




/*
 2.元组作为函数返回值
   函数返回值类型可以是字符串，整形，浮点型等
   元组与数组类似，不同的是，元组中的元素可以是任意类型，使用的是圆括号
 */
func minMax(array:[Int]) -> (min:Int, max: Int) {
    var currentMin = array[0];
    var currentMax = array[0];
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value;
        }else if value > currentMax {
            currentMax = value;
        }
    }
    return (currentMin, currentMax);
}

let bounds = minMax(array: [2,4,2,6,6,83,-3,-4,39]);
print("最小值=\(bounds.min)\n最大值=\(bounds.max)");



/*
 3.如果你不确定返回的数组一定不为nil，那么你可以返回一个可选的元组类型
 */
func aminMax(array:[Int]) -> (min:Int, max: Int)? {
    if !array.isEmpty{
        var currentMin = array[0];
        var currentMax = array[0];
        for value in array[1..<array.count] {
            if value < currentMin {
                currentMin = value;
            }else if value > currentMax {
                currentMax = value;
            }
        }
        return (currentMin, currentMax);
    }
    return (0,0);
}

let abounds = aminMax(array: []);
print("最小值=\(abounds!.min)\n最大值=\(abounds!.max)");




/*
 4.外部参数
   你可以在局部参数名前指定外部参数名，中间以空格分割，外部参数名用于在函数调用时传递给函数的参数
 */
func pow1(firstArg a:Int, secondArg b:Int) -> Int {
    if a > b {
        return a;
    }
    return b;
}
print("使用外部参数函数\(pow1(firstArg: 2, secondArg: 3))");



/*
 5.可变参数
   可变参数可以接受零个或多个值。函数调用时，你可以用可变参数来指定函数参数，其数量是不确定的
   可变参数通过在变量类型名后面加入(...)的方式来定义。
 */
func vari<k>(members:k...) {
    for i in members {
        print(i);
    }
}
vari(members: "我的","你的","他的");


/*
 6.常量、变量、及I/O参数
   一般默认在函数中定义的参数都是常量参数，也就是这个参数你只能查询使用，不能改变它的值
   如果想要声明一个变量参数，你可以在参数定义前加inout关键字，这样你就可以改变这个参数的值了。
 */
func swapTwoInts(a: inout Int) -> Int {
    a += 1;
    return a;
}
var x = 4;
print("变量参数加1了=\(swapTwoInts(a: &x))");




/*
 7.swift闭包
   闭包是自包含的功能代码块，可以在代码中使用或者用来作为参数传值
   闭包的形势有：
   1.全局函数：有名字但不能捕获任何值
   2.嵌套函数：有名字，也能捕获封闭函数内的值
   3.闭包表达式：无名闭包，使用轻量级语法，可以根据上下文环境捕获值
 
 swift中的闭包有很多可以优化的地方
   1.根据上下文推断参数和返回值类型
   2.从单行表达式闭包中隐式返回（也就是闭包体只有一行代码，可以省略return）
   3.可以使用简化参数名，如$0,$1（从0开始，表示第i个参数）
   4.提供了省略尾闭包语法
 */

let divide = {(value1:Int ,value2: Int) -> Int in
    return value1/value2;
}
print("闭包的使用第一个=\(divide(200,100))");



/*
 8.闭包表达式
   闭包表达式是一种利用简介语法构建内联闭包的方式。闭包表达式提供了一些语法优化，是的写闭包更加简洁
   sorted排序
 */
let names = ["AT", "AE", "D", "S", "BE"]

// 使用普通函数(或内嵌函数)提供排序功能,闭包函数类型需为(String, String) -> Bool。
func backwards(s1: String, s2: String) -> Bool {
    return s1 < s2
}
var reversed = names.sorted(by: backwards)

print(reversed);


/*
 9.参数名称缩写
 */
var reversed2 = names.sorted(by:{$0 > $1});
print("使用参数名称缩写排序=\(reversed2)");



/*
 10.运算符函数
 */
var reversed3 = names.sorted(by: < );
print("运算符函数=\(reversed3)");



/**
 11.尾随闭包
    尾随闭包是一个书写在函数括号之后的闭包表达式，函数支持将其作为最后一个参数调用
 */
var reversed4 = names.sorted(){
    $0 < $1
}
print("尾随闭包=\(reversed4)");



/*
 12.捕获值
     闭包可以在其定义的上下文中捕获常量和变量
    即使定义这些常量和变量的原域不存在，闭包仍然可以在闭包函数体内引用和修改这些值
 */

func makeIncrementor(forIncrement amount:Int) -> () -> Int {
    var runningTotal = 0;
    func incrementor() -> Int {
        runningTotal += amount;
        return runningTotal;
    }
    // 调用函数体内的函数
    return incrementor;
}
// 返回的是一个函数
let valueOut = makeIncrementor(forIncrement: 10);
print("捕获值为=\(valueOut())");





/*
 13.枚举
 */
// 定义枚举
enum DaysofaWeek {
    case Sunday
    case Monday
    case TUESDAY
    case WEDNESDAY
    case THURSDAY
    case FRIDAY
    case Saturday
}

var weekDay = DaysofaWeek.THURSDAY
weekDay = .THURSDAY
switch weekDay
{
case .Sunday:
    print("星期天")
case .Monday:
    print("星期一")
case .TUESDAY:
    print("星期二")
case .WEDNESDAY:
    print("星期三")
case .THURSDAY:
    print("星期四")
case .FRIDAY:
    print("星期五")
case .Saturday:
    print("星期六")
}



/*
 14.相关值
 */

enum Student {
    case Name(String);
    case Mark(Int,Int,Int);
}

var stuName = Student.Name("石峰");
var stuMarks = Student.Mark(150, 130, 140);
switch stuMarks
{
case Student.Name(let stuName1):
    print("学生的名字是=\(stuName1)");
case Student.Mark(let mark1,let mark2, let mark3):
    print("学生的成绩是=\(mark1),\(mark2),\(mark3)");
}



/*
 15.原始值
    原始值可以是字符串，字符，或者任何整型或者浮点型值。每个原始值在他的枚举声明中都是必须是唯一的
    在原始值为整数的枚举时，不需要显式的为每一个成员赋值，swift会自动为你赋值
 */
enum Month:Int {
    case January = 3,February,July
}
print("数字月份为=\(Month.July.rawValue)");




/*
 16.结构体：
    我们可以为结构体定义属性（常量、变量）和添加方法，从而扩展结构体的功能
    结构体的值总是通过被复制的方式在代码中传递，因此它的值是不可修改的
 */

struct studentMarks {
    var mark1 = 100;
    var mark2 = 200;
    var mark3 = 300
}
let marks = studentMarks();
print("mark1=\(marks.mark1)");



/*
 17.结构体创建
 */
struct studentHeights {
    var height1:Int;
    var height2:Int;
    var height3:Int;
    
    
    init(height1:Int, height2:Int, height3:Int) {
        self.height1 = height1;
        self.height2 = height2;
        self.height3 = height3;
    }
}
// 初始化学生身高
var heights = studentHeights(height1: 29,height2: 39,height3: 48);

print("学生身高分别是=\(heights.height1),\(heights.height2),\(heights.height3)");








