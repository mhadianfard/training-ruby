class MyClass

  @@instances = []

  def initialize(int)
    @myVar = int
    @@instances.push(self)
  end

  def theMethod
    puts "Instance \"#{@myVar}\" (#{self.object_id}"
  end

  def theObject
    self
  end

  def theMessage
    puts "I'm the original message"
  end

  def get_all_instances
    @@instances
  end
end

obj1 = MyClass.new(1)
obj1.theMethod

obj2 = MyClass.new(2)
obj2.theMethod

method_id = obj1.method :theMethod
method_object = obj1.method :theObject
method_message = obj1.method :theMessage

class MyClass
  def theMessage
    puts "I'm the changed message";
  end
end