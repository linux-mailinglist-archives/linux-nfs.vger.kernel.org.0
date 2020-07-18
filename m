Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B710224A31
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Jul 2020 11:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgGRJYz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Jul 2020 05:24:55 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:33359 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726493AbgGRJYx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Jul 2020 05:24:53 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jwj5N-0000R0-Em
        for linux-nfs@vger.kernel.org; Sat, 18 Jul 2020 04:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Zs8G1KEhTIqxglkafiEcfOf7iZimMZlcnlEuNlSeez0=; b=F7uWbdgM/Hfe11RO+tUMZ52RoW
        RaXkA3cpnnB7Kdq9oZQ1O8eMaC4AZSSPNBXYSXcCWydW1rAvS808DDjfUImbvXiMUE1E0TOEIFmI2
        cPlyysjH/22/cuYnRPsKnjPjvny/3eVqfp8LI9pwwf6hM9vL3UFZX3YX+hhYNxVSCKqWBGb0bJg4F
        Kedlcwp6BWgSaM7KAAbj8WWmcXlaUy6z1hKa5AhI9bucwypcp1VuCPtTIdQ07th2rdFZd5RAVyywa
        +rIsltX4JukCux6bzG1+qkEaCB5WU17xFj8A6+XKKfs4Ab64ngAQc3i6YsZFBHUe151QB5pNfKJPp
        lzWkIvHg==;
Received: from [174.119.114.224] (port=53842 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jwj5N-0001He-8s
        for linux-nfs@vger.kernel.org; Sat, 18 Jul 2020 05:24:49 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 02/11] gssd: Fix cccache buffer size
Date:   Sat, 18 Jul 2020 05:24:12 -0400
Message-Id: <20200718092421.31691-3-nazard@nazar.ca>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.01)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0ZZlDYW4q2llG44Qh0NJtYKpSDasLI4SayDByyq9LIhVKcroZG2O4Yxy
 BKfoN7Az3ETNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dLkG7tBGLrnWZHb+VDULxhKqJ2jUG6iVD0cGbSjkzfIDnXpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQ9clsf95ERnfa5/3utVu63cGgIqsnjgPIxt+QJb5OikLV0VRXawyICi9P2LaegYD
 7MEavzt+PYIWFngwZuyqjCaZSjmmVb1jzWCjpHhh1WjZqXWvTtyZt5+E2rHRTxiOPQKf33qQtTYr
 DPixEr4D2aetI4g+l6rCWbY0MZcgnbHs5dmPTEEmx4/N3lqiWWXcjbsCnerI87CybAKXp7fccSPP
 xlqSGulpXM7vqLZv/uuO9HDhl4gBqApdFfF/te8FXfRnzQu6jFSVK9YDcVmQAY2napQ1VBeZGBjd
 4wKnJrvdiwQzKw+6v3CaIMG6s7LqJPXlxUTbP0xEZy5p9dvo9LFm4eDGPWQjiHziZaTK5a5h/fs6
 iE/7cNj+QdmuDJk1uknmZzJCfS3ZbUCcYOOzBrr5d9Mpny2MqlrXcMQyNtV/a69YW9GH6uP7jsWP
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
 utils/gssd/krb5_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index e5b81823..34c81daa 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -1225,7 +1225,7 @@ out:
 int
 gssd_setup_krb5_user_gss_ccache(uid_t uid, char *servername, char *dirpattern)
 {
-	char			buf[PATH_MAX+2+256], dirname[PATH_MAX];
+	char			buf[PATH_MAX+4+2+256], dirname[PATH_MAX];
 	const char		*cctype;
 	struct dirent		*d;
 	int			err, i, j;
-- 
2.26.2

