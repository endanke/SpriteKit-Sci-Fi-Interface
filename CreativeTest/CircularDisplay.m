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

@end

@implementation CircularDisplay

float rotateCounter = 0.1;
float rotateScale = 0.0;

- (instancetype)initWithSize:(CGSize)size{
    self = [super initWithTexture:nil color:nil size:size];
    if(self){
        self.circles = [NSMutableArray array];
        
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
        

        

    }
    return self;
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
