Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE4E995102
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2019 00:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfHSWmx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 18:42:53 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41900 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfHSWmx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Aug 2019 18:42:53 -0400
Received: by mail-oi1-f194.google.com with SMTP id g7so2617046oia.8;
        Mon, 19 Aug 2019 15:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=HcRL7mEklA22xsf0ewjatYoR4UwmJXPgoFIVsj/Roas=;
        b=T7SF6NRw+HCY2YXOMlfH9CNtDwywRKUlYjoddyzJLrd5vGbPJxGchgFML1tccXtiAl
         ZyjpkFQLWlQx26d8wc/SXfrISRoiCQCPsyMpjXkdsbsFwfvhtrrBRxNTrrUb87J9RRh8
         /lV5XJJPygcQl591CvDCx4jWQ35yRYoA5oNM5qOw174EiJNon8JPi0X0wWpuO7qizIky
         qRhJZdPqPDlsNjTQYvM7Ov2PnHWRRU2HHSpMyFKWCOizjzI9KSBDrZA7uXpzI/7L9LtP
         Scq4NEoKsh+HCyP7crJdE4Up8h98M7b6xj39JCSzVi2VrdK72DXiuXviRFvVIbbc0oLl
         FHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=HcRL7mEklA22xsf0ewjatYoR4UwmJXPgoFIVsj/Roas=;
        b=X+RPh52jNtqqDKUwBDIYvNQHU7munKvASnBovTCkVYx+a3Ge2EQR/GdAID2UefDCss
         6wdVN69Pa/6IiFMgPpWkZ1Jq/HIEKPFBHdURHD/j2mXuHnxEa3PcllUrM27xZM4O4uJn
         39Dpv9E9V3JEFgAKTrZHFa/xd7mcJPVyrXSAVmRwxrQvX89RpRr5/NWOqI9ouvCzKfE2
         Et+wjvz6gUgU8PlftrxdH0Ps2yuQcX7WJL0c9//j6p18VP/7ANYKvG1JYiEWS0df1aZz
         pJlN/stMsvBOtGpw8jBDFM6YZCV6zqceCH3mXwiu/nEDtQVlBQyYhRp/KWMWr01720QY
         1YBg==
X-Gm-Message-State: APjAAAV3cj6/KUax8hc9krCJ4zKapx4FYc3K3okkekslpbTloESoZl0A
        UFmfqLOBi6Hn0NsjXQ5afO7Jt4U4
X-Google-Smtp-Source: APXvYqzHg+PjTHw9Hkwnki40OCPdCv0h7uimWK/ZbaUgJ0xaHM+kGi9SmW/izVce51ikTZtJFZDHwg==
X-Received: by 2002:aca:3c1:: with SMTP id 184mr15305455oid.113.1566254572472;
        Mon, 19 Aug 2019 15:42:52 -0700 (PDT)
Received: from seurat29.1015granger.net ([12.235.16.3])
        by smtp.gmail.com with ESMTPSA id w5sm4442399oic.36.2019.08.19.15.42.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 15:42:52 -0700 (PDT)
Subject: [PATCH v2 09/21] xprtrdma: Rename rpcrdma_buffer::rb_all
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Aug 2019 18:42:31 -0400
Message-ID: <156625453108.8161.5618620590594132378.stgit@seurat29.1015granger.net>
In-Reply-To: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
References: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: There are other "all" list heads. For code clarity
distinguish this one as for use only for MRs by renaming it.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c     |   26 ++++++++------------------
 net/sunrpc/xprtrdma/xprt_rdma.h |    2 +-
 2 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 3c275a7a4e4c..e004873cc4f0 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -944,8 +944,6 @@ rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt)
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
 	unsigned int count;
-	LIST_HEAD(free);
-	LIST_HEAD(all);
 
 	for (count = 0; count < ia->ri_max_segs; count++) {
 		struct rpcrdma_mr *mr;
@@ -963,15 +961,13 @@ rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt)
 
 		mr->mr_xprt = r_xprt;
 
-		list_add(&mr->mr_list, &free);
-		list_add(&mr->mr_all, &all);
+		spin_lock(&buf->rb_mrlock);
+		list_add(&mr->mr_list, &buf->rb_mrs);
+		list_add(&mr->mr_all, &buf->rb_all_mrs);
+		spin_unlock(&buf->rb_mrlock);
 	}
 
-	spin_lock(&buf->rb_mrlock);
-	list_splice(&free, &buf->rb_mrs);
-	list_splice(&all, &buf->rb_all);
 	r_xprt->rx_stats.mrs_allocated += count;
-	spin_unlock(&buf->rb_mrlock);
 	trace_xprtrdma_createmrs(r_xprt, count);
 }
 
@@ -1089,7 +1085,7 @@ int rpcrdma_buffer_create(struct rpcrdma_xprt *r_xprt)
 	spin_lock_init(&buf->rb_mrlock);
 	spin_lock_init(&buf->rb_lock);
 	INIT_LIST_HEAD(&buf->rb_mrs);
-	INIT_LIST_HEAD(&buf->rb_all);
+	INIT_LIST_HEAD(&buf->rb_all_mrs);
 	INIT_DELAYED_WORK(&buf->rb_refresh_worker,
 			  rpcrdma_mr_refresh_worker);
 
@@ -1156,24 +1152,18 @@ rpcrdma_mrs_destroy(struct rpcrdma_buffer *buf)
 
 	count = 0;
 	spin_lock(&buf->rb_mrlock);
-	while (!list_empty(&buf->rb_all)) {
-		mr = list_entry(buf->rb_all.next, struct rpcrdma_mr, mr_all);
+	while ((mr = list_first_entry_or_null(&buf->rb_all_mrs,
+					      struct rpcrdma_mr,
+					      mr_all)) != NULL) {
 		list_del(&mr->mr_all);
-
 		spin_unlock(&buf->rb_mrlock);
 
-		/* Ensure MW is not on any rl_registered list */
-		if (!list_empty(&mr->mr_list))
-			list_del(&mr->mr_list);
-
 		frwr_release_mr(mr);
 		count++;
 		spin_lock(&buf->rb_mrlock);
 	}
 	spin_unlock(&buf->rb_mrlock);
 	r_xprt->rx_stats.mrs_allocated = 0;
-
-	dprintk("RPC:       %s: released %u MRs\n", __func__, count);
 }
 
 /**
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index eaf6b907a76e..5aaa53b8ae12 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -360,7 +360,7 @@ rpcrdma_mr_pop(struct list_head *list)
 struct rpcrdma_buffer {
 	spinlock_t		rb_mrlock;	/* protect rb_mrs list */
 	struct list_head	rb_mrs;
-	struct list_head	rb_all;
+	struct list_head	rb_all_mrs;
 
 	unsigned long		rb_sc_head;
 	unsigned long		rb_sc_tail;

