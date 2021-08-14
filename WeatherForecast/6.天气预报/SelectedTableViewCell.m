//
//  SelectedTableViewCell.m
//  6.天气预报
//
//  Created by mac on 2021/8/9.
//  Copyright © 2021 mac. All rights reserved.
//

#import "SelectedTableViewCell.h"

@implementation SelectedTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ([self.reuseIdentifier isEqualToString:@"selected"]) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:39];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.frame = CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, 50);
        [self.contentView addSubview:_titleLabel];
        
        _smallTitleLabel = [[UILabel alloc] init];
        _smallTitleLabel.font = [UIFont systemFontOfSize:20];
        _smallTitleLabel.textColor = [UIColor whiteColor];
        _smallTitleLabel.textAlignment = NSTextAlignmentCenter;
        _smallTitleLabel.frame = CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, 30);
        
        _temTitleLabel = [[UILabel alloc] init];
        _temTitleLabel.font = [UIFont systemFontOfSize:110];
        _temTitleLabel.textColor = [UIColor whiteColor];
        _temTitleLabel.textAlignment = NSTextAlignmentCenter;
        _temTitleLabel.frame = CGRectMake(0, 115, [UIScreen mainScreen].bounds.size.width, 90);
        
        _weekTitleLabel = [[UILabel alloc] init];
        _weekTitleLabel.font = [UIFont systemFontOfSize:24];
        _weekTitleLabel.textColor = [UIColor whiteColor];
        _weekTitleLabel.textAlignment = NSTextAlignmentCenter;
        _weekTitleLabel.frame = CGRectMake(15, 270, 100, 35);
        
        _todayTitleLabel = [[UILabel alloc] init];
        _todayTitleLabel.font = [UIFont systemFontOfSize:18];
        _todayTitleLabel.textColor = [UIColor whiteColor];
        _todayTitleLabel.text = @"今天";
        _todayTitleLabel.textAlignment = NSTextAlignmentCenter;
        _todayTitleLabel.frame = CGRectMake(103, 273, 80, 35);
        
        _highTemTitleLabel = [[UILabel alloc] init];
        _highTemTitleLabel.font = [UIFont systemFontOfSize:23];
        _highTemTitleLabel.textColor = [UIColor whiteColor];
        _highTemTitleLabel.textAlignment = NSTextAlignmentCenter;
        _highTemTitleLabel.frame = CGRectMake(305, 270, 40, 35);
        
        _lowTemTitleLabel = [[UILabel alloc] init];
        _lowTemTitleLabel.font = [UIFont systemFontOfSize:23];
        _lowTemTitleLabel.textColor = [UIColor lightGrayColor];
        _lowTemTitleLabel.textAlignment = NSTextAlignmentCenter;
        _lowTemTitleLabel.frame = CGRectMake(360, 270, 40, 35);
        
        [self.contentView addSubview:_smallTitleLabel];
        [self.contentView addSubview:_temTitleLabel];
        [self.contentView addSubview:_weekTitleLabel];
        [self.contentView addSubview:_todayTitleLabel];
        [self.contentView addSubview:_highTemTitleLabel];
        [self.contentView addSubview:_lowTemTitleLabel];
    }
    return self;
}

@end
