//
//  HKVCAndKVOVC.m
//  YYKitDemo
//
//  Created by HY on 2016/11/25.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import "HKVCAndKVOVC.h"

@implementation HPerson
//用KVC时传入的Key必须保证类中存在同名的属性。否则会运行时崩溃。那么如果我不希望运行时直接崩溃，而是来一个相对友好的提示，不要让它崩溃，该怎么办呢？
//需要在HMPerson类里重写setValue:值 forUndefinedKey:键方法
//valueForKeyPath:返回跟接收者相关的键路径的值，对于子系列中任何不遵循KVC的对象，都会收到一个valueForUndefineKey:消息。
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"输入的key:%@不存在",key);
}
@end

@interface HKVCAndKVOVC ()

@end

@implementation HKVCAndKVOVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self kvcTest];
    [self kvoTest];
}

//KVC可以用来访问对象的属性、一对一的关系对象、一对多的关系对象
//
//访问对象属性：也可以是对象的成员变量，成员变量是私有的也可以访问，属性可以是对象，也可以是数值类型和结构体，非对象类型的参数和返回值会自动封装成NSValue活着NSNumber类型。
//valueForKey:会返回跟接收者相关的key的值，如果对于指定的key没有访问器或者实例变量，则给自己发送一个valueForUndefineKey:消息，这个方法的默认实现是抛出一个NSUndefinedKeyException
//通过关系访问对象：假设对象person有属性address，属性address有属性city，我们可以通过person来访问city:
//
//[person valueForKeyPath:@"address.city"];
- (void)kvcTest{
    HPerson *person = [HPerson new];
    
    [person setValue:@"HY" forKey:@"hName"];
    [person setValue:@18 forKey:@"hAge"];
    
    NSString *name = [person valueForKey:@"hName"];
    NSUInteger age = [[person valueForKey:@"hAge"] integerValue];
    NSLog(@"name = %@,age = %lu",name,age);
    NSDictionary *dic = @{@"name":@"HY",@"age":@18,@"height":@175,@"weight":@50};
    //赋值方式1
    //用kvc将字典转为model
    //    for (id key in dic) {
    //        [person setValue:dic[key] forKey:key];
    //    }
    //赋值方式2 最简单
    [person setValuesForKeysWithDictionary:dic];
    //    注意：用setValuesForKeysWithDictionary或者自己写循环做字典数据转模型数据时，必须保证实体类的属性跟字典中的key名字一一对应，并且属性可以比字典多，但是绝对不能比字典的元素少！
    //    KVC赋值和取值的一套顺序：
    //
    //    用KVC取值或赋值时，会优先找这个属性对应的getter或setter方法来对这个属性赋值
    //    如果找不到，则会查找带下划线的属性，如果找到则赋值
    //    如果依然找不到，则会查找不带下划线的属性，如果找到则赋值
    //    如果还是找不到，则报错
}

- (void)kvoTest{
    
}
//KVO 简介
//KVO 是一种当对象的指定属性修改时能通知其他对象的机制，是以 KVC 为基础的，所以被观察对象的属性值必须通过 KVC 来改变才能触发通知。KVO 通常用于 model 与 controller 层。
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
