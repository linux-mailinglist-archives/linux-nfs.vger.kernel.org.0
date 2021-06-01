Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B581397C3D
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jun 2021 00:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbhFAWLT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Jun 2021 18:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbhFAWLR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Jun 2021 18:11:17 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FABC061574
        for <linux-nfs@vger.kernel.org>; Tue,  1 Jun 2021 15:09:34 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c20so456032qkm.3
        for <linux-nfs@vger.kernel.org>; Tue, 01 Jun 2021 15:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9LDwEwPQbhwjs1lrw0RcLVlG/gcKNLc/Zyhh3epgGAM=;
        b=ZZGR+yTvvHOTcue8eeLb0wTVEAL80yz0pYdGUpS0zMu5bP2TQeC3Wh+Kv4X6x6hW1v
         6Pvs2n2dF9fsEzIxbNLrwcAjQVsQ/ihlqOC3OLiM93Ek+HTCjMPVzGbLw9fLx84JTqc7
         g4HwT8ikPQPHGMkLUswjsItPn9dSRUqLAMAysikroNf4gUr7ARG444gjeH2Ak8E9OpOr
         Blyp4zd71vYCZjAl7Qsl37WIpEYiBm60z74ErG2EsWxg1uRgJREdSsLWqYFsUOVKoD7n
         KQf09wV2xHB70rdyDX849q7LK4/x/I8j/vuJ4PxHfMvj/JvXXfP3oB+TIpoePSk09NLu
         XPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9LDwEwPQbhwjs1lrw0RcLVlG/gcKNLc/Zyhh3epgGAM=;
        b=jbt9Wf0U1cjUWim/4jbRLz+yGdWViPhB0U9iGdzCeiQXw3BF/i9nZS/RPymaP+s/4I
         kZpIR0QhBYsDtZg390trWy6elqfSzXFwAumuA3dj4p6k5FDSerpHmV/8pEg7H3ReZyLC
         KFRBsTY0ipuOl2T4KoioblzRSGMM5WPzVWoFlNRbKsjNQk0vchjJHwFvAuBjdvVYjBXv
         lzfAORu/OLMHzQd5KtslD+v6fUFykQ9s3QG2MAEPFfqdBY/s6lLldYte8l5Z4/oI8T3B
         /vlgGGpgnzknHz1PWUGnCj/IuuCaFo7u22HYItwm2bIspKt54AXj7zjJUgJpDeFHTPWu
         fmmA==
X-Gm-Message-State: AOAM531IphjSM0Dfd6QSVyJBbWoCItdUuyWrW0XGAxUBVC9ZWpVOObiw
        Vgtk8rtTquH+czlnTL5xNCU=
X-Google-Smtp-Source: ABdhPJxU+LdFa3z8nxBT2aD+KEBkleWDaurY0fJeao5pBlEpSEDGybbsx65rvumKU6qdO3qZBsdwZQ==
X-Received: by 2002:a37:6496:: with SMTP id y144mr23595970qkb.147.1622585373797;
        Tue, 01 Jun 2021 15:09:33 -0700 (PDT)
Received: from kolga-mac-1.lan (50-124-240-218.alma.mi.frontiernet.net. [50.124.240.218])
        by smtp.gmail.com with ESMTPSA id q13sm12419789qkn.10.2021.06.01.15.09.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 15:09:33 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 04/13] sunrpc: add xprt id
Date:   Tue,  1 Jun 2021 18:09:06 -0400
Message-Id: <20210601220915.18975-5-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210601220915.18975-1-olga.kornievskaia@gmail.com>
References: <20210601220915.18975-1-olga.kornievskaia@gmail.com>
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

