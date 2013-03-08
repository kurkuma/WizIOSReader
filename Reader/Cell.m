//
//  Cell.m
//  Reader
//
//  Created by wiz on 13-2-20.
//  Copyright (c) 2013年 wiz. All rights reserved.
//

#import "Cell.h"
#import "QuartzCore/QuartzCore.h"


@implementation Cell
@synthesize imageView,titleLabel,abstractLabel;
//@synthesize timeLabel;
@synthesize imageExist;
 - (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        

        
        //添加图片
        
        imageView = [[UIImageView alloc]init];

                 
        
        //标题
        
         titleLabel = [[UILabel alloc]init];
        
         titleLabel.font = [UIFont systemFontOfSize:14];
                 
        //添加摘要
        
        abstractLabel = [[UILabel alloc]init];
        
        abstractLabel.numberOfLines =2;
        
        abstractLabel.textColor = [UIColor grayColor];
        
        abstractLabel.adjustsFontSizeToFitWidth = YES;
        
        abstractLabel.highlighted = NO;
        
        abstractLabel.textAlignment = NSTextAlignmentLeft;
        
        abstractLabel.font = [UIFont systemFontOfSize:12];
        
        
         
         imageExist = YES;

         //[self layoutOfCell:imageExist];
                 
        
        
         
         // Initialization code
    }
    return self;
}
-(void)layoutOfCell:(BOOL)image{
    if (image)
    {
        [self.contentView setFrame:CGRectMake(10, 5,225,60)];
        [self.imageView setFrame:CGRectMake(245,5,65,65)];
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        //
        imageView.layer.cornerRadius = 10;
        //
        [imageView.layer setBorderWidth:2];
        //
        [imageView.layer setBorderColor:(__bridge CGColorRef)([UIColor grayColor])];


        [self.titleLabel setFrame:CGRectMake(10, 5,225, 20)];
        [self.abstractLabel setFrame:CGRectMake(10,25, 225, 45)];
        [self addSubview:imageView];

      }
    else
    {
        [self.contentView setFrame:CGRectMake(10, 5,[UIScreen mainScreen].bounds.size.width,60)];
        NSLog(@"没有图片%f",[UIScreen mainScreen].bounds.size.width);
        [self.titleLabel setFrame:CGRectMake(10, 5,[UIScreen mainScreen].bounds.size.width, 25)];
        [self.abstractLabel setFrame:CGRectMake(10,25, [UIScreen mainScreen].bounds.size.width, 45)];

    }
     
    [self.contentView addSubview:titleLabel];
    
    [self.contentView addSubview:abstractLabel];

}

//-(void)redifineSize:(float)width
//{
//    [self.contentView setFrame:CGRectMake(10, 5, width, 70)];
//    [self.abstractLabel setFrame:CGRectMake(10, 40, width, 40)];
//}
 - (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
