//
//  MainVC.swift
//  Answer Ball
//
//  Created by PJ Martinez on 9/9/15.
//  Copyright (c) 2015 Hard Part Productions. All rights reserved.
//

import UIKit
import AVFoundation

class MainVC: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var answerText: UILabel!
    
    var audioPlayer: AVAudioPlayer?
    
    var answers = [
        "I'm not a mindreader!",
        "All indicators point to YES!",
        "All indicators point to NO!",
        "Watch your language!",
        "It seems highly unlikely.",
        "Please speak up!",
        "It seems highly likely.",
        "Yes, indeed!",
        "Absolutely not!",
        "Please ask again later...",
        "Seriously?",
        "That was a dumb question.",
        "I was wondering the same thing!",
        "I can't answer that truthfully.",
        "What do you think?",
        "OMG YES!",
        "OMG NO!",
        "Imagine that!",
        "Really?",
        "Did you just ask that?",
        "Of course.",
        "Ask a higher power.",
        "The force is with you.",
        "The force is not near.",
        "You're unbelievable!",
        "Can I get a translation please?",
        "I'm gonna guess... NO!",
        "I'm gonna guess... YES!",
        "It would seem so.",
        "That does not seem to be true.",
        "Does a bear sh... never mind.",
        "I need a new profession!",
        "The odds are against that.",
        "The odds are in your favor.",
        "Can we skip this one?",
        "Ask a different question please.",
        "I'm doing good, yes I know you didn't ask.",
        "My connection to the stars was lost.",
        "Do you want the truth?",
        "I can see no answer but yes."
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent) {
        getAnswerTapped(UIEvent)
    }
    
    @IBAction func getAnswerTapped(sender: AnyObject) {
        
        answerText.text = getAnswer()
        answerText.hidden = false
        playSound()
    }
    
    func getAnswer() -> String {
        var random = Int(arc4random_uniform(UInt32(answers.count)))
        
        let result = answers[random]
        return result
    }
    
    func playSound() {
        // Play audio file when shaken or get answer tapped
        let dispatchQueue =
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_async(dispatchQueue, {[weak self] in
            let mainBundle = NSBundle.mainBundle()
            
            /* Find the location of our file to feed to the audio player */
            let filePath = mainBundle.pathForResource("shakesound", ofType:"wav")
            
            if let path = filePath{
                let fileData = NSData(contentsOfFile: path)
                
                var error:NSError?
                
                /* Start the audio player */
                self!.audioPlayer = AVAudioPlayer(data: fileData, error: &error)
                
                /* Did we get an instance of AVAudioPlayer? */
                if let player = self!.audioPlayer{
                    /* Set the delegate and start playing */
                    player.delegate = self
                    if player.prepareToPlay() && player.play(){
                        /* Successfully started playing */
                    } else {
                        /* Failed to play */
                    }
                } else {
                    /* Failed to instantiate AVAudioPlayer */
                }
            }
            
            })
    }

}
