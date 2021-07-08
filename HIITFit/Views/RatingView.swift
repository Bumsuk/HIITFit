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

struct RatingView: View {
    @AppStorage("ratings") private var ratings = "1000" // 총 4개의 운동화면의 레이팅 점수
    @State private var rating = 0 // 레이팅 점수(1~5)

    let exerciseIndex: Int
    let maximumRating = 5
    
    let onColor = Color.red
    let offColor = Color.gray
        
    var body: some View {
        HStack {
            ForEach(1 ..< maximumRating + 1) { idx in
                Image(systemName: "waveform.path.ecg")
                    .foregroundColor(idx > rating ? offColor : onColor )
                    .font(.largeTitle)
                    .onTapGesture {
                        updateRating(index: idx)
                    }
                    .onChange(of: ratings, perform: { _ in
                        convertRating()
                    })
            }
        }
        .onAppear(perform: {
            convertRating()
        })
    }
    
    init(exerciseIndex: Int) {
        self.exerciseIndex = exerciseIndex
        let desiredLenght = Exercise.exercises.count
        if ratings.count < desiredLenght {
            ratings = ratings.padding(toLength: desiredLenght, withPad: "0", startingAt: 0)
        }
    }
    
    fileprivate func convertRating() {
        let index = ratings.index(ratings.startIndex, offsetBy: exerciseIndex)
        let character = ratings[index]
        rating = character.wholeNumberValue ?? 0
    }

    fileprivate func updateRating(index: Int) {
        rating = index
        let index = ratings.index(ratings.startIndex, offsetBy: exerciseIndex)
        ratings.replaceSubrange(index...index, with: String(rating))
    }

}

struct RatingView_Previews: PreviewProvider {
    @AppStorage("ratings") static var ratings: String?
    static var previews: some View {
        ratings = nil
        return RatingView(exerciseIndex: 0)
            .previewLayout(.sizeThatFits)
    }
}
