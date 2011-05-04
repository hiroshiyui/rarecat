<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
  <xsl:param name="date">Unknown</xsl:param>
  <xsl:param name="xmlId">Unknown</xsl:param>
  <xsl:param name="archivesType">Unknown</xsl:param>
  <xsl:param name="archivesFonds">Unknown</xsl:param>
  <xsl:param name="archivesSeries">Unknown</xsl:param>
  <xsl:variable name="base">http://tais.ith.sinica.edu.tw/sinicafrsFront/</xsl:variable>
  <xsl:template match="/">
    <DACatalog>
      <xsl:for-each select="archive">
        <AdminDesc>
          <!-- Project -->
          <Project Creator="中央研究院臺灣史研究所">
            <xsl:attribute name="GenDate"><xsl:value-of select="$date"/></xsl:attribute>臺灣珍藏史料數位典藏及加值應用計畫</Project>
          <!-- Catalog -->
          <Catalog>
            <Record>內容主題:檔案:<xsl:value-of select="$archivesType"/>:<xsl:value-of select="$archivesFonds"/>:<xsl:value-of select="$archivesSeries"/></Record>
            <Record>典藏機構與計畫:中央研究院:臺灣史研究所:臺灣珍藏史料數位典藏及加值應用計畫:<xsl:value-of select="$archivesType"/>:<xsl:value-of select="$archivesFonds"/>:<xsl:value-of select="$archivesSeries"/></Record>
          </Catalog>
          <!-- DigiArchiveID -->
          <DigiArchiveID>
            <xsl:value-of select="idDesc/id"/>
          </DigiArchiveID>
          <!-- Hyperlink -->
          <Hyperlink>
            <xsl:value-of select="$base"/>search/search_detail.jsp?xmlId=<xsl:value-of select="$xmlId"/>
          </Hyperlink>
          <!-- ICON -->
          <ICON>
            <xsl:value-of select="daoGrp"/>
          </ICON>
        </AdminDesc>
        <MetaDesc>
          <!-- Title -->
          <xsl:for-each select="idDesc/title">
            <Title>
              <xsl:attribute name="field">
                <xsl:value-of select="titleType"/>
              </xsl:attribute>
              <xsl:value-of select="titles"/>
            </Title>
          </xsl:for-each>
          <!-- Creator -->
          <xsl:for-each select="idDesc/origination">
            <Creator>
              <xsl:attribute name="field">
                <xsl:value-of select="originationType"/>
              </xsl:attribute>
              <xsl:value-of select="originations"/>
            </Creator>
          </xsl:for-each>
          <!-- Subject -->
          <xsl:for-each select="controlAccess/subject">
            <xsl:if test="string(.)">
              <Subject>
                <xsl:attribute name="field"><xsl:text>主題</xsl:text></xsl:attribute>
                <xsl:value-of select="."/>
              </Subject>
            </xsl:if>
          </xsl:for-each>
          <xsl:for-each select="controlAccess/corpName/org">
            <xsl:if test="string(.)">
              <Subject>
                <xsl:attribute name="field"><xsl:text>機關</xsl:text></xsl:attribute>
                <xsl:value-of select="."/>
              </Subject>
            </xsl:if>
          </xsl:for-each>
          <xsl:for-each select="controlAccess/corpName/corp">
            <xsl:if test="string(.)">
              <Subject>
                <xsl:attribute name="field"><xsl:text>團體或公司行號</xsl:text></xsl:attribute>
                <xsl:value-of select="."/>
              </Subject>
            </xsl:if>
          </xsl:for-each>
          <xsl:for-each select="controlAccess/corpName/club">
            <xsl:if test="string(.)">
              <Subject>
                <xsl:attribute name="field"><xsl:text>番社</xsl:text></xsl:attribute>
                <xsl:value-of select="."/>
              </Subject>
            </xsl:if>
          </xsl:for-each>
          <xsl:for-each select="controlAccess/famName">
            <xsl:if test="string(.)">
              <Subject>
                <xsl:attribute name="field"><xsl:text>家族名稱</xsl:text></xsl:attribute>
                <xsl:value-of select="."/>
              </Subject>
            </xsl:if>
          </xsl:for-each>
          <xsl:for-each select="controlAccess/perName">
            <xsl:if test="string(.)">
              <Subject>
                <xsl:attribute name="field"><xsl:text>個人名稱</xsl:text></xsl:attribute>
                <xsl:value-of select="."/>
              </Subject>
            </xsl:if>
          </xsl:for-each>
          <xsl:for-each select="controlAccess/geogName">
            <xsl:if test="string(.)">
              <Subject>
                <xsl:attribute name="field"><xsl:text>地理名稱</xsl:text></xsl:attribute>
                <xsl:value-of select="."/>
              </Subject>
            </xsl:if>
          </xsl:for-each>
          <!-- Description -->
          <xsl:if test="string(idDesc/abstract)">
            <Description>
              <xsl:attribute name="field">
                <xsl:text>摘要</xsl:text>
              </xsl:attribute>
              <xsl:value-of select="idDesc/abstract"/>
            </Description>
          </xsl:if>
          <xsl:if test="string(scopeContent)">
            <Description>
              <xsl:attribute name="field">
                <xsl:text>範圍與內容</xsl:text>
              </xsl:attribute>
              <xsl:value-of select="scopeContent"/>
            </Description>
          </xsl:if>
          <!-- Publisher -->
          <Publisher>
            <xsl:text>臺灣珍藏史料數位典藏及加值應用計畫</xsl:text>
          </Publisher>
          <!-- Contributor -->
          <Contributor>
            <xsl:text>臺灣珍藏史料數位典藏及加值應用計畫、中央研究院臺灣史研究所</xsl:text>
          </Contributor>
          <!-- Date -->
          <xsl:for-each select="idDesc/date">
            <Date>
              <xsl:attribute name="field">
                <xsl:value-of select="dateType"/>
              </xsl:attribute>
              <xsl:value-of select="timePeriod"/>
              <xsl:text> (</xsl:text><xsl:value-of select="ce"/><xsl:text>)</xsl:text>
            </Date>
          </xsl:for-each>
          <!-- Type -->
          <Type></Type>
          <!-- Format -->
          <xsl:for-each select="idDesc/physicalDesc">
            <Format>
              <xsl:value-of select="type"/>
              <xsl:if test="string(number)">
                <xsl:text>:</xsl:text><xsl:value-of select="number"/>
              </xsl:if>
            </Format>
          </xsl:for-each>
          <!-- Identifier -->
          <Identifier>
            <xsl:value-of select="idDesc/id"/>
          </Identifier>
          <!-- Source -->
          <Source><xsl:value-of select="$archivesFonds"/><xsl:text>，</xsl:text>臺灣史檔案資源系統</Source>
          <Source><xsl:value-of select="$base"/></Source>
          <!-- Language -->
          <Language></Language>
          <!-- Relation -->
          <Relation></Relation>
          <!-- Coverage -->
          <Coverage></Coverage>
          <!-- Rights -->
          <Rights>
            <xsl:value-of select="adminInfo/useConstraints/copyrightDesc"/>
          </Rights>
        </MetaDesc>
      </xsl:for-each>
    </DACatalog>
  </xsl:template>
</xsl:stylesheet>
