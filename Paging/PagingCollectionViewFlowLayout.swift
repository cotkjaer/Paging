//
//  PagingCollectionViewFlowLayout.swift
//  Paging
//
//  Created by Christian Otkjær on 05/01/17.
//  Copyright © 2017 Silverback IT. All rights reserved.
//

import UIKit

/// Layout that allows collectionviews to be paged

open class PagingCollectionViewFlowLayout:UICollectionViewFlowLayout
{
    public var onePageAtATime = false

    public init(flowLayout: UICollectionViewFlowLayout)
    {
        super.init()
        
        sectionInset = flowLayout.sectionInset
        
        itemSize = flowLayout.itemSize
        
        minimumLineSpacing = flowLayout.minimumLineSpacing
        minimumInteritemSpacing = flowLayout.minimumInteritemSpacing
        
        scrollDirection = flowLayout.scrollDirection
    }
    
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder:aDecoder)
    }
    
    // MARK: - Prepare Layout
    
    override open func prepare()
    {
        updateSectionInsets()
        
        super.prepare()
    }
    
    // MARK: - Section Insets
    
    private func updateSectionInsets()
    {
        guard let size = collectionView?.bounds.size else { return }
        
        let horizontal = (size.width - itemSize.width) / 2
        let vertical = (size.height - itemSize.height) / 2
        
        sectionInset = UIEdgeInsets(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
    
    // Mark : - Pagination
    
    var pageSize : CGSize
    {
        switch scrollDirection
        {
        case .horizontal:
            
            return itemSize + CGSize(width: minimumLineSpacing, height: minimumInteritemSpacing)
            
        case .vertical:
            
            return itemSize + CGSize(width: minimumInteritemSpacing, height: minimumLineSpacing)
        }
    }
    
    var pageLength: CGFloat { return scrollDirection == .horizontal ? itemSize.width : itemSize.height }
    
    var pageSpacing: CGFloat { return minimumLineSpacing }
    
    let flickVelocity: CGFloat = 0.3
    
    
    override open func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint
    {
        var contentOffset = proposedContentOffset
        
        if let collectionView = self.collectionView
        {
            if onePageAtATime && (velocity.magnitude > flickVelocity)
            {
                let deltaX : CGFloat = velocity.x > 0 ? 0.5 : (velocity.x == 0 ? 0 : -0.5)
                let deltaY : CGFloat = velocity.y > 0 ? 0.5 : (velocity.y == 0 ? 0 : -0.5)
                let offsetOffset = CGPoint(x: pageSize.width * deltaX, y: pageSize.height * deltaY )
                
                contentOffset = collectionView.contentOffset + offsetOffset
            }
            
            let visibleRect = CGRect(origin: contentOffset, size: collectionView.bounds.size)
            
            let center = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            
            if let attributesList = layoutAttributesForElements(in: visibleRect)
            {
                for attributes in attributesList
                {
                    if attributes.frame.contains(center)
                    {
                        return contentOffset - ( visibleRect.center - attributes.frame.center )
                    }
                }
            }
        }
        
        return contentOffset
    }
}
