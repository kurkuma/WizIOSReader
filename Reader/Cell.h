//
//  Cell.h
//  Reader
//
//  Created by wiz on 13-2-20.
//  Copyright (c) 2013年 wiz. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CustomLabel.h"
//#import "TTTAttributedLabel.h"
#import"AttributedLabel.h"

 @interface Cell : UITableViewCell
{
    BOOL imageExist;
}
   // UIImageView *_ImageView;
 
@property(nonatomic,strong)UIImageView *ImageView;
@property(nonatomic,strong )UILabel *titleLabel;
@property(nonatomic,strong)AttributedLabel *abstractLabel;
//@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,assign)BOOL imageExist;
//-(void)redifineSize:(float)width ;
-(void)layoutOfCell:(BOOL)imageExist;
 @end
