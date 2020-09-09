//
//  ViewController.swift
//  Xylophone
//
//  Created by John Lawrence Salvador on 6/30/20.
//  Copyright © 2020 JLCS Inc. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // MARK: - Enums
    enum XyloKey: Int, CaseIterable {
        case cKey = 0
        case dKey
        case eKey
        case fKey
        case gKey
        case aKey
        case bKey
        
        func getSound() -> String {
            switch self {
            case .cKey:
                return "C"
            case .dKey:
                return "D"
            case .eKey:
                return "E"
            case .fKey:
                return "F"
            case .gKey:
                return "G"
            case .aKey:
                return "A"
            case .bKey:
                return "B"
            }
        }
    }
    
    // MARK: - Properties
    private var player: AVAudioPlayer!
    
    // MARK: - View Life Cylce
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - Private Helpers
    private func playSound(for key: XyloKey) {
        guard let url = Bundle.main.url(forResource: key.getSound(), withExtension: "wav") else { return }
        player = try! AVAudioPlayer(contentsOf: url)
        player.play()
    }

    // MARK: - IBActions
    @IBAction func keyPressed(_ sender: UIButton) {
        guard let key = XyloKey(rawValue: sender.tag) else { return }
        
        sender.alpha = 0.5
        print("Start")
        
        self.playSound(for: key)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            print("End")
            sender.alpha = 1
        }
    }
    
}

