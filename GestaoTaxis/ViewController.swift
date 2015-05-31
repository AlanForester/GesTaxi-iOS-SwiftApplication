//
//  ViewController.swift
//  GestaoTaxis
//
//  Created by Paulo Alves on 25/05/15.
//  Copyright (c) 2015 Paulo Alves. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var array = ["Filial Porto", "Filial Lisboa", "Filial Braga", "Filial Viana", "Filial Esposende"];
    
    var lista :Array<AnyObject> = []
    
    var filiais : [String] = []
    
    @IBOutlet weak var pickerview: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationController!.navigationBar.barTintColor = UIColorFromHex(0xfff000, alpha: 0.7)
        
        imageView.image = UIImage(named: ("taxi.jpg"))
      
        
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        let fetch = NSFetchRequest(entityName: "Filial")
        
        getAll()
        self.pickerview.reloadAllComponents()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    func getAll(){
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        let fetch = NSFetchRequest(entityName: "Filial")
        lista = context.executeFetchRequest(fetch, error: nil)!
        
        let fetchRequest = NSFetchRequest(entityName:"Filial")
        if let weightLogs = context.executeFetchRequest(fetchRequest, error: nil) as? [Filial] {
            filiais = weightLogs.map { $0.nome }
        }
        
        //context.deleteObject(lista[0] as! NSManagedObject)
        //lista.removeAtIndex(0)
        //context.save(nil)
        
        println("numero de resultados devolvidos \(lista.count)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return lista.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return filiais[row]
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        getAll()
        self.pickerview.reloadAllComponents()
    }
    
    
}

