//
//  LLLockPassword.m
//  LockSample
//
//  Created by Lugede on 14/11/12.
//  Copyright (c) 2014年 lugede.cn. All rights reserved.
//

#import "LLLockPassword.h"
#import <CommonCrypto/CommonDigest.h>

@implementation LLLockPassword

#pragma mark - 锁屏密码读写
+ (NSString*)loadLockPassword
{
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    NSString* pswd = [ud objectForKey:@"lock"];
    //    LLLog(@"pswd = %@", pswd);
    if (pswd != nil &&
        ![pswd isEqualToString:@""] &&
        ![pswd isEqualToString:@"(null)"]) {
        
        return pswd;
    }
    
    return nil;
}

+ (void)saveLockPassword:(NSString*)pswd
{
    pswd = [self CryptoStringWithKey:pswd];
    [[NSUserDefaults standardUserDefaults] setObject:pswd forKey:@"lock"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  内部方法
 *
 *  @param key 字符串
 *
 *  @return 加密字符串
 */
+(NSString *)CryptoStringWithKey:(NSString*)key
{
    if (key == nil || key.length ==0) {
        return @"";
    }
    const char *str = [key UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *md5str = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x"
                        "%02x%02x%02x%02x%02x%02x",
                        r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9],
                        r[10], r[11], r[12], r[13], r[15], r[14]];
    return md5str;
}

@end
