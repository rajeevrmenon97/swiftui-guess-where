//
//  GameView.swift
//  GuessWhere
//
//  Created by Rajeev R Menon on 10/12/23.
//

import SwiftUI
import MapKit
import AlertToast

struct GameView: View {
    
    @StateObject private var gameViewModel = GameViewModel()
    @State private var buttonLabel = "Submit"
    @State private var notificationObserver: NSObjectProtocol?
    @EnvironmentObject private var notificationService: PushNotificationService
    
    let subLabel = "Submit"
    let nextLabel = " Next "
    
    var body: some View {
        GeometryReader { geometryReader in
            VStack {
                MapView(gameViewModel: gameViewModel)
                    .padding(.bottom)
                
                HStack {
                    
                    HStack {
                        Image(systemName: "gear")
                        Text("Timer")
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            if buttonLabel == subLabel {
                                if gameViewModel.pinLocation != nil {
                                    gameViewModel.finishRound()
                                    buttonLabel = nextLabel
                                }
                            } else {
                                buttonLabel = subLabel
                                gameViewModel.nextRound()
                            }
                        }
                    }, label: {
                        Text(buttonLabel)
                    })
                    .buttonStyle(.bordered)
                }
                .padding([.leading, .trailing])
            }
        }
        .toast(isPresenting: $gameViewModel.isToastShown){
            AlertToast(type: .complete(.primary), title: "You were \(gameViewModel.distance) away")
        }
        .onAppear {
            if notificationService.isPermissionGranted {
                notificationObserver = NotificationCenter.default.addObserver(
                    forName: UIApplication.willResignActiveNotification, object: nil, queue: .main)
                { _ in
                    notificationService.scheduleNotification(
                        title: "Guess Where",
                        subtitle: "Game in progress. Get back to it!")
                }
            }
        }
        .onDisappear {
            if let observer = notificationObserver {
                NotificationCenter.default.removeObserver(observer)
            }
        }
        .navigationTitle(gameViewModel.targetCity != nil ? gameViewModel.targetCity!: "Loading..")
        .navigationBarTitleDisplayMode(.inline)
    }
}
