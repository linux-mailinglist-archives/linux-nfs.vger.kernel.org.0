Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 431B8DB634
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2019 20:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406687AbfJQSbk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Oct 2019 14:31:40 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37914 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731227AbfJQSbk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Oct 2019 14:31:40 -0400
Received: by mail-qk1-f194.google.com with SMTP id p4so2829115qkf.5;
        Thu, 17 Oct 2019 11:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Pn5eLKTK1EeeO2p0zq+GeIFZ+Xs+ZFVG/1mx3hQz3mk=;
        b=jzVg+dr4BPcss4fG5wo5uRG+yIiblDINfqMGFxY07ukJAtNYS2qgwkjt8brcUxUQwE
         z5rmr8I7pLXaWGdIGE1GPr4ppi64GOfv60miHenSuUVJT9oPFKoncomGPkWxSdiuiC/5
         j5nUSNMyGf+3guF9umrSSV+vrY92rFNFyWPecPYpydrDFxjxp+B3m6xYKTvzHx044nyN
         /i6xeDrlbffguLXb5RCNFMbi593ElVcze0RQruTIKWJqX6VVlXOSrH/ssJVmUJ22wo/X
         wD74txzAbngsLJmLj89QU+lIPft4f3/ttAmiHwqN0vadtmAY6UobrjRlFF6e7P/FQ9Ov
         NoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Pn5eLKTK1EeeO2p0zq+GeIFZ+Xs+ZFVG/1mx3hQz3mk=;
        b=HZp0z43NPt+PeQdW/QwERU8qR3pVORr74pPi6cNaNyui5Zxq7AtSvL9eFZIajA5p+n
         1kRxLwpAwcOhhgJ5TUx8pp+76+V/jqRkNcoWaFUx792geChI1kDKdONcuMNcki6W01MN
         JMqDzq47FU5YbG/W+ZAhL8H9CTCXV7Qz92KD+i9RcRfj5cLzv8G8pN5oVV69J5p6zw9L
         J5CXaQmeIDKfuWynq5p+OkgvEdgXNCbD3Jw98X1wBrOukAcX+BGw7d6LD1RAMGZEZjSI
         vKpdNfxK8OnC4SVFMUaBd9ZfX/lE6/8++AsSacGFt8j6Js6XTyUfdAFdHXwtqLHjbBU6
         dNKw==
X-Gm-Message-State: APjAAAWVApmvdztyGBgkiPsLmWpvME9AGOYDt/IpJ/y5VpDRj4ybaemz
        c0XOz5x6ZRAQvt+oiRF0lq1RyS8F
X-Google-Smtp-Source: APXvYqys78o/pzhzntw3fSbGMPFXDYzHnYmGC9KcoLuLw8nsNnQzYH2SBXn22PnR7Pa4ZZRQhkaykA==
X-Received: by 2002:a37:8785:: with SMTP id j127mr4631696qkd.126.1571337097389;
        Thu, 17 Oct 2019 11:31:37 -0700 (PDT)
Received: from oracle-102.nfsv4bat.org ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id x8sm1356871qkx.77.2019.10.17.11.31.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 11:31:36 -0700 (PDT)
Subject: [PATCH v1 4/6] xprtrdma: Move the rpcrdma_sendctx::sc_wr field
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Thu, 17 Oct 2019 14:31:35 -0400
Message-ID: <20191017183135.2517.60416.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <20191017182811.2517.25676.stgit@oracle-102.nfsv4bat.org>
References: <20191017182811.2517.25676.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: This field is not needed in the Send completion handler,
so it can be moved to struct rpcrdma_req to reduce the size of
struct rpcrdma_sendctx, and to reduce the amount of memory that
is sloshed between the sending process and the Send completion
process.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  |    2 +-
 net/sunrpc/xprtrdma/rpc_rdma.c  |    9 ++++++---
 net/sunrpc/xprtrdma/verbs.c     |    5 +----
 net/sunrpc/xprtrdma/xprt_rdma.h |    2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 31681cb..16572ae7 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -667,9 +667,8 @@
 		__entry->client_id = rqst->rq_task->tk_client ?
 				     rqst->rq_task->tk_client->cl_clid : -1;
 		__entry->req = req;
-		__entry->num_sge = req->rl_sendctx->sc_wr.num_sge;
-		__entry->signaled = req->rl_sendctx->sc_wr.send_flags &
-				    IB_SEND_SIGNALED;
+		__entry->num_sge = req->rl_wr.num_sge;
+		__entry->signaled = req->rl_wr.send_flags & IB_SEND_SIGNALED;
 		__entry->status = status;
 	),
 
diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 5cd8715..523722b 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -396,7 +396,7 @@ int frwr_send(struct rpcrdma_ia *ia, struct rpcrdma_req *req)
 	struct ib_send_wr *post_wr;
 	struct rpcrdma_mr *mr;
 
-	post_wr = &req->rl_sendctx->sc_wr;
+	post_wr = &req->rl_wr;
 	list_for_each_entry(mr, &req->rl_registered, mr_list) {
 		struct rpcrdma_frwr *frwr;
 
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 1941b22..53cd2e3 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -599,7 +599,7 @@ static bool rpcrdma_prepare_hdr_sge(struct rpcrdma_xprt *r_xprt,
 
 	ib_dma_sync_single_for_device(rdmab_device(rb), sge->addr, sge->length,
 				      DMA_TO_DEVICE);
-	sc->sc_wr.num_sge++;
+	req->rl_wr.num_sge++;
 	return true;
 
 out_regbuf:
@@ -711,7 +711,7 @@ static bool rpcrdma_prepare_msg_sges(struct rpcrdma_xprt *r_xprt,
 	}
 
 out:
-	sc->sc_wr.num_sge += sge_no;
+	req->rl_wr.num_sge += sge_no;
 	if (sc->sc_unmap_count)
 		kref_get(&req->rl_kref);
 	return true;
@@ -752,10 +752,13 @@ static bool rpcrdma_prepare_msg_sges(struct rpcrdma_xprt *r_xprt,
 	req->rl_sendctx = rpcrdma_sendctx_get_locked(r_xprt);
 	if (!req->rl_sendctx)
 		goto err;
-	req->rl_sendctx->sc_wr.num_sge = 0;
 	req->rl_sendctx->sc_unmap_count = 0;
 	req->rl_sendctx->sc_req = req;
 	kref_init(&req->rl_kref);
+	req->rl_wr.wr_cqe = &req->rl_sendctx->sc_cqe;
+	req->rl_wr.sg_list = req->rl_sendctx->sc_sges;
+	req->rl_wr.num_sge = 0;
+	req->rl_wr.opcode = IB_WR_SEND;
 
 	ret = -EIO;
 	if (!rpcrdma_prepare_hdr_sge(r_xprt, req, hdrlen))
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 3ab086a..2f46582 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -811,9 +811,6 @@ static struct rpcrdma_sendctx *rpcrdma_sendctx_create(struct rpcrdma_ia *ia)
 	if (!sc)
 		return NULL;
 
-	sc->sc_wr.wr_cqe = &sc->sc_cqe;
-	sc->sc_wr.sg_list = sc->sc_sges;
-	sc->sc_wr.opcode = IB_WR_SEND;
 	sc->sc_cqe.done = rpcrdma_wc_send;
 	return sc;
 }
@@ -1469,7 +1466,7 @@ static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb)
 		struct rpcrdma_ep *ep,
 		struct rpcrdma_req *req)
 {
-	struct ib_send_wr *send_wr = &req->rl_sendctx->sc_wr;
+	struct ib_send_wr *send_wr = &req->rl_wr;
 	int rc;
 
 	if (!ep->rep_send_count || kref_read(&req->rl_kref) > 1) {
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 0e5b7f3..cdd6a3d 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -219,7 +219,6 @@ enum {
  */
 struct rpcrdma_req;
 struct rpcrdma_sendctx {
-	struct ib_send_wr	sc_wr;
 	struct ib_cqe		sc_cqe;
 	struct rpcrdma_req	*sc_req;
 	unsigned int		sc_unmap_count;
@@ -314,6 +313,7 @@ struct rpcrdma_req {
 	struct rpcrdma_rep	*rl_reply;
 	struct xdr_stream	rl_stream;
 	struct xdr_buf		rl_hdrbuf;
+	struct ib_send_wr	rl_wr;
 	struct rpcrdma_sendctx	*rl_sendctx;
 	struct rpcrdma_regbuf	*rl_rdmabuf;	/* xprt header */
 	struct rpcrdma_regbuf	*rl_sendbuf;	/* rq_snd_buf */

