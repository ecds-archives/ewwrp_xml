<?xml version="1.0" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1">

<!-- Created by Rebecca Sutton Koeser & Tavishi Bhasin, January 2004.
     Use this stylesheet to fix Profile Descriptions.
     Capitalizes the first letter of all values for <rs @type="..."> tags.
-->


<xsl:variable name="lowercase">abcdefghijklmnopqrstuvwxyz</xsl:variable>
<xsl:variable name="uppercase">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>


<xsl:output method="xml"/>


<xsl:template match="/">
   <xsl:text disable-output-escaping="yes"/>  
    <xsl:apply-templates/>
</xsl:template>


<xsl:template match="profileDesc/creation/rs">
 <xsl:variable name="val"><xsl:value-of select="."/></xsl:variable>
  <rs>
   <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
     <xsl:value-of select="translate(substring($val, 1, 1), $lowercase,	$uppercase)"/><xsl:value-of select="substring($val, 2)"/>
  </rs>

</xsl:template>


<xsl:template match="@*|node()">
  <xsl:copy>
     <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>  

</xsl:stylesheet>