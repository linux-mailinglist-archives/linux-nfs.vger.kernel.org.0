Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03732112B3
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2020 20:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732913AbgGAS2P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Jul 2020 14:28:15 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:54843 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732857AbgGAS2M (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Jul 2020 14:28:12 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jqhSr-0007YX-L0
        for linux-nfs@vger.kernel.org; Wed, 01 Jul 2020 13:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=qw8xORloYize+TvB5UVwImrWq8pWlchk+hhNjpH8tko=; b=IBSE/ZuMdbYXLe0cUbQajTwluc
        dy540dDOjkp/XP7hhUKDLQYHmq51UHw1aTm0xkz9j0jUdI6Ci1FLw4Lpb7gezh2t88J3N7AWfxBkD
        LwefgCNvuO/EYdpEeyac4mcRoFnjvdEnrPfu4QsoVJk8rtrON6uOgsoZE/RitCFTgbDZD2Hm1NZlN
        a9bfMy9SqvB4VooLMoZA1cRGOrE8L71JmckGe0tiV16CAdOqLUB+p2/pMnZi7kOiDl9M1QdkMNgjq
        jPFYb/LHjVCPZE2L8kmLY+ycoaGqQ71HVPz2WVoql/sJKvqFWQl149gBg9TjwRMu4afikDKtbXFNH
        NmGLLmoA==;
Received: from [174.119.114.224] (port=43594 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jqhSr-0003Oc-E7
        for linux-nfs@vger.kernel.org; Wed, 01 Jul 2020 14:28:09 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 08/10] gssd: We never use the nocache param of gssd_check_if_cc_exists()
Date:   Wed,  1 Jul 2020 14:27:59 -0400
Message-Id: <20200701182803.14947-9-nazard@nazar.ca>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.02)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0f6LF1GdvkEexklpcFpSF5apSDasLI4SayDByyq9LIhV2p1hpBoZodUM
 HSEg3G9A5ETNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dIqQBwsVZwtF/e+5u63swo6Ys0odn9a1rBN2YckUdzhMnXpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQ9clsf95ERnfa5/3utVu63cGgIqsnjgPIxt+QJb5OikLV0VRXawyICi9P2LaegYD
 7MEavzt+PYIWFngwZuyqjCaZSjmmVb1jzWCjpHhh1WjZqXWvTtyZt5+E2rHRTxiOPQKf33qQtTYr
 DPixEr4D2aetI4g+l6rCWbY0MZcgnbHs5dmPTEEmx4/N3lqiWWXcjbsCnerI87CybAKXp7fccSNA
 +jWZIIHNDtJC47Gfj7TL9HDhl4gBqApdFfF/te8FXfRnzQu6jFSVK9YDcVmQAY2napQ1VBeZGBjd
 4wKnJrvdiwQzKw+6v3CaIMG6s7LqJPXlxUTbP0xEZy5p9dvo9LFm4eDGPWQjiHziZaTK5a5h3E+8
 uHRRBGJGIKxwkw+EflQrHktPby5WeLJY0zgXJz/5d9Mpny2MqlrXcMQyNtV/a69YW9GH6uP7jsWP
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
 utils/gssd/krb5_util.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index 560e4a87..e5b81823 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -165,7 +165,7 @@ static int select_krb5_ccache(const struct dirent *d);
 static int gssd_find_existing_krb5_ccache(uid_t uid, char *dirname,
 		const char **cctype, struct dirent **d);
 static int gssd_get_single_krb5_cred(krb5_context context,
-		krb5_keytab kt, struct gssd_k5_kt_princ *ple, int nocache);
+		krb5_keytab kt, struct gssd_k5_kt_princ *ple);
 static int query_krb5_ccache(const char* cred_cache, char **ret_princname,
 		char **ret_realm);
 
@@ -380,8 +380,7 @@ gssd_check_if_cc_exists(struct gssd_k5_kt_princ *ple)
 static int
 gssd_get_single_krb5_cred(krb5_context context,
 			  krb5_keytab kt,
-			  struct gssd_k5_kt_princ *ple,
-			  int nocache)
+			  struct gssd_k5_kt_princ *ple)
 {
 #ifdef HAVE_KRB5_GET_INIT_CREDS_OPT_SET_ADDRESSLESS
 	krb5_get_init_creds_opt *init_opts = NULL;
@@ -398,10 +397,11 @@ gssd_get_single_krb5_cred(krb5_context context,
 	char *cache_type;
 	char *pname = NULL;
 	char *k5err = NULL;
+	int nocache = 0;
 
 	memset(&my_creds, 0, sizeof(my_creds));
 
-	if (!nocache && !use_memcache)
+	if (!use_memcache)
 		nocache = gssd_check_if_cc_exists(ple);
 	/*
 	 * Workaround for clock skew among NFS server, NFS client and KDC
@@ -1199,7 +1199,7 @@ gssd_refresh_krb5_machine_credential_internal(char *hostname,
 			goto out_free_kt;
 		}
 	}
-	retval = gssd_get_single_krb5_cred(context, kt, ple, 0);
+	retval = gssd_get_single_krb5_cred(context, kt, ple);
 out_free_kt:
 	krb5_kt_close(context, kt);
 out_free_context:
-- 
2.26.2

