Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA33036E0F9
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Apr 2021 23:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhD1VdB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Apr 2021 17:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbhD1VdA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Apr 2021 17:33:00 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D30C06138F
        for <linux-nfs@vger.kernel.org>; Wed, 28 Apr 2021 14:32:13 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id o5so65212943qkb.0
        for <linux-nfs@vger.kernel.org>; Wed, 28 Apr 2021 14:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rHzBpwJvTvHqQjiOwfvuYiOBLOQx3SSYI4e3E1a/UCY=;
        b=ND2moWvSvAWWsGoZouNPmy1LPx+UILvry52kHLq3RJlFEIjZrQES/k0Cd0OQtdb6Rp
         syfhelC7KxhJ+qWfp9VmU2FCaJmBL3562riJGXV66Jc1+TYvvvcy9ZhkfI0oJSZ5Q9Dl
         KzPR/12c2kN1WQocAH40OXtkk3UxgnrhlTLV1luofM1qcbxMBLxgwRc+hdN2FvOcDFj5
         B00/txrYMKXlQXPHY2XgSdMel/6mG1dHl/QvNqdCSH79+PS9NtvrK0HyxOx5k5lP3rvq
         vMKX2Yrg09arV9Jaf+5QW2O+0FIFSMn5lJpAezcK2VOaHmY5qxfQGrR+T0/hWOm++vX0
         Nnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rHzBpwJvTvHqQjiOwfvuYiOBLOQx3SSYI4e3E1a/UCY=;
        b=B+zvSBF4usDJ53PR9SdGFKgEkE9iTjqDiNIx2C8EmCfvT2u/zDK4hsO/CLtLuURBIp
         NaDxKxMW4/V5Ghd/Uw2RsU4SYaX/Ex64vnphH+vz2UWFlwFsCm5S+IKlRn1AcqGIAvrY
         Tk0Zbd1KtKVSUFhlCFGtToTKwmDraYrJ18ImOok1IyVpXUeJtQcUx8493MGNV41L/gVG
         HD858YmbqZ9vpMqJNcja9rHzEBdV1EfvKtML89m9b4hg8XUZab3AvBno4R+FLmrZnXFM
         zQJ/q95nw33MRigVpqoFU0Pyt8glfH79JdiE27i0T7D9lfgQmiKruHQ7GvNVKtsSIeBG
         n+LA==
X-Gm-Message-State: AOAM532QpRrfI1SOFsNFotgH1K4D/fMMqXD4cKcoia1LX8vcDsnZTTh9
        lShXM4ApE2GKKiapEKibRDQ=
X-Google-Smtp-Source: ABdhPJzjVvbRNXB9dd9yHTA5kB2Q+Rv6kbjFS5ubXmo7iZPpAOiRL8zTC7RtmSoLTP2iF95pr5XpEg==
X-Received: by 2002:a37:7d83:: with SMTP id y125mr31850841qkc.263.1619645532725;
        Wed, 28 Apr 2021 14:32:12 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-11.netapp.com. [216.240.30.11])
        by smtp.gmail.com with ESMTPSA id v3sm710269qkb.124.2021.04.28.14.32.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Apr 2021 14:32:12 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 05/13] sunrpc: add xprt id
Date:   Wed, 28 Apr 2021 17:31:55 -0400
Message-Id: <20210428213203.40059-6-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210428213203.40059-1-olga.kornievskaia@gmail.com>
References: <20210428213203.40059-1-olga.kornievskaia@gmail.com>
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

