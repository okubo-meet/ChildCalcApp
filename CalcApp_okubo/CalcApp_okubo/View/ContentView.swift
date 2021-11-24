//
//  ContentView.swift
//  CalcApp_okubo
//
//  Created by 大久保徹郎 on 2021/09/29.
//

import SwiftUI

struct ContentView: View {
    //ViewModelのインスタンス
    //    @ObservedObject private var calcViewModel = CalcViewModel()
    //ボタンに表示するテキストを横一列毎にまとめた多次元配列
    private let buttonStr = [["7", "8", "9"],
                             ["4", "5", "6"],
                             ["1", "2", "3"],
                             ["0", "+", "-"],
                             ["AC", "="]]
    //画面の高さ
    private let screenHeight = UIScreen.main.bounds.height
    //画面の幅
    private let screenWidth = UIScreen.main.bounds.width
    var body: some View {
        NavigationView {
            ZStack {
                Color.backGround
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 0) {
                    ZStack {
                        HStack {
                            Spacer()
                            
                            //設定画面のリンク
                            NavigationLink(destination: ConfigView()) {
                                Image(systemName: "gearshape.fill")
                                    .font(.title)
                                    .foregroundColor(.buttonBulue)
                                    .padding(.trailing)
                                
                            }
                        }// HStack
                        //読み上げの際に出てくる画像
                        Image("animal_arupaka")
                            .resizable()
                            .scaledToFit()
                    }// ZStack
                    .frame(minWidth: 0, maxWidth: .infinity,
                           minHeight: 0, maxHeight: screenHeight / 8, alignment: .center)
                    //ボタンの入力を反映するテキスト
                    Text("0")
                        .font(.system(size: screenWidth / 8))
                        .fontWeight(.semibold)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                        //２重のForEachで多次元配列の値をからボタンに当てはめて並べる
                        ForEach(0..<buttonStr.count, id: \.self) { row in
                            HStack(spacing: 0) {
                                ForEach(0..<buttonStr[row].count, id: \.self) { col in
                                    Button(action: {
                                        //ボタンアクション
                                    }) {
                                        CircleText(text: buttonStr[row][col])
                                            .padding(5)
                                    }
                                }// ForEach col
                            }// HStack
                        }// ForEach row
                    
                    
                    Image("animals")
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity,
                               minHeight: 0, maxHeight: screenHeight / 8, alignment: .center)
                }// VStack
            }// ZStack
            .navigationTitle("戻る")
            .navigationBarHidden(true)
        }// NavigationView
    }// body
    
    init() {
        //NavigationBarの設定
        let appearance = UINavigationBar.appearance()
        //背景色
        appearance.backgroundColor = UIColor(Color.navigation)
        //ボタンの色
        appearance.tintColor = UIColor.white
        //タイトルテキストの色・大
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        //タイトルテキストの色・小
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        //Formの背景色
        UITableView.appearance().backgroundColor = UIColor(Color.backGround)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
