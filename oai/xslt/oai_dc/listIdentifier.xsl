<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html"/>
    <xsl:param name="prefix">test:</xsl:param>
    <xsl:param name="datestamp">now</xsl:param>

<xsl:include href="setSpec.xsl"/>
    
    <xsl:template match="/">
        <xsl:element name="ListIdentifiers">
            <xsl:apply-templates select="//TEI.2" />
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="TEI.2">
        <xsl:element name="header">            
            <xsl:element name="identifier">
              <xsl:value-of select="$prefix" />
              <xsl:value-of select="docName"/>
            </xsl:element>
            <xsl:element name="datestamp">
              <xsl:value-of select="LastModified" />
  	    </xsl:element>
	    <xsl:apply-templates select="profileDesc"/>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>
