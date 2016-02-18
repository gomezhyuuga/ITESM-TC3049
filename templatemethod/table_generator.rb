# Template Method Pattern
# Date: 27-Jan-2016
# Authors:
#          A01020319 Fernando Gómez Herrera

# File name: table_generator.rb

class TableGenerator

  def initialize(header, data)
    @header = header
    @data = data
  end

  def generate
    generate_header_row + (@data.map {|x| generate_row(x)}).join
  end

  def generate_header_row
    (@header.map {|x| generate_header_item(x)}).join
  end

  def generate_item(item)
    item
  end

  def generate_row(row)
    (row.map {|x| generate_item(x)}).join
  end

  def generate_header_item(item)
    item
  end
end

class CSVTableGenerator < TableGenerator
  def generate_row(row)
    "#{(row.map {|x| generate_item(x)}).join(',')}\n"
  end

  def generate_header_row
    generate_row(@header)
  end
end

class HTMLTableGenerator < TableGenerator
  def generate
    "<table>\n#{super}</table>\n"
  end
  def generate_header_row
    "<tr>#{super}</tr>\n"
  end
  def generate_row(row)
    "<tr>#{super(row)}</tr>\n"
  end
  def generate_item(item)
    "<td>#{item}</td>"
  end
  def generate_header_item(item)
    "<th>#{item}</th>"
  end
end

class AsciiDocTableGenerator < TableGenerator
  def generate
    "#{super}|==========\n"
  end
  def generate_header_row
    "[options=\"header\"]\n" +
    "|==========\n" +
    generate_row(@header)
  end
  def generate_row(row)
    "|#{(row.map {|item| generate_item(item)}).join('|')}\n"
  end
end
