#!/usr/bin/env ruby

# file: polyrex-schema.rb

require 'rexle'

class PolyrexSchema

  def initialize(s)

    a = s.split('/')

    r = add_node a
    r[3] << node('recordx_type', 'polyrex') << node('schema',s)
    @doc = Rexle.new(r)
  end

  def to_a()
    scan_to_a(@doc.root.element 'records/.')
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

    line = a.shift

    raw_siblings = line[/\{.*/]


    if raw_siblings then

      return  raw_siblings[1..-2].split(/\s*\s*;/).map{|x| add_node [x] + a}
    end

    name, raw_fields = line.split('[',2) 

    rows = if raw_fields then

      fields = raw_fields.chop.split(',')
      field_rows = fields.map {|field| node(field.strip) }
      field_rows << node('format_mask', fields.map{|x| "[!%s]" % x.strip}\
                                                                  .join(' '))
    end

    children = add_node(a)
    children = [children] if children and children[0].is_a? String

    node(name, '',
      node('summary', '', *rows), node('records', '', *children)
    )
  end

  def scan_to_a(r)

    a = r.xpath('summary/*/name()') # => ["entry", "format_mask"] 
    fields = (a - ["format_mask"]).map(&:to_sym)
    node = r.element 'records/.'

    if node then
      children = scan_to_a(node)
      [r.name.to_sym, *fields, children]
    else
      [r.name.to_sym, *fields]
    end
  end

end