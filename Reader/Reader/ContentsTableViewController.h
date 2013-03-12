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
#import "SettingTableViewController.h"
//#import "TTTAttributedLabel.h"
static NSString *guid = @"b7738f8c-3932-11e2-a9b7-907ab51b66ae";
static NSString *exitString = @"";//防止复用

@interface ContentsTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
{
    ReadViewController *ReadView;
    WizAccountManager *myAccountMana;
    WizSyncCenter *listSyn;
    WizGroup *myGroup;
    sqlite3 *indexDb;
    NSMutableArray *titleArray;
    SettingTableViewController *setTableView;
//    int synDocNum;
     WizAbstract *abstract;
    }
@property(nonatomic,strong)ReadViewController *ReadView;
@property(nonatomic,strong)WizAccountManager *myAccountMana;
@property(nonatomic,strong)WizSyncCenter *listSyn;
@property(nonatomic,strong)WizGroup *myGroup;
@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,strong)NSString *docGuid;
@property(nonatomic,strong)SettingTableViewController *setTableView;
@property(nonatomic,strong)WizAbstract *abstract;
//@property(nonatomic,assign)int synDocNum;
 
 
 -(void)getTitles:(NSMutableArray*)titles;


 @end
