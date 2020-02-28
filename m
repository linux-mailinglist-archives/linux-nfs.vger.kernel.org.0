Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5124E172D62
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2020 01:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbgB1AcM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Feb 2020 19:32:12 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44801 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbgB1AcM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Feb 2020 19:32:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id a14so537574pgb.11;
        Thu, 27 Feb 2020 16:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=HsD6XqPvYOfHqWao/oxjfSWr5+od2Da4O6WGbOcOZZE=;
        b=e/rew2Iv8wt4MR5uKlNxHQ+48Tnwl+boBMWgioditkkNgbTVjkW14Fz1z2Zi5xmijm
         6+Ci73ODR+isRVw2cmJisEVRFqk8y66UXKAtWFAfMxMlTC4QAN9eQjh65qQt2viBE8cZ
         28eRv/xKs8aVmm5trrxV1FvSB1L7z00AnqTIqAla7VHRaZtGIYpx/RjwflZ0xjYKARZg
         RQ9d6DgifKmLdyAeLpCrZhIDn5G1iBp7oxmiAttLKogwgljOYEjXd7Kkc5dvz/+ngGL9
         OduL09B2aJyRKQDxFk+kqrsxtQGN5N1eN5/reYr7Fg8iyfQC8zeikufdI8gPXYeUbZpc
         NMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=HsD6XqPvYOfHqWao/oxjfSWr5+od2Da4O6WGbOcOZZE=;
        b=HSwIqLRjfjrQBxkH2ScP9B4kb3z60tWibvyjxo854ZONnwpW/IGk47nSBhTGfJEzMG
         SuYADE4j0V3WSM8B2wYRLlUPrzpU/wXTIKSK6XTFq9YdZHJYqOl1KIKmgQsVQW2vf7cg
         jgiaTehPksehV6rvzcb1yilrzymWALYAJfhiR/Q1WSXBJRkswfSmJq+q61x1e/8pjNAC
         mpAQJ1zcUXcp/tV2tHYF4pYMEbcmeQdofhG9yhbOOVEUiCnDxkSlKHgvujqN7HppwoAP
         nPdTUc8Yp5zTuzOwg/gtm+yiynoXyXQBzeDQIhnf0rxdqEYyk0HRia7twmJOYH9bapAm
         HaUA==
X-Gm-Message-State: APjAAAV0nJP67BdTqyh8bj8XipLkFQwPUD39jTis+G6OtUY5kFtl2AbA
        6CHqWRM+kVOJ6A0RA3zgLW0=
X-Google-Smtp-Source: APXvYqz5uy/u2Bf3rX9pPyrNoDW1Sit3ntl26eIKI1oKaxpQDfiU03DBOUeLLwEjlijQwMICS5atwQ==
X-Received: by 2002:a63:cc4c:: with SMTP id q12mr1845950pgi.443.1582849930993;
        Thu, 27 Feb 2020 16:32:10 -0800 (PST)
Received: from seurat29.1015granger.net (ip-184-250-247-225.sanjca.spcsdns.net. [184.250.247.225])
        by smtp.gmail.com with ESMTPSA id v8sm8278650pfn.172.2020.02.27.16.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:32:10 -0800 (PST)
Subject: [PATCH v1 15/16] svcrdma: Fix double sync of transport header buffer
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 27 Feb 2020 19:32:09 -0500
Message-ID: <158284992931.38468.12518545682966287291.stgit@seurat29.1015granger.net>
In-Reply-To: <158284930886.38468.17045380766660946827.stgit@seurat29.1015granger.net>
References: <158284930886.38468.17045380766660946827.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Performance optimization: Avoid syncing the transport buffer twice
when Reply buffer pull-up is necessary.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h            |    3 -
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |    1 
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c    |    4 +-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      |   58 ++++++++++------------------
 4 files changed, 22 insertions(+), 44 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index d001aac13c2f..a3fa5b4fa2e4 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -191,9 +191,6 @@ extern struct svc_rdma_send_ctxt *
 extern void svc_rdma_send_ctxt_put(struct svcxprt_rdma *rdma,
 				   struct svc_rdma_send_ctxt *ctxt);
 extern int svc_rdma_send(struct svcxprt_rdma *rdma, struct ib_send_wr *wr);
-extern void svc_rdma_sync_reply_hdr(struct svcxprt_rdma *rdma,
-				    struct svc_rdma_send_ctxt *ctxt,
-				    unsigned int len);
 extern int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 				  struct svc_rdma_send_ctxt *sctxt,
 				  const struct svc_rdma_recv_ctxt *rctxt,
diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
index 9830748c58d2..46b59e91d34a 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
@@ -191,7 +191,6 @@ rpcrdma_bc_send_request(struct svcxprt_rdma *rdma, struct rpc_rqst *rqst)
 	*p++ = xdr_zero;
 	*p++ = xdr_zero;
 	*p   = xdr_zero;
-	svc_rdma_sync_reply_hdr(rdma, ctxt, ctxt->sc_hdrbuf.len);
 
 #ifdef SVCRDMA_BACKCHANNEL_DEBUG
 	pr_info("%s: %*ph\n", __func__, 64, rqst->rq_buffer);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 447060dbd6fd..2fb1de40613c 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -737,9 +737,9 @@ static void svc_rdma_send_error(struct svcxprt_rdma *xprt,
 		trace_svcrdma_err_chunk(*rdma_argp);
 	}
 
-	svc_rdma_sync_reply_hdr(xprt, ctxt, ctxt->sc_hdrbuf.len);
-
+	ctxt->sc_send_wr.num_sge = 1;
 	ctxt->sc_send_wr.opcode = IB_WR_SEND;
+	ctxt->sc_sges[0].length = ctxt->sc_hdrbuf.len;
 	ret = svc_rdma_send(xprt, &ctxt->sc_send_wr);
 	if (ret)
 		goto put_ctxt;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index f557e1cc5694..9a7317bc54c9 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -301,6 +301,12 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct ib_send_wr *wr)
 
 	might_sleep();
 
+	/* Sync the transport header buffer */
+	ib_dma_sync_single_for_device(rdma->sc_pd->device,
+				      wr->sg_list[0].addr,
+				      wr->sg_list[0].length,
+				      DMA_TO_DEVICE);
+
 	/* If the SQ is full, wait until an SQ entry is available */
 	while (1) {
 		if ((atomic_dec_return(&rdma->sc_sq_avail) < 0)) {
@@ -530,24 +536,6 @@ static int svc_rdma_dma_map_buf(struct svcxprt_rdma *rdma,
 				     offset_in_page(base), len);
 }
 
-/**
- * svc_rdma_sync_reply_hdr - DMA sync the transport header buffer
- * @rdma: controlling transport
- * @ctxt: send_ctxt for the Send WR
- * @len: length of transport header
- *
- */
-void svc_rdma_sync_reply_hdr(struct svcxprt_rdma *rdma,
-			     struct svc_rdma_send_ctxt *ctxt,
-			     unsigned int len)
-{
-	ctxt->sc_sges[0].length = len;
-	ctxt->sc_send_wr.num_sge++;
-	ib_dma_sync_single_for_device(rdma->sc_pd->device,
-				      ctxt->sc_sges[0].addr, len,
-				      DMA_TO_DEVICE);
-}
-
 /**
  * svc_rdma_pull_up_needed - Determine whether to use pull-up
  * @rdma: controlling transport
@@ -610,9 +598,7 @@ static int svc_rdma_pull_up_reply_msg(struct svcxprt_rdma *rdma,
 	unsigned char *dst, *tailbase;
 	unsigned int taillen;
 
-	dst = sctxt->sc_xprt_buf;
-	dst += sctxt->sc_sges[0].length;
-
+	dst = sctxt->sc_xprt_buf + sctxt->sc_hdrbuf.len;
 	memcpy(dst, xdr->head[0].iov_base, xdr->head[0].iov_len);
 	dst += xdr->head[0].iov_len;
 
@@ -648,11 +634,6 @@ static int svc_rdma_pull_up_reply_msg(struct svcxprt_rdma *rdma,
 		memcpy(dst, tailbase, taillen);
 
 	sctxt->sc_sges[0].length += xdr->len;
-	ib_dma_sync_single_for_device(rdma->sc_pd->device,
-				      sctxt->sc_sges[0].addr,
-				      sctxt->sc_sges[0].length,
-				      DMA_TO_DEVICE);
-
 	return 0;
 }
 
@@ -663,7 +644,7 @@ static int svc_rdma_pull_up_reply_msg(struct svcxprt_rdma *rdma,
  * @xdr: prepared xdr_buf containing RPC message
  *
  * Load the xdr_buf into the ctxt's sge array, and DMA map each
- * element as it is added.
+ * element as it is added. The Send WR's num_sge field is set.
  *
  * Returns zero on success, or a negative errno on failure.
  */
@@ -679,6 +660,13 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 	u32 xdr_pad;
 	int ret;
 
+	/* Set up the (persistently-mapped) transport header SGE */
+	sctxt->sc_send_wr.num_sge = 1;
+	sctxt->sc_sges[0].length = sctxt->sc_hdrbuf.len;
+
+	if (rctxt && rctxt->rc_reply_chunk)
+		return 0;
+
 	if (svc_rdma_pull_up_needed(rdma, rctxt, xdr))
 		return svc_rdma_pull_up_reply_msg(rdma, sctxt, rctxt, xdr);
 
@@ -780,12 +768,9 @@ static int svc_rdma_send_reply_msg(struct svcxprt_rdma *rdma,
 {
 	int ret;
 
-	if (!rctxt->rc_reply_chunk) {
-		ret = svc_rdma_map_reply_msg(rdma, sctxt, rctxt,
-					     &rqstp->rq_res);
-		if (ret < 0)
-			return ret;
-	}
+	ret = svc_rdma_map_reply_msg(rdma, sctxt, rctxt, &rqstp->rq_res);
+	if (ret < 0)
+		return ret;
 
 	svc_rdma_save_io_pages(rqstp, sctxt);
 
@@ -795,8 +780,6 @@ static int svc_rdma_send_reply_msg(struct svcxprt_rdma *rdma,
 	} else {
 		sctxt->sc_send_wr.opcode = IB_WR_SEND;
 	}
-	dprintk("svcrdma: posting Send WR with %u sge(s)\n",
-		sctxt->sc_send_wr.num_sge);
 	return svc_rdma_send(rdma, &sctxt->sc_send_wr);
 }
 
@@ -830,11 +813,11 @@ static int svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
 	*p   = err_chunk;
 	trace_svcrdma_err_chunk(*rdma_argp);
 
-	svc_rdma_sync_reply_hdr(rdma, ctxt, ctxt->sc_hdrbuf.len);
-
 	svc_rdma_save_io_pages(rqstp, ctxt);
 
+	ctxt->sc_send_wr.num_sge = 1;
 	ctxt->sc_send_wr.opcode = IB_WR_SEND;
+	ctxt->sc_sges[0].length = ctxt->sc_hdrbuf.len;
 	return svc_rdma_send(rdma, &ctxt->sc_send_wr);
 }
 
@@ -919,7 +902,6 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 			goto err0;
 	}
 
-	svc_rdma_sync_reply_hdr(rdma, sctxt, sctxt->sc_hdrbuf.len);
 	ret = svc_rdma_send_reply_msg(rdma, sctxt, rctxt, rqstp);
 	if (ret < 0)
 		goto err1;

