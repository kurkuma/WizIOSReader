//
//  Cell.h
//  Reader
//
//  Created by wiz on 13-2-20.
//  Copyright (c) 2013年 wiz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell : UITableViewCell
{
   // UIImageView *_ImageView;
    }
@property(nonatomic,strong)UIImageView *ImageView;
@property(nonatomic,strong )UILabel *textLabel;
@property(nonatomic,strong)UILabel *detailTextLabel;
@property(nonatomic,strong)NSDate *modiDate;
@property(nonatomic,strong)NSDateFormatter *dateForm;
@property(nonatomic,strong)UILabel *modiLabel;
@end
