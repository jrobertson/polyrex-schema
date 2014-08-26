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

# Polyrex-schema version 0.3

Polyrex-schema version 3.0 can now handle a schema that contain siblings recursively e.g.

    require 'polyrex-schema'



    o = PolyrexSchema.new 'a/{c[name,count];c2[age]/{f[title];f2[colour]}}/d[title]'

    puts o.to_doc.xml pretty: true

output:
<pre>
<?xml version='1.0' encoding='UTF-8'?>
<a>
  <summary>
    <recordx_type>polyrex</recordx_type>
    <schema>a/{c[name,count];c2[age]/{f[title];f2[colour]}}/d[title]</schema>
  </summary>
  <records>
    <c>
      <summary>
        <name></name>
        <count></count>
        <schema>c[name,count]/d[title]</schema>
        <format_mask>[!name] [!count]</format_mask>
      </summary>
      <records>
        <d>
          <summary>
            <title></title>
            <schema>d[title]</schema>
            <format_mask>[!title]</format_mask>
          </summary>
          <records></records>
        </d>
      </records>
    </c>
    <c2>
      <summary>
        <age></age>
        <schema>c2[age]/{f[title];f2[colour]}/d[title]</schema>
        <format_mask>[!age]</format_mask>
      </summary>
      <records>
        <f>
          <summary>
            <title></title>
            <schema>f[title]/d[title]</schema>
            <format_mask>[!title]</format_mask>
          </summary>
          <records>
            <d>
              <summary>
                <title></title>
                <schema>d[title]</schema>
                <format_mask>[!title]</format_mask>
              </summary>
              <records></records>
            </d>
          </records>
        </f>
        <f2>
          <summary>
            <colour></colour>
            <schema>f2[colour]/d[title]</schema>
            <format_mask>[!colour]</format_mask>
          </summary>
          <records>
            <d>
              <summary>
                <title></title>
                <schema>d[title]</schema>
                <format_mask>[!title]</format_mask>
              </summary>
              <records></records>
            </d>
          </records>
        </f2>
      </records>
    </c2>
  </records>
</a>
</pre>

## Resources:

* <a href='http://github.com/jrobertson/polyrex-schema'>jrobertson's polyrex-schema at master</a> [github.com]

