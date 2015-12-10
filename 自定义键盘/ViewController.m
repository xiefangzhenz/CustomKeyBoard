//
//  ViewController.m
//  自定义键盘
//
//  Created by 谢方振 on 15/12/9.
//  Copyright © 2015年 谢方振. All rights reserved.
//

#import "ViewController.h"
#import "XFZCustomKeyBoard.h"
@interface ViewController ()<XFZCustomKeyBoardDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //第一种自定义键盘的方法
    [[XFZCustomKeyBoard customKeyBoard]textViewShowView:self delegate:self];
    
    //第二种自定义键盘的方法
    //[self createUI];
    
}
- (void)createUI{


    // 新建一个UITextField，位置及背景颜色随意写的。
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 64, WIDTH_SCREEN-100, 50)];
    textField.backgroundColor = [UIColor grayColor];
    [self.view addSubview:textField];
    
    // 自定义的view
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
    customView.backgroundColor = [UIColor lightGrayColor];
    textField.inputAccessoryView = customView;
    
    // 往自定义view中添加各种UI控件(以UIButton为例)
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 5, 60, 20)];
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:btn];


}
- (void)sendButtonClick:(XFZCustomKeyBoard*)keyBoard{

    NSLog(@"%@",keyBoard.contentTextView.text);
    
    keyBoard.contentTextView.text = @"";
    
    [keyBoard textDidChanged:nil];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
