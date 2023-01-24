<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : cabinetInfirmier.xsl
    Created on : 9 novembre 2022, 10:28
    Author     : Mesouak
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:cab="http://www.ujf-grenoble.fr/l3miage/medical"
                xmlns:pat="http://www.ujf-grenoble.fr/l3miage/medical/patient"
                xmlns:act = "http://www.ujf-grenoble.fr/l3miage/actes"
                version="1.0">
    <xsl:output method="html"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    
    <!--Déclaration des paramètres et des variables-->
    
    <xsl:param name="destinedId" select="001"/>
    <xsl:variable name="actes" select="document('actes.xml', /)/act:ngap"/>
    
    
    <!-- Template du racine pour l'affichage
    du site l'infirmier désigné
    -->
    
    <xsl:template match="/">
        <html>
            <head>
                <title>cabinet.xsl</title>
                <link rel="stylesheet" type="text/css" href="../css/style.css" />
                <script type="text/javascript">
                    <![CDATA[
                        function openFacture(prenom, nom, actes) 
                        {
                            var width  = 500;
                            var height = 300;
                            if(window.innerWidth) {
                                var left = (window.innerWidth-width)/2;
                                var top = (window.innerHeight-height)/2;
                            }
                            else {
                                var left = (document.body.clientWidth-width)/2;
                                var top = (document.body.clientHeight-height)/2;
                            }
                            var factureWindow = window.open('','facture','menubar=yes, scrollbars=yes, top='+top+', left='+left+', width='+width+', height='+height+'');
                            factureText = "Facture pour : " + prenom + " " + nom;
                            factureWindow.document.write(factureText);
                         }
                    ]]>
                </script> 
            </head>
            <body>
                <p>Bonjour
                    <xsl:value-of select="cab:cabinet/cab:infirmiers/cab:infirmier[@id=$destinedId]/cab:prénom/text()"/> , </p>
                <p> Aujourd'hui , vous avez  
                    <xsl:value-of select="count(//cab:patients/cab:patient/pat:visite[@intervenant=$destinedId])"/>
                    patients .
                </p>
                <xsl:apply-templates select="//cab:patients"/>
                <br/>
            </body>
        </html>
    </xsl:template>
    
    <!-- Template des patients d'intervenant désigné-->
    
    <xsl:template match="cab:patients">
        <p>
            <xsl:apply-templates select="//cab:patient/pat:visite[@intervenant=$destinedId]"/>
        </p>
    </xsl:template>
    
    <!-- Template pour l'affiche des informations
    des visites des patients d'intervenant désigné
    -->
    
    <xsl:template match="cab:patient/pat:visite[@intervenant=$destinedId]">
        <table border="1">
            <tr><td>Nom du patient :</td></tr>
            <tr>
                <td><xsl:value-of select= "../pat:nom"/></td>
            </tr>
        </table>
        <br/>
        <xsl:apply-templates select="../pat:adresse"/>
        <br/>
        <xsl:apply-templates select="../pat:visite/pat:acte"/>
        <br/>  
        <button type="button">
            <xsl:attribute name="type">Submit</xsl:attribute>
            <xsl:attribute name="value">Facture</xsl:attribute>
            <xsl:attribute name="onclick">
                openFacture('<xsl:value-of select="../pat:prénom"/>',
                '<xsl:value-of select="../pat:nom"/>',
                '<xsl:value-of select="../pat:acte"/>')
            </xsl:attribute>
            Facture</button> 
        <br/><br/><br/>    
    </xsl:template>
    
    <!-- Template pour l'affichge des adresses
    des patients d'intervenant désigné
    -->
    
    <xsl:template match="pat:adresse">
        <table border="1">
            <tr>
                <td>L'adresse du patient : </td>
            </tr>
            <tr>
                <td>
                    <!-- Si l'etage existe dans le fichier .xml du cabinet -->
                    <xsl:if test="pat:étage">
                    étage n°<xsl:value-of select= "pat:étage/text()"/>,
                    </xsl:if>
                    <xsl:text> </xsl:text> 
                    <!-- Si le numéro existe dans le fichier .xml du cabinet -->
                    <xsl:if test="pat:numéro">
                    <xsl:value-of select= "pat:numéro/text()"/>
                    </xsl:if>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select= "pat:rue/text()"/>,
                    <xsl:text> </xsl:text>            
                    <xsl:value-of select= "pat:ville/text()"/>,
                    <xsl:text> </xsl:text>
                    <xsl:value-of select= "pat:codePostal/text()"/>. 
                </td>
            </tr>
        </table>  
        <br/>  
    </xsl:template>
    
    <!-- Template des soins demandés 
    à effectuer pour chaque patient
    -->
    
    <xsl:template match="pat:acte">
        <xsl:variable name="idActe" select= "@id"/> 
        <table border="1">
            <tr>
                <td>Soin demandé:</td>
            </tr>
            <tr>
                <td> 
                    <xsl:value-of select= "$actes/act:actes/act:acte[@id=$idActe]/text()"/>
                </td> 
            </tr>
        </table>
        <br></br>
        
    </xsl:template>
    
</xsl:stylesheet>

