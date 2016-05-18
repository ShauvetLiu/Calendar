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

###关于UICollectionView的疑问
1.在UICollectionViewFlowLayout中设置cell边距为0，cell的宽和高都为屏幕的宽度/7，会导致在cell之间的某些位置出现小的缝隙。

2.在纵向的边界线也会出现，暂时的推断是retina屏幕的尺寸除以7会导致浮点数的产生，而累加到一定程度的时候会产生较大的误差，但是layout还是让cell之间间隔为0，这一问题仍需探究。

3.cell的边框，也就是cell的contentView的图层的边框是向内延伸的，不能从边框的宽度的角度，来混弄过关😳。

###最近更新
####2016-05-18
1.更新ELCalendarEngine日历引擎类，使得日历来回之间的切换更加人性化😜
2.上次提到的cell之间的边距问题，目前还没有更好的解决，一直在忙，不过样式得不到领导的认可，产品将边框改为无边框，选中为圆圈状态。还是蛮好的。
3.对于来回之间切换的思考，做完熬到很晚，甚至于已经影响心情，不过今天一早过来，几下子就实现了，并且自己跑起来感觉还是可以的，
·所以适当的休息很重要，没什么事是一个好觉不能解决的😄
