//
//  GameScene.m
//  CreativeTest
//
//  Created by Daniel Eke on 2014. 11. 03..
//  Copyright (c) 2014. endanke. All rights reserved.
//

#import "MainScene.h"
#import "DisplayNode.h"
#import "VortexDisplay.h"
#import "ButtonNode.h"
#import "ChartNode.h"
#import "CircularDisplay.h"
#import "ConsoleDisplay.h"

@interface MainScene() <SKPhysicsContactDelegate>

// General nodes
@property (nonatomic) SKLabelNode* centerTextNode;
@property (nonatomic) SKEffectNode* mainEffect;
@property (nonatomic) SKNode* backgroundDots;

@property (nonatomic) NSMutableArray* displayElements;

@end

@implementation MainScene

-(void)didMoveToView:(SKView *)view {
    self.backgroundColor = [UIColor colorWithRed:0.86 green:0.83 blue:0.71 alpha:1];
    
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsWorld.gravity = CGVectorMake(0.0, 0.0);
    self.physicsWorld.contactDelegate = self;
    
    self.backgroundDots = [SKNode node];
    
    [self addChild:self.backgroundDots];
    
    for(int i = 0; i < self.frame.size.height; i += 10){
        for(int j = 0; j < self.frame.size.width; j += 10){
            SKSpriteNode* dotNode = [[SKSpriteNode alloc] initWithTexture:0 color:[UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:1] size:CGSizeMake(1, 1)];
            if(i/10 % 2 == 0){
                dotNode.position = CGPointMake(j+5, i);
            }else{
                dotNode.position = CGPointMake(j, i);
            }
            [self.backgroundDots addChild:dotNode];
        }
    }
    
    
    /*
     // A nice custom effect could be great
     CIFilter* hole = [CIFilter filterWithName:@"CIVortexDistortion"];
     [hole setValue:[CIVector vectorWithCGPoint:CGPointMake(50, 50)] forKey:@"inputCenter"];
     [self.mainEffect setFilter:hole];
     
     self.mainEffect.shouldRasterize = YES;
     
     [self addChild:self.mainEffect];
     */
    
    
    self.displayElements = [NSMutableArray array];
    float colSize = self.frame.size.width/4;
    
    ConsoleDisplay* consoleDisplay = [[ConsoleDisplay alloc] initWithSize:CGSizeMake(colSize*2, 320)];
    consoleDisplay.position = CGPointMake(CGRectGetMidX(self.frame) - consoleDisplay.frame.size.width/2, CGRectGetMidY(self.frame) + 70);
    [self.displayElements addObject:consoleDisplay];
    
    CircularDisplay* circularDisplay = [[CircularDisplay alloc] initWithSize:CGSizeMake(colSize*2, colSize*2)];
    circularDisplay.position = CGPointMake(CGRectGetMaxX(self.frame) - circularDisplay.frame.size.width/2, CGRectGetMaxY(self.frame) - circularDisplay.frame.size.width/2);
    
    [self.displayElements addObject:circularDisplay];
    
    for (int i = 0; (i*colSize/2) < self.frame.size.width/2; i++) {
        VortexDisplay* vortexDisplay = [[VortexDisplay alloc] initWithSize:CGSizeMake(colSize/2, colSize/2) physicsMask:pow(2, i) speed:1.0+i*0.1];
        vortexDisplay.position = CGPointMake(vortexDisplay.frame.size.width/2 +i*colSize/2,CGRectGetMaxY(self.frame)-vortexDisplay.frame.size.height/2);
        
        [self.displayElements addObject:vortexDisplay];
    }
    for(int i = 0; (i*colSize/2) < self.frame.size.width; i ++){
        ChartNode* chartNode = [[ChartNode alloc] initWithSize:CGSizeMake(colSize/2, colSize/2) physicsMask:6 variator:1.0];
        chartNode.position = CGPointMake(chartNode.frame.size.width/2+i*colSize/2, chartNode.frame.size.height/2+colSize/2);
        [self.displayElements addObject:chartNode];
        
        SKLabelNode* indexText = [[SKLabelNode alloc] initWithFontNamed:@"ISL_ALPHABOTXEN"];
        indexText.fontColor = [UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:1];
        indexText.text = [NSString stringWithFormat:@"IVC_#000%i",i];
        indexText.position = CGPointMake(0,15+chartNode.frame.size.height/2);
        indexText.fontSize = 15;
        [chartNode addChild:indexText];
        
        for(int j = 0; (j*40) < chartNode.size.width; j++){
            SKLabelNode* countText = [[SKLabelNode alloc] initWithFontNamed:@"ISL_ALPHABOTXEN"];
            countText.fontColor = [UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:1];
            countText.text = [NSString stringWithFormat:@"|%i|",j + i*10];
            countText.position = CGPointMake(-chartNode.frame.size.width/2 + 15 + j * 30,5+chartNode.frame.size.height/2);
            countText.fontSize = 10;
            [chartNode addChild:countText];
        }
    }
    
    for(int i = 0; (i*colSize/2) < self.frame.size.width; i ++){
        ButtonNode* buttonNode = [[ButtonNode alloc] initWithSize:CGSizeMake(colSize/2, colSize/4)];
        buttonNode.position = CGPointMake(buttonNode.frame.size.width/2+i*colSize/2, buttonNode.frame.size.height/2 + colSize/4);
        [self.displayElements addObject:buttonNode];
    }
    
    for(int i = 0; (i*colSize/2) < self.frame.size.width; i ++){
        ButtonNode* buttonNode = [[ButtonNode alloc] initWithSize:CGSizeMake(colSize/2, colSize/4)];
        buttonNode.position = CGPointMake(buttonNode.frame.size.width/2+i*colSize/2, buttonNode.frame.size.height/2);
        [self.displayElements addObject:buttonNode];
    }
    
    for(DisplayNode* display in self.displayElements){
        [self addChild:display];
    }
    
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        // TOOD: responses
    }
}

-(void)update:(CFTimeInterval)currentTime {
    for(DisplayNode* display in self.displayElements){
        [display update];
    }
}



@end
