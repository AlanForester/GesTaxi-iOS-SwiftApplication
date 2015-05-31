//
//  EditarFilialView.swift
//  GestaoTaxis
//
//  Created by Paulo Alves on 26/05/15.
//  Copyright (c) 2015 Paulo Alves. All rights reserved.
//

import UIKit

class EditarFilialView: UIViewController {

    @IBOutlet weak var nome: UITextField!
    @IBOutlet weak var cidade: UITextField!
    @IBOutlet weak var longitude: UITextField!
    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var numtelefone: UITextField!
    
    var idF = 0
    var nomeF = ""
    var cidadeF = ""
    var longF = 0.0
    var latF = 0.0
    var numTF = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nome.text = nomeF
        cidade.text = cidadeF
        longitude.text = longF.description
        latitude.text = latF.description
        numtelefone.text = numTF
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
