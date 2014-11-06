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
@property (nonatomic) SKShapeNode* circleNode;
@property (nonatomic) SKLabelNode* dataLabel;

// Physic mutators
@property (nonatomic) SKFieldNode* springField;
@property (nonatomic) SKFieldNode* noiseField;

@end

@implementation VortexDisplay


- (instancetype)initWithSize:(CGSize)size physicsMask:(int)physicsMask speed:(float)speed{
    self = [super initWithTexture:nil color:nil size:size];
    if(self){
        self.wayPoints = [NSMutableArray array];
        self.physicsMask = physicsMask;
        
        UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(-self.frame.size.width*0.9/2, -self.frame.size.height*0.9/2, self.frame.size.width*0.9, self.frame.size.height*0.9)];

        self.circleNode = [SKShapeNode node];
        self.circleNode.path = ovalPath.CGPath;
        self.circleNode.strokeColor = [UIColor clearColor];
        self.circleNode.fillColor = [UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:1];
        
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:ovalPath.CGPath];

        self.testNode = [[SKSpriteNode alloc] initWithTexture:nil color:[UIColor grayColor] size:CGSizeMake(30, 30)];
        self.testNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.testNode.size];
        self.testNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-10);
        self.testNode.physicsBody.categoryBitMask = physicsMask;
        self.testNode.physicsBody.fieldBitMask = physicsMask;
        
        
        self.canvasNode = [SKShapeNode node];
        self.canvasNode.strokeColor = [UIColor colorWithRed:0.86 green:0.83 blue:0.71 alpha:1];
        self.canvasNode.fillColor = nil;
        self.canvasNode.position = CGPointMake(0,0);
        
        self.springField = [SKFieldNode springField];
        self.springField.strength = 1.0;
        self.springField.falloff = -1.0;
        self.springField.categoryBitMask = physicsMask;

        self.noiseField = [SKFieldNode noiseFieldWithSmoothness:1.0 animationSpeed:speed];
        self.noiseField.categoryBitMask = physicsMask;
        
        self.springField.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        self.noiseField.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));

        self.dataLabel = [[SKLabelNode alloc] initWithFontNamed:@"ISL_ALPHABOTXEN"];
        self.dataLabel.fontColor = [UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:1];
        self.dataLabel.position = CGPointMake(0,-10-self.frame.size.width/2);
        self.dataLabel.fontSize = 15;
        
        [self addChild:self.circleNode];
        [self addChild:self.testNode];
        [self addChild:self.canvasNode];
        [self addChild:self.springField];
        [self addChild:self.noiseField];
        [self addChild:self.dataLabel];
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
    self.dataLabel.text = [NSString stringWithFormat:@"%.02f / %.02f", self.testNode.position.x, self.testNode.position.y];
}

@end
