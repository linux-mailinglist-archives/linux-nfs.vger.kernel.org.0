Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A6E3768A9
	for <lists+linux-nfs@lfdr.de>; Fri,  7 May 2021 18:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238110AbhEGQ02 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 May 2021 12:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238082AbhEGQ0Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 May 2021 12:26:24 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF14C061574
        for <linux-nfs@vger.kernel.org>; Fri,  7 May 2021 09:25:24 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id k25so8465159iob.6
        for <linux-nfs@vger.kernel.org>; Fri, 07 May 2021 09:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rHzBpwJvTvHqQjiOwfvuYiOBLOQx3SSYI4e3E1a/UCY=;
        b=dh6VobQVIGt5OWcU3zZhU+dLiR8W5+udYe841DiBvdBkJ+sr56FyI3tvUstMtHhoAq
         sbdwb4hf7Ip4T51tkfpinFTODv8tmABj/AJm8wdbBOAHVD28W4vCAV/e5pnAv49w8bmf
         /DwRCLdTUZlWsJn5XbuDV7Yvtar05B33qXKQWr1ahbcPHHNKaEDZbJnvNR5V4IgYCfBx
         WngxfVEQ0TP8mmP6+yDAR6OP4pq8XofLGrGCkwcU5eBnVtSLjl0p8xfu5zjUDnNeGu1V
         ASrLVGtHSBN6EKKTwLEMCbaBwcAcApT8Imrpwn7sMFkpy4mTg0DnA5WEypgttzKqh5Jd
         D5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rHzBpwJvTvHqQjiOwfvuYiOBLOQx3SSYI4e3E1a/UCY=;
        b=lto8AemqMxF8TR0ugItlt+wtAovvd+nuiB1XKqJLKhgk9LeJwQCS5z+lx4KBEX9Yjj
         U1gwb5kln++8dhfLOnUMqSHaHQwQ1sOjkSFmSmv4gFoJULT2vt6nZQi59zS7JJ4TLOAb
         sHMIo7k6ZFYwViiTT6M6DoYEuX8Zw+pk30obVJwhAYsoIhF8EUpZTwuaB5eLwCTx1HKs
         6T7eBTRKasZPsZBpDYj8UD69wkVYdlGQDqyeL35kcsNbiR+1Pvyj6HvTrEWxBKLzaJsI
         2japcy11mV3hRbanAy41pLGwIrAO3JlUbRoNfH3kEskwTfHAZlw3JirSbkZ4w6PYkuY5
         F56g==
X-Gm-Message-State: AOAM533zi0wJHXOgECug0GnEiwdQhxDcm3xNiXHPuNGVlL5mpKELIIqO
        J3u5F4ou32GmzrA8ZeuLFlcRwJga5HbMnQ==
X-Google-Smtp-Source: ABdhPJy1zoT+vDOaZYB1LCyvqKE5asF7HwTZBAksiGj/D0RNKwq0yB5mKVhNkJo2KRnBL6G8exVS8w==
X-Received: by 2002:a6b:ed11:: with SMTP id n17mr7954596iog.171.1620404724416;
        Fri, 07 May 2021 09:25:24 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id v2sm2451000ioe.22.2021.05.07.09.25.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 May 2021 09:25:24 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 04/12] sunrpc: add xprt id
Date:   Fri,  7 May 2021 12:25:10 -0400
Message-Id: <20210507162518.51520-5-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210507162518.51520-1-olga.kornievskaia@gmail.com>
References: <20210507162518.51520-1-olga.kornievskaia@gmail.com>
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

