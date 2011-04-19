<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
  <!-- parameters and variables -->
  <xsl:param name="date">Unknown</xsl:param>
  <xsl:variable name="base">http://rarebooks.ith.sinica.edu.tw/sinicafrsFront99/</xsl:variable>
  <!-- main XSL start -->
  <xsl:template match="/">
    <DACatalog>
      <xsl:for-each select="publication">
        <AdminDesc>
          <Project Creator="中央研究院臺灣史研究所">
            <xsl:attribute name="GenDate">
              <xsl:value-of select="$date"/>
              <!-- <xsl:value-of select="document('http://xobjex.com/service/date.xsl')/date/utc/@stamp"/> -->
            </xsl:attribute>日治時期臺灣研究古籍資料庫</Project>
          <Catalog>
            <Record>內容主題:善本古籍:古籍圖書:日治時期臺灣研究古籍:<xsl:value-of select="collectionId"/>:<xsl:value-of select="type"/></Record>
            <Record>典藏機構與計畫:中央研究院:臺灣珍藏史料數位典藏及加值應用計畫:日治時期臺灣研究古籍</Record> 
          </Catalog>
          <DigiArchiveID><xsl:value-of select="uniqueId"/></DigiArchiveID>
          <Hyperlink><xsl:value-of select="$base"/></Hyperlink>
          <xsl:choose>
            <xsl:when test="type = '圖書'">
              <ICON><xsl:value-of select="concat(uniqueId, '_0001.jpg')"/></ICON>
            </xsl:when>
            <xsl:when test="type = '期刊'">
              <xsl:variable name="basedoid"><xsl:value-of select="substring(digitalContent/DO,12,14)"/></xsl:variable>
              <ICON><xsl:value-of select="concat($basedoid, '_0001.jpg')"/></ICON>
            </xsl:when>
          </xsl:choose>
        </AdminDesc>
        <MetaDesc>
          <!-- Title -->
          <Title>
            <xsl:for-each select="title/mainTitle"><xsl:value-of select="."/></xsl:for-each>
            <xsl:for-each select="title/alterTitle">
              <xsl:if test="string(.)">&#160;<xsl:value-of select="."/></xsl:if>
            </xsl:for-each>
          </Title>
          <!-- Creator -->
          <xsl:for-each select="creator">
            <xsl:if test="string(creatorName)"><Creator><xsl:value-of select="creatorName"/><xsl:value-of select="creatorType"/></Creator></xsl:if>
          </xsl:for-each>
          <!-- Subject -->
          <Subject>
            <xsl:attribute name="field">
              <xsl:value-of select="classification"/>
            </xsl:attribute>

            <xsl:for-each select="subjectHeading/primaryHeading"><xsl:value-of select="."/></xsl:for-each>
            <xsl:for-each select="subjectHeading/secHeading">
              <xsl:if test="string(.)"><xsl:text> » </xsl:text><xsl:value-of select="."/></xsl:if>
            </xsl:for-each>
          </Subject>
          <!-- Description -->
          <!-- Publisher -->

          <xsl:for-each select="publisher">
            <Publisher>
              <xsl:attribute name="field">
                <xsl:value-of select="publisherType"/>
              </xsl:attribute>
            
              <xsl:value-of select="publisherName"/>
            </Publisher>
          </xsl:for-each>
          <!-- Contributer -->
          <!-- Date -->
          <xsl:for-each select="publisher">
            <Date>
              <xsl:attribute name="field">
               <xsl:value-of select="publisherType"/>
              </xsl:attribute>

              <xsl:value-of select="publishedYear"/>

              <xsl:for-each select="publishedYearCE">
                <xsl:if test="string(.)"><xsl:text>(</xsl:text><xsl:value-of select="."/><xsl:text>)</xsl:text></xsl:if>
              </xsl:for-each>
            </Date>
          </xsl:for-each>
          <!-- Type -->
          <Type>
            <xsl:attribute name="field">
              <xsl:value-of select="type"/>
            </xsl:attribute>
            
            <xsl:value-of select="collectionId"/>
          </Type>
          <!-- Format -->
          <!-- Identifier -->
          <Identifier><xsl:value-of select="uniqueId"/></Identifier>
          <!-- Source -->
          <Source>日治時期臺灣研究古籍資料庫</Source>
          <Source><xsl:value-of select="$base"/></Source>
          <!-- Language -->
          <xsl:for-each select="language">
            <xsl:if test="string(.)"><Language><xsl:value-of select="."/></Language></xsl:if>
          </xsl:for-each>
          <!-- Relation -->
          <xsl:for-each select="seriesInfo">
            <xsl:if test="string(.)"><Relation><xsl:value-of select="."/></Relation></xsl:if>
          </xsl:for-each>
          <!-- Coverage -->
          <!-- Rights -->
          <Rights>
            <xsl:attribute name="field">
              <xsl:text>典藏單位</xsl:text>
            </xsl:attribute>

            <xsl:text>中央研究院臺灣史研究所、國立中央圖書館臺灣分館</xsl:text>
          </Rights>
        </MetaDesc>
      </xsl:for-each>
    </DACatalog>
  </xsl:template>
</xsl:stylesheet>
