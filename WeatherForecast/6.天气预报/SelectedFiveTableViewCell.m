//
//  SelectedFiveTableViewCell.m
//  6.天气预报
//
//  Created by mac on 2021/8/10.
//  Copyright © 2021 mac. All rights reserved.
//

#import "SelectedFiveTableViewCell.h"

@implementation SelectedFiveTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ([self.reuseIdentifier isEqualToString:@"five"]) {
        self.backgroundColor = [UIColor clearColor];
        _sunriseLabel = [[UILabel alloc] init];
        _sunriseLabel.font = [UIFont systemFontOfSize:18];
        _sunriseLabel.textColor = [UIColor lightGrayColor];
        _sunriseLabel.frame = CGRectMake(25, 5, 90, 30);
        [self.contentView addSubview:_sunriseLabel];
        
        _sundownLabel = [[UILabel alloc] init];
        _sundownLabel.font = [UIFont systemFontOfSize:18];
        _sundownLabel.textColor = [UIColor lightGrayColor];
        _sundownLabel.frame = CGRectMake(235, 5, 90, 30);
        [self.contentView addSubview:_sundownLabel];
        
        _sunriseTimeLabel = [[UILabel alloc] init];
        _sunriseTimeLabel.font = [UIFont systemFontOfSize:40];
        _sunriseTimeLabel.textColor = [UIColor whiteColor];
        _sunriseTimeLabel.frame = CGRectMake(25, 30, 180, 58);
        [self.contentView addSubview:_sunriseTimeLabel];
        
        _sundownTimeLabel = [[UILabel alloc] init];
        _sundownTimeLabel.font = [UIFont systemFontOfSize:40];
        _sundownTimeLabel.textColor = [UIColor whiteColor];
        _sundownTimeLabel.frame = CGRectMake(235, 30, 180, 58);
        [self.contentView addSubview:_sundownTimeLabel];
    }
    return self;
}
@end
