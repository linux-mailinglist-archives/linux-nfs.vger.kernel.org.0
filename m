Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16C926CDE0
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jul 2019 14:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfGRMLh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Jul 2019 08:11:37 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44718 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbfGRMLg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Jul 2019 08:11:36 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so50931949iob.11
        for <linux-nfs@vger.kernel.org>; Thu, 18 Jul 2019 05:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rayXj1q+b9rk64I/kc9W92JG4FCiMgkDatuT1J5K2Ao=;
        b=WyRjH6GpaoV7S614A0EWdqCrLgOBMXvIneNhtCWGCNxzoD8OUsCiEkRJavvltznDxC
         rdMOJRpIRvM81Ri7M1sl+Y5aniPuZlNbv1HpBMz/VBuGrlZp6O4CvH69gnscuVwMg1LH
         0XD/rHVuC9xZcMnl4srKDBaKKGUxIOf8saTQaPDd+PWftY2anXZyJv9DFtXAx2ARtaw2
         ITL/5Rn8NVVOQxsJta476LCgxvT5Go5rL/1WCp8A28r8Utp3QNdXjqQk/YN5pCGXO54f
         xMp96ne2Lwp7iLAbpl8GnZ7DCFoXDBES37nQ9kHwcvAn+hIVJEVo2DircdTGxrjsCrrm
         jK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rayXj1q+b9rk64I/kc9W92JG4FCiMgkDatuT1J5K2Ao=;
        b=UiMVNsC8nYCRyq+poCgYDH++SQ9RXr1W/Jpjns4007sxBFUEHr75pqcJUORcwPvosH
         TQPj5hR/ocrHHhIrax+4o9NPVvCmC42CgwvDwjTh+CnIIWxFNYWFbO4gU4qesM44395s
         lgFLJQBVuTYY7XRK1+bVviRB9rGiRMjmiV2Xqfpk49+0opkrKnkZ+ILSRRy+lZPUwmbs
         4RsiHTvO3bGO4Vu+jwF4UmMhnaNwJtLCMWKUxwtfdfYeW6GrTkc4dN24ctmiW/oxKVJl
         SWFSRN7N1Q1q3M9HT3qMet79K4jszI3kMhU+LB9jB6egPNVGD+oB57rE3gK24m4FBsiO
         NY4g==
X-Gm-Message-State: APjAAAXDPVaxIGcfkg+WeEP9LHQ/Tc6YSQL2+/nS9K7Hvz43rvp3OPlE
        oqM2Lk5r1+W2TO+y/V4oxFvb76w=
X-Google-Smtp-Source: APXvYqz+KTQ2z6NCtHJgEhTSgeS9vhblFIDx3Z5rpRwP8jK7dQjChBMmi/lB1tYKkl56tyDvqbcw7Q==
X-Received: by 2002:a5d:928a:: with SMTP id s10mr16669196iom.29.1563451895284;
        Thu, 18 Jul 2019 05:11:35 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id i3sm23406741ion.9.2019.07.18.05.11.33
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 05:11:34 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Optimise transport balancing code
Date:   Thu, 18 Jul 2019 08:08:04 -0400
Message-Id: <20190718120804.108146-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190718120804.108146-2-trond.myklebust@hammerspace.com>
References: <20190718120804.108146-1-trond.myklebust@hammerspace.com>
 <20190718120804.108146-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Moves the balancing code to avoid doing cursor changes on every search
iteration.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xprtmultipath.c | 67 +++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 29 deletions(-)

diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index f3ecd0bee484..78c075a68c04 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -19,7 +19,7 @@
 #include <linux/sunrpc/addr.h>
 #include <linux/sunrpc/xprtmultipath.h>
 
-typedef struct rpc_xprt *(*xprt_switch_find_xprt_t)(struct list_head *head,
+typedef struct rpc_xprt *(*xprt_switch_find_xprt_t)(struct rpc_xprt_switch *xps,
 		const struct rpc_xprt *cur);
 
 static const struct rpc_xprt_iter_ops rpc_xprt_iter_singular;
@@ -291,22 +291,15 @@ struct rpc_xprt *xprt_switch_find_next_entry(struct list_head *head,
 }
 
 static
-struct rpc_xprt *xprt_switch_set_next_cursor(struct list_head *head,
+struct rpc_xprt *xprt_switch_set_next_cursor(struct rpc_xprt_switch *xps,
 		struct rpc_xprt **cursor,
 		xprt_switch_find_xprt_t find_next)
 {
-	struct rpc_xprt *cur, *pos, *old;
+	struct rpc_xprt *pos, *old;
 
-	cur = READ_ONCE(*cursor);
-	for (;;) {
-		old = cur;
-		pos = find_next(head, old);
-		if (pos == NULL)
-			break;
-		cur = cmpxchg_relaxed(cursor, old, pos);
-		if (cur == old)
-			break;
-	}
+	old = smp_load_acquire(cursor);
+	pos = find_next(xps, old);
+	smp_store_release(cursor, pos);
 	return pos;
 }
 
@@ -318,13 +311,11 @@ struct rpc_xprt *xprt_iter_next_entry_multiple(struct rpc_xprt_iter *xpi,
 
 	if (xps == NULL)
 		return NULL;
-	return xprt_switch_set_next_cursor(&xps->xps_xprt_list,
-			&xpi->xpi_cursor,
-			find_next);
+	return xprt_switch_set_next_cursor(xps, &xpi->xpi_cursor, find_next);
 }
 
 static
-struct rpc_xprt *xprt_switch_find_next_entry_roundrobin(struct list_head *head,
+struct rpc_xprt *__xprt_switch_find_next_entry_roundrobin(struct list_head *head,
 		const struct rpc_xprt *cur)
 {
 	struct rpc_xprt *ret;
@@ -336,31 +327,49 @@ struct rpc_xprt *xprt_switch_find_next_entry_roundrobin(struct list_head *head,
 }
 
 static
-struct rpc_xprt *xprt_iter_next_entry_roundrobin(struct rpc_xprt_iter *xpi)
+struct rpc_xprt *xprt_switch_find_next_entry_roundrobin(struct rpc_xprt_switch *xps,
+		const struct rpc_xprt *cur)
 {
-	struct rpc_xprt_switch *xps = rcu_dereference(xpi->xpi_xpswitch);
+	struct list_head *head = &xps->xps_xprt_list;
 	struct rpc_xprt *xprt;
-	unsigned long xprt_queuelen;
-	unsigned long xps_queuelen;
+	unsigned int nactive;
 
-	do {
-		xprt = xprt_iter_next_entry_multiple(xpi,
-			xprt_switch_find_next_entry_roundrobin);
-		if (xprt == NULL)
+	for (;;) {
+		unsigned long xprt_queuelen, xps_queuelen;
+
+		xprt = __xprt_switch_find_next_entry_roundrobin(head, cur);
+		if (!xprt)
 			break;
 		xprt_queuelen = atomic_long_read(&xprt->queuelen);
-		if (xprt_queuelen <= 2)
-			break;
 		xps_queuelen = atomic_long_read(&xps->xps_queuelen);
+		nactive = READ_ONCE(xps->xps_nactive);
 		/* Exit loop if xprt_queuelen <= average queue length */
-	} while (xprt_queuelen * READ_ONCE(xps->xps_nactive) > xps_queuelen);
+		if (xprt_queuelen * nactive <= xps_queuelen)
+			break;
+		cur = xprt;
+	}
 	return xprt;
 }
 
+static
+struct rpc_xprt *xprt_iter_next_entry_roundrobin(struct rpc_xprt_iter *xpi)
+{
+	return xprt_iter_next_entry_multiple(xpi,
+			xprt_switch_find_next_entry_roundrobin);
+}
+
+static
+struct rpc_xprt *xprt_switch_find_next_entry_all(struct rpc_xprt_switch *xps,
+		const struct rpc_xprt *cur)
+{
+	return xprt_switch_find_next_entry(&xps->xps_xprt_list, cur);
+}
+
 static
 struct rpc_xprt *xprt_iter_next_entry_all(struct rpc_xprt_iter *xpi)
 {
-	return xprt_iter_next_entry_multiple(xpi, xprt_switch_find_next_entry);
+	return xprt_iter_next_entry_multiple(xpi,
+			xprt_switch_find_next_entry_all);
 }
 
 /*
-- 
2.21.0

