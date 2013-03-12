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
        
         titleLabel.font = [UIFont systemFontOfSize:15];
                 
        //添加摘要
        
        abstractLabel = [[AttributedLabel alloc]init];
         abstractLabel.backgroundColor = [UIColor clearColor];
        
        
        abstractLabel.adjustsFontSizeToFitWidth = YES;
        
        abstractLabel.highlighted = NO;
        
        abstractLabel.textAlignment = NSTextAlignmentLeft;
        
        abstractLabel.font = [UIFont systemFontOfSize:12];
         
      //   CGRect r = CGRectMake(5,5 , self.abstractLabel.frame.size.width-15, self.abstractLabel.frame.size.height-5);
//         [self.abstractLabel.text drawInRect:r withFont:[UIFont systemFontOfSize:12] lineBreakMode:UILineBreakModeWordWrap];
//         self.abstractLabel.numberOfLines = 2;
        
        
         
         imageExist = YES;

         //[self layoutOfCell:imageExist];
                 
        
         [self addSubview:imageView];
         
         [self addSubview:titleLabel];
         
         [self  addSubview:abstractLabel];

         
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
        [self.abstractLabel setFrame:CGRectMake(10,35, 225, 45)];

      }
    else
    {
        [self.contentView setFrame:CGRectMake(10, 5,[UIScreen mainScreen].bounds.size.width,60)];
        NSLog(@"没有图片%f",[UIScreen mainScreen].bounds.size.width);
        [self.titleLabel setFrame:CGRectMake(10, 5,[UIScreen mainScreen].bounds.size.width-10, 25)];
        [self.abstractLabel setFrame:CGRectMake(10,35, [UIScreen mainScreen].bounds.size.width-10, 45)];

    }
    abstractLabel.textAlignment = NSTextAlignmentCenter;
  //  abstractLabel.numberOfLines =2;
   // [abstractLabel sizeToFit];

   
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
