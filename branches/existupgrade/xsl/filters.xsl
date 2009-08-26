<?xml version="1.0" encoding="ISO-8859-1"?> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" 
	xmlns:str="http://xsltsl.org/string">

<!-- xslt library : string functions -->
<xsl:include href="string.xsl"/>

<xsl:variable
name="contents_urlA">http://tamino/passthru/servlet/transform/tamino/EWWRP/wwrp?_xquery=for
$a in input()/TEI.2/teiHeader let $b := $a//titleStmt where $a/profileDesc/creation</xsl:variable>
<xsl:variable name="contents_urlB"> return $b sort by (author, title)&amp;_xslsrc=xsl:stylesheet/contents.xsl</xsl:variable>



<xsl:output method="html"/>  

<xsl:template match="/">
<html>
<head>
<link>
  <xsl:attribute name="rel">stylesheet</xsl:attribute>
  <xsl:attribute name="type">text/css</xsl:attribute>
  <xsl:attribute
name="href">http://beckptolemy.library.emory.edu/~rsutton/wwrp.css</xsl:attribute>
</link>
</head>
<body>
<h2>View content by type</h2>

<xsl:apply-templates select="//rs"/>

<b>Date:</b>
<ul>
  <xsl:apply-templates select="//date"/>
</ul>

</body>
</html>
</xsl:template>


<xsl:key name="rskey" match="rs" use="@type"/>

<xsl:template match="rs">

  <!-- only if it hasn't already been printed -->
  <xsl:choose>
    <xsl:when test="@type = preceding-sibling::rs/@type">
  <!-- don't display if this type has already been printed -->
  <!-- this is a bit of a hack, since we don't have the distinct-values function -->
    </xsl:when>
    <xsl:otherwise>
      <p>
        <b>
         <xsl:value-of select="@type"/>
       <!-- capitalize first letter of these labels -->
  <!--         <xsl:call-template name="str:capitalise"> -->
<!--             <xsl:with-param name="text" select="@type"/> -->
<!--           </xsl:call-template> -->
        </b>:
         <ul>
          <xsl:apply-templates select="key('rskey',./@type)" mode="link"/>
         </ul>
      </p>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="rs" mode="link">
  <xsl:choose>
    <xsl:when test=". = preceding-sibling::rs">
  <!-- don't display if this value has already been printed -->
  <!-- this is a bit of a hack, since we don't have the distinct-values function -->
    </xsl:when>
    <xsl:otherwise>
      <li>
      <xsl:choose>
        <xsl:when test="preceding-sibling::rs">
           </xsl:when>
        <xsl:otherwise>
	<!-- so css can display borders between options -->
           <xsl:attribute name="class">first</xsl:attribute>
        </xsl:otherwise>
     </xsl:choose>

<a>
   <xsl:attribute name="href"><xsl:value-of
select="$contents_urlA"/>/rs[@type='<xsl:value-of
select="@type"/>']='<xsl:value-of select="."/>'
<xsl:value-of select="$contents_urlB"/></xsl:attribute>
<xsl:value-of select="."/>
</a>
</li>
    </xsl:otherwise>
  </xsl:choose>


</xsl:template>

<xsl:template match="date">
  <xsl:choose>
    <xsl:when test=". = preceding-sibling::date">
	<!-- don't display if date is same as previous -->
  <!-- this is a bit of a hack, since we don't have the distinct-values function -->
    </xsl:when>
    <xsl:when test=". = ''">  <!-- a couple of dates are blank; don't display -->
    </xsl:when>
    <xsl:otherwise>
      <li>
      <xsl:choose>
        <xsl:when test="preceding-sibling::date">
           </xsl:when>
        <xsl:otherwise>
	<!-- so css can display borders between options -->
           <xsl:attribute name="class">first</xsl:attribute>
        </xsl:otherwise>
     </xsl:choose>

<a>
   <xsl:attribute name="href"><xsl:value-of
select="$contents_urlA"/>/date='<xsl:value-of
select="."/>'
<xsl:value-of select="$contents_urlB"/></xsl:attribute>
<xsl:value-of select="."/>
</a>
</li>
    </xsl:otherwise>
  </xsl:choose>


</xsl:template>


</xsl:stylesheet>