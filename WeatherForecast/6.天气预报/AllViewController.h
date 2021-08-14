//
//  AllViewController.h
//  6.天气预报
//
//  Created by mac on 2021/8/10.
//  Copyright © 2021 mac. All rights reserved.
//

#import "ViewController.h"
#import "SelectedTableViewCell.h"
#import "SelectedTwoTableViewCell.h"
#import "SelectedFourTableViewCell.h"
#import "SelectedFiveTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface AllViewController : ViewController <UIScrollViewDelegate,
NSURLSessionDelegate,
UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, assign) int selectedCity;
@property (nonatomic, assign) int nowPage;
@property (nonatomic, strong) UIPageControl* pageControl;
@property (nonatomic, strong) UIScrollView* allScrollView;
@property (nonatomic, strong) NSMutableData* data;
@property (nonatomic, strong) NSMutableArray* allArray;


@end

NS_ASSUME_NONNULL_END
