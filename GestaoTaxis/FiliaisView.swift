//
//  Filiais.swift
//  GestaoTaxis
//
//  Created by Paulo Alves on 25/05/15.
//  Copyright (c) 2015 Paulo Alves. All rights reserved.
//


import UIKit
import CoreData

class FiliaisView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var filiais: [FilialBLL] = []
    
    var lista :Array<AnyObject> = []
    
    var nomeFiliais : [String] = []
    var cidadeFiliais : [String] = []
    var numTelemoveis : [String] = []
    
    
    @IBOutlet weak var tableView: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var loadingView: UIView = UIView()
        
        getAll()
        
        tableView.reloadData()
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    func getAll(){
        filiais = []
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        let fetch = NSFetchRequest(entityName: "Filial")
        lista = context.executeFetchRequest(fetch, error: nil)!
        
        let fetchRequest = NSFetchRequest(entityName:"Filial")
        if let weightLogs = context.executeFetchRequest(fetchRequest, error: nil) as? [Filial] {
            nomeFiliais = weightLogs.map { $0.nome }
        }
        if let weightLogs = context.executeFetchRequest(fetchRequest, error: nil) as? [Filial] {
            cidadeFiliais = weightLogs.map { $0.cidade }
        }
        if let weightLogs = context.executeFetchRequest(fetchRequest, error: nil) as? [Filial] {
            numTelemoveis = weightLogs.map { $0.telefone }
        }
        
        
        var results = context.executeFetchRequest(fetch, error: nil)
        
        for result in results! as! [NSManagedObject] {
            let fil = FilialBLL(nome: result.valueForKey("nome")! as! String, cidade: result.valueForKey("cidade")! as! String, longitude: result.valueForKey("longitude")! as! Double, latitude: result.valueForKey("latitude")! as! Double, numtelefone: result.valueForKey("telefone") as! String)
            
            filiais.append(fil)
        }
        
        //context.deleteObject(lista[0] as! NSManagedObject)
        //lista.removeAtIndex(0)
        //context.save(nil)
        
        //println("numero de resultados \(lista.count)")
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nomeFiliais.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        cell.textLabel!.text = nomeFiliais[indexPath.row]
        cell.detailTextLabel!.text = cidadeFiliais[indexPath.row]
        return cell
    }
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        let apagar = { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            
            let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context:NSManagedObjectContext = appDel.managedObjectContext!
            context.deleteObject(self.lista[indexPath.row] as! NSManagedObject)
            self.lista.removeAtIndex(indexPath.row)
          
            var error: NSError? = nil
            context.save(&error)
            if (error != nil) {
                println(error)
            }
            else {
                println("registo apagado")
            }

            self.getAll()
            
                    
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        
        }
        
        let editar = { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in

            println(indexPath.row)

            var vc = self.storyboard?.instantiateViewControllerWithIdentifier("EditarFilial") as! EditarFilialView
              
                
            self.navigationController!.pushViewController(vc, animated: true)
            println(indexPath.row)
            vc.idF = indexPath.row
            vc.nomeF = self.filiais[indexPath.row].getNome()
            vc.cidadeF = self.filiais[indexPath.row].getCidade()
            vc.longF = self.filiais[indexPath.row].getLongitude()
            vc.latF = self.filiais[indexPath.row].getLatitude()
            vc.numTF = self.filiais[indexPath.row].getNumTelefone()

        }
        
        let telefonar = { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            
            println(indexPath.row)
            
            println(self.numTelemoveis[indexPath.row])
            
            UIApplication.sharedApplication().openURL(NSURL(string: "tel://"+"\(self.numTelemoveis[indexPath.row])")!)
        
        }
        
        
        let apagarAction = UITableViewRowAction(style: .Default, title: "Apagar", handler: apagar)
        let editarAction = UITableViewRowAction(style: .Normal, title: "Editar", handler: editar)
        let telefonarAction = UITableViewRowAction(style: .Normal, title: "Telefonar", handler: telefonar)
        telefonarAction.backgroundColor = UIColor.greenColor()
        editarAction.backgroundColor = UIColorFromHex(0xfff003, alpha: 1.0)
    
        return [apagarAction, editarAction, telefonarAction]
    }
    
    @IBAction func unwindToOrigem(segue: UIStoryboardSegue){
        let criarFilDados = segue.sourceViewController as! CriarFilialView

        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        let entidade = NSEntityDescription.entityForName("Filial", inManagedObjectContext: context)
        var filial = Filial(entity: entidade!, insertIntoManagedObjectContext: context)
    
        filial.nome = criarFilDados.nome.text
        filial.cidade = criarFilDados.nome.text
        filial.telefone = criarFilDados.telefone.text
        filial.latitude = NSString(string: criarFilDados.latitude.text).doubleValue
        filial.longitude = NSString(string: criarFilDados.longitude.text).doubleValue
        var error: NSError? = nil
        context.save(&error)
        if (error != nil) {
            println(error)
        }
        else {
            println("registo armazenado")
        }
        getAll()

        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "EditarSegue"){
        let DestinoVC = segue.destinationViewController as! EditarFilialView
        }
    }
    
    @IBAction func unwindEdita(segue: UIStoryboardSegue){
        
        let editarFilDados = segue.sourceViewController as! EditarFilialView
        //self.fetchEvent(editarFilDados.idF)
        
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext!
        
        var fetchRequest = NSFetchRequest(entityName: "Filial")
        fetchRequest.predicate = NSPredicate(format: "nome = %@", editarFilDados.nomeF)
        fetchRequest.predicate = NSPredicate(format: "cidade = %@", editarFilDados.cidadeF)
        fetchRequest.predicate = NSPredicate(format: "telefone = %@", editarFilDados.numTF)
       

        if let fetchResults = appDel.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [NSManagedObject] {
            if fetchResults.count != 0{
                
                var managedObject = fetchResults[0]
                var nome = editarFilDados.nome.text
                var cidade = editarFilDados.cidade.text
                var numtelemovel = editarFilDados.numtelefone.text
                var longitude = NSString(string: editarFilDados.longitude.text).doubleValue
                
                var latitude = NSString(string: editarFilDados.latitude.text).doubleValue
                //println(texto)
                managedObject.setValue(nome, forKey: "nome")
                managedObject.setValue(cidade, forKey: "cidade")
                managedObject.setValue(numtelemovel, forKey: "telefone")
                managedObject.setValue(longitude, forKey: "longitude")
                managedObject.setValue(latitude, forKey: "latitude")
                
                context.save(nil)
            }
        }
        getAll()
        
        tableView.reloadData()
        
    }

}
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


class FilialBLL{
    
    var nome = ""
    var cidade = ""
    var longitude = 0.0
    var latitude = 0.0
    var numtelefone = ""
    
    var taxistas: [TaxistaBLL] = []
    
    init(nome: String, cidade: String, longitude: Double, latitude: Double, numtelefone: String){
        self.nome = nome
        self.cidade = cidade
        self.longitude = longitude
        self.latitude = latitude
        self.numtelefone = numtelefone
        taxistas = []
    }
    
    func getNome() -> String{
        return nome
    }
    
    func getCidade() -> String{
        return cidade
    }
    
    func getLongitude() -> Double{
        return longitude
    }
    
    func getLatitude() -> Double{
        return latitude
    }
    
    func getNumTelefone() -> String{
        return numtelefone
    }
    
}
    

