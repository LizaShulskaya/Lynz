import SwiftUI

struct ContentView: View {
    
    @StateObject private var navigationState = NavigationState()
    @State private var calendarPath = NavigationPath()
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack(path: $calendarPath) {
                CalendarView()
                    .environmentObject(navigationState)
            }
            .tabItem {
                Image(systemName: "calendar")
                    .foregroundColor(.white)
            }
            .tag(0)
            
            NavigationStack {
                MessagesView().navigationTitle("Messages")
            }
                .tabItem {
                    Image(systemName: "message")
                        .foregroundColor(.white)
                }
                .tag(1)
          
            NavigationStack {
                PosesView()
            }
                .tabItem {
                    Image(systemName: "photo")
                        .foregroundColor(.white)
                }
                .tag(2)
        }
        .tint(AppColors.TabBar.selected)
        .onAppear {
            UITabBar.appearance().unselectedItemTintColor = UIColor(AppColors.TabBar.unselected)
            UITabBar.appearance().tintColor = UIColor(AppColors.TabBar.selected)
        }
        .onChange(of: selectedTab) { _ in
            UITabBar.appearance().unselectedItemTintColor = UIColor(AppColors.TabBar.unselected)
            UITabBar.appearance().tintColor = UIColor(AppColors.TabBar.selected)
        }
        .preferredColorScheme(.dark)
        .environmentObject(navigationState)
        .onChange(of: navigationState.popToCalendarToken) { _ in
            calendarPath = NavigationPath()
        }
    }
}

struct MessagesView: View {
    var body: some View {
        VStack {
            Text("Функционал в разработке :(")
            Spacer()
        }
        .padding()
    }
}



#Preview {
    ContentView()
}
