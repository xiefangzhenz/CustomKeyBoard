//
//  XFZCustomKeyBoard.h
//  自定义键盘
//
//  Created by 谢方振 on 15/12/9.
//  Copyright © 2015年 谢方振. All rights reserved.
//
//屏幕宽度
#define WIDTH_SCREEN [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define HEIGHT_SCREEN [UIScreen mainScreen].bounds.size.height
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class XFZCustomKeyBoard;
@protocol XFZCustomKeyBoardDelegate<NSObject>

- (void)sendButtonClick:(XFZCustomKeyBoard*)keyBoard;

@end

@interface XFZCustomKeyBoard : NSObject
//键盘上的View
@property(nonatomic,strong)UIView* backView;
//
@property(nonatomic,strong)UIViewController* backViewController;
//
@property(nonatomic,strong)UITextView* contentTextView;
//
@property(nonatomic,strong)UIButton* sendButton;
//
@property(nonatomic,strong)UIView* shadowView;
//
@property(nonatomic,assign)CGFloat earyContentHeight;
//
@property(nonatomic,weak)id<XFZCustomKeyBoardDelegate> delegate;
+ (XFZCustomKeyBoard*)customKeyBoard;
- (void)textViewShowView:(UIViewController*)viewController delegate:(id)delegate;
- (void)textDidChanged:(NSNotification*)info;
@end
