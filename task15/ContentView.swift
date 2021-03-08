//
//  ContentView.swift
//  task15
//
//  Created by Hiroshi.Nakai on 2021/02/27.
//

import SwiftUI

struct Task: Identifiable {
    var id = UUID()
    var name: String
    var isDone: Bool
}

struct ContentView: View {

    @State  var tasks: [Task] = [
        .init(name: "りんご", isDone: false),
        .init(name: "みかん", isDone: true),
        .init(name: "バナナ", isDone: false),
        .init(name: "パイナップル", isDone: true)
    ]

    @State private var isShowModal = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(tasks.indices, id: \.self) { index in
                        HStack {
                            CheckViewRow(task: $tasks[index])
                        }
                    }
                }
                .navigationBarItems(trailing: Button(action: {
                    isShowModal = true
                }) {
                    Text("+")
                        .font(.largeTitle)
                })
            }
        }
        .sheet(isPresented: $isShowModal, content: {
            TaskDetialView(
                didTapSave: { name in
                    guard !name.isEmpty else { return }
                    tasks.append(Task(name: name, isDone: false))
                    isShowModal = false
                },
                didTapCancel: {
                    isShowModal = false
                }
            )
        })
    }
}

struct CheckViewRow: View {
    @Binding var task: Task

    var body: some View {

        Button(action: {
            task.isDone.toggle()
        }) {
            if task.isDone {
                Image(systemName: "checkmark")
                    .foregroundColor(.red)
            } else {
                Image(systemName: "checkmark")
                    .hidden()
            }
        }

        Text(task.name)
        Spacer()
    }
}


struct TaskDetialView: View {

    @State private var name: String = ""

    let didTapSave: (String) -> Void
    let didTapCancel: () -> Void

    var body: some View {
        VStack {
            HStack {
                Button("Cancel") {
                    didTapCancel()
                }
                Spacer()
                Button("Save") {
                    didTapSave(name)
                }
            }.padding()

            HStack {
                Text("名前")
                TextField("", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 100)
            }
            Spacer()
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
