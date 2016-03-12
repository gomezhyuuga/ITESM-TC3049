# Adapter Pattern
# Date: 02-Mar-2016
# Authors:
#          A01020319 Fernando Gómez Herrera

class QueueAdapter
  def initialize(q)
    @stack = q
  end
  def push(x)
    @stack.insert(x)
    self
  end
  def pop
    return nil if self.empty?
    items = self.size
    (items - 1).times { @stack.insert(@stack.remove) }
    return @stack.remove
  end
  def peek
    return nil if empty?
    el = self.pop
    self.push(el)
    return el
  end
  def empty?
    @stack.empty?
  end
  def size
    @stack.size
  end
end
