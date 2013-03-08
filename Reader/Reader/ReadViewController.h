//
//  ReadViewController.h
//  Reader
//
//  Created by wiz on 13-2-20.
//  Copyright (c) 2013年 wiz. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *userId = @"demo@phone.com";
static NSString *passWord = @"123456";
  @interface ReadViewController : UIViewController<UIWebViewDelegate,UIGestureRecognizerDelegate>
{
    IBOutlet UIWebView *web;
    UIView *loadingView;
    WizDocument *myDoc;
    WizAbstract *tableAbstract;
    UIActivityIndicatorView *activityIndicator;
    NSURLRequest *request;
    UIToolbar *toolBar;
  }
@property(nonatomic,strong)UIWebView *web;
@property(nonatomic,strong)WizDocument *myDoc;
@property(nonatomic,strong)WizAbstract *tableAbstract;
@property(nonatomic,strong)UIActivityIndicatorView * activityIndicator;
   //@property(nonatomic,strong)UIView *loadView;
   @end
