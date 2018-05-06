<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:f="http://www.essepuntato.it/xslt/function"
    exclude-result-prefixes="xs f"
    version="2.0">
    
    <xsl:output encoding="UTF-8" indent="no" method="xml" />
    
    <xsl:param name="x" select="'X'" as="xs:string" />
    
    <xsl:variable name="root" select="/" />
    
    <xsl:template match="/">
        <refs>
            <meta>
                <title>
                    <xsl:variable name="title" select="normalize-space(//front//article-title)" />
                    <xsl:choose>
                        <xsl:when test="$title = ''">
                            <xsl:text>no-title</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="normalize-space(//front//article-title)" />
                        </xsl:otherwise>
                    </xsl:choose>
                </title>
                <authors>
                    <xsl:for-each select="//front//contrib[@contrib-type='author']">
                        <author>
                            <xsl:value-of select="f:getNames(name)" />
                        </author>
                    </xsl:for-each>
                </authors>
            </meta>
            <xsl:apply-templates />
        </refs>
    </xsl:template>
    
    <xsl:template match="text()" />
    
    <xsl:template match="xref[@ref-type= 'bibr']">
        <xsl:variable name="rid" select="@rid" />
        <ref>
            <id><xsl:value-of select="f:getId(.)" /></id>
            <label><xsl:value-of select="f:getLabel(.)" /></label>
            <description id="{//ref[@rid = $rid]/@id}"><xsl:value-of select="f:getDescription($rid)" /></description>
            <context><xsl:value-of select="f:getContext(.)" /></context>
        </ref>
    </xsl:template>
    
    <xsl:function name="f:getNames" as="xs:string">
        <xsl:param name="element" as="element()" />
        
        <xsl:variable name="tokens" select="tokenize(normalize-space($element),' ')" as="xs:string*" />
        <xsl:variable name="names" as="xs:string*">
            <xsl:for-each select="$tokens">
                <xsl:if test="f:startsWithAnUpperCaseChar(.) and not(matches(.,'^.+\.$'))">
                    <xsl:sequence select="." />
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        
        <xsl:value-of select="$names" />
    </xsl:function>
    
    <xsl:function name="f:startsWithAnUpperCaseChar" as="xs:boolean">
        <xsl:param name="string" as="xs:string" />
        <xsl:choose>
            <xsl:when test="string-length($string) > 0">
                <xsl:variable name="char" select="substring($string,1,1)" as="xs:string" />
                <xsl:choose>
                    <xsl:when test="upper-case($char) = $char">
                        <xsl:value-of select="true()" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="false()" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:function name="f:getId" as="xs:string">
        <xsl:param name="element" />
        <xsl:value-of select="$element/@id" />
    </xsl:function>
    
    <xsl:function name="f:getLabel" as="xs:string">
        <xsl:param name="element" />
        <xsl:value-of select="normalize-space($element)" />
    </xsl:function>
    
    <xsl:function name="f:getDescription" as="xs:string">
        <xsl:param name="id" />
        <xsl:variable name="el" select="$root//ref[@rid = $id][1]" />
        <xsl:value-of select="for $t in $el//text() return $t" separator="" />
    </xsl:function>
    
    <xsl:function name="f:getContext">
        <xsl:param name="el" />
        <xsl:variable name="ancestor-text" select="$el/(ancestor::region)[1]//text()" as="text()*" />
        <xsl:variable name="el-following-text" select="$el/following::text()" as="text()*" />
        <xsl:variable name="el-preceding-text" select="$el/preceding::text()" as="text()*" />
        <xsl:variable name="preceeding-text" select="string-join(($ancestor-text except $el-following-text),'')" as="xs:string" />
        <xsl:variable name="following-text" select="string-join(($ancestor-text except $el-preceding-text),'')" as="xs:string" />
        
        <xsl:variable name="pattern" as="xs:string" select="f:replaceAll(normalize-space($el),('(',')','[',']','^','*','.','?'))" />
        
        <xsl:value-of select="(
            replace(f:getLastSentence($preceeding-text,f:indexOfChar($preceeding-text,'.')),$pattern,$x),
            replace(f:getClosingSentence($following-text,f:indexOfChar($following-text,'.')),$pattern,''))" separator="" />
    </xsl:function>
    
    <xsl:function name="f:replaceAll" as="xs:string?">
        <xsl:param name="string" as="xs:string" />
        <xsl:param name="chars"  as="xs:string*" />
        
        <xsl:choose>
            <xsl:when test="empty($chars)">
                <xsl:sequence select="$string" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="f:replaceAll(replace($string,concat('\',$chars[1]),concat('\\',$chars[1])),subsequence($chars,2))" />
            </xsl:otherwise>
        </xsl:choose>
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