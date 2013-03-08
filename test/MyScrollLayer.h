//
//  MyScrollLayer.h
//  LokaFire
//
//  Created by longtou on 12-11-28.
//
//

#import "CCLayer.h"
#import "cocos2d.h"
@interface MyScrollLayer : CCLayer
{
    int maskWidth;//显示区域宽度
    int maskHeight;//显示区域高度
    CGRect maskRect;//显示区域
    float maxY;//y的最大值
    float minY;//y的最小值
    CGPoint downPoint;
    CGPoint upPoint;
    CGPoint movePoint;
    int itemNum;//添加的个数
    int currentHeight;
    float nextItemY;//下一个添加的物品y值
    CGSize size;
}
-(id)initWithRect:(CGRect)rect;//初始化遮罩区域
-(void)addItem:(CCLayer*)item height:(float)height;//添加层
-(void)addSprite:(CCSprite*)item height:(float)height;//添加层
@end
