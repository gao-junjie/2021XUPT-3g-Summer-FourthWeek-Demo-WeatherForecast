//
//  SelectedFourTableViewCell.m
//  6.天气预报
//
//  Created by mac on 2021/8/10.
//  Copyright © 2021 mac. All rights reserved.
//

#import "SelectedFourTableViewCell.h"

@implementation SelectedFourTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ([self.reuseIdentifier isEqualToString:@"four"]) {
        self.backgroundColor = [UIColor clearColor];
        _suggestionLabel = [[UILabel alloc] init];
        _suggestionLabel.textColor = [UIColor whiteColor];
        _suggestionLabel.numberOfLines = 0;
        _suggestionLabel.font = [UIFont systemFontOfSize:22];
        _suggestionLabel.frame = CGRectMake(25, 10, 340, 50);
        [self.contentView addSubview:_suggestionLabel];
    }
    return self;
}

@end
