//
//  CoolectionViewCell.swift
//  NewProject5
//
//  Created by Павел Нехорошкин on 21.03.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

import UIKit

final internal class BirdCollectionViewCell : UICollectionViewCell{
    
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
        
//        //можно стразу добавлять нескольео констрейнтов
//
//        addConstraints([
//        NSLayoutConstraint(item: coverImageView,
//                        attribute: .left  ,
//                        relatedBy: .equal ,
//                        toItem: self.contentView,
//                        attribute: .left,
//                        multiplier: 1.0,
//                        constant: 8.0),
//
//        NSLayoutConstraint(item: coverImageView,
//                        attribute: .top  ,
//                        relatedBy: .equal ,
//                        toItem: self.contentView,
//                        attribute: .top,
//                        multiplier: 1.0,
//                        constant: 8.0),
//
//        NSLayoutConstraint(item: coverImageView,
//                        attribute: .height ,
//                        relatedBy: .equal,
//                        toItem: nil,
//                        attribute: .notAnAttribute,
//                        multiplier: 1.0,
//                        constant: 50.0),
//
//        NSLayoutConstraint(item: coverImageView,
//                        attribute: .width ,
//                        relatedBy: .equal,
//                        toItem: nil,
//                        attribute: .notAnAttribute,
//                        multiplier: 1.0,
//                        constant: 50.0)
//    ])
//
    }
    
    //сделаем обязательный инициализатор, унаследованный из UIView
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //birdCollectionViewCellDelegete опционал, его можно не определять
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 5
//        оставим по 25 с каждой стороны картинки
        let coverImageViewX = (self.frame.width - 80) / 2
        coverImageView.frame = CGRect(x: coverImageViewX, y: 10, width: 90, height: 90)

//        coverImageView.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        coverImageView.layer.cornerRadius = 5;

        let titleY = coverImageView.frame.maxY + 5
        let titleWidth = self.frame.width - 20
        title.frame = CGRect(x: 10, y: titleY, width: titleWidth, height: 15)
//        title.backgroundColor = UIColor.white
        title.textAlignment = .center

        let buttonY = title.frame.maxY + 5
        button.frame = CGRect(x: (self.frame.width-50)/2, y: buttonY, width: 50, height: 20)
        button.layer.cornerRadius = 8
        coverImageView.isUserInteractionEnabled = true

        
        
       
        
        
//
//        let constraint = coverImageView.leftAnchor .constraint(
//            equalTo: self.leftAnchor
//        )
//        constraint.isActive = true
//        NSLayoutConstraint.activate([
//            // Place the button at the center of its parent
//            button.centerXAnchor.constraint(equalTo: parent.centerXAnchor),
//            button.centerYAnchor.constraint(equalTo: parent.centerYAnchor),
//
//            // Give the label a minimum width based on the button’s width
//            title.widthAnchor.constraint(greaterThanOrEqualTo: button.widthAnchor),
//
//            // Place the label 20 points beneath the button
//            label.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20),
//            label.centerXAnchor.constraint(equalTo: button.centerXAnchor)
//            ])
//
    }
    
    
    @objc func didTap(){
//        print(title.text)
        
        
        //меняем цвет кнопки
        if self.isButtonPressed == true {
            self.isButtonPressed = false
            self.button.backgroundColor = UIColor.gray
        } else {
            self.isButtonPressed = true
            self.button.backgroundColor = UIColor.black
        }
        
        switch countAnimation {
        case 0:
            birdCollectionViewCellDelegete?.viewCurlDown(view:coverImageView,animationTime:0.5)
//            birdCollectionViewCellDelegete?.didTap(cell: self)
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
        self.countAnimation += 1
        if countAnimation == 5 {countAnimation = 0}

    }
    
    
}
