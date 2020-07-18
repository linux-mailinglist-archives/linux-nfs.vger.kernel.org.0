Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA65224A30
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Jul 2020 11:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgGRJYz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Jul 2020 05:24:55 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:55483 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726518AbgGRJYy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Jul 2020 05:24:54 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jwj5N-0000RI-OL
        for linux-nfs@vger.kernel.org; Sat, 18 Jul 2020 04:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=6Mbw+GJ4eU1o1G1Xs86+ETUVY9PyB13dHakdISeVpGo=; b=VZ6rziKU+K1CxQhqwIrNAOazNZ
        4qss42QHegwESMHDNVPqW9GfYoPigh8frNuYWm09Q71pXp1EQM6RtW54j5P6J7KeZWGfsiHYn+NuK
        74LxduklXe7ueP2dGQqoVoEg6LXX7Ti2QVEqMlpR2N1s/HRTRVMsBTxrviSoPh4SkigBs5jzFg2Qk
        xjoDDGkQMqslsOu4ov+nH6W22JjYYYMow8bHiR/IOe7SxBFwo8ILIMICbdwv0k7d26L31fZ1pNBlx
        H/K1ZQH3EEKBvJnmbqP7OT+pz2yzmpEn1khLkpiChF2oUG8T0HXlfwOw5lNRTDKSK7W+ngN2YD/Wj
        gJnUfOHQ==;
Received: from [174.119.114.224] (port=53842 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jwj5N-0001He-JM
        for linux-nfs@vger.kernel.org; Sat, 18 Jul 2020 05:24:49 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 04/11] gssd: srchost should never be *
Date:   Sat, 18 Jul 2020 05:24:14 -0400
Message-Id: <20200718092421.31691-5-nazard@nazar.ca>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.05)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0ZZlDYW4q2llG44Qh0NJtYKpSDasLI4SayDByyq9LIhVj68uwus5iNQe
 5LfBw+Y7U0TNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dIrsigAD47V6xukOJK/QG1bqwD+Ufwmnv2XpsoA/vlp5nXpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQ9clsf95ERnfa5/3utVu63cGgIqsnjgPIxt+QJb5OikLV0VRXawyICi9P2LaegYD
 7MEavzt+PYIWFngwZuyqjCaZSjmmVb1jzWCjpHhh1WjZqXWvTtyZt5+E2rHRTxiOPQKf33qQtTYr
 DPixEr4D2aetI4g+l6rCWbY0MZcgnbHs5dmPTEEmx4/N3lqiWWXcjbsCnerI87CybAKXp7fccSM9
 KFHeWHW2x7WJWDVGxpUB9HDhl4gBqApdFfF/te8FXfRnzQu6jFSVK9YDcVmQAY2napQ1VBeZGBjd
 4wKnJrvdiwQzKw+6v3CaIMG6s7LqJPXlxUTbP0xEZy5p9dvo9LFm4eDGPWQjiHziZaTK5a5h/fs6
 iE/7cNj+QdmuDJk1ulGITuDr9Ht4sqiIlkRdeCb5d9Mpny2MqlrXcMQyNtV/a69YW9GH6uP7jsWP
 FubLd8OpyKA69LF1Ge2GaGfxmfr6K2lXCppCFhOH1qLPVvOyhENX6cHY1RZ9qv4kihn2llwcIfe9
 qSdMLqKquuUrXWpOB0fQQI8VICRbS6zGNgmkrLchyjwyJsS12kHj54zW1GIRK0UT0GXzK7XVSbOa
 O4t6datJIW5RtosbtmTCpMB/
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fix silly mistake on my part due to a rebase error.

Signed-off-by: Doug Nazar <nazard@nazar.ca>
---
 utils/gssd/krb5_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index 1d7b30c6..a1a9ffe9 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -854,7 +854,7 @@ find_keytab_entry(krb5_context context, krb5_keytab kt,
 		goto out;
 
 	/* Get full local hostname */
-	if (srchost && strcmp(srchost, "*") != 0) {
+	if (srchost) {
 		strcpy(myhostname, srchost);
 	        strcpy(myhostad, myhostname);
 	} else {
-- 
2.26.2

