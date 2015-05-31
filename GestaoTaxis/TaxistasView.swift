//
//  Taxistas.swift
//  GestaoTaxis
//
//  Created by Paulo Alves on 25/05/15.
//  Copyright (c) 2015 Paulo Alves. All rights reserved.
//

import UIKit

class TaxistasView: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var array = ["Taxista Pedro", "Taxista Paulo", "Taxista Jorge"];
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        cell.textLabel!.text = array[indexPath.row]
        cell.detailTextLabel!.text = array[indexPath.row]
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class TaxistaBLL{
    var nome = ""
    var numtelefone = ""
    
    init(nome: String, numtelefone: String){
        self.nome = nome
        self.numtelefone = numtelefone
    }
    
}

