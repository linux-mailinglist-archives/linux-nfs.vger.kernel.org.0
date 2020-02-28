Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0325172D56
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2020 01:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbgB1Abj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Feb 2020 19:31:39 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33772 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbgB1Abj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Feb 2020 19:31:39 -0500
Received: by mail-pl1-f193.google.com with SMTP id ay11so510166plb.0;
        Thu, 27 Feb 2020 16:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=HqCLHXBDi5YxU/ZH3rQjRlio90XPc518A9HBjf6DjUY=;
        b=DGUOefFZ7jtZGwbwbgx8KLlzw/bQOTfBuxZtP1/SE0J95P/mihODUu21rIY/HpZkF8
         IPqi/pdUgt9ReFpMAJuMVHx62UgnEN8ysv/GhgZ25BUTmg8X4ZtAmWH3rIfvzbxCNuI7
         ctLkwHciiA4jNyjHmbmmLFV9KFUw95IRg5P0Vd8pqIobRZnaOfAR9xU4j+EHNYsoKEgW
         ezE1hcRYJld7qHX8z4qMjA1vdxxuPCzucGiiwM6rDX+/F5KbYZ+8Tj0WueTUUdmZu1tc
         PAsbSdiBVfuqqm5EWhTpSF6ERaUiAKd5lrIr7d7XNY2XDP9jqvXEzfg7Nr71iohjueYg
         j1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=HqCLHXBDi5YxU/ZH3rQjRlio90XPc518A9HBjf6DjUY=;
        b=Hp5C7Hk4ROqjlVMpkZFnL8VbrpFDxVDmC6Sm6g3igmEkqoNhqxyxBza4tP3dxdeCYg
         Bm4k+Yx5DdIS9J2bjO3VHUn+sXC8UV/s5/BFWMDVqLUWyNvlCbMAtUYQFjKOeFzgoAVJ
         5Bz2LWzRTB7o2isZ/NQ81hjdSXE5ZGkpI12w5FTo+YiwdE5PhW+GxFP6YoyK2r03AQza
         EmK9x8o1Nk+MMXm8GCwPTTsPHt9mON+F8eBTJfW8UZHU43iNET8064JDvIfFl/TUGfSJ
         d8vaEts/lt6G+dbbqGBSo7FNV3Xh18bpsZ+qi1Mch5k8nfKpwfFNKeml9rou4LO9x5nr
         M4EQ==
X-Gm-Message-State: APjAAAVhjg62hRt37jgbXT5jJs4ZFnywTPh9JorIB6u/W5/r1PRbA/Sv
        FHQWXXIcqa9UP/FKJ8Uhz/MUQSASfWY=
X-Google-Smtp-Source: APXvYqxus+jaaiOrufGiYBcLYd26bruKEY1QJjLEKQEhOIao55czhWYcsVSRAsMeTL4UbOdjSv5JsA==
X-Received: by 2002:a17:90b:3115:: with SMTP id gc21mr1648926pjb.54.1582849896045;
        Thu, 27 Feb 2020 16:31:36 -0800 (PST)
Received: from seurat29.1015granger.net (ip-184-250-247-225.sanjca.spcsdns.net. [184.250.247.225])
        by smtp.gmail.com with ESMTPSA id 200sm8585322pfz.121.2020.02.27.16.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:31:35 -0800 (PST)
Subject: [PATCH v1 10/16] svcrdma: Update synopsis of
 svc_rdma_map_reply_msg()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 27 Feb 2020 19:31:34 -0500
Message-ID: <158284989441.38468.8027058905721344778.stgit@seurat29.1015granger.net>
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

Preparing for subsequent patches, no behavior change expected.

Pass the RPC Call's svc_rdma_recv_ctxt deeper into the sendto()
path. This enables passing more information about Requester-
provided Write and Reply chunks into those lower-level functions.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h            |    5 +-
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |    2 -
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      |   80 +++++++++++++++++-----------
 3 files changed, 52 insertions(+), 35 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 42b68126cc60..c506732886b3 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -193,8 +193,9 @@ extern void svc_rdma_sync_reply_hdr(struct svcxprt_rdma *rdma,
 				    struct svc_rdma_send_ctxt *ctxt,
 				    unsigned int len);
 extern int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
-				  struct svc_rdma_send_ctxt *ctxt,
-				  struct xdr_buf *xdr, __be32 *wr_lst);
+				  struct svc_rdma_send_ctxt *sctxt,
+				  const struct svc_rdma_recv_ctxt *rctxt,
+				  struct xdr_buf *xdr);
 extern int svc_rdma_sendto(struct svc_rqst *);
 extern int svc_rdma_read_payload(struct svc_rqst *rqstp, unsigned int offset,
 				 unsigned int length);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
index 908e78bb87c6..ce1a7a706f36 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
@@ -117,7 +117,7 @@ static int svc_rdma_bc_sendto(struct svcxprt_rdma *rdma,
 {
 	int ret;
 
-	ret = svc_rdma_map_reply_msg(rdma, ctxt, &rqst->rq_snd_buf, NULL);
+	ret = svc_rdma_map_reply_msg(rdma, ctxt, NULL, &rqst->rq_snd_buf);
 	if (ret < 0)
 		return -EIO;
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 0b6ff55b1ab1..bc8863342878 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -502,13 +502,19 @@ void svc_rdma_sync_reply_hdr(struct svcxprt_rdma *rdma,
 				      DMA_TO_DEVICE);
 }
 
-/* If the xdr_buf has more elements than the device can
- * transmit in a single RDMA Send, then the reply will
- * have to be copied into a bounce buffer.
+/**
+ * svc_rdma_pull_up_needed - Determine whether to use pull-up
+ * @rdma: controlling transport
+ * @rctxt: Write and Reply chunks provided by client
+ * @xdr: xdr_buf containing RPC message to transmit
+ *
+ * Returns:
+ *	%true if pull-up must be used
+ *	%false otherwise
  */
 static bool svc_rdma_pull_up_needed(struct svcxprt_rdma *rdma,
-				    struct xdr_buf *xdr,
-				    __be32 *wr_lst)
+				    const struct svc_rdma_recv_ctxt *rctxt,
+				    struct xdr_buf *xdr)
 {
 	int elements;
 
@@ -516,7 +522,7 @@ static bool svc_rdma_pull_up_needed(struct svcxprt_rdma *rdma,
 	elements = 1;
 
 	/* xdr->pages */
-	if (!wr_lst) {
+	if (!rctxt || !rctxt->rc_write_list) {
 		unsigned int remaining;
 		unsigned long pageoff;
 
@@ -538,26 +544,35 @@ static bool svc_rdma_pull_up_needed(struct svcxprt_rdma *rdma,
 	return elements >= rdma->sc_max_send_sges;
 }
 
-/* The device is not capable of sending the reply directly.
- * Assemble the elements of @xdr into the transport header
- * buffer.
+/**
+ * svc_rdma_pull_up_reply_msg - Copy Reply into a single buffer
+ * @rdma: controlling transport
+ * @sctxt: send_ctxt for the Send WR
+ * @rctxt: Write and Reply chunks provided by client
+ * @xdr: prepared xdr_buf containing RPC message
+ *
+ * The device is not capable of sending the reply directly.
+ * Assemble the elements of @xdr into the transport header buffer.
+ *
+ * Returns zero on success, or a negative errno on failure.
  */
 static int svc_rdma_pull_up_reply_msg(struct svcxprt_rdma *rdma,
-				      struct svc_rdma_send_ctxt *ctxt,
-				      struct xdr_buf *xdr, __be32 *wr_lst)
+				      struct svc_rdma_send_ctxt *sctxt,
+				      const struct svc_rdma_recv_ctxt *rctxt,
+				      struct xdr_buf *xdr)
 {
 	unsigned char *dst, *tailbase;
 	unsigned int taillen;
 
-	dst = ctxt->sc_xprt_buf;
-	dst += ctxt->sc_sges[0].length;
+	dst = sctxt->sc_xprt_buf;
+	dst += sctxt->sc_sges[0].length;
 
 	memcpy(dst, xdr->head[0].iov_base, xdr->head[0].iov_len);
 	dst += xdr->head[0].iov_len;
 
 	tailbase = xdr->tail[0].iov_base;
 	taillen = xdr->tail[0].iov_len;
-	if (wr_lst) {
+	if (rctxt && rctxt->rc_write_list) {
 		u32 xdrpad;
 
 		xdrpad = xdr_pad_size(xdr->page_len);
@@ -586,10 +601,10 @@ static int svc_rdma_pull_up_reply_msg(struct svcxprt_rdma *rdma,
 	if (taillen)
 		memcpy(dst, tailbase, taillen);
 
-	ctxt->sc_sges[0].length += xdr->len;
+	sctxt->sc_sges[0].length += xdr->len;
 	ib_dma_sync_single_for_device(rdma->sc_pd->device,
-				      ctxt->sc_sges[0].addr,
-				      ctxt->sc_sges[0].length,
+				      sctxt->sc_sges[0].addr,
+				      sctxt->sc_sges[0].length,
 				      DMA_TO_DEVICE);
 
 	return 0;
@@ -597,9 +612,9 @@ static int svc_rdma_pull_up_reply_msg(struct svcxprt_rdma *rdma,
 
 /* svc_rdma_map_reply_msg - Map the buffer holding RPC message
  * @rdma: controlling transport
- * @ctxt: send_ctxt for the Send WR
+ * @sctxt: send_ctxt for the Send WR
+ * @rctxt: Write and Reply chunks provided by client
  * @xdr: prepared xdr_buf containing RPC message
- * @wr_lst: pointer to Call header's Write list, or NULL
  *
  * Load the xdr_buf into the ctxt's sge array, and DMA map each
  * element as it is added.
@@ -607,8 +622,9 @@ static int svc_rdma_pull_up_reply_msg(struct svcxprt_rdma *rdma,
  * Returns zero on success, or a negative errno on failure.
  */
 int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
-			   struct svc_rdma_send_ctxt *ctxt,
-			   struct xdr_buf *xdr, __be32 *wr_lst)
+			   struct svc_rdma_send_ctxt *sctxt,
+			   const struct svc_rdma_recv_ctxt *rctxt,
+			   struct xdr_buf *xdr)
 {
 	unsigned int len, remaining;
 	unsigned long page_off;
@@ -617,11 +633,11 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 	u32 xdr_pad;
 	int ret;
 
-	if (svc_rdma_pull_up_needed(rdma, xdr, wr_lst))
-		return svc_rdma_pull_up_reply_msg(rdma, ctxt, xdr, wr_lst);
+	if (svc_rdma_pull_up_needed(rdma, rctxt, xdr))
+		return svc_rdma_pull_up_reply_msg(rdma, sctxt, rctxt, xdr);
 
-	++ctxt->sc_cur_sge_no;
-	ret = svc_rdma_dma_map_buf(rdma, ctxt,
+	++sctxt->sc_cur_sge_no;
+	ret = svc_rdma_dma_map_buf(rdma, sctxt,
 				   xdr->head[0].iov_base,
 				   xdr->head[0].iov_len);
 	if (ret < 0)
@@ -632,7 +648,7 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 	 * have added XDR padding in the tail buffer, and that
 	 * should not be included inline.
 	 */
-	if (wr_lst) {
+	if (rctxt && rctxt->rc_write_list) {
 		base = xdr->tail[0].iov_base;
 		len = xdr->tail[0].iov_len;
 		xdr_pad = xdr_pad_size(xdr->page_len);
@@ -651,8 +667,8 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 	while (remaining) {
 		len = min_t(u32, PAGE_SIZE - page_off, remaining);
 
-		++ctxt->sc_cur_sge_no;
-		ret = svc_rdma_dma_map_page(rdma, ctxt, *ppages++,
+		++sctxt->sc_cur_sge_no;
+		ret = svc_rdma_dma_map_page(rdma, sctxt, *ppages++,
 					    page_off, len);
 		if (ret < 0)
 			return ret;
@@ -665,8 +681,8 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 	len = xdr->tail[0].iov_len;
 tail:
 	if (len) {
-		++ctxt->sc_cur_sge_no;
-		ret = svc_rdma_dma_map_buf(rdma, ctxt, base, len);
+		++sctxt->sc_cur_sge_no;
+		ret = svc_rdma_dma_map_buf(rdma, sctxt, base, len);
 		if (ret < 0)
 			return ret;
 	}
@@ -720,8 +736,8 @@ static int svc_rdma_send_reply_msg(struct svcxprt_rdma *rdma,
 	int ret;
 
 	if (!rp_ch) {
-		ret = svc_rdma_map_reply_msg(rdma, sctxt,
-					     &rqstp->rq_res, wr_lst);
+		ret = svc_rdma_map_reply_msg(rdma, sctxt, rctxt,
+					     &rqstp->rq_res);
 		if (ret < 0)
 			return ret;
 	}

