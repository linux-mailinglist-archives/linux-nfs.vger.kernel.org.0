Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B72228FCB
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jul 2020 07:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgGVFfA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jul 2020 01:35:00 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:37167 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728049AbgGVFe5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jul 2020 01:34:57 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jy7P4-0005RK-Mx; Wed, 22 Jul 2020 00:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=H0OJJiCRA2z+J/9TID8hW+Nbywl+e68k4UX2dPuqEfU=; b=V4IdJOU0vrQbp9nF2I+Go/ckem
        qsSsQ3gX3Wf/e7ghIW0hcNWXGCaDzOyVgE1mKyp4u9PQ3MBdQTHWuzdQuEomJljx8siAeK0Y1je7r
        MaSYk6wjOpiCtn0Qz4ntyBZJVJ2NgT5TH6XKTt2wLETT16Z15TxgPxfkKchqn4rULgIgtAnJXshsO
        L88nynlbULjtBX6SvTD8+5gHq1sAkCqnkuyWzhzy+J9dZArcKWHR85cpD7B9xk/pO7C+3Zkp3RMYH
        goivPGakqxrwg3Ut1QZQ8bxc9x6o4Vf4x6ZicCuboWTsvsPlsYsroHaCTkAESALpnQcxjWySvGQ4z
        8r6Hz+Hg==;
Received: from [174.119.114.224] (port=44150 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jy7P4-00045O-CL; Wed, 22 Jul 2020 01:34:54 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/5] Add ability to detect if we're on the main thread.
Date:   Wed, 22 Jul 2020 01:34:44 -0400
Message-Id: <20200722053445.27987-5-nazard@nazar.ca>
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00670305885447)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0bN4ZX/cCaR95pQ7tQtUF1ypSDasLI4SayDByyq9LIhVcVNJJukeCDo5
 XLSdn74RK0TNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3KnRr9dv6aS/XsdM3hwL/Vxz9G
 0IA9bRwRct9JixjrSnwE9+MNv0Z9Z/ftUlQdQf4t0vBWG099Hxh0Nb9o6T55Sb4hKsV7vZ7I7qfm
 2H1Rjer+dlCJq8l1j1RkyrDTKlHq1/BgStvhQrzEV/3sSgXiDA8Wchfv6rsJV69dwwRye5Fqf5gk
 ygI/REKLXOuXEMRCFDpXnW7vq/flvXA178y90oxHpGdcOo7PShBgpIzYxnXDldmsGq7kDyH0ew4I
 Dw+CACkJUHU38G0nImq/tiQjLLdHRLp5rVU0FqkdDCRmJ2BgSGUuK0YJtRg9EDez7Ku5DKDi4xrE
 c/zFBOmiGaAnFDV0eGlRuLVR1NWZXcsvs30x4KEUiJDRsmQ5HT3VKkMngMDkh+x5vuoVP4y7XWE4
 htzO1sNHi2dZfnvz0t7lQuf3dzeBXXYwn72Dn7DrpA7vvCrJPmnnTHzVkpybMK7ZTb4b8JI5n/33
 0Vy5Mb7V+UASMA3VB4qR7791JlunzPNIIK/1NH5THMtlYvyHAYGOGiINloeONSMv6A+sGH/yfiSl
 jMAtJ8Ou1AejrJGC3Ksl9UChS3C9MEug5tRgp49dE7OQieMVEpHEHzm/JETlx82+bOZaDlh19n+s
 LEYRzXjws/gcceiy36c+3zs8n+TPIlBhoneoOfDXMh1yq1Dcc+PlM80SVRcI4stOBDpJY67t/SO9
 4N/2SEEH7linr52fw02EJlDGG/5q07Y5Durp9lofPFg46jzk0wb+4gNa+rlVcX6WA4xk2dMd2nDL
 ISKIkamUpWn9DZArkAAPSy5i7KyIyhaI671I4yi7MsEJJOHqizyAOkhWppVS6OKEN8H6j4felQMu
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
 src/mt_misc.c     | 17 +++++++++++++++++
 tirpc/reentrant.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/src/mt_misc.c b/src/mt_misc.c
index 5a49b78..020b55d 100644
--- a/src/mt_misc.c
+++ b/src/mt_misc.c
@@ -151,3 +151,20 @@ void tsd_key_delete(void)
 	return;
 }
 
+static pthread_t main_thread_id;
+
+__attribute__((constructor))
+static void
+get_thread_id(void)
+{
+	/* This will only work if we're opened by the main thread.
+	 * Shouldn't be a problem in practice since we expect to be
+	 * linked against, not dlopen() from a random thread.
+	 */
+	main_thread_id = pthread_self();
+}
+
+int thr_main(void)
+{
+	return pthread_equal(main_thread_id, pthread_self());
+}
diff --git a/tirpc/reentrant.h b/tirpc/reentrant.h
index 5bb581a..ee65454 100644
--- a/tirpc/reentrant.h
+++ b/tirpc/reentrant.h
@@ -76,4 +76,5 @@
 #define thr_self()		pthread_self()
 #define thr_exit(x)		pthread_exit(x)
 
+extern int thr_main(void);
 #endif
-- 
2.26.2

