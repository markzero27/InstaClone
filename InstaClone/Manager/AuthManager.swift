import FirebaseAuth

public class AuthManager {
    
    static let shared = AuthManager()
    
    // MARK: - Public
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        /*
         - check if username is available
         - check if email is available
         */
        
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate {
                /*
                 - create user account
                 - insert account to database
                 */
                
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if let error = error  {
                        print("error creating user")
                        print(error)
                        return
                    }
                    
                    if let rs: AuthDataResult = result {
                        print("Result")
                        print(rs)
                    }
                    
                    DatabaseManager.shared.createUser(username: username, email: email, password: password, image: nil) { success in
                        if success {
                            completion(true)
                            return
                        } else {
                            completion(false)
                            return
                        }
                    }
                    
                }
            } else {
                // either username or email exists
                completion(false)
            }
        }
    }
    
    // attempt to login user
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        if let email = email {
            // login via email
            Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
                guard authDataResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        }
        
        if let username = username {
            // login via email
            print(username)
        }
    }
    
    // Attemp to logout user
    public func logOut(completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
        } catch {
            completion(false)
            print(error)
        }
    }
}
