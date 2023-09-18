//
//  MainViewController.swift
//  WeatherAPI
//
//  Created by imac-2437 on 2023/8/14.
//

import UIKit

class MainViewController :UIViewController {
    
    //MARK: - IBOutlet
    
    
    
    //MARK: - Variables
    var rightBarButton: UIBarButtonItem?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var showLocation: UILabel!
    var selectValue: String = "臺北市"
    var downloadData: WeatherResponse!
    var CodingString: String!
    
    
    //MARK: - LifeCycle
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("顯示\(selectValue)")
        setString()
        setupNavigation()
        
        
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView.register(UINib(nibName: "ShowDataTableViewCell", bundle: nil), forCellReuseIdentifier: ShowDataTableViewCell.identifier)
        CallAPI {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    
    //MARK: - UI Settings
    
    func setUI(){

    }
    func setString() {
        showLocation.text = selectValue
        CodingString = selectValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
    }
    
    func setupNavigation() {
        self.title = "氣象預報"
        rightBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:#selector(jumpTOBviewcontroller))
        navigationItem.rightBarButtonItem = rightBarButton
        rightBarButton!.title = "選擇"
    }
    
    func CallAPI(finish: @escaping (() -> Void)) {
//        print(String(describing: CodingString!))
        let address = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWB-C1F1124A-2966-4D8B-9E96-BCDECED47A0E&locationName=\(String(describing: CodingString!))"
//        print(address)
        let url = URL(string: address)
        
        URLSession.shared.dataTask(with: url!) { [self] data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let response = response {
                print(response as! HTTPURLResponse)
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let WeatherData = try decoder.decode(WeatherResponse.self, from: data)
                    
                    print("==============================================================================")
                    print(WeatherData)
                    downloadData = WeatherData
                    print(downloadData?.records.location[0].weatherElement[0].time[0].endTime ?? "")
                    print("==============================================================================")
                    
                } catch {
                    print(error.localizedDescription)
                }
                finish()
            }
        }.resume()
//        tableView.reloadData()
    }
    
    //MARK: - IBAction
    @objc func jumpTOBviewcontroller(){
        let nextVC = BViewController()
        nextVC.delegate = self
        nextVC.location = selectValue
        let navigationController = UINavigationController(rootViewController: nextVC)
        navigationController.isNavigationBarHidden = false
        self.present(navigationController, animated: true, completion: nil)
    }

    
}

//MARK: - Extension

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShowDataTableViewCell.identifier, for: indexPath) as! ShowDataTableViewCell
       
            for i in 0...2{
                
                cell.StartTime.text = "\(downloadData?.records.location[0].weatherElement[0].time[i].startTime ?? "")"
                cell.EndTime.text = "\(downloadData?.records.location[0].weatherElement[0].time[i].endTime ?? "")"
                cell.highTemperature.text = "\(downloadData?.records.location[0].weatherElement[4].time[i].parameter.parameterName ?? "")"+"度"
                cell.lowTemperature.text = "\(downloadData?.records.location[0].weatherElement[2].time[i].parameter.parameterName ?? "")"+"度"
                cell.ComfortDegree.text = "\(downloadData?.records.location[0].weatherElement[3].time[1].parameter.parameterName ?? "")"
                cell.probabilityOfRain.text = "\(downloadData?.records.location[0].weatherElement[1].time[2].parameter.parameterName ?? "")"+"%"
                
                cell.RainDescription.text = "\(downloadData?.records.location[0].weatherElement[0].time[0].parameter.parameterName ?? "")"
            }
        
        return cell
    }
}



extension MainViewController: SendMessageToDelegate {
    func selectLocation(location: String) {
        self.selectValue = location
        setString()
        CallAPI {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
           
        }
//        showLocation.text = selectValue
//        CodingString = selectValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        print("k\(selectValue)")
        
        
    }
    
    func reload() {
        tableView.reloadData()
    }
}

//MARK: - Protocol

