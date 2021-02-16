<?xml version='1.0'?> <!-- As XML file -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:import href="../../mathbook/xsl/pretext-html.xsl" />


<xsl:param name="html.css.stylefile" select="'style_oscarlevin.css'"/>
<xsl:param name="html.css.colorfile" select="'colors_orange_navy.css'" />

<!-- Modified by Bruce: This is a more flexible system which allows full screen etc. You must give the full geogebra address of the geogebra applet in the ptx code -->
<xsl:template match="interactive[@geogebra]" mode="iframe-interactive">
    <iframe src="{@geogebra}" allowfullscreen="true" scrolling="no">
        <xsl:attribute name="id">
            <xsl:apply-templates select="." mode="internal-id"/>
        </xsl:attribute>
        <xsl:apply-templates select="." mode="size-pixels-attributes" />
    </iframe>
</xsl:template>




</xsl:stylesheet>