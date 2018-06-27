//
//  TWApiProxy.m
//  TWNetworking
//
//  Created by zsf on 2018/6/20.
//  Copyright © 2018年 zsf. All rights reserved.
//

#import "TWApiProxy.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworkActivityIndicatorManager.h>

#ifdef DEBUG
#define TWLog(...) printf("[%s] %s [第%d行]: %s\n", __TIME__ ,__PRETTY_FUNCTION__ ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define TWLog(...)
#endif


@interface TWApiProxy()

@property (nonatomic,strong) AFHTTPSessionManager *sessionManager;

@property (nonatomic,assign) TWHttpRequestMethod requestMethod;

@property (nonatomic,strong) NSMutableDictionary *allSessionTask;
@end


@implementation TWApiProxy

/**
 存储着所有的请求task数组
 */
- (NSMutableDictionary *)allSessionTask {
    if (!_allSessionTask) {
        _allSessionTask = [[NSMutableDictionary alloc] init];
    }
    return _allSessionTask;
}


#pragma mark - 初始化AFHTTPSessionManager相关属性
- (AFHTTPSessionManager *)sessionManager
{
    if (_sessionManager == nil) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
//        _sessionManager.securityPolicy.allowInvalidCertificates = YES;
//        _sessionManager.securityPolicy.validatesDomainName = NO;
        _sessionManager.requestSerializer.timeoutInterval = 30.f;
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
        
        // 打开状态栏的等待菊花
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    }
    return _sessionManager;
}


//开始监测网络状态
+ (void)load {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static TWApiProxy* instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[TWApiProxy alloc] init];
    });
    return instance;
}

#pragma mark - 取消网络请求
- (void)cancelRequestWithRequestID:(NSNumber *)requestID
{
    NSURLSessionDataTask *requestOperation = self.allSessionTask[requestID];
    [requestOperation cancel];
    [self.allSessionTask removeObjectForKey:requestID];
}

- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList
{
    for (NSNumber *requestId in requestIDList) {
        [self cancelRequestWithRequestID:requestId];
    }
}


#pragma mark - 网络请求统一入口
- (NSNumber *)sendRequestWithMethod:(TWHttpRequestMethod)method url:(NSString *)url parameters:(id)parameters success:(TWHttpRequestSuccess)success failure:(TWHttpRequestFailure)failure
{
    NSAssert(url != nil, @"URL不能为空");
    
    switch (method) {
            case TWHttpRequestMethodGet:
        {
           return [self getWithUrl:url parameters:parameters success:success failure:failure];
        }
            break;
            case TWHttpRequestMethodPost:
        {
           return  [self postWithUrl:url parameters:parameters success:success failure:failure];
        }
            break;
        default:
        {
            return  [self postWithUrl:url parameters:parameters success:success failure:failure];
        }
            break;
    }
}


#pragma mark - POST请求
- (NSNumber *)postWithUrl:(NSString *)url parameters:(id)parameters success:(TWHttpRequestSuccess)success failure:(TWHttpRequestFailure)failure
{
    __block  NSURLSessionTask *sessionTask = nil;
    sessionTask = [self.sessionManager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSNumber *requestID = @([sessionTask taskIdentifier]);
        [self.allSessionTask removeObjectForKey:requestID];
        
        success ? success(responseObject) : nil;
        
        TWLog(@"url = %@ \n paramters = %@ \n responseObject = %@",url,parameters ,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSNumber *requestID = @([sessionTask taskIdentifier]);
        [self.allSessionTask removeObjectForKey:requestID];
        
        failure ? failure(error) : nil;
        
        TWLog(@"url = %@ \n paramters = %@ \n error = %@",url,parameters,error);
    }];
    
    NSNumber *requestId = @([sessionTask taskIdentifier]);
    
    self.allSessionTask[requestId] = sessionTask;
    
    [sessionTask resume];
    
    return requestId;
}

#pragma mark - GET请求
- (NSNumber *)getWithUrl:(NSString *)url parameters:(id)parameters success:(TWHttpRequestSuccess)success failure:(TWHttpRequestFailure)failure
{
    __block NSURLSessionTask *sessionTask = nil;
    sessionTask = [self.sessionManager GET:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSNumber *requestID = @([sessionTask taskIdentifier]);
        [self.allSessionTask removeObjectForKey:requestID];
        
        success ? success(responseObject) : nil;
        
        TWLog(@"url = %@ \n paramters = %@ \n responseObject = %@",url,parameters,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSNumber *requestID = @([sessionTask taskIdentifier]);
        [self.allSessionTask removeObjectForKey:requestID];
        
        failure ? failure(error) : nil;
        
        TWLog(@"url = %@ \n paramters = %@ \n error = %@",url,parameters,error);
    }];
    
    NSNumber *requestId = @([sessionTask taskIdentifier]);
    
    self.allSessionTask[requestId] = sessionTask;
    
    [sessionTask resume];
    
    return requestId;
}

#pragma mark - 上传文件
- (NSNumber *)uploadFileWithUrl:(NSString *)url
                     parameters:(id)parameters
                           name:(NSString *)name
                       filePath:(NSString *)filePath
                       progress:(TWHttpProgress)progress
                        success:(TWHttpRequestSuccess)success
                        failure:(TWHttpRequestFailure)failure
{
    __block NSURLSessionTask *sessionTask = nil;
    sessionTask = [self.sessionManager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSNumber *requestID = @([sessionTask taskIdentifier]);
        [self.allSessionTask removeObjectForKey:requestID];
        
         success ? success(responseObject) : nil;
        
         TWLog(@"url = %@ \n paramters = %@ \n responseObject = %@",url,parameters,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSNumber *requestID = @([sessionTask taskIdentifier]);
        [self.allSessionTask removeObjectForKey:requestID];
        
         failure ? failure(error) : nil;
        
         TWLog(@"url = %@ \n paramters = %@ \n error = %@",url,parameters,error);
    }];
    
    NSNumber *requestId = @([sessionTask taskIdentifier]);
    
    self.allSessionTask[requestId] = sessionTask;
    
    [sessionTask resume];
    
    return requestId;
}

#pragma mark - 上传多张图片
- (NSNumber *)uploadImagesWithUrl:(NSString *)url
                               parameters:(id)parameters
                                     name:(NSString *)name
                                   images:(NSArray<UIImage *> *)images
                                fileNames:(NSArray<NSString *> *)fileNames
                               imageScale:(CGFloat)imageScale
                                imageType:(NSString *)imageType
                                 progress:(TWHttpProgress)progress
                                  success:(TWHttpRequestSuccess)success
                                  failure:(TWHttpRequestFailure)failure
{
    __block NSURLSessionTask *sessionTask = nil;
    sessionTask = [self.sessionManager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (NSInteger i = 0; i < images.count; i++) {
            //压缩
            NSData *imageData = UIImageJPEGRepresentation(images[i], imageScale?:1.f);
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *imageFileName = [NSString stringWithFormat:@"%@_%ld.%@",str,i,imageType?:@"jpg"];
            
            [formData appendPartWithFileData:imageData
                                        name:name
                                    fileName:fileNames ? [NSString stringWithFormat:@"%@.%@",fileNames[i],imageType?:@"jpg"]:imageFileName
                                    mimeType:[NSString stringWithFormat:@"image/%@",imageType ?: @"jpg"]];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSNumber *requestID = @([sessionTask taskIdentifier]);
        [self.allSessionTask removeObjectForKey:requestID];
        
        success ? success(responseObject) : nil;
        
        TWLog(@"responseObject = %@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSNumber *requestID = @([sessionTask taskIdentifier]);
        [self.allSessionTask removeObjectForKey:requestID];
        
        failure ? failure(error) : nil;
        
         TWLog(@"url = %@ \n paramters = %@ \n error = %@",url,parameters,error);
    }];
    
    NSNumber *requestId = @([sessionTask taskIdentifier]);
    
    self.allSessionTask[requestId] = sessionTask;
    
    [sessionTask resume];
    
    return requestId;
}


#pragma mark - 设置AFHTTPSessionManager相关属性
- (void)setRequestTimeoutInterval:(NSTimeInterval)time {
    self.sessionManager.requestSerializer.timeoutInterval = time;
}

- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    [self.sessionManager.requestSerializer setValue:value forHTTPHeaderField:field];
}

- (void)setRequestSerializer:(TWRequestSerializer)requestSerializer {
    self.sessionManager.requestSerializer = requestSerializer == TWRequestSerializerHTTP ? [AFHTTPRequestSerializer serializer] : [AFJSONRequestSerializer serializer];
}

- (void)setResponseSerializer:(TWResponseSerializer)responseSerializer {
    self.sessionManager.responseSerializer = responseSerializer == TWResponseSerializerHTTP ? [AFHTTPResponseSerializer serializer] : [AFJSONResponseSerializer serializer];
}

- (void)setSecurityPolicyWithCerPath:(NSString *)cerPath validatesDomainName:(BOOL)validatesDomainName {
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    // 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // 如果需要验证自建证书(无效证书)，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    // 是否需要验证域名，默认为YES;
    securityPolicy.validatesDomainName = validatesDomainName;
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData, nil];
    
    [self.sessionManager setSecurityPolicy:securityPolicy];
}


#pragma mark - 网络状态获取
+ (BOOL)isNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

+ (BOOL)isWWANNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
}

+ (BOOL)isWiFiNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}

@end
