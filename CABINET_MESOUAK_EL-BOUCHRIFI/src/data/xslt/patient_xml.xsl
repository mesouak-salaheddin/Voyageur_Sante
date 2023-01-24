<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : patient_xml.xsl
    Created on : 25 novembre 2022, 20:58
    Author     : Mesouak
    Description:
        Purpose of transformation follows.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:cab="http://www.ujf-grenoble.fr/l3miage/medical"
                xmlns:pat="http://www.ujf-grenoble.fr/l3miage/medical/patient"
                xmlns:act = "http://www.ujf-grenoble.fr/l3miage/actes"
                version="1.0">

    <xsl:output method="xml" indent="yes"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    
    <!--Déclaration des paramètres et des variables-->
    
    <xsl:param name="destinedName" select="'Alécole'"/>
    <xsl:variable name="actes" select="document('../xml/actes.xml', /)/act:ngap"/>
    
    <!-- Template du racine pour l'affichage
    des informations du patient destinedName
    -->
    
    <xsl:template match="/">
        <patient>
            <xsl:apply-templates select="//cab:patient" />
        </patient> 
    </xsl:template>
    
    <!-- Template pour l'affichage des informations
    du patient s'il est le patient destinedName  
    -->
    
    <xsl:template match="cab:patient">
        <!-- S'il s'agit patient destinedName faire-->
        <xsl:if test="pat:nom=$destinedName">
                <nom>
                    <xsl:value-of select="pat:nom"/>
                </nom>
                <prénom>
                    <xsl:value-of select="pat:prénom"/>
                </prénom>
                <sexe>
                    <xsl:value-of select="pat:sexe"/>
                </sexe>
                <naissance>
                    <xsl:value-of select="pat:naissance"/>
                </naissance>
                <numéroSS>
                    <xsl:value-of select="pat:numéro"/>
                </numéroSS>
                <adresse>
                    <!-- Si l'etage existe dans le fichier .xml du cabinet -->
                    <xsl:if test="pat:adresse/pat:étage"> 
                        <étage>
                            <xsl:value-of select="pat:adresse/pat:étage"/>
                        </étage>
                    </xsl:if>
                    <!-- Si le numéro existe dans le fichier .xml du cabinet -->
                    <xsl:if test="pat:adresse/pat:numéro">
                        <numéro>
                            <xsl:value-of select="pat:adresse/pat:numéro"/>
                        </numéro>
                    </xsl:if>
                    <rue>
                        <xsl:value-of select="pat:adresse/pat:rue"/>
                    </rue>
                    <codePostal>
                        <xsl:value-of select="pat:adresse/pat:codePostal"/>
                    </codePostal>
                    <ville>
                        <xsl:value-of select="pat:adresse/pat:ville"/>
                    </ville>
                </adresse>
                <xsl:apply-templates select="pat:visite" />
        </xsl:if>
    </xsl:template>
    
    <!-- Template pour l'affiche des informations
    des visites du patient destinedName
    -->
    
    <xsl:template match="pat:visite">
        <visite>
            <xsl:attribute name="date">
                <xsl:value-of select="@date" />
            </xsl:attribute>
            <!-- Si l'intervenat est désigné déjà 
            dans le fichier .xml du cabinet -->
            <xsl:if test="@intervenant">
            <xsl:variable name="idInfirmier" select="@intervenant"/>
                <intervenant>
                    <nom><xsl:value-of select="//cab:infirmier[@id=$idInfirmier]/cab:nom" /></nom>
                    <prénom><xsl:value-of select="//cab:infirmier[@id=$idInfirmier]/cab:prénom" /></prénom>
                </intervenant>
            </xsl:if>
            <acte>
                <xsl:apply-templates select="pat:acte" />
            </acte>
        </visite>
    </xsl:template>
    
    <!-- Template des soins demandés 
    à effectuer pour le patient destinedName
    -->
    
    <xsl:template match="pat:acte">
        <xsl:variable name="idActe" select="@id"/>
        <xsl:value-of select="$actes/act:actes/act:acte[@id=$idActe]/text()" />
    </xsl:template>
    
</xsl:stylesheet>
