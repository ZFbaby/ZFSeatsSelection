
![image](https://github.com/ZFbaby/ZFSeatsSelection/blob/master/ZFSeatsSelection/仿猫眼gif1.gif?raw=true)

## 功能简介 （Features）

* 座位落单判断（新增加功能）
*  （Single seat judgment）

*  影厅logo可根据座位图左右移动
*  （The auditorium can be moved according to the seat map about logo）

* 索引条可根据座位图上下移动跟随座位图放大缩小
* （Index bar can be moved up and down according to the seat map to enlarge and reduce the block bitmap）

*  中线随着座位图移动可实时跟进当前座位中间位置
*  （Median line with the seat map can be moved in real time to follow the current seat in the middle position）

* 下脚applogo可根据座位图上下拉 上下浮动效果兼跟座位图左右移动
* （Under the foot applogo can be based on the seat map under the floating effect with the seat map moving around）

*  左上角指示器可根据座位选座情况座位移动方法实时定位当前显示范围 
*  （The upper left angle indicator can locate the current display range in real time according to the seat seat selection situation.）

*  开场动画（座位图居中放大） 和 选座动画（指定放大到选中的位置）效果均与猫眼app效果一致
*  （Opening animation (seating chart centered amplification) and seat selection animation (designated magnification to the selected location) were with the app cat eye effect consistent）

*  适配各屏幕大小，可随意设置你的座位图的宽高
*  （Fit the size of the screen, you can set the width of your seat map）

## 前言（Preface）

高仿猫眼app选座（选票）模块
之前对这些模块做了初步了解没找到合适的开源框架，有一些都是简单的小demo更没有任何效果，代码也是惨不忍睹看的一头雾水，索性就自己捣鼓着造一个车轮😄，最终花了五天时间基本上搞定了，这种模块用的比较少，目前代码结构也已经比较清晰就凑合着用吧，😄，觉得好就给star✨

(High imitation （mao yan） app seat selection (vote) module
Before on these modules do the preliminary understanding did not find a suitable open source framework, some are simple little demo and no any effect, code is horrible to see befuddled, simply to fiddle with a made a wheels and eventually spent five days basically done, this to the drawing way build the module packaging framework, due to its own independent development, time is limited, once again set out to new projects this forget about it, this module is used less, the code structure has also been relatively clear is used to improvise, feel good to star
)


## 项目开始前看这里（Look here before the project starts）

默认是按照猫眼的数据结构来做的，如果你的数据结构跟demo中数据不一样，自己研究下参数结构，基本上大同小异，demo默认已经将数据转为模型，所以也默认是按有模型的方法来做，你所要做的就是更改项目中需要替换你模型数据的一些结构，初始化座位图必须跟随设置你的frame！

（Default is done according to the data structure of the (mao yan), if your data structure and demo data are not the same, their study parameter structure, basically similar, demo default has the data model, so the default is on the model, all you have to do is change the project need to replace some of the structure of your model data, initialization seating charts must follow set your frame.）


