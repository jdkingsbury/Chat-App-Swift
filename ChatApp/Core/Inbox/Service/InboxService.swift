//
//  InboxService.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 8/3/23.
//

import Foundation
import Firebase

class InboxService {
    @Published var documentChanges = [DocumentChange]()
    
    func observeRecentMessages() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let query = COLLECTION_MESSAGES
            .document(uid)
            .collection(FirebaseConstants.recentMessages)
            .order(by: "timestamp", descending: true)
        
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({
                $0.type == .added || $0.type == .modified || $0.type == .removed
            }) else { return }
            
            self.documentChanges = changes
        }
    }
}
