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

struct HeaderView: View {
    @State var titleText: String
    @Binding var selectedTab: Int

    var body: some View {
        VStack {
            Text(titleText)
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(.white)
                .lineLimit(1)

            HStack {
                ForEach(0 ..< Exercise.exercises.count) { idx in
                    ZStack {
                        Circle()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.white)
                            .opacity(idx == selectedTab ? 0.5 : 0)
                        Circle()
                            .frame(width: 16, height: 16)
                            .foregroundColor(.white)
                    }
                    .onTapGesture {
                        selectedTab = idx
                    }

                    /*
                    let fill = idx == selectedTab ? ".fill" : ""
                    Image(systemName: "\(idx + 1).circle\(fill)")
                        .onTapGesture {
                            selectedTab = idx
                        }
                    */
                }
            }
            .font(.title)
        }
        .foregroundColor(.white)        
        .onAppear(perform: {})
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(titleText: "Squat", selectedTab: .constant(1))
            .previewLayout(.sizeThatFits)

        HeaderView(titleText: "Squat", selectedTab: .constant(1))
            .preferredColorScheme(.dark)
            .environment(\.sizeCategory, .accessibilityLarge)
            .previewLayout(.sizeThatFits)
    }
}
