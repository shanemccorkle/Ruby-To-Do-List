require "date"

class ToDoItem
  def initialize(title="title", description="")
    @title = title
    @description = description
    @is_done = false
    @due_date
  end

  def title
    return @title
  end

  def description
    return @description
  end

  def print_item
    return "Title: #{@title}; Description: #{@description}; Is Done: #{@is_done}"
  end

  def is_done?
    return @is_done
  end

  def mark_as_done
    @is_done = true
  end

  def due_date
    @due_date
  end
end

class ToDoItemWithDate < ToDoItem
  def initialize(due_date, title="default title", description="default desc")
    @due_date = Date.parse(due_date)
    super(title, description)
  end

  def due_date
    return @due_date
  end

  def change_due_date(date)
    @due_date = Date.parse(date)
  end

  def print_item
    return "Title: #{@title}; Description: #{@description}; Is Done: #{@is_done}; Due Date: #{@due_date}"
  end
end

class ToDoList
  def initialize()
      @to_do_item = []
  end

  def add_item_to_list(item)
    @to_do_item.push(item)
  end

  def to_do_items
    return @to_do_item
  end

  def show_completed_items
    return @to_do_item.select { |x| x.is_done? == true }
  end

  def show_not_completed_items
    return @to_do_item.select { |x| x.is_done? == false }
  end

  def not_completed_due_today
    @not_done = @to_do_item.select { |x| x.is_done? == false }
    return @not_done.select { |x| x.due_date == Date.today }
  end

  def not_complete_by_date
    @not_done = show_not_completed_items
    return @not_done.sort_by {|x| x.due_date }
  end

  def organized_by_date
    @not_done = show_not_completed_items
    return @not_done.sort_by {|x| [x.due_date ? 0 : 1, x.due_date] }
  end


end
