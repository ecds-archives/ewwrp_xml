<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	version="1.0">

<xsl:include href="setSpec.xsl"/>


    <xsl:template match="div2">
      <xsl:element name="record">            
        <xsl:element name="header">            
            <xsl:element name="identifier">
              <xsl:value-of select="$prefix" />
              <xsl:value-of select="./@id"/>
            </xsl:element>
            <xsl:element name="datestamp">
              <xsl:value-of select="$datestamp" />
  	    </xsl:element>
	    <xsl:call-template name="determine_sets">
	      <xsl:with-param name="type" select="./@type"/>	
	    </xsl:call-template>
        </xsl:element>  <!-- end header -->

      <xsl:element name="metadata">
	<xsl:element name="oai_dc:dc">
	    <xsl:apply-templates />
 	    <xsl:element name="dc:type"><xsl:value-of select="@type"/></xsl:element>
	    <xsl:call-template name="description"/>
 	<!-- Note: uncomment identifier template when there is a set url -->
<!-- 	    <xsl:call-template name="identifier"/> -->
  	
	</xsl:element>  <!-- end oai_dc:dc -->
      </xsl:element>  <!-- end metadata -->
      </xsl:element>  <!-- end record -->
    </xsl:template>

<!-- article title -->
<xsl:template match="div2/head">
  <xsl:element name="dc:title"><xsl:value-of select="."/></xsl:element>
</xsl:template>

<!-- source = original publication information -->
<xsl:template match="div2/bibl">
  <xsl:element name="dc:source">
    <xsl:value-of select="title"/>, <xsl:value-of
	select="biblScope[@type='volume']"/>, <xsl:value-of
	select="biblScope[@type='issue']"/>, <xsl:value-of
	select="biblScope[@type='pages']"/>.</xsl:element>
  <!-- pick up the date -->
   <xsl:apply-templates/>
</xsl:template>

<!-- article date -->
<xsl:template match="div2/bibl/date">
  <xsl:element name="dc:date"><xsl:value-of select="."/></xsl:element>
</xsl:template>

<!-- contributor -->
<xsl:template match="titleStmt/respStmt">
  <xsl:element name="dc:contributor"><xsl:value-of select="concat(resp, ' ', name)"/></xsl:element>
</xsl:template>

<!-- publisher -->
<xsl:template match="publicationStmt">
  <xsl:element name="dc:publisher">  <xsl:value-of select="publisher"/>, <xsl:value-of
select="pubPlace"/>. <xsl:value-of select="date"/>: <xsl:value-of
select="address/addrLine"/>.</xsl:element>
  <!-- pick up rights statement -->
  <xsl:apply-templates/>
</xsl:template>

<!-- rights -->
<xsl:template match="availability">
  <xsl:element name="dc:rights"><xsl:value-of select="p"/></xsl:element>
</xsl:template>

<!-- subject -->
<xsl:template match="seriesStmt/title">
  <xsl:element name="dc:subject"><xsl:value-of select="."/></xsl:element>
</xsl:template>

<!-- description -->
<xsl:template name="description">
  <xsl:variable name="figure_count"><xsl:value-of select="count(figure)"/></xsl:variable>
  <xsl:element name="dc:description"><xsl:value-of
select="bibl/extent"/> <xsl:if test="$figure_count > 0">,
<xsl:value-of select="$figure_count"/> illustration<xsl:if
test="$figure_count > 1">s</xsl:if>: <xsl:apply-templates select="figure" mode="description"/></xsl:if>.</xsl:element>

</xsl:template>

<!-- mode = description : only output figure titles in list for description -->
<xsl:template match="figure" mode="description">
  "<xsl:value-of select="head"/>"<xsl:if
test="following-sibling::figure">, </xsl:if>
</xsl:template>

<!-- identifier -->
<!-- Note: this url is not yet firmly in place, but eventually it should be ... -->
<xsl:template name="identifier">
  <xsl:element
name="dc:identifier">http://beckptolemy.library.emory.edu/iln/browse.php?id=<xsl:value-of
select="@id"/></xsl:element>
</xsl:template>


<!-- default: ignore anything not explicitly selected -->
<xsl:template match="text()|@*">
</xsl:template>

</xsl:stylesheet>