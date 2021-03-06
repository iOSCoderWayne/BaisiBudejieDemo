//
//  QDBVoiceView.m
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/11/14.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import "QDBVoiceView.h"
#import "QDBTopic.h"
#import "QDBShowBigImageVC.h"
#import <UIImageView+WebCache.h>

@interface QDBVoiceView()
@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end

@implementation QDBVoiceView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.bgImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage)];
    [self.bgImageView addGestureRecognizer:tap];
}

//显示大图控制器
-(void)showBigImage
{
    QDBLog(@"-------%@=======%@",self.bgImageView.image,self.topic);
    QDBShowBigImageVC *showBig = [[QDBShowBigImageVC alloc]init];
    showBig.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showBig animated:YES completion:nil];
    
}


+(instancetype)voiceView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:0] lastObject];
}

-(void)setTopic:(QDBTopic *)topic
{
    _topic = topic;
    
    //设置数据
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:topic.bigImage]];
    
    //播放次数
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd次",topic.playcount];
    
    //播放时长
    NSInteger minute = topic.voicetime/60;
    NSInteger sencond = topic.voicetime%60;
    
    self.playTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,sencond];
}
@end
