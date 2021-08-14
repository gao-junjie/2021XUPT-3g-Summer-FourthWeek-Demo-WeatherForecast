//
//  AllViewController.m
//  6.天气预报
//
//  Created by mac on 2021/8/10.
//  Copyright © 2021 mac. All rights reserved.
//

#import "AllViewController.h"

@interface AllViewController ()

@end

@implementation AllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView* backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selectedBackground.jpg"]];
    backgroundImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:backgroundImageView];
    
    UIButton* outButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [outButton setImage:[UIImage imageNamed:@"duoxiang.png"] forState:UIControlStateNormal];
    outButton.frame = CGRectMake(350, 850, 30, 20);
    [outButton addTarget:self action:@selector(pressOutButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:outButton];
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(120, 835, 180, 50)];
    _pageControl.numberOfPages = _allArray.count;
    _pageControl.currentPage = _selectedCity;
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self.view addSubview:_pageControl];
    
    _allScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 55)];
    _allScrollView.backgroundColor = [UIColor clearColor];
    _allScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * _allArray.count, [UIScreen mainScreen].bounds.size.height - 55);
    _allScrollView.pagingEnabled = YES;
    _allScrollView.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width * _selectedCity, 0);
    _allScrollView.bounces = NO;
    _allScrollView.showsHorizontalScrollIndicator = NO;
    _allScrollView.tag = 999;
    [self.view addSubview:_allScrollView];
    _allScrollView.delegate = self;
    [self creatTableView];
}

- (void)creatTableView {
    for (int i = 0; i < _allArray.count; i++) {
        UITableView* allTableView = [[UITableView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * i, 60, [UIScreen mainScreen].bounds.size.width, 780) style:UITableViewStylePlain];
        allTableView.showsVerticalScrollIndicator = NO;
        allTableView.separatorColor = [UIColor whiteColor];
        allTableView.delegate = self;
        allTableView.dataSource = self;
        allTableView.backgroundColor = [UIColor clearColor];
        [allTableView registerClass:[SelectedTableViewCell class] forCellReuseIdentifier:@"selected"];
        [allTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"three"];
        [allTableView registerClass:[SelectedTwoTableViewCell class] forCellReuseIdentifier:@"two"];
        [allTableView registerClass:[SelectedFourTableViewCell class] forCellReuseIdentifier:@"four"];
        [allTableView registerClass:[SelectedFiveTableViewCell class] forCellReuseIdentifier:@"five"];
        allTableView.tag = 333 + i;
        [_allScrollView addSubview:allTableView];
    }
}

- (void)pressOutButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    int temp = (int)tableView.tag - 333;
        if (indexPath.row == 0) {
            SelectedTableViewCell *selectedCell = [tableView dequeueReusableCellWithIdentifier:@"selected"];
            selectedCell.backgroundColor = [UIColor clearColor];
            selectedCell.selectionStyle = UITableViewCellSelectionStyleNone;
            selectedCell.titleLabel.text = _allArray[temp][0];
            selectedCell.temTitleLabel.text = _allArray[temp][1];
            selectedCell.smallTitleLabel.text = _allArray[temp][2];
            selectedCell.weekTitleLabel.text = _allArray[temp][3];
            selectedCell.lowTemTitleLabel.text = _allArray[temp][4];
            selectedCell.highTemTitleLabel.text = _allArray[temp][5];
            return selectedCell;
        } else if (indexPath.row == 1) {
            SelectedTwoTableViewCell* selectedTwoCell = [tableView dequeueReusableCellWithIdentifier:@"two"];
            for (int i = 0; i < 9; i++) {
                UILabel* topTimeLabel = [[UILabel alloc] init];
                topTimeLabel.text = _allArray[temp][13][i];
                topTimeLabel.textColor = [UIColor whiteColor];
                topTimeLabel.textAlignment = NSTextAlignmentCenter;
                topTimeLabel.frame = CGRectMake(10 * (i + 1) + [UIScreen mainScreen].bounds.size.width * 2 / 10 * i, 8, ([UIScreen mainScreen].bounds.size.width * 2 - 10 * 10) / 10, 30);
                [selectedTwoCell.selectedScrollView addSubview:topTimeLabel];
                
                UIImageView* midImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",_allArray[temp][14][i]]]];
                midImageView.frame = CGRectMake(20 * (i + 1) + ([UIScreen mainScreen].bounds.size.width * 2 / 10 - 10) * i, 60, ([UIScreen mainScreen].bounds.size.width * 2 - 10 * 10) / 10 - 20, 30);
                [selectedTwoCell.selectedScrollView addSubview:midImageView];
                
                UILabel* botTemLabel = [[UILabel alloc] init];
                botTemLabel.text = _allArray[temp][15][i];
                botTemLabel.font = [UIFont systemFontOfSize:22];
                botTemLabel.textColor = [UIColor whiteColor];
                botTemLabel.textAlignment = NSTextAlignmentCenter;
                botTemLabel.frame = CGRectMake(10 * (i + 1) + [UIScreen mainScreen].bounds.size.width * 2 / 10 * i, 110, ([UIScreen mainScreen].bounds.size.width * 2 - 10 * 10) / 10, 30);
                [selectedTwoCell.selectedScrollView addSubview:botTemLabel];
            }
            return selectedTwoCell;
        } else if (indexPath.row == 2) {
            UITableViewCell* selectedThreeCell = [tableView dequeueReusableCellWithIdentifier:@"three"];
            selectedThreeCell.backgroundColor = [UIColor clearColor];
            selectedThreeCell.selectionStyle = UITableViewCellSelectionStyleNone;
            for (int i = 0; i < 6; i++) {
                UILabel* weekLabel = [[UILabel alloc] init];
                weekLabel.text = _allArray[temp][16][i];
                weekLabel.font = [UIFont systemFontOfSize:24];
                weekLabel.textColor = [UIColor whiteColor];
                weekLabel.frame = CGRectMake(25, 5 + 45 * i, 100, 45);
                [selectedThreeCell.contentView addSubview:weekLabel];
                
                UILabel* weekHighTemLabel = [[UILabel alloc] init];
                weekHighTemLabel.text = _allArray[temp][18][i];
                weekHighTemLabel.font = [UIFont systemFontOfSize:23];
                weekHighTemLabel.textColor = [UIColor whiteColor];
                weekHighTemLabel.frame = CGRectMake(315, 10 + 45 * i, 40, 45);
                [selectedThreeCell.contentView addSubview:weekHighTemLabel];
                
                UILabel* weekLowTemLabel = [[UILabel alloc] init];
                weekLowTemLabel.text = _allArray[temp][19][i];
                weekLowTemLabel.font = [UIFont systemFontOfSize:23];
                weekLowTemLabel.textColor = [UIColor lightGrayColor];
                weekLowTemLabel.frame = CGRectMake(370, 10 + 45 * i, 40, 45);
                [selectedThreeCell.contentView addSubview:weekLowTemLabel];
                
            UIImageView* weekImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",_allArray[temp][17][i]]]];
            weekImageView.frame = CGRectMake(190, 15 + 45 * i, 33, 24);
            [selectedThreeCell.contentView addSubview:weekImageView];
        }
            return selectedThreeCell;
        } else if (indexPath.row == 3) {
            SelectedFourTableViewCell* selectedFourCell = [tableView dequeueReusableCellWithIdentifier:@"four"];
            selectedFourCell.selectionStyle = UITableViewCellSelectionStyleNone;
            selectedFourCell.suggestionLabel.text = _allArray[temp][12];
                return selectedFourCell;
        } else if (indexPath.row == 4) {
                SelectedFiveTableViewCell* selectedFiveCell = [tableView dequeueReusableCellWithIdentifier:@"five"];
            selectedFiveCell.backgroundColor = [UIColor clearColor];
            selectedFiveCell.selectionStyle = UITableViewCellSelectionStyleNone;
            selectedFiveCell.sunriseTimeLabel.text = _allArray[temp][6];
            selectedFiveCell.sundownTimeLabel.text = _allArray[temp][7];
            selectedFiveCell.sunriseLabel.text = @"日出";
            selectedFiveCell.sundownLabel.text = @"日落";
                return selectedFiveCell;
        } else if (indexPath.row == 5) {
            SelectedFiveTableViewCell* selectedSixCell = [tableView dequeueReusableCellWithIdentifier:@"five"];
            selectedSixCell.backgroundColor = [UIColor clearColor];
            selectedSixCell.selectionStyle = UITableViewCellSelectionStyleNone;
            selectedSixCell.sunriseTimeLabel.text = _allArray[temp][8];
            selectedSixCell.sundownTimeLabel.text = _allArray[temp][9];
            selectedSixCell.sunriseLabel.text = @"湿度";
            selectedSixCell.sundownLabel.text = @"空气质量";
                return selectedSixCell;
        } else {
            SelectedFiveTableViewCell* selectedSevenCell = [tableView dequeueReusableCellWithIdentifier:@"five"];
            selectedSevenCell.backgroundColor = [UIColor clearColor];
            selectedSevenCell.selectionStyle = UITableViewCellSelectionStyleNone;
            selectedSevenCell.sunriseTimeLabel.text = _allArray[temp][10];
            selectedSevenCell.sundownTimeLabel.text = _allArray[temp][11];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.tag == 999) {
        _nowPage = (_allScrollView.contentOffset.x + [UIScreen mainScreen].bounds.size.width * 0.5) / [UIScreen mainScreen].bounds.size.width;
        _pageControl.currentPage = _nowPage;
    }
}

@end
