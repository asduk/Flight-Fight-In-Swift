//
//  ViewController.swift
//  Flight Fight
//
//  Created by asduk on 14-6-5.
//  Copyright (c) 2014年 asduk. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation
import Foundation

var labelTitle:UILabel!;
var labelStart:UILabel!;
var flight:Flight!;
var tapToStart:UITapGestureRecognizer!;
var fireTimer:NSTimer!;
var avplayer:AVAudioPlayer!;
var player:AVAudioPlayer!;
var enemyTimer:NSTimer!;
var timeLine=0;



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

        
        labelTitle=UILabel(frame:CGRectMake(0,0,180,50));
        labelTitle.center=CGPointMake(self.view.center.x+10, self.view.center.y-150);
        labelTitle.text="Flight Fight";
        labelTitle.font=UIFont.systemFontOfSize(30);
        labelTitle.textColor=UIColor.grayColor();
        self.view.addSubview(labelTitle);
        
        
        labelStart=UILabel(frame:CGRectMake(labelTitle.frame.size.width+25,300,90,50))
        
        labelStart.center=CGPointMake(self.view.center.x, labelStart.center.y+90);
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
        flight!.center=CGPointMake(self.view.center.x, self.view.center.y+130);
        self.view.addSubview(flight!);
        
        let pan=UIPanGestureRecognizer(target: self , action: "move:")
        flight!.addGestureRecognizer(pan);
        flight!.userInteractionEnabled=true;
        
        let bgSound = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("game_music",ofType:"mp3"));
        avplayer=AVAudioPlayer(contentsOfURL :bgSound, error :nil);
        avplayer.numberOfLoops=NSNotFound;
        avplayer.prepareToPlay();
        avplayer.play();
        
        enemyTimer=NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "enemy", userInfo: nil, repeats: true);
        enemyTimer.fire();
        
        timeLine=0;
    }
    func enemy(){
        timeLine++;
        var y = arc4random() % 4 + 1;
        
        if timeLine%2==0{
            
            var enemy1=Enemy(enemyType: EnemyType.enemy_1);
            enemy1.center=CGPointMake(60*CGFloat(y), -30);
            self.view.addSubview(enemy1);
            self.enemyFly(enemy1, type: EnemyType.enemy_1);
        }else if timeLine%3==0{
            
            var enemy2=Enemy(enemyType: EnemyType.enemy_2);
            enemy2.center=CGPointMake(60*CGFloat(y), -70);
            self.view.addSubview(enemy2);
            self.enemyFly(enemy2, type: EnemyType.enemy_2);
            
        }
        if timeLine%6==0{
            
        }
        
    }
    
    func enemyFly(enemy:Enemy,type:EnemyType){
        
        if type==EnemyType.enemy_1{
            
            UIView.animateWithDuration(4, animations: {
                UIView.setAnimationCurve(UIViewAnimationCurve.Linear);
                enemy.center=CGPointMake(enemy.center.x, 600);
                }, completion: {(finished:Bool) in
                    enemy.removeFromSuperview();
                })
        }else if type==EnemyType.enemy_2{
            UIView.animateWithDuration(7, animations: {
                UIView.setAnimationCurve(UIViewAnimationCurve.Linear);
                enemy.center=CGPointMake(enemy.center.x, 600);
                }, completion: {(finished:Bool) in
                    enemy.removeFromSuperview();
                })
            
        }
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
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),{
            let bgSound = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("bullet",ofType:"mp3"));
            player=AVAudioPlayer(contentsOfURL :bgSound, error :nil);
            player.prepareToPlay();
            player.play();
            }
            
        )
        
        var bullet=Bullet(frame:CGRectZero);
        bullet.center=CGPointMake(flight.center.x, flight.center.y-45);
        self.view.addSubview(bullet);
        UIView.animateWithDuration(1, animations: {
            
            UIView.setAnimationCurve(UIViewAnimationCurve.Linear);
            bullet.center=CGPointMake(bullet.center.x, -10);
            }, completion:  {(finished:Bool) in
                bullet.removeFromSuperview();
            });
    }
    
    
}

