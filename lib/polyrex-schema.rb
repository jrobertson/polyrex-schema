#!/usr/bin/ruby

# file: polyrex-schema.rb

require 'rexml/document'

class PolyrexSchema
  include REXML

  def initialize(s)

    @doc = Document.new
    node = Element.new 'root'
    @doc.add node

    s.scan(/\w+\[[^\]]*\]|\w+/).each do |x|
      b1, b2 = x.split('[')
      if b2 then
        node = append_node node, b1 do |summary|
          b2.scan(/\w+(?=[,\]])/).each {|x| summary.add Element.new x}
        end
      else
        node = append_node node, x
      end
    end

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
