<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- templates to determine which sets a record is a member of -->


<xsl:template match="profileDesc" mode="set">
  <xsl:apply-templates mode="set"/>
</xsl:template>

<!-- ethnicity -->
<xsl:template match="profileDesc/creation/rs[@type='ethnicity']" mode="set">
    <xsl:choose>
	<xsl:when test=". = 'African American'">
	  <xsl:element name="setSpec">afam</xsl:element>
 	</xsl:when>
	<xsl:when test=". = 'Caucasian'">
	  <xsl:element name="setSpec">cauc</xsl:element>
 	</xsl:when>
	<xsl:when test=". = 'Native American'">
	  <xsl:element name="setSpec">natam</xsl:element>
 	</xsl:when>
    </xsl:choose>
</xsl:template>

<!-- form (edited or not) -->
<xsl:template match="profileDesc/creation/rs[@type='form']" mode="set">
    <xsl:choose>
	<xsl:when test=". = 'Edited'">
	  <xsl:element name="setSpec">ed</xsl:element>
 	</xsl:when>
	<xsl:when test=". = 'Unedited'">
	  <xsl:element name="setSpec">uned</xsl:element>
 	</xsl:when>
    </xsl:choose>
</xsl:template>

<!-- genre -->
<xsl:template match="profileDesc/creation/rs[@type='genre']" mode="set">
    <xsl:choose>
	<xsl:when test=". = 'Poetry'">
	  <xsl:element name="setSpec">poetry</xsl:element>
 	</xsl:when>
	<xsl:when test=". = 'Prose'">
	  <xsl:element name="setSpec">prose</xsl:element>
 	</xsl:when>
	<xsl:when test=". = 'Drama'">
	  <xsl:element name="setSpec">drama</xsl:element>
 	</xsl:when>
    </xsl:choose>
</xsl:template>

<!-- geography -->
<xsl:template match="profileDesc/creation/rs[@type='geography']" mode="set">
    <xsl:choose>
	<xsl:when test=". = 'France'">
	  <xsl:element name="setSpec">FR</xsl:element>
 	</xsl:when>
	<xsl:when test=". = 'Great Britain'">
	  <xsl:element name="setSpec">GB</xsl:element>
 	</xsl:when>
	<xsl:when test=". = 'United States'">
	  <xsl:element name="setSpec">US</xsl:element>
 	</xsl:when>
    </xsl:choose>
</xsl:template>

<!-- time period -->
<xsl:template match="profileDesc/creation/date" mode="set">
    <xsl:choose>
	<xsl:when test=". = '1600-1699'">
	  <xsl:element name="setSpec">16c</xsl:element>
 	</xsl:when>
	<xsl:when test=". = '1700-1799'">
	  <xsl:element name="setSpec">17c</xsl:element>
 	</xsl:when>
	<xsl:when test=". = '1800-1899'">
	  <xsl:element name="setSpec">18c</xsl:element>
 	</xsl:when>
	<xsl:when test=". = '1900-1999'">
	  <xsl:element name="setSpec">19c</xsl:element>
 	</xsl:when>
    </xsl:choose>
</xsl:template>



</xsl:stylesheet>