//
//  SelectedViewController.m
//  6.天气预报
//
//  Created by mac on 2021/8/9.
//  Copyright © 2021 mac. All rights reserved.
//

#import "SelectedViewController.h"

@interface SelectedViewController ()

@end

@implementation SelectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _timeArray = [[NSMutableArray alloc] init];
    _weatherImgArray = [[NSMutableArray alloc] init];
    _temArray = [[NSMutableArray alloc] init];
    _weekArray = [[NSMutableArray alloc] init];
    _weekWeatherImgArray = [[NSMutableArray alloc] init];
    _weekHighTemArray = [[NSMutableArray alloc] init];
    _weekLowTemArray = [[NSMutableArray alloc] init];
    _allArray = [[NSMutableArray alloc] init];
    [self creatTips];
    [self creatUrl];
    //[self creatTableView];


}

- (void)creatGroupOne {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:39];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.text = _selectedCityName;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.frame = CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, 50);
    
    _smallTitleLabel = [[UILabel alloc] init];
    _smallTitleLabel.font = [UIFont systemFontOfSize:20];
    _smallTitleLabel.textColor = [UIColor whiteColor];
    _smallTitleLabel.text = _weaStr;
    _smallTitleLabel.textAlignment = NSTextAlignmentCenter;
    _smallTitleLabel.frame = CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, 30);
    
    _temTitleLabel = [[UILabel alloc] init];
    _temTitleLabel.font = [UIFont systemFontOfSize:110];
    _temTitleLabel.textColor = [UIColor whiteColor];
    _temTitleLabel.text = _temStr;
    _temTitleLabel.textAlignment = NSTextAlignmentCenter;
    _temTitleLabel.frame = CGRectMake(0, 115, [UIScreen mainScreen].bounds.size.width, 90);
    
    _weekTitleLabel = [[UILabel alloc] init];
    _weekTitleLabel.font = [UIFont systemFontOfSize:24];
    _weekTitleLabel.textColor = [UIColor whiteColor];
    _weekTitleLabel.text = _weekStr;
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
    _highTemTitleLabel.text = _highTemStr;
    _highTemTitleLabel.textAlignment = NSTextAlignmentCenter;
    _highTemTitleLabel.frame = CGRectMake(305, 270, 40, 35);
    
    _lowTemTitleLabel = [[UILabel alloc] init];
    _lowTemTitleLabel.font = [UIFont systemFontOfSize:23];
    _lowTemTitleLabel.textColor = [UIColor lightGrayColor];
    _lowTemTitleLabel.text = _lowTemStr;
    _lowTemTitleLabel.textAlignment = NSTextAlignmentCenter;
    _lowTemTitleLabel.frame = CGRectMake(360, 270, 40, 35);
}

- (void)creatTips {
    UIImageView* backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selectedBackground.jpg"]];
    backgroundImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:backgroundImageView];
    
    UIButton* cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:22];
    cancelButton.frame = CGRectMake(20, 42, 60, 40);
    [cancelButton addTarget:self action:@selector(pressCancelButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    
    UIButton* addButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [addButton setTitle:@"添加" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont systemFontOfSize:22];
    addButton.frame = CGRectMake(340, 42, 60, 40);
    [addButton addTarget:self action:@selector(pressAddButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
}

- (void)creatTableView {
    _selectedCityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 90, [UIScreen mainScreen].bounds.size.width, 780) style:UITableViewStylePlain];
    _selectedCityTableView.showsVerticalScrollIndicator = NO;
    _selectedCityTableView.separatorColor = [UIColor whiteColor];
    _selectedCityTableView.delegate = self;
    _selectedCityTableView.dataSource = self;
    _selectedCityTableView.backgroundColor = [UIColor clearColor];
    [_selectedCityTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"selected"];
    [_selectedCityTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"three"];
    [_selectedCityTableView registerClass:[SelectedTwoTableViewCell class] forCellReuseIdentifier:@"two"];
    [_selectedCityTableView registerClass:[SelectedFourTableViewCell class] forCellReuseIdentifier:@"four"];
    [_selectedCityTableView registerClass:[SelectedFiveTableViewCell class] forCellReuseIdentifier:@"five"];
    [self.view addSubview:_selectedCityTableView];
}

- (void)pressCancelButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)pressAddButton {
    BOOL flag = YES;
    for (NSString* object in _mainCityArray) {
        if ([object isEqualToString:_selectedCityName]) {
            flag = NO;
            break;
        }
    }
    if (flag == YES) {
        if (_mainCityArray.count < 8) {
            //添加 字典，将label的值通过key值设置传递
            NSDictionary *dict =[[NSDictionary alloc]initWithObjectsAndKeys:self.selectedCityName,@"cityname", nil];
            //创建通知
            NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:_allArray userInfo:dict];
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            UIAlertController* boomAlert = [UIAlertController alertControllerWithTitle:@"警告" message:@"城市已达上限" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *boomAction= [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [boomAlert addAction:boomAction];
            [self presentViewController:boomAlert animated:YES completion:nil];
        }
    } else {
        UIAlertController* boomAlert = [UIAlertController alertControllerWithTitle:@"警告" message:@"该城市天气已存在" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *boomAction= [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [boomAlert addAction:boomAction];
        [self presentViewController:boomAlert animated:YES completion:nil];
    }
    
}

- (void)creatUrl {
    //1.创建请求地址
    NSString *urlString = [NSString stringWithFormat:@"https://tianqiapi.com/api?version=v1&appid=83517518&appsecret=CUPEH1f7&city=%@", _selectedCityName];
    //处理字符
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //创建URL
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"%@", urlString);
    //2.创建请求类
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //3.创建会话
    //delegateQueue 表示协议方法在哪个线程中执行
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self  delegateQueue:[NSOperationQueue mainQueue]];
    //4.根据会话创建任务
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    //5.启动任务
    [dataTask resume];
}

//接收服务器的响应
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    if(self.data == nil){
        self.data = [[NSMutableData alloc] init];
    } else {
        self.data.length = 0;
    }
    //允许接收数据
    completionHandler(NSURLSessionResponseAllow);
}

//接收到数据，该方法会被调用多次
- (void)URLSession:(NSURLSession *)session dataTask:( NSURLSessionDataTask *)dataTask didReceiveData:( NSData *)data {
    [self.data appendData:data];
}

//数据请求完成或者请求出现错误调用的方法
- (void)URLSession:(NSURLSession *)session task:( NSURLSessionTask *)task didCompleteWithError:( NSError *)error {
    if (error == nil) {
        //解析数据
        NSDictionary *secondDictionary = [NSJSONSerialization JSONObjectWithData:_data options:kNilOptions error:nil];
        NSMutableArray *cityArray = [[NSMutableArray alloc] init];
        cityArray = secondDictionary[@"data"];
        _temStr = [NSMutableString stringWithFormat:@"%@",cityArray[0][@"tem"]];
        _weaStr = [NSMutableString stringWithFormat:@"%@",cityArray[0][@"wea"]];
        _weekStr = [NSMutableString stringWithFormat:@"%@",cityArray[0][@"week"]];
        _highTemStr = [NSMutableString stringWithFormat:@"%@",cityArray[0][@"tem1"]];
        _lowTemStr = [NSMutableString stringWithFormat:@"%@",cityArray[0][@"tem2"]];
        _sunriseStr = [NSMutableString stringWithFormat:@"%@",cityArray[0][@"sunrise"]];
        _sunsetStr = [NSMutableString stringWithFormat:@"%@",cityArray[0][@"sunset"]];
        _humidityStr = [NSMutableString stringWithFormat:@"%@",cityArray[0][@"humidity"]];
        _airlevelStr = [NSMutableString stringWithFormat:@"%@",cityArray[0][@"air_level"]];
        _visibilityStr = [NSMutableString stringWithFormat:@"%@",cityArray[0][@"visibility"]];
        _pressureStr = [NSMutableString stringWithFormat:@"%@",cityArray[0][@"pressure"]];
        _sugesstionStr = [NSMutableString stringWithFormat:@"%@",cityArray[0][@"index"][4][@"desc"]];
        _temStr = [_temStr stringByReplacingOccurrencesOfString:@"℃" withString:@""];
        _highTemStr = [_highTemStr stringByReplacingOccurrencesOfString:@"℃" withString:@""];
        _lowTemStr = [_lowTemStr stringByReplacingOccurrencesOfString:@"℃" withString:@""];
        NSMutableArray *todayArray = [[NSMutableArray alloc] init];
        todayArray = secondDictionary[@"data"][0][@"hours"];
        for (int i = 0; i < 9; i++) {
            NSMutableString *strOne = [NSMutableString stringWithFormat:@"%@",todayArray[i][@"hours"]];
            [_timeArray addObject: strOne];
            NSMutableString *strTwo = [NSMutableString stringWithFormat:@"%@",todayArray[i][@"wea_img"]];
            [_weatherImgArray addObject: strTwo];
            NSString *strThree = [NSString stringWithFormat:@"%@",todayArray[i][@"tem"]];
            strThree = [strThree stringByReplacingOccurrencesOfString:@"℃" withString:@""];
            [_temArray addObject: strThree];
        }
        for (int i = 1; i < cityArray.count; i++) {
            NSMutableString *strOne = [NSMutableString stringWithFormat:@"%@",cityArray[i][@"week"]];
            [_weekArray addObject: strOne];
            NSMutableString *strTwo = [NSMutableString stringWithFormat:@"%@",cityArray[i][@"wea_img"]];
            [_weekWeatherImgArray addObject: strTwo];
            NSString *strThree = [NSString stringWithFormat:@"%@",cityArray[i][@"tem1"]];
            strThree = [strThree stringByReplacingOccurrencesOfString:@"℃" withString:@""];
            [_weekHighTemArray addObject: strThree];
            NSString *strFour = [NSString stringWithFormat:@"%@",cityArray[i][@"tem2"]];
            strFour = [strFour stringByReplacingOccurrencesOfString:@"℃" withString:@""];
            [_weekLowTemArray addObject: strFour];
        }
        [_allArray addObject:_selectedCityName];
        [_allArray addObject:_temStr];
        [_allArray addObject:_weaStr];
        [_allArray addObject:_weekStr];
        [_allArray addObject:_highTemStr];
        [_allArray addObject:_lowTemStr];
        [_allArray addObject:_sunriseStr];
        [_allArray addObject:_sunsetStr];
        [_allArray addObject:_humidityStr];
        [_allArray addObject:_airlevelStr];
        [_allArray addObject:_visibilityStr];
        [_allArray addObject:_pressureStr];
        [_allArray addObject:_sugesstionStr];
        [_allArray addObject:_timeArray];
        [_allArray addObject:_weatherImgArray];
        [_allArray addObject:_temArray];
        [_allArray addObject:_weekArray];
        [_allArray addObject:_weekWeatherImgArray];
        [_allArray addObject:_weekHighTemArray];
        [_allArray addObject:_weekLowTemArray];
        
        
        [self creatGroupOne];
        [self creatTableView];
    } else {
        NSLog(@"error = %@", error);
    }
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self->_selectedCityTableView reloadData];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        UITableViewCell *selectedCell = [_selectedCityTableView dequeueReusableCellWithIdentifier:@"selected" forIndexPath:indexPath];
        selectedCell.backgroundColor = [UIColor clearColor];
        selectedCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [selectedCell.contentView addSubview:_titleLabel];
        [selectedCell.contentView addSubview:_smallTitleLabel];
        [selectedCell.contentView addSubview:_temTitleLabel];
        [selectedCell.contentView addSubview:_weekTitleLabel];
        [selectedCell.contentView addSubview:_todayTitleLabel];
        [selectedCell.contentView addSubview:_highTemTitleLabel];
        [selectedCell.contentView addSubview:_lowTemTitleLabel];
        
        return selectedCell;
    } else if (indexPath.row == 1) {
        SelectedTwoTableViewCell* selectedTwoCell = [_selectedCityTableView dequeueReusableCellWithIdentifier:@"two" forIndexPath:indexPath];
        for (int i = 0; i < _timeArray.count; i ++) {
            UILabel* topTimeLabel = [[UILabel alloc] init];
            topTimeLabel.text = _timeArray[i];
            topTimeLabel.textColor = [UIColor whiteColor];
            topTimeLabel.textAlignment = NSTextAlignmentCenter;
            topTimeLabel.frame = CGRectMake(10 * (i + 1) + [UIScreen mainScreen].bounds.size.width * 2 / _timeArray.count * i, 8, ([UIScreen mainScreen].bounds.size.width * 2 - 10 * _timeArray.count) / _timeArray.count, 30);
            [selectedTwoCell.selectedScrollView addSubview:topTimeLabel];
            
            UIImageView* midImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",_weatherImgArray[i]]]];
            midImageView.frame = CGRectMake(20 * (i + 1) + ([UIScreen mainScreen].bounds.size.width * 2 / _timeArray.count - 10) * i, 60, ([UIScreen mainScreen].bounds.size.width * 2 - 10 * _timeArray.count) / _timeArray.count - 20, 30);
            [selectedTwoCell.selectedScrollView addSubview:midImageView];
            
            UILabel* botTemLabel = [[UILabel alloc] init];
            botTemLabel.text = _temArray[i];
            botTemLabel.font = [UIFont systemFontOfSize:22];
            botTemLabel.textColor = [UIColor whiteColor];
            botTemLabel.textAlignment = NSTextAlignmentCenter;
            botTemLabel.frame = CGRectMake(10 * (i + 1) + [UIScreen mainScreen].bounds.size.width * 2 / _timeArray.count * i, 110, ([UIScreen mainScreen].bounds.size.width * 2 - 10 * _timeArray.count) / _timeArray.count, 30);
            [selectedTwoCell.selectedScrollView addSubview:botTemLabel];
        }
        return selectedTwoCell;
    } else if (indexPath.row == 2) {
        UITableViewCell* selectedThreeCell = [_selectedCityTableView dequeueReusableCellWithIdentifier:@"three" forIndexPath:indexPath];
        selectedThreeCell.backgroundColor = [UIColor clearColor];
        selectedThreeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        for (int i = 0; i < _weekArray.count; i++) {
            UILabel* weekLabel = [[UILabel alloc] init];
            weekLabel.text = _weekArray[i];
            weekLabel.font = [UIFont systemFontOfSize:24];
            weekLabel.textColor = [UIColor whiteColor];
            weekLabel.frame = CGRectMake(25, 5 + 45 * i, 100, 45);
            [selectedThreeCell.contentView addSubview:weekLabel];
            
            UILabel* weekHighTemLabel = [[UILabel alloc] init];
            weekHighTemLabel.text = _weekHighTemArray[i];
            weekHighTemLabel.font = [UIFont systemFontOfSize:23];
            weekHighTemLabel.textColor = [UIColor whiteColor];
            weekHighTemLabel.frame = CGRectMake(315, 10 + 45 * i, 40, 45);
            [selectedThreeCell.contentView addSubview:weekHighTemLabel];
            
            UILabel* weekLowTemLabel = [[UILabel alloc] init];
            weekLowTemLabel.text = _weekLowTemArray[i];
            weekLowTemLabel.font = [UIFont systemFontOfSize:23];
            weekLowTemLabel.textColor = [UIColor lightGrayColor];
            weekLowTemLabel.frame = CGRectMake(370, 10 + 45 * i, 40, 45);
            [selectedThreeCell.contentView addSubview:weekLowTemLabel];
            
            UIImageView* weekImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",_weekWeatherImgArray[i]]]];
            weekImageView.frame = CGRectMake(190, 15 + 45 * i, 33, 24);
            [selectedThreeCell.contentView addSubview:weekImageView];
        }
            return selectedThreeCell;
        } else if (indexPath.row == 3) {
            SelectedFourTableViewCell* selectedFourCell = [_selectedCityTableView dequeueReusableCellWithIdentifier:@"four" forIndexPath:indexPath];
            selectedFourCell.selectionStyle = UITableViewCellSelectionStyleNone;
            selectedFourCell.suggestionLabel.text = _sugesstionStr;
            return selectedFourCell;
        } else if (indexPath.row == 4) {
            SelectedFiveTableViewCell* selectedFiveCell = [_selectedCityTableView dequeueReusableCellWithIdentifier:@"five" forIndexPath:indexPath];
            selectedFiveCell.backgroundColor = [UIColor clearColor];
            selectedFiveCell.selectionStyle = UITableViewCellSelectionStyleNone;
            selectedFiveCell.sunriseTimeLabel.text = _sunriseStr;
            selectedFiveCell.sundownTimeLabel.text = _sunsetStr;
            selectedFiveCell.sunriseLabel.text = @"日出";
            selectedFiveCell.sundownLabel.text = @"日落";
            return selectedFiveCell;
        } else if (indexPath.row == 5) {
            SelectedFiveTableViewCell* selectedSixCell = [_selectedCityTableView dequeueReusableCellWithIdentifier:@"five" forIndexPath:indexPath];
            selectedSixCell.backgroundColor = [UIColor clearColor];
            selectedSixCell.selectionStyle = UITableViewCellSelectionStyleNone;
            selectedSixCell.sunriseTimeLabel.text = _humidityStr;
            selectedSixCell.sundownTimeLabel.text = _airlevelStr;
            selectedSixCell.sunriseLabel.text = @"湿度";
            selectedSixCell.sundownLabel.text = @"空气质量";
            return selectedSixCell;
        } else {
            SelectedFiveTableViewCell* selectedSevenCell = [_selectedCityTableView dequeueReusableCellWithIdentifier:@"five" forIndexPath:indexPath];
            selectedSevenCell.backgroundColor = [UIColor clearColor];
            selectedSevenCell.selectionStyle = UITableViewCellSelectionStyleNone;
            selectedSevenCell.sunriseTimeLabel.text = _visibilityStr;
            selectedSevenCell.sundownTimeLabel.text = _pressureStr;
            selectedSevenCell.sunriseLabel.text = @"能见度";
            selectedSevenCell.sundownLabel.text = @"气压";
            return selectedSevenCell;
        }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 310;
    } else if (indexPath.row == 1) {
        return 160;
    } else if (indexPath.row == 2) {
        return 280;
    } else {
        return 95;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


@end
