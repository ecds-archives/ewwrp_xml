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
   <xsl:apply-templates select="//titleStmt" />
        

      </body>
    </html>
  </xsl:template>


  <xsl:key name="authorkey" match="titleStmt" use="author/@n"/>
  
<xsl:template match="author">
  <xsl:variable name="comma">,</xsl:variable>
<xsl:variable name="apostrophe">'</xsl:variable>
<xsl:variable name="replacement">_</xsl:variable>

  <xsl:variable name="lastname">
   <xsl:choose>
     <xsl:when test="contains(., $comma)">
    <xsl:value-of select="substring-before(., $comma)"/>   
     </xsl:when>
     <xsl:otherwise>
       <xsl:value-of select="."></xsl:value-of>
     </xsl:otherwise>
</xsl:choose>
  </xsl:variable> 

 <xsl:variable name="fixedname">
   
   
    <xsl:value-of select="translate($lastname, $apostrophe, $replacement)"/>
  </xsl:variable> 


  <p>
    
    <font size="+1">
<a>
  <xsl:attribute name="onclick">toggle_ul('<xsl:value-of select="$fixedname"/>')</xsl:attribute>
[+]</a>
      <xsl:value-of select="."/></font>
      
<ul>
  <xsl:attribute name="id"><xsl:value-of select="$fixedname"/></xsl:attribute> 
    
  <xsl:apply-templates select="key('authorkey', ./@n)/title">
    <!--    <xsl:with-param name="author"> -->
    <!--       <xsl:value-of select="."/> -->
    <!--    </xsl:with-param> -->
  </xsl:apply-templates>

  </ul></p>

</xsl:template>


<xsl:template match="titleStmt">
  
  <!-- only print author name if it hasn't already been printed -->
  <xsl:choose>
    <xsl:when test="./author/@n = preceding-sibling::titleStmt[1]/author/@n">
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="./author"/>
    </xsl:otherwise>
  </xsl:choose>
     

 
</xsl:template>

<xsl:template match="title">
  <li><a><xsl:attribute name="href">
  <xsl:value-of select="$baseurl"/>?_xquery=for $a in input()/TEI.2 
let $b:=$a/:text 
where $a/teiHeader/fileDesc/titleStmt/title="<xsl:value-of select="."/>" 
return $b</xsl:attribute>
<xsl:value-of select="."/></a>
</li>

</xsl:template>


</xsl:stylesheet>
