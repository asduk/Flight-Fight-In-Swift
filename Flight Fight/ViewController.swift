//
//  ViewController.swift
//  Flight Fight
//
//  Created by asduk on 14-6-5.
//  Copyright (c) 2014年 asduk. All rights reserved.
//

import UIKit
import QuartzCore


var labelTitle:UILabel!;
var labelStart:UILabel!;
var flight:Flight!;
var tapToStart:UITapGestureRecognizer!;
var fireTimer:NSTimer!;

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let bgRect1=CGRectMake(0, 0, 320, 568);
        
        var imgRef=CGImageCreateWithImageInRect(UIImage(named:"gameArts").CGImage , bgRect1)
        
        let bgimg1=UIImageView(image:UIImage(CGImage: imgRef));
        bgimg1.layer.anchorPoint=CGPointZero;
        bgimg1.center=CGPointZero;
        self.view.addSubview(bgimg1);
        
        let bgimg2=UIImageView(image:UIImage(CGImage: imgRef));
        bgimg2.layer.anchorPoint=CGPointZero;
        bgimg2.center=CGPointMake(0, -568);
        self.view.addSubview(bgimg2);
        
        //cloud and sky
        UIView.animateWithDuration(10,
            animations:{
                UIView.setAnimationRepeatCount(10000);
                UIView.setAnimationCurve(UIViewAnimationCurve.Linear);
                bgimg1.center=CGPointMake(0, 568);
                bgimg2.center=CGPointMake(0, 0);
            },
            completion:  {(finished:Bool) in
                bgimg1.center=CGPointMake(0, 0);
                bgimg2.center=CGPointMake(0, -568);
            });

        
        labelTitle=UILabel(frame:CGRectMake(0,0,120,50));
        labelTitle.center=CGPointMake(self.view.center.x, self.view.center.y-50);
        labelTitle.text="Flight Fight";
        labelTitle.font=UIFont.systemFontOfSize(22);
        labelTitle.textColor=UIColor.blueColor();
        self.view.addSubview(labelTitle);
        
        
        labelStart=UILabel(frame:CGRectMake(labelTitle.frame.size.width+25,300,90,50))
        
        labelStart.center=CGPointMake(self.view.center.x, labelStart.center.y);
        labelStart.text="Tap to start!";
        labelStart.font=UIFont.systemFontOfSize(15);
        labelStart.textColor=UIColor.redColor();
        self.view.addSubview(labelStart);
        
        
        
        
        tapToStart=UITapGestureRecognizer(target: self , action: "start:");
        self.view.addGestureRecognizer(tapToStart!);
        self.view.userInteractionEnabled=true;
        
        
        UIView.animateWithDuration(1, animations: {
            UIView.setAnimationRepeatAutoreverses(true);
            UIView.setAnimationRepeatCount(10000);
            labelStart.alpha=0
            }, completion: nil);
        
        
       
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func start(sender :UITapGestureRecognizer!){
        labelStart.removeFromSuperview();
        labelTitle.removeFromSuperview();
        self.loadGame();
    }
    //loadFlight and gesture
    func loadGame(){
        
        self.view.removeGestureRecognizer(tapToStart!);
        flight=Flight(frame:CGRectZero);
        flight!.center=CGPointMake(self.view.center.x, self.view.center.y+100);
        self.view.addSubview(flight!);
        
        let pan=UIPanGestureRecognizer(target: self , action: "move:")
        flight!.addGestureRecognizer(pan);
        flight!.userInteractionEnabled=true;
        
        
    }
    
    func move(sender :UIPanGestureRecognizer!){
        if sender.state==UIGestureRecognizerState.Began{
            //fire
            println("fire");
            fireTimer=NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "bullet", userInfo: nil, repeats: true);
            fireTimer.fire();
            
        }else if sender.state==UIGestureRecognizerState.Changed{
            
            var p=sender.locationInView(self.view!);
            flight.center=p;
            println("\(p)");
            
        }else if sender.state==UIGestureRecognizerState.Ended{
            //endfire
            println("endfire");
            fireTimer.invalidate();
        }
    }
    
    func bullet(){
        var bullet=Bullet(frame:CGRectZero);
        bullet.center=CGPointMake(flight.center.x, flight.center.y-45);
        self.view.addSubview(bullet);
        UIView.animateWithDuration(1, animations: {
            UIView.setAnimationCurve(UIViewAnimationCurve.Linear);
            bullet.center=CGPointMake(bullet.center.x, -10);
            });
    }
    
}

