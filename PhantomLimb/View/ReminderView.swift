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

    @State var temp_laterality_reminders: [String] = []
    @State var temp_motor_reminder: String?
    @State var temp_mirror_reminder: String?

    @State var notification_not_granted_error: Bool = false
    @State var notification_set_success: Bool = false

    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            //Reminders for laterality training (up to 5)
            List {
                Section {
                    Text("hiasdasdasdasdasdasdasd\nasdasdasdasdasdasdasdasdasdasdasdasasd\n")
                    ForEach(temp_laterality_reminders.enumerated().map { $0 }, id: \.0) {
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
                                    temp_laterality_reminders[idx] = newtime
                                }
                            ),
                            displayedComponents: .hourAndMinute
                        )
                        .listRowSeparator(.hidden, edges: .bottom)
                    }
                    .onDelete { indexSet in
                        temp_laterality_reminders.remove(atOffsets: indexSet)
                    }
                    if temp_laterality_reminders.count < 5 {
                        Button {
                            let currenttime = DateHelper.dateFormatter.string(from: Date())
                            withAnimation {
                                temp_laterality_reminders.append(currenttime)
                            }
                        } label: {
                            HStack {
                                Image(systemName: "plus")
                                Text("Add a reminder")
                            }
                        }
                    }
                }

                SingleReminderSettingView(
                    remindersouce: $temp_motor_reminder,
                    description: "Motor"
                )

                SingleReminderSettingView(
                    remindersouce: $temp_mirror_reminder,
                    description: "Mirror"
                )
            }
            .scrollContentBackground(.hidden)
            .listStyle(.insetGrouped)
            .padding(.vertical)
            MyCapsuleButton(buttontext: Text("Confirm"), buttonColor: .blue) {
                if viewModel.notificationManager.notification_denied {
                    notification_not_granted_error = true
                }
                else {
                    viewModel.laterality_reminders = temp_laterality_reminders
                    viewModel.motor_reminder = temp_motor_reminder
                    viewModel.mirror_reminder = temp_mirror_reminder
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { // to prevent the alert does not show up when the user directly clikcs confirm without closing the datapicker first
                         notification_set_success = true
                    }
                    //TODO: Synchronize it with database
                }
            }
            .frame(width: 20, height: 20)
        }
        .onAppear {
            self.temp_laterality_reminders = viewModel.laterality_reminders
            self.temp_motor_reminder = viewModel.motor_reminder
            self.temp_mirror_reminder = viewModel.mirror_reminder
        }
        .alert("Notification Not Granted", isPresented: $notification_not_granted_error) {
            Button("OK") {
                notification_not_granted_error = false
            }
        } message: {
            Text("Please Enable Notification in your settings")
        }
        .alert("Set Reminder Success", isPresented: $notification_set_success) {
            Button("OK") {
                withAnimation {
                    notification_set_success = false
                    dismiss()
                }
            }
        }
    }
}

//for motor and mirror training reminder
struct SingleReminderSettingView: View {
    @Binding var remindersouce: String?
    let description: String

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
                        withAnimation {
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
                    withAnimation {
                        remindersouce = currenttime
                    }
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
