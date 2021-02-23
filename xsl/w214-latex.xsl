<?xml version='1.0'?>

<!--********************************************************************
Copyright 2018 Andrew Rechnitzer

This file is part of PreTeXt.

PreTeXt is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 2 or version 3 of the
License (at your option).

PreTeXt is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with PreTeXt.  If not, see <http://www.gnu.org/licenses/>.
*********************************************************************-->

<!-- Conveniences for classes of similar elements -->
<!DOCTYPE xsl:stylesheet [
    <!ENTITY % entities SYSTEM "../../mathbook/xsl/entities.ent">
    %entities;
]>

<!-- Identify as a stylesheet -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:xml="http://www.w3.org/XML/1998/namespace"
>

<!-- Override specific tenplates of the standard conversion -->
<xsl:import href="../../mathbook/xsl/pretext-latex.xsl" />

<!-- Intend output for rendering by pdflatex -->
<xsl:output method="text" />

<!-- "commentary" -->
<!-- Green and ugly -->
<xsl:template match="commentary" mode="tcb-style">
    <xsl:text>
      size=minimal,
      attach title to upper,
      after title={\space},
      fonttitle=\bfseries,
      coltitle=black,
      colback=green
    </xsl:text>
</xsl:template>

<!-- "objectives", "outcomes",etc. -->
<!-- Default tcb, identically      -->
<xsl:template match="&GOAL-LIKE;" mode="tcb-style">
    <xsl:text/>
</xsl:template>

<!-- EXAMPLE-LIKE: "example", "question", "problem" -->

<xsl:template match="example" mode="tcb-style">
    <xsl:text>
      blanker,
      coltitle=primaryColor,
      fonttitle=\bfseries,
      after title={\newline

      },
      attach title to upper,
      breakable,
      left=5mm,
      top=3mm,
      before skip=10pt,
      after skip=10pt,
      borderline west={0.4mm}{0pt}{primaryColor},
      borderline north={0.4mm}{0pt}{primaryColor},
      after upper = {\hfill \(\blacksquare\)},
    </xsl:text>
</xsl:template>

<!-- DEFINITION-LIKE: "definition"   -->
<!-- Various extreme choices from the tcolorbox documentation -->
<!-- Note: a trailing comma is OK, and maybe a good idea      -->
<!-- Note: the style definition may split across several line -->
<!-- of the LaTeX source using the hex A (dec 10) character   -->
<!-- Note: "enhanced" is necessary for boxed titles           -->
<xsl:template match="&DEFINITION-LIKE;" mode="tcb-style">
  <xsl:text>
    breakable,
    colframe=primaryColor,
    colback=primaryColor!5,
    colbacktitle=primaryColor,
    coltitle=white,
    fonttitle = \bfseries,
    enhanced,
    attach boxed title to top left={xshift=7mm, yshift*=-2ex},
    arc=10pt,
  </xsl:text>
</xsl:template>

<!-- THEOREM-LIKE -->
<xsl:template match="&THEOREM-LIKE;" mode="tcb-style">
  <xsl:text>
    breakable,
    colframe=secondaryColor,
    colback=secondaryColor!5,
    colbacktitle=secondaryColor,
    coltitle=black,
    fonttitle = {\bfseries\upshape},
    after title = {\ },
    tcbox width = auto limited, % Don't know if this is necessary
    enhanced,
    attach title to upper,
    arc=3pt,
  </xsl:text>
</xsl:template>


<xsl:template match="proof" mode="tcb-style">
  <xsl:text>
    blanker, coltitle=black,
    fonttitle=\itshape,
    after title={\ },
    attach title to upper,
    breakable,left=5mm,
    before skip=10pt,after skip=10pt,
    borderline west={1mm}{0pt}{secondaryColor},
    after upper = {\hfill \(\square\)},
  </xsl:text>
</xsl:template>

<!-- REMARK-LIKE: "remark", "convention", "note",   -->
<!--            "observation", "warning", "insight" -->
<!-- COMPUTATION-LIKE: "computation", "technology"  -->
 <!--White title text, but title backgounds vary    -->
 <!--by category, and remarks have sharp corners    -->
 <!--
<xsl:template match="&REMARK-LIKE;" mode="tcb-style">
    <xsl:text>
      %colbacktitle=primaryColor,
      %sharp corners,
      %enhanced,
      %attach boxed title to top center={yshift*=-2ex},
    </xsl:text>
</xsl:template>
-->

<xsl:template match="&COMPUTATION-LIKE;" mode="tcb-style">
    <xsl:text>
      colbacktitle=secondaryColor,
    </xsl:text>
</xsl:template>


<xsl:param name="exercise.divisional.solution" select="'no'" />
<xsl:param name="exercise.divisional.answer" select="'no'" />
<xsl:param name="exercise.divisional.hint" select="'no'" />

<xsl:param name="exercise.inline.solution" select="'no'" />

<xsl:param name="exercise.inline.answer" select="'no'" />

<!--
  Write down the url of a GeoGebra activity, allowing line breaks so that the full url can be read (for a print version). This requires the xurl package loaded in the main ptx file.
-->
<xsl:template match="interactive[@geogebra]" mode="static-caption">
    <xsl:choose>
        <xsl:when test="caption">
            <xsl:apply-templates select="caption" />
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>\url{</xsl:text>
            <xsl:value-of select="@geogebra"/>
            <xsl:text>}</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!--
  Create the QR code of the url that links to the GeoGebra activity hosted on geogebra.org. I think the original creates the link to a page where the activity is embedded using the html output. In that case a baseurl needs to be set first. For now this adaptation is preferable to us.
-->
<xsl:template match="*" mode="static-qr">
    <xsl:choose>
        <xsl:when test="not(@geogebra = '')">
            <xsl:text>{\hypersetup{urlcolor=black}</xsl:text>
            <xsl:text>\qrcode[height=\qrsize]{</xsl:text>
                <xsl:value-of select="@geogebra" />
            <xsl:text>}}%&#xa;</xsl:text>
        </xsl:when>
    </xsl:choose>
</xsl:template>

<!--
  Without this, the compiler creates an "empty" QR code for the jsxgraph activity, due to the previous adaptation, which is of course senseless. This ensures that no QR code is created.
-->
<xsl:template match="interactive[@platform='jsxgraph']" mode="static-qr">
  <xsl:text>{}</xsl:text>
</xsl:template>


<!-- The Chinese characters in UTF font work in the html version, but require a package in the LaTeX version. The adaptations are made below.
Since these are aapended at the top of the user defined macros
-->
<xsl:variable name="latex-packages">
  <xsl:text>\usepackage{CJKutf8}%&#xa;</xsl:text>
  <xsl:text>\newcommand{\ChBird}{\begin{CJK}{UTF8}{gbsn} \text{鸟} \end{CJK}}%&#xa;</xsl:text>
  <xsl:text>\newcommand{\ChEye}{\begin{CJK}{UTF8}{gbsn} \text{眼} \end{CJK}}%&#xa;</xsl:text>
  <xsl:text>\newcommand{\ChCross}{\begin{CJK}{UTF8}{gbsn} \text{叉} \end{CJK}}%&#xa;</xsl:text>
</xsl:variable>

<xsl:param name="latex.geometry" select="'a4paper'"/>



</xsl:stylesheet>
