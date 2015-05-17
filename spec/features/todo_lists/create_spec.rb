require 'rails_helper'

describe "Creatin todo lists" do
  it "redirects to the todo list index on success" do
    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: "new test todo list"
    fill_in "Description", with: "a basic description"
    click_button "Create Todo list"

    expect(page).to have_content("new test todo list")
  end

  it "displays an error when the todo list has no title" do
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: ""
    fill_in "Description", with: "a basic description"
    click_button "Create Todo list"

   
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("a basic description")
  end
end