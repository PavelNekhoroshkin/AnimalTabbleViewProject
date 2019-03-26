//
//  BirdCollectionViewLayout.swift
//  NewProject5
//
//  Created by Павел Нехорошкин on 26.03.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

import UIKit


class BirdCollectionViewLayout: UICollectionViewLayout {
    //1. Pinterest Layout Delegate
    
    //2. Configurable properties
    fileprivate var numberOfColumns = 2
    fileprivate var cellPadding: CGFloat = 6
    
    //3. Array to keep a cache of attributes.
    fileprivate var arrayOfAtributesForCollectionViewLayout = [UICollectionViewLayoutAttributes]()
    
    //4. Content height and size
    fileprivate var contentHeight: CGFloat = 0
    
    fileprivate var contentWidth: CGFloat
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
        // 1. Only calculate once
        guard arrayOfAtributesForCollectionViewLayout.isEmpty == true, let collectionView = collectionView else {
            return
        }
        // 2. Pre-Calculates the X Offset for every column and adds an array to increment the currently max Y Offset for each column
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns
        {
            xOffset.append(CGFloat(column) * columnWidth)//для первой колонки отступ нудевой, для второй - ширина колонок
        }
        
        //первая колонка
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)//массив отступов по высоте для каждой ячейки, сперва заполнен нулями
        
        // 3. Iterates through the list of items in the first section
        //перебираем все ячейки в первой секции (т.е. вообще все)
        for item in 0 ..< collectionView.numberOfItems(inSection: 0)
        {
            
            //генерируем indexPath ячейки, для которой выполняется рассчет параметра
            let indexPath = IndexPath(item: item, section: 0)
            
            // 4. Asks the delegate for the height of the picture and the annotation and calculates the cell frame.
            //выполняется рассчет координат ВСЕХ ячеек для ВСЕХ рисунков на основании данных о высоте рисунка, отступах, номере ячейки, колонки ячейки
            var photoHeight = CGFloat(200)
            switch (item%4)
            {
                case 1:photoHeight = CGFloat(150)
                case 2:photoHeight = CGFloat(150)
                default:break
            }
            let height = cellPadding * 2 + photoHeight//высота одной ячейки
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            // 5. Creates an UICollectionViewLayoutItem with the frame and add it to the cache
            //генерируем объект атрибутов, который хранит свойства ячейки, вначале он пустой
            let atributesForCollectionViewLayout = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            //заполняем данные фрейма ячейки с учетом уменьшения на размер отступов
            atributesForCollectionViewLayout.frame = insetFrame
            //добавляем объект с данными ячейки в массив
            arrayOfAtributesForCollectionViewLayout.append(atributesForCollectionViewLayout)
            
            // 6. Updates the collection view content height
            
            //максимум рассчетной высоты и явно заданной в проперти
            contentHeight = max(contentHeight, frame.maxY)
            //сдвинем счетчик отступа по высоте вниз на высоту добавленной ячейки
            yOffset[column] = yOffset[column] + height
            //следующая ячейка будет располагаться в колонке правее, пока не дойдем до конца ряда, получим номер колонки
            column = column < (numberOfColumns - 1) ?    (column + 1) : 0
        }
    }
    
    
    //проверяем пересекается ли лдаееый rect с каким либо другим из кэша
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Loop through the cache and look for items in the rect
        for attributes in arrayOfAtributesForCollectionViewLayout {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return arrayOfAtributesForCollectionViewLayout[indexPath.item]
    }
    
}

