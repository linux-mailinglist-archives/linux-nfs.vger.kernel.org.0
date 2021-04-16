Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FFC361861
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Apr 2021 05:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbhDPDw7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Apr 2021 23:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238296AbhDPDw7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Apr 2021 23:52:59 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A094C061574
        for <linux-nfs@vger.kernel.org>; Thu, 15 Apr 2021 20:52:35 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 18so10745975qkl.3
        for <linux-nfs@vger.kernel.org>; Thu, 15 Apr 2021 20:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M01+BF9kyavBPPm+eb+RPWIBekFS3wzqz8TxPsbYnYQ=;
        b=TT3arrh6VuQ4U+I36w+YGJonnS5UAloRUkNmsKxH7eq47QLo4ZZAqPF9OsM8S/cJwi
         zTRc9X/o7llYIbC69eOH67Xsevm2tZTqyF3CyIb4szEiCydEMsP3E1KF6dTWpS07dVBl
         V4YXmgAXFIpInl3YLPGvhFn/V7bf9fGrAFPPgXjnxXlyhTyH5EnM7w4bjOGEKxKVyyYc
         TfukHCBryCHTy5MTG0lxlc49GRo29efzE7zX9C/TUfvHgkbM/IOZJVuMbI3mghJzo7ji
         pJk7D3d+IBlRlmo0HX5lL05eymBiAS6bcZTu8CgO0ZpfOxqeQhvS6XzzaI0mfo46TbGm
         Za8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M01+BF9kyavBPPm+eb+RPWIBekFS3wzqz8TxPsbYnYQ=;
        b=ZudGSbzp6I41tEXK+8Wa5mBRd68zlFlohCJo4Kri36mcX6BXVXloLkj/PqEgtXKhni
         mdPUnpD7e28zFqjUf/VFAVpR5clUAGgTer8NR8yzZKlQODUwRCJyk3wuEK1KZDvgi9wU
         s4rIIrKpsCVYloxq2sJ8iJdxIigmesLKqMXWW16Z2EyagD+a5ja5cFIbW5mY6LueYORM
         lWrIi3t73DXXJiFXTmMng0/rnO1E49txBuPDBTbHK1NoCZmZOgSCjhr/IZ2r7w+sZYvP
         Y332DsjZs2qAbOF9j85C9argfcq2HbD3G7Rs2VJu+Jc8P1ujDHj57vZzUnS2mhiw0BfF
         hsjQ==
X-Gm-Message-State: AOAM531uHXaHHVSvk5VZiNandAgaDqmZimc/jcI6bYLNlhq7Yt3FBJAS
        bvEEiXQS6lTuUT1goH3NjiGTn/xn/Us=
X-Google-Smtp-Source: ABdhPJzd63sCPQmlhwBS/C+r3b/XE2ga83joMFlLMi1FzKjNWn2vA9Kp1dp8P9fMsyFeBj484mn59A==
X-Received: by 2002:a37:74b:: with SMTP id 72mr6805903qkh.252.1618545154641;
        Thu, 15 Apr 2021 20:52:34 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-25.netapp.com. [216.240.30.25])
        by smtp.gmail.com with ESMTPSA id x82sm3500913qkb.0.2021.04.15.20.52.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 20:52:34 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 05/13] sunrpc: add xprt id
Date:   Thu, 15 Apr 2021 23:52:18 -0400
Message-Id: <20210416035226.53588-6-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210416035226.53588-1-olga.kornievskaia@gmail.com>
References: <20210416035226.53588-1-olga.kornievskaia@gmail.com>
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

