Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738D631C0CE
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Feb 2021 18:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhBORlE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Feb 2021 12:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbhBORkt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Feb 2021 12:40:49 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EB7C0613D6
        for <linux-nfs@vger.kernel.org>; Mon, 15 Feb 2021 09:40:09 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id f14so12507031ejc.8
        for <linux-nfs@vger.kernel.org>; Mon, 15 Feb 2021 09:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ci5HE9rOCY9XgU05vBcOkC3fmwgmO/4Car2EJUGflaE=;
        b=Whrcwx/m6M/XyTOBe6voO6Sy9UTS8XptMOl/peoZIsmYQvhQdUlwjrGhMNKp+bDuLV
         XeIRVc7KcneHWkk6huqQ2/FqbdWlN5vjOGT8WavN22cDFR7fv8sgc5dAKijMy5R3lG1k
         oj3aRGYd+rqFsqd6woouUiBkjNSVTI5Q0UxbIRkZ9W09raBjceicL0z/tYIK7zQAdJzN
         E+z3Syx/2+U/OPYhbZE91uZJoE7ewJ/ft8D/loEO/4Fk73Jg//yCpGIHqsCD3gxPYmLN
         QeSOrTnW5Blr0xElYaNHBzqfCckIick7W6k5DKb6VE572Mm200NIHb2yz9Stdfrr3tIo
         jPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ci5HE9rOCY9XgU05vBcOkC3fmwgmO/4Car2EJUGflaE=;
        b=f18KvFZ1TwaeNo9dqKM9mGy96GYsWSJGQ4Ph+j+ngWkQiSqRlzsespFc+RGo1CXNm0
         bJlUWXrr5YHhQ7IwxSHMRFEDjvIyY7gk5UUrldBYj92Z1W6Gz37V2PuFDY1Qall3UD/z
         bx0dHVSqjX+gxsF4fAE3O4tP7jEBq7+qG9XYTtlhBszmK+kTbgJF5LtlVvWjCHW/7NQr
         +M8QlOtWBK6DUOPP/jEt0kwjWExHL+sFplxiOrZ0DnZFqfOwMO31lSc98ShZ3mRONaLE
         gRrtjuSBXrtCBgoh+7zNkXhBCCqqspnxhkO2K+4BVinB0mftmSkhWNpHorBqXcrx8doQ
         n+ew==
X-Gm-Message-State: AOAM531pALq2k46Coqe4Y0rvWG9YJphHy3CVk9dhAxoHe+1F8Sx8DtGl
        mdR6qXRh9fMwvKLvB1nigy/GfJkT+xs2Mg==
X-Google-Smtp-Source: ABdhPJx0NYFtDUiKadA/62OtgmDaKzc3HvN44ENEvWmJvj4MGGwe0XPfMDoOF2TThoSMrwYlyO2UMg==
X-Received: by 2002:a17:906:4a8a:: with SMTP id x10mr6807715eju.407.1613410807757;
        Mon, 15 Feb 2021 09:40:07 -0800 (PST)
Received: from jupiter.home.aloni.org ([77.124.84.167])
        by smtp.gmail.com with ESMTPSA id e11sm11257485ejz.94.2021.02.15.09.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 09:40:07 -0800 (PST)
From:   Dan Aloni <dan@kernelim.com>
To:     linux-nfs@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH v1 2/8] sunrpc: add xprt id
Date:   Mon, 15 Feb 2021 19:39:56 +0200
Message-Id: <20210215174002.2376333-3-dan@kernelim.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210215174002.2376333-1-dan@kernelim.com>
References: <20210215174002.2376333-1-dan@kernelim.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This adds a unique identifier for a sunrpc transport in sysfs, which is
similarly managed to the unique IDs of clients.

Signed-off-by: Dan Aloni <dan@kernelim.com>
---
 include/linux/sunrpc/xprt.h |  2 ++
 net/sunrpc/sunrpc_syms.c    |  1 +
 net/sunrpc/xprt.c           | 26 ++++++++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index d2e97ee802af..fbf57a87dc47 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -185,6 +185,7 @@ enum xprt_transports {
 struct rpc_xprt {
 	struct kref		kref;		/* Reference count */
 	const struct rpc_xprt_ops *ops;		/* transport methods */
+	unsigned int		id;		/* transport id */
 
 	const struct rpc_timeout *timeout;	/* timeout parms */
 	struct sockaddr_storage	addr;		/* server address */
@@ -367,6 +368,7 @@ struct rpc_xprt *	xprt_alloc(struct net *net, size_t size,
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
index 691ccf8049a4..e30acd1f0e31 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1717,6 +1717,30 @@ static void xprt_free_all_slots(struct rpc_xprt *xprt)
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
@@ -1729,6 +1753,7 @@ struct rpc_xprt *xprt_alloc(struct net *net, size_t size,
 	if (xprt == NULL)
 		goto out;
 
+	xprt_alloc_id(xprt);
 	xprt_init(xprt, net);
 
 	for (i = 0; i < num_prealloc; i++) {
@@ -1757,6 +1782,7 @@ void xprt_free(struct rpc_xprt *xprt)
 {
 	put_net(xprt->xprt_net);
 	xprt_free_all_slots(xprt);
+	xprt_free_id(xprt);
 	kfree_rcu(xprt, rcu);
 }
 EXPORT_SYMBOL_GPL(xprt_free);
-- 
2.26.2

