Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB3AC172D51
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2020 01:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgB1AbX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Feb 2020 19:31:23 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51527 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbgB1AbX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Feb 2020 19:31:23 -0500
Received: by mail-pj1-f68.google.com with SMTP id fa20so514496pjb.1;
        Thu, 27 Feb 2020 16:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=AzkiZb8px8kNE2AdDZkFKa0fWQaErrSv90fuEowsxTQ=;
        b=mRVabJ4JXPv/zW57Td4ZCaBbL0pHGtSygEHoOZ1MqZPRKlqwWbobCJzuEWXdX2cDT/
         1u3G+onZTuz3y4KI/xZGDB6YdB9Fr0Ay2dVf+jfzqkgaokcyXIkTV0vq9OArV9lqv0mI
         STsXbcU+blAX787Ep5GiPjnPUBohvXlN20MCTQXNyMMRqFA2ti3HNQzUawiJA7c3dSdM
         GzMv6NI23FgG5oR+8y5QOQeSHI1IpFw7Qe1ffS3/QRELEKuK9Ion/vtxUl9Wp/zp9X4R
         /OVFPmkk7bumR7oVMLe462oj0i2Hfu8MEi777QBxehOTZyGc1cJTzL99E7APX4+oEf9P
         TaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=AzkiZb8px8kNE2AdDZkFKa0fWQaErrSv90fuEowsxTQ=;
        b=HisRkyhkALDa7pGWfkFWoRdJNkgKY6ws7orGe52S6Tz04icd+Sx90rO0sIUHn5UkDT
         DCA4BZS7bbYVGmFGU2/pHwtIWTcy2FgBVLzsBL8qe0Gc8FNrMDTN1cyj8kntngKaU6A4
         2ekhlCEzORYVfvZxXPe6KHpEOUBdlxlIHOJHBhB5GH6WIL0pdtHDcF1pkdyskpB7osYz
         JLeSKGaoQVXTwwH0ntrC9J1dyRQO7Bnh1KH06AauYKvd+t9si8AvQRNKSrC57Wmbuuty
         0+QfRUdYMtbktW90wdxIm4zhGSHc5UPaC525avUCOOEUJ3Rx+W8mSdBIQQP4N8+vIkv5
         8iyQ==
X-Gm-Message-State: APjAAAWQxzPzc8q0P21rfaEiOLAcNwB41f8TCLyYu1OxKaMiOEuUp5Ve
        wG2uQRbZAVBo1tGx4ZErz+Y=
X-Google-Smtp-Source: APXvYqwbWaZiX9/pOpDCzcJhnDjqgXT+4oGxEDwJPVxYul7BjvNscUdeznrDFAP78IUFHcYJS/6T9w==
X-Received: by 2002:a17:902:8642:: with SMTP id y2mr1387721plt.306.1582849882259;
        Thu, 27 Feb 2020 16:31:22 -0800 (PST)
Received: from seurat29.1015granger.net (ip-184-250-247-225.sanjca.spcsdns.net. [184.250.247.225])
        by smtp.gmail.com with ESMTPSA id q13sm9402296pfn.162.2020.02.27.16.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:31:21 -0800 (PST)
Subject: [PATCH v1 08/16] svcrdma: De-duplicate code that locates Write and
 Reply chunks
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 27 Feb 2020 19:31:20 -0500
Message-ID: <158284988067.38468.555434593805309782.stgit@seurat29.1015granger.net>
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

Cache the locations of the Requester-provided Write list and Reply
chunk so that the Send path doesn't need to parse the Call header
again.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h         |    2 ++
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |    8 ++++++-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c   |   38 +++----------------------------
 3 files changed, 13 insertions(+), 35 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index c790dbb0dd90..e714e4d90ac5 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -138,6 +138,8 @@ struct svc_rdma_recv_ctxt {
 	unsigned int		rc_page_count;
 	unsigned int		rc_hdr_count;
 	u32			rc_inv_rkey;
+	__be32			*rc_write_list;
+	__be32			*rc_reply_chunk;
 	unsigned int		rc_read_payload_offset;
 	unsigned int		rc_read_payload_length;
 	struct page		*rc_pages[RPCSVC_MAXPAGES];
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 7db151b7dfd3..f9a3c413491c 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -480,6 +480,7 @@ static bool xdr_check_write_list(struct svc_rdma_recv_ctxt *rctxt)
 	p = xdr_inline_decode(&rctxt->rc_stream, sizeof(*p));
 	if (!p)
 		return false;
+	rctxt->rc_write_list = p;
 	while (*p != xdr_zero) {
 		if (!xdr_check_write_chunk(rctxt, MAX_BYTES_WRITE_CHUNK))
 			return false;
@@ -488,6 +489,8 @@ static bool xdr_check_write_list(struct svc_rdma_recv_ctxt *rctxt)
 		if (!p)
 			return false;
 	}
+	if (!chcount)
+		rctxt->rc_write_list = NULL;
 	return chcount < 2;
 }
 
@@ -510,9 +513,12 @@ static bool xdr_check_reply_chunk(struct svc_rdma_recv_ctxt *rctxt)
 	p = xdr_inline_decode(&rctxt->rc_stream, sizeof(*p));
 	if (!p)
 		return false;
-	if (*p != xdr_zero)
+	rctxt->rc_reply_chunk = p;
+	if (*p != xdr_zero) {
 		if (!xdr_check_write_chunk(rctxt, MAX_BYTES_SPECIAL_CHUNK))
 			return false;
+	} else
+		rctxt->rc_reply_chunk = NULL;
 	return true;
 }
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 4add875277f8..94895635c007 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -449,36 +449,6 @@ static void svc_rdma_xdr_encode_reply_chunk(__be32 *rdma_resp, __be32 *rp_ch,
 	xdr_encode_write_chunk(p, rp_ch, consumed);
 }
 
-/* Parse the RPC Call's transport header.
- */
-static void svc_rdma_get_write_arrays(__be32 *rdma_argp,
-				      __be32 **write, __be32 **reply)
-{
-	__be32 *p;
-
-	p = rdma_argp + rpcrdma_fixed_maxsz;
-
-	/* Read list */
-	while (*p++ != xdr_zero)
-		p += 5;
-
-	/* Write list */
-	if (*p != xdr_zero) {
-		*write = p;
-		while (*p++ != xdr_zero)
-			p += 1 + be32_to_cpu(*p) * 4;
-	} else {
-		*write = NULL;
-		p++;
-	}
-
-	/* Reply chunk */
-	if (*p != xdr_zero)
-		*reply = p;
-	else
-		*reply = NULL;
-}
-
 static int svc_rdma_dma_map_page(struct svcxprt_rdma *rdma,
 				 struct svc_rdma_send_ctxt *ctxt,
 				 struct page *page,
@@ -813,14 +783,14 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	struct svcxprt_rdma *rdma =
 		container_of(xprt, struct svcxprt_rdma, sc_xprt);
 	struct svc_rdma_recv_ctxt *rctxt = rqstp->rq_xprt_ctxt;
-	__be32 *p, *rdma_argp, *rdma_resp, *wr_lst, *rp_ch;
+	__be32 *rdma_argp = rctxt->rc_recv_buf;
+	__be32 *wr_lst = rctxt->rc_write_list;
+	__be32 *rp_ch = rctxt->rc_reply_chunk;
 	struct xdr_buf *xdr = &rqstp->rq_res;
 	struct svc_rdma_send_ctxt *sctxt;
+	__be32 *p, *rdma_resp;
 	int ret;
 
-	rdma_argp = rctxt->rc_recv_buf;
-	svc_rdma_get_write_arrays(rdma_argp, &wr_lst, &rp_ch);
-
 	/* Create the RDMA response header. xprt->xpt_mutex,
 	 * acquired in svc_send(), serializes RPC replies. The
 	 * code path below that inserts the credit grant value

