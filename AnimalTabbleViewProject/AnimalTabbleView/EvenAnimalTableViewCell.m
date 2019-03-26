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
//        _coverImageView.backgroundColor = [UIColor lightGrayColor];
        _coverImageView.frame = CGRectMake(8, 8, 50, 50);
        
        _title  = [UILabel new];
//        _title.backgroundColor =  [UIColor lightGrayColor];
        _title.frame = CGRectMake(16 + 50, 8, (self.frame.size.width - 16 - 50 - 8), 10);
        
        _subTitle  = [UILabel new];
//        _subTitle.backgroundColor =  [UIColor lightGrayColor];
        _subTitle.frame = CGRectMake(16 + 50, 8 + 20 + 5, (self.frame.size.width - 16 - 50 - 8), 96 - 20 - 8 - 5 - 8);
        _subTitle.numberOfLines = 0; //чтобы текст переносился на вторую строку, если позволяют заданные пределы фрейма
        
        
        [self.contentView addSubview:_coverImageView];
        [self.contentView addSubview:_title ];
        [self.contentView addSubview:_subTitle ];
        
        NSLayoutConstraint *bottomOfText =
        //        [_subTitle.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant: -8.f];
        [self.contentView.bottomAnchor constraintEqualToAnchor:_subTitle.bottomAnchor constant: +8.f];
        
        //  можно выставить приоритет констрейнту
        //        bottomOfText.priority = UILayoutPriorityDefaultHigh;
        
        self.bottomOfText = bottomOfText;
        [self.contentView addConstraint:bottomOfText];
        
        
        //вынесли устаноку констрейнтов в отдельный метод
        [self makeAndAddLayoutConstraints];
        
        
        
        //добавляем действие по нажатию на рисунок
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapCoverImage)];
        [_coverImageView addGestureRecognizer:tapGestureRecognizer];
        //чтобы _coverImageView получал события нажатий
        _coverImageView.userInteractionEnabled = YES;
        
        //выравнивание рисунка по высоте ячейки, при изменении высоты ячейки в зависимости от размера текста
        NSLayoutConstraint *align = [self.coverImageView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor constant:0.f];
        
        
        
        //нельзя добавлять к _coverImageView:
        // Unable to install constraint on view.  Does the constraint reference something from outside the subtree of the view?  That's illegal. constraint:<NSLayoutConstraint:0x6000034df430 UIImageView:0x7f9930006f10.centerY == UITableViewCellContentView:0x7f9930006aa0.centerY   (active)> view:<UIImageView: 0x7f9930006f10; frame = (8 8; 50 50); gestureRecognizers = <NSArray: 0x6000019a25b0>; layer = <CALayer: 0x6000017e1de0>>'
        //        [_coverImageView addConstraint:align]; будет ошибка
        
        //нужно активировать, но по кнопке
        //        [NSLayoutConstraint activateConstraints:@[align]] ;
        
        //        self.align = align;
        
        
    }
    
    return self;
    
    
}
-(void) prepareForReuse {
    [super prepareForReuse];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //    self.coverImageView.frame = CGRectMake(16.f, 16.f, 40.f, 40.f);
    //    self.title.frame = CGRectMake(CGRectGetMaxX(self.coverImageView.frame) + 16.f, 16.f, CGRectGetWidth(self.frame) - 88.f, 16.f);
    //    self.subTitle.frame = CGRectMake(CGRectGetMaxX(self.coverImageView.frame) + 16.f, CGRectGetMaxY(self.title.frame) + 16.f, CGRectGetWidth(self.frame) - 88.f, 16.f);
}



-(void) makeAndAddLayoutConstraints{
    
    //создаем констрейнт и записываем его в проперти
    NSLayoutConstraint *constraintCoverImageViewTopAncor =     [_coverImageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:8.f];
    self.constraintCoverImageViewTopAncor = constraintCoverImageViewTopAncor;
    
    [NSLayoutConstraint activateConstraints:@[
[_coverImageView.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-8.f],
//    [_coverImageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:8.f],
//    [_coverImageView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor constant:0.f], //привязка к середине высоты, перестает работать смещение
self.constraintCoverImageViewTopAncor, //берем из проперти, чтобы можно было менять из другого метода
[_coverImageView.widthAnchor constraintEqualToConstant: 50.f],
[_coverImageView.heightAnchor constraintEqualToConstant: 50.f]]];


    _coverImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _coverImageView.layer.cornerRadius = 8;
    _coverImageView.layer.masksToBounds = true;
    
    [NSLayoutConstraint activateConstraints:@[
[_title.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:8.f],
[_title.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:8.f],
[_title.rightAnchor constraintEqualToAnchor:self.coverImageView.leftAnchor constant: -8.f],
[_title.heightAnchor constraintEqualToConstant: 20.f] ]];
    _title.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
[_subTitle.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:8.f],
[_subTitle.topAnchor constraintEqualToAnchor:_title.bottomAnchor constant:8.f],
[_subTitle.rightAnchor constraintEqualToAnchor:self.coverImageView.leftAnchor constant: -8.f],
//[_subTitle.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant: -8.f], //_subTitle многострочный и может расширяться. При этом, если не задана жестко высота ячейки, то нижняя граница contentView не имеет ограниченийи и будет смещеться вниз сколько нужно. Для этого важно, чтобы была отключена фиксированная высота ячейки и был отключен translatesAutoresizingMaskIntoConstraints у _subTitle
]];
    _subTitle.translatesAutoresizingMaskIntoConstraints = NO;//обязательно, чтобы перестали учитываться параметры фрейма и размер элемента начал определяться констрейнтами
}

-(void) didTapCoverImage{
    ////    по нажатию кнопки опускает ее на 5, без вынесения в проперти нельзя было бы менять констрейнт
    //    self.constraintCoverImageViewTopAncor.constant = self.constraintCoverImageViewTopAncor.constant + 5.f;
    //
    //
    ////    по нажатию кнопки перемещает картинку на середину высоты
    ////     [NSLayoutConstraint activateConstraints:@[self.align]] ;
    //    [UIView animateWithDuration:0.5f animations:^{
    //        [self layoutIfNeeded ];
    //    }];
    
    
    //
    //    [UIView animateWithDuration:2.0
    //                          delay:0.0
    //                        options:UIViewAnimatingOptionBeginFromCurrentState
    //                     animations:^(void){
    //                         controller.layer.backgroundColor = [UIColor blueColor].CGColor;
    //                     }
    //                     completion:NULL];
    //
    
    
//    //картинка прыгает
//    CGRect start = self.coverImageView.frame;
//
//    [UIView animateWithDuration:0.1
//                          delay:0.0
//                        options:UIViewAnimationOptionTransitionFlipFromLeft
//                     animations:^{
//                         [self.coverImageView
//                          setFrame:CGRectMake(CGRectGetMaxX(self.contentView.frame) - 8 - 50,
//                                              CGRectGetMaxY(self.contentView.frame) - 8 - 50,
//                                              self.coverImageView.frame.size.width,
//                                              self.coverImageView.frame.size.height)];
//                     }
//                     completion:nil];
//
//    [UIView animateWithDuration:0.2
//                          delay:0.1
//                        options:UIViewAnimationOptionTransitionFlipFromLeft
//                     animations:^{
//                         [self.coverImageView
//                          setFrame:start];
//                     }
//                     completion:nil];


    [self pulseItem:self.coverImageView];
    
}
- (void) pulseItem:(UIView *)item
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

//поменять базовый лейер у ячейки таблицы
