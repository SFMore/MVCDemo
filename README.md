# MVCDemo
#### 主目录结构
```
--Features         //模块。包含各个模块的Model,View,Controller,Service
--Categories            //类目。包含各种类的分类
--Frameworks        //系统框架。包含导入的系统的框架
--Helpers           //帮助类。包含网络，数据库，归档，定位等操作类的封装和实现
--Utilites       //工具类，一些非对象的，而是类方法调用的类
--Vendors           //第三方库。部分需要修改或者不支持cocoapod的第三方的框架引入
--Config                //配置。包含宏定义文件，全局配置文件，全局常量文件，颜色配置文件
--Resources         //资源。包含plist,image,html,bundle，Localizable.strings等
--AppEntry          //程序入口。包含AppDelegate,main.c,info.plist
-MVCDemoTests
-MVCDemoUITests
-Products           // 系统自动生成的.app所在文件夹
-Pods                   // 采用 CocoaPods 管理的第三方库。
```

#### 模块目录结构
```
-- Features
---Base             //MVC的基类或者通用类
----Models      //数据模型
----Views       //视图
----Controllers //控制器
----Service     //具体业务模型
---Home
----Models
----Views
----Controllers
----Service
...
```
