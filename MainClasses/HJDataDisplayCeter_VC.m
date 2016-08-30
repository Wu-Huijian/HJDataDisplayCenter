//
//  HJDataDisplayCeter_VC.m
//  HJDataDisplayCenter
//
//  Created by WHJ on 16/7/26.
//  Copyright © 2016年 WHJ. All rights reserved.
//

#import "HJDataDisplayCeter_VC.h"
#import "CONST.h"
#import "HJCollectionViewLayout.h"
#import "HJCollectionViewCell.h"

@interface HJDataDisplayCeter_VC ()<UICollectionViewDataSource
,UICollectionViewDelegateFlowLayout>{

    NSArray *_images;

}

@property (nonatomic, strong) UICollectionView *collectionView;

@end

static CGFloat const collectionViewCellWidth = 180;
static CGFloat const collectionViewCellHeight = 220;

@implementation HJDataDisplayCeter_VC
#pragma mark -lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initW];
    
    [self setupUI];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)initW{

    _images = @[@"psb-1.jpeg",@"psb-2.jpeg",@"psb-3.jpeg",@"psb-4.jpeg",@"psb-1.jpeg",@"psb-2.jpeg",@"psb-3.jpeg",@"psb-4.jpeg"];

}
#pragma mark - About UI

- (void)setupUI{

    HJCollectionViewLayout *flowlayout = [[HJCollectionViewLayout alloc]init];
    flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowlayout.minimumInteritemSpacing = (ScreenWidth - collectionViewCellWidth)/2.f;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight/2.f) collectionViewLayout:flowlayout];
    [collectionView registerClass:[HJCollectionViewCell class] forCellWithReuseIdentifier:@"HJCollectionViewCell"];
    collectionView.backgroundColor = [UIColor purpleColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}

#pragma mark - Request data

#pragma mark - Event response

#pragma mark - Private methods

#pragma mark - Delegate methods

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;{
    return _images.count;
}


- (HJCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;{
    
    HJCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HJCollectionViewCell" forIndexPath:indexPath];
    cell.imageV.image = [UIImage imageNamed:_images[indexPath.item]];
    return cell;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;{
    return 1;
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;{

    return CGSizeMake(collectionViewCellWidth, collectionViewCellHeight);
}



#pragma mark - getters and setters

@end
