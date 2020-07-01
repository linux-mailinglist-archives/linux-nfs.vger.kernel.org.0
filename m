Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179D72112B1
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2020 20:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732888AbgGAS2O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Jul 2020 14:28:14 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:42005 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732917AbgGAS2M (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Jul 2020 14:28:12 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jqhSr-0007YQ-Eu
        for linux-nfs@vger.kernel.org; Wed, 01 Jul 2020 13:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=TvI3qznYTWACEEDDBRWY1FRT5HMml3Mq8UfkmcasubA=; b=o9WC+j0kf4niADvBZFmH3d6VtA
        Wh8XnxVBc6lp3qbsIoxITgE/0uJm5HEYFST7BFN+SMHM3x0cWvUdXXwsBYxyalPOQDMlMLoKKe0yK
        cBRmvGZd5eGQz9VA3G/kciGvWEXzlB53SKnTiYUWmHpWYgzPl5tEexAZn/vacbYnWva56OstNWFwF
        x880UyQoJKDd1KlyPSRpgupzGqPwy2lb/Fbl0XYDtUwqAdTVewNTmttXEksjdaCoqu/6Y/fSOslNF
        y6hZnvMEYDMf4oKHGZm5MqbiUdS321xy9D9hADQzRQ4XngzgkUDO7cLay4+6UWupo0iNjGR8oEEYh
        YQP7ERpg==;
Received: from [174.119.114.224] (port=43594 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jqhSr-0003Oc-8f
        for linux-nfs@vger.kernel.org; Wed, 01 Jul 2020 14:28:09 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 07/10] gssd: Lookup local hostname when srchost is '*'
Date:   Wed,  1 Jul 2020 14:27:58 -0400
Message-Id: <20200701182803.14947-8-nazard@nazar.ca>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701182803.14947-1-nazard@nazar.ca>
References: <20200701182803.14947-1-nazard@nazar.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Get-Message-Sender-Via: nyc006.hawkhost.com: authenticated_id: nazard@nazar.ca
X-Authenticated-Sender: nyc006.hawkhost.com: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: 172.96.186.142
Authentication-Results: arandomserver.com; auth=pass smtp.auth=172.96.186.142@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.000398538624751)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0f6LF1GdvkEexklpcFpSF5apSDasLI4SayDByyq9LIhV/191HuqCKv7D
 hDxVNAklOkTNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dIXH0xmKZzAodnlk3/LoR8Asl7H6aAPMkVWPpyCe5BmaHXpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQwzEEJbreAQRsbSZZ9fXoUEifL76GD10kuo3nOZaoX+gsjENmEszkjZCjfYHwrdv
 NOzx52pqgFKULzmTh7lC+C1OB0fQQI8VICRbS6zGNgmk2+y1r/Jt2+QI0NYgZu+YDGDmnroh/8hH
 WR/Etfk4HCQTo4dLz8XEDoyijq2CEGKcGplHcpVCCoX989hgB8R+yHz6Wz8d/Pp/n7kUT3MNKWyV
 mI6ol8ojWV/XK6LQktrhHWdMu4xDs/1OoE0qi8LnaH9nMre3YEbkuALmW8gN9RXH3DI0NOgo6/Ab
 vYB8YDlEEBksfbu9yLQMc7lcHkHFV/djzQ6YC7Heg3Xf7O1TOd4Lp6/mezP3/ta7RoBl7TSj8Cd1
 02D1/PxWBdanhqFXVM7CC2z6Dgs2SNe1BxOjU9idGQ/PRvBBIJ85eo1vZMenZjEa/sNl+vcoDGoY
 k0DAXQsuA+ZOE6ZCLBhP3Kw7GhP6DxWSEoQUnaVSVuR240Ewmn4rjkt/ing/Kst6lT+FgU1vUJm2
 lwcjBA1nf30dydyo/g58MkufxisELuuE3bZK19QhM8um7L9VndMW7hyljAQWfxYdU0gXE07BZ9Ya
 Ke+gc5LamkkGaPkiMxmyjA0L/Ub/yrYgxwwQmd72Iri+RjEvuGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently when we receive a '*' srchost, we scan our keytab for a matching
host but of course none match. We then fall back to scanning for any
service/realm match and eventually find our hostname. Let's lookup our
hostname instead and quickly find our specific match.

Signed-off-by: Doug Nazar <nazard@nazar.ca>
---
 utils/gssd/krb5_util.c | 52 ++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index 7908c10f..560e4a87 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -757,6 +757,7 @@ gssd_search_krb5_keytab(krb5_context context, krb5_keytab kt,
 		goto out;
 	}
 
+	printerr(4, "Scanning keytab for %s/*@%s\n", service, realm);
 	while ((code = krb5_kt_next_entry(context, kt, kte, &cursor)) == 0) {
 		if ((code = krb5_unparse_name(context, kte->principal,
 					      &pname))) {
@@ -853,43 +854,44 @@ find_keytab_entry(krb5_context context, krb5_keytab kt,
 		goto out;
 
 	/* Get full local hostname */
-	if (srchost) {
+	if (srchost && strcmp(srchost, "*") != 0) {
 		strcpy(myhostname, srchost);
-	} else if (gethostname(myhostname, sizeof(myhostname)) == -1) {
-		retval = errno;
-		k5err = gssd_k5_err_msg(context, retval);
-		printerr(1, "%s while getting local hostname\n", k5err);
-		goto out;
+	        strcpy(myhostad, myhostname);
+	} else {
+		/* Borrow myhostad for gethostname(), we need it later anyways */
+		if (gethostname(myhostad, sizeof(myhostad)-1) == -1) {
+			retval = errno;
+			k5err = gssd_k5_err_msg(context, retval);
+			printerr(1, "%s while getting local hostname\n", k5err);
+			goto out;
+		}
+		retval = get_full_hostname(myhostad, myhostname, sizeof(myhostname));
+		if (retval) {
+			/* Don't use myhostname */
+			myhostname[0] = 0;
+		}
 	}
 
 	/* Compute the active directory machine name HOST$ */
-	krb5_appdefault_string(context, "nfs", NULL, "ad_principal_name", 
+	krb5_appdefault_string(context, "nfs", NULL, "ad_principal_name",
 		notsetstr, &adhostoverride);
 	if (strcmp(adhostoverride, notsetstr) != 0) {
-	        printerr (1, 
-				"AD host string overridden with \"%s\" from appdefaults\n", 
+		printerr (1,
+				"AD host string overridden with \"%s\" from appdefaults\n",
 				adhostoverride);
-	        /* No overflow: Windows cannot handle strings longer than 19 chars */
-	        strcpy(myhostad, adhostoverride);
+		/* No overflow: Windows cannot handle strings longer than 19 chars */
+		strcpy(myhostad, adhostoverride);
 	} else {
-	        strcpy(myhostad, myhostname);
-	        for (i = 0; myhostad[i] != 0; ++i) {
-	          if (myhostad[i] == '.') break;
-	        }
-	        myhostad[i] = '$';
-	        myhostad[i+1] = 0;
+		/* In this case, it's been pre-filled above */
+		for (i = 0; myhostad[i] != 0; ++i) {
+			if (myhostad[i] == '.') break;
+		}
+		myhostad[i] = '$';
+		myhostad[i+1] = 0;
 	}
 	if (adhostoverride)
 		krb5_free_string(context, adhostoverride);
 
-	if (!srchost) {
-		retval = get_full_hostname(myhostname, myhostname, sizeof(myhostname));
-		if (retval) {
-			/* Don't use myhostname */
-			myhostname[0] = 0;
-		}
-	}
-
 	code = krb5_get_default_realm(context, &default_realm);
 	if (code) {
 		retval = code;
-- 
2.26.2

