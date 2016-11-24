//
//  PasswordEncrypt.m
//  BiCaiJia
//
//  Created by Tion on 16/2/19.
//  Copyright © 2016年 Tion. All rights reserved.
//

#import "PasswordEncrypt.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "BCJUserInfo.h"
@implementation PasswordEncrypt
+ (NSString*)encrypt:(NSString*)InputString
{
    //password =InputString;
    BCJUserInfo* userInfo=[BCJUserInfo sharedUserInfo];
#pragma mark- 加密
    //加载js做文件中的内容
    NSString *BigIntPath = [[NSBundle mainBundle] pathForResource:@"BigInt" ofType:@"js"];
    NSString *RSAPath = [[NSBundle mainBundle] pathForResource:@"RSA" ofType:@"js"];
    NSString *BarrettPath = [[NSBundle mainBundle] pathForResource:@"Barrett" ofType:@"js"];
    NSString *EncryptPath = [[NSBundle mainBundle] pathForResource:@"RSAEncrypt" ofType:@"js"];
    
    NSString *BigIntContent = [NSString stringWithContentsOfFile:BigIntPath encoding:NSUTF8StringEncoding error:nil];
    NSString *BarrettContent = [NSString stringWithContentsOfFile:BarrettPath encoding:NSUTF8StringEncoding error:nil];
    NSString *RSAContent = [NSString stringWithContentsOfFile:RSAPath encoding:NSUTF8StringEncoding error:nil];
    NSString *EncryptContent = [NSString stringWithContentsOfFile:EncryptPath encoding:NSUTF8StringEncoding error:nil];
    //执行js文件中的内容
    JSContext* context=[[JSContext alloc] init];
    
    //self.context = [[JSContext alloc] init];
    [context evaluateScript:BigIntContent];
    [context evaluateScript:RSAContent];
    [context evaluateScript:BarrettContent];
    [context evaluateScript:EncryptContent];
    
    //调用js中的函数
    JSValue *value = [context[@"RSAEncript"] callWithArguments:@[userInfo.empoent,userInfo.module,InputString]];
    BCJLog(@"value=%@",value);
    return [value toString];
}

@end
