# This is a generated example window init bat file for your project, just adjust as needed
# for your needs. It is not a complete setup but parts that give you a few
# hints on how to install a product, build a project and install it on the
# application server (java project).
#
# This same principle can be applied to any language project, the point is
# to keep it simple and clean (KISS). 
#
# Note everything is installed into the target directory, so now that we
# have an easily repeatable installation of your project, you can throw away
# the target directory at any time and run your init.sh to start over!
#
@ECHO OFF
setlocal

set PROJECT_HOME=%~dp0
set DEMO=YOUR-PRJECT-DEMO
set AUTHORS=YOUR-NAME
set PROJECT=YOUR-GIT-REPO
set PRODUCT=JBoss BPM Suite
set JBOSS_HOME=%PROJECT_HOME%target\jboss-eap-6.1
set SERVER_DIR=%JBOSS_HOME%\standalone\deployments\
set SERVER_CONF=%JBOSS_HOME%\standalone\configuration\
set SERVER_BIN=%JBOSS_HOME%\bin
set SRC_DIR=%PROJECT_HOME%installs
set SUPPORT_DIR=%PROJECT_HOME%support
set PRJ_DIR=%PROJECT_HOME%projects
set BPMS=jboss-bpms-installer-6.0.3.GA-redhat-1.jar
set VERSION=6.0.3

REM wipe screen.
cls

echo.
echo #################################################################
echo ##                                                             ##   
echo ##  Setting up the %DEMO%                          ##
echo ##                                                             ##   
echo ##                                                             ##   
echo ##     ####  ####   #   #      ### #   # ##### ##### #####     ##
echo ##     #   # #   # # # # #    #    #   #   #     #   #         ##
echo ##     ####  ####  #  #  #     ##  #   #   #     #   ###       ##
echo ##     #   # #     #     #       # #   #   #     #   #         ##
echo ##     ####  #     #     #    ###  ##### #####   #   #####     ##
echo ##                                                             ##   
echo ##                                                             ##   
echo ##  brought to you by,                                         ##   
echo ##                     %AUTHORS%           ##
echo ##                                                             ##   
echo ##  %PROJECT%##
echo ##                                                             ##   
echo #################################################################
echo.

REM make some checks first before proceeding.	
if exist %SRC_DIR%\%BPMS% (
	echo Product sources are present...
	echo.
) else (
	echo Need to download %BPMS% package from the Customer Support Portal
	echo and place it in the %SRC_DIR% directory to proceed...
	echo.
	GOTO :EOF
)

REM Move the old JBoss instance, if it exists, to the OLD position.
if exist %JBOSS_HOME% (
	echo - existing JBoss product install removed...
	echo.
	rmdir /s /q target"
)

REM Run installer.
echo Product installer running now...
echo.
call java -jar %SRC_DIR%/%BPMS% %SUPPORT_DIR%\installation-bpms -variablefile %SUPPORT_DIR%\installation-bpms.variables

if not "%ERRORLEVEL%" == "0" (
	echo Error Occurred During %PRODUCT% Installation!
	echo.
	GOTO :EOF
)


echo.
echo - setting up web services...
echo.
call mvn clean install -f %PRJ_DIR%/pom.xml
xcopy /Y /Q "%PRJ_DIR%\acme-demo-flight-service\target\acme-flight-service-1.0.war" "%SERVER_DIR%"
xcopy /Y /Q "%PRJ_DIR%\acme-demo-hotel-service\target\acme-hotel-service-1.0.war" "%SERVER_DIR%"

echo.
echo ========================================================================
echo =                                                                      =
echo =  You can now start the %PRODUCT% with:                         =
echo =                                                                      =
echo =   %SERVER_BIN%\standalone.bat                           =
echo =                                                                      =
echo =  Login into business central at:                                     =
echo =                                                                      =
echo =    http://localhost:8080/business-central  [u:erics / p:bpmsuite1!]  =
echo =                                                                      =
echo =  See README.md for general details to run the various demo cases.    =
echo =                                                                      =
echo =  %PRODUCT% %VERSION% %DEMO% Setup Complete.            =
echo =                                                                      =
echo ========================================================================
echo.

echo
