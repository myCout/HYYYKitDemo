//
//  HReactiveCocoaVC.m
//  YYKitDemo
//
//  Created by HY on 2017/2/28.
//  Copyright © 2017年 郝毅. All rights reserved.
//

#import "HReactiveCocoaVC.h"
#import "HRacOneVC.h"
#import "HRacView.h"

@interface HReactiveCocoaVC ()
@property (nonatomic, retain) UIButton *hNextPageBtn;
@property (nonatomic, retain) RACCommand *command;
@end

@implementation HReactiveCocoaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self racDemo];
    
}

- (void)initUI{
    [self.view addSubview:self.hNextPageBtn];
    self.hNextPageBtn.sd_layout.leftSpaceToView(self.view,100)
    .topSpaceToView(self.view,100)
    .widthIs(100)
    .heightIs(34);
//    [self.hNextPageBtn.titleLabel jk_resizeLabelHorizontal];
//    self.hNextPageBtn.width = self.hNextPageBtn.titleLabel.width;
}

- (void)racDemo{
//    RACSiganl:信号类,一般表示将来有数据传递，只要有数据改变，信号内部接收到数据，就会马上发出数据。
//    RACSubscriber:表示订阅者的意思，用于发送信号，这是一个协议，不是一个类，只要遵守这个协议，并且实现方法才能成为订阅者。通过create创建的信号，都有一个订阅者，帮助他发送数据。
//    RACDisposable:用于取消订阅或者清理资源，当信号发送完成或者发送错误的时候，就会自动触发它。
//    RACSubject:RACSubject:信号提供者，自己可以充当信号，又能发送信号。
//    RACReplaySubject:重复提供信号类，RACSubject的子类。RACReplaySubject可以先发送信号，在订阅信号，RACSubject就不可以。
    [self racSenderMessage];
    
//    [self ReactiveCocoa];
//    
//    [self racAddTap];
//    
//    [self racTextField];
//    
//    //    [self racKVO];
//    [self arrayLog];
//    
//    [self subjectDemo];
}

/**
 Rac Btn 用法
 */
- (void)racBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setRac_command:[[RACCommand alloc] initWithEnabled:nil signalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [GCDQueue executeInMainQueue:^{
                //btn事件执行完之后发送完成信号
                [subscriber sendNext:[[NSDate date] description]];
                [subscriber sendCompleted];
                
            } afterDelaySecs:3];
            
            return [RACDisposable disposableWithBlock:^{
                //
            }];
        }];
    }]];
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [btn setBounds:CGRectMake(100, 100, 200, 50)];
    btn.center = self.view.center;
    
    [[[btn rac_command] executionSignals] subscribeNext:^(id x) {
        [x subscribeNext:^(id x) {
            //接收btn执行完发送的信号
            NSLog(@"%@",x);
        }];
    }];
    [self.view addSubview:btn];
}

/**
 用RAC实现
 需求：用户名长度大于3  密码长度大于3 同时满足时button可以点击
 */
- (void)racLoginDemo{
    UITextField *userTextField = [UITextField new];
    UITextField *psdTextField = [UITextField new];
    UIButton *logInBtn = [UIButton new];
    //注册一个合并的信号量
    RACSignal *enableSignal = [[RACSignal combineLatest:@[userTextField.rac_textSignal,psdTextField.rac_textSignal]] map:^id(id value) {
        //value 是一个元祖
        return @([value[0] length] > 0 && [value[1] length] > 6);
    }];
    logInBtn.rac_command = [[RACCommand alloc] initWithEnabled:enableSignal signalBlock:^RACSignal *(id input) {
        return [RACSignal empty];
    }];
    
}

/**
 将slider和textfield 绑定，滑动slider时 textfield实时显示slider的值

 @param slider slider
 @param textField textfield
 */
- (void)blindSlider:(UISlider *)slider textField:(UITextField *)textField{
    RACChannelTerminal *signalSlider = [slider rac_newValueChannelWithNilValue:nil];//当slider滑动时，slider值改变返回对应的 信号
    RACChannelTerminal *signalText = [textField rac_newTextChannel];
    [signalText subscribe:signalText];
    [[signalSlider map:^id(id value) {
        return [NSString stringWithFormat:@"%.2f",[value floatValue]];
    }] subscribe:signalText];
}

#pragma mark - 1. RAC发送消息,并且绑定到控件，最基本的使用。
-(void)racSenderMessage {
    UITextField * _userNameFeild = [[UITextField alloc] initWithFrame:CGRectMake(100,200, 200, 30)];
    //延迟2.0S 发送消息
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"消息"];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"一些处理事件");
        }];
    }] delay:2.0];
    //将_userNameFeild的`text`属性与映射后的信号量的值绑定到一起
    RAC(_userNameFeild , text) = [signal map:^id(id value) {
        if ([value isEqualToString:@"消息"]) {
            return @"成功收到";
        }
        return nil;
    }];
    _userNameFeild.backgroundColor = [UIColor randomColor];
    [self.view addSubview:_userNameFeild];
}

#pragma mark - 2. RAC代理，使用rac_signalForSelector这个方法来获取代理信号.下边是调用alertview的代理方法
-(void)racProtocolMothel {
    RACSignal *protocolSignal = [self rac_signalForSelector:@selector(alertView:clickedButtonAtIndex:) fromProtocol:@protocol(UIAlertViewDelegate)];
    [protocolSignal subscribeNext:^(id x) {
        
    }];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
}

#pragma mark - 3. RAC通知
-(void)racNotification {
    //接受通知并且处理
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"RAC_Notifaciotn" object:nil] subscribeNext:^(id x) {
        //          NSLog(@"notify.content = %@",notify.userInfo[@"content"]);
    }];
    
    //发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RAC_Notifaciotn" object:nil userInfo:@{@"content" : @"i'm a notification"}];
}

#pragma mark - 4. RAC信号拼接 concat是signal1 completed之后 signal2才能执行
-(void)racSignalLink {
    
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@(1)];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@(2)];
        [subscriber sendCompleted];
        
        return nil;
    }];
    
    RACSignal* concatSignal = [RACSignal concat:@[signal1,signal2]];
    [concatSignal subscribeNext:^(id value) {
        NSLog(@"RAC信号拼接------value = %@",value);
    }];
    //或者
    //    [[signal1 concat:signal2] subscribeNext:^(id value) {
    //          NSLog(@"RAC信号拼接------value = %@",value);
    //    }];
    
}

#pragma mark - 5. RAC信号合并
-(void)racSignalMerge {
    
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"AA"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"BB"];
        [subscriber sendCompleted];
        return  nil;
    }];
    //合并操作
    RACSignal* mergeSignal = [RACSignal merge:@[signal1,signal2]];
    [mergeSignal subscribeNext:^(id x) {
        NSLog(@"RAC信号合并------我喜欢： %@",x);
    }];
    //或者
    //    [[signal1 merge:signal2] subscribeNext:^(id x) {
    //         NSLog(@"RAC信号合并------我喜欢： %@",x);
    //    }];
}

#pragma mark - 6. RAC信号组合(取信号量的最后发送的对象)
-(void)racSignalCombine {
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"SS"];
        [subscriber sendNext:@"AA"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"BB"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    //combineLatest 将数组中的信号量发出的最后一个object 组合到一起
    [[RACSignal combineLatest:@[signal1,signal2]] subscribeNext:^(id x) {
        RACTupleUnpack(NSString *signal1_Str, NSString *signal2_Str) = (RACTuple *)x;
        NSLog(@"RAC信号组合------我就是 %@ %@",signal1_Str,signal2_Str);
    }];
    
    //会注意收到 组合方法后还可以跟一个Block  /** + (RACSignal *)combineLatest:(id<NSFastEnumeration>)signals reduce:(id (^)())reduceBlock */
    /*
     reduce这个Block可以对组合后的信号量做处理
     */
    //我们还可以这样使用
    RACSignal * combineSignal =[RACSignal combineLatest:@[signal1,signal2] reduce:^(NSString *signal1_Str, NSString *signal2_Str){
        return [signal1_Str stringByAppendingString:signal2_Str];
    }];
    [combineSignal subscribeNext:^(id x) {
        NSLog(@"RAC信号组合(Reduce处理)------我喜欢 %@ 的",x);
    }];
    
}

#pragma mark - 7. RAC信号组合(取信号量的最开始发送的对象)全部获取才会返回
/*当且仅当signalA和signalB同时都产生了值的时候，一个value才被输出，signalA和signalB只有其中一个有值时会挂起等待另一个的值，所以输出都是一对值（RACTuple）），当signalA和signalB只要一个先completed，RACStream也解散。*/
-(void)racSignalZIP {
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"AA"];
        [subscriber sendNext:@"BB"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"CC"];
        [subscriber sendCompleted];
        
        return nil;
    }];
    
    [[RACSignal zip:@[signal1,signal2]] subscribeNext:^(id x) {
        RACTupleUnpack(NSString *signal1_Str, NSString *signal2_Str) = (RACTuple *)x;
        NSLog(@"RAC信号压缩------我是 %@的 %@的 ",signal1_Str, signal2_Str);
    }];
}

#pragma mark - 8. RAC信号过滤
-(void)racSignalFilter {
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@(19)];
        [subscriber sendNext:@(12)];
        [subscriber sendNext:@(20)];
        [subscriber sendCompleted];
        
        return nil;
    }] filter:^BOOL(id value) {
        NSNumber *numberValue = value;
        if(numberValue.integerValue < 18) {
            //18禁
            NSLog(@"RAC信号过滤------FBI Warning~");
        }
        return numberValue.integerValue > 18;
    }] subscribeNext:^(id x) {
        NSLog(@"RAC信号过滤------年龄：%@",x);
    }];
}

#pragma mark - 9. RAC信号传递（传递数值，前后信号有联系）
-(void)racSignalPass {
    [[[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"老板向我扔过来一个Star"];
        return nil;
    }] flattenMap:^RACStream *(id value) {
        NSLog(@"RAC信号传递flattenMap1------%@",value);
        RACSignal *tmpSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:[NSString stringWithFormat:@"%@----我向老板扔回一块板砖",value]];
            return nil;
        }];
        
        return tmpSignal;
    }] flattenMap:^RACStream *(id value) {
        NSLog(@"RAC信号传递flattenMap2------%@",value);
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:[NSString stringWithFormat:@"%@---我跟老板正面刚~,结果可想而知",value]];
            return nil;
        }];
    }] subscribeNext:^(id x) {
        NSLog(@"RAC信号传递last------%@",x);
    }];
}

#pragma mark - 10. RAC信号传递（不传递数值）
-(void)racSignalQueue {
    //与信号传递类似，不过使用 `then` 表明的是秩序，没有传递value
    [[[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"RAC信号串------我先来");
        [subscriber sendCompleted];
        return nil;
    }] then:^RACSignal *{
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"RAC信号串------我第二");
            [subscriber sendCompleted];
            return nil;
        }];
    }] then:^RACSignal *{
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"RAC信号串------我第三");
            [subscriber sendCompleted];
            return nil;
        }];
    }] subscribeNext:^(id x) {
        NSLog(@"RAC信号串------Over");
    }];
    
}
#pragma mark - 11. RAC_Command介绍
-(void)racCommandDemo {
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"racCommandDemo------");
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    //命令执行
    [command execute:nil];
    
    
}

#pragma mark - ReactiveCocoa开发中常见用法。
- (void)ReactiveCocoa{
//    代替代理:
//    rac_signalForSelector：用于替代代理。
    // 需求：自定义redView,监听红色view中按钮点击
    // 之前都是需要通过代理监听，给红色View添加一个代理属性，点击按钮的时候，通知代理做事情
    // rac_signalForSelector:把调用某个对象的方法的信息转换成信号，就要调用这个方法，就会发送信号。
    // 这里表示只要redV调用btnClick:,就会发出信号，订阅就好了。
    
    HRacView *redV = [[HRacView alloc] initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH-20*2, 300)];
    [[redV rac_signalForSelector:@selector(testClick:)] subscribeNext:^(UIButton * x) {
        NSLog(@"点击红色按钮 %@",x);
    }];
    
    [self.view addSubview:redV];
    
//    代替KVO :
//    rac_valuesAndChangesForKeyPath：用于监听某个对象的属性改变。
    // 把监听redV的center属性改变转换成信号，只要值改变就会发送信号
    // observer:可以传入nil
    [[redV rac_valuesAndChangesForKeyPath:@"centerX" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    // 3.监听事件
    // 把按钮点击事件转换为信号，点击按钮，就会发送信号
    UIButton *btn;
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"按钮被点击了");
    }];
    
//    代替通知:
//    rac_addObserverForName:用于监听某个通知。
    // 把监听到的通知转换信号
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(id x) {
        NSLog(@"键盘弹出");
    }];
    
//    监听文本框文字改变:
//    rac_textSignal:只要文本框发出改变就会发出这个信号。
    UITextField *_textField;
    [_textField.rac_textSignal subscribeNext:^(id x) {
        NSLog(@"文字改变了%@",x);
    }];
//    处理当界面有多次请求时，需要都获取到数据时，才能展示界面
//    rac_liftSelector:withSignalsFromArray:Signals:当传入的Signals(信号数组)，每一个signal都至少sendNext过一次，就会去触发第一个selector参数的方法。
//    使用注意：几个信号，参数一的方法就几个参数，每个参数对应信号发出的数据。
    
    // 6.处理多个请求，都返回结果的时候，统一做处理.
    RACSignal *request1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 发送请求1
        [subscriber sendNext:@"发送请求1"];
        return nil;
    }];
    RACSignal *request2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 发送请求2
        [subscriber sendNext:@"发送请求2"];
        return nil;
    }];
    // 使用注意：几个信号，参数一的方法就几个参数，每个参数对应信号发出的数据。
    [self rac_liftSelector:@selector(updateUIWithR1:r2:) withSignalsFromArray:@[request1,request2]];
}

// 更新UI
- (void)updateUIWithR1:(id)data r2:(id)data1
{
    NSLog(@"更新UI%@  %@",data,data1);
}
#pragma mark - 数组遍历
- (void)arrayLog{
//    RACTuple:元组类,类似NSArray,用来包装值.
//    RACSequence:RAC中的集合类，用于代替NSArray,NSDictionary,可以使用它来快速遍历数组和字典。
    // 1.遍历数组
    // 这里其实是三步
    // 第一步: 把数组转换成集合RACSequence numbers.rac_sequence
    // 第二步: 把集合RACSequence转换RACSignal信号类,numbers.rac_sequence.signal
    // 第三步: 订阅信号，激活信号，会自动把集合中的所有值，遍历出来。
    NSArray *numbers = @[@1,@2,@3,@4];
    [numbers.rac_sequence.signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    // 2.遍历字典,遍历出来的键值对会包装成RACTuple(元组对象)
    NSDictionary *dict = @{@"name":@"xmg",@"age":@18};
    [dict.rac_sequence.signal subscribeNext:^(RACTuple *x) {
        RACTupleUnpack(NSString *key, NSString *value) = x;
        NSLog(@"%@ %@",key,value);
    }];
    
    //3 .字典转模型
    // 3.1 OC写法
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
    NSArray *dictArr = [NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray *items = [NSMutableArray array];
    for (NSDictionary *dict in dictArr) {
//        FlagItem *item = [FlagItem flagWithDict:dict];
//        [items addObject:item];
    }
    
    // 3.2 RAC写法
    NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
    NSArray *dictArr2 = [NSArray arrayWithContentsOfFile:filePath2];
    NSMutableArray *flags = [NSMutableArray array];
//    _flags = flags;
    [dictArr2.rac_sequence.signal subscribeNext:^(id x) {
        // 运用RAC遍历字典，x：字典
//        FlagItem *item = [FlagItem flagWithDict:x];
//        [flags addObject:item];
    }];
    
    // 3.3 RAC高级写法:
    NSString *filePath3 = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
    NSArray *dictArr3 = [NSArray arrayWithContentsOfFile:filePath3];
    // map:映射的意思，目的：把原始值value映射成一个新值
    // array: 把集合转换成数组
    // 底层实现：当信号被订阅，会遍历集合中的原始值，映射成新值，并且保存到新的数组里。
    
    NSArray *flags3 = [[dictArr3.rac_sequence map:^id(id value) {
//        return [FlagItem flagWithDict:value];
        return nil;
    }] array];
}
#pragma mark - ReactiveCocoa常见宏。
- (void)ReactiveCocoaDefine{
//    RAC(TARGET, [KEYPATH, [NIL_VALUE]]):用于给某个对象的某个属性绑定。
//    基本用法
    // 只要文本框文字改变，就会修改label的文字
//    RAC(self.labelView,text) = _textField.rac_textSignal;
    
//    RACObserve(self, name):监听某个对象的某个属性,返回的是信号。
//    基本用法
    [RACObserve(self.view, center) subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
//    @weakify(Obj)和@strongify(Obj),一般两个都是配套使用,解决循环引用问题.
    
//    RACTuplePack：把数据包装成RACTuple（元组类）
//    基本用法
    // 把参数中的数据包装成元组
//    RACTuple *tuple = RACTuplePack(@10,@20);
    
//    RACTupleUnpack：把RACTuple（元组类）解包成对应的数据。
//    基本用法
//    // 把参数中的数据包装成元组
//    RACTuple *tuple = RACTuplePack(@"xmg",@20);
//    // 解包元组，会把元组的值，按顺序给参数里面的变量赋值
//    // name = @"xmg" age = @20
//    RACTupleUnpack(NSString *name,NSNumber *age) = tuple;
}

//RACMulticastConnection简单使用
// RACMulticastConnection使用步骤:
// 1.创建信号 + (RACSignal *)createSignal:(RACDisposable * (^)(id<racsubscriber> subscriber))didSubscribe
// 2.创建连接 RACMulticastConnection *connect = [signal publish];
// 3.订阅信号,注意：订阅的不在是之前的信号，而是连接的信号。 [connect.signal subscribeNext:nextBlock]
// 4.连接 [connect connect]

// RACMulticastConnection底层原理:
// 1.创建connect，connect.sourceSignal -> RACSignal(原始信号)  connect.signal -> RACSubject
// 2.订阅connect.signal，会调用RACSubject的subscribeNext，创建订阅者，而且把订阅者保存起来，不会执行block。
// 3.[connect connect]内部会订阅RACSignal(原始信号)，并且订阅者是RACSubject
// 3.1.订阅原始信号，就会调用原始信号中的didSubscribe
// 3.2 didSubscribe，拿到订阅者调用sendNext，其实是调用RACSubject的sendNext
// 4.RACSubject的sendNext,会遍历RACSubject所有订阅者发送信号。
// 4.1 因为刚刚第二步，都是在订阅RACSubject，因此会拿到第二步所有的订阅者，调用他们的nextBlock

#pragma mark -
// 需求：假设在一个信号中发送请求，每次订阅一次都会发送请求，这样就会导致多次请求。
// 解决：使用RACMulticastConnection就能解决.
- (void)RACMulticastConnection{
    //普通请求信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送请求");
        return nil;
    }];
    //订阅信号
    [signal subscribeNext:^(id x) {
        NSLog(@"接收数据 1");
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"接收数据 2");
    }];
     // 3.运行结果，会执行两遍发送请求，也就是每次订阅都会发送一次请求
    
     // RACMulticastConnection:解决重复请求问题
    
    // 1.创建信号
    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送请求");
        [subscriber sendNext:@1];
        return nil;
    }];
    //2.创建连接
    RACMulticastConnection *rConnect = [signal2 publish];
    // 3.订阅信号，
    // 注意：订阅信号，也不能激活信号，只是保存订阅者到数组，必须通过连接,当调用连接，就会一次性调用所有订阅者的sendNext:
    [rConnect.signal subscribeNext:^(id x) {
        NSLog(@"订阅者一信号");
    }];
    [rConnect.signal subscribeNext:^(id x) {
        NSLog(@"订阅者二信号");
    }];
    [rConnect connect];
}
#pragma mark - RACCommand
//RACCommand:RAC中用于处理事件的类，可以把事件如何处理,事件中的数据如何传递，包装到这个类中，他可以很方便的监控事件的执行过程。
//使用场景:监听按钮点击，网络请求
//RACCommand简单使用

- (void)RACCommand{
    // 一、RACCommand使用步骤:
    // 1.创建命令 initWithSignalBlock:(RACSignal * (^)(id input))signalBlock
    // 2.在signalBlock中，创建RACSignal，并且作为signalBlock的返回值
    // 3.执行命令 - (RACSignal *)execute:(id)input
    
    // 二、RACCommand使用注意:
    // 1.signalBlock必须要返回一个信号，不能传nil.
    // 2.如果不想要传递信号，直接创建空的信号[RACSignal empty];
    // 3.RACCommand中信号如果数据传递完，必须调用[subscriber sendCompleted]，这时命令才会执行完毕，否则永远处于执行中。
    
    // 三、RACCommand设计思想：内部signalBlock为什么要返回一个信号，这个信号有什么用。
    // 1.在RAC开发中，通常会把网络请求封装到RACCommand，直接执行某个RACCommand就能发送请求。
    // 2.当RACCommand内部请求到数据的时候，需要把请求的数据传递给外界，这时候就需要通过signalBlock返回的信号传递了。
    
    // 四、如何拿到RACCommand中返回信号发出的数据。
    // 1.RACCommand有个执行信号源executionSignals，这个是signal of signals(信号的信号),意思是信号发出的数据是信号，
    //   不是普通的类型。
    // 2.订阅executionSignals就能拿到RACCommand中返回的信号，然后订阅signalBlock返回的信号，就能获取发出的值。
    // 五、监听当前命令是否正在执行executing
    // 六、使用场景,监听按钮点击，网络请求
    
    // 1.创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"执行命令");
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"请求数据"];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    // 强引用命令，不要被销毁，否则接收不到数据
    _command = command;
    // 3.执行命令
    [self.command execute:@1];
    // 4.订阅RACCommand中的信号
    [command.executionSignals subscribeNext:^(id x) {
        [x subscribeNext:^(id x) {
            NSLog(@"%@",x);
        }];
    }];
    
    // RAC高级用法
    // switchToLatest:用于signal of signals，获取signal of signals发出的最新信号,也就是可以直接拿到RACCommand中的信号
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    // 5.监听命令是否执行完毕,默认会来一次，可以直接跳过，skip表示跳过第一次信号。
    [[command.executing skip:1] subscribeNext:^(id x) {
        if ([x boolValue] == YES) {
            // 正在执行
            NSLog(@"正在执行");
        }else{
            // 执行完成
            NSLog(@"执行完成");
        }
    }];
}




//RACSubject和RACReplaySubject简单使用:

- (void)subjectDemo{
    // RACSubject使用步骤
    // 1.创建信号 [RACSubject subject]，跟RACSiganl不一样，创建信号时没有block。
    // 2.订阅信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
    // 3.发送信号 sendNext:(id)value
    
    // RACSubject:底层实现和RACSignal不一样。
    // 1.调用subscribeNext订阅信号，只是把订阅者保存起来，并且订阅者的nextBlock已经赋值了。
    // 2.调用sendNext发送信号，遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock。
    // 1.创建信号
    RACSubject *subject = [RACSubject subject];
    // 2.订阅信号
    [subject subscribeNext:^(id x) {
        // block调用时刻：当信号发出新值，就会调用.
        NSLog(@"1 第一个订阅者%@",x);
    }];
    [subject subscribeNext:^(id x) {
        // block调用时刻：当信号发出新值，就会调用.
        NSLog(@"1 第二个订阅者%@",x);
    }];
    // 3.发送信号
    [subject sendNext:@"1"];
    
    // RACReplaySubject使用步骤:
    // 1.创建信号 [RACSubject subject]，跟RACSiganl不一样，创建信号时没有block。
    // 2.可以先订阅信号，也可以先发送信号。
    // 2.1 订阅信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
    // 2.2 发送信号 sendNext:(id)value
    
    // RACReplaySubject:底层实现和RACSubject不一样。
    // 1.调用sendNext发送信号，把值保存起来，然后遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock。
    // 2.调用subscribeNext订阅信号，遍历保存的所有值，一个一个调用订阅者的nextBlock
    
    // 如果想当一个信号被订阅，就重复播放之前所有值，需要先发送信号，在订阅信号。
    // 也就是先保存值，在订阅值。
    
    // 1.创建信号
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    
    // 2.发送信号
    [replaySubject sendNext:@1];
    [replaySubject sendNext:@2];
    
    // 3.订阅信号
    [replaySubject subscribeNext:^(id x) {
        
        NSLog(@"2 第一个订阅者接收到的数据%@",x);
    }];
    
    // 订阅信号
    [replaySubject subscribeNext:^(id x) {
        
        NSLog(@"2 第二个订阅者接收到的数据%@",x);
    }];
}

//创建信号
- (void)creatSignal{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // block调用时刻：每当有订阅者订阅信号，就会调用block。
        // 2.发送信号
        [subscriber sendNext:@1];
        // 如果不在发送数据，最好发送信号完成，内部会自动调用[RACDisposable disposable]取消订阅信号。
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            // block调用时刻：当信号发送完成或者发送错误，就会自动执行这个block,取消订阅信号。
            // 执行完Block后，当前信号就不在被订阅了。
            NSLog(@"信号被销毁");
        }];
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"接收到数据 :%@",x);
    }];
}

#pragma mark - UITextField 用法
- (void)racTextField{
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 40, 200, 40)];
    textField.backgroundColor = [UIColor randomColor];
    [self.view addSubview:textField];
    
//    [[textField rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(UITextField *textField) {
//        NSLog(@"change  %@",textField.text);
//    }];
    // 上下两种方式 等同 参数不同，下面直接打印出 text  上面是 UITextField 对象
    [[textField rac_textSignal] subscribeNext:^(id x) {
        NSLog(@"change  %@",x);
    }];
    //Map 映射
    [[textField.rac_textSignal map:^id(id value) {
        NSLog(@"%@", value);
        return @1;
    }] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    //filter
    [[textField.rac_textSignal filter:^BOOL(NSString *value) {
        return [value length] > 3;//只有长度大于3 才会向后传递信号
    }] subscribeNext:^(id x) {
        NSLog(@"x = %@", x);// 打印传递过来的信号值
    }];
}

#pragma mark - 添加手势

- (void)racAddTap{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
//        NSLog(@"tap  %@",x);
        [self racDelegate];
    }];
    [self.view addGestureRecognizer:tap];
}


#pragma mark - RAC 代理
//用RAC写代理是有局限的，它只能实现返回值为void的代理方法

- (void)racDelegate{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"RAC" message:@"RAC TEST" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"other", nil];
//    [[self rac_signalForSelector:@selector(alertView:clickedButtonAtIndex:) fromProtocol:@protocol(UIAlertViewDelegate)]subscribeNext:^(RACTuple *tuple) {
//        NSLog(@"%@",tuple.first);
//        NSLog(@"%@",tuple.second);
//        NSLog(@"%@",tuple.third);
//    }];
    [[alertView rac_buttonClickedSignal] subscribeNext:^(id x) {
        NSLog(@"index = %@",x);//x就是各个Button的序号了
    }];
    [alertView show];
}

#pragma mark - RAC Notification RAC中的通知不需要remove observer，因为在rac_add方法中他已经写了remove

- (void)hyRacNotification{
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithObjects:@"1", @"2", @"3", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"postData" object:dataArray];
    //监听
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"postData" object:nil]subscribeNext:^(NSNotification *notification) {
        NSLog(@"%@", notification.name);
        NSLog(@"%@", notification.object);
    }];
}

#pragma mark - RAC KVO 
//RAC中得KVO大部分都是宏定义，所以代码异常简洁，简单来说就是RACObserve(TARGET, KEYPATH)这种形式，TARGET是监听目标，KEYPATH是要观察的属性值
- (void)racKVO{
    // 监听UIScrollView滚动
    UIScrollView *scrolView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 200, 400)];
    scrolView.contentSize = CGSizeMake(200, 800);
    scrolView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:scrolView];
    
    [RACObserve(scrolView, contentOffset) subscribeNext:^(id x) {
        NSLog(@"ScrollScrollScrollScroll");
    }];
}


#pragma mark - Get / Set

-(UIButton *)hNextPageBtn{
    if (_hNextPageBtn == nil) {
        _hNextPageBtn = [UIButton new];
        _hNextPageBtn.backgroundColor = [UIColor randomColor];
        [_hNextPageBtn setTitleColor:[UIColor randomColor] forState:UIControlStateNormal];
        [_hNextPageBtn setTitle:@"类似Block传值" forState:UIControlStateNormal];
        [_hNextPageBtn setCornerRadius:_hNextPageBtn.height/2];
        WS(weakSelf)
        [_hNextPageBtn jk_addActionHandler:^(NSInteger tag) {
            HRacOneVC *one = [HRacOneVC new];
            one.delegateSignal = [RACSubject subject];
            [one.delegateSignal subscribeNext:^(id x) {
                NSLog(@"通知通知通知通知通知");
            }];
            [weakSelf.navigationController pushViewController:one animated:YES];
        }];
    }
    return _hNextPageBtn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
