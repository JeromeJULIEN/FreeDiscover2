//
//  VoteCountDisplay2.swift
//  FreeDiscover
//
//  Created by apprenant70 on 30/10/2023.
//

import SwiftUI

struct VoteCountDisplay2: View {
    // MARK: Variables externes à la vue
    @EnvironmentObject var userGlobalVariables : UserGlobalVariables
    /// Id de l'activité à afficher
    @Binding var activity : FreeDiscover
    
    // MARK: Fonctions de la vue
    /// fonctions pour vérifier si un vote a déjà été fait
    func hasVotedUp(activityId : Int)-> Bool {
        return userGlobalVariables.connectedUser.userUpVote.contains(activityId)
    }
    func hasVotedDown(activityId : Int)-> Bool {
        return userGlobalVariables.connectedUser.userDownVote.contains(activityId)
    }
    
    /// fonctions pour ajouter/supprimer un vote
    func voteUp(activityId : Int){
        if (hasVotedUp(activityId: activityId) == false && hasVotedDown(activityId: activityId) == false){
            activity.upVote()
            userGlobalVariables.connectedUser.userUpVote.append(activityId)
        } else if(hasVotedUp(activityId: activityId) == true) {
            activity.downVote()
            userGlobalVariables.connectedUser.userUpVote.removeAll{$0 == activityId}
        }
    }
    
    func voteDown(activityId : Int){
        if (hasVotedDown(activityId: activityId) == false && hasVotedUp(activityId: activityId) == false){
            activity.downVote()
            userGlobalVariables.connectedUser.userDownVote.append(activityId)
        } else if(hasVotedDown(activityId: activityId) == true) {
            activity.upVote()
            userGlobalVariables.connectedUser.userDownVote.removeAll{$0 == activityId}
        }
    }
    
    
    var body: some View {
        HStack(spacing:0) {
            ZStack{
                RoundedRectangle(cornerRadius: 0)
                    .frame(width: 50,height: 20)
                    .foregroundColor(activity.voteCounter > 0 ? Color.blueFD : .socialRed)
                    .clipShape(
                        .rect(
                            topLeadingRadius: 10,
                            bottomLeadingRadius: 10,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: 0
                        )
                    )
                HStack{
                    Text("\(activity.voteCounter) \(activity.voteCounter > 1 ? "pts" : "pt")")
                        .font(.caption.bold())
                }
                .foregroundColor(.white)
            }
            Button(action: {voteUp(activityId: activity.id)},
                   label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 0)
                                .frame(width: 30,height: 20)
                                .foregroundColor(Color.blueFD)
                            Image(systemName:hasVotedUp(activityId: activity.id) ? "hand.thumbsup.fill" : "hand.thumbsup")
                                .font(.caption)
                        }
                    }
                
            )
            .foregroundColor(.white)
            Button(action: {voteDown(activityId: activity.id)},
                   label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 0)
                        .frame(width: 30,height: 20)
                        .foregroundColor(Color.socialRed)
                        .clipShape(
                            .rect(
                                topLeadingRadius: 0,
                                bottomLeadingRadius: 0,
                                bottomTrailingRadius: 10,
                                topTrailingRadius: 10
                            )
                        )
                    
                    Image(systemName:hasVotedDown(activityId: activity.id) ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                        .font(.caption)
                }
                .foregroundColor(.white)
            })
            
        }
       
        .shadow(color: Color.secondary, radius: 1)
    }
    
        
        
}

#Preview {
    VoteCountDisplay2(activity: .constant(FreeDiscover.nature1)).environmentObject(UserGlobalVariables())
}
