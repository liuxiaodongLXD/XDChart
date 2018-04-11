//
//  MainController.m
//  XDChartDemo
//
//  Created by apple on 2018/4/11.
//  Copyright © 2018年 lxd. All rights reserved.
//

#import "MainController.h"
#import "Test1ViewController.h"
#import "Test2ViewController.h"
#import "Test3ViewController.h"
#import "Test4ViewController.h"
#import "Test5ViewController.h"
#import "Test6ViewController.h"
#import "Test7ViewController.h"

@interface MainController ()
@property (nonatomic, strong) NSArray *textArray;
@end

@implementation MainController
- (NSArray *)textArray{
    if(!_textArray){
        _textArray = @[@"柱状折线上下限",@"单组柱状",@"多组柱状",@"折线图",@"柱状和折线",@"折线和上下限",@"正态分布图"];
    }
    return _textArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"示例";
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.textArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.textArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            Test1ViewController *test1 = [[Test1ViewController alloc] init];
            test1.navigationItem.title = self.textArray[indexPath.row];
            [self.navigationController pushViewController:test1 animated:YES];
        }
            break;
        case 1:{
            Test2ViewController *test2 = [[Test2ViewController alloc] init];
            test2.navigationItem.title = self.textArray[indexPath.row];
            [self.navigationController pushViewController:test2 animated:YES];
        }
            break;
        case 2:{
            Test3ViewController *test3 = [[Test3ViewController alloc] init];
            test3.navigationItem.title = self.textArray[indexPath.row];
            [self.navigationController pushViewController:test3 animated:YES];
        }
            break;
        case 3:{
            Test4ViewController *test4 = [[Test4ViewController alloc] init];
            test4.navigationItem.title = self.textArray[indexPath.row];
            [self.navigationController pushViewController:test4 animated:YES];
        }
            break;
        case 4:{
            Test5ViewController *test5 = [[Test5ViewController alloc] init];
            test5.navigationItem.title = self.textArray[indexPath.row];
            [self.navigationController pushViewController:test5 animated:YES];
        }
            break;
        case 5:{
            Test6ViewController *test6 = [[Test6ViewController alloc] init];
            test6.navigationItem.title = self.textArray[indexPath.row];
            [self.navigationController pushViewController:test6 animated:YES];
        }
            break;
        case 6:{
            Test7ViewController *test7 = [[Test7ViewController alloc] init];
            test7.navigationItem.title = self.textArray[indexPath.row];
            [self.navigationController pushViewController:test7 animated:YES];
        }
            break;
        default:
            break;
    }
}
@end
