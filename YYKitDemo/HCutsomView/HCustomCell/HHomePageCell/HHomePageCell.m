//
//  HHomePageCell.m
//  YYKitDemo
//
//  Created by HY on 16/8/1.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import "HHomePageCell.h"


@interface HHomePageCell ()

@property (nonatomic, retain) UILabel *hTitleLab;

@property (nonatomic, retain) UIImageView *hHomeIconImgV;

@end

@implementation HHomePageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier] ) {
        [self.contentView addSubview:self.hTitleLab];
        [self.contentView addSubview:self.hHomeIconImgV];
    }
    return self;
}

- (void)initDataWith:(HYStoryModel *)model{
    self.hTitleLab.text = model.title;
    [self.hHomeIconImgV sd_setImageWithURL:[NSURL URLWithString:model.images[0]]];
}

- (UILabel *)hTitleLab{
    if (!_hTitleLab) {
        _hTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, kScreenWidth - 15 * 3 - 100, 50)];
        _hTitleLab.numberOfLines = 2;
    }
    return _hTitleLab;
}

- (UIImageView *)hHomeIconImgV{
    if (!_hHomeIconImgV) {
        _hHomeIconImgV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 15 - 100 - 15, 15, 100, 50)];
        _hHomeIconImgV.contentMode = UIViewContentModeScaleAspectFill;
        [_hHomeIconImgV setCornerRadius:.2];
    }
    return _hHomeIconImgV;
}
@end
