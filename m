Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEC94748B5
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Dec 2021 18:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236212AbhLNRBb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Dec 2021 12:01:31 -0500
Received: from forward101o.mail.yandex.net ([37.140.190.181]:48536 "EHLO
        forward101o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233565AbhLNRBb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Dec 2021 12:01:31 -0500
X-Greylist: delayed 330 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Dec 2021 12:01:31 EST
Received: from sas1-c701ea5c66a2.qloud-c.yandex.net (sas1-c701ea5c66a2.qloud-c.yandex.net [IPv6:2a02:6b8:c08:bd28:0:640:c701:ea5c])
        by forward101o.mail.yandex.net (Yandex) with ESMTP id 07113369B532
        for <linux-nfs@vger.kernel.org>; Tue, 14 Dec 2021 19:55:59 +0300 (MSK)
Received: from sas1-37da021029ee.qloud-c.yandex.net (sas1-37da021029ee.qloud-c.yandex.net [2a02:6b8:c08:1612:0:640:37da:210])
        by sas1-c701ea5c66a2.qloud-c.yandex.net (mxback/Yandex) with ESMTP id qqPjcoO0sB-twfCuwco;
        Tue, 14 Dec 2021 19:55:58 +0300
Authentication-Results: sas1-c701ea5c66a2.qloud-c.yandex.net; dkim=pass
Received: by sas1-37da021029ee.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id ga0CTPm1eS-twPmDWlk;
        Tue, 14 Dec 2021 19:55:58 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
From:   "Sergey V. Lobanov" <sergey@lobanov.in>
To:     linux-nfs@vger.kernel.org
Cc:     "Sergey V. Lobanov" <sergey@lobanov.in>
Subject: [PATCH] tools/rpcgen: fix build on macos arm64 (stat64 issue)
Date:   Tue, 14 Dec 2021 19:55:44 +0300
Message-Id: <20211214165544.40403-1-sergey@lobanov.in>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

__DARWIN_ONLY_64_BIT_INO_T is true on macos arm64 so struct stat64
and stat64() are not available. This patch defines stat64 as stat if
__DARWIN_ONLY_64_BIT_INO_T is true

Signed-off-by: Sergey V. Lobanov <sergey@lobanov.in>
---
 tools/rpcgen/rpc_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/rpcgen/rpc_main.c b/tools/rpcgen/rpc_main.c
index e97940b9..277adc6b 100644
--- a/tools/rpcgen/rpc_main.c
+++ b/tools/rpcgen/rpc_main.c
@@ -62,6 +62,12 @@
 #define EXTEND	1		/* alias for TRUE */
 #define DONT_EXTEND	0	/* alias for FALSE */
 
+#ifdef __APPLE__
+# if __DARWIN_ONLY_64_BIT_INO_T
+#  define stat64 stat
+# endif
+#endif
+
 struct commandline
   {
     int cflag;			/* xdr C routines */
-- 
2.30.1 (Apple Git-130)

