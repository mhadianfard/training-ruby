class MyCircularQueue

=begin
    Initialize your data structure here. Set the size of the queue to be k.
    :type k: Integer
=end
  def initialize(k)
    @queue = Array.new(k)
    @front = @rear = nil
  end


=begin
    Insert an element into the circular queue. Return true if the operation is successful.
    :type value: Integer
    :rtype: Boolean
=end
  def en_queue(value)
    unless is_full
      if is_empty
        @front = @rear = 0
      else
        @rear = (@rear + 1) % @queue.length
      end
      @queue[@rear] = value
      return true
    end
    false
  end


=begin
    Delete an element from the circular queue. Return true if the operation is successful.
    :rtype: Boolean
=end
  def de_queue()
    unless is_empty
      if (@front == @rear)
        @queue.fill(nil)
        @front = @rear = nil
      else
        @front = (@front + 1) % @queue.length
      end
      return true
    end
    false
  end


=begin
    Get the front item from the queue.
    :rtype: Integer
=end
  def front()
    return -1 if is_empty
    @queue[@front]
  end


=begin
    Get the last item from the queue.
    :rtype: Integer
=end
  def rear()
    return -1 if is_empty
    @queue[@rear].to_i
  end


=begin
    Checks whether the circular queue is empty or not.
    :rtype: Boolean
=end
  def is_empty()
    (@front.nil? || @rear.nil?)
  end


=begin
    Checks whether the circular queue is full or not.
    :rtype: Boolean
=end
  def is_full()
    return false if is_empty
    ((@rear + 1) % @queue.length) == @front
  end

  def print()
    puts "Is Empty? #{is_empty ? 'Yes' : 'No'}"
    puts "Is Full? #{is_full ? 'Yes' : 'No'}"
    self.inspect
  end
end

# Your MyCircularQueue object will be instantiated and called as such:
# obj = MyCircularQueue.new(k)
# param_1 = obj.en_queue(value)
# param_2 = obj.de_queue()
# param_3 = obj.front()
# param_4 = obj.rear()
# param_5 = obj.is_empty()
# param_6 = obj.is_full()