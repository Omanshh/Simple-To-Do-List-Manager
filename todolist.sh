#!/bin/bash

# File to store tasks
TODO_FILE="tasks.txt"

# --- Function to view all tasks ---
view_tasks() {
    if [ ! -f "$TODO_FILE" ] || [ ! -s "$TODO_FILE" ]; then
        echo "No tasks found."
        return
    fi

    echo "Your To-Do List:"
    nl -w2 -s". " "$TODO_FILE"
}

# --- Function to add a new task ---
add_task() {
    echo -n "Enter a new task: "
    read task
    echo "$task" >> "$TODO_FILE"
    echo "Task added: $task"
}

# --- Function to delete a task ---
delete_task() {
    if [ ! -f "$TODO_FILE" ] || [ ! -s "$TODO_FILE" ]; then
        echo "No tasks to delete."
        return
    fi

    echo "Your To-Do List:"
    nl -w2 -s". " "$TODO_FILE"

    echo -n "Enter the task number to delete: "
    read num

    if [[ ! "$num" =~ ^[0-9]+$ ]]; then
        echo "Invalid input. Please enter a number."
        return
    fi

    if [ "$num" -le 0 ] || [ "$num" -gt "$(wc -l < "$TODO_FILE")" ]; then
        echo "Invalid task number."
        return
    fi

    sed -i "${num}d" "$TODO_FILE"
    echo "Task deleted."
}

# --- Main menu ---
while true; do
    echo "=============================="
    echo "====== TO-DO LIST MANAGER ======"
    echo "1. View tasks"
    echo "2. Add task"
    echo "3. Delete task"
    echo "4. Exit"
    echo "=============================="
    read -p "Choose an option (1-4): " choice

    case $choice in
        1) view_tasks ;;
        2) add_task ;;
        3) delete_task ;;
        4) echo "Goodbye!"; break ;;
        *) echo "Invalid option. Please choose again." ;;
    esac
done
