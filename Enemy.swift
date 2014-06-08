//
//  Enemy.swift
//  Flight Fight
//
//  Created by asduk on 14-6-8.
//  Copyright (c) 2014年 asduk. All rights reserved.
//

import UIKit
var enemy:UIImageView!;
enum EnemyType: Int {
    case enemy_1,enemy_2,enemy_3
    func enemyDescription() -> String {
        switch self {
        case .enemy_1:
            return "enemy_1"
        case .enemy_2:
            return "enemy_2"
        case .enemy_3:
            return "enemy_3"

        default:
            return String(self.toRaw())
        }
    }
}

class Enemy: UIView {
    init(enemyType:EnemyType){
        super.init(frame:CGRect())
        if enemyType==EnemyType.enemy_1{
            self.frame=CGRectMake(0, 0, 34, 24)
            let enemy1_fly_1=self.getImageRef(CGRectMake(82, 657, 34, 24));
            let enemy1_blowup_1=self.getImageRef(CGRectMake(47, 657, 34, 24));
            let enemy1_blowup_2=self.getImageRef(CGRectMake(420, 729, 34, 32));
            let enemy1_blowup_3=self.getImageRef(CGRectMake(472, 719,38, 34));
            let enemy1_blowup_4=self.getImageRef(CGRectMake(479, 413,32, 32));
            
            enemy=UIImageView(image:enemy1_fly_1);
            enemy.animationImages=[enemy1_blowup_1,enemy1_blowup_2,enemy1_blowup_3,enemy1_blowup_4];
            enemy.animationRepeatCount=1;
            enemy.animationDuration=0.5;
            enemy.center=self.center;
            self.addSubview(enemy);
            
        }else if enemyType==EnemyType.enemy_2{
            self.frame=CGRectMake(0, 0, 110, 164)
            let enemy2_fly_1=self.getImageRef(CGRectMake(221, 857,110, 164));
            let enemy2_blowup_1=self.getImageRef(CGRectMake(0, 754,110, 164));
            let enemy2_blowup_2=self.getImageRef(CGRectMake(321, 171,110, 169));
            let enemy2_blowup_3=self.getImageRef(CGRectMake(321, 514,110, 169));
            let enemy2_blowup_4=self.getImageRef(CGRectMake(321, 343,110, 169));
            
            enemy=UIImageView(image:enemy2_fly_1);
            enemy.animationImages=[enemy2_blowup_1,enemy2_blowup_2,enemy2_blowup_3,enemy2_blowup_4];
            enemy.animationRepeatCount=1;
            enemy.animationDuration=0.5;
            enemy.center=self.center;
            self.addSubview(enemy);
            
        }
    }
    
    func blowUp(){
        enemy.startAnimating();
    }
    
    func getImageRef(rect:CGRect!)->UIImage{
        var imgRef=CGImageCreateWithImageInRect(UIImage(named:"gameArts").CGImage , rect);
        var uiImg=UIImage(CGImage: imgRef);
        return uiImg;
    }

}
