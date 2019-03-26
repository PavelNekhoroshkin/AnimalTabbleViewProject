//
//  AnimalTableCollection.swift
//  NewProject5
//
//  Created by Павел Нехорошкин on 21.03.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

import UIKit
//import Scool


@objc class BirdViewController : UIViewController{
   
    //создадим в контроллере проперти с коллекцией, создадим ленивый инициализатор
    private lazy var collectionView : UICollectionView = {
        
        
        
        
////        создадим раскладку
//        let collectionLayout = UICollectionViewFlowLayout()
////        определим размер ячеек
////        collectionLayout.itemSize = CGSize(width: (self.view.frame.width / 2) - 10 , height: 100)
////        collectionLayout.minimumInteritemSpacing = 10
////       размер для коллекции нулевой - весь экран
////       зададим в качетва поравила раскладки созданную раскладку
//        collectionLayout.scrollDirection = .vertical
//        collectionLayout.minimumLineSpacing = 0
//        collectionLayout.minimumInteritemSpacing = 0
//        collectionLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let collectionLayout = BirdCollectionViewLayout()

        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:collectionLayout )
        collectionView.backgroundColor  = UIColor.white
        collectionView.dataSource = self
//        collectionView.delegate = self //as? UICollectionViewDelegate //делегат отвечает за метод collectionView() -> CGSize

        //создаем в отдельном классе view для каждой ячейки, и загружаем для отображения элемента коллекции
        collectionView.register(BirdCollectionViewCell.self, forCellWithReuseIdentifier: "BirdCollectionViewCell")
        
        
        return collectionView
    }()
    
    
    fileprivate var dataSource:  [String] = ["Картинка 1","Картинка2","Картинка 3","Картинка 4","Картинка 5","Картинка 6","Картинка 7","Картинка 8","Картинка 9","Картинка 10","Картинка 11","Картинка 12","Картинка 13","Картинка 14","Картинка 15"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.red
        view.addSubview(collectionView)
        
        
//        Apply this attribute to a method or function declaration to have the compiler emit a warning when the method or function is called without using its result.
//        You can use this attribute to provide a warning message about incorrect usage of a nonmutating method that has a mutating counterpart.
        let _ = BirdCollectionViewCell()
    }
    
    //без этого коллекция вообще не отображается!!!
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    
        collectionView.frame = view.frame
        
    }
}

//сделаем контроллер распределителем ячеек
extension BirdViewController : UICollectionViewDataSource{
//    первый метод - подсчет элементов
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    

//    второй метод - готовит ячейки
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //получим данные из хранилища,соответствующие ячейке
        let birdName = self.dataSource[indexPath.row]
        //пробуем получить ячейку, если успешно, то настраиваем ее данными из хранилища, соответствующими ячейке
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BirdCollectionViewCell", for: indexPath) as? BirdCollectionViewCell {
            
            cell.birdCollectionViewCellDelegete = self //укажем, кто будет отвечать за обработку событий от элементов в ячейке
            cell.title.text = birdName
            
            let imageName = "Image-"  + String(indexPath.row) + ".png"
            
            cell.coverImageView.image = UIImage(named:imageName)
         
            return cell
            
            
        }
        
        
        
        
        //если не получилось, создаем новую
        return BirdCollectionViewCell()
       
        
        
        
    }
    
    
    
    
//    func didTap(cell: BirdCollectionViewCell) {
//        print(cell.title.text!)
//
//    }
    
}



//делаем расширение и импдементируем поддержку протокола делегата
extension BirdViewController : BirdCollectionViewCellDelegete {
    func didTap(cell: BirdCollectionViewCell) {
//        print(cell.title.text!)
        let allertController = UIAlertController(title: "TEXT", message: cell.title.text!, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel)
        allertController.addAction(alertAction)
        
        present(allertController, animated: true, completion: nil)

    }

    func viewCurlUp(view:UIView,animationTime:Float)
    {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(UIView.AnimationCurve.easeInOut)
        UIView.setAnimationDuration(TimeInterval(animationTime))
        UIView.setAnimationTransition(UIView.AnimationTransition.curlUp, for: view, cache: false)
        
        UIView.commitAnimations()
    }
    
    func viewCurlDown(view:UIView,animationTime:Float)
    {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(UIView.AnimationCurve.easeInOut)
        UIView.setAnimationDuration(TimeInterval(animationTime))
        UIView.setAnimationTransition(UIView.AnimationTransition.curlDown, for: view, cache: false)
        
        UIView.commitAnimations()
    }
    
    func viewFlipFromLeft(view:UIView,animationTime:Float)
    {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(UIView.AnimationCurve.easeInOut)
        UIView.setAnimationDuration(TimeInterval(animationTime))
        UIView.setAnimationTransition(UIView.AnimationTransition.flipFromLeft, for: view, cache: false)
        
        UIView.commitAnimations()
    }
    
    func viewMoveInFromTop(view:UIView,animationTime:Float)
    {
        let animation:CATransition = CATransition()
        animation.duration = CFTimeInterval(animationTime)
        animation.type = CATransitionType(rawValue: "moveIn")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName(rawValue: "easeInEaseOut"))
        animation.subtype = CATransitionSubtype(rawValue: "fromBottom")
        animation.fillMode = CAMediaTimingFillMode(rawValue: "forwards")
        view.layer.add(animation, forKey: nil)
        
    }
    
    func animationRotationEffect(view:UIView,animationTime:Float)
    {
        UIView.animate(withDuration: TimeInterval(animationTime), animations: { () -> Void in
            
            let animation:CABasicAnimation = CABasicAnimation(keyPath: "transform")
            animation.toValue = NSValue(caTransform3D:CATransform3DMakeRotation(CGFloat(Double.pi), 1, 1, 1))
            
            animation.duration = CFTimeInterval(animationTime)
            animation.isCumulative = true
            animation.repeatCount  = 2
            
            view.layer.add(animation, forKey: nil)
        })
    }
    
    func animationScaleEffect(view:UIView,animationTime:Float)
    {
        UIView.animate(withDuration: TimeInterval(animationTime), animations: {
            
            view.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            
        },completion:{completion in
            UIView.animate(withDuration: TimeInterval(animationTime), animations: { () -> Void in
                
                view.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        })
        
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // check text and do something
        
        
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//    {
//        // In this function is the code you must implement to your code project if you want to change size of Collection view
//        let width  = (view.frame.width-20)/3
//        return CGSize(width: width, height: width)
//    }
}





//extension BirdViewController: UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//    {
//        switch indexPath.row%4 {
//        case 0:
//            return CGSize(width: (collectionView.frame.width-20)/2, height: 200)
//        case 1:
//            return CGSize(width: (collectionView.frame.width-20)/2, height: 150)
//        case 2:
//            return CGSize(width: (collectionView.frame.width-20)/2, height: 150)
//        default:
//             return CGSize(width: (collectionView.frame.width-20)/2, height: 200)
//        }
//        // In this function is the code you must implement to your code project if you want to change size of Collection view
//        return CGSize(width: 300, height: 700)
//    }
//
//
//}






//collectionview.
//ДЗ два столбца ячейки со сдвигом по высоте первый столбец , в каждом столбце чередуются большие 100 и низкие 50 ячекй, они чередуются шахматно второй ниже на 50
