//
//  YKTextView.m
//  YYTextDemo
//
//  Created by 恭喜发财 on 2017/4/26.
//  Copyright © 2017年 PGWizard. All rights reserved.
//

#import "YKTextView.h"

@implementation YKTextView



- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.contentOffset = (CGPoint){self.contentSize.width- self.frame.size.width};
    NSArray<YYTextLine *> *lines = self.textLayout.lines;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    [[UIColor whiteColor] setFill];
    [path fill];
     CGFloat lineSpace = self.attributedText.yy_lineSpacing;
    CGFloat startX = rect.size.width ;//- 0.5*lineSpace;
    CGFloat margin = 0;
    CGFloat maxHeight = -MAXFLOAT;
    for (int i = 0; i < lines.count+1; i+=1) {
        
        @autoreleasepool {
            path = [UIBezierPath bezierPath];
            [path moveToPoint:(CGPoint){startX, 0}];
            [path addLineToPoint:(CGPoint){startX, rect.size.height-self.contentInset.top-self.contentInset.bottom-lineSpace}];
            CGFloat dashPattern[] = {8, 4.0f};
            [path setLineDash:dashPattern count:2 phase:4];
            [path setLineWidth:0.5];
            [[UIColor darkGrayColor] setStroke];
            [path stroke];
            if (i < lines.count) {
                maxHeight = MAX(maxHeight, lines[i].height);
                margin = lineSpace + lines[i].width;
                startX -= margin;
            }
        }
    }
}

@end
