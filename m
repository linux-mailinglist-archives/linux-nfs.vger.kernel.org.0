Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B16739ADE7
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jun 2021 00:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhFCWXc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 18:23:32 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:37568 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbhFCWXc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Jun 2021 18:23:32 -0400
Received: by mail-qk1-f173.google.com with SMTP id i67so7551866qkc.4
        for <linux-nfs@vger.kernel.org>; Thu, 03 Jun 2021 15:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9LDwEwPQbhwjs1lrw0RcLVlG/gcKNLc/Zyhh3epgGAM=;
        b=p1GP2scrKDinCFr3gsnXtWhEeOqeXZYzJlMIcnFwvH583H3F1q0R2IXr1SIqkQyMsM
         cQ0Xvi1sULRe97LN+aHYYHW6j5llxsW+73eaJ9/ieVOHcUJOx1J5y9lW1WNYHNHWV6R7
         40QbEJUMHnY5sj0/f+bB/kQD1Z0sL8KcxNDaWBd4aze2+LFTQwC4lLwIYUYrxXRv/1uq
         pV2W4lP6ZcSw7Jb2G2nqDapjW06jxqDTFEVoaAEtBvz80HoXrauL0xNfmlHX0up6/SiW
         0VIS57WMc8g1JACPBhFycf2WlrWA9B6hsJ/dzTw3n/H51YSE57LLwrIGx/w7KYqpwOv7
         hHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9LDwEwPQbhwjs1lrw0RcLVlG/gcKNLc/Zyhh3epgGAM=;
        b=GcBh72JeTJ+pBcc//0JCaa+XGvJ3PSDWwPffmwR/AQ/t2bBEsfC3WWdGDiiuuu4cR+
         1KkV/tNgOFC7+Ada7dKstoja1lEphl3o1eNIWCp6aX57DPyPGUnMF2Zj+egHI5pUc/Pi
         xMSIqrAH35qDuTR/JA+g3+IqRUFkWGYr72Y0mQvW0mGod5sPHtNNpQtH5tqOnOqh112H
         dzAijR9b54aM4aNotkraAg0jrX4V5jVebUIJc/GHPFQj7IwdkdA92/+MgjRcPoZRGXgF
         XEj//z3a0MI2iiDMkQ4FZwHQGEdp6rkzUFqsi3Mq1Npq+Ir5SBsZxY7Vw71zDHZCE2MK
         3y8g==
X-Gm-Message-State: AOAM531M31BUwsKtfHnFW4ZYrKT5bbfPuxyi94quR2HS1PXxTeM+f8pn
        eYe/V7wy4Ih1V715vapil0EU6WAolQU=
X-Google-Smtp-Source: ABdhPJy3/5q/2Wg2fhXjcXuJ4pyQlLBss2blEKcuMnOwFhY2ad0ay6NonZ7JALg3xPftr/h4qJ6RKQ==
X-Received: by 2002:a05:620a:14a9:: with SMTP id x9mr1524641qkj.57.1622758846703;
        Thu, 03 Jun 2021 15:20:46 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-23.netapp.com. [216.240.30.23])
        by smtp.gmail.com with ESMTPSA id 187sm2870230qkn.43.2021.06.03.15.20.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jun 2021 15:20:46 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 04/13] sunrpc: add xprt id
Date:   Thu,  3 Jun 2021 18:20:30 -0400
Message-Id: <20210603222039.19182-5-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210603222039.19182-1-olga.kornievskaia@gmail.com>
References: <20210603222039.19182-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

This adds a unique identifier for a sunrpc transport in sysfs, which is
similarly managed to the unique IDs of clients.

Signed-off-by: Dan Aloni <dan@kernelim.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/xprt.h |  2 ++
 net/sunrpc/sunrpc_syms.c    |  1 +
 net/sunrpc/xprt.c           | 26 ++++++++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index 61b622e334ee..1fbc470ce205 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -185,6 +185,7 @@ enum xprt_transports {
 struct rpc_xprt {
 	struct kref		kref;		/* Reference count */
 	const struct rpc_xprt_ops *ops;		/* transport methods */
+	unsigned int		id;		/* transport id */
 
 	const struct rpc_timeout *timeout;	/* timeout parms */
 	struct sockaddr_storage	addr;		/* server address */
@@ -370,6 +371,7 @@ struct rpc_xprt *	xprt_alloc(struct net *net, size_t size,
 void			xprt_free(struct rpc_xprt *);
 void			xprt_add_backlog(struct rpc_xprt *xprt, struct rpc_task *task);
 bool			xprt_wake_up_backlog(struct rpc_xprt *xprt, struct rpc_rqst *req);
+void			xprt_cleanup_ids(void);
 
 static inline int
 xprt_enable_swap(struct rpc_xprt *xprt)
diff --git a/net/sunrpc/sunrpc_syms.c b/net/sunrpc/sunrpc_syms.c
index 3b57efc692ec..b61b74c00483 100644
--- a/net/sunrpc/sunrpc_syms.c
+++ b/net/sunrpc/sunrpc_syms.c
@@ -133,6 +133,7 @@ cleanup_sunrpc(void)
 {
 	rpc_sysfs_exit();
 	rpc_cleanup_clids();
+	xprt_cleanup_ids();
 	rpcauth_remove_module();
 	cleanup_socket_xprt();
 	svc_cleanup_xprt_sock();
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 3509a7f139b9..20b9bd705014 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1746,6 +1746,30 @@ static void xprt_free_all_slots(struct rpc_xprt *xprt)
 	}
 }
 
+static DEFINE_IDA(rpc_xprt_ids);
+
+void xprt_cleanup_ids(void)
+{
+	ida_destroy(&rpc_xprt_ids);
+}
+
+static int xprt_alloc_id(struct rpc_xprt *xprt)
+{
+	int id;
+
+	id = ida_simple_get(&rpc_xprt_ids, 0, 0, GFP_KERNEL);
+	if (id < 0)
+		return id;
+
+	xprt->id = id;
+	return 0;
+}
+
+static void xprt_free_id(struct rpc_xprt *xprt)
+{
+	ida_simple_remove(&rpc_xprt_ids, xprt->id);
+}
+
 struct rpc_xprt *xprt_alloc(struct net *net, size_t size,
 		unsigned int num_prealloc,
 		unsigned int max_alloc)
@@ -1758,6 +1782,7 @@ struct rpc_xprt *xprt_alloc(struct net *net, size_t size,
 	if (xprt == NULL)
 		goto out;
 
+	xprt_alloc_id(xprt);
 	xprt_init(xprt, net);
 
 	for (i = 0; i < num_prealloc; i++) {
@@ -1786,6 +1811,7 @@ void xprt_free(struct rpc_xprt *xprt)
 {
 	put_net(xprt->xprt_net);
 	xprt_free_all_slots(xprt);
+	xprt_free_id(xprt);
 	kfree_rcu(xprt, rcu);
 }
 EXPORT_SYMBOL_GPL(xprt_free);
-- 
2.27.0

