//
//  SelectedFiveTableViewCell.h
//  6.天气预报
//
//  Created by mac on 2021/8/10.
//  Copyright © 2021 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectedFiveTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel* sunriseLabel;
@property (nonatomic, strong) UILabel* sunriseTimeLabel;
@property (nonatomic, strong) UILabel* sundownLabel;
@property (nonatomic, strong) UILabel* sundownTimeLabel;
@end

NS_ASSUME_NONNULL_END
