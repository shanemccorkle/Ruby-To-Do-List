require "rspec"
require_relative "to_do_list"

describe "ToDoItem" do

  # Story: As a developer, I can create a ToDoItem.
  it "can create a to do item" do
    expect{ToDoItem.new}.to_not raise_error
  end

  # Story: As a developer, I can give a ToDoItem a title and retrieve it.
  it "has a title" do
    expect{ToDoItem.new("new title")}.to_not raise_error
  end
  # can retrieve title from the item
  it "can retrive title" do
    new_item = ToDoItem.new("new title")
    expect(new_item.title).to be_a String
  end

  # Story: As a developer, I can give a ToDoItem a description and retrieve it.
  it "has a description and default is '' " do
    new_item = ToDoItem.new()
    expect(new_item.description).to be_a String
    expect(new_item.description).to eq("")
  end
  # can retrieve a description from the item
  it "can retrieve description" do
    new_item = ToDoItem.new("new Title", "description")
    expect(new_item.description).to eq("description")
  end

  # Story: As a developer, I can print a ToDoItem with field labels and values.
  it "can print the title and description on an item" do
    new_item = ToDoItem.new("New Title","New Description")
    expect(new_item.print_item).to be_a String
    expect(new_item.print_item).to eq("Title: New Title; Description: New Description; Is Done: false")
  end

  # Story: As a developer, I can mark a ToDoItem done.
  it "has is_done property as false" do
    new_item = ToDoItem.new
    expect(new_item.is_done?).to be_a FalseClass
  end

  # Test to make sure we can mark an item as done
  it "can be marked as done" do
    new_item = ToDoItem.new
    new_item.mark_as_done
    expect(new_item.is_done?).to be_a TrueClass
  end

  # Story: As a developer, when I print a ToDoItem is done status is shown.
  it "can print the title and description and status on an item" do
    new_item = ToDoItem.new("New Title","New Description")
    new_item.mark_as_done
    expect(new_item.print_item).to be_a String
    expect(new_item.print_item).to eq("Title: New Title; Description: New Description; Is Done: true")
  end
end


describe "ToDoList" do
  # Story: As a developer, I can add all of my ToDoItems to a ToDoList.
  it "is a list of ToDoItems" do
    expect{ToDoList.new}.to_not raise_error
  end

  it "can add ToDoItems to a ToDoList" do
    to_do_list = ToDoList.new
    item1 = ToDoItem.new("Title 1", "Description 1")
    item2 = ToDoItem.new("Title 2", "Description 2")
    item3 = ToDoItem.new("Title 3", "Description 3")
    to_do_list.add_item_to_list(item1)
    to_do_list.add_item_to_list(item2)
    to_do_list.add_item_to_list(item3)
    expect(to_do_list.to_do_items.length).to eq(3)
  end

  # Story: As a developer with a ToDoList, I can show all the completed items.
  it "displays all completed items" do
    to_do_list = ToDoList.new
    item1 = ToDoItem.new("Title 1", "Description 1")
    item2 = ToDoItem.new("Title 2", "Description 2")
    item3 = ToDoItem.new("Title 3", "Description 3")
    to_do_list.add_item_to_list(item1)
    to_do_list.add_item_to_list(item2)
    to_do_list.add_item_to_list(item3)
    item1.mark_as_done
    item3.mark_as_done
    expect(to_do_list.show_completed_items).to eq([item1, item3])
  end

  # Story: As a developer with a ToDoList, I can showall the not completed items.
  it "displays all not completed items" do
    to_do_list = ToDoList.new
    item1 = ToDoItem.new("Title 1", "Description 1")
    item2 = ToDoItem.new("Title 2", "Description 2")
    item3 = ToDoItem.new("Title 3", "Description 3")
    to_do_list.add_item_to_list(item1)
    to_do_list.add_item_to_list(item2)
    to_do_list.add_item_to_list(item3)
    item1.mark_as_done
    item3.mark_as_done
    expect(to_do_list.show_not_completed_items).to eq([item2])
  end

  # Story: As a developer, I can add items with due dates to my ToDoList.
  it "can add items with due dates" do
    to_do_with_date_list = ToDoList.new
    item1 = ToDoItemWithDate.new("2016-02-24", "Title 1", "Description 1")
    item2 = ToDoItemWithDate.new("18-4-23", "Title 2", "Description 2")
    item3 = ToDoItemWithDate.new("18-12-23", "Title 3", "Description 3")
    item3.change_due_date("2016-8-26")
    to_do_with_date_list.add_item_to_list(item1)
    to_do_with_date_list.add_item_to_list(item2)
    to_do_with_date_list.add_item_to_list(item3)
    expect(to_do_with_date_list.to_do_items.length).to eq(3)
    expect(item1.print_item).to eq("Title: Title 1; Description: Description 1; Is Done: false; Due Date: 2016-02-24")
    expect(item2.print_item).to eq("Title: Title 2; Description: Description 2; Is Done: false; Due Date: 2018-04-23")
    expect(item3.print_item).to eq("Title: Title 3; Description: Description 3; Is Done: false; Due Date: 2016-08-26")
    # test to verify inputing an invalid date will be error
    # expect{ToDoItemWithDate.new("2016-14-24", "Title 1", "Description 1").print_item}.to raise_error
  end

  # Story: As a developer with a ToDoList, I can list all the not completed items that are due today.
  it "can list all the not completed items that due today" do
    to_do_with_date_list = ToDoList.new
    item1 = ToDoItemWithDate.new("2016-02-24", "Title 1", "Description 1")
    item2 = ToDoItemWithDate.new("18-4-23", "Title 2", "Description 2")
    item3 = ToDoItemWithDate.new("18-12-23", "Title 3", "Description 3")
    item4 = ToDoItemWithDate.new("16-2-11", "Title 4", "Description 4")
    item1.change_due_date(Date.today.to_s)
    item3.change_due_date(Date.today.to_s)
    item4.change_due_date(Date.today.to_s)
    to_do_with_date_list.add_item_to_list(item1)
    to_do_with_date_list.add_item_to_list(item2)
    to_do_with_date_list.add_item_to_list(item3)
    to_do_with_date_list.add_item_to_list(item4)

    expect(to_do_with_date_list.not_completed_due_today).to eq([item1, item3, item4])
  end

  # Story: As a developer with a ToDoList, I can list all the not completed items in order of due date.
  it "can list all items not completed in order of due date" do
    to_do_with_date_list = ToDoList.new
    item1 = ToDoItemWithDate.new("2016-02-24", "Title 1", "Description 1")
    item2 = ToDoItemWithDate.new("18-4-23", "Title 2", "Description 2")
    item3 = ToDoItemWithDate.new("18-12-23", "Title 3", "Description 3")
    item4 = ToDoItemWithDate.new("16-2-11", "Title 4", "Description 4")
    to_do_with_date_list.add_item_to_list(item1)
    to_do_with_date_list.add_item_to_list(item2)
    to_do_with_date_list.add_item_to_list(item3)
    to_do_with_date_list.add_item_to_list(item4)

    expect(to_do_with_date_list.not_complete_by_date).to eq([item4, item1, item2, item3])
  end

  # Story: As a developer with a ToDoList with and without due dates, I can show all the not completed items in order of due date, and then the items without due dates.
  it "can list not completed items by due date and the items without due date" do
    to_do_list = ToDoList.new
    item1 = ToDoItemWithDate.new("2016-02-24", "Title 1", "Description 1")
    item2 = ToDoItemWithDate.new("18-4-23", "Title 2", "Description 2")
    item3 = ToDoItemWithDate.new("18-12-23", "Title 3", "Description 3")
    item4 = ToDoItemWithDate.new("16-2-11", "Title 4", "Description 4")
    item5 = ToDoItem.new("Title 5", "Description 5")
    item6 = ToDoItem.new("Title 6", "Description 6")
    to_do_list.add_item_to_list(item1)
    to_do_list.add_item_to_list(item2)
    to_do_list.add_item_to_list(item3)
    to_do_list.add_item_to_list(item4)
    to_do_list.add_item_to_list(item5)
    to_do_list.add_item_to_list(item6)

    expect(to_do_list.organized_by_date).to eq([item4, item1, item2, item3, item5, item6])
  end

end

describe "ToDoItemWithDate" do
  # Story: As a developer, I can create a to do item with a due date, which can be changed.
  it "creates a ToDoItem with a due date" do
    expect{ToDoItemWithDate.new("2015-6-7")}.to_not raise_error
  end

  # Test to make sure that we can change a date of a to do item
  it "can change a due date of an item" do
    item1 = ToDoItemWithDate.new("2015-6-7")
    date = item1.due_date
    item1.change_due_date("2016-03-24")
    expect(item1.due_date).not_to eq(date)
  end

  # Story: As a developer, I can print an item with a due date with field labels and values.
  it "can print the title, description, status and due date on an item" do
    new_item = ToDoItemWithDate.new("2016-2-13", "Title 1", "Description 1")
    new_item.mark_as_done
    new_item.change_due_date("2016-03-24")
    expect(new_item.print_item).to eq("Title: Title 1; Description: Description 1; Is Done: true; Due Date: 2016-03-24")
  end

end
