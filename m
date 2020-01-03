Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9836812FAE0
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2020 17:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgACQ4a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jan 2020 11:56:30 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37061 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgACQ43 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Jan 2020 11:56:29 -0500
Received: by mail-yw1-f67.google.com with SMTP id z7so18752752ywd.4;
        Fri, 03 Jan 2020 08:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=BnRDLTtdlUh8mqBrpT4Rt9IaTfUaFir1pql1uwAgVUw=;
        b=lZUVS9SHDR73AWg2s1Ne7zXRaAlgMiXaH46nB2d8IMC2s5B7UwummjEm7ISk3Y94Ae
         a8l5XsRuYp5bH3aJPj78Gh/EaDHaJ3Nzm3C7BHfPwWJ0DNDYPLZS8Zqk6hDff+M8UYRO
         LMC/0z5Na2KY0to27TnnTG8mtkHdd7ByOwf0iVPVZFp6YkZAa7CrF1qiWHBiKAetu132
         u6tHnBWctRtWzw+9LP2lALNVSLsf9Z8yLb7ziiqgwI3Ks7ZKqRaZU3XvCh0jd+4AuGU+
         KXPRTSrnwvH4ME2nEz0SQbg0ZxdFynS47Hsn/pVebckpeDdhWs8H+1ullOi7P8fqsN+f
         TmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=BnRDLTtdlUh8mqBrpT4Rt9IaTfUaFir1pql1uwAgVUw=;
        b=iChRT7tPrLZ/1JpaXRiWoM6lED75dvllA73Ht4Q1F512dWK/r4kafVELmSC2MITQuZ
         CKn4ttyE77cJ7n91cYIA900ofGl8dGwzxi3pRSz4H/lOLlEiri0fO3m+KCK8vF1aZN4B
         dSuQCArOGbuM7Mr/gYXAYSZeyMS55R3jX1hVy9Gvn/kjCmep/LGfAORYvbp9I/H8aryk
         L74Z/kJkUTTD9bUTNucF+mU/twQIktSBIU9sZNFu1oGj1rx2SZhDG0VIf+9++ychPRHC
         In/Z/ZujFQXc5GCIgNfaIXX14Ss3jmGiDsnfS96sMIS3mUdJ7SAMM1ph3anc7eVpna4W
         wC7w==
X-Gm-Message-State: APjAAAX9+BL7I7hHXaJVOu59mdfdRQOeI9kIpcGNVXAQcsWgXu/65ONM
        bIzSAI9i2ObPLeBGUEJD2RR0ivAG
X-Google-Smtp-Source: APXvYqzXr9NrpPBA7CmCZD2Mv2mb1ZoxjVo8hmcQvOtYLyYRvixiXRGJuzUEm5wO5zItgi2UfmkvTg==
X-Received: by 2002:a0d:fb46:: with SMTP id l67mr34564580ywf.38.1578070588429;
        Fri, 03 Jan 2020 08:56:28 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id f138sm24511068ywb.99.2020.01.03.08.56.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jan 2020 08:56:28 -0800 (PST)
Received: from morisot.1015granger.net (morisot.1015granger.net [192.168.1.67])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 003GuR4m016383;
        Fri, 3 Jan 2020 16:56:27 GMT
Subject: [PATCH v1 1/9] xprtrdma: Eliminate ri_max_send_sges
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 03 Jan 2020 11:56:27 -0500
Message-ID: <157807058713.4606.5667131330030980818.stgit@morisot.1015granger.net>
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

Clean-up. The max_send_sge value also happens to be stored in
ep->rep_attr. Let's keep just a single copy.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  |   10 ++++++++++
 net/sunrpc/xprtrdma/rpc_rdma.c  |    2 +-
 net/sunrpc/xprtrdma/verbs.c     |   17 +++--------------
 net/sunrpc/xprtrdma/xprt_rdma.h |    1 -
 4 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 50025408dc2a..24b8b75d0d49 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -183,6 +183,16 @@ int frwr_open(struct rpcrdma_ia *ia, struct rpcrdma_ep *ep)
 {
 	struct ib_device_attr *attrs = &ia->ri_id->device->attrs;
 	int max_qp_wr, depth, delta;
+	unsigned int max_sge;
+
+	max_sge = min_t(unsigned int, attrs->max_send_sge,
+			RPCRDMA_MAX_SEND_SGES);
+	if (max_sge < RPCRDMA_MIN_SEND_SGES) {
+		pr_err("rpcrdma: HCA provides only %u send SGEs\n", max_sge);
+		return -ENOMEM;
+	}
+	ep->rep_attr.cap.max_send_sge = max_sge;
+	ep->rep_attr.cap.max_recv_sge = 1;
 
 	ia->ri_mrtype = IB_MR_TYPE_MEM_REG;
 	if (attrs->device_cap_flags & IB_DEVICE_SG_GAPS_REG)
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index aec3beb93b25..af917228d245 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -145,7 +145,7 @@ static bool rpcrdma_args_inline(struct rpcrdma_xprt *r_xprt,
 			remaining -= min_t(unsigned int,
 					   PAGE_SIZE - offset, remaining);
 			offset = 0;
-			if (++count > r_xprt->rx_ia.ri_max_send_sges)
+			if (++count > r_xprt->rx_ep.rep_attr.cap.max_send_sge)
 				return false;
 		}
 	}
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 4d7d7555569c..0ad81d3c735e 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -469,21 +469,12 @@ int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
 	struct rpcrdma_connect_private *pmsg = &ep->rep_cm_private;
 	struct ib_cq *sendcq, *recvcq;
-	unsigned int max_sge;
 	int rc;
 
 	ep->rep_max_requests = xprt_rdma_slot_table_entries;
 	ep->rep_inline_send = xprt_rdma_max_inline_write;
 	ep->rep_inline_recv = xprt_rdma_max_inline_read;
 
-	max_sge = min_t(unsigned int, ia->ri_id->device->attrs.max_send_sge,
-			RPCRDMA_MAX_SEND_SGES);
-	if (max_sge < RPCRDMA_MIN_SEND_SGES) {
-		pr_warn("rpcrdma: HCA provides only %d send SGEs\n", max_sge);
-		return -ENOMEM;
-	}
-	ia->ri_max_send_sges = max_sge;
-
 	rc = frwr_open(ia, ep);
 	if (rc)
 		return rc;
@@ -491,8 +482,6 @@ int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 	ep->rep_attr.event_handler = rpcrdma_qp_event_handler;
 	ep->rep_attr.qp_context = ep;
 	ep->rep_attr.srq = NULL;
-	ep->rep_attr.cap.max_send_sge = max_sge;
-	ep->rep_attr.cap.max_recv_sge = 1;
 	ep->rep_attr.cap.max_inline_data = 0;
 	ep->rep_attr.sq_sig_type = IB_SIGNAL_REQ_WR;
 	ep->rep_attr.qp_type = IB_QPT_RC;
@@ -795,11 +784,11 @@ static void rpcrdma_sendctxs_destroy(struct rpcrdma_buffer *buf)
 	kfree(buf->rb_sc_ctxs);
 }
 
-static struct rpcrdma_sendctx *rpcrdma_sendctx_create(struct rpcrdma_ia *ia)
+static struct rpcrdma_sendctx *rpcrdma_sendctx_create(struct rpcrdma_ep *ep)
 {
 	struct rpcrdma_sendctx *sc;
 
-	sc = kzalloc(struct_size(sc, sc_sges, ia->ri_max_send_sges),
+	sc = kzalloc(struct_size(sc, sc_sges, ep->rep_attr.cap.max_send_sge),
 		     GFP_KERNEL);
 	if (!sc)
 		return NULL;
@@ -827,7 +816,7 @@ static int rpcrdma_sendctxs_create(struct rpcrdma_xprt *r_xprt)
 
 	buf->rb_sc_last = i - 1;
 	for (i = 0; i <= buf->rb_sc_last; i++) {
-		sc = rpcrdma_sendctx_create(&r_xprt->rx_ia);
+		sc = rpcrdma_sendctx_create(&r_xprt->rx_ep);
 		if (!sc)
 			return -ENOMEM;
 
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index d796d68609ed..7655a99fd559 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -73,7 +73,6 @@ struct rpcrdma_ia {
 	int			ri_async_rc;
 	unsigned int		ri_max_segs;
 	unsigned int		ri_max_frwr_depth;
-	unsigned int		ri_max_send_sges;
 	bool			ri_implicit_roundup;
 	enum ib_mr_type		ri_mrtype;
 	unsigned long		ri_flags;


