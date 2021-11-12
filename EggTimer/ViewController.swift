
import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //MARK: - Atributes
    
    var player: AVAudioPlayer!
    
    let eggTimes = ["Soft": 3, "Medium": 420, "Hard": 720]
    var totalTime = 0
    var secondsPassed = 0
    
    var timer = Timer()
    
    func playAudio() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var lbText: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    //MARK: - IBActions

    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        let hardness = sender.currentTitle!
        
        progressBar.isHidden = false
        timer.invalidate()
        progressBar.progress = 0.0
        secondsPassed = 0
        lbText.text = hardness
        
        guard let result = eggTimes[hardness] else {return}
        totalTime = result
        
        //Timer
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            
            secondsPassed += 1
            progressBar.progress =  Float(secondsPassed) / Float(totalTime)
            
        } else {
            timer.invalidate()
            lbText.text = "Your Egg is Done!"
            playAudio()
        }
    }
    
}
