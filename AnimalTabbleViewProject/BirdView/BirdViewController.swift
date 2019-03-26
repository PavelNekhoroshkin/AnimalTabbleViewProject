//
//  AnimalTableCollection.swift
//  NewProject5
//
//  Created by Павел Нехорошкин on 21.03.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

import UIKit

@objc class BirdViewController : UIViewController
{
   
    //создадим в контроллере проперти с коллекцией, создадим ленивый инициализатор
    private lazy var collectionView : UICollectionView =
    {

        let collectionLayout = BirdCollectionViewLayout()

        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:collectionLayout )
        
        collectionView.backgroundColor  = UIColor.white
        collectionView.dataSource = self
        collectionView.register(BirdCollectionViewCell.self, forCellWithReuseIdentifier: "BirdCollectionViewCell")
        
        return collectionView
    }()
    
    
    fileprivate var dataSource:  [String] = ["Картинка 1","Картинка2","Картинка 3","Картинка 4","Картинка 5","Картинка 6","Картинка 7","Картинка 8","Картинка 9","Картинка 10","Картинка 11","Картинка 12","Картинка 13","Картинка 14","Картинка 15"]
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.red
        view.addSubview(collectionView)

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
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        //получим данные из хранилища,соответствующие ячейке
        let cellName = self.dataSource[indexPath.row]
        
        //пробуем получить ячейку, если успешно, то настраиваем ее данными из хранилища, соответствующими ячейке
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BirdCollectionViewCell", for: indexPath) as? BirdCollectionViewCell
        {
            //укажем, кто будет отвечать за обработку событий от элементов в ячейке
            cell.birdCollectionViewCellDelegete = self
            
            cell.title.text = cellName
            
            let imageName = "Image-"  + String(indexPath.row) + ".png"
            
            cell.coverImageView.image = UIImage(named:imageName)
         
            return cell
        }
        
        //если не получилось, создаем новую
        return BirdCollectionViewCell()
    }
}



//делаем расширение и имплементируем поддержку протокола делегата, способного обработать вызов метода по нажатию на кньопку в ячейке
extension BirdViewController : BirdCollectionViewCellDelegete
{
    //вывести алерт
    func didTap(cell: BirdCollectionViewCell)
    {
        let allertController = UIAlertController(title: "TEXT", message: cell.title.text!, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .cancel)
        
        allertController.addAction(alertAction)
        
        present(allertController, animated: true, completion: nil)
    }
    
    //перелистанипе вверх
    func viewCurlUp(view:UIView,animationTime:Float)
    {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(UIView.AnimationCurve.easeInOut)
        UIView.setAnimationDuration(TimeInterval(animationTime))
        UIView.setAnimationTransition(UIView.AnimationTransition.curlUp, for: view, cache: false)
        UIView.commitAnimations()
    }
    
    //перелистанипе вниз
    func viewCurlDown(view:UIView,animationTime:Float)
    {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(UIView.AnimationCurve.easeInOut)
        UIView.setAnimationDuration(TimeInterval(animationTime))
        UIView.setAnimationTransition(UIView.AnimationTransition.curlDown, for: view, cache: false)
        
        UIView.commitAnimations()
    }
    
    //
    func viewFlipFromLeft(view:UIView,animationTime:Float)
    {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(UIView.AnimationCurve.easeInOut)
        UIView.setAnimationDuration(TimeInterval(animationTime))
        UIView.setAnimationTransition(UIView.AnimationTransition.flipFromLeft, for: view, cache: false)
        
        UIView.commitAnimations()
    }
    
    //съезжает сверху
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
    
    //поворот в 3D вокруг наклонной оси
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
    
    //пульсация
    func animationScaleEffect(view:UIView,animationTime:Float)
    {
        UIView.animate(withDuration: TimeInterval(animationTime), animations: {
            
            view.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            
        },completion:{completion in
            UIView.animate(withDuration: TimeInterval(animationTime), animations:{ () -> Void in
                
                view.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        })
        
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    {
        
    }

}


//ДЗ два столбца ячейки со сдвигом по высоте первый столбец , в каждом столбце чередуются большие 100 и низкие 50 ячекй, они чередуются шахматно второй ниже на 50
