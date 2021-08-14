//
//  AddViewController.h
//  6.天气预报
//
//  Created by mac on 2021/8/9.
//  Copyright © 2021 mac. All rights reserved.
//

#import "ViewController.h"
#import "SelectedViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddViewController : ViewController <
UITextFieldDelegate,
UITableViewDelegate,
UITableViewDataSource,
NSURLSessionDelegate
>
@property (nonatomic, strong) UITextField* addTextfield;
@property (nonatomic, strong) UITableView *cityTableView;
@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) NSMutableArray *cityArray;
@property (nonatomic, copy) NSString* cityName;
@property (nonatomic, strong) NSMutableArray *mainCityArray;
@end

NS_ASSUME_NONNULL_END
