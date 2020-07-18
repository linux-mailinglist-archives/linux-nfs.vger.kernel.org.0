Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE7A224A33
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Jul 2020 11:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgGRJY5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Jul 2020 05:24:57 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:36171 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726559AbgGRJY4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Jul 2020 05:24:56 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jwj5O-0000SX-Ip
        for linux-nfs@vger.kernel.org; Sat, 18 Jul 2020 04:24:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=oZ4nVdTZ4HAuL0AY+koCbqG3ZP6aLbgfD/cASysB+VY=; b=Q5DQ6lMMmqcCZlf2mxLhYJb0vY
        ltRgcGu+v7r+E14Lu6Y4UHE0rpjjXl6UHRCqYVNkx0tHm+OPbPgdnrpgAFi8/dTv3vu3k5+12mngr
        aYEl5YYx+5XjmnWx6ALbA3qxeBdkCcoda5pyef51RJnv/9+JiRR1Ef9eas+D4ZyRH/iaNRbyZwGwx
        ualfJMXZgHS5CBh3wO/WFgmwzJfQc3RQ+hcEF0TfAsdvygYpDJfForJKlZOX+lb2ZykuO5hRx+WKN
        kty9xnEqNjcg1Hj+avB4d8QOusDaJGlUHKXsO8059q2afFCHLgDW02daOGlkT/SAFYa+RKYj4K+wj
        jQbtzgxw==;
Received: from [174.119.114.224] (port=53842 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jwj5O-0001He-Do
        for linux-nfs@vger.kernel.org; Sat, 18 Jul 2020 05:24:50 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 09/11] nfsidmap: Add support to cleanup resources on exit
Date:   Sat, 18 Jul 2020 05:24:19 -0400
Message-Id: <20200718092421.31691-10-nazard@nazar.ca>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200718092421.31691-1-nazard@nazar.ca>
References: <20200718092421.31691-1-nazard@nazar.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Get-Message-Sender-Via: nyc006.hawkhost.com: authenticated_id: nazard@nazar.ca
X-Authenticated-Sender: nyc006.hawkhost.com: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: 172.96.186.142
Authentication-Results: arandomserver.com; auth=pass smtp.auth=172.96.186.142@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00658253320716)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0ZZlDYW4q2llG44Qh0NJtYKpSDasLI4SayDByyq9LIhVL1A1W/yzBA+A
 XlxHAxqQb0TNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dJ0umIx1tarOSRvONkpRH/f8GzpdKrT+RIHw0XUg4Z8DnXpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQwzEEJbreAQRsbSZZ9fXoUEifL76GD10kuo3nOZaoX+gsjENmEszkjZCjfYHwrdv
 NOzx52pqgFKULzmTh7lC+C1OB0fQQI8VICRbS6zGNgmk2+y1r/Jt2+QI0NYgZu+YDGDmnroh/8hH
 WR/Etfk4HCQTo4dLz8XEDoyijq2CEGKcGplHcpVCCoX989hgB8R+yHz6Wz8d/Pp/n7kUT3MNKWyV
 mI6ol8ojWV/XK6LQktrhuhYMGNLNEaAwHVitdY03xn9nMre3YEbkuALmW8gN9RXH3DI0NOgo6/Ab
 vYB8YDlEEBksfbu9yLQMc7lcHkHFV/djzQ6YC7Heg3Xf7O1TOd4Lp6/mezP3/ta7RoBl7TSj8Cd1
 02D1/PxWBdanhqFXVNO0eLTyIuJf+IqbzABHTTexKCV0O7/1pFcV4j/2J1bGZjEa/sNl+vcoDGoY
 k0DAXQsuA+ZOE6ZCLBhP3Kw7GhP6DxWSEoQUnaVSVuR240Ewmn4rjkt/ing/Kst6lT+FgU1vUJm2
 lwcjBA1nf30dydyo/g58MkufxisELuuE3bZK19QhM8um7L9VndMW7hyljAQWfxYdU0gXE07BZ9Ya
 Ke+gc5LamkkGaPkiMxmyjA0L/Ub/yrYgxwwQmd72Iri+RjEvuGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Doug Nazar <nazard@nazar.ca>
---
 support/nfsidmap/libnfsidmap.c      | 13 +++++++++++++
 support/nfsidmap/nfsidmap.h         |  1 +
 support/nfsidmap/nfsidmap_common.c  | 11 ++++++++++-
 support/nfsidmap/nfsidmap_private.h |  1 +
 support/nfsidmap/nss.c              |  8 ++++++++
 5 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/support/nfsidmap/libnfsidmap.c b/support/nfsidmap/libnfsidmap.c
index bce448cf..6b5647d2 100644
--- a/support/nfsidmap/libnfsidmap.c
+++ b/support/nfsidmap/libnfsidmap.c
@@ -496,6 +496,19 @@ out:
 	return ret ? -ENOENT: 0;
 }
 
+void nfs4_term_name_mapping(void)
+{
+	if (nfs4_plugins)
+		unload_plugins(nfs4_plugins);
+	if (gss_plugins)
+		unload_plugins(gss_plugins);
+
+	nfs4_plugins = gss_plugins = NULL;
+
+	free_local_realms();
+	conf_cleanup();
+}
+
 int
 nfs4_get_default_domain(char *UNUSED(server), char *domain, size_t len)
 {
diff --git a/support/nfsidmap/nfsidmap.h b/support/nfsidmap/nfsidmap.h
index 10630654..5a795684 100644
--- a/support/nfsidmap/nfsidmap.h
+++ b/support/nfsidmap/nfsidmap.h
@@ -50,6 +50,7 @@ typedef struct _extra_mapping_params {
 typedef void (*nfs4_idmap_log_function_t)(const char *, ...);
 
 int nfs4_init_name_mapping(char *conffile);
+void nfs4_term_name_mapping(void);
 int nfs4_get_default_domain(char *server, char *domain, size_t len);
 int nfs4_uid_to_name(uid_t uid, char *domain, char *name, size_t len);
 int nfs4_gid_to_name(gid_t gid, char *domain, char *name, size_t len);
diff --git a/support/nfsidmap/nfsidmap_common.c b/support/nfsidmap/nfsidmap_common.c
index f89b82ee..4d2cb14f 100644
--- a/support/nfsidmap/nfsidmap_common.c
+++ b/support/nfsidmap/nfsidmap_common.c
@@ -34,12 +34,21 @@ static char * toupper_str(char *s)
         return s;
 }
 
+static struct conf_list *local_realms = NULL;
+
+void free_local_realms(void)
+{
+	if (local_realms) {
+		conf_free_list(local_realms);
+		local_realms = NULL;
+	}
+}
+
 /* Get list of "local equivalent" realms.  Meaning the list of realms
  * where john@REALM.A is considered the same user as john@REALM.B
  * If not specified, default to upper-case of local domain name */
 struct conf_list *get_local_realms(void)
 {
-	static struct conf_list *local_realms = NULL;
 	if (local_realms) return local_realms;
 
 	local_realms = conf_get_list("General", "Local-Realms");
diff --git a/support/nfsidmap/nfsidmap_private.h b/support/nfsidmap/nfsidmap_private.h
index f1af55fa..a5cb6dda 100644
--- a/support/nfsidmap/nfsidmap_private.h
+++ b/support/nfsidmap/nfsidmap_private.h
@@ -37,6 +37,7 @@
 #include "conffile.h"
 
 struct conf_list *get_local_realms(void);
+void free_local_realms(void);
 int get_nostrip(void);
 int get_reformat_group(void);
 
diff --git a/support/nfsidmap/nss.c b/support/nfsidmap/nss.c
index 9d46499c..f8dbb94a 100644
--- a/support/nfsidmap/nss.c
+++ b/support/nfsidmap/nss.c
@@ -467,6 +467,14 @@ static int nss_plugin_init(void)
 	return 0;
 }
 
+__attribute__((destructor))
+static int nss_plugin_term(void)
+{
+	free_local_realms();
+	conf_cleanup();
+	return 0;
+}
+
 
 struct trans_func nss_trans = {
 	.name		= "nsswitch",
-- 
2.26.2

