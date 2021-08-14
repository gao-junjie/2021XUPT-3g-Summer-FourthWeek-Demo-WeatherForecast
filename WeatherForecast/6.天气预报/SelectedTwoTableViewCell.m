//
//  SelectedTwoTableViewCell.m
//  6.天气预报
//
//  Created by mac on 2021/8/9.
//  Copyright © 2021 mac. All rights reserved.
//

#import "SelectedTwoTableViewCell.h"

@implementation SelectedTwoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ([self.reuseIdentifier isEqualToString:@"two"]) {
        self.backgroundColor = [UIColor clearColor];
        
        _selectedScrollView = [[UIScrollView alloc] init];
        _selectedScrollView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 160);
        _selectedScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 2, 160);
        _selectedScrollView.bounces = NO;
        _selectedScrollView.showsHorizontalScrollIndicator = NO;
        _selectedScrollView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_selectedScrollView];
    }
    return self;
}
    

@end
