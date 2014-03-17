# Introducing the polyrex-schema gem

The polyrex-schema gem builds a Polyrex document from a string representation of the schema.

## installation

<pre>gem install polyrex-schema</pre>

## example

    require 'polyrex-schema'
    
    o = PolyrexSchema.new 'config/entry[name]/extension[string]/instruction[line,command]'
    o.to_s

output:
<pre>
&lt;root&gt;
  &lt;config&gt;
    &lt;summary/&gt;
    &lt;records&gt;
      &lt;entry&gt;
        &lt;summary&gt;&lt;name/&gt;&lt;/summary&gt;
        &lt;records&gt;
          &lt;extension&gt;
            &lt;summary&gt;&lt;string/&gt;&lt;/summary&gt;
            &lt;records&gt;
              &lt;instruction&gt;
                &lt;summary&gt;&lt;line/&gt;&lt;command/&gt;&lt;/summary&gt;
                &lt;records/&gt;
              &lt;/instruction&gt;
            &lt;/records&gt;
          &lt;/extension&gt;
        &lt;/records&gt;
      &lt;/entry&gt;
    &lt;/records&gt;
  &lt;/config&gt;
&lt;/root&gt;
</pre>

## Resources:

* <a href='http://github.com/jrobertson/polyrex-schema'>jrobertson's polyrex-schema at master</a> [github.com]

