Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF31360001
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Apr 2021 04:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhDOC2f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 22:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhDOC2d (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Apr 2021 22:28:33 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F95C06175F
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 19:28:11 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id v3so1241136ion.12
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 19:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M01+BF9kyavBPPm+eb+RPWIBekFS3wzqz8TxPsbYnYQ=;
        b=rQPi3+WWnv0Zw4xYhkyotmM0+jFNhNx5eOM3zt4uEJcdQAZgNVGlhT4D6ov4He5m0Y
         anri2EW1elz1lZiID7GkUYbCl5i86nZWLndqWyHBd+XK2fyOfloSfg1BVkQ1DgrG3FAu
         meCnDEr6xS3+RjFrQKKoc+KWBTTTyDIUwUkDhfUjW2AMce8TK7xa6FYP9D6eqlLHaXsq
         iMDL1ST02dgXV4fFhAfnPCHAFG2j7PLaOU5EXOc/ogPS66w4kv6L6dBViw+NoeKJkTWh
         yxrXv7tUfZJAFSqazSeDLS6v7W2J8XL2g2OdurJNhI1Jv7lPNSsEXR0P+WiTNWKNdHTI
         CApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M01+BF9kyavBPPm+eb+RPWIBekFS3wzqz8TxPsbYnYQ=;
        b=ZFBleNKuxzruibDbejpPtBFqrMv5ZZIZpWiKLvQq2wcIdWOFOWL6YV9d1eS78xXRvF
         Gwwk4cI2Zb3+/kYeS19/qfvfWTo8QJBJvCZHd4OuzESpSMX/VIT5CHGjsgFNmsx4jXkB
         0y7i6qrJX7uAY9/2my923cSSz1yZeJf659PXT+dn0haVxkhoU42GCTVwgCHwCme2My2d
         m2xlldV3UA4ogeZbm8rUk1HzpKLKT6TBB+vBlDKr82gaRSDQYOIBSn9ZZ/QmiZ7NRSIN
         MNUIGNb9IsTDTPsVpYYuDWUU4lZgqhkWu+16W28vm8kuSmQKCp3mQDp8eTt4+V3WLQtI
         8sDA==
X-Gm-Message-State: AOAM530zO8suATnpFbhHXI2yOLpQo1Xztzx3s8zGHxODf5DsZWPdJC2X
        l1vF7XCt19kktOWFJGcCifWyWRKa5hc=
X-Google-Smtp-Source: ABdhPJz3tFz0/wHQrwTjzeDRYNF5CV+oXsSV/on7WDxw2JmfARuWVuFshNh083NyMZllrZi6AcE1Qw==
X-Received: by 2002:a05:6602:180c:: with SMTP id t12mr827795ioh.109.1618453691024;
        Wed, 14 Apr 2021 19:28:11 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id s11sm608917ilh.47.2021.04.14.19.28.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Apr 2021 19:28:10 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 05/13] sunrpc: add xprt id
Date:   Wed, 14 Apr 2021 22:27:54 -0400
Message-Id: <20210415022802.31692-6-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210415022802.31692-1-olga.kornievskaia@gmail.com>
References: <20210415022802.31692-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Dan Aloni <dan@kernelim.com>

This adds a unique identifier for a sunrpc transport in sysfs, which is
similarly managed to the unique IDs of clients.

Signed-off-by: Dan Aloni <dan@kernelim.com>
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
index a853f75d4968..6181792aec23 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1719,6 +1719,30 @@ static void xprt_free_all_slots(struct rpc_xprt *xprt)
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
@@ -1731,6 +1755,7 @@ struct rpc_xprt *xprt_alloc(struct net *net, size_t size,
 	if (xprt == NULL)
 		goto out;
 
+	xprt_alloc_id(xprt);
 	xprt_init(xprt, net);
 
 	for (i = 0; i < num_prealloc; i++) {
@@ -1759,6 +1784,7 @@ void xprt_free(struct rpc_xprt *xprt)
 {
 	put_net(xprt->xprt_net);
 	xprt_free_all_slots(xprt);
+	xprt_free_id(xprt);
 	kfree_rcu(xprt, rcu);
 }
 EXPORT_SYMBOL_GPL(xprt_free);
-- 
2.27.0

