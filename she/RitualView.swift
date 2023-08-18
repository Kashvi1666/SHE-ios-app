import SwiftUI
import Combine

struct Task: Identifiable, Codable {
    var id = UUID()
    var name: String
    var time: String
}

struct TaskList: Identifiable, Codable {
    var id = UUID()
    var name: String
    var tasks: [Task]
}

class TaskListManager: ObservableObject {
    @Published var taskLists: [TaskList] = {
        if let data = UserDefaults.standard.data(forKey: "taskLists"), let savedTaskLists = try? JSONDecoder().decode([TaskList].self, from: data) {
            return savedTaskLists
        } else {
            return [TaskList(name: "morning", tasks: [
                        Task(name: "stretch", time: "8:00-8:10am"),
                        Task(name: "shower", time: "8:10-8:40am")
                    ])]
        }
    }()
    
    private var cancellable: AnyCancellable?
    
    init() {
        cancellable = $taskLists
            .debounce(for: 2.0, scheduler: RunLoop.main)
            .sink { lists in
                if let data = try? JSONEncoder().encode(lists) {
                    UserDefaults.standard.set(data, forKey: "taskLists")
                }
            }
    }
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
                .multilineTextAlignment(.center)
            TextField("time", text: $task.time)
                .autocapitalization(.none)
                .padding()
                .cornerRadius(8)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
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
            .frame(width: 340.0, height: 20.0)
            .font(.title2)
            .padding()
            .background(Color.black.opacity(0.3))
            .cornerRadius(8)
            .foregroundColor(.black)
            .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black.opacity(0.4), lineWidth: 1))
            .zIndex(1)
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
                Text("create")
                    .foregroundColor(.white)
                    .background(Color.black)
                    .cornerRadius(8)
                    .padding(.all, 200.0)
            }
            .frame(width: 600.0, height: 45.0)
        }
    }

    func addTask() {
        tasks.append(Task(name: "", time: ""))
    }
}

struct RitualView: View {
    @ObservedObject var manager = TaskListManager()
    @State private var expandedSection: UUID?

    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    .ignoresSafeArea()
                    .blur(radius: 4.0)

                VStack {
                    Text("User's Rituals")
                        .fontWeight(.light)
                        .font(.title)
                        .padding(.top, 50)
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(manager.taskLists.indices, id: \.self) { index in
                                VStack(spacing: 10) {
                                    TaskListRowView(taskList: $manager.taskLists[index])
                                        .onTapGesture {
                                            withAnimation {
                                                if expandedSection == manager.taskLists[index].id {
                                                    expandedSection = nil
                                                } else {
                                                    expandedSection = manager.taskLists[index].id
                                                }
                                            }
                                        }

                                    if expandedSection == manager.taskLists[index].id {
                                        TaskListView(tasks: $manager.taskLists[index].tasks)
                                    }
                                }.animation(.default)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                }
            }
            .navigationBarItems(trailing: addButton)
        }
    }

    var addButton: some View {
        Button(action: {
            if manager.taskLists.count < 8 {
                manager.taskLists.append(TaskList(name: "ritual", tasks: []))
                expandedSection = manager.taskLists.last?.id
            }
        }) {
            Image(systemName: "plus")
                .foregroundColor(.white)
                .padding()
                .frame(width: 40.0, height: 40.0)
                .background(Color.black.opacity(0.5))
                .clipShape(Circle())
                .offset(x: /*@START_MENU_TOKEN@*/-8.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
        }
    }
}

struct RitualView_Previews: PreviewProvider {
    static var previews: some View {
        RitualView()
    }
}
