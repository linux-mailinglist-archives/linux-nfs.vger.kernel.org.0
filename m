Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B445375CE0
	for <lists+linux-nfs@lfdr.de>; Thu,  6 May 2021 23:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhEFVfm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 May 2021 17:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhEFVfl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 May 2021 17:35:41 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE28C061574
        for <linux-nfs@vger.kernel.org>; Thu,  6 May 2021 14:34:43 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id k25so6176919iob.6
        for <linux-nfs@vger.kernel.org>; Thu, 06 May 2021 14:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rHzBpwJvTvHqQjiOwfvuYiOBLOQx3SSYI4e3E1a/UCY=;
        b=k6JKtbaPGvTbui6liaRcU1Eya/6JWDcDodZlp04okyEAvprSdT2JU3+cl0Q3+2z9TF
         1zNF3gVIAaT79z2bUv21wR1PWOvKUoF3viwSF+tLvIOJj0x0Bc0LVJa8u5zXnCKGDxe2
         cLKx8smqXMJWinOGvnqv4ZzZ/ZCyn+mPHORD3aH+sEAaMZDrNd4UbSTKc6/x61zTYfo5
         mIiVYqeOq+EXZLqYANfsMP3qV+qt966xmMKAP4rmsMk9kfxzzEQI+ecDD1992+12gH33
         28nt9/08PiVSCtB8DMOIlGDTPgsB3Riygen86Q0d3hgYiy9S1cVWxBoIrspt1wWf6DYl
         Iw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rHzBpwJvTvHqQjiOwfvuYiOBLOQx3SSYI4e3E1a/UCY=;
        b=j0zdqqZrxclEv3U3IVUfilDLoCzzKAsxfQWVCFECN3I3AOt1YI1tsFkDEUdcvpQoCU
         vTyn9CSGWlRtx1z5oQpSKYsqsSyYxSBXBEoqgTYfNoQFB/IZtEX5qyVBdKBorRXHLwlT
         nvha6IOYxhmdK1Ur5q8sdmKvBsaou9rCXGk3hW6ow1TcVGDALt9byxvHCRpJwCQCkud3
         vxkzaD9waaNcNfpNkoUdqR7FnvMC/EfMeY/mAxxdf79zB13a3c7bs/iQ/UvFX7ZVQFgP
         Pn0fpUfSgGaO7w0QBz+NVVkAOaR30Nq0n5iSyWm9NlR+wd+f3d0evJrNeV7hhD/iE0ls
         NVeQ==
X-Gm-Message-State: AOAM530Jb5430wnH6zA0BYPrONsjYlUVhQ+bcWfN9+dMTJeoFDJsGsGn
        9jBdtm9E0i3O9HN9e7AF+SenjnWoRuBC8A==
X-Google-Smtp-Source: ABdhPJzGY1aRwq32vXACFEtQNXOpD/+wdroOz9ksA/XtTaFl1IRtQ9SYATJcGxhWI3dDPU/zuTqgvA==
X-Received: by 2002:a5e:a50c:: with SMTP id 12mr332241iog.206.1620336882773;
        Thu, 06 May 2021 14:34:42 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id 6sm1486019iog.36.2021.05.06.14.34.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 May 2021 14:34:42 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 04/12] sunrpc: add xprt id
Date:   Thu,  6 May 2021 17:34:27 -0400
Message-Id: <20210506213435.42457-5-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210506213435.42457-1-olga.kornievskaia@gmail.com>
References: <20210506213435.42457-1-olga.kornievskaia@gmail.com>
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

