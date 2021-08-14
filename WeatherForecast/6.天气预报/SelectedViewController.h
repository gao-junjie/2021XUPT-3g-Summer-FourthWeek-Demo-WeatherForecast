//
//  SelectedViewController.h
//  6.天气预报
//
//  Created by mac on 2021/8/9.
//  Copyright © 2021 mac. All rights reserved.
//

#import "ViewController.h"
#import "SelectedTwoTableViewCell.h"
#import "SelectedFourTableViewCell.h"
#import "SelectedFiveTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface SelectedViewController : ViewController <
UITableViewDelegate,
UITableViewDataSource,
NSURLSessionDelegate
>
@property (nonatomic, strong) NSMutableArray *mainCityArray;
@property (nonatomic, copy) NSString* selectedCityName;
@property (nonatomic, strong) UITableView* selectedCityTableView;
@property (nonatomic, strong) NSMutableData* data;
@property (nonatomic, copy) NSString* temStr;
@property (nonatomic, copy) NSString* weaStr;
@property (nonatomic, copy) NSString* weekStr;
@property (nonatomic, copy) NSString* highTemStr;
@property (nonatomic, copy) NSString* lowTemStr;
@property (nonatomic, copy) NSString* sugesstionStr;
@property (nonatomic, copy) NSString* sunriseStr;
@property (nonatomic, copy) NSString* sunsetStr;
@property (nonatomic, copy) NSString* humidityStr;
@property (nonatomic, copy) NSString* airlevelStr;
@property (nonatomic, copy) NSString* visibilityStr;
@property (nonatomic, copy) NSString* pressureStr;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* smallTitleLabel;
@property (nonatomic, strong) UILabel* temTitleLabel;
@property (nonatomic, strong) UILabel* weekTitleLabel;
@property (nonatomic, strong) UILabel* todayTitleLabel;
@property (nonatomic, strong) UILabel* highTemTitleLabel;
@property (nonatomic, strong) UILabel* lowTemTitleLabel;
@property (nonatomic, strong) NSMutableArray* temArray;
@property (nonatomic, strong) NSMutableArray* timeArray;
@property (nonatomic, strong) NSMutableArray* weatherImgArray;
@property (nonatomic, strong) NSMutableArray* weekArray;
@property (nonatomic, strong) NSMutableArray* weekWeatherImgArray;
@property (nonatomic, strong) NSMutableArray* weekHighTemArray;
@property (nonatomic, strong) NSMutableArray* weekLowTemArray;
@property (nonatomic, strong) UIScrollView* selectedScrollView;
@property (nonatomic, strong) NSMutableArray* allArray;
@end

NS_ASSUME_NONNULL_END
