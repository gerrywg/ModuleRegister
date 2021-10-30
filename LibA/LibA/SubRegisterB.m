//
//  SubRegisterB.m
//  LibA
//
//  Created by wanggang on 2021/10/30.
//

#import "SubRegisterB.h"
#import "LibA/LibA-Swift.h"

@implementation SubRegisterB
+ (void)load {
    [ModuleRegister addDirectlyWithString:@"This is SubRegisterB Register Action"];
}
@end
