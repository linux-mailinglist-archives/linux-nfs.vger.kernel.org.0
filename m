Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 198CF1689AC
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2020 23:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgBUWAU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Feb 2020 17:00:20 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:40798 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgBUWAU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Feb 2020 17:00:20 -0500
Received: by mail-yb1-f195.google.com with SMTP id f130so1865819ybc.7;
        Fri, 21 Feb 2020 14:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=1X6vImbr9w24l3C435df4gRldd0qbJ/tqpv2qdY22yI=;
        b=najHyUXyrzAuvdoq3GvO/P53/fqB/aZWOzPaIwfH/VpklfJ9LSrnK6BmEcE9AU9Dbx
         qrhH4zBdtLCdWmr9WblbitlS+SO7dKHGKqUx+F7YMWyLUYjhSER79LbNr/Y+xoYSvwMt
         OfoHwJwSw6I38Gk5TqgHvnr3lMsdOnk1cxjC2yFMbOZvscTQe1JYQ2qlBN87zb47QDpw
         t7BA8iFPbNcH/vWi0VACPgkBA85nfQmU+1yi+6AoVCvPM3GRtSAFyGX8LElDgD1gVjuQ
         gyoRENXELr/p4LMgFMy60pRJYKl5WL/o/cvyTQJYsSEP0aWbgN4L3NMG59buBshz+5Ww
         jgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=1X6vImbr9w24l3C435df4gRldd0qbJ/tqpv2qdY22yI=;
        b=FXrHeFAy2c1vUmaI9QRAbNpcfcFVolq21r+Coz9MmcVaqB5sxLcWmRUVYSFC9PuSuR
         aLl7cYP717iIuGIoupjrjdYfwd3HtvSmKY7Q/8bbj0YAX3zIOACIdRJDXh/S5Xjf92Ft
         /8dNNullkwhvNNFjNSi3jV/vHwFNfSIKHFdjWrn/aDW8Q+5SKgw4zokk9acWZK64gW3u
         x3AmN4WQ/WL9h/DjntCPYy6yoJW4vmWnkigNnc9GfQFdS48Ujl8ZqPDAhRM16A0pXdOi
         5yXVANr5pOBBU6efdS11vSIXdo2U89ImYWL2eyVR5Nt0MjFTT9LdwHoml4Vfqh4A9Feq
         UxyA==
X-Gm-Message-State: APjAAAUSZrjdieaMy+eandL4N0G0HYqzzZbvFTR296g3ZtehTWxzraUg
        yg3pDvhki5oEhLTuEVYBjVIOS3WU
X-Google-Smtp-Source: APXvYqzcJiESDix++eTEA5Njjav1htpmQuvdTLPzKKnSK9Hrk4NuFvsjD5uSPMlnIFsgePgl1oAwFg==
X-Received: by 2002:a5b:7c6:: with SMTP id t6mr7954251ybq.287.1582322419019;
        Fri, 21 Feb 2020 14:00:19 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id m203sm1812920ywc.10.2020.02.21.14.00.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2020 14:00:18 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 01LM0Huw018981;
        Fri, 21 Feb 2020 22:00:17 GMT
Subject: [PATCH v1 02/11] xprtrdma: Refactor frwr_init_mr()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 21 Feb 2020 17:00:17 -0500
Message-ID: <20200221220017.2072.81820.stgit@manet.1015granger.net>
In-Reply-To: <20200221214906.2072.32572.stgit@manet.1015granger.net>
References: <20200221214906.2072.32572.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: prepare for combining the rpcrdma_ia and rpcrdma_ep
structures. Take the opportunity to rename the function to be
consistent with the "subsystem _ object _ verb" naming scheme.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  |   10 ++++++----
 net/sunrpc/xprtrdma/verbs.c     |    4 +---
 net/sunrpc/xprtrdma/xprt_rdma.h |    2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 125297c9aa3e..f161be259997 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -52,7 +52,7 @@
 
 /**
  * frwr_release_mr - Destroy one MR
- * @mr: MR allocated by frwr_init_mr
+ * @mr: MR allocated by frwr_mr_init
  *
  */
 void frwr_release_mr(struct rpcrdma_mr *mr)
@@ -106,15 +106,16 @@ void frwr_reset(struct rpcrdma_req *req)
 }
 
 /**
- * frwr_init_mr - Initialize one MR
- * @ia: interface adapter
+ * frwr_mr_init - Initialize one MR
+ * @r_xprt: controlling transport instance
  * @mr: generic MR to prepare for FRWR
  *
  * Returns zero if successful. Otherwise a negative errno
  * is returned.
  */
-int frwr_init_mr(struct rpcrdma_ia *ia, struct rpcrdma_mr *mr)
+int frwr_mr_init(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr)
 {
+	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
 	unsigned int depth = ia->ri_max_frwr_depth;
 	struct scatterlist *sg;
 	struct ib_mr *frmr;
@@ -128,6 +129,7 @@ int frwr_init_mr(struct rpcrdma_ia *ia, struct rpcrdma_mr *mr)
 	if (!sg)
 		goto out_list_err;
 
+	mr->mr_xprt = r_xprt;
 	mr->frwr.fr_mr = frmr;
 	mr->mr_dir = DMA_NONE;
 	INIT_LIST_HEAD(&mr->mr_list);
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 042e6cc4f767..02ce3d548825 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -896,14 +896,12 @@ static void rpcrdma_sendctx_put_locked(struct rpcrdma_xprt *r_xprt,
 		if (!mr)
 			break;
 
-		rc = frwr_init_mr(ia, mr);
+		rc = frwr_mr_init(r_xprt, mr);
 		if (rc) {
 			kfree(mr);
 			break;
 		}
 
-		mr->mr_xprt = r_xprt;
-
 		spin_lock(&buf->rb_lock);
 		rpcrdma_mr_push(mr, &buf->rb_mrs);
 		list_add(&mr->mr_all, &buf->rb_all_mrs);
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 9a536319557e..9e3e9a82cb9f 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -536,7 +536,7 @@ static inline bool rpcrdma_regbuf_dma_map(struct rpcrdma_xprt *r_xprt,
 void frwr_reset(struct rpcrdma_req *req);
 int frwr_query_device(struct rpcrdma_xprt *r_xprt,
 		      const struct ib_device *device);
-int frwr_init_mr(struct rpcrdma_ia *ia, struct rpcrdma_mr *mr);
+int frwr_mr_init(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr);
 void frwr_release_mr(struct rpcrdma_mr *mr);
 struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 				struct rpcrdma_mr_seg *seg,

