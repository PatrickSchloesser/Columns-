//
//  ViewController.swift
//  SC1
//
//  Created by Ethan Hardacre on 10/22/17.
//  Copyright © 2017 Ethan Hardacre. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var info = ["1","2","3","4","5","6"]
    
    var myView = UIView()
    var dailyView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: 50))
        myView.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        self.view.addSubview(myView)
        
        dailyView = UITableView(frame: CGRect(x: 0.0, y: myView.frame.maxY, width: self.view.frame.width, height: self.view.frame.height - myView.frame.height))
        dailyView.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        dailyView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        dailyView.delegate = self
        dailyView.dataSource = self
        self.view.addSubview(dailyView)
        self.view.sendSubview(toBack: dailyView)
        
        
        var gestureRecog = UISwipeGestureRecognizer(target: self, action: #selector(animate))
        gestureRecog.direction = .down
        view.addGestureRecognizer(gestureRecog)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.white
        var label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: cell.frame.width, height: cell.frame.height))
        label.text = info[indexPath.row]
        cell.addSubview(label)
        return cell
    }

    func animate(){
        UIView.animate(withDuration: 1.0) {
            self.myView.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: 300)
            self.dailyView.frame = CGRect(x: 0.0, y: self.myView.frame.maxY, width: self.view.frame.width, height: self.view.frame.height - self.myView.frame.height)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

