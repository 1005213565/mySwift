//
//  main.swift
//  swift_4
//
//  Created by fly on 2017/5/12.
//  Copyright © 2017年 石峰. All rights reserved.
//

import Foundation

/**
 1.定义了一个类
 */
class student:NSObject {
    
    var name:String = ""
    var mark1:Int = 0
    var mark2:Int = 0
    
    init(name:String, mark1:Int, mark2:Int) {
        self.name = name;
        self.mark1 = mark1;
        self.mark2 = mark2;
    }
}





/*
 2.使用该类
 */
let student1 = student(name: "张三",mark1: 49,mark2:89);
print(student1.name,student1.mark1);



/*
 3.判断两个对象是否相等
 */
// 恒等(对象和对象使用恒等)
// 作为类是引用类型，有可能有多个常量和变量在后台同时引用某一个类实例
let student2 = student(name: "张三",mark1: 49,mark2:89);
if student1 == student2 {
    print("student1 === student2")
}else {
    print("student1 !== studnet2");
}



/*
 4.延时储存属性：（不懂）
   延迟存储属性是指当第一次被调用的时候才会计算其初始值的属性
   在属性声明前使用lazy来标示一个延迟存储属性
   一般应用于：
   延迟对象的创建
   当属性的值依赖于其他未知类
 */




/*
 5.属性观察器：
   每次属性被设置值的时候都会调用属性观察器。（类似于kvo）
   可以为除了延迟存储器之外的其他存储属性添加属性观察器，也可以通过重载属性的方法为继承的属性添加属性观察器（包括计算属性，和存储属性）
  
   可以为属性添加如下的一个或全部观察器
   1.willSet在设置新的值之前调用
   2.didSet在新的值被设置之后立即调用
   3.willSet和didSet观察器在属性初始化过程中不会被调用
 */
class Test1 {
    var counter:Int = 0{
        willSet(newTotal){
            print("计数器：\(newTotal)");
        }
        didSet{
            if counter > oldValue {
                print("新增数\(counter - oldValue)");
            }
        }
    }
    
}

let NewCounter = Test1();
NewCounter.counter = 12;
NewCounter.counter = 39;






/*
 6.在实例方法中修改值类型
   修改结构体和枚举的值，在实例方法中。你可以选择变异(mutating)这个方法，然后方法就从内部改变他的属性
   ；并且它做的改变在方法结束时，还会保留在原始结构中
 */
struct area {
    var length = 1
    var breadth = 1
    
    func area() -> Int {
        return length * breadth
    }
    
    mutating func scaleBy(res: Int) {
        length *= res
        breadth *= res
        
        print(length)
        print(breadth)
    }
}

var val = area(length: 3, breadth: 5)
val.scaleBy(res: 3)
val.scaleBy(res: 30)
val.scaleBy(res: 300)




/*
 7.类型方法：
   实例方法是被类型的某个实例调用的方法，你可以定义类型本身调用的方法，这种方法叫做类型方法。
   声明结构体和枚举的类型方法，在方法的func关键字之前加上关机字static
 */
class Math
{
    class func abs(number: Int) -> Int
    {
        if number < 0
        {
            return (-number)
        }
        else
        {
            return number
        }
    }
}

struct absno
{
    static func abs(number: Int) -> Int
    {
        if number < 0
        {
            return (-number)
        }
        else
        {
            return number
        }
    }
}

let no = Math.abs(number: -35)
let num = absno.abs(number: -5)

print(no)
print(num)










































