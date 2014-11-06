//
//  ChartNode.h
//  CreativeTest
//
//  Created by Eke Dániel on 2014. 11. 04..
//  Copyright (c) 2014. endanke. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DisplayNode.h"

@interface ChartNode : DisplayNode

- (instancetype)initWithSize:(CGSize)size physicsMask:(int)physicsMask variator:(float)variator;

@end
