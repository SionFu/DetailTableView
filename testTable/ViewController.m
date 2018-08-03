//
//  ViewController.m
//  testTable
//
//  Created by Fu Sion on 2018/7/21.
//  Copyright © 2018年 Fu Sion. All rights reserved.
//

#import "ViewController.h"
#import "DemoTableViewCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray      *stateArray;
}
@property (weak, nonatomic) IBOutlet UITableView *indexTable;
@property (nonatomic, strong)UINib *nib;
@property (nonatomic, strong)NSIndexPath *lasterIndex;
@end

@implementation ViewController
- (IBAction)reloadBtnClick:(UIBarButtonItem *)sender {
    [self.indexTable reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"可以折叠tableview 刷新不闪动";
    stateArray = [NSMutableArray array];
    self.indexTable.estimatedRowHeight = 0;
    self.indexTable.estimatedSectionHeaderHeight = 0;
    self.indexTable.estimatedSectionFooterHeight = 0;
    
    for (int i = 0; i <88; i++)
    {
        [stateArray addObject:@"0"];
    }
    // Do any additional setup after loading the view, typically from a nib.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 88;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_nib == nil) {
        _nib = [UINib nibWithNibName:@"DemoTableViewCell" bundle:nil];
        [tableView registerNib:_nib forCellReuseIdentifier:@"DemoCell"];
    }
    DemoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DemoCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    cell.label.text = [NSString stringWithFormat:@"这是第%ld行",(long)indexPath.row];
    cell.detail.text = [NSString stringWithFormat:@"这是第%ld行细节部分",(long)indexPath.row];
    if ([stateArray[indexPath.row] isEqualToString:@"0"]) {
        cell.detail.hidden = YES;
    }else {
        [cell.detail setHidden:NO];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *cellArray = [NSMutableArray array];
    
    if (self.lasterIndex != nil&&self.lasterIndex != indexPath)
    {
        [cellArray addObject:self.lasterIndex];
        [stateArray replaceObjectAtIndex:self.lasterIndex.row withObject:@"0"];
    }
    self.lasterIndex = indexPath;
    
    //关闭的打开
    if ([stateArray[indexPath.row] isEqualToString:@"0"]) {
        [stateArray replaceObjectAtIndex:indexPath.row withObject:@"1"];
        
    }else {
        [stateArray replaceObjectAtIndex:indexPath.row withObject:@"0"];
    }
    [cellArray addObject:indexPath];
    [tableView reloadRowsAtIndexPaths:cellArray withRowAnimation:UITableViewRowAnimationFade];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([stateArray[indexPath.row] isEqualToString:@"1"]){
        //如果是展开状态
        //        NSArray *array = [self.dataSource objectAtIndex:section];
        return 218.0;
    }else{
        //如果是闭合，返回0
       return 100.0;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
