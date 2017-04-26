//
//  ViewController.m
//  YYTextDemo
//
//  Created by 恭喜发财 on 2017/4/26.
//  Copyright © 2017年 PGWizard. All rights reserved.
//

#import "ViewController.h"
#import "YKTextView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    YKTextView *txtV = [[YKTextView alloc] init];
    txtV.frame = (CGRect){50, 100, 200,200};
    txtV.backgroundColor = [UIColor greenColor];
    [self.view addSubview:txtV];
    txtV.verticalForm = YES;
    txtV.editable = NO;
//    txtV.userInteractionEnabled = NO;
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = 8.0f;
   NSMutableAttributedString *attriStrM =  [[NSMutableAttributedString alloc] initWithString:@"次才是大师的那是肯定是的是的是的是的是的是的爱上了大神快打死了快递那算了看，我是中国人中国人，爱打打卡就打谁开的骄傲的卡斯达大厦肯德基阿克苏大姐那肯定叫你卡死的那是肯定就是打卡机纳斯达克阿萨德看上的空间啊。爱上的那款就是的纳税会计的时代，爱上的空间按多看少打卡机爱上的那是进口的那是肯定。" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paraStyle }];
     
    
    txtV.attributedText = attriStrM.copy;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
