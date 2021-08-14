//
//  MainTableViewCell.m
//  6.天气预报
//
//  Created by mac on 2021/8/9.
//  Copyright © 2021 mac. All rights reserved.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ([self.reuseIdentifier isEqualToString:@"main"]) {
        _mainImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_mainImageView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:38];
        _titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_titleLabel];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        //现在时间,你可以输出来看下是什么格式
        NSDate *dateNow = [NSDate date];
        //----------将nsdate按formatter格式转成nsstring
        NSString *currentTimeString = [formatter stringFromDate:dateNow];
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = currentTimeString;
        _timeLabel.font = [UIFont systemFontOfSize:19];
        _timeLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_timeLabel];
        
    }
    return self;
}

- (void)layoutSubviews {
    _titleLabel.frame = CGRectMake(30, 45, 200, 60);
    _mainImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, ([UIScreen mainScreen].bounds.size.height - 60) / 8.0);
    _timeLabel.frame = CGRectMake(30, 15, 100, 30);
}


@end
