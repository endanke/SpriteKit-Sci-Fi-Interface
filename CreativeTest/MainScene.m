//
//  GameScene.m
//  CreativeTest
//
//  Created by Daniel Eke on 2014. 11. 03..
//  Copyright (c) 2014. endanke. All rights reserved.
//

#import "MainScene.h"
#import "VortexDisplay.h"

@interface MainScene() <SKPhysicsContactDelegate>

// General nodes
@property (nonatomic) SKShapeNode* circleDots;
@property (nonatomic) SKLabelNode* centerTextNode;
@property (nonatomic) SKEffectNode* mainEffect;
@property (nonatomic) SKNode* backgroundDots;

@property (nonatomic) NSMutableArray* vortexDisplays;

@end

@implementation MainScene

float rotateCounter = 0.1;
float rotateScale = 0.0;

-(void)didMoveToView:(SKView *)view {
    self.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
   
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsWorld.gravity = CGVectorMake(0.0, 0.0);
    self.physicsWorld.contactDelegate = self;
    
    self.backgroundDots = [SKNode node];
    
    [self addChild:self.backgroundDots];
    
    for(int i = 0; i < self.frame.size.height; i += 10){
        for(int j = 0; j < self.frame.size.width; j += 10){
            SKSpriteNode* dotNode = [[SKSpriteNode alloc] initWithTexture:0 color:[UIColor whiteColor] size:CGSizeMake(1, 1)];
            if(i/10 % 2 == 0){
                dotNode.position = CGPointMake(j+5, i);
            }else{
                dotNode.position = CGPointMake(j, i);
            }
            [self.backgroundDots addChild:dotNode];
        }
    }
    
    self.circleDots = [SKShapeNode node];
    
    UIBezierPath *_path=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(-250, -250, 500, 500)];
    
    CGFloat pattern[2];
    pattern[0] = 0.0;
    pattern[1] = 20.0;
    CGPathRef dashed =
    CGPathCreateCopyByDashingPath([_path CGPath],
                                  NULL,
                                  0,
                                  pattern,
                                  2);
    
    self.circleDots.path = dashed;
    self.circleDots.strokeColor = UIColor.whiteColor;
    self.circleDots.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    self.circleDots.lineCap = kCGLineCapRound;
    self.circleDots.lineWidth = 2.0;
    
    CGPathRelease(dashed);
    
    [self addChild:self.circleDots];
    
    self.centerTextNode = [[SKLabelNode alloc] initWithFontNamed:@"ISL_ALPHABOTXEN"];
    self.centerTextNode.text = @"01812992 WAITING FOR INPUT";
    self.centerTextNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    [self addChild:self.centerTextNode];
    
   // CIFilter *blur = [CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:@"inputRadius", @10.0f, nil];
   // [self.mainEffect setFilter:blur];

    /*
    CIFilter* hole = [CIFilter filterWithName:@"CIVortexDistortion"];
//    [hole setValue:[CIVector vectorWithCGPoint:CGPointMake(50, 50)] forKey:@"inputCenter"];
    [self.mainEffect setFilter:hole];
    
    self.mainEffect.shouldRasterize = YES;
    
    [self addChild:self.mainEffect]; */
    
    self.vortexDisplays = [NSMutableArray array];
    
    
    VortexDisplay* vortexDisplay = [[VortexDisplay alloc] initWithTexture:nil color:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0] size:CGSizeMake(200, 200)withPhysicsMask:2];
    vortexDisplay.position = CGPointMake(100,CGRectGetMaxY(self.frame)-vortexDisplay.frame.size.height/2);
    [self.vortexDisplays addObject:vortexDisplay];
    [self addChild:vortexDisplay];
    
    VortexDisplay* vortexDisplay2 = [[VortexDisplay alloc] initWithTexture:nil color:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0] size:CGSizeMake(200, 200) withPhysicsMask:4];
    vortexDisplay2.position = CGPointMake(300,CGRectGetMaxY(self.frame)-vortexDisplay.frame.size.height/2);
    [self.vortexDisplays addObject:vortexDisplay2];
    [self addChild:vortexDisplay2];
}

CGPathRef CGPathCreateCopyByDashingPath(
                                        CGPathRef path,
                                        const CGAffineTransform *transform,
                                        CGFloat phase,
                                        const CGFloat *lengths,
                                        size_t count
                                        );

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        
    }
}

-(void)update:(CFTimeInterval)currentTime {
    rotateScale = sinf(rotateCounter);
    rotateCounter += 0.01;
    self.circleDots.zRotation = M_PI/rotateScale;
    
    for(VortexDisplay* display in self.vortexDisplays){
        [display update];
    }
}



@end
