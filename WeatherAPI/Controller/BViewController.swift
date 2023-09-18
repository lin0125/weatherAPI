//
//  BViewController.swift
//  WeatherAPI
//
//  Created by imac-2437 on 2023/8/14.
//

import UIKit

class BViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var Location = ["嘉義縣", "新北市", "嘉義市", "新竹縣", "新竹市","臺北市", "臺南市", "宜蘭縣", "苗栗縣", "雲林縣", "花蓮縣", "臺中市", "臺東縣", "桃園市", "南投縣", "高雄市", "金門縣", "屏東縣", "基隆市", "澎湖縣", "彰化縣", "連江縣"]
    var selectRow: Int?
    var location: String = ""
    var leftBarButton: UIBarButtonItem!
    var delegate: SendMessageToDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        print("ccc\(location)")
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView.register(UINib(nibName: "SelectTableViewCell", bundle: nil), forCellReuseIdentifier: SelectTableViewCell.identifier)
        // Do any additional setup after loading the view.
    }
    
    func setupNavigation() {
        self.title = "地區"
        let leftBarButton = UIBarButtonItem(title: "<返回", style: .plain, target: self, action: #selector(backTOBviewcontroller))
        navigationItem.leftBarButtonItem = leftBarButton
        
    }
    //    func backValue() {
    //        if location == nil {
    //
    //        }
    //    }
    @objc func backTOBviewcontroller(){
        location = Location[selectRow ?? 0]
        delegate!.selectLocation(location: location)
        delegate?.reload()
        print("回傳\(location)")
        self.dismiss(animated: true, completion: nil)
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension BViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Location.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectTableViewCell.identifier, for: indexPath) as! SelectTableViewCell
        cell.SelectionLocation.text = Location[indexPath.row]
        
        if selectRow == indexPath.row {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        if location != "" {
            for i in Location  {
                if i == location {
                    let index = Location.firstIndex(of: i)
                    selectRow = index
                }
            }
            location = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRow = indexPath.row
        tableView.reloadData()
    }
}


protocol SendMessageToDelegate {
    func selectLocation(location: String)
    func reload ()
}
