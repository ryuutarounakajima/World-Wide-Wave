//
//  sampleCodeFlie.swift
//  World Wide Wave
//
//  Created by Ryutarou Nakajima on 2024/10/16.
//

import Foundation



/*
 

// ASAuthorizationControllerDelegate methods
func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
        let userIdentifier = appleIDCredential.user
        let fullName = appleIDCredential.fullName
        let email = appleIDCredential.email
        
        // Save credentials in CoreData
        saveUserInCoreData(userID: userIdentifier, name: fullName?.givenName, email: email)
        
        // Handle successful login
        print("Login successful: \(userIdentifier), \(fullName?.givenName ?? ""), \(email ?? "")")
    }
}

func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    // Handle error during Apple authentication
    print("Error during Apple sign-in: \(error.localizedDescription)")
}

// CoreData save function
func saveUserInCoreData(userID: String, name: String?, email: String?) {
    // Assuming Core Data setup with an entity "User" that has attributes "id", "name", and "email"
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let context = appDelegate.persistentContainer.viewContext
    
    let entity = NSEntityDescription.entity(forEntityName: "User", in: context)!
    let newUser = NSManagedObject(entity: entity, insertInto: context)
    
    newUser.setValue(userID, forKey: "id")
    newUser.setValue(name, forKey: "name")
    newUser.setValue(email, forKey: "email")
    
    do {
        try context.save()
        print("User saved to CoreData")
    } catch {
        print("Failed to save user: \(error)")
    }
}
}
*/
