//
//  SubRegisterA.m
//  LibA
//
//  Created by wanggang on 2021/10/30.
//

#import "SubRegisterA.h"
#import "LibA/LibA-Swift.h"

#define UseDirectly

@implementation SubRegisterA
+ (void)load {
#ifdef UseDirectly
    [ModuleRegister addDirectlyWithString:@"This is SubRegisterA Register Action"];
#else
    [ModuleRegister add:^NSString * _Nonnull{
        return  @"This is SubRegisterA Register Action";
    }];
#endif
}
@end
