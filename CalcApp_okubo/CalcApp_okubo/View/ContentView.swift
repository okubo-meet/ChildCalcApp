//
//  ContentView.swift
//  CalcApp_okubo
//
//  Created by 大久保徹郎 on 2021/09/29.
//

import SwiftUI

struct ContentView: View {
    //ConfigViewModelの共有インスタンス
    @EnvironmentObject var configViewModel: ConfigViewModel
    //CalcViewModelの共有インスタンス
    @StateObject private var calcViewModel = CalcViewModel()
    //ボタンに表示するテキストを横一列毎にまとめた多次元配列
    private let buttonStr = [["7", "8", "9"],
                             ["4", "5", "6"],
                             ["1", "2", "3"],
                             ["0", "+", "-"],
                             ["C", "="]]
    //画面の高さ
    private let screenHeight = UIScreen.main.bounds.height
    //画面の幅
    private let screenWidth = UIScreen.main.bounds.width
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backGround
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 0) {
                    ZStack {
                        HStack {
                            Spacer()
                            //設定画面のリンク
                            NavigationLink {
                                ConfigView()
                            } label: {
                                Image(systemName: "gearshape.fill")
                                    .font(.system(size: screenWidth / 15))
                                    .foregroundColor(.buttonBlue)
                                    .padding(.trailing)
                            }
                        }// HStack
                        HStack {
                            //動物の画像
                            Image(configViewModel.animal.toImageString())
                                .resizable()
                                .scaledToFit()
                            //読み上げ中に切り替わる画像
                            Image(systemName: calcViewModel.speaker.rawValue)
                                .font(.system(size: screenWidth / 10))
                                .foregroundColor(calcViewModel.speaker.color())
                        }
                    }// ZStack
                    .frame(minWidth: 0, maxWidth: .infinity,
                           minHeight: 0, maxHeight: screenHeight / 8, alignment: .center)
                    //ボタンの入力を反映するテキスト
                    HStack() {
                        //前の項
                        Text(calcViewModel.firstNumber)
                            .font(.system(size: screenWidth / 8))
                            .fontWeight(.semibold)
                            .frame(minWidth: 0, maxWidth: screenWidth / 5, alignment: .center)
                        //演算子
                        Text(calcViewModel.calcOperator.rawValue)
                            .font(.system(size: screenWidth / 8))
                            .fontWeight(.semibold)
                            .frame(minWidth: 0, maxWidth: screenWidth / 10, alignment: .center)
                        //後ろの項
                        Text(calcViewModel.secondNumber)
                            .font(.system(size: screenWidth / 8))
                            .fontWeight(.semibold)
                            .frame(minWidth: 0, maxWidth: screenWidth / 5, alignment: .center)
                        //=
                        Text(calcViewModel.equalString())
                            .font(.system(size: screenWidth / 8))
                            .fontWeight(.semibold)
                            .frame(minWidth: 0, maxWidth: screenWidth / 10, alignment: .center)
                        //解
                        Text(calcViewModel.answerNumber)
                            .font(.system(size: screenWidth / 8))
                            .fontWeight(.semibold)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity,
                           minHeight: 0, maxHeight: screenHeight / 8, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                        //２重のForEachで多次元配列の値をからボタンに当てはめて並べる
                        ForEach(0..<buttonStr.count, id: \.self) { row in
                            HStack(spacing: 0) {
                                ForEach(0..<buttonStr[row].count, id: \.self) { col in
                                    Button(action: {
                                        //ボタンアクション
                                        calcViewModel.buttonAction(text: buttonStr[row][col])
                                    }) {
                                        CircleText(isHighlight: $calcViewModel.isHighlight,
                                                   text: buttonStr[row][col])
                                            .padding(5)
                                    }
                                }// ForEach col
                            }// HStack
                        }// ForEach row
                    // 画面下部の画像
                    Image("animals")
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity,
                               minHeight: 0, maxHeight: screenHeight / 8, alignment: .center)
                }// VStack
            }// ZStack
            .onAppear {
                //画面起動時、設定画面から戻ってきた時に設定をCalcViewModelに渡す
                calcViewModel.setUp(config: configViewModel)
            }
            .navigationBarHidden(true)
        }// NavigationStack
        .navigationViewStyle(.stack) //iPadでも同じ画面表示
        .tint(.white)// NavugationBarのボタンの色を設定
    }// body
    
    init() {
        //NavigationBarの設定
        let appearance = UINavigationBar.appearance()
        //背景色
        appearance.backgroundColor = UIColor(Color.navigation)
        //ボタンの色 iOS16で機能しなくなった
//        appearance.tintColor = UIColor.white
        //タイトルテキストの色・大
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        //タイトルテキストの色・小
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        //Formの背景色 ＊iOS16でUITableViewからUICollectionViewに変わったらしい
//        UICollectionView.appearance().backgroundColor = UIColor(Color.backGround)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Formの背景色を変えるための拡張
extension UICollectionReusableView {
    override open var backgroundColor: UIColor? {
        get { .clear }
        set { super.backgroundColor = UIColor(Color.backGround) }
    }
}
