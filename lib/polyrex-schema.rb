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
      return  raw_siblings[1..-2].split(';').map{|x| add_node [x] + a}
    end

    name, raw_fields = line.split('[',2) 

    rows = if raw_fields then

      fields = raw_fields.chop.split(',')
      field_rows = fields.map {|field| node(field.strip) }
      field_rows << node('format_mask', fields.map{|x| "[!%s]" % x}.join(' '))
    end

    children = add_node(a)
    children = [children] if children and children[0].is_a? String

    node(name, '',
      node('summary', '', *rows), node('records', '', *children)
    )
  end

end