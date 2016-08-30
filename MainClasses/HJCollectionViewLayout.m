//
//  HJCollectionViewLayout.m
//  HJDataDisplayCenter
//
//  Created by WHJ on 16/7/26.
//  Copyright © 2016年 WHJ. All rights reserved.
//

#import "HJCollectionViewLayout.h"
#import "CONST.h"

@implementation HJCollectionViewLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
      
        self.minimumLineSpacing = kMinimumInteritemSpacing;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.itemSize = CGSizeMake(kItemWidth, kItemHeight);
        
    }
    return self;
}


- (void)prepareLayout{
    
    self.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin);
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    
    return YES;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [super layoutAttributesForItemAtIndexPath:indexPath];
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{

    NSArray *items = [super layoutAttributesForElementsInRect:rect];
     CGFloat horizontalCenterX = self.collectionView.contentOffset.x + CGRectGetWidth(self.collectionView.bounds)/2.0;
    __block NSMutableArray *tmpMArr = [NSMutableArray arrayWithCapacity:items.count];
    
    [items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UICollectionViewLayoutAttributes *attr = obj;
        
        //没有则比较全部，找出最近
        NSLog(@"offset = %f centerx = %f",horizontalCenterX,attr.center.x);
        if (ABS(attr.center.x - horizontalCenterX) < attr.size.width/2.f) {
            CGFloat scale = 1+(1-ABS(attr.center.x - horizontalCenterX)/(attr.size.width/2.f))/4.f;
                attr.zIndex = 5;
                attr.transform3D = CATransform3DMakeScale(scale, scale, 1);
        }
        
        [tmpMArr addObject:attr];
    }];

    return tmpMArr;
}


- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity;{

   __block CGFloat offsetAdjustment = 0.f;
    CGFloat horizontalCenterX = proposedContentOffset.x + CGRectGetWidth(self.collectionView.bounds)/2.0;
    CGRect targetRect = CGRectMake(proposedContentOffset.x, proposedContentOffset.y, CGRectGetWidth(self.collectionView.bounds), CGRectGetHeight(self.collectionView.bounds));
    NSArray *items = [super layoutAttributesForElementsInRect:targetRect];
    __block UICollectionViewLayoutAttributes *tmpAttr = nil;//用于比较
    
    [items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UICollectionViewLayoutAttributes *attr = obj;
        //判断是否有最接近的，有则跳出循环
        if (ABS(attr.center.x - horizontalCenterX) <= attr.size.width/2.f) {
            offsetAdjustment = attr.center.x - horizontalCenterX;
            *stop = YES;
        }
        //没有则比较全部，找出最近
        if (ABS(attr.center.x - horizontalCenterX) <= ABS(tmpAttr.center.x - horizontalCenterX)) {
            tmpAttr = attr;
            offsetAdjustment = attr.center.x - horizontalCenterX;
        }
    }];
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);

}
@end
