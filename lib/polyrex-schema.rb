#!/usr/bin/env ruby

# file: polyrex-schema.rb

require 'rexle'

class PolyrexSchema

  def initialize(s)

    s.prepend 'root/' if s[0] == '{'

    a = s.scan(/(\{[^\}]+\})|(\w+[^\/]*)\/|\/(.*)|(.+)/).flatten(1).compact

    r = add_node a
    r[3] << node('recordx_type', 'polyrex') << node('schema',s)
    @doc = Rexle.new(r)
  end

  def to_a()
    scan_to_a(@doc.root.xpath 'records/.')
  end

  def to_h()
    scan_to_h(@doc.root.xpath 'records/.')
  end

  def to_doc()
    @doc
  end

  def to_s()
    @doc.to_s
  end

  private

  def node(name, val='', *children)
   [name, val, {}, *children]
  end

  def add_node(a)

    return if a.empty?

    schema = a.join('/')
    line = a.shift
    raw_siblings = line[/\{.*/]

    if raw_siblings then

      r = raw_siblings[1..-2].split(/\s*\s*;/).map do |x| 

        a2 = x.scan(/(\{[^\}]+\})|(\w+[^\/]*)\/|\/(.*)|(.+)/).flatten(1)\
                                                                      .compact
        add_node a2 + a
      end

      return r
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
      node = r.xpath 'records/.'

      if node.any? then
        children = scan_to_h(node)
        {name: r.name.to_sym, fields: fields, schema: schema, children: children}
      else
        {name: r.name.to_sym, fields: fields, schema: schema}
      end
    end

  end

end