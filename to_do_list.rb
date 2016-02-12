require "date"

# a class for todo item
class ToDoItem
  def initialize(title="title", description="")
    @title = title
    @description = description
    @is_done = false
  end

  # returns title for an item
  def title
    return @title
  end

  # returns description for item
  def description
    return @description
  end

  # method returns string with title, description, and status
  def print_item
    return "Title: #{@title}; Description: #{@description}; Is Done: #{@is_done}"
  end

  # returns status of is_done
  def is_done?
    return @is_done
  end

  # marks status as done for an item
  def mark_as_done
    @is_done = true
  end

end


# a class for todo item with due date.
class ToDoItemWithDate < ToDoItem

  def initialize(due_date, title="default title", description="default desc")
    @due_date = Date.parse(due_date)
    super(title, description)
  end

  # returns due_date for an item
  def due_date
    return @due_date
  end

  # changes due date for an item
  def change_due_date(date)
    @due_date = Date.parse(date)
  end

  # returns String with title, description, status, and due date
  def print_item
    return "Title: #{@title}; Description: #{@description}; Is Done: #{@is_done}; Due Date: #{@due_date}"
  end
end

class AnniversaryItems < ToDoItem
  def initialize(month, day, title="default title", description="default desc")
    @month = month
    @day = day
    super(title, description)
  end

  # returns title, description, and anniversary date for an item
  def print_item
    return "Title: #{@title}; Description: #{@description}; Anniversary Date: #{@month}/#{@day}"
  end

  # returns month of the anniversary date
  def month
    return @month
  end

  # returns day of the anniversary date
  def day
    return @day
  end
end

class ToDoList
  def initialize()
      @to_do_item = []
      @to_do_with_date = []
      @anniversary_list = []
  end

  # method to add an item to the item list
  def add_item_to_list(item)
    @to_do_item.push(item)
  end

  # method to add an item with a date to the item list with a date
  def add_item_to_with_date(item)
    @to_do_with_date.push(item)
  end

  # method to add an anniversary item to the anniversary list
  def add_anniversary_item(item)
    @anniversary_list.push(item)
  end

  # three methods below return either the item list, item list with due dates, and the anniversary list
  def to_do_items
    return @to_do_item
  end

  def to_do_with_date
    return @to_do_with_date
  end

  def anniversary_items
    return @anniversary_list
  end

  # method to be called that will return only completed items
  def show_completed_items
    return @to_do_item.select { |x| x.is_done? == true }
  end

  # method that will only return not completed items
  def show_not_completed_items
    return @to_do_item.select { |x| x.is_done? == false }
  end

  # method that will return all not completed items with due dates
  def show_not_completed_date_items
    return @to_do_with_date.select { |x| x.is_done? == false }
  end

  # return not completed items that are due today
  def not_completed_due_today
    @not_done = @to_do_with_date.select { |x| x.is_done? == false }
    return @not_done.select { |x| x.due_date == Date.today }
  end

  # return all not completed items by date
  def not_complete_by_date
    @not_done = show_not_completed_date_items
    return @not_done.sort_by {|x| x.due_date }
  end

  # returns all items that are not completed by date, and then all the items that are not completed with no date
  def show_not_completed_by_date_first
    @not_done_date = not_complete_by_date
    @not_done = show_not_completed_items
    return @not_done_date + @not_done
  end

  # returns all items that are not completed by date for this month, and anniversaries that are not completed this month
  def list_not_completed_this_month_date_only
    @due_this_month = not_complete_by_date.select {|x| x.due_date.month == Date.today.month}
    @anniversary_this_month = @anniversary_list.select {|x| x.month == Date.today.month}
    @anniversary_this_month = @anniversary_this_month.sort_by {|x| x.day}
    return @due_this_month + @anniversary_this_month
  end

# returns all items that are not completed by date for this month, and anniversaries that are not completed this month, and then all other items that are not completed regardless of if there is a due date or not
  def list_all_not_completed_this_month
    @due_this_month = not_complete_by_date.select {|x| x.due_date.month == Date.today.month}
    @anniversary_this_month = @anniversary_list.select {|x| x.month == Date.today.month}
    @anniversary_this_month = @anniversary_this_month.sort_by {|x| x.day}
    return @due_this_month + @anniversary_this_month + show_not_completed_items
  end

end
