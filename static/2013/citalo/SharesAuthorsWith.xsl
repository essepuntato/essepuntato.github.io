<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
    <!ENTITY cito "http://purl.org/spar/cito/">
    <!ENTITY act "http://purl.org/citationact/">
    <!ENTITY fabio "http://purl.org/spar/fabio/">
    <!ENTITY oa "http://www.openannotation.org/spec/core/">
    <!ENTITY frbr "http://purl.org/vocab/frbr/core#">
    <!ENTITY c4o "http://purl.org/spar/c4o/">
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:cito="&cito;"
    xmlns:oa="&oa;"
    xmlns:frbr="&frbr;"
    xmlns:c4o="&c4o;"
    xmlns:fabio="&fabio;"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:variable name="id" select="lower-case(replace(replace(normalize-space(//title),' |–','-'),',|\.|:|;|–',''))" as="xs:string" />
    <xsl:variable name="baseurl" select="concat('&act;',$id,'/')" />
    
    <xsl:variable name="firstnames" as="xs:string*">
        <xsl:for-each select="//author">
            <xsl:variable name="tokens" select="tokenize(.,' ')" as="xs:string*" />
            <xsl:sequence select="string-join(subsequence($tokens,1,count($tokens) - 1),' ')" />
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="query-firstnames" as="xs:string?">
        <xsl:value-of select="$firstnames" separator=" | " />
    </xsl:variable>
    
    <xsl:variable name="surnames" as="xs:string*">
        <xsl:for-each select="//author">
            <xsl:variable name="tokens" select="tokenize(.,' ')" as="xs:string*" />
            <xsl:sequence select="subsequence($tokens,count($tokens))" />
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="query-surnames" as="xs:string?">
        <xsl:value-of select="$surnames" separator=" | " />
    </xsl:variable>
    
    <xsl:variable name="sourceurl" select="concat($baseurl,'source')" />
    
    <xsl:template match="/">
        <rdf:RDF>
            <rdf:Description rdf:about="{$sourceurl}">
                <rdf:type rdf:resource="&fabio;Expression" />
                <xsl:if test="normalize-space(//title) != ''">
                    <dcterms:title><xsl:value-of select="//title" /></dcterms:title>
                </xsl:if>
            </rdf:Description>
            <xsl:for-each select="//description[every $desc in preceding::description satisfies $desc/@id != @id]">
                <rdf:Description rdf:about="{$baseurl}{@id}">
                    <rdf:type rdf:resource="&fabio;Expression" />
                    <dcterms:bibliographicCitation><xsl:value-of select="." /></dcterms:bibliographicCitation>
                </rdf:Description>
            </xsl:for-each>
            <xsl:for-each select="//ref">
                <rdf:Description rdf:about="{$baseurl}{id}">
                    <rdf:type rdf:resource="&c4o;InTextReferencePointer" />
                    <dcterms:identifier><xsl:value-of select="id" /></dcterms:identifier>
                    <frbr:partOf rdf:resource="{$sourceurl}" />
                </rdf:Description>
            </xsl:for-each>
            <xsl:apply-templates select="//ref" />
        </rdf:RDF>
    </xsl:template>
    
    <xsl:template match="ref">
        <xsl:variable name="string" select="normalize-space(description)" />
        <xsl:if test="(some $name in $surnames satisfies matches($string,$name)) or (some $name in $firstnames satisfies matches($string,$name))">
            <rdf:Description rdf:about="{$sourceurl}">
                <cito:sharesAuthorsWith rdf:resource="&act;{$id}/{description/@id}" />
            </rdf:Description>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>