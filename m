Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC1A228FC6
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jul 2020 07:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgGVFe7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jul 2020 01:34:59 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:50237 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728046AbgGVFe5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jul 2020 01:34:57 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jy7P4-0005Qg-5s; Wed, 22 Jul 2020 00:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=GGieAohSQ31SwIYWB2LdK8lLYSGztBwZMbXdvDH2Lho=; b=BgD7j+VBEVvm+jXtKFSEQli9g5
        V8EVTOvPnB5cmbxdKDRdNn883XaV2VxdIz8SfHPljHNbpQvhtCtLyC54W4BmPss2eGhqLYYFpNuD7
        KaTdyxB1g9W+rJ3Ia4B5k51e1Vi+NqjARhnTb4bA5vNjO8jmksS7+sstzQdHDe+9JSx+Mmv4DEUEK
        2qOob1vSGlTpntCHj4r4YdWLWeI78wkFwEgGP11+yVJYNUfsFXqNYB4D/a7cpFtVKF3OneU95xpNt
        JMSGEopXTnVqwOhrnvCWMhE+F9+F4o6HqD7O+2oaKQQNADniVfdxZjtC9aBJQCHuirUsCovx03LTA
        roqcGrJw==;
Received: from [174.119.114.224] (port=44150 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jy7P3-00045O-Ub; Wed, 22 Jul 2020 01:34:54 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/5] svc: Batch allocations of pollfds
Date:   Wed, 22 Jul 2020 01:34:42 -0400
Message-Id: <20200722053445.27987-3-nazard@nazar.ca>
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00179183145979)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0bN4ZX/cCaR95pQ7tQtUF1ypSDasLI4SayDByyq9LIhVRG3Tb3qtKIqt
 P1XtNZVSC0TNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3KnRr9dv6aS/XsdM3hwL/Vxz9G
 0IA9bRwRct9JixjrSnwE9+MNv0Z9Z/ftUlQdQf4t0vBWG099Hxh0Nb9o6T55Sb4hKsV7vZ7I7qfm
 2H1RjeqE//3ApKDQFdJoYdj151hF1/BgStvhQrzEV/3sSgXiDA8Wchfv6rsJV69dwwRye5Fqf5gk
 ygI/REKLXOuXEMRCFDpXnW7vq/flvXA178y90oxHpGdcOo7PShBgpIzYxnXDldmsGq7kDyH0ew4I
 Dw+CACkJUHU38G0nImq/tiQjLLdHRLp5rVU0FqkdDCRmJ2BgSGUuK0YJtRg9EDez7Ku5DKDi4xrE
 c/zFBOmiGaAnFDV0eGlRuLVR1NWZXcsvs30x4KEUiJDRsmQ5HT3VKkMngMDkh+x5vuoVP4y7XWE4
 htzO1sNHi2dZfnvz0t7lQuf3dzeBXXYwn72Dn7DrpA7vvCrJPmnnTHzVkpybMK7ZTb4b8JI5n/33
 0Vy5Mb7V+UASMA3VB4qR7791JlunzPNIIK/1NH5THMtlYvyHAYGOGiINloeONSMv6A+sGH/yfiSl
 jMAtJ8Ou1AejrJGC3Ksl9UChS3C9MEug5tRgp49dE7OQieMVEpHEHzm/JETlx82+bOZaDlh19n+s
 LEYRzXjwbGfWvrl6c2l2Hs3z42U2W1BhoneoOfDXMh1yq1Dcc+PlM80SVRcI4stOBDpJY67t/SO9
 4N/2SEEH7linr52fw02EJlDGG/5q07Y5Durp9lofPFg46jzk0wb+4gNa+rlVcX6WA4xk2dMd2nDL
 ISKIkSzoNhqcqZSvJmI092BUuwyIyhaI671I4yi7MsEJJOHqizyAOkhWppVS6OKEN8H6j4felQMu
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
 src/svc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/src/svc.c b/src/svc.c
index 6db164b..57f7ba3 100644
--- a/src/svc.c
+++ b/src/svc.c
@@ -54,6 +54,7 @@
 #include "rpc_com.h"
 
 #define	RQCRED_SIZE	400	/* this size is excessive */
+#define	SVC_POLLFD_INCREMENT	16
 
 #define max(a, b) (a > b ? a : b)
 
@@ -107,6 +108,7 @@ xprt_register (xprt)
   if (sock < _rpc_dtablesize())
     {
       int i;
+      size_t size;
       struct pollfd *new_svc_pollfd;
 
       __svc_xports[sock] = xprt;
@@ -126,17 +128,17 @@ xprt_register (xprt)
             goto unlock;
           }
 
-      new_svc_pollfd = (struct pollfd *) realloc (svc_pollfd,
-                                                  sizeof (struct pollfd)
-                                                  * (svc_max_pollfd + 1));
+      size = sizeof (struct pollfd) * (svc_max_pollfd + SVC_POLLFD_INCREMENT);
+      new_svc_pollfd = (struct pollfd *) realloc (svc_pollfd, size);
       if (new_svc_pollfd == NULL) /* Out of memory */
         goto unlock;
       svc_pollfd = new_svc_pollfd;
-      ++svc_max_pollfd;
+      svc_max_pollfd += SVC_POLLFD_INCREMENT;
 
-      svc_pollfd[svc_max_pollfd - 1].fd = sock;
-      svc_pollfd[svc_max_pollfd - 1].events = (POLLIN | POLLPRI |
-                                               POLLRDNORM | POLLRDBAND);
+      svc_pollfd[i].fd = sock;
+      svc_pollfd[i].events = (POLLIN | POLLPRI | POLLRDNORM | POLLRDBAND);
+      for (++i; i < svc_max_pollfd; ++i)
+        svc_pollfd[i].fd = -1;
     }
 unlock:
   rwlock_unlock (&svc_fd_lock);
-- 
2.26.2

