require 'rails_helper'

describe "Creatin todo lists" do

  def create_to_do_list (options = {})
    options[:title] ||= "My to do list"
    options[:description] ||= "My to do list description."

    visit "/todo_lists"
    click_link "New Todo list"

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Create Todo list"

  end


  it "redirects to the todo list index on success" do
    
    create_to_do_list
    expect(page).to have_content("My to do list")
  end

  it "displays an error when the todo list has no title" do
    expect(TodoList.count).to eq(0)
    create_to_do_list title: ""
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("a basic description")
  end

  it "displays an error when the todo list has too short of a title" do
    expect(TodoList.count).to eq(0)

    create_to_do_list title: "Hi"
   
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("a basic description")
  end

 it "displays an error when the todo list has no description" do
    expect(TodoList.count).to eq(0)

    create_to_do_list description: ""
   
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("a basic description")
  end

  it "displays an error when the todo list has too short of a description" do
    expect(TodoList.count).to eq(0)

    create_to_do_list description: "Hi"
   
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("a basic description")
  end

end