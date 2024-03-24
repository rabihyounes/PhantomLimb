//
//  ReminderView.swift
//  PhantomLimb
//
//  Created by xz353 on 3/23/24.
//

import SwiftUI

struct ReminderView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var showDatePicker: Bool = false
    @State var timeset: String = ""

    var body: some View {
        VStack {
            //Reminders for laterality training (up to 5)
            List {
                Section {
                    Text("hi")
                    ForEach(viewModel.laterality_reminders.enumerated().map { $0 }, id: \.0) {
                        idx,
                        time in
                        DatePicker(
                            "Reminder \(idx+1)",
                            selection: Binding(
                                get: {
                                    DateHelper.dateFormatter.date(from: time) ?? Date()
                                },
                                set: {
                                    let newtime = DateHelper.dateFormatter.string(from: $0)
                                    viewModel.laterality_reminders[idx] = newtime
                                }
                            ),
                            displayedComponents: .hourAndMinute
                        )
                    }
                    .onDelete { indexSet in
                        viewModel.laterality_reminders.remove(atOffsets: indexSet)
                    }
                    if viewModel.laterality_reminders.count < 5 {
                        Button {
                            let currenttime = DateHelper.dateFormatter.string(from: Date())
                            withAnimation {
                                viewModel.laterality_reminders.append(currenttime)
                            }
                        } label: {
                            HStack {
                                Image(systemName: "plus")
                                Text("Add a reminder")
                            }
                        }
                    }
                }
                
                SingleReminderSettingView(remindersouce: $viewModel.motor_reminder, description: "Motor")
                
                SingleReminderSettingView(remindersouce: $viewModel.mirror_reminder, description: "Mirror")
            }
        }
    }
}

//for motor and mirror training reminder
struct SingleReminderSettingView:View {
    @Binding var remindersouce:String?
    let description:String
    
    var body: some View {
        Section {
            Text(description)
            if let reminder = remindersouce {
                DatePicker(
                    "Reminder",
                    selection: Binding(
                        get: {
                            DateHelper.dateFormatter.date(from: reminder) ?? Date()
                        },
                        set: {
                            let newtime = DateHelper.dateFormatter.string(from: $0)
                            remindersouce = newtime
                        }
                    ),
                    displayedComponents: .hourAndMinute
                )
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        withAnimation{
                            remindersouce = nil
                        }
                    } label: {
                        Text("Delete")
                    }
                }
            }
            else {
                Button {
                    let currenttime = DateHelper.dateFormatter.string(from: Date())
                    remindersouce = currenttime
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add a reminder")
                    }
                }
            }
        }
    }
}

#Preview {
    ReminderView()
        .environmentObject(ViewModel())
}
