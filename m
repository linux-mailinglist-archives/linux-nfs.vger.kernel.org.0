Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9AA1AEEB5
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Apr 2020 16:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgDRO3B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Apr 2020 10:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725903AbgDRO3B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Apr 2020 10:29:01 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E578BC061A0C
        for <linux-nfs@vger.kernel.org>; Sat, 18 Apr 2020 07:29:00 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id q17so4610245qtp.4
        for <linux-nfs@vger.kernel.org>; Sat, 18 Apr 2020 07:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kFym5NwoGvzv0LgMn+K8SW+7bdABiir8lrjN3taaEEI=;
        b=ELMHus3He30DxqYIFcMKFeymhAPbR1mObSgtmMQ93yS8/XNdQ0ElL0QSgl0vDkH3p7
         G1CoERwWNWxzy9npYsDZS0GqHvwD9yk0n1iGz7/jFmWlbLJQ12DXnDErCbTzwgdJRLfc
         M+ePTRKLOQl4xADJjAoJeWEALOdpMbx3kqS7Q7ERKvc2CG4nYniSJcNZBoAtx1XNY4XE
         1+Z+FMKv0a0v6xHiPnpINFkX5MtOuBzexoe9CDmx7Q7kz2Yt7jwKph5wshjgvfvbfNzv
         MQdRDn435eBwX+F5chVvj1VfR+IjLE6p2Y8bsqKwQ7wrdT5kFm/T/P3MWN3n3DeGBfOo
         f1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kFym5NwoGvzv0LgMn+K8SW+7bdABiir8lrjN3taaEEI=;
        b=rscMDhJ9nlEvQsSHxWitXSVkNGn8w2abFkBzkiFqg94ZeLVqz6MsDq/K6lNQX/CsiT
         uUsCI7G6JUU6DR+csE55j5J8EmiK3L7d5f9HlceGZVrih/sRE51q/0A2+q9lh+2gjGLx
         FSlPgfNLfJs5LL59TXs0rSEkeBt8e20E320iz+xiLffgM/15fawym8tkh/1VmQzxxkyq
         h38gVohWOwSUcgZHcfB1jSspZ3ZdIFwA0wu3I3bYKPLsIIbAJUB1Waobrq4MZ97haMuB
         Hsh8VTiy2x2keurQrWO/cVfD39iZLJjpnj+4EVp4iUyt4bcEGv9zcG8Dfr4onNE8dAuB
         EfEw==
X-Gm-Message-State: AGi0PuZPvMdVDNnAa5X/jLfXjfWpKYVrC8Nyi2BaEXPM+DmmcDcBQAyg
        moHTj9S+7Pd4R3bgQXeoM8hedoVx+z8=
X-Google-Smtp-Source: APiQypINdhG/bZ3hl0KQ81mieXlqGuLDzIu2QLwFuONh/KmU1UIeWAfkeg1QJkcn3UeBzZVsRYxU9Q==
X-Received: by 2002:ac8:19dd:: with SMTP id s29mr8214916qtk.164.1587220139733;
        Sat, 18 Apr 2020 07:28:59 -0700 (PDT)
Received: from localhost.localdomain ([192.146.154.244])
        by smtp.gmail.com with ESMTPSA id 195sm18106874qkd.6.2020.04.18.07.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 07:28:59 -0700 (PDT)
From:   Srikrishan Malik <srikrishanmalik@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     Srikrishan Malik <srikrishanmalik@gmail.com>
Subject: [PATCH] nfsidmap:umich_ldap: Add tunable to control action for ldap referrals.
Date:   Sat, 18 Apr 2020 07:28:56 -0700
Message-Id: <20200418142856.22896-1-srikrishanmalik@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

LDAP library follows referrals received in ldap response by default.
This commit adds a param ldap_follow_referrals for umich_schema to control
the behaviour. The default value of this tunable is 'true' i.e set to
follow referrals. This is similar to nslcd::referrals param.

Signed-off-by: Srikrishan Malik <srikrishanmalik@gmail.com>
---
 support/nfsidmap/idmapd.conf   |  3 +++
 support/nfsidmap/idmapd.conf.5 |  3 +++
 support/nfsidmap/umich_ldap.c  | 25 ++++++++++++++++++++++++-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/support/nfsidmap/idmapd.conf b/support/nfsidmap/idmapd.conf
index aeeca1bf..2a2f79a1 100644
--- a/support/nfsidmap/idmapd.conf
+++ b/support/nfsidmap/idmapd.conf
@@ -98,6 +98,9 @@ LDAP_base = dc=local,dc=domain,dc=edu
 # absolute search base for groups
 #LDAP_group_base = <LDAP_base>
 
+# Whether to follow ldap referrals
+#LDAP_follow_referrals = true
+
 # Set to true to enable SSL - anything else is not enabled
 #LDAP_use_ssl = false
 
diff --git a/support/nfsidmap/idmapd.conf.5 b/support/nfsidmap/idmapd.conf.5
index d2fd3a20..f5b18167 100644
--- a/support/nfsidmap/idmapd.conf.5
+++ b/support/nfsidmap/idmapd.conf.5
@@ -239,6 +239,9 @@ name given as
 .B LDAP_server
 (Default: "true")
 .TP
+.B LDAP_follow_referrals
+Whether or not to follow ldap referrals. (Default: "true")
+.TP
 .B LDAP_use_ssl
 Set to "true" to enable SSL communication with the LDAP server.
 (Default: "false")
diff --git a/support/nfsidmap/umich_ldap.c b/support/nfsidmap/umich_ldap.c
index d5a7731a..c475d379 100644
--- a/support/nfsidmap/umich_ldap.c
+++ b/support/nfsidmap/umich_ldap.c
@@ -115,6 +115,7 @@ struct umich_ldap_info {
 				   looking up user groups */
 	int ldap_timeout;	/* Timeout in seconds for searches
 				   by ldap_search_st */
+	int follow_referrals;	/* whether to follow ldap referrals */
 	char *sasl_mech;	/* sasl mech to be used */
 	char *sasl_realm;	/* SASL realm for SASL authentication */
 	char *sasl_authcid;	/* authentication identity to be used  */
@@ -139,6 +140,7 @@ static struct umich_ldap_info ldap_info = {
 	.tls_reqcert = LDAP_OPT_X_TLS_HARD,
 	.memberof_for_groups = 0,
 	.ldap_timeout = DEFAULT_UMICH_SEARCH_TIMEOUT,
+	.follow_referrals = 1,
 	.sasl_mech = NULL,
 	.sasl_realm = NULL,
 	.sasl_authcid = NULL,
@@ -346,6 +348,15 @@ ldap_init_and_bind(LDAP **pld,
 		ldap_set_option(ld, LDAP_OPT_SIZELIMIT, (void *)sizelimit);
 	}
 
+	lerr = ldap_set_option(ld, LDAP_OPT_REFERRALS,
+			linfo->follow_referrals ? (void *)LDAP_OPT_ON :
+						  (void *)LDAP_OPT_OFF);
+	if (lerr != LDAP_SUCCESS) {
+		IDMAP_LOG(2, ("ldap_init_and_bind: setting LDAP_OPT_REFERRALS "
+			      "failed: %s (%d)", ldap_err2string(lerr), lerr));
+		goto out;
+	}
+
 	/* Set option to to use SSL/TLS if requested */
 	if (linfo->use_ssl) {
 		int tls_type = LDAP_OPT_X_TLS_HARD;
@@ -1310,7 +1321,7 @@ out_err:
 static int
 umichldap_init(void)
 {
-	char *tssl, *canonicalize, *memberof, *cert_req;
+	char *tssl, *canonicalize, *memberof, *cert_req, *follow_referrals;
 	char missing_msg[128] = "";
 	char *server_in, *canon_name;
 
@@ -1378,6 +1389,16 @@ umichldap_init(void)
 	ldap_info.sasl_krb5_ccname = conf_get_str(LDAP_SECTION,
 						  "LDAP_sasl_krb5_ccname");
 
+	follow_referrals = conf_get_str_with_def(LDAP_SECTION,
+						 "LDAP_follow_referrals",
+						 "true");
+	if ((strcasecmp(follow_referrals, "true") == 0) ||
+	    (strcasecmp(follow_referrals, "on") == 0) ||
+	    (strcasecmp(follow_referrals, "yes") == 0))
+		ldap_info.follow_referrals = 1;
+	else
+		ldap_info.follow_referrals = 0;
+
 	/* Verify required information is supplied */
 	if (server_in == NULL || strlen(server_in) == 0)
 		strncat(missing_msg, "LDAP_server ", sizeof(missing_msg)-1);
@@ -1542,6 +1563,8 @@ umichldap_init(void)
 		      ldap_info.sasl_canonicalize));
 	IDMAP_LOG(1, ("umichldap_init: sasl_krb5_ccname: %s",
 		      ldap_info.sasl_krb5_ccname));
+	IDMAP_LOG(1, ("umichldap_init: follow_referrals: %s",
+		  ldap_info.follow_referrals ? "yes" : "no"));
 
 	IDMAP_LOG(1, ("umichldap_init: NFSv4_person_objectclass : %s",
 		  ldap_map.NFSv4_person_objcls));
-- 
2.25.1

