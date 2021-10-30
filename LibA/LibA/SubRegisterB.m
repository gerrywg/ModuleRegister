//
//  SubRegisterB.m
//  LibA
//
//  Created by wanggang on 2021/10/30.
//

#import "SubRegisterB.h"
#import "LibA/LibA-Swift.h"

#define UseDirectly

@implementation SubRegisterB
+ (void)load {
#ifdef UseDirectly
    [ModuleRegister addDirectlyWithString:@"This is SubRegisterB Register Action"];
#else
    [ModuleRegister add:^NSString * _Nonnull{
        return  @"This is SubRegisterB Register Action";
    }];
#endif
}
@end
