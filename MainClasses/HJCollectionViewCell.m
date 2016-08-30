//
//  HJCollectionViewCell.m
//  HJDataDisplayCenter
//
//  Created by WHJ on 16/7/26.
//  Copyright © 2016年 WHJ. All rights reserved.
//

#import "HJCollectionViewCell.h"


@implementation HJCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame;{
    self = [super initWithFrame:frame];
    if(self){
        [self setupUI];
    }
    return self;
}



- (void)setupUI{
    
    [self.contentView addSubview:self.imageV];

}

- (UIImageView *)imageV{
    if (!_imageV) {
        _imageV = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
        _imageV.backgroundColor = [UIColor blueColor];
    }
    return _imageV;
}

@end
