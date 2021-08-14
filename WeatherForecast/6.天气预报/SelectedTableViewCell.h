//
//  SelectedTableViewCell.h
//  6.天气预报
//
//  Created by mac on 2021/8/9.
//  Copyright © 2021 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectedTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* smallTitleLabel;
@property (nonatomic, strong) UILabel* temTitleLabel;
@property (nonatomic, strong) UILabel* weekTitleLabel;
@property (nonatomic, strong) UILabel* todayTitleLabel;
@property (nonatomic, strong) UILabel* highTemTitleLabel;
@property (nonatomic, strong) UILabel* lowTemTitleLabel;

@end

NS_ASSUME_NONNULL_END
