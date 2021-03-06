<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs xd" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> May 21, 2016</xd:p>
            <xd:p><xd:b>Author:</xd:b> Timothy Hinchcliffe</xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>
    <xsl:output method="html" omit-xml-declaration="yes"/>
    <xsl:param name="debug" select="false()"/>
    <xsl:template name="axisname">
        <xsl:param name="device"/>
        <xsl:param name="key"/>
        <xsl:variable name="rawaxis" select="replace(replace($key, 'Axis$', ''), '^.*_', '')"/>
        <xsl:choose>
            <xsl:when test="$device = 'LogitechG940Joystick' and $rawaxis = 'U'">
                <xsl:text>Mini Joy Y Axis</xsl:text>
            </xsl:when>
            <xsl:when test="$device = 'LogitechG940Joystick' and $rawaxis = 'V'">
                <xsl:text>Mini Joy X Axis</xsl:text>
            </xsl:when>
            <xsl:when test="$device = 'LogitechG940Joystick' and $rawaxis = 'RY'">
                <xsl:text>Trim 3</xsl:text>
            </xsl:when>
            <xsl:when test="$device = 'LogitechG940Throttle' and $rawaxis = 'Y'">
                <xsl:text>Left Throttle</xsl:text>
            </xsl:when>
            <xsl:when test="$device = 'LogitechG940Throttle' and $rawaxis = 'X'">
                <xsl:text>Right Throttle</xsl:text>
            </xsl:when>
            <xsl:when test="$device = 'LogitechG940Pedals' and $rawaxis = 'RZ'">
                <xsl:text>Rudder</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat($rawaxis, ' Axis')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="displaykey">
        <xsl:param name="key" select="@Key"/>
        <xsl:param name="device" select="@Device"/>
        <xsl:variable name="isaxis" select="ends-with($key, 'Axis')"/>
        <xsl:choose>
            <!-- NOTE: Order *IS* significant here! -->
            <xsl:when test="$device = '1267A001' and $key = 'Joy_6'">
                <xsl:text>Throttle Left Toggle Switch</xsl:text>
            </xsl:when>
            <xsl:when test="$device = '1267A001' and $key = 'Joy_9'">
                <xsl:text>Throttle Right Toggle Switch</xsl:text>
            </xsl:when>
            <xsl:when test="$device = '06A305D2' and starts-with($key, 'Joy_POV')">
                <xsl:text>POV </xsl:text>
                <xsl:value-of select="substring($key, 9)"/>
            </xsl:when>
            <xsl:when test="$device = '06A305D2'">
                <xsl:text>R</xsl:text>
                <xsl:value-of select="1 + floor((number(substring($key, 5)) - 1) div 7)"/>
                <xsl:text>C</xsl:text>
                <xsl:value-of select="1 + ((number(substring($key, 5)) - 1) mod 7)"/>
            </xsl:when>
            <xsl:when test="$device = 'LogitechG940Joystick' and $key = 'Joy_1'">
                <xsl:text>Trigger (initial)</xsl:text>
            </xsl:when>
            <xsl:when test="$device = 'LogitechG940Joystick' and $key = 'Joy_9'">
                <xsl:text>Trigger (full)</xsl:text>
            </xsl:when>
            <xsl:when test="$device = 'LogitechG940Joystick' and $key = 'Joy_2'">
                <xsl:text>Fire</xsl:text>
            </xsl:when>
            <xsl:when test="$device = 'LogitechG940Joystick' and $key = 'Joy_8'">
                <xsl:text>Mini Joy Button</xsl:text>
            </xsl:when>
            <xsl:when test="$device = 'LogitechG940Throttle' and starts-with($key, 'Joy_POV1')">
                <xsl:text>Lower POV </xsl:text>
                <xsl:value-of select="substring($key, 9)"/>
            </xsl:when>
            <xsl:when test="$device = 'LogitechG940Throttle' and starts-with($key, 'Joy_POV2')">
                <xsl:text>Upper POV </xsl:text>
                <xsl:value-of select="substring($key, 9)"/>
            </xsl:when>
            <xsl:when test="starts-with($key, 'Joy_') and $isaxis">
                <xsl:call-template name="axisname">
                    <xsl:with-param name="device" select="$device"/>
                    <xsl:with-param name="key" select="$key"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="starts-with($key, 'Joy_POV')">
                <xsl:value-of select="substring($key, 5)"/>
            </xsl:when>
            <xsl:when test="$device = 'LogitechG940Joystick' and starts-with($key, 'Joy_')">
                <xsl:text>S</xsl:text>
                <xsl:value-of select="number(substring($key, 5)) - 2"/>
            </xsl:when>
            <xsl:when
                test="$device = 'LogitechG940Throttle' and starts-with($key, 'Joy_') and number(substring($key, 5)) &lt;= 4">
                <xsl:text>T</xsl:text>
                <xsl:value-of select="substring($key, 5)"/>
            </xsl:when>
            <xsl:when test="$device = 'LogitechG940Throttle' and starts-with($key, 'Joy_')">
                <xsl:text>P</xsl:text>
                <xsl:value-of select="number(substring($key, 5)) - 4"/>
            </xsl:when>
            <xsl:when test="starts-with($key, 'Joy_')">
                <xsl:text xml:space="preserve">Button </xsl:text>
                <xsl:value-of select="substring($key, 5)"/>
            </xsl:when>
            <xsl:when test="starts-with($key, 'Mouse_')">
                <xsl:text xml:space="preserve">Button </xsl:text>
                <xsl:value-of select="substring($key, 7)"/>
            </xsl:when>
            <xsl:when test="starts-with($key, 'Key_Numpad_')">
                <xsl:text>Numpad </xsl:text>
                <xsl:value-of select="substring($key, 12)"/>
            </xsl:when>
            <xsl:when test="starts-with($key, 'Key_')">
                <xsl:value-of select="substring($key, 5)"/>
            </xsl:when>
            <xsl:when test="starts-with($key, 'Pos_Joy_') and $isaxis">
                <xsl:text xml:space="preserve">Increase </xsl:text>
                <xsl:call-template name="axisname">
                    <xsl:with-param name="device" select="$device"/>
                    <xsl:with-param name="key" select="$key"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="starts-with($key, 'Neg_Joy_') and $isaxis">
                <xsl:text xml:space="preserve">Decrease </xsl:text>
                <xsl:call-template name="axisname">
                    <xsl:with-param name="device" select="$device"/>
                    <xsl:with-param name="key" select="$key"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$key"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="devicekeys">
        <xsl:param name="top"/>
        <xsl:param name="device"/>
        <xsl:param name="display">
            <xsl:call-template name="displaydevice">
                <xsl:with-param name="devicename" select="$device"/>
            </xsl:call-template>
        </xsl:param>
        <h3>
            <xsl:value-of select="$display"/>
        </h3>
        <table border="1">
            <xsl:for-each select="distinct-values($top/Root/*/*[@Device = $device]/@Key)">
                <xsl:sort select="string-length(.)"/>
                <!-- A crappy way of doing numerical sort. -->
                <xsl:sort select="."/>
                <tr>
                    <td>
                        <xsl:call-template name="displaykey">
                            <xsl:with-param name="key" select="."/>
                            <xsl:with-param name="device" select="$device"/>
                        </xsl:call-template>
                    </td>
                    <xsl:variable name="key" select="."/>
                    <xsl:for-each select="$top/Root/*[*[@Device = $device and @Key = $key]]">
                        <xsl:sort select="name()"/>
                        <td>
                            <xsl:if test="*[@Device = $device and @Key = $key]/Modifier">
                                <xsl:text>(</xsl:text>
                                <xsl:for-each select="*[@Device = $device and @Key = $key]/Modifier">
                                    <xsl:text> + </xsl:text>
                                    <xsl:if test="../@Device != @Device">
                                        <xsl:call-template name="displaydevice">
                                            <xsl:with-param name="devicename" select="@Device"/>
                                        </xsl:call-template>
                                        <xsl:text>:</xsl:text>
                                    </xsl:if>
                                    <xsl:call-template name="displaykey"/>
                                </xsl:for-each>
                                <xsl:text xml:space="preserve">) </xsl:text>
                            </xsl:if>
                            <xsl:call-template name="displayaction"/>
                        </td>
                    </xsl:for-each>
                </tr>
            </xsl:for-each>
            <xsl:if test="$device = 'Keyboard'">
                <!-- Remind me what my macro keys do: -->
                <tr>
                    <td>G1</td>
                    <td>Power: Engines (SW)</td>
                </tr>
                <tr>
                    <td>G2</td>
                    <td>Power: Weapons (SE)</td>
                </tr>
                <tr>
                    <td>G3</td>
                    <td>Power: Weapons (E)</td>
                </tr>
                <tr>
                    <td>G7</td>
                    <td>Power: Weapons (S)</td>
                </tr>
                <tr>
                    <td>G8</td>
                    <td>Power: System (E)</td>
                </tr>
                <tr>
                    <td>G9</td>
                    <td>Power: System (W)</td>
                </tr>
            </xsl:if>
        </table>
    </xsl:template>
    <xsl:template name="sortdevice">
        <!-- Use to alter device sort order. !! Each result must be composed of exactly 1 element !! -->
        <xsl:choose>
            <xsl:when test=". = '1267A001'">
                <xsl:text>AAA-Gamepad</xsl:text>
            </xsl:when>
            <xsl:when test=". = 'Mouse'">
                <xsl:text>BBB-Mouse</xsl:text>
            </xsl:when>
            <xsl:when test="ends-with(., 'Pedals')">
                <xsl:text>CCC-Pedals</xsl:text>
            </xsl:when>
            <xsl:when test="ends-with(., 'Joystick')">
                <xsl:text>DDD-Joystick</xsl:text>
            </xsl:when>
            <xsl:when test=". = '06A305D2'">
                <xsl:text>EEE-P8000</xsl:text>
            </xsl:when>
            <xsl:when test="ends-with(., 'Throttle')">
                <xsl:text>FFF-Throttle</xsl:text>
            </xsl:when>
            <xsl:when test=". = 'Keyboard'">
                <xsl:text>000-Keyboard</xsl:text>
            </xsl:when>
            <xsl:when test=". = '{NoDevice}'">
                <xsl:text>Unbound</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="displaydevice">
        <xsl:param name="devicename" select="."/>
        <xsl:choose>
            <xsl:when test="$devicename = '06A305D2'">
                <xsl:text>P8000</xsl:text>
            </xsl:when>
            <xsl:when test="$devicename = '1267A001'">
                <xsl:text>Gamepad</xsl:text>
            </xsl:when>
            <xsl:when test="$devicename = '{NoDevice}'">
                <xsl:text>Unbound</xsl:text>
            </xsl:when>
            <xsl:when test="starts-with($devicename, 'LogitechG940')">
                <xsl:text>G940 </xsl:text>
                <xsl:value-of select="substring($devicename, 13)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$devicename"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="displayaction">
        <xsl:param name="action" select="."/>
        <xsl:variable name="actionname" select="$action/name()"/>
        <xsl:choose>
            <xsl:when test="starts-with($actionname, 'TargetWingman')">
                <xsl:text>Target Wingman </xsl:text>
                <xsl:value-of select="number(substring($actionname, 14)) + 1"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$actionname"/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test="$action/ToggleOn/@Value = '1'">
                <b>
                    <xsl:text xml:space="preserve"> (toggle)</xsl:text>
                </b>
            </xsl:when>
            <xsl:when test="$action/ToggleOn/@Value != '1'">
                <b>
                    <xsl:text xml:space="preserve"> (hold)</xsl:text>
                </b>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="device">
        <xsl:param name="top"/>
        <xsl:param name="device"/>
        <xsl:param name="display">
            <xsl:call-template name="displaydevice">
                <xsl:with-param name="devicename" select="$device"/>
            </xsl:call-template>
        </xsl:param>
        <h3>
            <xsl:value-of select="$display"/>
        </h3>
        <table border="1">
            <xsl:for-each select="$top/Root/*/*[@Device = $device]/..">
                <xsl:sort select="name()"/>
                <tr>
                    <td>
                        <xsl:call-template name="displayaction"/>
                    </td>
                    <xsl:for-each select="*[@Key and @Device = $device]">
                        <td>
                            <xsl:for-each select="Modifier">
                                <xsl:if test="../@Device != @Device">
                                    <xsl:call-template name="displaydevice">
                                        <xsl:with-param name="devicename" select="@Device"/>
                                    </xsl:call-template>
                                    <xsl:text>:</xsl:text>
                                </xsl:if>
                                <xsl:call-template name="displaykey"/>
                                <xsl:text> + </xsl:text>
                            </xsl:for-each>
                            <xsl:call-template name="displaykey"/>
                            <xsl:if test="../Inverted/@Value = '1'">
                                <xsl:text xml:space="preserve"> (inverted)</xsl:text>
                            </xsl:if>
                        </td>
                    </xsl:for-each>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
    <xsl:template match="/">
        <html>
            <head>
                <title>ED Controls</title>
                <style>
                    <xsl:text xml:space="preserve">
                    fieldset {
                        display: block;
                        min-width: -webkit-min-content;
                        border: none;
                    }
                    fieldset fieldset {
                        display: inline;
                        position: relative;
                        border: 1px solid black;
                        padding: 3px;
                        margin: 3px;
                    }
                </xsl:text>
                </style>
            </head>
            <body>
                <h1>ED Controls</h1>
                <xsl:variable name="top" select="."/>
                <ol>
                    <li>
                        <a href="#da">By Device, by Action</a>
                    </li>
                    <li>
                        <a href="#dk">By Device, by Key</a>
                    </li>
                    <li>
                        <a href="#unbound">Unbound Actions</a>
                    </li>
                    <xsl:if test="$debug">
                        <li>
                            <a href="#debug">Debug</a>
                        </li>
                    </xsl:if>
                </ol>
                <hr/>
                <h2>By Device, by Action</h2>
                <a name="da"/>
                <fieldset>
                    <xsl:for-each
                        select="distinct-values(//*[@Device][@Device != '{NoDevice}']/@Device)">
                        <xsl:sort>
                            <xsl:call-template name="sortdevice"/>
                        </xsl:sort>
                        <fieldset>
                            <xsl:if test=". = 'Keyboard'">
                                <xsl:attribute name="style">
                                    <xsl:text>float:right</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:call-template name="device">
                                <xsl:with-param name="top" select="$top"/>
                                <xsl:with-param name="device" select="."/>
                            </xsl:call-template>
                        </fieldset>
                    </xsl:for-each>
                </fieldset>
                <hr/>
                <h2>By Device, by Key</h2>
                <a name="dk"/>
                <fieldset>
                    <xsl:for-each
                        select="distinct-values(//*[@Device][@Device != '{NoDevice}']/@Device)">
                        <xsl:sort>
                            <xsl:call-template name="sortdevice"/>
                        </xsl:sort>
                        <fieldset>
                            <xsl:if test=". = 'Keyboard'">
                                <xsl:attribute name="style">
                                    <xsl:text>float:right</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:call-template name="devicekeys">
                                <xsl:with-param name="top" select="$top"/>
                                <xsl:with-param name="device" select="."/>
                            </xsl:call-template>
                        </fieldset>
                    </xsl:for-each>
                </fieldset>
                <hr/>
                <a name="unbound"/>
                <h2>
                    <xsl:text>Unbound</xsl:text>
                </h2>
                <fieldset>
                    <xsl:for-each select="/Root/*/*[@Device = '{NoDevice}']/..">
                        <xsl:sort select="name()"/>
                        <xsl:if test="not(*/@Device != '{NoDevice}')">
                            <fieldset>
                                <xsl:value-of select="name()"/>
                                <xsl:if test="Deadzone">
                                    <xsl:text xml:space="preserve"> (axis)</xsl:text>
                                </xsl:if>
                                <xsl:if test="ToggleOn/@Value = '1'">
                                    <span
                                        title="You can select between toggle and hold, current is toggle"
                                        > (togglable)</span>
                                </xsl:if>
                                <xsl:if test="ToggleOn/@Value != '1'">
                                    <span
                                        title="You can select between toggle and hold, current is toggle"
                                        > (holdable)</span>
                                </xsl:if>
                            </fieldset>
                        </xsl:if>
                    </xsl:for-each>
                </fieldset>

                <hr/>
                <xsl:if test="$debug">
                    <a name="debug"/>
                    <h2>Debug</h2>
                    <fieldset>
                        <xsl:for-each select="distinct-values(/Root/*/*/name())">
                            <xsl:sort select="."/>
                            <fieldset>
                                <xsl:value-of select="."/>
                            </fieldset>
                        </xsl:for-each>
                    </fieldset>
                    <hr/>
                </xsl:if>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
