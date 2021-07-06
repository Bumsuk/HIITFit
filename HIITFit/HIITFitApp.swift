/// Copyright (c) 2021 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Combine
import SwiftUI

// MARK: - CheckVersion

@main
enum CheckVersion {
    static func main() {
        if #available(iOS 14.0, *) {
            HIITFitApp.main()
        } else {
            UIApplicationMain(CommandLine.argc,
                              CommandLine.unsafeArgv,
                              nil,
                              NSStringFromClass(AppDelegate.self))
        }
    }
}

// MARK: - ObservableObject 테스트

class ShareData: ObservableObject {
    @Published var val1 = "값1"
    @Published var val2 = PassthroughSubject<String, Never>()
    @Published var val3 = CurrentValueSubject<String, Never>("값3")
}

// MARK: - iOS 14+ Only

@available(iOS 14.0, *)
struct HIITFitApp: App {
    @Environment(\.scenePhase) var scenePhase
    @StateObject private var historyStore: HistoryStore
    @State private var showAlert: Bool
    let shareData = ShareData() // 이건 테스트

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(shareData) //! 중요
                .environmentObject(historyStore) // 왜인지는 알지?
                .onAppear(perform: {
                    let fileManager = FileManager.default
                    print("[🤡] \(fileManager.urls(for: .documentDirectory, in: .userDomainMask))")
                })
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("History"), message: Text("""
                        Unfortunately we can’t load your past history.
                        Email support:
                        support@xyz.com
                        """), dismissButton: .destructive(Text("알겠음요!")))
                }
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                print("App is active")
            case .inactive:
                print("App is inactive")
            case .background:
                print("App is in background")
            @unknown default:
                print("Interesting: Unexpected new value.")
            }
        }
    }
    
    init() {
        let historyStore: HistoryStore
        do {
            historyStore = try .init(withChecking: true)
            _showAlert = .init(wrappedValue: false)
        } catch {
            print("Could not load history data")
            historyStore = HistoryStore()
            _showAlert = .init(wrappedValue: true)
        }
        
        // !!!
        // 에러남. self.historyStore = historyStore
        _historyStore = StateObject(wrappedValue: historyStore)
    }
}

// MARK: - iOS 13 Below Only

// @UIApplicationMain (xcode 11)
// @main (xcode 12)
class AppDelegate: UIResponder, UIApplicationDelegate {
    func applicationDidFinishLaunching(_ application: UIApplication) {
        print("🔥", #function)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print("🔥", #function)
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let contentView = ContentView()

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}
