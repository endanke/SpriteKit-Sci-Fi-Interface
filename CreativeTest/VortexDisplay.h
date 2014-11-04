//
//  VortexDisplay.h
//  CreativeTest
//
//  Created by Daniel Eke on 2014. 11. 04..
//  Copyright (c) 2014. endanke. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface VortexDisplay : SKSpriteNode

- (instancetype)initWithTexture:(SKTexture *)texture color:(UIColor *)color size:(CGSize)size withPhysicsMask:(int)physicsMask;
- (void)update;

@end
