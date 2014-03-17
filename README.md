# Introducing the polyrex-schema gem

The polyrex-schema gem builds a Polyrex document from a string representation of the schema.

## installation

<pre>gem1.9.1 install polyrex-schema</pre>

## example

    require 'polyrex-schema'
    
    o = PolyrexSchema.new 'config/entry[name]/extension[string]/instruction[line,command]'
    o.to_s

output:
<pre>
<root>
  <config>
    <summary/>
    <records>
      <entry>
        <summary><name/></summary>
        <records>
          <extension>
            <summary><string/></summary>
            <records>
              <instruction>
                <summary><line/><command/></summary>
                <records/>
              </instruction>
            </records>
          </extension>
        </records>
      </entry>
    </records>
  </config>
</root>
</pre>

## Resources:

* <a href='http://github.com/jrobertson/polyrex-schema'>jrobertson's polyrex-schema at master</a> [github.com]

