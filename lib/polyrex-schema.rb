#!/usr/bin/env ruby

# file: polyrex-schema.rb

require 'rexle'

class PolyrexSchema

  def initialize(s)

    @doc = Rexle.new
    node = @doc

    s.scan(/\w+\[[^\]]*\]|\w+/).each do |x|
      
      b1, b2 = x.split('[')
      
      if b2 then
        
        append_node node, b1 do |summary|
          
          fields = b2.scan(/\w+(?=[,\]])/)
          fields.each {|x| summary.add Rexle::Element.new x}
          summary.add Rexle::Element.new('format_mask').add_text(fields.map {|x| "[!%s]" % x}. join(' '))
        end
        
        node = node.element '*/records'

      else
        node = append_node node, x
      end
    end

    summary = @doc.root.element 'summary'
    summary.add_element Rexle::Element.new('recordx_type').add_text('polyrex')
    summary.add_element Rexle::Element.new('schema').add_text(s)

  end

  def to_s
    @doc.to_s
  end

  def to_doc
    @doc
  end

  private

  def append_node(node, name)

    new_node = Rexle::Element.new name
    summary = Rexle::Element.new 'summary'
    yield(summary) if block_given?

    new_node.add summary
    records = Rexle::Element.new 'records'
    new_node.add records

    node.add new_node

  end
end
