//
//  MainMenuView.swift
//  GuessWhere
//
//  Created by Rajeev R Menon on 10/13/23.
//

import SwiftUI

struct MainMenuView: View {
    @State private var notificationObserver: NSObjectProtocol?
    @StateObject private var notificationService = PushNotificationService()
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: GameView().environmentObject(notificationService), label: {
                    Text("Play")
                })
            }
            .onAppear {
                notificationService.requestPermissions()
                if notificationService.isPermissionGranted {
                    notificationObserver = NotificationCenter.default.addObserver(
                        forName: UIApplication.willResignActiveNotification, object: nil, queue: .main)
                    { _ in
                        notificationService.scheduleNotification(
                            title: "Guess Where",
                            subtitle: "Are you sure you don't wanna play another game")
                    }
                }
            }
            .onDisappear {
                if let observer = notificationObserver {
                    NotificationCenter.default.removeObserver(observer)
                }
            }
        }
    }
}

#Preview {
    MainMenuView()
}
