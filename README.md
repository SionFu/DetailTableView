## DetailTableView
一个可以展开详细信息的tableview 消除了reloadData时候的跳动问题

这两行代码可以解决`tableview`刷新的时候跳动的问题
```
self.indexTable.estimatedSectionHeaderHeight = 0;
    self.indexTable.estimatedSectionFooterHeight = 0;
```

利用状态数组来确定每行cell的高度
更具行高返回是否显示detail信息
```
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([stateArray[indexPath.row] isEqualToString:@"1"]){
        //如果是展开状态
        return 218.0;
    }else{
        //如果是闭合，返回0
       return 100.0;
    }
}
```
