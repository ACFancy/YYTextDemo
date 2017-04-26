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
    NSArray *lines = self.textLayout.lines;
    NSLog(@"%zd", lines.count);
    // Drawing code
    CGFloat fontSize = self.attributedText.yy_font.pointSize+self.attributedText.yy_headIndent + self.attributedText.yy_tailIndent;
    CGFloat lineSpace = self.attributedText.yy_lineSpacing;
    CGFloat margin = fontSize + lineSpace;
    CGFloat startX = rect.size.width - 0.5*lineSpace;
    NSInteger numOfColums = floor((rect.size.width - lineSpace)/margin);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    [[UIColor whiteColor] setFill];
    [path fill];
    for (int i = 0; i < numOfColums+2; i+=1) {
        @autoreleasepool {
            path = [UIBezierPath bezierPath];
            [path moveToPoint:(CGPoint){startX-i*margin, 0}];
            [path addLineToPoint:(CGPoint){startX-i*margin, rect.size.height}];
            [path setLineWidth:0.5];
            [[UIColor redColor] setStroke];
            [path stroke];
        }
    }
    
}

@end
