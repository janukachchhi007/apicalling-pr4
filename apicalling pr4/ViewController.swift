//
//  ViewController.swift
//  apicalling pr4
//
//  Created by R94 on 27/03/23.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    @IBOutlet weak var countryData: UITableView!
    
    @IBOutlet weak var serchBar: UISearchBar!
    var arr : [WelcomeElement] = []
    var arr2 : [WelcomeElement] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getdata()
        
    }
    func getdata()
    {
        let url = URL(string: "https://restcountries.com/v3.1/all")
        var ur = URLRequest(url: url!)
        ur.httpMethod = "GET"
        URLSession.shared.dataTask(with: ur) { data, responce, error in
            do{
                if error == nil
                {
                    self.arr = try JSONDecoder().decode([WelcomeElement].self, from: data!)
                    self.arr2 =  self.arr
                    
                    DispatchQueue.main.async {
                        self.countryData.reloadData()
                    }
                   }
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
         
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countryData.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! MyTableViewCell
        cell.lable1.text = arr[indexPath.row].name.common
        cell.lable2.text = arr[indexPath.row].name.official
        cell.img.image = stringToimg(link: arr[indexPath.row].flags.png)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        naviget(flogsimage: stringToimg(link:  arr[indexPath.row].flags.png)! ,ComanName: arr[indexPath.row].name.common, populationName: arr[indexPath.row].population ,image: stringToimg(link: arr[indexPath.row].coatOfArms.png!)!)
    }
    
    func stringToimg(link:String) -> UIImage?
    {
        let url1 = URL(string: link)
        let data = try? Data(contentsOf: url1! as URL)
        return UIImage(data: data!)
    }
   
    func naviget(flogsimage: UIImage,ComanName: String,populationName : Int , image : UIImage)
    {
        let navigation = storyboard? .instantiateViewController(withIdentifier: "MyViewController") as! MyViewController
        navigation.image = flogsimage
     //   navigation.officalName = OfficalName
        navigation.commanName = ComanName
        navigation.population = populationName
        navigation.coatsOfArms = image
        navigationController?.pushViewController(navigation, animated: true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == ""
        {
            arr = arr2
        }
        else{
            arr = arr2.filter({ i in
                return i.name.common.contains(searchBar.text!)
            })
        }
        countryData.reloadData()
    }
    

}

