//
//  SubRegisterA.m
//  LibA
//
//  Created by wanggang on 2021/10/30.
//

#import "SubRegisterA.h"
#import "LibA/LibA-Swift.h"

@implementation SubRegisterA
+ (void)load {
    [ModuleRegister addDirectlyWithString:@"This is SubRegisterA Register Action"];
}
@end
