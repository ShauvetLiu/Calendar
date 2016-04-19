# Calendar
### 一个日历的demo，可以选择本月上月和下一月三个月（满足项目中的需求）。也可以支持全日历查看。
后面会指出全日历查看的方法。
还在学习markdown，稍后更新😄
## 各个类的用途
### ELCalendarView
是整个日历最底层的view，传入默认取当天的日期，通过代理回传点击事件，内部封装了上下月按钮，显示日历的主视图，实现为collectionview。

    ELCalendarView *calendar = [[ELCalendarView alloc]initWithFrame:CGRectMake(0, 100, DEVICE_SIZE.width, DEVICE_SIZE.width+30)];
    calendar.delegate = self;
    [calendar refreshUI];
    [self.view addSubview:calendar];

### ELCalendarCollectionView
日历主视图，通过collection view显示。
### ELCalendarEngine
相当于日历的大脑，所有关于日历计算的东西都在这里，通过_Engine_计算得出当前日历月份的第一天为周几等。
### ELCalendarModel
刷新日历cell用到的model，可以进行拓展，目前项目需求尚未明确，后台数据也没敲定，所以预留以后进行拓展和数据回传。
### ELCalendarCell
collectionview显示日历的cell。

