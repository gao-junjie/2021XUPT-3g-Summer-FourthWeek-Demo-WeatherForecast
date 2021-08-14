//
//  MainViewController.m
//  6.天气预报
//
//  Created by mac on 2021/8/9.
//  Copyright © 2021 mac. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    UIImageView* mainBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weatherBackground0.jpg"]];
    mainBackground.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
    [self.view addSubview:mainBackground];
    
    _bigAllArray = [[NSMutableArray alloc] init];
    _allArray = [[NSMutableArray alloc] init];
    _cityNameArray = [[NSMutableArray alloc] init];
    _timeArray = [[NSMutableArray alloc] init];
    _weatherImgArray = [[NSMutableArray alloc] init];
    _temArray = [[NSMutableArray alloc] init];
    _weekArray = [[NSMutableArray alloc] init];
    _weekWeatherImgArray = [[NSMutableArray alloc] init];
    _weekHighTemArray = [[NSMutableArray alloc] init];
    _weekLowTemArray = [[NSMutableArray alloc] init];
    _cityNameArray = [NSMutableArray arrayWithObject:@"西安"];
    //[self creatTableView];
    [self creatUrl];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:)name:@"tongzhi" object:nil];
}

- (void)creatTableView {
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, ([UIScreen mainScreen].bounds.size.height - 114) / 8.0 * _cityNameArray.count  + 60) style:UITableViewStylePlain];
    _mainTableView.separatorStyle = UITableViewCellAccessoryNone;
    _mainTableView.backgroundColor = [UIColor blackColor];
    _mainTableView.showsVerticalScrollIndicator = NO;
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    [_mainTableView registerClass:[MainTableViewCell class] forCellReuseIdentifier:@"main"];
    [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"normal"];
    [self.view addSubview:_mainTableView];
}

- (void)creatUrl {
    //1.创建请求地址
    NSString *urlString = [NSString stringWithFormat:@"https://tianqiapi.com/api?version=v1&appid=83517518&appsecret=CUPEH1f7&city=%@", _cityNameArray[0]];
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
        [_allArray addObject:_cityNameArray[0]];
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
        
        [_bigAllArray addObject:_allArray];
        [self creatTableView];
    } else {
        NSLog(@"error = %@", error);
    }
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self->_mainTableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cityNameArray.count + 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    int number = (int)_cityNameArray.count;
    if (indexPath.row < number) {
        CGFloat totalHeight = ([UIScreen mainScreen].bounds.size.height - 114) / 8.0;
        return totalHeight;
    } else {
        return 60;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < _cityNameArray.count) {
        MainTableViewCell* mainCell = [_mainTableView dequeueReusableCellWithIdentifier:@"main" forIndexPath:indexPath];
        mainCell.titleLabel.text = _cityNameArray[indexPath.row];
        mainCell.mainImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"weatherBackground%ld.jpg", indexPath.row + 1]];
        mainCell.backgroundColor = [UIColor clearColor];
        if (indexPath.row == 0) {
            UILabel *nowLabel = [[UILabel alloc] init];
            nowLabel.font = [UIFont systemFontOfSize:23];
            nowLabel.textColor = [UIColor colorWithWhite:0.8 alpha:1];
            nowLabel.text = @"（当前位置）";
            nowLabel.frame = CGRectMake(145, 5, 155, 50);
            [mainCell.contentView addSubview:nowLabel];
        }
        return mainCell;
    } else {
        UITableViewCell* normalCell = [_mainTableView dequeueReusableCellWithIdentifier:@"normal" forIndexPath:indexPath];
        normalCell.backgroundColor = [UIColor blackColor];
        normalCell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIButton* addButton = [UIButton buttonWithType: UIButtonTypeCustom];
        [addButton setImage:[UIImage imageNamed:@"add1.png"] forState:UIControlStateNormal];
        addButton.frame = CGRectMake(350, 15, 33, 33);
        [addButton addTarget:self action:@selector(pressAddButton) forControlEvents:UIControlEventTouchUpInside];
        [normalCell.contentView addSubview:addButton];
        return normalCell;
    }
}

- (void)pressAddButton {
    AddViewController* addViewController = [[AddViewController alloc] init];
    addViewController.mainCityArray = _cityNameArray;
    [self presentViewController:addViewController animated:YES completion:nil];
}

- (void)tongzhi:(NSNotification *)text {
    [_cityNameArray addObject:text.userInfo[@"cityname"]];
    [_bigAllArray addObject:text.object];
    _mainTableView.frame = CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, ([UIScreen mainScreen].bounds.size.height - 114) / 8.0 * _cityNameArray.count  + 60);
    [_mainTableView reloadData];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"tongzhi" object:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _cityNameArray.count) {
        
    }
    else {
        AllViewController* allViewController = [[AllViewController alloc] init];
        allViewController.allArray = _bigAllArray;
        allViewController.selectedCity = (int)indexPath.row;
        allViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:allViewController animated:YES completion:nil];
    }
}
@end
