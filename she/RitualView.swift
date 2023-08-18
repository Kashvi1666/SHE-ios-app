import SwiftUI

struct Task: Identifiable {
    var id = UUID()
    var name: String
    var time: String
}

struct TaskList: Identifiable {
    var id = UUID()
    var name: String
    var tasks: [Task]
}

struct TaskRowView: View {
    @Binding var task: Task

    var body: some View {
        HStack {
            TextField("task", text: $task.name)
                .autocapitalization(.none)
                .padding()
                .cornerRadius(8)
                .foregroundColor(.white)
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            TextField("time", text: $task.time)
                .autocapitalization(.none)
                .padding()
                .cornerRadius(8)
                .foregroundColor(.white)
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
        .padding()
        .frame(width: 380.0, height: 40.0)
        .background(Color.black.opacity(0.2))
        .cornerRadius(20)
    }
}

struct TaskListRowView: View {
    @Binding var taskList: TaskList

    var body: some View {
        TextField("ritual", text: $taskList.name)
            .autocapitalization(.none)
            .font(.title2)
            .padding()
            .background(Color.white.opacity(0.1))
            .cornerRadius(8)
            .foregroundColor(.white)
            .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black.opacity(0.4), lineWidth: 1))
    }
}

struct TaskListView: View {
    @Binding var tasks: [Task]

    var body: some View {
        VStack(spacing: 10) {
            ForEach(tasks.indices, id: \.self) { index in
                TaskRowView(task: $tasks[index])
            }

            Button(action: addTask) {
                Text("add task")
                    .foregroundColor(.white)
                    .background(Color.black)
                    .cornerRadius(8)
                    .padding(.all, 20.0)
            }
            .frame(width: 600.0, height: 45.0)
        }
    }

    func addTask() {
        tasks.append(Task(name: "", time: ""))
    }
}

struct RitualView: View {
    @State private var taskLists: [TaskList] = [
        TaskList(name: "morning", tasks: [
            Task(name: "stretch", time: "8:00-8:10am"),
            Task(name: "shower", time: "8:10-8:40am")
        ])
    ]

    @State private var expandedSection: UUID?

    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    .ignoresSafeArea()
                    .blur(radius: 4.0)

                VStack(spacing: 20) {
                    Text("user's rituals")
                        .fontWeight(.light)
                        .font(.title)
                        .offset(y: 30)

                    ScrollView {
                        ForEach(taskLists.indices, id: \.self) { index in
                            VStack {
                                TaskListRowView(taskList: $taskLists[index])
                                    .onTapGesture {
                                        withAnimation {
                                            if self.expandedSection == taskLists[index].id {
                                                self.expandedSection = nil
                                            } else {
                                                self.expandedSection = taskLists[index].id
                                            }
                                        }
                                    }

                                if self.expandedSection == taskLists[index].id {
                                    TaskListView(tasks: $taskLists[index].tasks)
                                        .transition(.move(edge: .top))
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            .navigationBarItems(trailing: addButton)
        }
    }

    var addButton: some View {
        Button(action: {
            if taskLists.count < 8 {
                taskLists.append(TaskList(name: "ritual", tasks: []))
            }
        }) {
            Image(systemName: "plus")
                .foregroundColor(.white)
                .padding()
                .background(Color.black.opacity(0.5))
                .clipShape(Circle())
        }
    }
}

struct RitualView_Previews: PreviewProvider {
    static var previews: some View {
        RitualView()
    }
}
