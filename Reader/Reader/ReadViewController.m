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
#import "ContentsTableViewController.h"
@interface ReadViewController ()<WizSyncDownloadDelegate,WizGenerateAbstractDelegate>

@end

@implementation ReadViewController
@synthesize web;
@synthesize myDoc;
@synthesize tableAbstract;
@synthesize activityIndicator;
 //@synthesize loadView;
 

//只在初始化时候调用，调用一次。
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;

        [[WizNotificationCenter shareCenter]addDownloadDelegate:self];
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
-(void)toolBarInitial:(UIToolbar*)toolbar
{
    UIBarButtonItemStyle style= UIBarButtonItemStylePlain;
    UIBarButtonItem *fullScreen = [[UIBarButtonItem alloc]initWithImage:nil style:style target:self action:@selector(screenFull)];
                                   
    fullScreen.style = style;
    [fullScreen setTag:0];
    NSArray *array = [NSArray arrayWithObjects:fullScreen, nil];
    [toolBar setItems:array];
}
//也是只调用一次
 - (void)viewDidLoad
{
    NSLog(@"3.viewdidload");
    
    [super viewDidLoad];
        
    self.web.delegate = self;
    
   
    
    //缩放(为yes时候会使显示的页面特别的小);
    self.web.scalesPageToFit = NO;
    
//    self.web.frame = [[UIScreen mainScreen] bounds];
    
     [self.view addSubview:web];
    
    loadingView = [[UIView alloc]initWithFrame:CGRectMake( 80, 159, 150,120)];
    
        [loadingView setTag:108];
    
        [loadingView setBackgroundColor:[UIColor grayColor]];
    
        [loadingView setAlpha:0.5];
    
       [self.web addSubview:loadingView];
    toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0.0,[UIScreen mainScreen].bounds.size.height - 64,web.frame.size.width, 44.0)];
    NSLog(@"%f",self.view.frame.size.height);
    
    toolBar.barStyle =UIBarStyleBlackTranslucent;
     
    [self toolBarInitial:toolBar];
    
   // [self.view addSubview:toolBar];

   
    activityIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(50, 40,  50, 50)];

    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];

    [loadingView addSubview:activityIndicator];

    UITextField *loadIndiText = [[UITextField alloc]init];

    loadIndiText.text = @"正在加载";

    [loadIndiText setFrame:CGRectMake( 40,20, 80,40)];

    [loadingView addSubview:loadIndiText];

    [activityIndicator startAnimating];

    NSString * file =[[WizFileManager shareManager]documentIndexFilePath:myDoc.guid];
    
    WizFileManager *mana = [WizFileManager shareManager];
    
     if ([mana fileExistsAtPath:file]) {
         
         [self readDocument:myDoc];
     }
    
    else
        
      [self downLoadDocument:myDoc];

    
           // Do any additional setup after loading the view from its nib.
}

 - (void)didReceiveMemoryWarning
{
    NSLog(@"didReceiveMemory");
    
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
     NSLog(@"webViewDidStarLoad");
 
 }
 -(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicator stopAnimating];
    
    [loadingView setHidden:YES];
    
    float width = web.frame.size.width;
    
     NSString* scriptName =@"Read";
    
     NSString *path = [[NSBundle mainBundle] pathForResource:scriptName ofType:@"js"];
    
      NSString *jsCode = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [web stringByEvaluatingJavaScriptFromString:jsCode];
    
     NSString* cmd = [NSString stringWithFormat: @"ResizeImages(%f);",width];
    
    [web stringByEvaluatingJavaScriptFromString:cmd];
    
  //  [web stringByEvaluatingJavaScriptFromString:@"Touch()"];
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    
    [self.view addGestureRecognizer:singleTap];
    
    //这个可以加到任何控件上,比如你只想响应WebView，我正好填满整个屏幕
    singleTap.delegate = self;
    
    singleTap.cancelsTouchesInView = NO;
    
      NSLog(@"webViewDidFinishLoad");
        }
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
 -(void)handleSingleTap:(UITapGestureRecognizer *)sender{
     
     if (self.navigationController.navigationBarHidden) {
         self.navigationController.navigationBarHidden = NO;
         toolBar.hidden = NO;
     }
     else
     {
         self.navigationController.navigationBarHidden = YES;
         toolBar.hidden = YES;
         
     }
    CGPoint point = [sender locationInView:self.view];
    NSLog(@"handleSingleTap!pointx:%f,y:%f",point.x,point.y);
}


//当下载完成之后解压(sdk)
- (void) didDownloadEnd:(NSString*)guid{
     if (myDoc.guid == guid)
     {
         
         NSDateFormatter *form = [[NSDateFormatter alloc]init];
         [form setDateFormat:@"YY-MM-dd hh:mm:ss"];
         NSString *location = [form stringFromDate:[NSDate date]];
         NSLog(@" 下载完毕时间：%@",location);
         
        NSLog(@"READ:didDownloadEnd");
         
        [self readDocument:myDoc];
     }
//    docGuid = myDoc.guid;
//    NSLog(@"docGuid%@",docGuid);
}

#pragma mark 下载ziw
-(void)downLoadDocument:(WizDocument *)doc{
    
    [[WizSyncCenter shareCenter] downloadDocument:doc.guid kbguid:guid accountUserId:userId];
    
    }
#pragma mark 检查文件是否已经存在
 
-(void)readDocument:(WizDocument *)doc{
    
   NSString *file=  [[NSString alloc]init ];

  if ([[WizFileManager shareManager] prepareReadingEnviroment:doc.guid accountUserId:userId]){
        
            NSLog(@"44444444444444444解压");
        
      file =[[WizFileManager shareManager]documentIndexFilePath:doc.guid];}
    
    //有可能返回空，会下载的。需要做的就是解压。
    
    if (file == nil) {
        
        NSLog(@"file == nil");
        
     }
    
   NSURL *url = [NSURL fileURLWithPath:file];
    
   request=  [NSURLRequest requestWithURL:url] ;
    
   [self.web  loadRequest:request];
    NSLog(@"&&&&&&&&&&&开始请求");
     
 
}

-(void)dealloc{

    [[WizNotificationCenter shareCenter]removeObserver:self];
}
 @end
