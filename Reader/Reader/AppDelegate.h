//
//  AppDelegate.h
//  Reader
//
//  Created by wiz on 13-2-20.
//  Copyright (c) 2013年 wiz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentsTableViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate>
{
    ContentsTableViewController * ConTable;
    UINavigationController *ContentsNavi;
    UIWindow * _window;
  //  UITabBarController *tabBarController;
    


}
@property (strong, nonatomic) UIWindow *window;
//@property(strong,nonatomic) ContentsTableViewController * ConTable;
@end
