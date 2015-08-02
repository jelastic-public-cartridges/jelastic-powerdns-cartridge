#!/bin/bash

source /etc/jelastic/environment

function _setPassword() {
        mysqlpasswd=`cat /etc/powerdns/pdns.conf|grep gmysql-password=|sed 's/gmysql-password=//g'`;
        passmd5=`echo -n ${J_OPENSHIFT_APP_ADM_PASSWORD} | md5sum | awk '{ print $1 }'`;
        ID=`mysql -u root -p${mysqlpasswd} powerdns -Bse "select id from users  where username='admin'" 2>/dev/null`
	
	if [ -z "$ID" ]	
	then
		mysql -u root -p${mysqlpasswd} powerdns -Bse "INSERT INTO users (username, password, fullname, email, description, perm_templ, active) VALUES ('admin','$passmd5','Administrator','admin@example.net','Administrator with full rights.',1,1);" 2>/dev/null
	else
		mysql -u root -p${mysqlpasswd} powerdns -Bse "UPDATE users SET password='$passmd5' WHERE username='admin';" 2>/dev/null
	fi
        
        service httpd restart > /dev/null 2>&1;
        unset mysqlpasswd;
        unset passmd5;
}
