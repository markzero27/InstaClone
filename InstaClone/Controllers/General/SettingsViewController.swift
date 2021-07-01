//
//  SettingsViewController.swift
//  InstaClone
//
//  Created by Marcus Daquis on 6/11/21.
//

import UIKit

struct SettingsCellModel {
    let title: String
    let handler: (() -> Void)
}

final class SettingsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private var data = [[SettingsCellModel]]()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        configureModels()
    }
    
    // MARK: - Functions
    func configureModels() {
        let section = [
            SettingsCellModel(title: "Logout") { [weak self] in
                self?.didTapLogout()
            }
        ]
        data.append(section)
    }
    
    func didTapLogout() {
        AuthManager.shared.logOut { success in
            if success {
                
            } else {
                // error occured
            }
        }
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    }
    
    
}
