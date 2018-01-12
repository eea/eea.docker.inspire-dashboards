<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:daobs="http://daobs.org"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="text"/>
    
    <xsl:template match="/">
<xsl:value-of select=".//daobs:title"/>
        
<xsl:value-of select="'| Indicator | Definition |'"/><xsl:text>
</xsl:text>
        <xsl:value-of select="'| --- | --- |'"/>  <xsl:text>
</xsl:text>
        <xsl:for-each select=".//daobs:variables|.//daobs:indicator">
            <xsl:sort select="@id"/>
            <xsl:value-of select="concat('| ', @id, ' | ', normalize-space(daobs:name) , ' |')"/><xsl:text>
</xsl:text>                 
        </xsl:for-each>
        
    </xsl:template>
</xsl:stylesheet>