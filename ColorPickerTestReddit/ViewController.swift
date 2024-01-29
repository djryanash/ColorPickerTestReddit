// 
//  ViewController.swift
//  ColorPickerTestReddit
//
//  Created by Ryan Ashton on 29/1/2024 at 08:31
//  Copyright © 2024 Ryan Ashton. All rights reserved.
//
    

import UIKit

class ViewController: UIViewController {

    var myColor: PaintColor = {
        let color: PaintColor = .lightBlue
        
        return color
    }() {
        didSet {
            do {
                print("~~~ \(String(format: "%-4d", #line)) \((#fileID).components(separatedBy: "/").last!.components(separatedBy: ".").first!).\(#function).\(myColor)")
                let data = try JSONEncoder().encode(myColor)
                UserDefaults.standard.setValue(data, forKey: "color")
            } catch {
                print("~~~ \(#function) Error: \(error)")
            }
        }
    }
    
    let colorPickerButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemPink
        return button
    }()
    
    @objc func setTint(_ sender: UIButton) {
        let colors = PaintColor.allCases
        if let randoColor = colors.randomElement() {
            let uiColor = UIColor(hexString: randoColor.rawValue)
            sender.tintColor = uiColor
            sender.setTitle(String(describing: randoColor), for: .normal)
            myColor = randoColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkUserDefaults()
        setupUI()
        
    }
    
    func checkUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: "color") {
            do {
                let decodedColor = try JSONDecoder().decode(PaintColor.self, from: data)
                myColor = decodedColor
            } catch {
                print("~~~ \(#function) Error: \(error)")
            }
        }
    }
    
    func setupUI() {
        view.addSubview(colorPickerButton)
        colorPickerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        colorPickerButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        colorPickerButton.addTarget(self, action: #selector(setTint(_:)), for: .touchUpInside)
        colorPickerButton.tintColor = UIColor(hexString: myColor.rawValue)
        colorPickerButton.setTitle(String(describing: myColor), for: .normal)
        
    }


}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var hexInt: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&hexInt)
        let red = CGFloat((hexInt & 0xFF000) >> 16) / 255.0
        let green = CGFloat((hexInt & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hexInt & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
        
enum PaintColor: String, CaseIterable, Codable {
    
    case red = "F1696D"
    case redOrange = "FD8568"
    case orange = "F3A655"
    case yellow = "E8C32A"
    case green = "48C35C"
    case teal = "00CAAC"
    case lightBlue = "00C7DA"
    case blue = "00B2F0"
    case blurple = "4E68BD"
    case purple = "855AB9"
    case lilac = "B477DB"
    case pink = "EC85CB"
    case lightGray = "BBBBBB"
    case gray = "88929C"
    case brown = "4E3424"
    case black = "2F2F2F"
    
    var id: Self { self }
}

/*
 
 case red = "2F2F20"
 case redOrange = "2F2F21"
 case orange = "2F2F22"
 case yellow = "2F2F23"
 case green = "2F2F24"
 case teal = "2F2F25"
 case lightBlue = "2F2F26"
 case blue = "2F2F27"
 case blurple = "2F2F28"
 case purple = "2F2F29"
 case lilac = "2F2F2A"
 case pink = "2F2F2B"
 case lightGray = "2F2F2C"
 case gray = "2F2F2D"
 case brown = "2F2F2E"
 case black = "2F2F2F"
 
 */
