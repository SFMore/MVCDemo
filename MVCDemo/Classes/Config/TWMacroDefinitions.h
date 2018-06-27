//
//  TWMacroDefinitions.h
//  MVCDemo
//
//  Created by zsf on 2018/6/22.
//  Copyright © 2018年 zsf. All rights reserved.
//

#ifndef TWMacroDefinitions_h
#define TWMacroDefinitions_h

#define TW_USE_CLEAR_BAR - (BOOL)useClearBar{return YES;}

#define kBINDVIEW(viewclass,frame)   \
-(void)loadView \
{\
self.view = [[viewclass alloc] initWithFrame:frame];\
}\
-(id)forwardingTargetForSelector:(SEL)aSelector\
{\
struct objc_method_description  omd = protocol_getMethodDescription(@protocol(viewclass), aSelector, NO, YES);\
if (omd.name != NULL)\
{\
return self.view;\
}\
return [super forwardingTargetForSelector:aSelector];\
}\


//屏幕尺寸
#define kScreen_width   [UIScreen mainScreen].bounds.size.width
#define kScreen_height [UIScreen mainScreen].bounds.size.height
#define kMainScreen_Bounds [[UIScreen mainScreen] bounds]

//色值
#define kRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define kRGB(r,g,b) kRGBA(r,g,b,1.0f)
#define kHEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]

//字体
#define kFont(x) ([UIFont systemFontOfSize:x])
#define kBoldFont(x) ([UIFont boldSystemFontOfSize:x])


//设置 view 圆角和边框
#define kViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define kViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

//适配iPhone X
#define kTopBarHeight (kScreen_height == 812.0 ? 88 : 64)
#define kBottomBarHeight (kScreen_height == 812.0 ? 49+34 : 49)
#define kSpaceToBottom (kScreen_height == 812.0 ? 34 : 0)

//弱引用
#define kWeakSelf(weakSelf)      __weak __typeof(&*self)    weakSelf  = self;
#define kStrongSelf(strongSelf)  __strong __typeof(&*self) strongSelf = weakSelf;

//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || [str isEqualToString: @"(null)"] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

//打印
#ifdef DEBUG
#define NSLog(format,...)  NSLog((@"[函数名:%s]\n" "[行号:%d]\n" format),__FUNCTION__,__LINE__,##__VA_ARGS__)
#else
#define NSLog(...)
#endif


#endif /* TWMacroDefinitions_h */
