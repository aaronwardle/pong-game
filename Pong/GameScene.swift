//
//  GameScene.swift
//  Pong
//
//  Created by Aaron Wardle on 13/03/2018.
//  Copyright © 2018 Aaron Wardle. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
        
    private var leftPaddle : SKSpriteNode?
    private var ballObject : SKShapeNode?
    
    override func didMove(to view: SKView) {
        
        // Setting up some physics as a test
        let worldBorder = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody = worldBorder
        self.physicsBody?.friction = 1
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -1)
        view.showsPhysics = true
    }
    
    override func sceneDidLoad() {

        createBall()
        self.lastUpdateTime = 0
        
        self.leftPaddle = self.childNode(withName: "//leftPaddle") as? SKSpriteNode
        
    }
    
    func createBall() {
        
        let path = CGMutablePath()
        path.addArc(center: CGPoint.zero,
                    radius: 15,
                    startAngle: 0,
                    endAngle: CGFloat.pi * 2,
                    clockwise: true)
        let ball = SKShapeNode(path: path)
        
        ball.lineWidth = 1
        
        ball.fillColor = .white
        ball.strokeColor = .white
        ball.glowWidth = 0.5

        ball.physicsBody = SKPhysicsBody(circleOfRadius: 13/2)
        
        self.addChild(ball)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {
        leftPaddle?.position.y = pos.y
    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        if let leftPaddle = self.leftPaddle {
//            leftPaddle.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchMoved(toPoint: t.location(in: self))
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
