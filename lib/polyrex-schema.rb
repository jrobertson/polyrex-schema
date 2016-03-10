#!/usr/bin/env ruby

# file: polyrex-schema.rb

require 'rexle'

class PolyrexSchema

  attr_reader :to_schema
  
  def initialize(s=nil)

    if s then
      s.prepend 'root/' if s[0] == '{'
      
      r = add_node split(s)
      r[3] << node('recordx_type', 'polyrex')  

      @doc = Rexle.new(r)

    end
  end

  
  def parse(s)
    doc = Rexle.new s
    @to_schema = scan_to_schema doc.root
    self
  end  
  
  def to_a()    scan_to_a(@doc.root.xpath 'records/*')  end
  def to_h()    scan_to_h(@doc.root.xpath 'records/*')  end
  def to_doc()  @doc                                    end
  def to_s()    @doc.to_s                               end

  private

  def node(name, val='', *children)
   [name, {}, val, *children]
  end

  def add_node(a)

    return if a.empty?

    schema = a.join('/')
    line = a.shift
    raw_siblings = line[/\{.*/]

    if raw_siblings then      
      return split(raw_siblings[1..-2],';').map {|x| add_node split(x) + a}
    end

    name, raw_fields = line.split('[',2) 

    rows = if raw_fields then

      fields = raw_fields.chop.split(',')
      field_rows = fields.map {|field| node(field.strip) }
      field_rows << node('schema', schema)
      field_rows << node('format_mask', fields.map{|x| "[!%s]" % x.strip}\
                                                                  .join(' '))
    end

    children = add_node(a)
    children = [children] if children and children[0].is_a? String

    node(name, '',
      node('summary', '', *rows), node('records', '', *children)
    )
  end

  def scan_to_a(nodes)

    nodes.map do |r|

      a = r.xpath('summary/*/name()') # => ["entry", "format_mask"] 
      fields = (a - %w(schema format_mask)).map(&:to_sym)
      node = r.xpath 'records/.'

      if node.any? then
        children = scan_to_a(node)
        [r.name.to_sym, *fields, children]
      else
        [r.name.to_sym, *fields]
      end
    end

  end

  def scan_to_h(nodes)

    nodes.map do |r|

      a = r.xpath('summary/*/name()') # => ["entry", "format_mask"] 
      schema = r.text('summary/schema')
      fields = (a - %w(schema format_mask)).map(&:to_sym)
      node = r.xpath 'records/*'

      if node.any? then
        children = scan_to_h(node)
        {name: r.name.to_sym, fields: fields, schema: schema, children: children}
      else
        {name: r.name.to_sym, fields: fields, schema: schema}
      end
    end

  end
  
  def scan_to_schema(node)

    e = node.element('summary')
    fields = e.elements.map(&:name) - %w(schema recordx_type format_mask)
    recs = node.xpath('records/*')

    summary = fields.any? ? ("[%s]" % fields.join(', ')) : ''
    records = recs.any? ? '/' + recs\
                .uniq {|x| x.name <=> x.name}.map {|x| scan_to_schema(x)}.join('/') : ''
    
    node.name + summary + records
  end
  
  # splits into levels identified by a slash (/) or a semicolon (;)
  #
  def split(s, separator='/')
    
    brace_count = 0
    
    s.each_char.inject(['']) do |r, c|

      case c
        when '{'
          brace_count += 1
        when '}'
          brace_count -= 1
      end

      if c != separator or brace_count > 0 then
        r.last << c
      else
        c = '' if c == separator
        r << c
      end
      r
    end

  end

end