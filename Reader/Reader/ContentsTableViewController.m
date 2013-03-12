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
#import "WizTemporaryDataBaseDelegate.h"
extern int synDocNum ;
extern int TotalDocNum;@class WizAbstract;
@interface ContentsTableViewController ()<WizSyncKbDelegate, WizGenerateAbstractDelegate>

@end

@implementation ContentsTableViewController
@synthesize ReadView;
@synthesize myAccountMana;
@synthesize titleArray;
@synthesize setTableView;
//@synthesize synDocNum;
 @synthesize abstract;
//@synthesize tableAbstract;
//@synthesize docGuid;
//@synthesize user,password;

- (void)dealloc
{
    [[WizNotificationCenter shareCenter] removeDownloadObserver:self];
    [[WizNotificationCenter shareCenter]removeObserver:self];
}
 
   //  docNum = 0;

  // for ( Cell* cell in pageCells) {
     //  if ([doc.guid isEqualToString:guid]) {
          
       
   //  }
   // [self.tableView reloadData];

//}
 


 - (id)initWithStyle:(UITableViewStyle)style
{
    NSLog(@"initwithstyle");
    self = [super initWithStyle:style];
    if (self) {
         //注册监听者模式
        
        [[WizNotificationCenter shareCenter] addSyncKbObserver:self];
        
        //注册摘要的观察者模式，摘要需要在下载ziw文件之后才可以获取
        
        [[WizNotificationCenter shareCenter] addGenerateAbstractObserver:self];

        // Custom initialization
    }
    return self;
}
//观察者模式，数据库下载完后才允许获取数据库连接。

- (void) didSyncKbEnd:(NSString *)kbguid
{
     NSLog(@"didSyncKbEnd");
    
    //获取数据库连接

    id<WizInfoDatabaseDelegate>dataDelegate = [WizDBManager getMetaDataBaseForKbguid:kbguid accountUserId:userId];
    
     
    //按时间排序
    
    titleArray =(NSMutableArray *)[dataDelegate recentDocuments];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"dateCreated" ascending:NO];
    
    [titleArray sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSLog(@"count&&%d :",[titleArray count]);
    TotalDocNum = [titleArray count];
    NSLog(@"%d:::::",TotalDocNum);

    
    [self.tableView reloadData];
}

 
- (void)viewDidLoad
{
    
    NSLog(@"*********");
    [super viewDidLoad];
   // self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    
    synDocNum = 200;
     
    setTableView = [[SettingTableViewController alloc]init];

    
    self.title = @"我知科技";
    NSLog(@"title:%@",self.title);
    
    UIBarButtonItem *settingButton = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(settings)];
    
    self.navigationItem.rightBarButtonItem = settingButton;
    abstract = [[WizAbstract alloc]init];
        
    //注意下面都是单例模式
    //连接到指定账户

     [[WizAccountManager defaultManager]updateAccount:userId password:passWord personalKbguid:guid];
    
    //注册活跃用户，
    [[WizAccountManager defaultManager] registerActiveAccount:userId];
        
    //账户同步，同步完成可通过查看沙盒路径内容完成；isGroup表示是否同步账户所在的群组数据
    
    //获取群组
    WizGroup* group = [[WizAccountManager defaultManager] groupFroKbguid:guid accountUserId:userId ];
    
    [[WizSyncCenter shareCenter]syncKbGuid:guid accountUserId:userId password:passWord isUploadOnly:NO userGroup:group.userGroup];

    NSLog(@"count%d",[titleArray count]);
    
     // Uncomment the following line to preserve selection between presentations.
     // self.clearsSelectionOnViewWillAppear = NO;
 
     // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewWillAppear:(BOOL)animated
{
 
    [super viewWillAppear:YES];
    
    [self.tabBarController.tabBar setHidden: NO];
    self.navigationItem.title = @"我知科技";
    
    //如果设置的更新方式改变则重新加载数据。
    
    if (setTableView.changed ) {
        
        [self.tableView reloadData];
    }
    NSLog(@"viewWillAppear");
   // [self.tableView reloadData];

}// Called when the view is about to made visible. Default does nothing

-(void)settings
{
    self.navigationItem.title = @"返回";
    [self.navigationController pushViewController:setTableView animated:YES];
    //setTableView.contTableView = self;
  
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
    
    if ([titleArray count]<=synDocNum) {
        
        NSLog(@"synDocNum = %d",synDocNum);

        
        return [titleArray count];
    }
    
    else
       // NSLog(@"synDocNum = %d",synDocNum);
       return synDocNum;
//    return 1;
    // return [titleArray count];
 }
- (void) didGenerateAbstract:(NSString *)guid
{
    
     //WizDocument *doc = [titleArray objectAtIndex:docNum];
         WizAbstract *abs = [[WizGlobalCache shareInstance]abstractForDoc:guid accountUserId:userId];
    if (abs) {
        abstract = abs; 
    }
    
  }
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
  //  NSString *_text = [_objects objectAtIndex:indexPath.row];
    WizDocument * tempDocument = [titleArray objectAtIndex:indexPath.row];
    
    NSDateFormatter *dateFor = [[NSDateFormatter alloc]init];
    
    [dateFor setDateFormat:@"yy-MM-dd"];
    
    NSString *tempString = [dateFor stringFromDate:tempDocument.dateCreated];
    
    tempString = [tempString stringByAppendingString:@"    "];
    
        NSLog(@"***************************cellForRowAtIndext:");
    static NSString *CellIdentifier = @"Cell";
    NSLog(@"syndocAgain:%d",synDocNum);
    
    
    

    //这里用到摘要，用到时候才会观察者模式发挥作用（发送消息）
    
    WizAbstract* abs = [[WizGlobalCache shareInstance] abstractForDoc:tempDocument.guid accountUserId:userId];
    
     
    Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell)
         {
             cell.abstractLabel.textLayer.string = nil;
         }
        else
        {
            NSLog(@"————————————————————————————cell 为空，复用");
           cell = [[Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
 
 
    
    cell.titleLabel.text =  tempDocument.title;

    cell.imageView.image  = nil;
    
    cell.abstractLabel.text = tempString;
    
    [cell.abstractLabel setColor:[UIColor blueColor] fromIndex:0 length:11];
    
    
    if (abs) {
      cell.abstractLabel.text = @"";
      //  cell.abstractLabel.textLayer.string = nil;
        if (!abs.image)
        {
            
            cell.imageExist = NO;
        }
        
       
        else
            cell.imageExist = YES;
        
            NSLog(@"有摘要");
        
       tempString = [tempString stringByAppendingString:abs.text];
    
       cell.abstractLabel.text = tempString;
       // cell.abstractLabel.textLayer.string = tempString;
        
        [cell.abstractLabel setColor:[UIColor blueColor] fromIndex:0 length:11];
        
        [cell.abstractLabel setColor:[UIColor grayColor] fromIndex:12 length:tempString.length-12];
        
        cell.imageView.image = abs.image;
        //[cell.abstractLabel setGradientEndColor:[UIColor grayColor]];

        
    }
 
    else
    {
        cell.imageExist = NO;
        
    }
    
   
    
    [cell layoutOfCell:cell.imageExist];

     
//    exitString = cell.abstractLabel.text in;
    

    
      // Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ReadViewController *tempReadView = [[ReadViewController alloc]initWithNibName:@"ReadViewController" bundle:nil];
    
    tempReadView.myDoc = [titleArray objectAtIndex:indexPath.row];
    
    self.navigationItem.title = @"返回";
    
     
    //设置跳转页面导航栏题目
    
    tempReadView.title = tempReadView.myDoc.title;
    
    NSLog(@"%@",tempReadView.myDoc.title);
    
    
    WizDocument *doc = [[WizDocument alloc]init];
    
    doc = [titleArray objectAtIndex:indexPath.row];
    
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   75;
}

#pragma mark 时间排序

@end
 

