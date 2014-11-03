//
//  GameScene.m
//  CreativeTest
//
//  Created by Daniel Eke on 2014. 11. 03..
//  Copyright (c) 2014. endanke. All rights reserved.
//

#import "GameScene.h"

@interface GameScene() <SKPhysicsContactDelegate>

// General objects
@property (nonatomic) NSMutableArray *wayPoints;

// General nodes
@property (nonatomic) SKSpriteNode* testNode;
@property (nonatomic) SKShapeNode* circleDots;
@property (nonatomic) SKEffectNode* mainEffect;
@property (nonatomic) SKShapeNode* canvasNode;

// Physic mutators
@property (nonatomic) SKFieldNode* springField;
@property (nonatomic) SKFieldNode* noiseField;

@end

@implementation GameScene

float rotateCounter = 0.1;
float rotateScale = 0.0;

-(void)didMoveToView:(SKView *)view {
    self.backgroundColor = UIColor.whiteColor;
    self.wayPoints = [NSMutableArray array];
    
    self.mainEffect = [SKEffectNode node];
    
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsWorld.gravity = CGVectorMake(0.0, 0.0);
    self.physicsWorld.contactDelegate = self;
    
    self.testNode = [[SKSpriteNode alloc] initWithTexture:nil color:UIColor.redColor size:CGSizeMake(30, 30)];
    self.testNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.testNode.size];
    self.testNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-40);
    [self addChild:self.testNode];
    
    self.circleDots = [SKShapeNode node];
    
    UIBezierPath *_path=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(-50, -50, 100, 100)];
    
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
    self.circleDots.strokeColor = UIColor.grayColor;
    self.circleDots.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    self.circleDots.lineCap = kCGLineCapRound;
    self.circleDots.lineWidth = 1.0;
    
    CGPathRelease(dashed);
    
    [self addChild:self.circleDots];
    
    self.springField = [SKFieldNode springField];
    self.springField.strength = 1.0;
    self.springField.falloff = -1.0;
    
    self.noiseField = [SKFieldNode noiseFieldWithSmoothness:1.0 animationSpeed:1.0];
    
    self.springField.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    self.noiseField.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    [self addChild:self.springField];
    [self addChild:self.noiseField];
    
    self.canvasNode = [SKShapeNode node];
    self.canvasNode.strokeColor = [UIColor grayColor];
    self.canvasNode.fillColor = nil;
    self.canvasNode.position = CGPointMake(0,0);
    
    [self.mainEffect addChild:self.canvasNode];
    
   // CIFilter *blur = [CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:@"inputRadius", @10.0f, nil];
   // [self.mainEffect setFilter:blur];

    CIFilter* hole = [CIFilter filterWithName:@"CIHoleDistortion"];
    [self.mainEffect setFilter:hole];
    
    self.mainEffect.shouldRasterize = YES;
    
    [self addChild:self.mainEffect];
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
    
    [self.wayPoints addObject:[NSValue valueWithCGPoint:self.testNode.position]];
    
    [self drawLines];
}

- (CGPathRef)createPathToMove {
    CGMutablePathRef ref = CGPathCreateMutable();
    for(int i = 0; i < [self.wayPoints count]; ++i) {
        CGPoint p = [self.wayPoints[i] CGPointValue];
        p = [self.scene convertPointToView:p];
        if(i == 0) {
            CGPathMoveToPoint(ref, NULL, p.x, p.y);
        } else {
            CGPathAddLineToPoint(ref, NULL, p.x, p.y);
        }
    }
    
    return ref;
}

- (void)drawLines {
    CGPathRef path = [self createPathToMove];
    self.canvasNode.path = path;
    CGPathRelease(path);
}

@end
