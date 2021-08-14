//
//  AddViewController.m
//  6.天气预报
//
//  Created by mac on 2021/8/9.
//  Copyright © 2021 mac. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加毛玻璃
    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView * effe = [[UIVisualEffectView alloc]initWithEffect:blur];
    effe.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:effe];
    
    [self creatTips];
    [self creatTableView];
}

- (void)creatTips {
    UIImageView* backgroundImageView = [[UIImageView alloc] init];
    backgroundImageView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    backgroundImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 120);
    [self.view addSubview:backgroundImageView];
    
    UILabel* tipLabel = [[UILabel alloc] init];
    tipLabel.text = @"输入城市、邮政编码或机场位置";
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.frame = CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, 30);
    [self.view addSubview:tipLabel];
    
    UILabel* backgroundLabel = [[UILabel alloc] init];
    backgroundLabel.backgroundColor = [UIColor colorWithWhite:0.47 alpha:0.5];
    backgroundLabel.frame = CGRectMake(25, 60, 320, 47);
    [backgroundLabel.layer setMasksToBounds:YES];
    [backgroundLabel.layer setCornerRadius:12.0];
    [self.view addSubview:backgroundLabel];
    
    UIImageView* searchImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"soushuo1.png"]];
    searchImageView.frame = CGRectMake(10, 8, 27, 27);
    [backgroundLabel addSubview:searchImageView];
    
    _addTextfield = [[UITextField alloc] init];
    UIColor *color = [UIColor lightGrayColor];
    _addTextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索" attributes:@{NSForegroundColorAttributeName: color}];
    _addTextfield.textColor = [UIColor whiteColor];
    _addTextfield.font = [UIFont systemFontOfSize:21];
    _addTextfield.clearButtonMode = UITextFieldViewModeAlways;
    _addTextfield.keyboardType = UIKeyboardTypeDefault;
    _addTextfield.frame = CGRectMake(71, 65, 266, 38);
    _addTextfield.delegate = self;
    [self.view addSubview:_addTextfield];
    
    UIButton* cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelButton.frame = CGRectMake(353, 65, 50, 40);
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:21];
    [cancelButton addTarget:self action:@selector(pressCancelButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
}

- (void)pressCancelButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_addTextfield resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_addTextfield endEditing:YES];
}

- (void)creatTableView {
    
    _cityTableView = [[UITableView alloc] initWithFrame:CGRectMake(50, 120, [UIScreen mainScreen].bounds.size.width - 120, 650) style:UITableViewStylePlain];
    _cityTableView.separatorStyle = UITableViewCellAccessoryNone;
    _cityTableView.showsVerticalScrollIndicator = NO;
    _cityTableView.delegate = self;
    _cityTableView.dataSource = self;
    _cityTableView.backgroundColor = [UIColor clearColor];
    [_cityTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"city"];
    [self.view addSubview:_cityTableView];
}

- (void)creatUrl {
    //1.创建请求地址
    NSString *urlString = [NSString stringWithFormat:@"https://geoapi.heweather.net/v2/city/lookup?location=%@&key=b92646e0f4194731b50870798cfad1d0", _addTextfield.text];
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
        NSMutableArray *timeArray = [[NSMutableArray alloc] init];
        timeArray = secondDictionary[@"location"];
        for (int i = 0; i < timeArray.count; i++) {
            NSMutableString *str = [NSMutableString stringWithFormat:@"%@-%@市-%@",timeArray[i][@"adm1"],timeArray[i][@"adm2"], timeArray[i][@"name"]];
            [_cityArray addObject:str];
        }
        for (int i = 0; i < _cityArray.count; i++) {
            NSLog(@"%@", _cityArray[i]);
        }
    } else {
        NSLog(@"error = %@", error);
    }
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self->_cityTableView reloadData];
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [_cityTableView dequeueReusableCellWithIdentifier:@"city" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    while ([cell.contentView.subviews lastObject] != nil) {
        [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
    }
    cell.textLabel.text = _cityArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:21];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cityArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self creatUrl];
    _cityArray = [[NSMutableArray alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *string = _cityArray[indexPath.row];
    NSArray *array = [string componentsSeparatedByString:@"市-"];
    _cityName = array[1];
    SelectedViewController* selectedViewController = [[SelectedViewController alloc] init];
    selectedViewController.selectedCityName = _cityName;
    selectedViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [selectedViewController.presentingViewController dismissViewControllerAnimated:NO completion:nil];
    selectedViewController.mainCityArray = _mainCityArray;
    [self presentViewController:selectedViewController animated:YES completion:nil];
}
@end
