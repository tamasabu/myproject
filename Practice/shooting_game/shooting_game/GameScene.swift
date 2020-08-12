
import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    var haikei : SKSpriteNode!
    var spaceship: SKSpriteNode!
    var hearts: [SKSpriteNode] = []
    var scoreLabel: SKLabelNode!
    var gameVC: GameViewController!
    
    let motionManager = CMMotionManager()
    var accelaration: CGFloat = 0.0
    
    var timer: Timer?
    var timeForAsteroud: Timer?
    var asteroudDuration: TimeInterval = 6.0 {
        didSet{
            if asteroudDuration < 2.0 {
                timeForAsteroud?.invalidate()
            }
        }
    }
    var score: Int = 0 {
        //didSetを設ける事でscoreに値が代入されるたびにscoreLabelのtextが処理される
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    //ノードIDの設定
    let spaceshipCategory: UInt32 = 0b0001
    let missileCategory: UInt32 = 0b0010
    let asteroidCategory: UInt32 = 0b0100
    let earthCategory: UInt32 = 0b1000
    
    //初期処理
    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        //背景の設定
        self.haikei = SKSpriteNode(imageNamed: "earth")
        self.haikei.xScale = 1.5
        self.haikei.yScale = 0.3
        self.haikei.position = CGPoint(x: 0, y: -frame.height / 2)
        self.haikei.zPosition = -1.0
        //背景の当たり判定
        self.haikei.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: frame.width, height: 100))
        self.haikei.physicsBody?.categoryBitMask = earthCategory
        self.haikei.physicsBody?.contactTestBitMask = asteroidCategory
        self.haikei.physicsBody?.collisionBitMask = 0
        addChild(self.haikei)
        
        //宇宙船の初期位置
        self.spaceship = SKSpriteNode(imageNamed: "spaceship")
        self.spaceship.scale(to: CGSize(width: frame.width / 5, height: frame.width / 5))
        self.spaceship.position = CGPoint(x: 0, y: self.haikei.frame.maxY + 50)
        //宇宙船の当たり判定
        self.spaceship.physicsBody = SKPhysicsBody(circleOfRadius: self.spaceship.frame.width * 0.1)
        self.spaceship.physicsBody?.categoryBitMask = spaceshipCategory
        self.spaceship.physicsBody?.contactTestBitMask = asteroidCategory
        self.spaceship.physicsBody?.collisionBitMask = 0
        addChild(self.spaceship)
        
        //加速度の設定
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!){(data, _) in
            guard let data = data else{ return }
            let a = data.acceleration
            self.accelaration = CGFloat(a.x) * 0.75 + self.accelaration * 0.25
        }
        //sscheduledTimerが一秒毎にblock内の処理を行う
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            self.addAsteroid()
        })
        //体力の表示
        for i in 1...5{
            let heart = SKSpriteNode(imageNamed: "heart")
            heart.position = CGPoint(x: -frame.width / 2 + heart.frame.height * CGFloat(i), y: frame.height / 2 - heart.frame.height)
            addChild(heart)
            hearts.append(heart)
        }
        //スコアの表示
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.fontName = "Papyrus"
        scoreLabel.fontSize = 50
        scoreLabel.position = CGPoint(x: -frame.width / 2 + scoreLabel.frame.width / 2 + 50 , y: frame.height / 2 - scoreLabel.frame.height * 5)
        addChild(scoreLabel)
        //ベストスコア表示
        let bestScore = UserDefaults.standard.integer(forKey: "bestScore")
        let bestScoreLabel = SKLabelNode(text: "Best Score: \(bestScore)")
        bestScoreLabel.fontName = "Papyrus"
        bestScoreLabel.fontSize = 30
        bestScoreLabel.position = scoreLabel.position.applying(CGAffineTransform(translationX: 0, y: -bestScoreLabel.frame.height * 1.5))
        addChild(bestScoreLabel)
        //惑星の加速
        timeForAsteroud = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { _ in
            self.asteroudDuration -= 0.5
        })
    }
    
    //フレーム毎にされる処理
    override func didSimulatePhysics() {
        let nextPosition = self.spaceship.position.x + self.accelaration * 50
        if nextPosition > frame.width / 2 - 30 { return }
        if nextPosition < -frame.width / 2 + 30 { return }
        self.spaceship.position.x = nextPosition
    }
    
    //惑星をを呼び出す処理
    func addAsteroid() {
        let names = ["asteroid1", "asteroid2", "asteroid3"]
        let index = Int(arc4random_uniform(UInt32(names.count))) //ランダムな整数を設定する最大値はnames.count
        let name = names[index]
        let asteroid = SKSpriteNode(imageNamed: name)
        let random = CGFloat(arc4random_uniform(UINT32_MAX)) / CGFloat(UINT32_MAX) //ランダムな数字を決める
        let positionX = frame.width * (random - 0.5) //出現位置を決める
        asteroid.position = CGPoint(x: positionX, y: frame.height / 2 + asteroid.frame.height)
        asteroid.scale(to: CGSize(width: 70, height: 70))
        //惑星の当たり判定
        asteroid.physicsBody = SKPhysicsBody(circleOfRadius: asteroid.frame.width)
        asteroid.physicsBody?.categoryBitMask = asteroidCategory
        asteroid.physicsBody?.contactTestBitMask = missileCategory + spaceshipCategory + earthCategory
        asteroid.physicsBody?.collisionBitMask = 0
        addChild(asteroid)
        //上から下に移動する処理
        let move = SKAction.moveTo(y: -frame.height / 2 - asteroid.frame.height, duration: asteroudDuration)
        let remove = SKAction.removeFromParent()
        asteroid.run(SKAction.sequence([move, remove]))
    }
    //衝突すると呼ばれる処理
    func didBegin(_ contact: SKPhysicsContact) {
        var asteroid: SKPhysicsBody
        var target: SKPhysicsBody
        
        //bodyAが惑星だった場合
        if contact.bodyA.categoryBitMask == asteroidCategory {
            asteroid = contact.bodyA
            target = contact.bodyB
        } else {
            //bodyBが惑星だった場合
            asteroid = contact.bodyB
            target = contact.bodyA
        }
        //ノードIDnilチェック
        guard let asteroidNode = asteroid.node else { return }
        guard let targetNode = target.node else { return }
        guard let explosion = SKEmitterNode(fileNamed: "Explosion") else { return }
        //爆発エフェクト処理
        explosion.position = asteroidNode.position
        addChild(explosion)
        //惑星の消滅処理
        asteroidNode.removeFromParent()
        //ミサイルに当たった場合
        if target.categoryBitMask == missileCategory {
            targetNode.removeFromParent()
            score += 5
        }
        //1秒間に一回呼ぶ処理
        self.run(SKAction.wait(forDuration: 1.0)) {
            explosion.removeFromParent()
        }
        //宇宙船または地球に惑星が衝突した場合
        if target.categoryBitMask == spaceshipCategory || target.categoryBitMask == earthCategory {
            guard let heart = hearts.last else { return }
            //ハートが一つ減る処理
            heart.removeFromParent()
            hearts.removeLast()
            //ハートが０の場合ゲームオーバー処理へ
            if hearts.isEmpty {
                gameOver()
            }
        }
    }
    //ゲームオーバー処理
    func gameOver() {
        isPaused = true
        timer?.invalidate()
        //ベストスコア更新時の処理
        let bestScore = UserDefaults.standard.integer(forKey: "bestScore")
        if score > bestScore {
            UserDefaults.standard.set(score, forKey: "bestScore")
        }
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false){ _ in
            self.gameVC.dismiss(animated: true, completion: nil)
        }
    }
    //画面をタッチしたときの処理
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let missile = SKSpriteNode(imageNamed: "missile")
        missile.position = CGPoint(x: self.spaceship.position.x, y: self.spaceship.position.y + 50)
        addChild(missile)
        //ミサイルに当たり判定
        missile.physicsBody = SKPhysicsBody(circleOfRadius: missile.frame.height / 2)
        missile.physicsBody?.categoryBitMask = missileCategory
        missile.physicsBody?.contactTestBitMask = asteroidCategory
        missile.physicsBody?.collisionBitMask = 0
        
        let moveToTop = SKAction.moveTo(y: frame.height + 10, duration: 0.3)
        let remove = SKAction.removeFromParent()
        missile.run(SKAction.sequence([moveToTop, remove]))
    }
    
}
