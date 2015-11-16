//
//  LicenseAgreementTableViewCell.m
//  room107
//
//  Created by ningxia on 15/9/8.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "LicenseAgreementTableViewCell.h"
#import "SearchTipLabel.h"
//#import "SelectButton.h"

@interface LicenseAgreementTableViewCell ()

@property (nonatomic, strong) SearchTipLabel *contentLabel;
@property (nonatomic, strong) NSString *content;
//@property (nonatomic, strong) SelectButton *selectButton;

@end

@implementation LicenseAgreementTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        CGFloat originY = [self originTopY];
        _contentLabel = [[SearchTipLabel alloc] initWithFrame:(CGRect){0, originY, CGRectGetWidth([self cellFrame]), licenseAgreementTableViewCellHeight - originY}];
        [_contentLabel setFont:[UIFont room107FontThree]];
        [_contentLabel setTextColor:[UIColor room107GrayColorC]];
        [_contentLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_contentLabel];
        UITapGestureRecognizer *tapGestureRecgnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidClick)];
        _contentLabel.userInteractionEnabled = YES;
        [_contentLabel addGestureRecognizer:tapGestureRecgnizer];
    }
    
    return self;
}

- (CGRect)cellFrame {
    return CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, licenseAgreementTableViewCellHeight);
}

- (void)setContent:(NSString *)content {
    _content = content;
    [_contentLabel setText:[@"\ue643 " stringByAppendingString:_content]];
//    CGRect contentRect = [content boundingRectWithSize:(CGSize){CGRectGetWidth([self cellFrame]), MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_contentLabel.font} context:nil];
    
//    CGFloat buttonWidth = contentRect.size.height + 10;
//    _selectButton = [[SelectButton alloc] initWithFrame:(CGRect){(CGRectGetWidth([self cellFrame]) - contentRect.size.width) / 2 - buttonWidth - 5, _contentLabel.frame.origin.y + CGRectGetHeight(_contentLabel.bounds) / 2 - buttonWidth / 2, buttonWidth, buttonWidth}];
//    [_selectButton addTarget:self action:@selector(selectButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:_selectButton];
}

- (void)setStatus:(BOOL)selected {
    if (selected) {
//        [_selectButton buttonDidClick:_selectButton];
//        [self selectButtonDidClicked:_selectButton];
        [self viewDidClick];
    }
}

- (BOOL)status {
    return [_contentLabel.textColor isEqual:[UIColor room107GrayColorC]] ? NO : YES;
}

- (void)viewDidClick {
    if ([_contentLabel.textColor isEqual:[UIColor room107GreenColor]]) {
        [_contentLabel setTextColor:[UIColor room107GrayColorC]];
        [_contentLabel setText:[@"\ue643 " stringByAppendingString:_content]];
    } else {
        [_contentLabel setTextColor:[UIColor room107GreenColor]];
        [_contentLabel setText:[@"\ue644 " stringByAppendingString:_content]];
    }
}

//- (IBAction)selectButtonDidClicked:(id)sender {
//    if ([_contentLabel.textColor isEqual:[UIColor room107GreenColor]]) {
//        [_contentLabel setTextColor:[UIColor room107GrayColorC]];
//    } else {
//        [_contentLabel setTextColor:[UIColor room107GreenColor]];
//    }
//}

@end
