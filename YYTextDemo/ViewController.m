//
//  ViewController.m
//  YYTextDemo
//
//  Created by 恭喜发财 on 2017/4/26.
//  Copyright © 2017年 PGWizard. All rights reserved.
//

#import "ViewController.h"
#import "YKTextView.h"

/*
 https://github.com/ibireme/YYText/issues/595
 复现：YYTextEditExample 纵向排版下，清空文字, 再中英文混合输入，文字会消失。
 
 问题分析及解决建议：
 
 问题：iOS 10 中，某些字体在某些字号，例如：Zapfino 13 号、Times New Roman 20 号，的纵向布局下，文字会消失；AvenirNext-Regular 字体在清空文字后，仅输入英文时正常，输入中文时文字消失等。
 
 分析：iOS 10 中，某些字体在某些字号下， CTFrameSetter 使用了略大于 cgpath 的 constrainSize 计算，因此纵向布局下， baseline.origin.x 会比预想的略微向右偏移。YYTextLayout 中纵向文字的 line 是从右往左绘制，计算 line 的 frame 中，有这么一段代码：
 
 ...
 if (constraintSizeIsExtended) {
 if (isVerticalForm) {
 if (rect.origin.x + rect.size.width >
 constraintRectBeforeExtended.origin.x +
 constraintRectBeforeExtended.size.width) break;
 }
 ...
 此时，行的 rect.origin.x + rect.size.width 是略大于 constraintRectBeforeExtended.origin.x + constraintRectBeforeExtended.size.width 的。因此会直接跳过行的计算，导致 textBoundingRect等一系列的错误。
 
 修改： 谨慎的将 if (rect.origin.x + rect.size.width > constraintRectBeforeExtended.origin.x +
 constraintRectBeforeExtended.size.width) 修改为 if (!CGRectIntersectsRect(rect,constraintRectBeforeExtended)) 。
 
 */

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    YKTextView *txtV = [[YKTextView alloc] init];
    txtV.backgroundColor = [UIColor greenColor];
    txtV.frame = (CGRect){0, 0 , 1000, 1000};
    [self.view addSubview:txtV];
    txtV.verticalForm = YES;
    txtV.editable = NO;
    txtV.userInteractionEnabled = NO;
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = 12.0f;
    NSString *str = @"阳光下，他以别人的意愿站立着，站立成一座城市的背影，他知道这不是他要的，其实他的愿望很小。\n—《冬青树》";
   str =  [str stringByReplacingOccurrencesOfString:@"，" withString:@"，\r"];
   str =  [str stringByReplacingOccurrencesOfString:@"。" withString:@"。\r"];
   str =  [str stringByReplacingOccurrencesOfString:@"！" withString:@"！\r"];
   str =  [str stringByReplacingOccurrencesOfString:@"？" withString:@"？\r"];
   str =  [str stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\r"];
    
   NSMutableAttributedString *attriStrM =  [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18.0], NSParagraphStyleAttributeName:paraStyle }];
    
    YYTextContainer *container = [YYTextContainer containerWithSize:(CGSize){1000, 1000}];
    container.maximumNumberOfRows = 10;
    
    YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:attriStrM];
    
    NSArray<YYTextLine *> *lines = layout.lines;
    CGFloat maxWidth = -MAXFLOAT;
    for (int i = 0; i < lines.count; i+=1) {
        maxWidth = MAX(maxWidth, lines[i].width+attriStrM.yy_lineSpacing);
    }
    txtV.attributedText = attriStrM.copy;
    __block CGFloat txtVW = 0.5*attriStrM.yy_lineSpacing;
    if (lines.count > 10) {
//      txtVW += attriStrM.yy_lineSpacing;
        
        __block NSInteger lineCount = 0;
        [lines enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(YYTextLine * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (lineCount >= 10) {
                *stop = YES;
            }else {
                txtVW +=obj.height;
                lineCount++;
            }
        }];
    }else {
        txtVW += attriStrM.yy_lineSpacing*(lines.count);
        [lines enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(YYTextLine * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            txtVW +=obj.height;
        }];
    }
    
    txtV.frame = (CGRect){5, 50, txtVW, maxWidth};
    [txtV setNeedsLayout];
    txtV.backgroundColor = [UIColor greenColor];
    
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
