<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

<xsl:variable name="baseurl">http://tamino.library.emory.edu/tamino/EWWRP/wwrp</xsl:variable>
    
  

  <xsl:output method="html"/>

  <xsl:template match="/">
    <html><head>
    <script language="Javascript" src="http://chaucer.library.emory.edu/iln/content-list.js"></script>
</head>
      <body bgcolor="white" marginwidth="150">
        <title>Contents</title>
        <h1 align="center">Contents</h1>       
   <xsl:apply-templates select="//div1" />
        

      </body>
    </html>
  </xsl:template>


<xsl:template match="div1">
  
  <p>
    
    <font size="+1">

  <xsl:value-of select="./@n"/></font>
      
<ul> 
    
  <xsl:apply-templates select="./div2"/>
 
 </ul></p>

</xsl:template>


<xsl:template match="div2">

  <!--
<xsl:attribute name="href">
  <xsl:value-of select="$baseurl"/>?_xquery=for $a in input()/TEI.2 
let $b:=$a/:text 
where $a/teiHeader/fileDesc/titleStmt/title="<xsl:value-of select="."/>" 
return $b</xsl:attribute>  -->

<li><xsl:value-of select="./@n"/> - <xsl:value-of select="./@type"/> - <xsl:value-of select="./docDate"/>
</li>

</xsl:template>


</xsl:stylesheet>