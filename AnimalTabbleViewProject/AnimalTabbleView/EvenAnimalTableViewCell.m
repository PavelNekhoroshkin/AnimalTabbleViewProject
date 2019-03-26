//
//  EvenAnimalTableViewCell.m
//  NewProject5
//
//  Created by Павел Нехорошкин on 22.03.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EvenAnimalTableViewCell.h"


@interface EvenAnimalTableViewCell()

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic, strong   ) UIImageView * coverImageView;
@property (nonatomic, strong   ) UILabel *title ;
@property (nonatomic, strong   ) UILabel *subTitle;
@property (nonatomic, strong   ) NSLayoutConstraint *constraintCoverImageViewTopAncor;//вынесли ограничение в проперти
@property (nonatomic, strong   ) NSLayoutConstraint *bottomOfText;//вынесли ограничение в проперти
@property (nonatomic, strong   ) NSLayoutConstraint *align;//вынесли ограничение в проперти

@end


@implementation EvenAnimalTableViewCell

//метод получения ячеек для переиспользования
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier ];
    
    if(self){
        _coverImageView = [UIImageView new];
        _coverImageView.frame = CGRectMake(8, 8, 50, 50);
        
        _title  = [UILabel new];
        _title.frame = CGRectMake(16 + 50, 8, (self.frame.size.width - 16 - 50 - 8), 10);
        
        _subTitle  = [UILabel new];
        _subTitle.frame = CGRectMake(16 + 50, 8 + 20 + 5, (self.frame.size.width - 16 - 50 - 8), 96 - 20 - 8 - 5 - 8);
        
        //чтобы текст переносился на вторую строку, если позволяют заданные пределы фрейма
        _subTitle.numberOfLines = 0;
        
        
        [self.contentView addSubview:_coverImageView];
        [self.contentView addSubview:_title ];
        [self.contentView addSubview:_subTitle ];
        
        NSLayoutConstraint *bottomOfText =
            [self.contentView.bottomAnchor constraintEqualToAnchor:_subTitle.bottomAnchor constant: +8.f];
        
        
        self.bottomOfText = bottomOfText;
        [self.contentView addConstraint:bottomOfText];
        
        //вынесли устаноку констрейнтов в отдельный метод
        [self makeAndAddLayoutConstraints];
        
        //добавляем действие по нажатию на рисунок
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapCoverImage)];
        [_coverImageView addGestureRecognizer:tapGestureRecognizer];
        
        //чтобы _coverImageView получал события нажатий
        _coverImageView.userInteractionEnabled = YES;
        
      
    }
    return self;
}

-(void) makeAndAddLayoutConstraints{
    
    //создаем констрейнт и записываем его в проперти
    NSLayoutConstraint *constraintCoverImageViewTopAncor =
        [_coverImageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:8.f];
    
    self.constraintCoverImageViewTopAncor = constraintCoverImageViewTopAncor;
    
    [NSLayoutConstraint activateConstraints:@[
      [_coverImageView.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-8.f],
      self.constraintCoverImageViewTopAncor,
      [_coverImageView.widthAnchor constraintEqualToConstant: 50.f],
      [_coverImageView.heightAnchor constraintEqualToConstant: 50.f] ]];
    
    _coverImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _coverImageView.layer.cornerRadius = 8;
    _coverImageView.layer.masksToBounds = true;
    
    [NSLayoutConstraint activateConstraints:@[
      [_title.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:8.f],
      [_title.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:8.f],
      [_title.rightAnchor constraintEqualToAnchor:self.coverImageView.leftAnchor constant: -8.f],
      [_title.heightAnchor constraintEqualToConstant: 20.f]]];
    
    _title.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
      [_subTitle.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:8.f],
      [_subTitle.topAnchor constraintEqualToAnchor:_title.bottomAnchor constant:8.f],
      [_subTitle.rightAnchor constraintEqualToAnchor:self.coverImageView.leftAnchor constant: -8.f]]];
    
    _subTitle.translatesAutoresizingMaskIntoConstraints = NO;
}


-(void) prepareForReuse {
    [super prepareForReuse];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
}




/** нажатие на рисунок */
-(void) didTapCoverImage
{
    [self pulseItem:self.coverImageView];
    [self changeCollor];
}

-(void) pulseItem:(UIView *)item
{
    CABasicAnimation *scalingAnimation = (CABasicAnimation *)[item.layer animationForKey:@"scaling"];
    
    if (!scalingAnimation)
    {
        scalingAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        scalingAnimation.duration=0.07;
        scalingAnimation.repeatCount=3;
        scalingAnimation.autoreverses=YES;
        scalingAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        scalingAnimation.fromValue=[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
        scalingAnimation.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.3, 1.3, 1.0)];
        
    }
    
    [item.layer addAnimation:scalingAnimation forKey:@"scaling"];
}

- (void) changeCollor
{
    CABasicAnimation *color = [CABasicAnimation animationWithKeyPath:@"borderColor"];
    //меняем цвет рамкиа с белого на карсный
    color.fromValue = (id)[UIColor redColor].CGColor;
    color.toValue   = (id)[UIColor whiteColor].CGColor;
    
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    
    //меняем ширину рамки
    CABasicAnimation *width = [CABasicAnimation animationWithKeyPath:@"borderWidth"];
    // animate from 2pt to 4pt wide border ...
    width.fromValue = @0;
    width.toValue   = @8;
    // ... and change the model value
    self.layer.borderWidth = 0;
    
    //меняем цвет ячейки
    CABasicAnimation *background = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    // animate from 2pt to 4pt wide border ...
    background.fromValue = (id)[UIColor grayColor].CGColor;
    background.toValue   = (id)[UIColor whiteColor].CGColor;
    
    // ... and change the model value
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    
    
    CAAnimationGroup *allAnimation = [CAAnimationGroup animation];
    // animate both as a group with the duration of 0.5 seconds
    allAnimation.duration   = 0.8;
    allAnimation.animations = @[color, width, background];
    // optionally add other configuration (that applies to both animations)
    allAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.layer addAnimation:allAnimation forKey:@"color and width"];
    
}

@end


