# see https://support.globalsign.com/customer/en/portal/articles/2121490-java-keytool---create-keystore
# https://www.sslshopper.com/article-most-common-openssl-commands.html


keytool -genkey -alias tomcat -keyalg RSA -keystore selfsigned.keystore.jks -keysize 2048
keytool -list -v -keystore .self-signed-keystore

