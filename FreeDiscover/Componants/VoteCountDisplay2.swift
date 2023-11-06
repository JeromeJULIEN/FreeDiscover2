//
//  VoteCountDisplay2.swift
//  FreeDiscover
//
//  Created by apprenant70 on 30/10/2023.
//

import SwiftUI


struct VoteCountDisplay2: View {
    // MARK: Variables externes à la vue
    @EnvironmentObject var userGlobalVariables : APIUserRequestModel
    @EnvironmentObject var activityGlobalVariables : APIActivityRequestModel
    
    // MARK: Variables de la vue
    /// Id de l'activité à afficher
    @Binding var activity : Activity
    
    // MARK: Fonctions de la vue
    /// fonctions pour vérifier si un vote a déjà été fait
    func hasVotedUp()-> Bool {
        return userGlobalVariables.connectedUser.idFromUserUpVote.contains(activity.id)
    }
    func hasVotedDown()-> Bool {
        return userGlobalVariables.connectedUser.idFromUserDownVote.contains(activity.id)
    }
    
    /// fonctions pour ajouter/supprimer un vote up
    /// cette fonction doit envoyer les id des records airtable, et non l'id des objets de la bdd
    /// pour ce faire, on utilise des fonctions qui récupèrent l'id du record à partir de l'id de l'objet
    func voteUp(activityId : Int){
        if (hasVotedUp() == false && hasVotedDown() == false){
            print("ADD UP VOTE")
            Task{
                await userGlobalVariables.addUpVoteToUser(userId: findUserRecordID(userID: userGlobalVariables.connectedUser.id, records: userGlobalVariables.allUsersRecord),
                                                    activityId:findActivityRecordID(activityID: activityId, records: activityGlobalVariables.allActivitiesRecord),
                                                    currentUpVote: userGlobalVariables.connectedUser.userUpVote
                )
                await activityGlobalVariables.increaseVoteCount(activityId: findActivityRecordID(activityID: activityId, records: activityGlobalVariables.allActivitiesRecord), currentVoteCOunt: activity.vote)
            }
        } else if(hasVotedUp() == true) {
            print("REMOVE UP VOTE")
            Task{
            await userGlobalVariables.removeUpVoteToUser(userId: findUserRecordID(userID: userGlobalVariables.connectedUser.id, records: userGlobalVariables.allUsersRecord),
                                                activityId:findActivityRecordID(activityID: activityId, records: activityGlobalVariables.allActivitiesRecord),
                                                currentUpVote: userGlobalVariables.connectedUser.userUpVote
                )
            await activityGlobalVariables.decreaseVoteCount(activityId: findActivityRecordID(activityID: activityId, records: activityGlobalVariables.allActivitiesRecord), currentVoteCOunt: activity.vote)
            }
        }
    }
    
    /// fonctions pour ajouter/supprimer un vote down
    func voteDown(activityId : Int){
        if (hasVotedDown() == false && hasVotedUp() == false){
            print("DOWN VOTE")
            Task{
                await userGlobalVariables.addDownVoteToUser(userId: findUserRecordID(userID: userGlobalVariables.connectedUser.id, records: userGlobalVariables.allUsersRecord),
                                                activityId:findActivityRecordID(activityID: activityId, records: activityGlobalVariables.allActivitiesRecord),
                                                currentDownVote: userGlobalVariables.connectedUser.userDownVote
                )
                await activityGlobalVariables.decreaseVoteCount(activityId: findActivityRecordID(activityID: activityId, records: activityGlobalVariables.allActivitiesRecord), currentVoteCOunt: activity.vote)
            }
        } else if(hasVotedDown() == true) {
            print("UP VOTE")
            Task{
                await userGlobalVariables.removeDownVoteToUser(userId: findUserRecordID(userID: userGlobalVariables.connectedUser.id, records: userGlobalVariables.allUsersRecord),
                                                activityId:findActivityRecordID(activityID: activityId, records: activityGlobalVariables.allActivitiesRecord),
                                                currentDownVote: userGlobalVariables.connectedUser.userDownVote
                )
                await activityGlobalVariables.increaseVoteCount(activityId: findActivityRecordID(activityID: activityId, records: activityGlobalVariables.allActivitiesRecord), currentVoteCOunt: activity.vote)
            }
        }
    }
    
    
    var body: some View {
        HStack(spacing:0) {
            ZStack{
                RoundedRectangle(cornerRadius: 0)
                    .frame(width: 50,height: 20)
                    .foregroundColor(activity.vote > 0 ? Color.blueFD : .socialRed)
                    .clipShape(
                        .rect(
                            topLeadingRadius: 10,
                            bottomLeadingRadius: 10,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: 0
                        )
                    )
                HStack{
                    Text("\(activity.vote) \(activity.vote > 1 ? "pts" : "pt")")
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
                            Image(systemName:hasVotedUp() ? "hand.thumbsup.fill" : "hand.thumbsup")
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
                    
                    Image(systemName:hasVotedDown() ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                        .font(.caption)
                }
                .foregroundColor(.white)
            })
            
        }
       
        .shadow(color: Color.secondary, radius: 1)
        .onChange(of: activityGlobalVariables.needsRefresh) { newValue in
                    if newValue {
                        Task {
                            await activityGlobalVariables.refreshData()
                        }
                    }
                }
    }
    
        
        
}

#Preview {
    VoteCountDisplay2(activity: .constant(Activity.nature1))
        .environmentObject(APIUserRequestModel())
        .environmentObject(APIActivityRequestModel())
}


