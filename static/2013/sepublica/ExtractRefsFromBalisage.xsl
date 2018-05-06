<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:d="http://docbook.org/ns/docbook"
    xmlns:f="http://www.essepuntato.it/xslt/function"
    exclude-result-prefixes="xs d f"
    version="2.0">
    
    <xsl:output encoding="UTF-8" indent="no" method="xml" />
    
    <xsl:variable name="root" select="/" />
    
    <xsl:template match="/">
        <refs>
            <xsl:apply-templates />
        </refs>
    </xsl:template>
    
    <xsl:template match="text()" />
    
    <xsl:template match="d:xref[for $id in @linkend return exists(//d:bibliomixed[@xml:id = $id])]">
        <ref>
            <label><xsl:value-of select="f:getLabel(@linkend)" /></label>
            <description><xsl:value-of select="f:getDescription(@linkend)" /></description>
            <context><xsl:value-of select="f:getContext(.)" /></context>
        </ref>
    </xsl:template>
    
    <xsl:function name="f:getLabel" as="xs:string">
        <xsl:param name="id" />
        <xsl:variable name="el" select="$root//element()[@xml:id = $id][1]" />
        <xsl:variable name="name" select="local-name($el)" />
        <xsl:value-of select="count($el/preceding::element()[local-name() = $name]) + 1" />
    </xsl:function>
    
    <xsl:function name="f:getDescription" as="xs:string">
        <xsl:param name="id" />
        <xsl:variable name="el" select="$root//element()[@xml:id = $id][1]" />
        <xsl:value-of select="for $t in $el//text() return $t" separator="" />
    </xsl:function>
    
    <xsl:function name="f:getContext">
        <xsl:param name="el" />
        <xsl:variable name="ancestor-text" select="$el/(ancestor::d:para)[1]//text()" as="text()*" />
        <xsl:variable name="el-following-text" select="$el/following::text()" as="text()*" />
        <xsl:variable name="el-preceding-text" select="$el/preceding::text()" as="text()*" />
        <xsl:variable name="preceeding-text" select="string-join(($ancestor-text except $el-following-text),'')" as="xs:string" />
        <xsl:variable name="following-text" select="string-join(($ancestor-text except $el-preceding-text),'')" as="xs:string" />
        
        <xsl:value-of select="(
            f:getLastSentence($preceeding-text,f:indexOfChar($preceeding-text,'.')),
            '[x]',
            f:getClosingSentence($following-text,f:indexOfChar($following-text,'.')))" separator="" />
    </xsl:function>
    
    <xsl:function name="f:getLastSentence">
        <xsl:param name="string" />
        <xsl:param name="indexes" as="xs:integer*" />
        <xsl:choose>
            <xsl:when test="exists($indexes)">
                <xsl:variable name="i" select="count($indexes)" as="xs:integer" />
                <xsl:variable name="index" select="$indexes[$i]" />
                <xsl:variable name="substring" select="substring($string,$index)" />
                <xsl:choose>
                    <xsl:when test="matches($substring,'^\.\s*[A-Z].+')">
                        <xsl:value-of select="replace($substring,'^\. *','')" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="f:getLastSentence($string,subsequence($indexes,1,$i - 1))" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$string" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:function name="f:getClosingSentence">
        <xsl:param name="string" />
        <xsl:param name="indexes" as="xs:integer*" />
        <xsl:choose>
            <xsl:when test="exists($indexes)">
                <xsl:variable name="i" select="1" as="xs:integer" />
                <xsl:variable name="index" select="$indexes[$i]" />
                <xsl:variable name="substring" select="substring($string,1,$index - 1)" />
                <xsl:choose>
                    <xsl:when test="matches(substring-after($string,$substring),'^\.\s*[A-Z].+')">
                        <xsl:value-of select="concat($substring, '.')" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="f:getClosingSentence($string,subsequence($indexes,2))" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$string" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:function name="f:indexOfChar" as="xs:integer*">
        <xsl:param name="string" as="xs:string" />
        <xsl:param name="value" as="xs:string" />
        <xsl:variable name="string-codepoints" select="string-to-codepoints($string)" />
        <xsl:variable name="value-codepoints" select="string-to-codepoints($value)" />
        
        <xsl:sequence select="index-of($string-codepoints,$value-codepoints)" />
    </xsl:function>
    
</xsl:stylesheet>