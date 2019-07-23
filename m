Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABC087200A
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2019 21:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfGWTWA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jul 2019 15:22:00 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:45481 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388860AbfGWTV7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Jul 2019 15:21:59 -0400
Received: by mail-vk1-f196.google.com with SMTP id e83so8896252vke.12;
        Tue, 23 Jul 2019 12:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Hd2S1laDEZJgCQAENJlCeGAX43irbfWRJ9ZNT4sWiiE=;
        b=k1QmKSIZLrCowXoyOe4khwTaSPvX8fHHqe4JmhnZ1k2pnlr0GLv6Edls1Ea0e0G5Bc
         xzx6dSYoeXbpihVgxJbh7rReM8uPz1MiosJkEAyyxMlAg1SamxRi5O7Sxx25tQ9VP0gK
         KV6n/ykx0WaOnsikaFOrbPny1Xx+aCEGEkTzp6qidP/fKion4ucCxpec14VWagQi1Opa
         m4ZNyqqHcgf+E/HkDxo4ni1Jx4xuQNsK+ADDIJjPoZM6d7uYIp4S2oYsI7kyvAS79miU
         55IA9JjtUKkDQSCxQkmCHEPR8KFcaCbv3vZSClasJ3XuK8tEi5odlyvH0/trHZTStycq
         V0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Hd2S1laDEZJgCQAENJlCeGAX43irbfWRJ9ZNT4sWiiE=;
        b=Kg97wagdGNz0cO/RWZmVW6+0Op9kcsQalZJBYt3qVF3pW+ANMxQFKWcze8/WgAUnBr
         IVHKYTLJAtGUtQiK6E6CC4tP6I7DZ17Z29K3ZlnoSIoJCjqNNMV60SYHfZSjr2QLOg+9
         yVn/ZyZVtbF3XEzQsC35xvq0EmRoA1xzJgQ3c3O3x1fbanQylp7uVu9AlQ+/QtwINns9
         hs01dCqzL6NRP+FRz6MpbjxDVY39zsxolVxFtqLrnbZQWumd7Mpl4k7N/QoS3TEXhQ6r
         lkNHnH8PWzGMyjGWzDZSTbKJCkJNIFBpnloxCFk6CDPg90ibQWcPhqh2VqLsdsYrKLuL
         xcgQ==
X-Gm-Message-State: APjAAAXSr4dmce/KCaYVS8KUF/ILHxnHdphnRro91gDBlEBXgXzgKuU8
        yMq3Qu3rp6Q9kRndCMykf2Ml5xYf1h85VQ==
X-Google-Smtp-Source: APXvYqyBPEhfHptlQkk5JTYSVWAc9JcxZDMV0hptX/btPofj+NmgLO5llefDP73Jq+/ozpzD5FspHA==
X-Received: by 2002:a1f:b552:: with SMTP id e79mr15331864vkf.90.1563909717930;
        Tue, 23 Jul 2019 12:21:57 -0700 (PDT)
Received: from seurat29.1015granger.net (dhcp-82c9.meeting.ietf.org. [31.133.130.201])
        by smtp.gmail.com with ESMTPSA id q29sm15438722vsl.3.2019.07.23.12.21.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 12:21:57 -0700 (PDT)
Subject: [PATCH v1 2/2] svcrdma: Use llist for managing cache of recv_ctxts
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 23 Jul 2019 15:21:37 -0400
Message-ID: <156390967695.6811.7979365338289864060.stgit@seurat29.1015granger.net>
In-Reply-To: <156390950940.6811.3316103129070572088.stgit@seurat29.1015granger.net>
References: <156390950940.6811.3316103129070572088.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Use a wait-free mechanism for managing the svc_rdma_recv_ctxts free
list. Subsequently, sc_recv_lock can be eliminated.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h          |    5 +++--
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |   24 ++++++++++--------------
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    3 +--
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index edb39900fe04..40f65888dd38 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -42,6 +42,7 @@
 
 #ifndef SVC_RDMA_H
 #define SVC_RDMA_H
+#include <linux/llist.h>
 #include <linux/sunrpc/xdr.h>
 #include <linux/sunrpc/svcsock.h>
 #include <linux/sunrpc/rpc_rdma.h>
@@ -107,8 +108,7 @@ struct svcxprt_rdma {
 	struct list_head     sc_read_complete_q;
 	struct work_struct   sc_work;
 
-	spinlock_t	     sc_recv_lock;
-	struct list_head     sc_recv_ctxts;
+	struct llist_head    sc_recv_ctxts;
 };
 /* sc_flags */
 #define RDMAXPRT_CONN_PENDING	3
@@ -125,6 +125,7 @@ enum {
 #define RPCSVC_MAXPAYLOAD_RDMA	RPCSVC_MAXPAYLOAD
 
 struct svc_rdma_recv_ctxt {
+	struct llist_node	rc_node;
 	struct list_head	rc_list;
 	struct ib_recv_wr	rc_recv_wr;
 	struct ib_cqe		rc_cqe;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 65e2fb9aac65..96bccd398469 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -172,9 +172,10 @@ static void svc_rdma_recv_ctxt_destroy(struct svcxprt_rdma *rdma,
 void svc_rdma_recv_ctxts_destroy(struct svcxprt_rdma *rdma)
 {
 	struct svc_rdma_recv_ctxt *ctxt;
+	struct llist_node *node;
 
-	while ((ctxt = svc_rdma_next_recv_ctxt(&rdma->sc_recv_ctxts))) {
-		list_del(&ctxt->rc_list);
+	while ((node = llist_del_first(&rdma->sc_recv_ctxts))) {
+		ctxt = llist_entry(node, struct svc_rdma_recv_ctxt, rc_node);
 		svc_rdma_recv_ctxt_destroy(rdma, ctxt);
 	}
 }
@@ -183,21 +184,18 @@ static struct svc_rdma_recv_ctxt *
 svc_rdma_recv_ctxt_get(struct svcxprt_rdma *rdma)
 {
 	struct svc_rdma_recv_ctxt *ctxt;
+	struct llist_node *node;
 
-	spin_lock(&rdma->sc_recv_lock);
-	ctxt = svc_rdma_next_recv_ctxt(&rdma->sc_recv_ctxts);
-	if (!ctxt)
+	node = llist_del_first(&rdma->sc_recv_ctxts);
+	if (!node)
 		goto out_empty;
-	list_del(&ctxt->rc_list);
-	spin_unlock(&rdma->sc_recv_lock);
+	ctxt = llist_entry(node, struct svc_rdma_recv_ctxt, rc_node);
 
 out:
 	ctxt->rc_page_count = 0;
 	return ctxt;
 
 out_empty:
-	spin_unlock(&rdma->sc_recv_lock);
-
 	ctxt = svc_rdma_recv_ctxt_alloc(rdma);
 	if (!ctxt)
 		return NULL;
@@ -218,11 +216,9 @@ void svc_rdma_recv_ctxt_put(struct svcxprt_rdma *rdma,
 	for (i = 0; i < ctxt->rc_page_count; i++)
 		put_page(ctxt->rc_pages[i]);
 
-	if (!ctxt->rc_temp) {
-		spin_lock(&rdma->sc_recv_lock);
-		list_add(&ctxt->rc_list, &rdma->sc_recv_ctxts);
-		spin_unlock(&rdma->sc_recv_lock);
-	} else
+	if (!ctxt->rc_temp)
+		llist_add(&ctxt->rc_node, &rdma->sc_recv_ctxts);
+	else
 		svc_rdma_recv_ctxt_destroy(rdma, ctxt);
 }
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index f8e48d6824a0..935a4a23dff7 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -140,14 +140,13 @@ static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
 	INIT_LIST_HEAD(&cma_xprt->sc_rq_dto_q);
 	INIT_LIST_HEAD(&cma_xprt->sc_read_complete_q);
 	INIT_LIST_HEAD(&cma_xprt->sc_send_ctxts);
-	INIT_LIST_HEAD(&cma_xprt->sc_recv_ctxts);
+	init_llist_head(&cma_xprt->sc_recv_ctxts);
 	INIT_LIST_HEAD(&cma_xprt->sc_rw_ctxts);
 	init_waitqueue_head(&cma_xprt->sc_send_wait);
 
 	spin_lock_init(&cma_xprt->sc_lock);
 	spin_lock_init(&cma_xprt->sc_rq_dto_lock);
 	spin_lock_init(&cma_xprt->sc_send_lock);
-	spin_lock_init(&cma_xprt->sc_recv_lock);
 	spin_lock_init(&cma_xprt->sc_rw_ctxt_lock);
 
 	/*

