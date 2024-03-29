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

import AVKit
import SwiftUI

struct ExerciseView: View {
    @EnvironmentObject var history: HistoryStore
    @State private var showHistory = false
    @State private var showSuccess = false
    @State private var timerDone = false
    @State private var showTimer = false
    @Binding var selectedTab: Int
    let index: Int

    var startExerciseButton: some View {
        RaisedButton(buttonText: "Start Exercise") {
            showTimer.toggle()
        }
    }

    var historyButton: some View {
        Button(action: {
            showHistory = true
        }, label: {
            Text("History")
                .fontWeight(.bold)
                .padding([.leading, .trailing], 5)
        })
            .padding(.bottom, 10)
            .buttonStyle(EmbossedButtonStyle())
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                HeaderView(titleText: Exercise.exercises[index].exerciseName, selectedTab: $selectedTab)
                    .padding([.all], 20)

                ContainerView {
                    VStack {
                        VStack {
                            if let url = Bundle.main.url(forResource: Exercise.exercises[index].videoName, withExtension: "mp4") {
                                VideoPlayer(player: AVPlayer(url: url))
                                    .cornerRadius(20)
                            } else {
                                Text("\(Exercise.exercises[index].videoName)파일을 찾을수 없음!")
                                    .fontWeight(.bold)
                                    .foregroundColor(.red)
                            }
                        }
                        .frame(width: geometry.size.width * 0.9,
                               height: geometry.size.height * 0.25,
                               alignment: .top)
                        .padding()

                        // Spacer()

                        HStack(spacing: 150) {
                            startExerciseButton

                            Button("Done") {
                                history.addDoneExercise(Exercise.exercises[index].exerciseName)

                                timerDone = false
                                showTimer.toggle()

                                if lastExercise {
                                    showSuccess.toggle()
                                } else {
                                    selectedTab += 1
                                }
                            }
                            .disabled(!timerDone)
                            .sheet(isPresented: $showSuccess, content: {
                                SuccessView(selectedTab: $selectedTab)
                            })
                        }
                        .font(.headline)
                        .padding()

                        if showTimer {
                            TimerView(timerDone: $timerDone)
                        }


                        RatingView(exerciseIndex: index)
                            .padding()

                        Spacer()
                        
                        historyButton
                            .sheet(isPresented: $showHistory) {
                                HistoryView()
                            }
                            .padding(.bottom)
                    }
                }
            }
        }
    }
}

extension ExerciseView {
    var lastExercise: Bool {
        index + 1 == Exercise.exercises.count ? true : false
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView(selectedTab: .constant(3), index: 3)
            .environmentObject(HistoryStore())
            // .previewDevice("iPhone 12 Pro Max")
            .previewLayout(.sizeThatFits)
    }
}
