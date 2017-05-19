//
//  main.swift
//  swift_6
//
//  Created by fly on 2017/5/16.
//  Copyright © 2017年 石峰. All rights reserved.
//

import Foundation
// 继承
/*
 1.基类
 */
class StudDetails {
    var stname:String!;
    var mark1:Int!;
    var mark2:Int!;
    var mark3:Int!;
    
    init(stname: String, mark1:Int, mark2:Int, mark3:Int) {
        self.stname = stname
        self.mark1 = mark1
        self.mark2 = mark2
        self.mark3 = mark3
    }
}

let stname = "swift"
let mark1 = 98;
let mark2 = 89;
let mark3 = 76;

let sds = StudDetails(stname:stname, mark1:mark1, mark2:mark2, mark3:mark3);

print(sds.stname)
print(sds.mark1)
print(sds.mark2)
print(sds.mark3)




/*
 2.子类
 */
class Tome: StudDetails {
    init() {
        super.init(stname: "张三", mark1: 39, mark2: 49, mark3: 89);
    }
}
let tom = Tome();
print(tom.stname);



/*
 3.重写：
   子类可以通过继承来的实例方法，类方法，实例属性，或下标脚本来实现自己的定制功能，我们把这种行为叫重写
   我们可以使用override关键字来实现重写
 */
class SuperClass {
    func show() {
        print("这是超类 superClass");
    }
}

class SubClass: SuperClass {
    override func show() {
        print("这是子类，SubClas");
    }
}

let superClass = SuperClass()
superClass.show()

let subClass = SubClass()
subClass.show()




/*
 4.重写属性
 */
class Circle {
    var radius = 12.5;
    var area:String {
        return "矩形半径\(radius)";
    }
}

// 继承超类 Circle
class Rectangle:Circle {
    var print = 7;
    override var area: String {
        return super.area + ",但是现在被重写为\(print)";
    }
    
}
let rect = Rectangle()
rect.radius = 25.0
rect.print = 3
print("Radius \(rect.area)")




/*
 5.重写属性观察器
   你可以在属性重写中为一个继承来的属性添加属性观察器，这样一来，当继承来的属性值发生变化时，你就会检测到
   注意：你不可以为继承来的常量存储型属性或继承来的只读计算型属性添加属性观察器
 */


class Square : Rectangle {
    override var radius: Double {
        didSet {
            print = Int(radius/5.0) + 1
        }
    }
}

let sq = Square()
sq.radius = 100.0
print("半径: \(sq.area)")




/*
 6.防止重写
   我们可以使用final关键字防止它们被重写
   如果你重写了final方法，属性或下标脚本，在编译时会报错
 */
// final标记了，及时此类不能被重写，继承
final class Circle1 {
    final var radius = 12.5;
    var area: String {
        return "矩形半径为 \(radius) "
    }
}
//class Rectangle1: Circle1 {
//    var mineValue = 7;

    
//    var print = 7
//    override var area: String {
//        return super.area + " ，但现在被重写为 \(print)"
//    }
//}





/*
 7.swift构造过程
   构造过程是为了使用某个类、结构体或者枚举类型的实例而进行的准备过程。这个过程包含了为实例中的每个属性设置初始值和为其执行必要的准备和初始任务
   与OC中的构造不同，Swift的构造无需返回值，它们的主要任务是保证新实例在第一次使用前完成正确的初始化
 
 
   存储型属性的初始赋值：
   类和结构体在实例创建时，必须为所有存储型属性设置合适的初始值
   存储属性在构造中赋值时，他们的值是被直接设置的，不会触发任何属性观察器。
 */



/*
 8.构造器
 */
struct School1 {
    var length:Double;
    var breath:Double;
    init() {
        length = 6;
        breath = 14;
    }
}

var school1 = School1();
print("School1的length=\(school1.length)\nbreak=\(school1.breath)");



/*
 9.默认属性值
   我们可以在构造器中位存储型属性设置初始值；同样，也可以在属性声明时为其设置默认值。
 */
struct School2 {
    // 设置默认值
    var length = 6
    var breadth = 12
}
var school2 = School2();
print("School2的length=\(school2.length)\nbreak=\(school2.breadth)");


/*
 10.构造参数
 */



/*
 11.内部参数和外部参数名
    跟函数和方法参数相同，构造参数也存在一个在构造器内部使用的参数名字和一个在调用构造器时使用的外部参数名字。
    然而，构造器并不想函数和方法那样在括号前有一个可辨别的名字。所以在调用构造器时，主要通过构造器中的参数名和类型来确定调用的构造器
    如果你在定义构造器时没有提供参数的外部名字，Swift会为每个构造器的参数自动生成一个跟内部名字相同的外部名字
 */
struct Color  {
    let red, green, blue:Double;
    init(red:Double, green:Double, blue:Double) {
        self.red = red;
        self.green = green;
        self.blue = blue;
    }
    init(white:Double) {
        red = white;
        green = white;
        blue = white;
    }
}

// 创建一个新的Color实例，通过三种颜色的外部参数名来传值，并调用构造器
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)

print("red 值为: \(magenta.red)")
print("green 值为: \(magenta.green)")
print("blue 值为: \(magenta.blue)")

// 创建一个新的Color实例，通过三种颜色的外部参数名来传值，并调用构造器
let halfGray = Color(white: 0.5)
print("red 值为: \(halfGray.red)")
print("green 值为: \(halfGray.green)")
print("blue 值为: \(halfGray.blue)")




/*
 12.没有外部名称参数
    如果你不希望为构造器的某个参数提供外部名字，你可以使用下划线_来显示描述它的外部名
 */
struct School3 {
    var length:Double;
    
    init(fromBreadth breadth:Double) {
        length = breadth * 10;
    }
    
    init(fromBre bre:Double) {
        length = bre * 30;
    }
    
    // 不提供外部参数名
    init(_ area:Double) {
        length = area;
    }
}

// 调用不提供外部的名字
let school3 = School3(20.0);
print("school3的length=\(school3.length)");




/*
 13.可选属性类型
    如果你定制的类型包括一个逻辑上允许取值为空的存储属性，你都需要将它定义为可选类型
 */

struct School4 {
    var length:Double?;
    
    init(fromBreadth breadth:Double) {
        length = breadth * 10;
    }
    
    init(fromBre bre:Double) {
        length = bre * 30;
    }
    
    // 不提供外部参数名
    init(_ area:Double) {
        length = area;
    }
}



/*
 14.构造过程中修改常量属性
    只要在构造过程结束前常量的值能够确定，你可以在构造过程中的任意时间点修改常量属性的值
 */



/*
 15.值类型的构造器代理
    构造器可以通过调用其他构造器来完成实例的部分构造过程，这个过程称为构造器代理，它能减少多个构造器间的代码重复
 */

struct Size  {
    var width = 0.0, height = 0.0;
}

struct Point {
    var x = 0.0, y = 0.0;
}

struct Rect {
    var origin = Point();
    var size = Size();
    
    init() {};
    init(origin:Point, size:Size) {
        self.origin = origin;
        self.size = size;
    }
    init(center:Point, size:Size) {
        let originX = center.x - (size.width / 2);
        let originY = center.y - (size.height / 2);
        
        self.init(origin: Point(x: originX, y: originY), size: size);
    }
}

// origin和size属性都使用定义时默认值Point(x: 0.0, y: 0.0)和Size(width: 0.0, height: 0.0)
let baseRect = Rect();
print("Size 结构体初始值：\(baseRect.size.width,baseRect.size.height)");
print("Rect 结构体初始值: \(baseRect.origin.x, baseRect.origin.y)");


// 将origin和size的参数值赋值给对应的存储型属性
let originRect = Rect(origin: Point(x: 2.0, y: 2.0),
                      size: Size(width: 5.0, height: 5.0));
print("Size 结构体初始值: \(originRect.size.width, originRect.size.height) ")
print("Rect 结构体初始值: \(originRect.origin.x, originRect.origin.y) ")


// 先通过center和size的值计算出origin的坐标
// 然后再调用（或代理给）init
let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                      size: Size(width: 3.0, height: 3.0))
print("Size 结构体初始值: \(centerRect.size.width, centerRect.size.height) ")
print("Rect 结构体初始值: \(centerRect.origin.x, centerRect.origin.y) ")




/*
 16.构造器代理规则
    值类型：
       不支持继承，所以构造代理的过程相对简单，因为他们只能代理给本身提供的其他构造器。你可以使用self.init在自定义的构造器中引用其他的属于相同值类型的构造器
    类类型：
       它可以继承自其他类，这意味着类有责任保证其所有继承的存储属性在构造时也能正确的初始化
 */























