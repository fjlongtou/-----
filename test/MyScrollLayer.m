//
//  MyScrollLayer.m
//  LokaFire
//
//  Created by longtou on 12-11-28.
//
//

#import "MyScrollLayer.h"
#import "cocos2d.h"
#import "AppDelegate.h"
@interface MyScrollLayer()
-(void)beforeDraw;
-(void)afterDraw;
@end
@implementation MyScrollLayer
-(id)initWithRect:(CGRect)rect
{
    if (self = [super init])
    {
        anchorPoint_ = ccp(0.5,0);
        maskRect = rect;
        maskHeight = rect.size.height;
        maskWidth = rect.size.width;
        maxY = 0;
        minY = 0;
        itemNum = 0;
        nextItemY = rect.origin.y+rect.size.height;
        size = [[CCDirector sharedDirector] winSize];
    }
    return self;
}
-(void)addItem:(CCLayer*)item height:(float)height
{
    currentHeight += height;
    if(currentHeight>maskRect.size.height)maxY = currentHeight-maskRect.size.height;
    item.position = ccp(maskRect.origin.x,nextItemY-height);
    nextItemY -= height;
    [self addChild:item];
    itemNum++;
}
-(void)addSprite:(CCSprite*)item height:(float)height;//添加层
{
    item.anchorPoint = CGPointZero;
    currentHeight += height;
    if(currentHeight>maskRect.size.height)maxY = currentHeight-maskRect.size.height;
    item.position = ccp(maskRect.origin.x,nextItemY-height);
    nextItemY -= height;
    [self addChild:item];
    itemNum++;
}
-(void)visit
{
    // quick return if not visible. children won't be drawn.
    if (!visible_)
        return;
    //add  by  tangaowen
    [self beforeDraw];
    [super visit];
    //add  by tangaowen
    [self  afterDraw];
    
}
/**
 * clip this view so that outside of the visible bounds can be hidden.
 */
-(void)beforeDraw
{
    glEnable(GL_SCISSOR_TEST);
    if ([AppDelegate isRetinaMode])
    {
        //高清
        glScissor(maskRect.origin.x*2,maskRect.origin.y*2, maskRect.size.width*2,maskRect.size.height*2);
    }else
    {
        //非高清
        glScissor(maskRect.origin.x,maskRect.origin.y, maskRect.size.width,maskRect.size.height);
    }
    
}

/**
 * retract what's done in beforeDraw so that there's no side effect to
 * other nodes.
 */
-(void)afterDraw
{
    glDisable(GL_SCISSOR_TEST);
}
-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self stopAllActions];
    if(!self.parent.visible)return NO;
    downPoint = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    if (CGRectContainsPoint(maskRect, downPoint))
    {
        return YES;
    }
    return NO;
}
-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (self.position.y>maxY)
    {
        CCMoveTo *moveto = [CCMoveTo actionWithDuration:0.1 position:ccp(self.position.x,maxY)];
        [self runAction:moveto];
    }else if(self.position.y<minY)
    {
        CCMoveTo *moveto = [CCMoveTo actionWithDuration:0.1 position:ccp(self.position.x,minY)];
        [self runAction:moveto];
    }
}
-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    movePoint = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    if((self.position.y+(movePoint.y-downPoint.y)/2)>=maxY)
    {
        self.position = ccp(self.position.x,maxY);
    }
    else if ((self.position.y+(movePoint.y-downPoint.y)/2)<=minY)
    {
        self.position = ccp(self.position.x,minY);
    }
    else
    {
       self.position = ccp(self.position.x,self.position.y+(movePoint.y-downPoint.y)/2); 
    }
    downPoint = movePoint;
}
-(void)onEnter
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    [super onEnter];
}
-(void)onExit
{
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    [super onExit];
}
@end
