//
//  RegisterApi.m
//  Imitate
//
//  Created by 王阳 on 2020/6/8.
//  Copyright © 2020 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RegisterApi.h"

@implementation RegisterApi {
    NSString *_url;
}

- (id)initWithUrl:(NSString *)url {
    self = [super init];
    if (self) {
        _url = url;
    }
    return self;
}

- (NSString *)requestUrl {
    // “ http://www.yuantiku.com ” 在 YTKNetworkConfig 中设置，这里只填除去域名剩余的网址信息
    return _url;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}


@end
