#!/usr/bin/ruby

# file: polyrex-schema.rb

require 'rexml/document'

class PolyrexSchema
  include REXML

  def initialize(s)

    @doc = Document.new
    node = @doc

    s.scan(/\w+\[[^\]]*\]|\w+/).each do |x|
      b1, b2 = x.split('[')
      if b2 then
        node = append_node node, b1 do |summary|
          fields = b2.scan(/\w+(?=[,\]])/)
          fields.each {|x| summary.add Element.new x}
          summary.add Element.new('format_mask').add_text(fields.map {|x| "[!%s]" % x}. join(' '))
        end
      else
        node = append_node node, x
      end
    end

    summary = XPath.first(@doc.root, 'summary')
    summary.add_element Element.new('recordx_type').add_text('polyrex')
    summary.add_element Element.new('schema').add_text(s)

  end

  def to_s
    @doc.to_s
  end

  private

  def append_node(node, name)
    new_node = Element.new name
    summary = Element.new 'summary'
    yield(summary) if block_given?
    new_node.add summary
    records = Element.new 'records'
    new_node.add records
    node.add new_node
    records
  end
end