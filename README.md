# Starry-sky-II

![image 1](/image/image.png)

学了点新东西,把之前乱七八糟的代码重写,重点加注释

异域星空：无限火力 II（调试版本）

本版本用于 调试与展示，增加了游戏进程速度，线性增长间隔为半分钟


调试版：

1.增加能量系统每次获取能量的数量，减少能量系统每次的消耗，增长了开启护盾时间，使调试版hero大部分时间可以处于无敌状态，便于展示和提高测试速度

2.提升了子弹速度

3.游戏事件触发间隔改为半分钟

4.降低boss血量 提升过关速度便于展示


游戏版本 重构0.1

1.关闭震动效果

2.暂时取消了技能系统

3.增加了第一关得分统计 和 等级评定

4.增加无尽关卡

5.修复重复爆炸bug

6.解决游戏对象过多时卡顿现象

7.删除调试控制台

8.增加了导弹（未加入武器系统，暂定需要加入跟踪效果）

9.调整了文件目录文件关系优化代码


文件树

starry—sky II

／build        JS生成文件存放

／data         为下次重写准备

／image        图片文件夹

    ／bullet   子弹

    ／lv2      无尽模式 敌机图片

／js           coffee文件夹

／music        音乐文件夹

／node_modules 依赖文件

.gitgnore      git设置

game0.1.html   游戏文件

gulpfile.js    gulp配置

package.json    配置信息


游戏

w a s d 控制移动 鼠标准星控制方向

r 键开启武器系统  武器系统依赖宝石  开启武器 需要对应宝石

鼠标左键射击  右键暂停，再次点击恢复

能量系统 需要击毁敌机获得 击毁敌机得到破碎粒子 粒子上升消失候能量＋1

增加的能量值会体现在右下角的能量盘，能量会循环减少，碰撞会大量减少能量值

能量系统可以激活护盾 护盾状态 hero无敌

敌机爆炸 可获得随机宝石 宝石可以激活武器

游戏计时激活时间 调试版为半分钟

第一次 警告 激活火球事件 火球只能躲避不可击毁

第二次 危险 boss出现  boss 3种子弹 和激光 （激光是唬人的）

第三次 为进入无尽模式 切换敌机 随机加速敌机

第四次 改变敌机样式，增加敌机速度，数量，随机加速量增加

第五次 敌机样式多样话。。

无尽模式不会结束 直到你死亡
