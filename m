Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C978712FAE8
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2020 17:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgACQ4v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jan 2020 11:56:51 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41117 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgACQ4v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Jan 2020 11:56:51 -0500
Received: by mail-yw1-f68.google.com with SMTP id l22so18749225ywc.8;
        Fri, 03 Jan 2020 08:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=tCZVxSAnaTTodNkIrs6d0LpkpyWPH5ZzAla3zGsgHkU=;
        b=Q1HIICC46YeH3jzrPdeseIemA4f5HPZ/M8Hhmi/KkuaQdQPD23YGPM9AVHA5Ito+oE
         spJEXqgcHR183nu9j96DA20VPjkzYSJ1mI8rPenhvmnia+C5MMhxT+ebytB9hEP/4SoI
         b5d7+hMbyEmX1rEVMPiQ5ofKuFRZlTxQgd24RoLh8mhAMXQY04jpKOOcTZSx6nOCVFOg
         BibQqPkrsiBXEgzUoSrzQk2ZTCEjNThpMnwbkCbkK7KMJVMawCzG2e6YaAhyM3UnR4+0
         RcJlSCWWTswmDuyXo9c00SBG5+ZFaVll6L4eM/0M24sF9i/ImU618GBnWxnTPkN6sYBn
         18aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=tCZVxSAnaTTodNkIrs6d0LpkpyWPH5ZzAla3zGsgHkU=;
        b=oZdl/kOhNo/vKn02uFFJkBfwBGgTxLNv2MpjvXpNAUOIa9NRJ8WbgTdj1xl/LsU3Rm
         gWqIahkB3rlTtD64kFsCBjau43fFB7d/rEsH3iXZsVslklhnxTJo67ZOs0z0rcGfF1U8
         GDX8oNgLDdMtsemQZH7bCqgK5LhByG+U81EBYpS7dg2mJZe30Jzb6xkLfhmVcHzk4tA0
         Y3osRcdpwJfavN+fBpX+3PxGC2BYETEXfBe4ztrPyHG7J8MTFhqD5/tf+zYIcJk5vEak
         qdJGNu1oLBQlWrpckTLR5GvGr+NHLtEOa8vQ3a6/dlU0B7idWQCTWY2EXurDuIojp8FK
         HtDQ==
X-Gm-Message-State: APjAAAVp1Wob8OLcvLaqy52XeBnX1txvZv30j4LCRl0sdcQfSUhbKug6
        v7Kv6RHT+LQ9tyjGtRYVX0FGW47R
X-Google-Smtp-Source: APXvYqxdBkM0PZOHm01LJvEUjEuLei6FG97nU5xn8UC5bQTvPG0dUDaDo8oTBr38ta1An0MRMSbsbA==
X-Received: by 2002:a81:39d7:: with SMTP id g206mr66333288ywa.484.1578070609757;
        Fri, 03 Jan 2020 08:56:49 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g29sm23955290ywk.31.2020.01.03.08.56.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jan 2020 08:56:49 -0800 (PST)
Received: from morisot.1015granger.net (morisot.1015granger.net [192.168.1.67])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 003GumKD016395;
        Fri, 3 Jan 2020 16:56:48 GMT
Subject: [PATCH v1 5/9] xprtrdma: Refactor frwr_is_supported
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 03 Jan 2020 11:56:48 -0500
Message-ID: <157807060839.4606.7268843859672908333.stgit@morisot.1015granger.net>
In-Reply-To: <157807044515.4606.732915438702066797.stgit@morisot.1015granger.net>
References: <157807044515.4606.732915438702066797.stgit@morisot.1015granger.net>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor: Perform the "is supported" check in rpcrdma_ep_create()
instead of in rpcrdma_ia_open(). frwr_open() is where most of the
logic to query device attributes is already located.

The current code displays a redundant error message when the device
does not support FRWR. As an additional clean-up, this patch removes
the extra message.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  |   54 ++++++++++++++++-----------------------
 net/sunrpc/xprtrdma/verbs.c     |   14 +---------
 net/sunrpc/xprtrdma/xprt_rdma.h |    4 +--
 3 files changed, 25 insertions(+), 47 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index f31ff54bb266..b22a9d7f9c8d 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -50,28 +50,6 @@
 # define RPCDBG_FACILITY	RPCDBG_TRANS
 #endif
 
-/**
- * frwr_is_supported - Check if device supports FRWR
- * @device: interface adapter to check
- *
- * Returns true if device supports FRWR, otherwise false
- */
-bool frwr_is_supported(struct ib_device *device)
-{
-	struct ib_device_attr *attrs = &device->attrs;
-
-	if (!(attrs->device_cap_flags & IB_DEVICE_MEM_MGT_EXTENSIONS))
-		goto out_not_supported;
-	if (attrs->max_fast_reg_page_list_len == 0)
-		goto out_not_supported;
-	return true;
-
-out_not_supported:
-	pr_info("rpcrdma: 'frwr' mode is not supported by device %s\n",
-		device->name);
-	return false;
-}
-
 /**
  * frwr_release_mr - Destroy one MR
  * @mr: MR allocated by frwr_init_mr
@@ -163,13 +141,12 @@ int frwr_init_mr(struct rpcrdma_ia *ia, struct rpcrdma_mr *mr)
 }
 
 /**
- * frwr_open - Prepare an endpoint for use with FRWR
- * @ia: interface adapter this endpoint will use
- * @ep: endpoint to prepare
+ * frwr_query_device - Prepare a transport for use with FRWR
+ * @r_xprt: controlling transport instance
+ * @device: RDMA device to query
  *
  * On success, sets:
- *	ep->rep_attr.cap.max_send_wr
- *	ep->rep_attr.cap.max_recv_wr
+ *	ep->rep_attr
  *	ep->rep_max_requests
  *	ia->ri_max_rdma_segs
  *
@@ -177,14 +154,27 @@ int frwr_init_mr(struct rpcrdma_ia *ia, struct rpcrdma_mr *mr)
  *	ia->ri_max_frwr_depth
  *	ia->ri_mrtype
  *
- * On failure, a negative errno is returned.
+ * Return values:
+ *   On success, returns zero.
+ *   %-EINVAL - the device does not support FRWR memory registration
+ *   %-ENOMEM - the device is not sufficiently capable for NFS/RDMA
  */
-int frwr_open(struct rpcrdma_ia *ia, struct rpcrdma_ep *ep)
+int frwr_query_device(struct rpcrdma_xprt *r_xprt,
+		      const struct ib_device *device)
 {
-	struct ib_device_attr *attrs = &ia->ri_id->device->attrs;
+	const struct ib_device_attr *attrs = &device->attrs;
+	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
+	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
 	int max_qp_wr, depth, delta;
 	unsigned int max_sge;
 
+	if (!(attrs->device_cap_flags & IB_DEVICE_MEM_MGT_EXTENSIONS) ||
+	    attrs->max_fast_reg_page_list_len == 0) {
+		pr_err("rpcrdma: 'frwr' mode is not supported by device %s\n",
+		       device->name);
+		return -EINVAL;
+	}
+
 	max_sge = min_t(unsigned int, attrs->max_send_sge,
 			RPCRDMA_MAX_SEND_SGES);
 	if (max_sge < RPCRDMA_MIN_SEND_SGES) {
@@ -231,7 +221,7 @@ int frwr_open(struct rpcrdma_ia *ia, struct rpcrdma_ep *ep)
 		} while (delta > 0);
 	}
 
-	max_qp_wr = ia->ri_id->device->attrs.max_qp_wr;
+	max_qp_wr = attrs->max_qp_wr;
 	max_qp_wr -= RPCRDMA_BACKWARD_WRS;
 	max_qp_wr -= 1;
 	if (max_qp_wr < RPCRDMA_MIN_SLOT_TABLE)
@@ -242,7 +232,7 @@ int frwr_open(struct rpcrdma_ia *ia, struct rpcrdma_ep *ep)
 	if (ep->rep_attr.cap.max_send_wr > max_qp_wr) {
 		ep->rep_max_requests = max_qp_wr / depth;
 		if (!ep->rep_max_requests)
-			return -EINVAL;
+			return -ENOMEM;
 		ep->rep_attr.cap.max_send_wr = ep->rep_max_requests * depth;
 	}
 	ep->rep_attr.cap.max_send_wr += RPCRDMA_BACKWARD_WRS;
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 601a1bd56260..92a52934b622 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -367,18 +367,6 @@ rpcrdma_ia_open(struct rpcrdma_xprt *xprt)
 		goto out_err;
 	}
 
-	switch (xprt_rdma_memreg_strategy) {
-	case RPCRDMA_FRWR:
-		if (frwr_is_supported(ia->ri_id->device))
-			break;
-		/*FALLTHROUGH*/
-	default:
-		pr_err("rpcrdma: Device %s does not support memreg mode %d\n",
-		       ia->ri_id->device->name, xprt_rdma_memreg_strategy);
-		rc = -EINVAL;
-		goto out_err;
-	}
-
 	return 0;
 
 out_err:
@@ -478,7 +466,7 @@ int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 	ep->rep_inline_send = xprt_rdma_max_inline_write;
 	ep->rep_inline_recv = xprt_rdma_max_inline_read;
 
-	rc = frwr_open(ia, ep);
+	rc = frwr_query_device(r_xprt, ia->ri_id->device);
 	if (rc)
 		return rc;
 	r_xprt->rx_buf.rb_max_requests = cpu_to_be32(ep->rep_max_requests);
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index aac4cf959c3a..0aed1e98f2bf 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -534,9 +534,9 @@ rpcrdma_data_dir(bool writing)
 
 /* Memory registration calls xprtrdma/frwr_ops.c
  */
-bool frwr_is_supported(struct ib_device *device);
 void frwr_reset(struct rpcrdma_req *req);
-int frwr_open(struct rpcrdma_ia *ia, struct rpcrdma_ep *ep);
+int frwr_query_device(struct rpcrdma_xprt *r_xprt,
+		      const struct ib_device *device);
 int frwr_init_mr(struct rpcrdma_ia *ia, struct rpcrdma_mr *mr);
 void frwr_release_mr(struct rpcrdma_mr *mr);
 struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,


