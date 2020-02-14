Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEF1615F446
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2020 19:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394811AbgBNSUJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Feb 2020 13:20:09 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45499 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730409AbgBNPuQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Feb 2020 10:50:16 -0500
Received: by mail-yw1-f68.google.com with SMTP id a125so4419915ywe.12;
        Fri, 14 Feb 2020 07:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=4CVhXYMIL7ngreD3h590y5QJsOqcAB/B0UruGgDbpao=;
        b=cn595/bE0+I30RhhDv44q3UwuufzvBh/cGPspIT9i3lLe4boPZ08NKo5iQPRdHj+Di
         6jkQztoQPlPBi9SbhAJCzwi4hv74NgHd6pGoSbzduxf60gF5P3ZH0t0oUJQzMiT7IBSW
         JZlvFN1X4izV/mT4zvwVQAyx7RvJaLjc/2EwlmpLAWqO3YnoKcwi5+2RN/bZeFDi4ClG
         Owac+edJeZpXjnNt/PKH+hYxztb4KfS6MKgNvawsY4k9MlFfhjpMhFtZooef6x3OklN+
         F8GEM/JH0dUECWU6WwDYaYE5J4Xh6VJIcApjN4mJ/2j1u8HMt2rleOxP6riML3xY5z+L
         7pJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=4CVhXYMIL7ngreD3h590y5QJsOqcAB/B0UruGgDbpao=;
        b=bLmVh+JEjO7XPZoYKfRwo+goHIrKLISZ4QHUiMR56fwhIEggHRFEwSRYwShwhOdS8E
         M96A7eSYY+82XKM2gHbqcuK3iqGpaFN8+bPyQ7C/Bz02ufDKjDC2Jmc0bkqQlMNPAop4
         gA3ulhBtjQjOJ70AuDibAu0ehKPbk5IU+7t9kT88nwldukBElWx7vcvqbi0bx2+P+/dz
         UFwSr8kVyL61fDSl7WWHkxvet/hmAarLuLWyG4A2FnOAhQE1ckq9a4/kk/dUAiGELv+J
         CK7kMxSq8E8YVQ+eTnsn0cXnj2EOPes1IQUG0DE8cSeriUv/FMSmYDotOza6mfZHnGtt
         e0gg==
X-Gm-Message-State: APjAAAWHwW5lXO7iurAcvNCCR+5IQIiQdHIUhK7EXEV68WUPTmCyBLgm
        mEauC32lCsE3v7Xk18MnfNgWnB0x
X-Google-Smtp-Source: APXvYqyGEF+Z6KPkh+RZKk1b/x7jzQ20oMi8+tNvvrs/MKLB5w43OaZzDk+XJlT5A1UhkITqZRQldg==
X-Received: by 2002:a81:9a09:: with SMTP id r9mr2852836ywg.244.1581695415446;
        Fri, 14 Feb 2020 07:50:15 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o69sm2804046ywd.38.2020.02.14.07.50.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2020 07:50:14 -0800 (PST)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 01EFoEbC029175;
        Fri, 14 Feb 2020 15:50:14 GMT
Subject: [PATCH RFC 6/9] svcrdma: De-duplicate code that locates Write and
 Reply chunks
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 14 Feb 2020 10:50:14 -0500
Message-ID: <20200214155014.3848.84789.stgit@klimt.1015granger.net>
In-Reply-To: <20200214151427.3848.49739.stgit@klimt.1015granger.net>
References: <20200214151427.3848.49739.stgit@klimt.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Cache the locations of the first Write chunk and the Reply chunk so
that the Send path doesn't need to parse the Call header again.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h         |    2 ++
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   24 +++++++++++++-------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c   |   38 +++----------------------------
 3 files changed, 22 insertions(+), 42 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 04e4a34d1c6a..07baeb5f93c1 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -137,6 +137,8 @@ struct svc_rdma_recv_ctxt {
 	unsigned int		rc_page_count;
 	unsigned int		rc_hdr_count;
 	u32			rc_inv_rkey;
+	__be32			*rc_write_list;
+	__be32			*rc_reply_chunk;
 	unsigned int		rc_read_payload_offset;
 	unsigned int		rc_read_payload_length;
 	struct page		*rc_pages[RPCSVC_MAXPAGES];
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 2f16c0625226..91abe08f7d75 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -444,15 +444,17 @@ static __be32 *xdr_check_write_chunk(__be32 *p, const __be32 *end,
  * - This implementation supports only one Write chunk.
  *
  * Sanity checks:
- * - Write list does not overflow buffer.
+ * - Write list does not overflow Receive buffer.
  * - Segment size limited by largest NFS data payload.
  *
  * Returns pointer to the following Reply chunk.
  */
-static __be32 *xdr_check_write_list(__be32 *p, const __be32 *end)
+static __be32 *xdr_check_write_list(__be32 *p, const __be32 *end,
+				    struct svc_rdma_recv_ctxt *ctxt)
 {
 	u32 chcount;
 
+	ctxt->rc_write_list = p;
 	chcount = 0;
 	while (*p++ != xdr_zero) {
 		p = xdr_check_write_chunk(p, end, MAX_BYTES_WRITE_SEG);
@@ -461,6 +463,8 @@ static __be32 *xdr_check_write_list(__be32 *p, const __be32 *end)
 		if (chcount++ > 1)
 			return NULL;
 	}
+	if (!chcount)
+		ctxt->rc_write_list = NULL;
 	return p;
 }
 
@@ -472,13 +476,16 @@ static __be32 *xdr_check_write_list(__be32 *p, const __be32 *end)
  *
  * Returns pointer to the following RPC header.
  */
-static __be32 *xdr_check_reply_chunk(__be32 *p, const __be32 *end)
+static __be32 *xdr_check_reply_chunk(__be32 *p, const __be32 *end,
+				     struct svc_rdma_recv_ctxt *ctxt)
 {
+	ctxt->rc_reply_chunk = p;
 	if (*p++ != xdr_zero) {
 		p = xdr_check_write_chunk(p, end, MAX_BYTES_SPECIAL_SEG);
 		if (!p)
 			return NULL;
-	}
+	} else
+		ctxt->rc_reply_chunk = NULL;
 	return p;
 }
 
@@ -554,7 +561,8 @@ static void svc_rdma_get_inv_rkey(struct svcxprt_rdma *rdma,
  * Assumptions:
  * - The transport header is entirely contained in the head iovec.
  */
-static int svc_rdma_xdr_decode_req(struct xdr_buf *rq_arg)
+static int svc_rdma_xdr_decode_req(struct xdr_buf *rq_arg,
+				   struct svc_rdma_recv_ctxt *ctxt)
 {
 	__be32 *p, *end, *rdma_argp;
 	unsigned int hdr_len;
@@ -587,10 +595,10 @@ static int svc_rdma_xdr_decode_req(struct xdr_buf *rq_arg)
 	p = xdr_check_read_list(rdma_argp + 4, end);
 	if (!p)
 		goto out_inval;
-	p = xdr_check_write_list(p, end);
+	p = xdr_check_write_list(p, end, ctxt);
 	if (!p)
 		goto out_inval;
-	p = xdr_check_reply_chunk(p, end);
+	p = xdr_check_reply_chunk(p, end, ctxt);
 	if (!p)
 		goto out_inval;
 	if (p > end)
@@ -792,7 +800,7 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	rqstp->rq_next_page = rqstp->rq_respages;
 
 	p = (__be32 *)rqstp->rq_arg.head[0].iov_base;
-	ret = svc_rdma_xdr_decode_req(&rqstp->rq_arg);
+	ret = svc_rdma_xdr_decode_req(&rqstp->rq_arg, ctxt);
 	if (ret < 0)
 		goto out_err;
 	if (ret == 0)
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 40b4843be869..3c0e41d378bc 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -454,36 +454,6 @@ static void svc_rdma_xdr_encode_reply_chunk(__be32 *rdma_resp, __be32 *rp_ch,
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
@@ -842,14 +812,14 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
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

