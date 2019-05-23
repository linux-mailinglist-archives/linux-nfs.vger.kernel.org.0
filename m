Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB6E28232
	for <lists+linux-nfs@lfdr.de>; Thu, 23 May 2019 18:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbfEWQKr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 May 2019 12:10:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33497 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730782AbfEWQKr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 May 2019 12:10:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id z28so3513486pfk.0
        for <linux-nfs@vger.kernel.org>; Thu, 23 May 2019 09:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ZKaMwVsPGpjBhaYm34dPuQEtJuN35DvIlygZGK6orI=;
        b=Ro52BcPUWcsq4p1EkCHtMo0Zf0MetREvVVB9pwxL1eox1Fh5P93Y92qEU+vlTJ0rzZ
         ixizK5EFKN8EIYyVaruu2jBvA97QsX1GxE2ouK1gEkyrI19DFEnkGuTk6DadS+vy/EOH
         1AiPShft+e9i/JS+aoh+hDX3e36jCMsf0zA/ojrE+Z5NmqTntl1WkH6iZHOcZfDQ+R+/
         9ajpGlWcuAuzuUUNzuW0cvsM/JIwdvhSOC3g/WOnX/ZAxlakXp61O1yudrhvfRuCU82a
         dgZ+TzieP8qS6aqgwNyafW9VqRbqNOuMcXxf4cy+NQDG2uVAu5mGoQ3Uohh6xOOKA1Ki
         8hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ZKaMwVsPGpjBhaYm34dPuQEtJuN35DvIlygZGK6orI=;
        b=kc7EYGV8ouM9+F4dPJHJAgbZgoCwnbk4p4at2VmEINCHoR2Dmht3UnUnzvDxAMWtF6
         B/SmmKBKaBd39vAayFMxLrUv0hDij8l+Zf6bH5eosIE0TuNUj2aN/s+7FPjoH1T0kb5k
         701dC6WJ14Ax1ydznRW9+25Onb8IxBcsn4ZbdLNeY1bQGBiTy+A+gs7YvNYHBHn5Cr2Y
         wFTXQ6MVDm2tbI5uFsxupVum4SOUwskrJnt/xvJozaS/sG6ozLSouspVHKygCtvCKkcb
         hNjSPzimmYo8fxysEQM1itiT7Dkcrh0RG9dUq4RT3DtfxaxcMlckAy4hQsgazc0ay096
         i4HQ==
X-Gm-Message-State: APjAAAWOMBPkvrIl/ZrfalniD+XQmKIissEBBiW1RSvRCgVof09aQLzd
        YWe78cpKxL3q18gKiychFgIR2AOT
X-Google-Smtp-Source: APXvYqydvLPfo0ddFJFM+YF+fzRGTd7m5DTquIjk/Fw/Mv47JWQ/2Eg729QbcUynXNiAgDbNt8UHBg==
X-Received: by 2002:a63:dc09:: with SMTP id s9mr58001217pgg.425.1558627846299;
        Thu, 23 May 2019 09:10:46 -0700 (PDT)
Received: from localhost.localdomain ([192.146.154.1])
        by smtp.googlemail.com with ESMTPSA id o1sm24940838pfa.66.2019.05.23.09.10.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 09:10:45 -0700 (PDT)
From:   Srikrishan Malik <srikrishanmalik@gmail.com>
Cc:     linux-nfs@vger.kernel.org,
        Srikrishan Malik <srikrishanmalik@gmail.com>
Subject: [nfs-utils:nfsidmap PATCH v2] Add LDAP_tls_reqcert tunable to idmapd.conf.
Date:   Thu, 23 May 2019 09:10:14 -0700
Message-Id: <20190523161014.60182-1-srikrishanmalik@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <0a9cbe6a-3c24-08d5-7383-f32bd8be4e09@RedHat.com>
References: <0a9cbe6a-3c24-08d5-7383-f32bd8be4e09@RedHat.com>
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
 support/nfsidmap/idmapd.conf   |  8 ++++-
 support/nfsidmap/idmapd.conf.5 | 11 ++++++-
 support/nfsidmap/umich_ldap.c  | 57 ++++++++++++++++++++++++++++------
 3 files changed, 64 insertions(+), 12 deletions(-)

diff --git a/support/nfsidmap/idmapd.conf b/support/nfsidmap/idmapd.conf
index f07286c3..b673c7d7 100644
--- a/support/nfsidmap/idmapd.conf
+++ b/support/nfsidmap/idmapd.conf
@@ -101,7 +101,13 @@ LDAP_base = dc=local,dc=domain,dc=edu
 # Set to true to enable SSL - anything else is not enabled
 #LDAP_use_ssl = false
 
-# You must specify a CA certificate location if you enable SSL
+# Controls the LDAP server certificate validation behavior
+# It can take the same values as ldap.conf(5)'s TLS_REQCERT
+# tunable
+#LDAP_tls_reqcert = "hard"
+
+# Location of CA certificate, mandatory if LDAP_tls_reqcert
+# is not set to "never"
 #LDAP_ca_cert = /etc/ldapca.cert
 
 # Objectclass mapping information
diff --git a/support/nfsidmap/idmapd.conf.5 b/support/nfsidmap/idmapd.conf.5
index 9a6457e2..61fbb613 100644
--- a/support/nfsidmap/idmapd.conf.5
+++ b/support/nfsidmap/idmapd.conf.5
@@ -195,7 +195,16 @@ Set to "true" to enable SSL communication with the LDAP server.
 Location of a trusted CA certificate used when SSL is enabled
 (Required if
 .B LDAP_use_ssl
-is true)
+is true and
+.B LDAP_tls_reqcert
+is not set to never)
+.TP
+.B LDAP_tls_reqcert
+Controls the LDAP server certificate validation behavior.
+It can take the same values as ldap.conf(5)'s
+.B TLS_REQCERT
+tunable.
+(Default: "hard")
 .TP
 .B NFSv4_person_objectclass
 The object class name for people accounts in your local LDAP schema
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

