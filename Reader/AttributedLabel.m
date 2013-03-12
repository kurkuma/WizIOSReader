//
//  AttributedLabel.m
//  AttributedStringTest
//
//  Created by sun huayu on 13-2-19.
//  Copyright (c) 2013年 sun huayu. All rights reserved.
//

#import "AttributedLabel.h"
#import<CoreText/CoreText.h>


@interface AttributedLabel(){

}
@property (nonatomic,retain)NSMutableAttributedString          *attString;

@end

@implementation AttributedLabel
@synthesize attString = _attString;
@synthesize textLayer;
@synthesize linesSpacing;
@synthesize numberOfLines;

- (void)dealloc{
    [_attString release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        numberOfLines = 0;
        self.backgroundColor = [UIColor clearColor];
        self.lineBreakMode = UILineBreakModeWordWrap;
        self.numberOfLines = 0;

        // Initialization code
    }
    return self;
}
-(void)setNumberOfLines:(NSInteger)numberOfLine
{
    //[super setNumberOfLines:numberOfLine];
    NSLog(@"行数设置");
    numberOfLines = numberOfLine;
    

    [self setNeedsDisplay];
}
-(void)setLinesSpacing:(long)lineSpacing
{
    NSLog(@"&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&设置行间距");
    linesSpacing = lineSpacing;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
     
    textLayer = [CATextLayer layer];
   
    textLayer.string = _attString;
    textLayer.frame = CGRectMake(0, 0, self.frame.size.width-10, self.frame.size.height);
     [self.layer addSublayer:textLayer];
  //  CGRect r = CGRectMake(5,5 , self.frame.size.width-15, self.frame.size.height-5);
     CGRect f = [self bounds];
    
    //[self.textLayer.string drawInRect:f withFont:[UIFont systemFontOfSize:10] lineBreakMode:UILineBreakModeWordWrap];
     
    
    self.numberOfLines = 2;
    
//     [super drawRect:rect];
//    CGContextRef ctx =UIGraphicsGetCurrentContext();
//    CGContextConcatCTM(ctx, CGAffineTransformScale(CGAffineTransformMakeTranslation(0, rect.size.height), 1.f, -1.f));
//    CTFramesetterRef framesetter =CTFramesetterCreateWithAttributedString((CFAttributedStringRef)_attString);
//    CGMutablePathRef path =CGPathCreateMutable();
//    CGPathAddRect(path, NULL, rect);
//    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [_attString length]-1), path, NULL);
//    CFRelease(path);
//    CFRelease(framesetter);
//    CTFrameDraw(frame, ctx);
//    CFRelease(frame);
    
}

- (void)setText:(NSString *)text{
    // text = nil;
    [super setText:text];
    NSLog(@"setText:%@",text);
    if (text == nil) {
        self.attString = nil;
    }else{
        self.attString = [[[NSMutableAttributedString alloc] initWithString:text] autorelease];
    }
}

// 设置某段字的颜色
- (void)setColor:(UIColor *)color fromIndex:(NSInteger)location length:(NSInteger)length{
    if (location < 0||location>self.text.length-1||length+location>self.text.length) {
        return;
    }
    [_attString addAttribute:(NSString *)kCTForegroundColorAttributeName
                        value:(id)color.CGColor
                        range:NSMakeRange(location, length)];
}

// 设置某段字的字体
- (void)setFont:(UIFont *)font fromIndex:(NSInteger)location length:(NSInteger)length{
    if (location < 0||location>self.text.length-1||length+location>self.text.length) {
        return;
    }
    [_attString addAttribute:(NSString *)kCTFontAttributeName
                        value:(id)CTFontCreateWithName((CFStringRef)font.fontName,
                                                       font.pointSize,
                                                       NULL)
                        range:NSMakeRange(location, length)];
}

// 设置某段字的风格
- (void)setStyle:(CTUnderlineStyle)style fromIndex:(NSInteger)location length:(NSInteger)length{
    if (location < 0||location>self.text.length-1||length+location>self.text.length) {
        return;
    }
    [_attString addAttribute:(NSString *)kCTUnderlineStyleAttributeName
                        value:(id)[NSNumber numberWithInt:style]
                        range:NSMakeRange(location, length)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
