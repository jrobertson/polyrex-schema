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

    name, raw_fields = a.shift.split('[')  
   
    rows = if raw_fields then

      fields = raw_fields.chop.split(',')
      field_rows = fields.map {|field| node(field.strip) }
      field_rows << node('format_mask', fields.map{|x| "[!%s]" % x}.join(' '))
    end

    node(name, '', 
      node('summary', '', *rows), node('records', '', add_node(a))
    )
  end

end