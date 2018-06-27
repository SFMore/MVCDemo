//
//  TWApiProxy.h
//  TWNetworking
//
//  Created by zsf on 2018/6/20.
//  Copyright © 2018年 zsf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// 请求成功的Block
typedef void(^TWHttpRequestSuccess)(id responseObject);

/// 请求失败的Block
typedef void(^TWHttpRequestFailure)(NSError *error);

/// 上传或下载进度
typedef void (^TWHttpProgress)(NSProgress *progress);

//请求方式
typedef NS_ENUM(NSUInteger, TWHttpRequestMethod) {
    /// GET请求
    TWHttpRequestMethodGet,
    /// POST请求
    TWHttpRequestMethodPost
};

//请求数据格式
typedef NS_ENUM(NSUInteger, TWRequestSerializer) {
    /// 设置请求数据为JSON格式
    TWRequestSerializerJSON,
    /// 设置请求数据为二进制格式
    TWRequestSerializerHTTP,
};

//响应数据格式
typedef NS_ENUM(NSUInteger, TWResponseSerializer) {
    /// 设置响应数据为JSON格式
    TWResponseSerializerJSON,
    /// 设置响应数据为二进制格式
    TWResponseSerializerHTTP,
};


@interface TWApiProxy : NSObject

/**
 判断是否有网络
 
 @return 有网YES, 无网:NO
 */
+ (BOOL)isNetwork;


/**
 判断是否是手机网络
 
 @return 手机网络:YES, 反之:NO
 */
+ (BOOL)isWWANNetwork;


/**
 判断是否是WiFi网络
 
 @return WiFi网络:YES, 反之:NO
 */
+ (BOOL)isWiFiNetwork;


/**
 全局请求单例

 @return 返回请求发起对象
 */
+ (instancetype)sharedInstance;

/**
 GET&POST请求统一入口（[TWApiProxy sharedInstance] 发起请求）

 @param method 请求方式
 @param url 请求地址
 @param parameters 请求参数
 @param success 请求成功回调
 @param failure 请求失败回调
 @return 返回请求标识id，可根据标识id取消请求
 */
- (NSNumber *)sendRequestWithMethod:(TWHttpRequestMethod)method url:(NSString *)url parameters:(id)parameters success:(TWHttpRequestSuccess)success failure:(TWHttpRequestFailure)failure;


/**
 上传文件

 @param url 请求地址
 @param parameters 请求参数
 @param name 文件对应服务器上的字段
 @param filePath 文件本地的沙盒路径
 @param progress 上传进度信息
 @param success 请求成功回调
 @param failure 请求失败回调
 @return 返回请求标识id，可根据标识id取消请求
 */
- (NSNumber *)uploadFileWithUrl:(NSString *)url
                     parameters:(id)parameters
                           name:(NSString *)name
                       filePath:(NSString *)filePath
                       progress:(TWHttpProgress)progress
                        success:(TWHttpRequestSuccess)success
                        failure:(TWHttpRequestFailure)failure;


/**
 上传多图

 @param url 请求地址
 @param parameters 请求参数
 @param name 图片对应服务器上的字段
 @param images 图片数组
 @param fileNames 图片文件名数组, 可以为nil, 数组内的文件名默认为当前日期时间"yyyyMMddHHmmss"
 @param imageScale 图片文件压缩比 范围 (0.f ~ 1.f)
 @param imageType 图片文件的类型,例:png、jpg(默认类型)....
 @param progress 上传进度信息
 @param success 请求成功的回调
 @param failure 请求失败的回调
 @return 返回请求标识id，可根据标识id取消请求
 */
- (NSNumber *)uploadImagesWithUrl:(NSString *)url
                       parameters:(id)parameters
                             name:(NSString *)name
                           images:(NSArray<UIImage *> *)images
                        fileNames:(NSArray<NSString *> *)fileNames
                       imageScale:(CGFloat)imageScale
                        imageType:(NSString *)imageType
                         progress:(TWHttpProgress)progress
                          success:(TWHttpRequestSuccess)success
                          failure:(TWHttpRequestFailure)failure;


/**
 设置请求超时时间:默认为30S

 @param time 时长
 */
- (void)setRequestTimeoutInterval:(NSTimeInterval)time;


/**
 设置请求头

 @param value 值
 @param field 键
 */
- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;


/**
 设置网络请求参数的格式:默认为JSON格式

 @param requestSerializer TWRequestSerializerJSON(JSON格式)，TWRequestSerializerHTTP(二进制格式)
 */
- (void)setRequestSerializer:(TWRequestSerializer)requestSerializer;


/**
 设置服务器响应数据格式:默认为JSON格式

 @param responseSerializer TWResponseSerializerJSON(JSON格式)，TWResponseSerializerHTTP(二进制格式)
 */
- (void)setResponseSerializer:(TWResponseSerializer)responseSerializer;


/**
 配置自建证书的Https请求, 参考链接: http://blog.csdn.net/syg90178aw/article/details/52839103

 @param cerPath 自建Https证书的路径
 @param validatesDomainName 是否需要验证域名，默认为YES. 如果证书的域名与请求的域名不一致，需设置为NO; 即服务器使用其他可信任机构颁发
 的证书，也可以建立连接, 主要用于这种情况:客户端请求的是子域名, 而证书上的是另外一个域名。因为SSL证书上的域名是独立的,假如证书上注册的域名是www.google.com, 那么mail.google.com是无法验证通过的.
 */
- (void)setSecurityPolicyWithCerPath:(NSString *)cerPath validatesDomainName:(BOOL)validatesDomainName;

@end
