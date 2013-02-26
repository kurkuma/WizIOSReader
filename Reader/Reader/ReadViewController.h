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
  @interface ReadViewController : UIViewController<UIWebViewDelegate>
{
    IBOutlet UIWebView *web;
    WizDocument *myDoc;
  }
@property(nonatomic,strong)UIWebView *web;
@property(nonatomic,strong)WizDocument *myDoc;
   @end
