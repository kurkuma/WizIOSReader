//
//  Cell.m
//  Reader
//
//  Created by wiz on 13-2-20.
//  Copyright (c) 2013年 wiz. All rights reserved.
//

#import "Cell.h"

@implementation Cell
@synthesize imageView,textLabel,detailTextLabel;
@synthesize modiDate;
@synthesize dateForm;
@synthesize modiLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         //[self setFrame:CGRectMake(0, 0, 320, 400)];
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(280, 0, 80, 40)];
        imageView.backgroundColor = [UIColor grayColor];
        [self addSubview:imageView];
        textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 40)];
         [self.contentView addSubview:textLabel];
        detailTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 40, 200, 60)];
        detailTextLabel.numberOfLines = 3;
        detailTextLabel.text = @"hlsajfjfjkioq[jgkjas;jfa";
         [self.contentView setFrame:CGRectMake(0, 0, 200, 100)];
        [self.contentView addSubview:detailTextLabel];
        
        //文档修改时间
        modiDate = [[NSDate alloc]init];
        dateForm = [[NSDateFormatter alloc]init];
        [dateForm setDateFormat:@"MM-dd"];
        modiLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,40, 70, 60)];
        NSString *temp = [[NSString alloc]init];
        temp= [dateForm stringFromDate:modiDate];
        modiLabel.text = [temp stringByAppendingString:@" " ];
        [self.contentView addSubview:modiLabel];
        
        // Initialization code
    }
    return self;
}
  
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
