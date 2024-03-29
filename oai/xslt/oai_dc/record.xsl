<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE stylesheet [
<!ENTITY cr "<xsl:text>
</xsl:text>">
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	version="1.0">

<xsl:include href="setSpec.xsl"/>


    <xsl:template match="TEI.2">
      <xsl:element name="record">            
        <xsl:element name="header">            
            <xsl:element name="identifier">
              <xsl:value-of select="$prefix" />
              <xsl:value-of select="docName"/>
            </xsl:element>
            <xsl:element name="datestamp">
              <xsl:value-of select="LastModified" />
  	    </xsl:element>

	<!-- sets are determined by profile description -->
	    <xsl:apply-templates select="teiHeader/profileDesc" mode="set"/>
        </xsl:element>  <!-- end header -->

      <xsl:element name="metadata">
	<xsl:element name="oai_dc:dc">
	    <xsl:apply-templates />

		<!-- Note: MIME type format, as recommended by DCMI -->
		<xsl:element name="dc:format">text/xml</xsl:element>
               <!-- Note: This is the relevant term from the Dublin Core
    	            Recommended Type Vocabulary -->
                <xsl:element name="dc:type">text</xsl:element>


 	    <xsl:call-template name="contents"/> 

 	<!-- Note: uncomment identifier template when there is a set url -->
<!-- 	    <xsl:call-template name="identifier"/> -->
  	
	</xsl:element>  <!-- end oai_dc:dc -->
      </xsl:element>  <!-- end metadata -->
      </xsl:element>  <!-- end record -->
    </xsl:template>




<!-- title -->
<xsl:template match="teiHeader/fileDesc/titleStmt/title">
  <xsl:element name="dc:title"><xsl:value-of select="."/></xsl:element>
</xsl:template>

<!-- author -->
<xsl:template match="teiHeader/fileDesc/titleStmt/author">
  <xsl:element name="dc:author"><xsl:value-of select="@n"/></xsl:element>
</xsl:template>

<!-- source = original publication information -->
<xsl:template match="teiHeader/fileDesc/sourceDesc/bibl">
  <xsl:element name="dc:source"><xsl:value-of select="."/></xsl:element>
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

<!-- note: getting far too many types with this -->
<!-- <xsl:template match="div1"> -->
  <!-- A more specific type term from the document itself. -->
<!--   <xsl:element name="dc:type"><xsl:value-of select="@type"/></xsl:element> -->
<!--   <xsl:apply-templates/> -->
<!-- </xsl:template> -->

<xsl:template match="profileDesc">
  <xsl:apply-templates />
</xsl:template>

<!--  genre type -->
<xsl:template match="profileDesc/creation/rs[@type='genre']">
  <xsl:element name="dc:type"><xsl:value-of select="."/></xsl:element>
</xsl:template>


<!--  geographic coverage -->
<xsl:template match="profileDesc/creation/rs[@type='geography']">
  <xsl:element name="dc:coverage"><xsl:value-of select="."/></xsl:element>
</xsl:template>

<!-- temporal coverage -->
<xsl:template match="profileDesc/creation/date">
  <xsl:element name="dc:coverage"><xsl:value-of select="."/></xsl:element>
</xsl:template>


<!-- document date: possible to have multiple, different dates -->
<xsl:template match="docDate">
  <!-- only output a date if it is different from prior dates -->
  <xsl:if test="not(. = preceding::docDate)">
    <xsl:element name="dc:date"><xsl:value-of select="."/></xsl:element>
  </xsl:if>
</xsl:template>


<!-- many texts have an argument: one kind of description -->
<xsl:template match="argument">
  <xsl:element name="dc:description">
    <xsl:apply-templates/>
  </xsl:element>
</xsl:template>

<!-- dc:description : description of text -->
<!-- Note: not all texts have an argument. -->
<xsl:template match="argument/p">
  <xsl:value-of select="."/>
</xsl:template>


<!-- dc:description - Table of Contents -->
<xsl:template name="contents">
  <xsl:element name="dc:description">
   Contents:&cr;
  <xsl:apply-templates select=".//div1" mode="contents"/>
  </xsl:element>
</xsl:template>


<xsl:template match="div1" mode="contents">
  <xsl:variable name="title">
    <xsl:choose>
      <xsl:when test="@n">
        <xsl:value-of select="@n"/>    
      </xsl:when>
      <xsl:otherwise>[untitled]</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
 
<!-- encapsulate type in () and spaces, if defined; 
     otherwise, display nothing -->
 <xsl:variable name="type">
   <xsl:choose>
    <xsl:when test="@type">
      <xsl:value-of select="concat(' (', @type, ') ')"/>
    </xsl:when>
    <xsl:otherwise> </xsl:otherwise>
   </xsl:choose>
 </xsl:variable>

<xsl:value-of select="concat($title, $type, docAuthor, ' ', docDate, ' ')"/>&cr;

  <xsl:apply-templates select="div2" mode="contents"/>
</xsl:template>

<xsl:template match="div2" mode="contents">
  <xsl:variable name="title">
    <xsl:choose>
      <xsl:when test="@n">
        <xsl:value-of select="@n"/>    
      </xsl:when>
      <xsl:otherwise>[untitled]</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

<xsl:value-of select="concat(' - ', $title, ' (', @type, ') ')"/> &cr;

</xsl:template>




<!-- identifier -->
<!-- Note: we do not yet have a usable url -->
<!--  <xsl:template name="identifier"> -->
<!-- </xsl:template> -->


<!-- default: ignore anything not explicitly selected -->
<xsl:template match="text()|@*">
</xsl:template>

</xsl:stylesheet>
