//
//  ChartNode.m
//  CreativeTest
//
//  Created by Eke Dániel on 2014. 11. 04..
//  Copyright (c) 2014. endanke. All rights reserved.
//

#import "ChartNode.h"

@interface ChartNode()

@property (nonatomic) NSMutableArray* bars;

@end

@implementation ChartNode

float scaleCounter = 0.1;
float barScale = 1.0;
float barCount = 25;

- (instancetype)initWithSize:(CGSize)size physicsMask:(int)physicsMask variator:(float)variator{
    self = [super initWithTexture:nil color:nil size:size];
    if(self){
        self.bars = [NSMutableArray array];
        
        for(int i = 0; i < barCount; i++){
            SKSpriteNode* barNode = [[SKSpriteNode alloc] initWithTexture:nil color:[UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:1] size:CGSizeMake(self.frame.size.width/barCount, self.frame.size.height)];
            barNode.position = CGPointMake((barNode.size.width/2-self.frame.size.width/2)+(barNode.size.width)*i, 0);
            [self.bars addObject:barNode];
            [self addChild:barNode];
            
            SKAction *a = [SKAction scaleYTo:0.0 duration:1.0];
            SKAction *b = [SKAction scaleYTo:1.0 duration:1.0];
            SKAction *c = [SKAction scaleXTo:0.5 duration:1.0];
            SKAction *d = [SKAction scaleXTo:arc4random_uniform(100)/100.0 duration:1.0];
            SKAction *e = [SKAction waitForDuration:0.1*i];
            SKAction *sequence = [SKAction sequence:@[a,b,c,d,e]];
            [barNode runAction:[SKAction repeatActionForever:sequence]];
        }
    }
    return self;
}

- (void)update{
    
}

@end
