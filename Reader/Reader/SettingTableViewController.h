//
//  SettingTableViewController.h
//  Reader
//
//  Created by wiz on 13-2-20.
//  Copyright (c) 2013年 wiz. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class  ContentsTableViewController;
  int synDocNum ;
  int TotalDocNum;
@interface SettingTableViewController : UITableViewController
{

    BOOL changed;//用于表示更新设置是否改变
}
@property(nonatomic,assign)BOOL changed;
//@property(nonatomic,strong)ContentsTableViewController *contTableView;

@end
