<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	version="1.0">
    <xsl:output method="html"/>
    <xsl:param name="prefix">test:</xsl:param>
    <xsl:param name="datestamp">now</xsl:param>

<xsl:include href="record.xsl"/>
    
    <xsl:template match="/">
        <xsl:element name="GetRecord">
            <xsl:apply-templates select="//div2" />
        </xsl:element>
    </xsl:template>
    

</xsl:stylesheet>
