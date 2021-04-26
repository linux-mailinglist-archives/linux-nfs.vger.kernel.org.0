Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8AB36B7F7
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Apr 2021 19:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbhDZRUq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Apr 2021 13:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236845AbhDZRUj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Apr 2021 13:20:39 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B38C06138F
        for <linux-nfs@vger.kernel.org>; Mon, 26 Apr 2021 10:19:56 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id t21so5943922iob.2
        for <linux-nfs@vger.kernel.org>; Mon, 26 Apr 2021 10:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rHzBpwJvTvHqQjiOwfvuYiOBLOQx3SSYI4e3E1a/UCY=;
        b=BvYHmZ4XMGYFfqiHp8K29N/cv1WmfJWo+35iEeP7Hp8lsCO26mxTx4lOW4MkgA0S6X
         iE0Krv/3kGyu7dJXJxQEARMcUkv6zee8Lobf6D3XPtHIqe9pFCN0ByXF8JCv4kWCZ/GW
         CwMnKHhxdPfYwi9imMBBFqXdVJKy3zB1oDhR1D7umvC4pTe8Lcceob3k+s1d6U6DNehh
         5MXdFV0erAE+YSXEVrCyAsiSDGk6YeQs3zpDBoeECs0FlR1AC9GZnZKKihMUQbNoL0G7
         j1vKp7+JdPT5sxaohuINAAbVFk2dOmJf4Wb3SuV0IKVRE3UluCMxyrm0uSLKQTSzNDQ9
         /nBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rHzBpwJvTvHqQjiOwfvuYiOBLOQx3SSYI4e3E1a/UCY=;
        b=ServJwTe7INHFEpZr1eT3C3m6idKwIPixJofLVmsbBd8Mdjybfeyk2aBhsON1qavKq
         7Q4WFYvN7WIo7JbytmIvVs/Dapgl883qh82U0wqzYbk1vg+JPDHR5SZLkrQ7ElfZXXee
         i7R+1GKsJiB5Q2W0mW2tKls2L6zSaysCyRpdLmLHDZ8zHOhDiiDspjiPAqcProzaWeWl
         e9FfMXY1yI93TcqVINYeW+gny42J4RXDu+GhE+RoZUhQ3kBXP/5rOpd0Cq8V0ZczieV7
         nNH3zNyWjs34NmHec5gZwVw8BB2sypWxJ1NBfrrhxYufj5Z831Qa/Vml4blS7wQuxzHO
         BXUg==
X-Gm-Message-State: AOAM531kL4c8Xd4hKAJk5UjirPcICvxSDU5IwRglD5WqiUM68evPebPW
        ofK8Bo3zA0DHbn6QERfGC8QAgw2Cxrgbtg==
X-Google-Smtp-Source: ABdhPJysd5DihesdXMI5/3vRxfAp0KvNR7B78U3B5KG7DRHJntb4T5+w0HNHQ7DeOPUbTihsigZAzw==
X-Received: by 2002:a6b:7314:: with SMTP id e20mr15321646ioh.74.1619457595680;
        Mon, 26 Apr 2021 10:19:55 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id x13sm207297ilq.85.2021.04.26.10.19.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Apr 2021 10:19:55 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 05/13] sunrpc: add xprt id
Date:   Mon, 26 Apr 2021 13:19:39 -0400
Message-Id: <20210426171947.99233-6-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
References: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Dan Aloni <dan@kernelim.com>

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
index d81fe8b364d0..82294d06075c 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -185,6 +185,7 @@ enum xprt_transports {
 struct rpc_xprt {
 	struct kref		kref;		/* Reference count */
 	const struct rpc_xprt_ops *ops;		/* transport methods */
+	unsigned int		id;		/* transport id */
 
 	const struct rpc_timeout *timeout;	/* timeout parms */
 	struct sockaddr_storage	addr;		/* server address */
@@ -368,6 +369,7 @@ struct rpc_xprt *	xprt_alloc(struct net *net, size_t size,
 				unsigned int num_prealloc,
 				unsigned int max_req);
 void			xprt_free(struct rpc_xprt *);
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
index e5b5a960a69b..fd58a3a16add 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1722,6 +1722,30 @@ static void xprt_free_all_slots(struct rpc_xprt *xprt)
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
@@ -1734,6 +1758,7 @@ struct rpc_xprt *xprt_alloc(struct net *net, size_t size,
 	if (xprt == NULL)
 		goto out;
 
+	xprt_alloc_id(xprt);
 	xprt_init(xprt, net);
 
 	for (i = 0; i < num_prealloc; i++) {
@@ -1762,6 +1787,7 @@ void xprt_free(struct rpc_xprt *xprt)
 {
 	put_net(xprt->xprt_net);
 	xprt_free_all_slots(xprt);
+	xprt_free_id(xprt);
 	kfree_rcu(xprt, rcu);
 }
 EXPORT_SYMBOL_GPL(xprt_free);
-- 
2.27.0

