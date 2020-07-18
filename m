Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9249C224A2F
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Jul 2020 11:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgGRJYz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Jul 2020 05:24:55 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:36099 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726507AbgGRJYy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Jul 2020 05:24:54 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jwj5N-0000R7-JF
        for linux-nfs@vger.kernel.org; Sat, 18 Jul 2020 04:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=H1/Nr7B6KAwvVE82vY20YyfG5n6cHzrNsZsapRq89Sc=; b=LrnLzgXyWD2zg2KnpJYjyCoetq
        7vtGOI8OAv6YTl3g6Hg3CAF8d16wRtxjge5grbGbnwoBBEJYxv2/+THD6wVlbfYDa5dCrlfxFZcxa
        KxiSd/Sq9j41Tn2G8NgKpWdXoRnwWiwmWUlQBgpZTlddkXIw/LAvj8kNts0VZTpz2YMxEdxEJolRN
        PIZIWJb+drLU35WsU/O2s7xZH6rwfH94iiT3sDqSkmtMEgVKEpLCN7fa0Ai8SX1WpdM+4hHikedEP
        9IY7dBi855X7Q51PG+O54pOTVq4eYKc8QdwDu2CmBUIINgo5BwJAEWXeGzDyMwxOYmzilHuX8LUtQ
        qCT//FPA==;
Received: from [174.119.114.224] (port=53842 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jwj5N-0001He-EC
        for linux-nfs@vger.kernel.org; Sat, 18 Jul 2020 05:24:49 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 03/11] gssd: Fix handling of failed allocations
Date:   Sat, 18 Jul 2020 05:24:13 -0400
Message-Id: <20200718092421.31691-4-nazard@nazar.ca>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.03)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0ZZlDYW4q2llG44Qh0NJtYKpSDasLI4SayDByyq9LIhV2NlXmWfGu0OA
 PmVES5coAETNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dJ4apnoCbgR4h+LpMWlA2LjYs0odn9a1rBN2YckUdzhMnXpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQ9clsf95ERnfa5/3utVu63cGgIqsnjgPIxt+QJb5OikLV0VRXawyICi9P2LaegYD
 7MEavzt+PYIWFngwZuyqjCaZSjmmVb1jzWCjpHhh1WjZqXWvTtyZt5+E2rHRTxiOPQKf33qQtTYr
 DPixEr4D2aetI4g+l6rCWbY0MZcgnbHs5dmPTEEmx4/N3lqiWWXcjbsCnerI87CybAKXp7fccSM7
 xlVKx55BxrXNwY84BHrW9HDhl4gBqApdFfF/te8FXfRnzQu6jFSVK9YDcVmQAY2napQ1VBeZGBjd
 4wKnJrvdiwQzKw+6v3CaIMG6s7LqJPXlxUTbP0xEZy5p9dvo9LFm4eDGPWQjiHziZaTK5a5h/fs6
 iE/7cNj+QdmuDJk1ui2KYdMyfcbD2ceGUyX2OCD5d9Mpny2MqlrXcMQyNtV/a69YW9GH6uP7jsWP
 FubLd8OpyKA69LF1Ge2GaGfxmfr6K2lXCppCFhOH1qLPVvOyhENX6cHY1RZ9qv4kihn2llwcIfe9
 qSdMLqKquuUrXWpOB0fQQI8VICRbS6zGNgmkrLchyjwyJsS12kHj54zW1GIRK0UT0GXzK7XVSbOa
 O4t6datJIW5RtosbtmTCpMB/
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Doug Nazar <nazard@nazar.ca>
---
 utils/gssd/gss_names.c | 6 ++++--
 utils/gssd/krb5_util.c | 8 ++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/utils/gssd/gss_names.c b/utils/gssd/gss_names.c
index 2a7f3a13..982b96f4 100644
--- a/utils/gssd/gss_names.c
+++ b/utils/gssd/gss_names.c
@@ -110,10 +110,12 @@ get_hostbased_client_name(gss_name_t client_name, gss_OID mech,
 	/* For Kerberos, transform the NT_KRB5_PRINCIPAL name to
 	 * an NT_HOSTBASED_SERVICE name */
 	if (g_OID_equal(&krb5oid, mech)) {
-		if (get_krb5_hostbased_name(&name, &cname) == 0)
-			*hostbased_name = cname;
+		if (get_krb5_hostbased_name(&name, &cname) != 0)
+			goto out_rel_buf;
+		*hostbased_name = cname;
 	} else {
 		printerr(1, "WARNING: unknown/unsupport mech OID\n");
+		goto out_rel_buf;
 	}
 
 	res = 0;
diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index 34c81daa..1d7b30c6 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -875,10 +875,10 @@ find_keytab_entry(krb5_context context, krb5_keytab kt,
 	/* Compute the active directory machine name HOST$ */
 	krb5_appdefault_string(context, "nfs", NULL, "ad_principal_name",
 		notsetstr, &adhostoverride);
-	if (strcmp(adhostoverride, notsetstr) != 0) {
-		printerr (1,
-				"AD host string overridden with \"%s\" from appdefaults\n",
-				adhostoverride);
+	if (adhostoverride && strcmp(adhostoverride, notsetstr) != 0) {
+		printerr(1,
+			 "AD host string overridden with \"%s\" from appdefaults\n",
+			 adhostoverride);
 		/* No overflow: Windows cannot handle strings longer than 19 chars */
 		strcpy(myhostad, adhostoverride);
 	} else {
-- 
2.26.2

