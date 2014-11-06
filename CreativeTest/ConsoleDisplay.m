//
//  ConsoleDisplay.m
//  CreativeTest
//
//  Created by Eke Dániel on 2014. 11. 06..
//  Copyright (c) 2014. endanke. All rights reserved.
//

#import "ConsoleDisplay.h"

@interface ConsoleDisplay()

@property (nonatomic) NSMutableArray* labelNodes;

@end

@implementation ConsoleDisplay

- (instancetype)initWithSize:(CGSize)size{
    self = [super initWithTexture:nil color:[UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:1] size:size];
    if(self){
        self.labelNodes = [NSMutableArray array];
        
        SKAction *a = [SKAction performSelector:@selector(addText) onTarget:self];
        SKAction *b = [SKAction performSelector:@selector(moveText) onTarget:self];
        SKAction *c = [SKAction performSelector:@selector(removeText) onTarget:self];
        SKAction *d = [SKAction waitForDuration:1.0];
        SKAction *sequence = [SKAction sequence:@[a,b,c,d]];
        [self runAction:[SKAction repeatActionForever:sequence]];
    }
    return self;
}

- (void)addText{
    SKLabelNode* textNode = [[SKLabelNode alloc] initWithFontNamed:@"ISL_ALPHABOTXEN"];
    textNode.fontColor = [UIColor colorWithRed:0.86 green:0.83 blue:0.71 alpha:1];
    textNode.text = [NSString stringWithFormat:@"%i%i%i%i%i%i00000000000000000000000000000000000",arc4random_uniform(100000000),arc4random_uniform(100000000),arc4random_uniform(100000000),arc4random_uniform(100000000),arc4random_uniform(100000000),arc4random_uniform(100000000)];
    textNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    textNode.fontSize = 10;
    textNode.position = CGPointMake(10-self.frame.size.width/2, - 5 - self.frame.size.height/2);
    
    [self.labelNodes addObject:textNode];
    [self addChild:textNode];
}

- (void)moveText{
    for(SKLabelNode* textNode in self.labelNodes){
        SKAction* moveDown = [SKAction moveByX:0 y:10 duration:1.0];
        [textNode runAction:moveDown];
    }
}

- (void)removeText{
    SKLabelNode* lastNode =[self.labelNodes objectAtIndex:0];
    if(lastNode.position.y > -10 + self.frame.size.height/2){
        SKAction *a = [SKAction fadeOutWithDuration:0.3];
        SKAction *b = [SKAction removeFromParent];
        SKAction *sequence = [SKAction sequence:@[a,b]];
        [lastNode runAction:sequence];
        [self.labelNodes removeObject:lastNode];
    }
}

- (void)update{
    
}

@end
