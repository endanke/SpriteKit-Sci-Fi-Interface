//
//  ButtonNode.m
//  CreativeTest
//
//  Created by Eke Dániel on 2014. 11. 05..
//  Copyright (c) 2014. endanke. All rights reserved.
//

#import "ButtonNode.h"

@interface ButtonNode()

@property (nonatomic) SKShapeNode* onOverlay;
@property (nonatomic) SKLabelNode* label;
@property float duration;

@end

@implementation ButtonNode

float counter = 0.1;
float phaser = 0.0;

- (instancetype)initWithSize:(CGSize)size{
    self = [super initWithTexture:nil color:[UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:1] size:size];
    if(self){
        self.duration = arc4random_uniform(100)/100.0;
        
        self.onOverlay = [SKShapeNode node];
        
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(-self.frame.size.width/2, -self.frame.size.height/2, self.frame.size.width, self.frame.size.height)];
        self.onOverlay.path = rectanglePath.CGPath;
        self.onOverlay.strokeColor = [UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:1];
        self.onOverlay.fillColor = [UIColor colorWithRed:0.2 green:0.8 blue:0.2 alpha:1.0];
        
        [self addChild:self.onOverlay];
        
        SKAction *a = [SKAction moveToY:-self.frame.size.height duration:1.0];
        SKAction *b = [SKAction performSelector:@selector(randomizeColor) onTarget:self];
        SKAction *c = [SKAction moveToY:0 duration:1.0];
        SKAction *d = [SKAction waitForDuration:self.duration];
        SKAction *sequence = [SKAction sequence:@[a,b,c,d]];
        [self.onOverlay runAction:[SKAction repeatActionForever:sequence]];
        
        self.label = [[SKLabelNode alloc] initWithFontNamed:@"ISL_ALPHABOTXEN"];
        self.label.fontColor = [UIColor colorWithRed:0.86 green:0.83 blue:0.71 alpha:1];
        self.label.text = [NSString stringWithFormat:@"/20/"];
        self.label.position = CGPointMake(0, -15);
        self.label.fontSize = 50;
        [self addChild:self.label];

    }
    return self;
}

- (void)randomizeColor{
    self.onOverlay.fillColor = [UIColor colorWithRed:arc4random_uniform(80)/100.0 green:arc4random_uniform(60)/100.0 blue:arc4random_uniform(30)/100.0 alpha:1.0];
}

- (void)update{
    phaser = sinf(counter);
    counter += 0.01;
    self.label.text = [NSString stringWithFormat:@"[%.01f]", (1-phaser)*self.duration*2];

}

@end
