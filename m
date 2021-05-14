Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714C5380B42
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 16:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhENOOq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 10:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbhENOOn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 May 2021 10:14:43 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BDAC061574
        for <linux-nfs@vger.kernel.org>; Fri, 14 May 2021 07:13:30 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id d24so18318977ios.2
        for <linux-nfs@vger.kernel.org>; Fri, 14 May 2021 07:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rHzBpwJvTvHqQjiOwfvuYiOBLOQx3SSYI4e3E1a/UCY=;
        b=PfgfC+u2GqvZaS3893Auvkj2pfyl/KrCQBVIHCbVCtYDJ63qpvOPa4kAmDD19Ndan7
         DGKPn9MsaYyVjd4dKD4ZPh16KBtL+fRdyPTh5u3cqWVSZ7QW8zjxv8lL7YNXLaRJjDOf
         IYD4bsrKyMhbpheM2RzOFhVKoOB/FRvBWQWZAJHIpiUanq1AhyIIoxTu5UU4Jz0JJLBA
         w6XAk4aqBDwgHtwoR3M2JLGqIBwZ3g4qgz5YnXbt69JxwzXvzUTHq0VlUoF1kHV7+AHe
         +ZVfH4isvwXmkM4k/hMY6J8X+9vJMNmd16+UeoFvQ8IaRdsUlOSf/o85l/saL6Axo9Sg
         TJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rHzBpwJvTvHqQjiOwfvuYiOBLOQx3SSYI4e3E1a/UCY=;
        b=D6JUWQHMg/cx6IDiKi91lVDiuCE/q12rqZIDaEgGiLOxU8qcXB31Udi6kiJmoZq3Gk
         XRjSCIxVuRNX9xzQD4cdZ9J/RBqk3wUNqC0f+xx3yFDfKvRtWiMFDrpAnoOcZ4tcwWTo
         +0j75pmLUthu5wAOZhZgHRYtgb1pPrJgHcZd25ycVOiGJLncPib7wKtE3xoNKl6y9jPd
         TMDlGkIZ7g9EEL4z9eiT8aXCohxp0FSwueyzT/+PGwW0jwMcjlyL4OaWGWamp76nGB2R
         jFprVGuYjeMjPGWqvXKCJdABIVEvt7MFIpMZ7BMcvYT46cPkzfyj13R8CCMkDuKtDl33
         tgAw==
X-Gm-Message-State: AOAM532vg3GfsLV9GX1cguDVvX6W5JxrNNpNBgnbJwPaUtoK1pUTt/NP
        B4v1OhKYpyvlkGVOHTG2hqoHsnH3NlKUYA==
X-Google-Smtp-Source: ABdhPJw0h/BgDBDOOWnqLvbK92Bj2Inmk8yZMT8qsw+zEvPFB7pqqByMf1wrMHnJQHnVjLO6AE/4rw==
X-Received: by 2002:a05:6602:164c:: with SMTP id y12mr32994064iow.78.1621001610331;
        Fri, 14 May 2021 07:13:30 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:a4f7:32c8:9c05:11a7])
        by smtp.gmail.com with ESMTPSA id b189sm2639263iof.48.2021.05.14.07.13.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 May 2021 07:13:29 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 04/12] sunrpc: add xprt id
Date:   Fri, 14 May 2021 10:13:15 -0400
Message-Id: <20210514141323.67922-5-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210514141323.67922-1-olga.kornievskaia@gmail.com>
References: <20210514141323.67922-1-olga.kornievskaia@gmail.com>
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

