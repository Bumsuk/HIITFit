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

import SwiftUI
import Combine

struct WelcomeView: View {
    @EnvironmentObject var share: ShareData
    @State var showHistory = false
    @Binding var selectedTab: Int
    
    var historyButton: some View {
        Button(action: {
            showHistory = true
        }, label: {
            Text("History")
                .fontWeight(.bold)
                .padding([.leading, .trailing], 5)
        })
        .padding(.bottom, 10)
        .buttonStyle(EmbossedButtonStyle(buttonShape: .capsule))
    }
    
    var body: some View {
        GeometryReader { geo in
            
            VStack {
                HeaderView(titleText: NSLocalizedString("Welcome", comment: "greeting"),
                           selectedTab: $selectedTab)

                Spacer()
                
                ContainerView {
                    VStack {
                        VStack {
                            WelcomeView.images
                            WelcomeView.welcomeText
                            getStartButton()
                            Spacer()
                            historyButton.padding(.bottom, 10)
                        }
                    }
                    .sheet(isPresented: $showHistory, content: {
                        HistoryView()
                    })
                }
                .frame(height: geo.size.height * 0.8)
            }
            //.ignoresSafeArea(.container, edges: .bottom)
        }
    }
    
    fileprivate func getStartButton() -> some View {
        RaisedButton(buttonText: NSLocalizedString("Get Started", comment: "")) {
            selectedTab = 0
        }
        .padding()
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WelcomeView(selectedTab: .constant(1))
                .preferredColorScheme(.light)
                .environmentObject(ShareData())
            WelcomeView(selectedTab: .constant(1))
                .previewDevice("iPod touch (7th generation)")
                .preferredColorScheme(.light)
                .environmentObject(ShareData())
        }
            //.preferredColorScheme(.dark)

        // .previewDevice("iPad Pro (11-inch) (3rd generation)")
        // .previewLayout(.sizeThatFits)
    }
}
