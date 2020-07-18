Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1AA224A34
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Jul 2020 11:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgGRJY5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Jul 2020 05:24:57 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:36025 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726524AbgGRJYz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Jul 2020 05:24:55 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jwj5N-0000Re-UF
        for linux-nfs@vger.kernel.org; Sat, 18 Jul 2020 04:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ob/a3QrY/CnYMnzETkd/l2eT8Jz0jXEb4c9iigBzbjs=; b=D0YpvvRTpGwgjoMYMn8VUSobjk
        xn3OdLPg4Ep00J5Fp2vE69i7FIgUGxzy7YA5TBeekPhd9p9f0HcarWOu85oVBMLDTlnB6BnDojqSq
        xaOdbxHwcRQNWhHhjAwc8YFTLtReCHDo8BryJhrxyzqdbiEVD9R0x7UPhxL+waP0vKs6rbJMNhvRi
        IyaI2F8e3yORJxr/2UMJzw5cTZ6eUz63I8XDZ1/hCBPADcH3YwLBArZThe2sOjFmV3ljKUS6K6gpx
        X27Klo0jYaBBT+Af/28zkDdKUT+j4f5TFDDtygDGz+i/kT5mDfh3TCQaMoaPxxntvaS3Bs7ZVMtD6
        TYmy+K5A==;
Received: from [174.119.114.224] (port=53842 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jwj5N-0001He-Oe
        for linux-nfs@vger.kernel.org; Sat, 18 Jul 2020 05:24:49 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 05/11] xlog: Reorganize xlog_backend() to work around -Wmaybe-uninitialized
Date:   Sat, 18 Jul 2020 05:24:15 -0400
Message-Id: <20200718092421.31691-6-nazard@nazar.ca>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200718092421.31691-1-nazard@nazar.ca>
References: <20200718092421.31691-1-nazard@nazar.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Get-Message-Sender-Via: nyc006.hawkhost.com: authenticated_id: nazard@nazar.ca
X-Authenticated-Sender: nyc006.hawkhost.com: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: 172.96.186.142
Authentication-Results: arandomserver.com; auth=pass smtp.auth=172.96.186.142@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00182392679309)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0ZZlDYW4q2llG44Qh0NJtYKpSDasLI4SayDByyq9LIhVN69Z152jo21K
 i1yspGfIeUTNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dK2//bXub2QN6Rh6ewuoq3n8XMDNGgxMYuTJb3gku0denXpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQwzEEJbreAQRsbSZZ9fXoUEifL76GD10kuo3nOZaoX+gsjENmEszkjZCjfYHwrdv
 NOzx52pqgFKULzmTh7lC+C1OB0fQQI8VICRbS6zGNgmk2+y1r/Jt2+QI0NYgZu+YDGDmnroh/8hH
 WR/Etfk4HCQTo4dLz8XEDoyijq2CEGKcGplHcpVCCoX989hgB8R+yHz6Wz8d/Pp/n7kUT3MNKWyV
 mI6ol8ojWV/XK6LQktrhCohLlAoHDrdsdIGnH8V4JX9nMre3YEbkuALmW8gN9RXH3DI0NOgo6/Ab
 vYB8YDlEEBksfbu9yLQMc7lcHkHFV/djzQ6YC7Heg3Xf7O1TOd4Lp6/mezP3/ta7RoBl7TSj8Cd1
 02D1/PxWBdanhqFXVNfl/yowmv/m59rLSnpj2NxQtO5l+JZmq2Ee+qvvScIFZjEa/sNl+vcoDGoY
 k0DAXQsuA+ZOE6ZCLBhP3Kw7GhP6DxWSEoQUnaVSVuR240Ewmn4rjkt/ing/Kst6lT+FgU1vUJm2
 lwcjBA1nf30dydyo/g58MkufxisELuuE3bZK19QhM8um7L9VndMW7hyljAQWfxYdU0gXE07BZ9Ya
 Ke+gc5LamkkGaPkiMxmyjA0L/Ub/yrYgxwwQmd72Iri+RjEvuGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

xlog.c: In function ‘xlog_backend’:
xlog.c:202:3: warning: ‘args2’ may be used uninitialized in this function [-Wmaybe-uninitialized]
202 |   vfprintf(stderr, fmt, args2);
    |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Doug Nazar <nazard@nazar.ca>
---
 support/nfs/xlog.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/support/nfs/xlog.c b/support/nfs/xlog.c
index 687d862d..86acd6ac 100644
--- a/support/nfs/xlog.c
+++ b/support/nfs/xlog.c
@@ -156,13 +156,29 @@ xlog_enabled(int fac)
 void
 xlog_backend(int kind, const char *fmt, va_list args)
 {
-	va_list args2;
-
 	if (!(kind & (L_ALL)) && !(logging && (kind & logmask)))
 		return;
 
-	if (log_stderr)
+	if (log_stderr) {
+		va_list		args2;
+#ifdef VERBOSE_PRINTF
+		time_t		now;
+		struct tm	*tm;
+
+		time(&now);
+		tm = localtime(&now);
+		fprintf(stderr, "%s[%d] %04d-%02d-%02d %02d:%02d:%02d ",
+				log_name, log_pid,
+				tm->tm_year+1900, tm->tm_mon + 1, tm->tm_mday,
+				tm->tm_hour, tm->tm_min, tm->tm_sec);
+#else
+		fprintf(stderr, "%s: ", log_name);
+#endif
 		va_copy(args2, args);
+		vfprintf(stderr, fmt, args2);
+		fprintf(stderr, "\n");
+		va_end(args2);
+	}
 
 	if (log_syslog) {
 		switch (kind) {
@@ -185,25 +201,6 @@ xlog_backend(int kind, const char *fmt, va_list args)
 		}
 	}
 
-	if (log_stderr) {
-#ifdef VERBOSE_PRINTF
-		time_t		now;
-		struct tm	*tm;
-
-		time(&now);
-		tm = localtime(&now);
-		fprintf(stderr, "%s[%d] %04d-%02d-%02d %02d:%02d:%02d ",
-				log_name, log_pid,
-				tm->tm_year+1900, tm->tm_mon + 1, tm->tm_mday,
-				tm->tm_hour, tm->tm_min, tm->tm_sec);
-#else
-		fprintf(stderr, "%s: ", log_name);
-#endif
-		vfprintf(stderr, fmt, args2);
-		fprintf(stderr, "\n");
-		va_end(args2);
-	}
-
 	if (kind == L_FATAL)
 		exit(1);
 }
-- 
2.26.2

