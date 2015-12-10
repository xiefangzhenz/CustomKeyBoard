//
//  XFZCustomKeyBoard.m
//  自定义键盘
//
//  Created by 谢方振 on 15/12/9.
//  Copyright © 2015年 谢方振. All rights reserved.
//

#import "XFZCustomKeyBoard.h"
static XFZCustomKeyBoard* customKeyBoard = nil;
@implementation XFZCustomKeyBoard
+ (XFZCustomKeyBoard*)customKeyBoard{

    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
       
        customKeyBoard = [[self alloc]init];
    });


    return customKeyBoard;

}
- (void)textViewShowView:(UIViewController*)viewController delegate:(id)delegate{
    
    self.backViewController = viewController;
    self.delegate = delegate;

    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT_SCREEN-50, WIDTH_SCREEN, 50)];
    
    self.backView.backgroundColor = [UIColor grayColor];
    
    [self.backViewController.view addSubview:self.backView];
    
    self.contentTextView = [[UITextView alloc]initWithFrame:CGRectMake(5, 5, self.backView.frame.size.width-80, self.backView.frame.size.height-10)];
    
    self.contentTextView.font = [UIFont systemFontOfSize:20];
    
    [self.backView addSubview:self.contentTextView];
    
    self.sendButton = [[UIButton alloc]initWithFrame:CGRectMake(self.contentTextView.frame.origin.x+self.contentTextView.frame.size.width+10, 5, 40, 40)];
    [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
    
    [self.sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.sendButton addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backView addSubview:self.sendButton];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChanged:) name:UITextViewTextDidChangeNotification object:nil];
    
    


}
#pragma mark - 通知
- (void)keyboardWillShow:(NSNotification*)info{

    CGRect keyboardFrame = [[[info userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    
    if (!self.shadowView) {

        self.shadowView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        self.shadowView.backgroundColor = [UIColor blackColor];
        
        self.shadowView.alpha = 0.0f;
        
        [self.backViewController.view addSubview:self.shadowView];
        
        
        UIButton* button = [[UIButton alloc]initWithFrame:self.shadowView.frame];
        
        [button addTarget:self action:@selector(shadowAction:) forControlEvents:UIControlEventTouchUpInside];
        
        button.backgroundColor = [UIColor clearColor];
        
        [self.shadowView addSubview:button];
    }
    
    [UIView animateWithDuration:.35 animations:^{
        
        self.backView.frame = CGRectMake(0, HEIGHT_SCREEN-keyboardFrame.size.height-self.backView.frame.size.height, WIDTH_SCREEN, self.backView.frame.size.height);
        
        self.shadowView.alpha = 0.4f;
        
        [self.backViewController.view bringSubviewToFront:self.backView];
        
    }];

}
- (void)keyboardWillHidden:(NSNotification*)info{

    [UIView animateWithDuration:.35 animations:^{
        
        self.backView.frame = CGRectMake(0, HEIGHT_SCREEN-self.backView.frame.size.height, WIDTH_SCREEN, self.backView.frame.size.height);
        
        self.shadowView.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        
        [self.shadowView removeFromSuperview];
        
        self.shadowView = nil;

        
    }];

}
- (void)textDidChanged:(NSNotification*)info{
    
    CGSize contSize = self.contentTextView.contentSize;
    
    if (self.earyContentHeight == 0) {
        
        self.earyContentHeight = contSize.height;
    }

    if (contSize.height == self.earyContentHeight) {
        
        return;
    }

    
    CGRect textViewFrame = self.backView.frame;
    
    textViewFrame.origin.y = textViewFrame.origin.y-(contSize.height-self.earyContentHeight);
    
    textViewFrame.size.height = textViewFrame.size.height+(contSize.height-self.earyContentHeight);
    
    self.backView.frame = textViewFrame;
    
    self.contentTextView.frame = CGRectMake(self.contentTextView.frame.origin.x, self.contentTextView.frame.origin.y, self.contentTextView.frame.size.width, self.backView.frame.size.height-10);
    
    self.sendButton.frame = CGRectMake(self.sendButton.frame.origin.x, self.contentTextView.center.y-self.sendButton.frame.size.height/2, self.sendButton.frame.size.width, self.sendButton.frame.size.height);
                                                     
    self.earyContentHeight = contSize.height;
    
    


}
#pragma mark - ButtonAction
- (void)sendAction:(UIButton*)sender{

    [self.delegate sendButtonClick:self];
    

}

- (void)shadowAction:(UIButton*)sender{

    [self.contentTextView resignFirstResponder];

}

-(void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];


}
@end
