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
<!-- Default tcolorbox, but with tricolor titles    -->
<!-- Each just slightly different                   -->

<!-- Example styling from CLP -->
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

<xsl:template match="question" mode="tcb-style">
    <xsl:text>
      colback=white, colframe=blue, colbacktitle=white, coltitle=blue,
        enhanced,
        breakable,
        attach boxed title to top left={xshift=7mm, yshift*=-\tcboxedtitleheight/2},
        frame hidden,
        overlay unbroken={
        \draw[blue, thick, square-, rounded corners] ([yshift=-3ex]interior.north west)--(interior.north west)--(title);
        \draw[blue,thick, -square, rounded corners] (title)--(interior.north east)--([yshift=-3ex]interior.north east);
        \draw[blue,thick, square-square, rounded corners] ([yshift=3ex]interior.south west)--(interior.south west)--(interior.south east)--([yshift=3ex]interior.south east);
        },
        overlay first={
          \draw[blue,thick, square-, rounded corners] ([yshift=-3ex]interior.north west)--(interior.north west)--(title);
          \draw[blue,thick, -square, rounded corners] (title)--(interior.north east)--([yshift=-3ex]interior.north east);
          },
        overlay middle={},
        overlay last={
          \node[blue, draw, thick, rectangle, rounded corners] (repeatTitle) at ([xshift=-12ex]interior.south east) {\textbf{Example~\thetcbcounter}};
          \draw[blue, thick, square-, rounded corners] ([yshift=3ex]interior.south west)--(interior.south west)--(repeatTitle);
          \draw[blue, thick, -square,rounded corners] (repeatTitle)--(interior.south east)--([yshift=3ex]interior.south east);
          },
    </xsl:text>
</xsl:template>

<xsl:template match="problem" mode="tcb-style">
    <xsl:text>
      colback=white, colframe=red, colbacktitle=white, coltitle=red,
        enhanced,
        breakable,
        attach boxed title to top left={xshift=7mm, yshift*=-\tcboxedtitleheight/2},
        frame hidden,
        overlay unbroken={
        \draw[red, thick, |-, rounded corners] ([yshift=-3ex]interior.north west)--(interior.north west)--(title);
        \draw[red,thick, -|, rounded corners] (title)--(interior.north east)--([yshift=-3ex]interior.north east);
        \draw[red,thick, |-|, rounded corners] ([yshift=3ex]interior.south west)--(interior.south west)--(interior.south east)--([yshift=3ex]interior.south east);
        },
        overlay first={
          \draw[red,thick, |-, rounded corners] ([yshift=-3ex]interior.north west)--(interior.north west)--(title);
          \draw[red,thick, -|, rounded corners] (title)--(interior.north east)--([yshift=-3ex]interior.north east);
          },
        overlay middle={},
        overlay last={
          \node[red, draw, thick, rectangle, rounded corners] (repeatTitle) at ([xshift=-12ex]interior.south east) {\textbf{Example~\thetcbcounter}};
          \draw[red, thick, |-, rounded corners] ([yshift=3ex]interior.south west)--(interior.south west)--(repeatTitle);
          \draw[red, thick, -|,rounded corners] (repeatTitle)--(interior.south east)--([yshift=3ex]interior.south east);
          },
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
  TODO: Set geometry parameter to a4page instead of default letter
-->

<xsl:template match="interactive[@geogebra]" mode="static-caption">
    <xsl:choose>
        <!-- author-supplied override -->
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





</xsl:stylesheet>
