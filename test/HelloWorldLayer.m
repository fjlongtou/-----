//
//  HelloWorldLayer.m
//  test
//
//  Created by longtou on 13-3-8.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "MyScrollLayer.h"
#import "cocos2d.h"
#import "AppDelegate.h"
// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		MyScrollLayer *scoll = [[MyScrollLayer alloc] initWithRect:CGRectMake(100, 100, 300, 220)];
        CCSprite *sp1 = [CCSprite spriteWithFile:@"test1.png"];
        sp1.anchorPoint = ccp(0, 0);
        [scoll addSprite:sp1 height:sp1.contentSize.height];
        CCSprite *sp2 = [CCSprite spriteWithFile:@"test1.png"];
        sp2.anchorPoint = ccp(0, 0);
        [scoll addSprite:sp2 height:sp2.contentSize.height];
        [self addChild:scoll];
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
