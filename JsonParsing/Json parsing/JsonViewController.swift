//
//  JsonViewController.swift
//  TestApps
//
//  Created by Saddam on 23/6/21.
//

import UIKit

class JsonViewController: UIViewController {

    @IBOutlet weak var dataTableView: UITableView!
    
    var allDataInfo: allData?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        dataTableView.register(UINib(nibName: "DataTableViewCell", bundle: nil), forCellReuseIdentifier: "DataTableViewCell")
        dataTableView.dataSource = self
        dataTableView.delegate = self
        
        fetchData()
    }

    func fetchData(){
        
        guard let path = Bundle.main.path(forResource: "myData", ofType: ".json") else{
            return
        }
        
        let url = URL(fileURLWithPath: path)
        do{
            let jsonData = try Data(contentsOf: url)
            allDataInfo = try JSONDecoder().decode(allData.self, from: jsonData)
            guard let allDataInfo = allDataInfo else{ return }
            print(allDataInfo.myData.count)
            print("status :: ",allDataInfo.status )
            
            for itm in allDataInfo.myData{
                
                print(itm.title," :: ")
                for items in itm.items{
                    print(items)
                }
                print("\n")
            }
        }
        catch{
            print(error.localizedDescription)
        }
    }
}
extension JsonViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headView = UIView()
        let headTxt = allDataInfo?.myData[section].title
        let lbl = UILabel()
        lbl.text = headTxt
        lbl.frame = CGRect(x: 20, y: 0, width: 200, height: 20)
        
        headView.addSubview(lbl)
        
        headView.frame = CGRect(x: 0, y: 0, width: 400, height: 25)
        headView.backgroundColor = .cyan
        return headView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension JsonViewController: UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return (allDataInfo?.myData.count)!
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (allDataInfo?.myData[section].items.count)!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cell = dataTableView.dequeueReusableCell(withIdentifier: "DataTableViewCell", for: indexPath) as! DataTableViewCell
        cell.itmsLbl.text = allDataInfo?.myData[indexPath.section].items[indexPath.row]
        return cell
        
    }
}
