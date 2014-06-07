//
//  Flight.swift
//  Flight Fight
//
//  Created by asduk on 14-6-7.
//  Copyright (c) 2014年 asduk. All rights reserved.
//

import UIKit

class Flight: UIView {
    
    init(frame: CGRect){
        super.init(frame:CGRect())
        self.frame=CGRectMake(0, 0, 66, 80);
        
        let flight1=self.getImageRef(CGPointMake(432, 332));
        let flight2=self.getImageRef(CGPointMake(432, 0));
        
        var flight=UIImageView(image:flight1);
        flight.animationImages=[flight1,flight2];
        flight.animationRepeatCount=NSNotFound;
        flight.animationDuration=0.25;
        flight.center=self.center;
        flight.startAnimating();
        self.addSubview(flight);
        

    }
    
    func getImageRef(p:CGPoint!)->UIImage{
        var imgRef=CGImageCreateWithImageInRect(UIImage(named:"gameArts").CGImage , CGRectMake(p.x, p.y, 66, 80));
        var uiImg=UIImage(CGImage: imgRef);
        return uiImg;
    }

    
}
