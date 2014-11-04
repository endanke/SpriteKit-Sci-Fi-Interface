//
//  VortexDisplay.m
//  CreativeTest
//
//  Created by Daniel Eke on 2014. 11. 04..
//  Copyright (c) 2014. endanke. All rights reserved.
//

#import "VortexDisplay.h"

@interface VortexDisplay()

// General objects
@property (nonatomic) NSMutableArray *wayPoints;
@property int physicsMask;

// General nodes
@property (nonatomic) SKSpriteNode* testNode;
@property (nonatomic) SKShapeNode* canvasNode;

// Physic mutators
@property (nonatomic) SKFieldNode* springField;
@property (nonatomic) SKFieldNode* noiseField;

@end

@implementation VortexDisplay


- (instancetype)initWithTexture:(SKTexture *)texture color:(UIColor *)color size:(CGSize)size withPhysicsMask:(int)physicsMask{
    self = [super initWithTexture:texture color:color size:size];
    if(self){
        self.wayPoints = [NSMutableArray array];
        self.physicsMask = physicsMask;
        
        UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(-self.frame.size.width/2, -self.frame.size.height/2, self.frame.size.width, self.frame.size.height)];
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:ovalPath.CGPath];

        self.testNode = [[SKSpriteNode alloc] initWithTexture:nil color:[UIColor grayColor] size:CGSizeMake(30, 30)];
        self.testNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.testNode.size];
        self.testNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-40);
        self.testNode.physicsBody.categoryBitMask = physicsMask;
        self.testNode.physicsBody.fieldBitMask = physicsMask;
        [self addChild:self.testNode];
        
        
        self.canvasNode = [SKShapeNode node];
        self.canvasNode.strokeColor = [UIColor whiteColor];
        self.canvasNode.fillColor = nil;
        self.canvasNode.position = CGPointMake(0,0);
        
        [self addChild:self.canvasNode];
        
        self.springField = [SKFieldNode springField];
        self.springField.strength = 1.0;
        self.springField.falloff = -1.0;
        self.springField.categoryBitMask = physicsMask;

        self.noiseField = [SKFieldNode noiseFieldWithSmoothness:1.0 animationSpeed:1.0];
        self.noiseField.categoryBitMask = physicsMask;
        
        self.springField.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        self.noiseField.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        [self addChild:self.springField];
        [self addChild:self.noiseField];
    }
    return self;
}

- (CGPathRef)createPathToMove {
    CGMutablePathRef ref = CGPathCreateMutable();
    for(int i = 0; i < [self.wayPoints count]; ++i) {
        CGPoint p = [self.wayPoints[i] CGPointValue];
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

- (void)update{
    if([self.wayPoints count] > 500){
        [self.wayPoints removeObjectAtIndex:0];
    }
    [self.wayPoints addObject:[NSValue valueWithCGPoint:self.testNode.position]];
    [self drawLines];
}

@end
