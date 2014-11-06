//
//  VortexDisplay.h
//  CreativeTest
//
//  Created by Daniel Eke on 2014. 11. 04..
//  Copyright (c) 2014. endanke. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DisplayNode.h"

@interface VortexDisplay : DisplayNode

- (instancetype)initWithSize:(CGSize)size physicsMask:(int)physicsMask speed:(float)speed;

@end
