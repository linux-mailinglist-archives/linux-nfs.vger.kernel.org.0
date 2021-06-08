Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234333A04D6
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 22:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhFHUB0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 16:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbhFHUB0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 16:01:26 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4D0C061574
        for <linux-nfs@vger.kernel.org>; Tue,  8 Jun 2021 12:59:32 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id d196so16338052qkg.12
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jun 2021 12:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9LDwEwPQbhwjs1lrw0RcLVlG/gcKNLc/Zyhh3epgGAM=;
        b=mvY/PMb3Zjny6Bm1fZP8CJRsQ9lAazaeOTnyJbMpMvxNWb2EtT47OHCsj0qA7T/B37
         ZfRloPejFYpK54Fxf/0hhggkyssCT8Su9ZCaGimVO8IX2H2/Vlegs+04wgcIUF5v++h0
         lUR/ssQw510fz2ns/b/KnIYDv0ccQrKazaJxytDFZ1O2Po23McWbD3nULWhZM3EmDuNl
         Rgz78SyKoso4dFbIaZhcZOZjQ/dSE4LdpJsf1ZV3qhjbYtTzLTbM86yIlMwu9Z/9fpBI
         5L1gXS/8m8CgAXUUVDlwU3HjiGUKNrd52zz5u4Y/9RTARDE/DJJQ8gDygdwFh4F089OF
         /HXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9LDwEwPQbhwjs1lrw0RcLVlG/gcKNLc/Zyhh3epgGAM=;
        b=KLYZf7oAJDb/rHNSJbYamKRiVHeXRpfumU5WaBieVLArjoQeWF7REXQ9FhaRsuT6Gr
         IBtnWvw8KmjGh0hsyVXHFXKLL/TLbdcXXJ7WImcW3Fcm/hhRizrG1ML2xiBSqopHdWKO
         4+Lmf/kqdJu+4wuo2oszp7b8FRJI8HyziWocskdOVyf8L4/ZAl2aNktsasxMmlWxUlkY
         fFcWCFIbyX8bulLKvzpTxNx49opeFeB8kx/O1xfB5gI154A66dukNQK0DMlo/5h1LmtQ
         WlQHelcy5ewIPVrMl30n082Kc1/Q3N13qVTwlLeiub2YpX4JEeZ4sIg/h7eWnLDerQY4
         lZUg==
X-Gm-Message-State: AOAM531LmvLikt1SySPOhCWm5lisvMKEnMQKycqQrD2xGHoHeEdpz6a4
        x9EO1e63hRG+2F2EgfY0ZOE=
X-Google-Smtp-Source: ABdhPJzUETEttIRWw/XF4hvv/FhtvrY5cNS5ja3JJbq7Av5hqwRc8mwBy0YpoWXgkaITd8lEX+V3VQ==
X-Received: by 2002:a05:620a:290b:: with SMTP id m11mr15765475qkp.455.1623182371832;
        Tue, 08 Jun 2021 12:59:31 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-25.netapp.com. [216.240.30.25])
        by smtp.gmail.com with ESMTPSA id j127sm12952765qke.90.2021.06.08.12.59.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 12:59:31 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 04/13] sunrpc: add xprt id
Date:   Tue,  8 Jun 2021 15:59:13 -0400
Message-Id: <20210608195922.88655-5-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210608195922.88655-1-olga.kornievskaia@gmail.com>
References: <20210608195922.88655-1-olga.kornievskaia@gmail.com>
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

