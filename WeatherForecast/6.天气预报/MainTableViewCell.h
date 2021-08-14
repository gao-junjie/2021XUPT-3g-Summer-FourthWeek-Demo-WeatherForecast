//
//  MainTableViewCell.h
//  6.天气预报
//
//  Created by mac on 2021/8/9.
//  Copyright © 2021 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* timeLabel;
@property (nonatomic, strong) UIImageView* mainImageView;
@end

NS_ASSUME_NONNULL_END
