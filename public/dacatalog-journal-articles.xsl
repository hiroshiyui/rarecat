<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
  <!-- parameter(s) -->
  <xsl:param name="date">Unknown</xsl:param>
  <xsl:param name="xmlId">Unknown</xsl:param>
  <xsl:param name="collectionSet">Unknown</xsl:param>
  <xsl:param name="repository">Unknown</xsl:param>
  <xsl:param name="journalTitle">Unknown</xsl:param>
  <!-- main XSL start -->
  <xsl:template match="/">
    <DACatalog>
      <xsl:for-each select="journalArticle">
        <!-- local variables -->
        <xsl:variable name="base">http://rarebooks.ith.sinica.edu.tw/sinicafrsFront99/</xsl:variable>
        <!-- import the original (XDCM format) journal metadata -->
        <xsl:variable name="journalId"><xsl:value-of select="substring(uniqueId,1,5)"/></xsl:variable>
        <xsl:variable name="journalXml"><xsl:value-of select="concat('export/', $journalId, '.xml')"/></xsl:variable>
        <AdminDesc>
          <Project Creator="中央研究院臺灣史研究所">
            <xsl:attribute name="GenDate">
              <xsl:value-of select="$date"/>
              <!-- <xsl:value-of select="document('http://xobjex.com/service/date.xsl')/date/utc/@stamp"/> -->
            </xsl:attribute>臺灣珍藏史料數位典藏及加值應用計畫</Project>
          <Catalog>
            <Record>內容主題:善本古籍:古籍圖書:日治時期臺灣研究古籍:<xsl:value-of select="$collectionSet"/>:期刊:<xsl:value-of select="$journalTitle"/></Record>
            <Record>典藏機構與計畫:中央研究院:臺灣史研究所:臺灣珍藏史料數位典藏及加值應用計畫:日治時期臺灣研究古籍</Record> 
          </Catalog>
          <DigiArchiveID><xsl:value-of select="uniqueId"/></DigiArchiveID>
          <Hyperlink><xsl:value-of select="$base"/>search/search_result2.htm?xmlId=<xsl:value-of select="$xmlId"/>&amp;articleTitle=<xsl:value-of select="articleTitle"/>&amp;display=detail</Hyperlink>
          <!--
            journalArticle:
              http://rarebooks.ith.sinica.edu.tw/sinicafrsFront99
              /search/search_result2.htm?
              xmlId=0000180157
              &articleTitle=%E6%B5%B7%E5%A4%96%E5%9C%96%E6%9B%B8%E9%A4%A8%E8%A8%AA%E5%95%8F%E8%A8%98
              &display=detail
          -->
          <ICON><xsl:value-of select="digitalContent/DO"/></ICON>
        </AdminDesc>
        <MetaDesc>
          <!-- Title -->
          <Title>
            <xsl:for-each select="articleTitle"><xsl:value-of select="."/></xsl:for-each>
          </Title>
          <!-- Creator -->
          <xsl:for-each select="creator">
            <xsl:if test="string(creatorName)"><Creator><xsl:value-of select="creatorName"/><xsl:value-of select="creatorType"/></Creator></xsl:if>
          </xsl:for-each>
          <!-- Subject -->
          <!-- Description -->
          <xsl:for-each select="digitalContent">
            <!-- illustration -->
            <xsl:for-each select="illustration">
              <xsl:for-each select="illustrationDes">
                <xsl:if test="string(.)">
                  <Description>
                    <xsl:attribute name="field">
                      <xsl:text>插圖</xsl:text>
                    </xsl:attribute>

                    <xsl:value-of select="."/>
                  </Description>
                </xsl:if>
              </xsl:for-each>
            </xsl:for-each>
          </xsl:for-each>
          <!-- Publisher -->
          <!-- Contributer -->
          <!-- Date -->
          <Date>
            <xsl:for-each select="publishedDate">
              <xsl:if test="string(.)"><xsl:value-of select="."/></xsl:if>
            </xsl:for-each>
          </Date>
          <!-- Type -->
          <Type>
            <xsl:attribute name="field">
              <xsl:value-of select="type"/>
            </xsl:attribute>
            
            <xsl:value-of select="$collectionSet"/>
          </Type>
          <!-- Format -->
          <!-- Identifier -->
          <Identifier><xsl:value-of select="uniqueId"/></Identifier>
          <!-- Source -->
          <Source><xsl:value-of select="$journalTitle"/><xsl:text>，</xsl:text><xsl:value-of select="volumeTitle"/></Source>
          <Source>日治時期臺灣研究古籍資料庫</Source>
          <Source><xsl:value-of select="$base"/></Source>
          <!-- Language -->
          <xsl:for-each select="language">
            <xsl:if test="string(.)"><Language><xsl:value-of select="."/></Language></xsl:if>
          </xsl:for-each>
          <!-- Relation -->
          <!-- Coverage -->
          <!-- Rights -->
          <Rights>
            <xsl:attribute name="field">
              <xsl:text>典藏單位</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="$repository"/>
            <!--
            <xsl:text>中央研究院臺灣史研究所、國立中央圖書館臺灣分館</xsl:text>
            -->
          </Rights>
        </MetaDesc>
      </xsl:for-each>
    </DACatalog>
  </xsl:template>
</xsl:stylesheet>
