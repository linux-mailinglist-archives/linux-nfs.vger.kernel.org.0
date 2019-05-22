Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D50C26368
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2019 14:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbfEVMGN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 May 2019 08:06:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37123 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbfEVMGN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 May 2019 08:06:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id a23so1229866pff.4
        for <linux-nfs@vger.kernel.org>; Wed, 22 May 2019 05:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XSWG5OW2PJNKdvnFHW5pnFadq75uYdHtoB0w1Hd6pko=;
        b=S29IQnzxMG/Xvqem/m8TfH5JEnt3tam7l4m3EP6E+Jl/1JdSjKOgNRpXAmdZP2FjsA
         XZUdhHy86T/oPqV7jlal+Yef/Ag+BhGofq2aGxUFim4QyPMTk+udGs8cR0BAx8fpFSpr
         b5/pTxqpQg2keYi/tBYbEEMhjKOVhCBEmioZHbg+lcEUSMxE6GaPUuzErcul2Y5CN2DW
         Z0+MHLpdVBzqrIGrgPnR6lIzXL84S7wJU34OpwSghdGmpc71bcrC5V9Hm/c2jsM+mJ+e
         6IhzwADZDtrPKRLqsDJbrVB9EmdM8+toyvvz8TydWddC/JSF01ugzjsj/qcMIYFJOVO7
         D5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XSWG5OW2PJNKdvnFHW5pnFadq75uYdHtoB0w1Hd6pko=;
        b=kH/SMa9W7aIa47D1Zzxij+BKz13VbAUrgxvp/ekfrXFoAczytzdDUcldU5oT4pVbjV
         fV5/8UdosyzXZnbE60BI4drc65Rxu42HPiF181rrXTh3QNbMHx9jAAgvUQIorJJOqTCo
         uiYgx+/Nys1peUaNhr3wZ+PhbxWPLp0LIpGh/gaJIPK4Z8CcoGy8THG0L/SzYDhUu2FK
         MIHfGWFFg7iUXnvnjJ5PCcfzilIXrfk6q+B89gIN0ARRDZfmjYpC6JY6kKjOLlLyTl/v
         TjBMm58K4QKAH8smz/wKhnUpIsuxvacVDxbHXcOCRonHzX2d9FSE8Nx86ctygns2e5iV
         YaXg==
X-Gm-Message-State: APjAAAUvo/lMm7FTYFei5tA7hO6CWO6rMNxhqnytLiXPn7QUveKCc1m8
        gtkmPAfh5JRHVyoxBlDPCA3kYqrhom8=
X-Google-Smtp-Source: APXvYqwwhHRBZjiPN5b+esHoe7BdyxmmOU87NS1/ouufMpAb+jAnBiK5HUAUDqi0HPG5vMHp87CugA==
X-Received: by 2002:a63:ff23:: with SMTP id k35mr58921859pgi.139.1558526772344;
        Wed, 22 May 2019 05:06:12 -0700 (PDT)
Received: from localhost.localdomain ([192.146.154.1])
        by smtp.googlemail.com with ESMTPSA id f29sm59433554pfq.11.2019.05.22.05.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 05:06:11 -0700 (PDT)
From:   Srikrishan Malik <srikrishanmalik@gmail.com>
Cc:     linux-nfs@vger.kernel.org,
        Srikrishan Malik <srikrishanmalik@gmail.com>
Subject: [nfs-utils:nfsidmap PATCH] Add LDAP_tls_reqcert tunable to idmapd.conf.
Date:   Wed, 22 May 2019 05:05:26 -0700
Message-Id: <20190522120526.59335-1-srikrishanmalik@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This tunable will control the checks on server certs for a TLS session
similar to ldap.conf(5).
LDAP_ca_cert can be skipped if LDAP_tls_reqcert is set to "never"

Signed-off-by: Srikrishan Malik <srikrishanmalik@gmail.com>
---
 support/nfsidmap/umich_ldap.c | 57 +++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/support/nfsidmap/umich_ldap.c b/support/nfsidmap/umich_ldap.c
index 10d1d979..b7445c37 100644
--- a/support/nfsidmap/umich_ldap.c
+++ b/support/nfsidmap/umich_ldap.c
@@ -100,6 +100,7 @@ struct umich_ldap_info {
 	char *passwd;		/* Password to use when binding to directory */
 	int use_ssl;		/* SSL flag */
 	char *ca_cert;		/* File location of the ca_cert */
+	int tls_reqcert;	/* req and validate server cert */
 	int memberof_for_groups;/* Use 'memberof' attribute when
 				   looking up user groups */
 	int ldap_timeout;	/* Timeout in seconds for searches
@@ -118,6 +119,7 @@ static struct umich_ldap_info ldap_info = {
 	.passwd = NULL,
 	.use_ssl = 0,
 	.ca_cert = NULL,
+	.tls_reqcert = LDAP_OPT_X_TLS_HARD,
 	.memberof_for_groups = 0,
 	.ldap_timeout = DEFAULT_UMICH_SEARCH_TIMEOUT,
 };
@@ -153,7 +155,7 @@ ldap_init_and_bind(LDAP **pld,
 	LDAPAPIInfo apiinfo = {.ldapai_info_version = LDAP_API_INFO_VERSION};
 
 	snprintf(server_url, sizeof(server_url), "%s://%s:%d",
-		 (linfo->use_ssl && linfo->ca_cert) ? "ldaps" : "ldap",
+		 (linfo->use_ssl) ? "ldaps" : "ldap",
 		 linfo->server, linfo->port);
 
 	/*
@@ -208,9 +210,8 @@ ldap_init_and_bind(LDAP **pld,
 	}
 
 	/* Set option to to use SSL/TLS if requested */
-	if (linfo->use_ssl && linfo->ca_cert) {
+	if (linfo->use_ssl) {
 		int tls_type = LDAP_OPT_X_TLS_HARD;
-
 		lerr = ldap_set_option(ld, LDAP_OPT_X_TLS, &tls_type);
 		if (lerr != LDAP_SUCCESS) {
 			IDMAP_LOG(2, ("ldap_init_and_bind: setting SSL "
@@ -218,11 +219,23 @@ ldap_init_and_bind(LDAP **pld,
 				  ldap_err2string(lerr), lerr));
 			goto out;
 		}
-		lerr = ldap_set_option(NULL, LDAP_OPT_X_TLS_CACERTFILE,
-				       linfo->ca_cert);
+
+		if (linfo->ca_cert != NULL) {
+			lerr = ldap_set_option(NULL, LDAP_OPT_X_TLS_CACERTFILE,
+					       linfo->ca_cert);
+			if (lerr != LDAP_SUCCESS) {
+				IDMAP_LOG(2, ("ldap_init_and_bind: setting CA "
+					  "certificate file failed : %s (%d)",
+					  ldap_err2string(lerr), lerr));
+				goto out;
+			}
+		}
+
+		lerr = ldap_set_option(NULL, LDAP_OPT_X_TLS_REQUIRE_CERT,
+				       &linfo->tls_reqcert);
 		if (lerr != LDAP_SUCCESS) {
-			IDMAP_LOG(2, ("ldap_init_and_bind: setting CA "
-				  "certificate file failed : %s (%d)",
+			IDMAP_LOG(2, ("ldap_init_and_bind: setting "
+				      "req CA cert failed : %s(%d)",
 				  ldap_err2string(lerr), lerr));
 			goto out;
 		}
@@ -1098,7 +1111,7 @@ out_err:
 static int
 umichldap_init(void)
 {
-	char *tssl, *canonicalize, *memberof;
+	char *tssl, *canonicalize, *memberof, *cert_req;
 	char missing_msg[128] = "";
 	char *server_in, *canon_name;
 
@@ -1119,6 +1132,24 @@ umichldap_init(void)
 	else
 		ldap_info.use_ssl = 0;
 	ldap_info.ca_cert = conf_get_str(LDAP_SECTION, "LDAP_CA_CERT");
+	cert_req = conf_get_str(LDAP_SECTION, "LDAP_tls_reqcert");
+	if (cert_req != NULL) {
+		if (strcasecmp(cert_req, "hard") == 0)
+			ldap_info.tls_reqcert = LDAP_OPT_X_TLS_HARD;
+		else if (strcasecmp(cert_req, "demand") == 0)
+			ldap_info.tls_reqcert = LDAP_OPT_X_TLS_DEMAND;
+		else if (strcasecmp(cert_req, "try") == 0)
+			ldap_info.tls_reqcert = LDAP_OPT_X_TLS_TRY;
+		else if (strcasecmp(cert_req, "allow") == 0)
+			ldap_info.tls_reqcert = LDAP_OPT_X_TLS_ALLOW;
+		else if (strcasecmp(cert_req, "never") == 0)
+			ldap_info.tls_reqcert = LDAP_OPT_X_TLS_NEVER;
+		else {
+			IDMAP_LOG(0, ("umichldap_init: Invalid value(%s) for "
+				      "LDAP_tls_reqcert."));
+			goto fail;
+		}
+	}
 	/* vary the default port depending on whether they use SSL or not */
 	ldap_info.port = conf_get_num(LDAP_SECTION, "LDAP_port",
 				      (ldap_info.use_ssl) ?
@@ -1230,9 +1261,12 @@ umichldap_init(void)
 	if (ldap_info.group_tree == NULL || strlen(ldap_info.group_tree) == 0)
 		ldap_info.group_tree = ldap_info.base;
 
-	if (ldap_info.use_ssl && ldap_info.ca_cert == NULL) {
+	if (ldap_info.use_ssl &&
+	    ldap_info.tls_reqcert != LDAP_OPT_X_TLS_NEVER &&
+	    ldap_info.ca_cert == NULL) {
 		IDMAP_LOG(0, ("umichldap_init: You must specify LDAP_ca_cert "
-			  "with LDAP_use_ssl=yes"));
+			  "with LDAP_use_ssl=yes and "
+			  "LDAP_tls_reqcert not set to \"never\""));
 		goto fail;
 	}
 
@@ -1257,6 +1291,9 @@ umichldap_init(void)
 		  ldap_info.use_ssl ? "yes" : "no"));
 	IDMAP_LOG(1, ("umichldap_init: ca_cert : %s",
 		  ldap_info.ca_cert ? ldap_info.ca_cert : "<not-supplied>"));
+	IDMAP_LOG(1, ("umichldap_init: tls_reqcert : %s(%d)",
+		  cert_req ? cert_req : "<not-supplied>",
+		  ldap_info.tls_reqcert));
 	IDMAP_LOG(1, ("umichldap_init: use_memberof_for_groups : %s",
 		  ldap_info.memberof_for_groups ? "yes" : "no"));
 
-- 
2.21.0

