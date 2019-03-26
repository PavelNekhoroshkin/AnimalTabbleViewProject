//
//  BirdCollectionViewLayout.swift
//  NewProject5
//
//  Created by Павел Нехорошкин on 26.03.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

import UIKit


class BirdCollectionViewLayout: UICollectionViewLayout
{
  
    var numberOfColumns = 2
    var cellPadding: CGFloat = 4
    var arrayOfAtributesForCollectionViewLayout = [UICollectionViewLayoutAttributes]()
    var contentHeight: CGFloat = 0
    
    var contentWidth: CGFloat
    {
        guard let collectionView = collectionView else
        {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare()
    {
        //вычисляем один раз все координаты всех ячеек и сохраняем их в массиве свойств
        guard arrayOfAtributesForCollectionViewLayout.isEmpty == true, let collectionView = collectionView else {
            return
        }
        
        //отступ первой и второй колонки
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        
        var xOffset = [CGFloat]()
        
        for column in 0 ..< numberOfColumns
        {
            xOffset.append(CGFloat(column) * columnWidth)//для первой колонки отступ нудевой, для второй - ширина колонок
        }
        
        //первый элемент, первая колонка
        var column = 0
        
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)//массив отступов по высоте для каждой ячейки, сперва заполнен нулями
        
        //перебираем все ячейки (есть только одна секция, в ней все ячейки)
        for item in 0 ..< collectionView.numberOfItems(inSection: 0)
        {
            
            //генерируем indexPath ячейки, для которой выполняется рассчет параметра
            let indexPath = IndexPath(item: item, section: 0)
            
            //выполняется рассчет координат ВСЕХ ячеек для ВСЕХ рисунков на основании данных о высоте рисунка, отступах, номере ячейки, колонки ячейки
            var photoHeight = CGFloat(200)
            
            switch (item%4)
            {
                case 1:photoHeight = CGFloat(150)
                case 2:photoHeight = CGFloat(150)
                default:break
            }
            
            //высота одной ячейки
            let height = cellPadding * 2 + photoHeight
            
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            

            //генерируем объект атрибутов, который хранит свойства ячейки, вначале он пустой
            let atributesForCollectionViewLayout = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            //заполняем данные фрейма ячейки с учетом уменьшения на размер отступов
            atributesForCollectionViewLayout.frame = insetFrame
            
            //добавляем объект с данными ячейки в массив
            arrayOfAtributesForCollectionViewLayout.append(atributesForCollectionViewLayout)
            
            //максимум рассчетной высоты и высотя по умолчанию, которую можно задать в пропертях
            contentHeight = max(contentHeight, frame.maxY)
            
            //сдвинем счетчик отступа по высоте вниз на высоту добавленной ячейки
            yOffset[column] = yOffset[column] + height
            
            //следующая ячейка будет располагаться в колонке правее, пока не дойдем до конца ряда, получим номер колонки
            column = column < (numberOfColumns - 1) ?    (column + 1) : 0
        }
    }
    
    
    //проверяем пересекается ли лдаееый rect с каким либо другим из кэша
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]?
    {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Loop through the cache and look for items in the rect
        for attributes in arrayOfAtributesForCollectionViewLayout
        {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes?
    {
        return arrayOfAtributesForCollectionViewLayout[indexPath.item]
    }
    
}

