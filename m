Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C173228FC7
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jul 2020 07:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgGVFfA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jul 2020 01:35:00 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:39783 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728047AbgGVFe5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jul 2020 01:34:57 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jy7P4-0005Qp-D2; Wed, 22 Jul 2020 00:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=WV/diP5A2mxTKrNLxrkUgdsaCx95wCjxBIat5AbFg3I=; b=FE1cvUxi4SrjHEJo0ekII3qQwa
        CDkRnstVhsv29dgJWQnuYSA6OJYH1tOYRiMI3kIjIzixjxDlG3T+/XVkGqxSv3FX43BVs/Y0fVKO6
        oyfFmEQQxy/fmramk7rKeCWKJEG2mFuZv1bD3+/77H67J3tGBqGsDNDnVHvlhOUTjETGkUOFbkkhm
        e6EJcounzGSFnexia3P6+szbZz2mf+dTLaWyeN3dLXVtzHHpqrPaND8UiiD7keEr/NKUP1bJNiTc/
        tPaROYPADroCi0wyVGqQAS5H/VIpcQSJr5O89zv+WJe/jnWBwxfZRk/lRatYFgq7DoyOmdsF3RV54
        Dnq1a54A==;
Received: from [174.119.114.224] (port=44150 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jy7P4-00045O-5m; Wed, 22 Jul 2020 01:34:54 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/5] Add destructor functions to cleanup static resources on exit
Date:   Wed, 22 Jul 2020 01:34:43 -0400
Message-Id: <20200722053445.27987-4-nazard@nazar.ca>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200722053445.27987-1-nazard@nazar.ca>
References: <20200722053445.27987-1-nazard@nazar.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Get-Message-Sender-Via: nyc006.hawkhost.com: authenticated_id: nazard@nazar.ca
X-Authenticated-Sender: nyc006.hawkhost.com: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: 172.96.186.142
Authentication-Results: arandomserver.com; auth=pass smtp.auth=172.96.186.142@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00727654545138)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0bN4ZX/cCaR95pQ7tQtUF1ypSDasLI4SayDByyq9LIhV9NcozcRA5uRv
 eFErZGsk80TNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3KnRr9dv6aS/XsdM3hwL/Vxz9G
 0IA9bRwRct9JixjrSnwE9+MNv0Z9Z/ftUlQdQf4t0vBWG099Hxh0Nb9o6T55Sb4hKsV7vZ7I7qfm
 2H1RjeoPKPw30IfHLv5Maa509n421/BgStvhQrzEV/3sSgXiDA8Wchfv6rsJV69dwwRye5Fqf5gk
 ygI/REKLXOuXEMRCFDpXnW7vq/flvXA178y90oxHpGdcOo7PShBgpIzYxnXDldmsGq7kDyH0ew4I
 Dw+CACkJUHU38G0nImq/tiQjLLdHRLp5rVU0FqkdDCRmJ2BgSGUuK0YJtRg9EDez7Ku5DKDi4xrE
 c/zFBOmiGaAnFDV0eGlRuLVR1NWZXcsvs30x4KEUiJDRsmQ5HT3VKkMngMDkh+x5vuoVP4y7XWE4
 htzO1sNHi2dZfnvz0t7lQuf3dzeBXXYwn72Dn7DrpA7vvCrJPmnnTHzVkpybMK7ZTb4b8JI5n/33
 0Vy5Mb7V+UASMA3VB4qR7791JlunzPNIIK/1NH5THMtlYvyHAYGOGiINloeONSMv6A+sGH/yfiSl
 jMAtJ8Ou1AejrJGC3Ksl9UChS3C9MEug5tRgp49dE7OQieMVEpHEHzm/JETlx82+bOZaDlh19n+s
 LEYRzXjw0dlbiVj8iqSymuT4y+AGElBhoneoOfDXMh1yq1Dcc+PlM80SVRcI4stOBDpJY67t/SO9
 4N/2SEEH7linr52fw02EJlDGG/5q07Y5Durp9lofPFg46jzk0wb+4gNa+rlVcX6WA4xk2dMd2nDL
 ISKIkc+9ZP4yc5/9kax13FT91ruIyhaI671I4yi7MsEJJOHqizyAOkhWppVS6OKEN8H6j4felQMu
 NmxhuDV4B2QQyyolCkSujm58a/xB+XC1kCc6aOZSGeNj6SDHeu/o/TAv4j8LsjKGjaMRfhQwBM0F
 5SQ74aTtf/4C/N7L86T3goskHJ4/eQwX8czaqLttcGYGf49yYjkgur7cbmMvzASyKBHj9d2+x33p
 URJvPvfexqQ63bg2yZA3P76DRQMMUbyIqw==
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Doug Nazar <nazard@nazar.ca>
---
 src/auth_none.c | 14 ++++++++++++++
 src/clnt_dg.c   | 12 ++++++++++++
 src/clnt_vc.c   | 12 ++++++++++++
 src/svc.c       | 19 +++++++++++++++++++
 4 files changed, 57 insertions(+)

diff --git a/src/auth_none.c b/src/auth_none.c
index 0b0bbd1..06db3b3 100644
--- a/src/auth_none.c
+++ b/src/auth_none.c
@@ -72,6 +72,20 @@ static struct authnone_private {
 	u_int	mcnt;
 } *authnone_private;
 
+__attribute__((destructor))
+static void
+authnone_cleanup(void)
+{
+	extern mutex_t authnone_lock;
+
+	mutex_lock(&authnone_lock);
+	if (authnone_private) {
+		free(authnone_private);
+		authnone_private = NULL;
+	}
+	mutex_unlock(&authnone_lock);
+}
+
 AUTH *
 authnone_create()
 {
diff --git a/src/clnt_dg.c b/src/clnt_dg.c
index abc09f1..60e3503 100644
--- a/src/clnt_dg.c
+++ b/src/clnt_dg.c
@@ -130,6 +130,18 @@ struct cu_data {
 	char			cu_inbuf[1];
 };
 
+__attribute__((destructor))
+static void
+clnt_vc_cleanup(void)
+{
+	mutex_lock(&clnt_fd_lock);
+	if (dg_fd_locks) {
+		mem_free(dg_fd_locks, sizeof(*dg_fd_locks));
+		dg_fd_locks = NULL;
+	}
+	mutex_unlock(&clnt_fd_lock);
+}
+
 /*
  * Connection less client creation returns with client handle parameters.
  * Default options are set, which the user can change using clnt_control().
diff --git a/src/clnt_vc.c b/src/clnt_vc.c
index 6f7f7da..a4b41df 100644
--- a/src/clnt_vc.c
+++ b/src/clnt_vc.c
@@ -158,6 +158,18 @@ static const char clnt_vc_errstr[] = "%s : %s";
 static const char clnt_vc_str[] = "clnt_vc_create";
 static const char __no_mem_str[] = "out of memory";
 
+__attribute__((destructor))
+static void
+clnt_vc_cleanup(void)
+{
+	mutex_lock(&clnt_fd_lock);
+	if (vc_fd_locks) {
+		mem_free(vc_fd_locks, sizeof(*vc_fd_locks));
+		vc_fd_locks = NULL;
+	}
+	mutex_unlock(&clnt_fd_lock);
+}
+
 /*
  * Create a client handle for a connection.
  * Default options are set, which the user can change using clnt_control()'s.
diff --git a/src/svc.c b/src/svc.c
index 57f7ba3..b5f35c8 100644
--- a/src/svc.c
+++ b/src/svc.c
@@ -85,6 +85,25 @@ static void __xprt_do_unregister (SVCXPRT * xprt, bool_t dolock);
 
 /* ***************  SVCXPRT related stuff **************** */
 
+__attribute__((destructor))
+static void
+xprt_cleanup(void)
+{
+  rwlock_wrlock (&svc_fd_lock);
+  if (__svc_xports != NULL)
+    {
+      free (__svc_xports);
+      __svc_xports = NULL;
+    }
+  if (svc_pollfd != NULL)
+    {
+      free (svc_pollfd);
+      svc_pollfd = NULL;
+      svc_max_pollfd = 0;
+    }
+  rwlock_unlock (&svc_fd_lock);
+}
+
 /*
  * Activate a transport handle.
  */
-- 
2.26.2

