Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D80D0172D64
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2020 01:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbgB1AcT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Feb 2020 19:32:19 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43502 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730253AbgB1AcT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Feb 2020 19:32:19 -0500
Received: by mail-pl1-f194.google.com with SMTP id p11so490220plq.10;
        Thu, 27 Feb 2020 16:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Rh0J7J+tmI9ibvdcsm+0y9mwMYxxyAhrYZdwv/dpsVs=;
        b=JgGJRtpmRQYq4WDLgxCITaAj2ShvrCED1EkjwcpTiEr/6r5/0OPWOZ9k9lc31K0sBN
         d96QEG2Ed9x3bLuz7YP6t0ZYhWj7PPdGOL6ZU/4BWgsxTjYymn5NmXbt5eH600h0xcvo
         ekN8P90C7/XW//n2WG7eyjacCSCF7OIB/y9/KF4wR29ebax1TIOL7ptTFx4q51Qgk+xp
         TSsHPFxzBFt6mqq8b0uc11Fpy2wJq46WKBcDw5Nw16PYSlyCty+6s55vjNWDaXMnpMP0
         ICCUcbKGsHWgvh1lWFxCXVtDOCR3UsFGG6FELqphsWVZ2eJUpJjFTsDIFCbci+R8wqHq
         o10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Rh0J7J+tmI9ibvdcsm+0y9mwMYxxyAhrYZdwv/dpsVs=;
        b=IxaLRZHifIxwHjgx3PFZxmfLfWy/3JYcXErt1HpIpkCK9Vcsqdevb97yV28yqJsxKc
         pS6IqnMnF9y1rfKdeJR/dEv2FODCmlANfJzwhL6AlVhgV8xTOXYuux1rq+husbb8mlwB
         /JqxUYEuV1uVN4OropNVrqykHEAn3op586PlyeIQLSrGyRRmHzQeHKhuTasL3bdjjUaH
         G/c+kmWqdr+PCADb6YDE85rMuJSyj6H1lfmhoVsUQ+VWGMRUXkzURY2UL3pKrjfWr7Br
         NLDxx4NCgsFdF+4R+oCcyzrwrd0hVJAdlwulZs4FFmZeSxYzf943AMz/yKQDXO73pxLx
         niSQ==
X-Gm-Message-State: APjAAAVSyVJSCqFDmmqVIF17pMj8yI3cB+2QIhS0jI7w1nJyYQ2q7Cu5
        V2cqRd89HCv2tDmBwW/w7gLx2FqW7hA=
X-Google-Smtp-Source: APXvYqzEK+YIRCXyESRiVTv9OYqSRB+MClMUSy6tM2tGMvj6K/bEJMqF8h7CEJ/2t785gOnMdIQ42w==
X-Received: by 2002:a17:90a:da04:: with SMTP id e4mr1631372pjv.26.1582849937969;
        Thu, 27 Feb 2020 16:32:17 -0800 (PST)
Received: from seurat29.1015granger.net (ip-184-250-247-225.sanjca.spcsdns.net. [184.250.247.225])
        by smtp.gmail.com with ESMTPSA id z13sm7995590pge.29.2020.02.27.16.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:32:17 -0800 (PST)
Subject: [PATCH v1 16/16] svcrdma: Avoid DMA mapping small RPC Replies
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 27 Feb 2020 19:32:16 -0500
Message-ID: <158284993622.38468.2163113637049774961.stgit@seurat29.1015granger.net>
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

On some platforms, DMA mapping part of a page is more costly than
copying bytes. Indeed, not involving the I/O MMU can help the
RPC/RDMA transport scale better for tiny I/Os across more RDMA
devices. This is because interaction with the I/O MMU is eliminated
for each of these small I/Os. Without the explicit unmapping, the
NIC no longer needs to do a costly internal TLB shoot down for
buffers that are just a handful of bytes.

Since pull-up is now a more a frequent operation, I've introduced a
trace point in the pull-up path. It can be used for debugging or
user-space tools that count pull-up frequency.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h        |   18 ++++++++++++++++++
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   15 ++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 74b68547eefb..9238d233f8cf 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1639,6 +1639,24 @@ TRACE_EVENT(svcrdma_dma_map_rwctx,
 	)
 );
 
+TRACE_EVENT(svcrdma_send_pullup,
+	TP_PROTO(
+		unsigned int len
+	),
+
+	TP_ARGS(len),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, len)
+	),
+
+	TP_fast_assign(
+		__entry->len = len;
+	),
+
+	TP_printk("len=%u", __entry->len)
+);
+
 TRACE_EVENT(svcrdma_send_failed,
 	TP_PROTO(
 		const struct svc_rqst *rqst,
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 9a7317bc54c9..3669a41bf8b6 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -539,6 +539,7 @@ static int svc_rdma_dma_map_buf(struct svcxprt_rdma *rdma,
 /**
  * svc_rdma_pull_up_needed - Determine whether to use pull-up
  * @rdma: controlling transport
+ * @sctxt: send_ctxt for the Send WR
  * @rctxt: Write and Reply chunks provided by client
  * @xdr: xdr_buf containing RPC message to transmit
  *
@@ -547,11 +548,22 @@ static int svc_rdma_dma_map_buf(struct svcxprt_rdma *rdma,
  *	%false otherwise
  */
 static bool svc_rdma_pull_up_needed(struct svcxprt_rdma *rdma,
+				    struct svc_rdma_send_ctxt *sctxt,
 				    const struct svc_rdma_recv_ctxt *rctxt,
 				    struct xdr_buf *xdr)
 {
 	int elements;
 
+	/* For small messages, copying bytes is cheaper than DMA
+	 * mapping.
+	 */
+	if (sctxt->sc_hdrbuf.len + xdr->len <
+	    RPCRDMA_V1_DEF_INLINE_SIZE >> 1)
+		return true;
+
+	/* Check whether the xdr_buf has more elements than can
+	 * fit in a single RDMA Send.
+	 */
 	/* xdr->head */
 	elements = 1;
 
@@ -634,6 +646,7 @@ static int svc_rdma_pull_up_reply_msg(struct svcxprt_rdma *rdma,
 		memcpy(dst, tailbase, taillen);
 
 	sctxt->sc_sges[0].length += xdr->len;
+	trace_svcrdma_send_pullup(sctxt->sc_sges[0].length);
 	return 0;
 }
 
@@ -667,7 +680,7 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 	if (rctxt && rctxt->rc_reply_chunk)
 		return 0;
 
-	if (svc_rdma_pull_up_needed(rdma, rctxt, xdr))
+	if (svc_rdma_pull_up_needed(rdma, sctxt, rctxt, xdr))
 		return svc_rdma_pull_up_reply_msg(rdma, sctxt, rctxt, xdr);
 
 	++sctxt->sc_cur_sge_no;

