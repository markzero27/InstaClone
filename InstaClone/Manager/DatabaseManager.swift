//
//  FirebaseManager.swift
//  InstaClone
//
//  Created by Marcus Daquis on 6/11/21.
//

import Firebase
protocol DatabaseManagerDelegate {
    func didCreateUser(username: String, password: String)
}

public class DatabaseManager {
    // MARK: - Singleton
    static let shared = DatabaseManager()
    
    // MARK: - PROPERTIES
    var delegate: DatabaseManagerDelegate?
    
    /// Check if username and email is available
    /// - Parameters
    ///     - username:  String representing username
    ///     - email:  String representing email
    ///     - completion:  Callback function returning void
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
        completion(true)
    }
    
    /// Create user item on Firestore
    /// - Parameters
    ///     - username:  String representing username
    ///     - email:  String representing email
    ///     - completion:  Callback function returning void
    public func createUser(username: String, email: String, password: String, image: String?, completion: @escaping (Bool) -> Void) {
        // database instance
        let db = Firestore.firestore()
        
        // uuid as the document id and uuid field value
        let uuid = UUID().uuidString
        
        db.collection("userAccounts").document(uuid).setData(
            [
                "uuid": uuid,
                "username" : username,
                "email": email
            ]
        ) { err in
            if let err = err {
                    print("Error writing document: \(err)")
                    completion(false)
                    return
                } else {
                    print("Document successfully written!")
                    self.delegate?.didCreateUser(username: username, password: password)
                    completion(true)
                    return
                }
            
        }
        
    }
}

