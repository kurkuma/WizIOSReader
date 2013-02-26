//
//  ContentsTableViewController.m
//  Reader
//
//  Created by wiz on 13-2-20.
//  Copyright (c) 2013年 wiz. All rights reserved.
//

#import "ContentsTableViewController.h"
#import "Cell.h"
#import "SettingTableViewController.h"
#import "WizNotificationCenter.h"
#import "WizFileManager.h"
#import "WizGlobalCache.h"
@interface ContentsTableViewController ()<WizSyncKbDelegate, WizGenerateAbstractDelegate>

@end

@implementation ContentsTableViewController
@synthesize ReadView;
@synthesize myAccountMana;
@synthesize titleArray;
@synthesize docGuid;
@synthesize user,password;
 - (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [[WizNotificationCenter shareCenter] addSyncKbObserver:self];
    }
    return self;
}
- (void) didGenerateAbstract:(NSString *)guid
{
    
}
- (void)viewDidLoad
{
    NSLog(@"*********");
    [super viewDidLoad];
    
    self.title = @"我知科技";
    NSLog(@"title:%@",self.title);
    
    UIBarButtonItem *settingButton = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(settings)];
    
    self.navigationItem.rightBarButtonItem = settingButton;
 
     self.user =userId;
    self.password = passWord;
    
    //注意下面都是单例模式
    //连接到指定账户

     [[WizAccountManager defaultManager]updateAccount:self.user password:self.password personalKbguid:guid];
    
    listSyn = [WizSyncCenter shareCenter];
    
    //测试语句，查看能否查找到账户。
    
    NSLog(@"第一步 账户存在测试");
    
    if ([[WizAccountManager defaultManager] canFindAccount:userId]) {
       
        NSLog(@"canFindAccount");
    }
    
    else
        
        NSLog(@"sorry,cant find your Account");
    
    //账户同步，同步完成可通过查看沙盒路径内容完成；isGroup表示是否同步账户所在的群组数据
    
    [listSyn syncAccount:userId password:passWord isGroup:YES isUploadOnly:NO];
    
    //获取数据库连接
    id<WizInfoDatabaseDelegate>dataDelegate = [WizDBManager getMetaDataBaseForKbguid:guid accountUserId:userId];
    titleArray = [dataDelegate recentDocuments];
    NSLog(@"count&&%d :",[titleArray count]);
    
     // Uncomment the following line to preserve selection between presentations.
     // self.clearsSelectionOnViewWillAppear = NO;
 
     // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewWillAppear:(BOOL)animated
{
    
    animated = YES;
    self.navigationItem.title = @"我知科技";

}// Called when the view is about to made visible. Default does nothing

-(IBAction)settings
{
    SettingTableViewController * setTable = [[SettingTableViewController alloc]init];
    self.navigationItem.title = @"返回";
    [self.navigationController pushViewController:setTable animated:YES];
  
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [titleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
     WizDocument * tempDocument = [titleArray objectAtIndex:indexPath.row];
     if (indexPath.row == 1) {
         NSLog(@"%@",tempDocument.dateModified);
    }
    cell.textLabel.text =  tempDocument.title;
    cell.modiDate = tempDocument.dateModified;
    
   
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReadViewController *tempReadView = [[ReadViewController alloc]init];
    tempReadView.myDoc = [titleArray objectAtIndex:indexPath.row];
      self.navigationItem.title = @"返回";
//     WizSyncCenter *syn = [[WizSyncCenter alloc]init];
//     WizDocument *doc = [[WizDocument alloc]init];
//     doc = [titleArray objectAtIndex:indexPath.row];

    
    
     
    WizDocument *doc = [[WizDocument alloc]init];
    
    doc = [titleArray objectAtIndex:indexPath.row];
    
        
    //摘要，然后是delegate，需要下载下来之后才有。
    
   // WizAbstract* abstract = [[WizGlobalCache shareInstance] abstractForDoc:doc.guid accountUserId:userId];
   // if (abstract) {
        
    //}

         
    //顺序要弄对，先push再URL。
    [self.navigationController pushViewController:tempReadView animated:YES];
   
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = /Users/Guest/Library/Containers/com.tencent.qq/Data/Library/Application Support/QQ/1042683690/Image/230G[%YT~6TL9JEX6C]M4HN.jpg[[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
 
@end
 

