//
//  CircularDisplay.m
//  CreativeTest
//
//  Created by Daniel Eke on 2014. 11. 04..
//  Copyright (c) 2014. endanke. All rights reserved.
//

#import "CircularDisplay.h"

@interface CircularDisplay()

@property (nonatomic) NSMutableArray* circles;
@property (nonatomic) NSMutableArray* graphPoints;
@property (nonatomic) NSMutableArray* graphLines;

@end

@implementation CircularDisplay

float rotateCounter = 0.1;
float rotateScale = 0.0;

- (instancetype)initWithSize:(CGSize)size{
    self = [super initWithTexture:nil color:nil size:size];
    if(self){
        self.circles = [NSMutableArray array];
        self.graphPoints = [NSMutableArray array];
        self.graphLines = [NSMutableArray array];
        
        for(int i = 0; i < 5; i++){
            SKShapeNode* circleDots = [SKShapeNode node];
            
            float scale = ((i+4)*0.1);
            
            UIBezierPath *_path=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(-self.frame.size.width*scale/2, -self.frame.size.height*scale/2, self.frame.size.width*scale, self.frame.size.height*scale)];
            
            CGFloat pattern[2];
            pattern[0] = 0.0;
            pattern[1] = 20.0;
            CGPathRef dashed =
            CGPathCreateCopyByDashingPath([_path CGPath],
                                          NULL,
                                          0,
                                          pattern,
                                          2);
            
            circleDots.path = dashed;
            circleDots.strokeColor = [UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:1];
            circleDots.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
            circleDots.lineCap = kCGLineCapRound;
            circleDots.lineWidth = 2.0;
            
            CGPathRelease(dashed);
            
            [self.circles addObject:circleDots];
            [self addChild:circleDots];
            
        }
        
        for(int i = 0; i < 5; i++){
            SKSpriteNode* point = [[SKSpriteNode alloc] initWithTexture:nil color:[UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:1] size:CGSizeMake(20, 20)];
            
            point.position = CGPointMake(10+arc4random_uniform(100), 10+arc4random_uniform(100));
            
            if(i > 0){
                SKSpriteNode* prevNode = [self.graphPoints objectAtIndex:i-1];
                SKShapeNode *line = [SKShapeNode node];
                CGMutablePathRef pathToDraw = CGPathCreateMutable();
                CGPathMoveToPoint(pathToDraw, NULL, prevNode.position.x, prevNode.position.y);
                CGPathAddLineToPoint(pathToDraw, NULL, point.position.x, point.position.y);
                line.path = pathToDraw;
                [line setStrokeColor:[UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:1]];
                [self.graphLines addObject:line];
                [self addChild:line];
            }
            
            
            [self.graphPoints addObject:point];
            [self addChild:point];

            SKAction *a = [SKAction scaleTo:1.2 duration:0.1];
            SKAction *b = [SKAction scaleTo:1.0 duration:0.1];
            SKAction *c = [SKAction scaleTo:1.2 duration:0.1];
            SKAction *d = [SKAction scaleTo:1.0 duration:0.1];
            SKAction *e = [SKAction performSelector:@selector(updatePositions) onTarget:self];
            SKAction *f = [SKAction waitForDuration:0.5];
            SKAction *sequence = [SKAction sequence:@[a,b,c,d,e,f]];
            [point runAction:[SKAction repeatActionForever:sequence]];
        
        }
        

    }
    return self;
}

- (void)updatePositions{
    int i = 0;
    for(SKSpriteNode* point in self.graphPoints){
        int randomX = arc4random_uniform(self.frame.size.width/2);
        int randomY = arc4random_uniform(self.frame.size.width/2);
        point.position = CGPointMake(randomX-self.frame.size.width/4, randomY-self.frame.size.width/4);
        
        if(i > 0){
            SKSpriteNode* prevNode = [self.graphPoints objectAtIndex:i-1];
            SKShapeNode *line = [self.graphLines objectAtIndex:i-1];
            CGMutablePathRef pathToDraw = CGPathCreateMutable();
            CGPathMoveToPoint(pathToDraw, NULL, prevNode.position.x, prevNode.position.y);
            CGPathAddLineToPoint(pathToDraw, NULL, point.position.x, point.position.y);
            line.path = pathToDraw;
        }
        
        
        i++;
    }
}

CGPathRef CGPathCreateCopyByDashingPath(
                                        CGPathRef path,
                                        const CGAffineTransform *transform,
                                        CGFloat phase,
                                        const CGFloat *lengths,
                                        size_t count
                                        );

- (void)update{
    rotateScale = sinf(rotateCounter);
    rotateCounter += 0.01;

    for(SKShapeNode* node in self.circles){
        node.zRotation = M_PI/rotateScale;
    }
}

@end
