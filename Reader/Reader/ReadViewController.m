//
//  ReadViewController.m
//  Reader
//
//  Created by wiz on 13-2-20.
//  Copyright (c) 2013年 wiz. All rights reserved.
//

#import "ReadViewController.h"
#import "WizNotificationCenter.h"
#import "WizSyncCenter.h"
#import "WizFileManager.h"
 @interface ReadViewController ()<WizSyncDownloadDelegate>

@end

@implementation ReadViewController
@synthesize web;
@synthesize myDoc;
 

//只在初始化时候调用，调用一次。
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
         NSLog(@"1.initwithnibname");
       // Custom initialization
    }
    return self;
}
//每次都会调用
- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"2.viewWillAppear");

    //[self readDocument:myDoc];
}
 
//也是只调用一次
 - (void)viewDidLoad
{
    NSLog(@"3.viewdidload");
    [super viewDidLoad];
    self.web.delegate = self;
    [self.view addSubview:web];
    [self downLoadDocument:myDoc];

 
       // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"shouldstart");
    return YES;
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"didstartload");
}
// - (void) didDownloadEnd:(NSString *)guid
//{
//    NSLog(@"readView didDownloadEnd");
//    WizDocument *doc  = [[WizDocument alloc]init];
//    if (guid == doc.guid) {
//        [self downLoadDocument:doc];
//        
//    }
//    
//}
#pragma mark 下载ziw
-(void)downLoadDocument:(WizDocument *)doc{
    
    //观察者模式，被观察者添加。
    //[[WizNotificationCenter shareCenter]addDownloadDelegate:self];
    //[[WizSyncCenter shareCenter]downloadDocument:doc.guid kbguid:nil accountUserId:userId];
    NSLog(@"downloaddocument");
    WizSyncCenter *syn = [WizSyncCenter shareCenter];
    [syn downloadDocument:doc.guid kbguid:nil accountUserId:userId];
    NSLog(@"下载完成");
}
#pragma mark  解压文件，得到文件路径
-(NSString*)loadFile:(WizDocument *)doc user:(NSString *)user{
    WizFileManager *fm = [WizFileManager shareManager];
    
    //有可能已经下载,sdk已经对此判断，再看解压后的文件是否存在
    
    if (![fm prepareReadingEnviroment:doc.guid accountUserId:user]) {
        //当文件存在时候，通过文档的guid,借助wizfilemanager 的 documentIndexPath,可以得到文件的路径
        [self downLoadDocument:doc];
        NSString *documenFile = [fm documentIndexFilePath:doc.guid];
        return documenFile;
    }
    else
    {
        NSLog(@"直接解压");
     }
    
       return nil;
}
#pragma mark 检查文件是否已经存在
-(void)readDocument:(WizDocument *)doc{
    
    NSString *file=  [[NSString alloc]init ];
                  NSLog(@"filepath:%@",[self  loadFile:doc user:userId]);
    file = [self  loadFile:doc user:userId];
         //首先检查压缩包是否存在，其次查看文件是否已经存在
    NSLog(@"filePath%@",file);
             NSLog(@"已经存在，直接读取");
    //有可能返回空，会下载的。需要做的就是解压。
    if (file == nil) {
        NSLog(@"file == nil");
        //WizFileManager *fm = [WizFileManager shareManager];
        //[fm prepareReadingEnviroment:doc.guid accountUserId:userId];
     }
  NSURL *url = [NSURL fileURLWithPath:file];
  NSURLRequest * request= [NSURLRequest requestWithURL:url];

  [self.web  loadRequest:request];

}



@end
