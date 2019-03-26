//
//  BirdCollectionViewCellDelegate.swift
//  NewProject5
//
//  Created by Павел Нехорошкин on 23.03.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

import UIKit

protocol BirdCollectionViewCellDelegete : class {
    func didTap(cell: BirdCollectionViewCell)
    func viewCurlUp(view:UIView,animationTime:Float)
    func viewCurlDown(view:UIView,animationTime:Float)
    func viewFlipFromLeft(view:UIView,animationTime:Float)
    func viewMoveInFromTop(view:UIView,animationTime:Float)
    func animationRotationEffect(view:UIView,animationTime:Float)

}
