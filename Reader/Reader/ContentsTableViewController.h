//
//  ContentsTableViewController.h
//  Reader
//
//  Created by wiz on 13-2-20.
//  Copyright (c) 2013年 wiz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadViewController.h"
#import "WizAccountManager.h"
#import "WizSyncCenter.h"
#import "sqlite3.h"
#import "WizDBManager.h"
static NSString *guid = @"59f91414-67c0-11e2-a9b7-907ab51b66ae";
@interface ContentsTableViewController : UITableViewController
{
    ReadViewController *ReadView;
    WizAccountManager *myAccountMana;
    WizSyncCenter *listSyn;
    WizGroup *myGroup;
    sqlite3 *indexDb;
    NSArray *titleArray;
    NSString *docGuid;
    NSString *user;
    NSString *password;
   // id<WizInfoDatabaseDelegate> dataDeletate;
}
@property(nonatomic,strong)ReadViewController *ReadView;
@property(nonatomic,strong)WizAccountManager *myAccountMana;
@property(nonatomic,strong)WizSyncCenter *listSyn;
@property(nonatomic,strong)WizGroup *myGroup;
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)NSString *docGuid;
@property(nonatomic,strong)NSString *user;
@property(nonatomic,strong)NSString *password;
 -(void)getTitles:(NSMutableArray*)titles;


 @end
