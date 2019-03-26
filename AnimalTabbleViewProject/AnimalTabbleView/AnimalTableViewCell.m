//
//  AnimalTableViewCell.m
//  NewProject5
//
//  Created by Павел Нехорошкин on 19.03.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AnimalTableViewCell.h"


@interface AnimalTableViewCell()

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic, strong ) UIImageView * coverImageView;
@property (nonatomic, strong ) UILabel *title ;
@property (nonatomic, strong ) UILabel *subTitle;
@property (nonatomic, strong ) NSLayoutConstraint *constraintCoverImageViewTopAncor;//вынесли ограничение в проперти
@property (nonatomic, strong ) NSLayoutConstraint *bottomOfText;//вынесли ограничение в проперти
@property (nonatomic, strong ) NSLayoutConstraint *align;//вынесли ограничение в проперти

@end


@implementation AnimalTableViewCell 

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
        _subTitle.numberOfLines = 0; //чтобы текст переносился на вторую строку, если позволяют заданные пределы фрейма

        
        [self.contentView addSubview:_coverImageView];
        [self.contentView addSubview:_title ];
        [self.contentView addSubview:_subTitle ];
        
        NSLayoutConstraint *bottomOfText =
            [self.contentView.bottomAnchor constraintEqualToAnchor:_subTitle.bottomAnchor constant: +8.f];

        self.bottomOfText = bottomOfText;
        
        [self.contentView addConstraint:bottomOfText];

        //вынесли устаноку констрейнтов в отдельный метод
        [self makeAndAddLayoutConstraints];
        
        //добавляет действие по нажатию на рисунок
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapCoverImage)];
        
        [_coverImageView addGestureRecognizer:tapGestureRecognizer];
       
        _coverImageView.userInteractionEnabled = YES;
        
    }
    return self;
}

-(void) makeAndAddLayoutConstraints
{
    
    //создаем констрейнт и записываем его в проперти
    NSLayoutConstraint *constraintCoverImageViewTopAncor =     [_coverImageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:8.f];
    self.constraintCoverImageViewTopAncor = constraintCoverImageViewTopAncor;
    
    [NSLayoutConstraint activateConstraints:@[
      [_coverImageView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:8.f],
      constraintCoverImageViewTopAncor,
      [_coverImageView.widthAnchor constraintEqualToConstant: 50.f],
      [_coverImageView.heightAnchor constraintEqualToConstant: 50.f]]];
    
    _coverImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _coverImageView.layer.cornerRadius = 8;
    _coverImageView.layer.masksToBounds = true;
    
    [NSLayoutConstraint activateConstraints:@[
      [_title.leftAnchor constraintEqualToAnchor:_coverImageView.rightAnchor constant:8.f],
      [_title.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:8.f],
      [_title.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-8.f],
      [_title.heightAnchor constraintEqualToConstant: 20.f] ]];
    
    _title.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
      [_subTitle.leftAnchor constraintEqualToAnchor:_coverImageView.rightAnchor constant:8.f],
      [_subTitle.topAnchor constraintEqualToAnchor:_title.bottomAnchor constant:8.f],
      [_subTitle.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant: -8.f]]];
    
    _subTitle.translatesAutoresizingMaskIntoConstraints = NO;
}


-(void) prepareForReuse
{
    [super prepareForReuse];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
}


-(void) didTapCoverImage
{
       [self pulseItem:self.coverImageView];
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
@end


//добавить контент в массиве не только строки а словари с картинками в банк
    //два типа ячеек четные одни - нечетные другие
    //прочитать
    //обновление ячеек таблиц и коллекций


//анимировать ячейки CAAnimation - градиент лейер при менить через CAAnimation анимацию (ячейка прыгает или двигается)


