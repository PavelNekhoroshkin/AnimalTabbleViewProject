//
//  CoolectionViewCell.swift
//  NewProject5
//
//  Created by Павел Нехорошкин on 21.03.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

import UIKit

final internal class BirdCollectionViewCell : UICollectionViewCell
{
    
    weak var birdCollectionViewCellDelegete : BirdCollectionViewCellDelegete?
    let coverImageView = UIImageView()
    let title = UILabel()
    let button = UIButton()
    var isButtonPressed = false
    
    var countAnimation = 0
    
    
    //создадим инициализатор convinience
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGray

        coverImageView.backgroundColor = UIColor.lightGray
        button.backgroundColor = UIColor.lightGray
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        button.backgroundColor = UIColor.gray
        button.setTitle("push", for: .normal)
        
        
        self.addSubview(coverImageView)
        self.addSubview(title)
        self.addSubview(button)
        //у каждого рисунка есть подпись и кнопка

        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    //сделаем обязательный инициализатор, унаследованный из UIView
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //birdCollectionViewCellDelegete опционал, его можно не определять
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 5
        
        let coverImageViewX = (self.frame.width - 80) / 2
        coverImageView.frame = CGRect(x: coverImageViewX, y: 10, width: 90, height: 90)
        coverImageView.layer.cornerRadius = 5;

        let titleY = coverImageView.frame.maxY + 5
        let titleWidth = self.frame.width - 20
        title.frame = CGRect(x: 10, y: titleY, width: titleWidth, height: 15)
        title.textAlignment = .center

        let buttonY = title.frame.maxY + 5
        button.frame = CGRect(x: (self.frame.width-50)/2, y: buttonY, width: 50, height: 20)
        button.layer.cornerRadius = 8
        coverImageView.isUserInteractionEnabled = true

    }
    
    
    @objc func didTap()
    {

        //меняем цвет кнопки
        if self.isButtonPressed == true
        {
            self.isButtonPressed = false
            self.button.backgroundColor = UIColor.gray
        } else
        {
            self.isButtonPressed = true
            self.button.backgroundColor = UIColor.black
        }
        //перебираем варианты анимации по счетчику
        switch countAnimation
        {
            case 0:
                birdCollectionViewCellDelegete?.viewCurlDown(view:coverImageView,animationTime:0.5)
            case 1:
                birdCollectionViewCellDelegete?.viewMoveInFromTop(view:coverImageView,animationTime:0.5)
            case 2:
                birdCollectionViewCellDelegete?.animationRotationEffect(view:coverImageView,animationTime:0.5)
            case 3:
                birdCollectionViewCellDelegete?.viewFlipFromLeft(view:coverImageView,animationTime:0.5)
            case 4:
                birdCollectionViewCellDelegete?.viewCurlUp(view:coverImageView,animationTime:0.5)
            default:
                break
        }
        //счетчик
        self.countAnimation += 1
        if countAnimation == 5 {countAnimation = 0}

    }
    
}
