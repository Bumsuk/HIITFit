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

// MARK: - 커스텀 버튼

struct RaisedButton: View {
    let buttonText: String
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(buttonText).raisedButtonTextStyle()
        })
        .buttonStyle(RaisedButtonStyle())
        //.buttonStyle(RaisedPrimitiveButtonStyle())
    }
}

// MARK: - 버튼 스타일들

struct RaisedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding([.top, .bottom], 12)
            //.foregroundColor(configuration.isPressed ? Color.black : Color.yellow)
            .background(Capsule()
                            //.fill(configuration.isPressed ? Color.red : Color.blue)
                            .foregroundColor(Color("background"))
                            .shadow(color: Color("drop-shadow"), radius: 4, x: 6.0, y: 6.0)
                            .shadow(color: Color("drop-highlight"), radius: 4, x: -6, y: -6)
            )
    }
}

struct RaisedPrimitiveButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            /*
            .onLongPressGesture {
                print("[onLongPressGesture]")
                configuration.trigger()
            }
            */
            .onTapGesture {
                print("[onTapGesture]")
                configuration.trigger()
            }
        }
}

// MARK: - 프리뷰

struct RaisedButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RaisedButton(buttonText: "Get Started") {
                print("action!")
            }
            .preferredColorScheme(.light)
        }
    }
}
