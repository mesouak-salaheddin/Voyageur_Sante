<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : patient_html.xsl
    Created on : 28 novembre 2022, 19:28
    Author     : Mesouak
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    
    <!-- Template du racine pour l'affichage
    des informations du patient
    -->
    
    <xsl:template match="/">
        <html>
            <head>
                <title>patient_html</title>
                <link rel="stylesheet" type="text/css" href="../css/patientPage.css" />
            </head>
            <body>
                <h2>Bonjour<xsl:text> </xsl:text>
                    <q>
                        <xsl:value-of select="patient/sexe" />.
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="patient/nom" />
                    </q>,</h2>
                <br/>
                <h3>Les renseignements du patient :</h3>
                <br/>
                <blockquote>
                    <p>
                        <div>Nom : </div>
                        <q>
                            <xsl:value-of select="patient/nom" />
                        </q>
                    </p>
                    <p>
                        <div>Prénom : </div>
                        <q>
                            <xsl:value-of select="patient/prénom" />
                        </q>
                    </p>
                    <p>
                        <div>Sexe :</div> 
                        <q>
                            <xsl:value-of select="patient/sexe" />
                        </q>
                    </p>
                    <p>
                        <div>Date de naissance : </div>
                        <q>
                            <xsl:value-of select="patient/naissance" />
                        </q>
                    </p>
                    <p>
                        <div>Numéro de sécurité sociale : </div>
                        <q>
                            <xsl:value-of select="patient/numéroSS" />
                        </q>
                    </p>
                    <p>
                        <div>Adresse :</div> 
                        <q>
                            <!-- Si l'étage existe dans le fichier .xml du patient -->
                            <xsl:if test="patient/adresse/étage">
                                Etage n°<xsl:value-of select= "patient/adresse/étage/text()"/>,
                            </xsl:if> 
                            <xsl:text> </xsl:text>
                            <!-- Si le numéro existe dans le fichier .xml du patient -->
                            <xsl:if test="patient/adresse/numéro">
                                <xsl:value-of select= "patient/adresse/numéro/text()"/>
                            </xsl:if>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select= "patient/adresse/rue/text()"/>,
                            <xsl:text> </xsl:text>            
                            <xsl:value-of select= "patient/adresse/ville/text()"/>,
                            <xsl:text> </xsl:text>
                            <xsl:value-of select= "patient/adresse/codePostal/text()"/>.
                        </q>
                    </p>
                </blockquote>
                <br/>
                <br/>
                <h3>La liste des visites:</h3>
                <br/>
                <table>
                    <tr>
                        <th>Date de visite :</th>
                        <th>Acte :</th>
                        <th>Intervenant :</th>
                    </tr>
                    <xsl:apply-templates select="patient/visite"/> 
                </table>
            </body>
        </html>
    </xsl:template>
    
    <!-- Template pour l'affiche des informations
    des visites du patient
    -->
    
    <xsl:template match="visite">
        <tr>
            <td> 
                <xsl:value-of select="@date"/>
            </td>
            <td> 
                <xsl:value-of select="acte/text()"/>
            </td>
            <td> 
                <xsl:value-of select="intervenant/nom/text()"/>
                <xsl:text> </xsl:text>            
                <xsl:value-of select="intervenant/prénom/text()"/>
            </td>
        </tr>
    </xsl:template>

</xsl:stylesheet>
