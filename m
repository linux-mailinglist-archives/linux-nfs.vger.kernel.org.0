Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F92E29960D
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Oct 2020 19:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782952AbgJZSzQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Oct 2020 14:55:16 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38777 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781817AbgJZSzQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Oct 2020 14:55:16 -0400
Received: by mail-qt1-f194.google.com with SMTP id q26so7518658qtb.5;
        Mon, 26 Oct 2020 11:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=4KJm145UWBWPfJj4byRZtYjTtFKvdCbaxgLINuLuBEM=;
        b=obdQsOKvuaWgGgX7Jx/8jSfKJTYezF6B74jSK5bokLN+DohTX1g539hYvmuyRwF6fV
         wIkDZoIJGXfYE0SuFJa0LlGEIEDPqfpHjciiiNAzMr3ux3nHM2gposqi4JvSn/Ef89WJ
         8ol9uKhjENDSqGKaxnq0M0n4gBD8Fp76nmAFojhTSM31VSgad91OHd1zPe9WOtBk/wbq
         OfdjGUrv2GG6ZXiHO13m6zQeoSEfSlm3X/z7/a/gIv0G0C1r1jXzrEib098teTBTQE2S
         LY5deTgrdnayuuLb1CVmBqD/JmKBJyFUiBk+JNOjXed3pqkoXZGSnTvBym5GApFZnxw6
         hy0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=4KJm145UWBWPfJj4byRZtYjTtFKvdCbaxgLINuLuBEM=;
        b=DX0mV844NE3hTwcQbec0QpR3gBmpmuAcysHcn+kirWkzW0Dhv6c/SBmFlFoxnLb+vK
         O9B1U3C53BQ7L6WGzwk9W9L12uNZJPGdJuwmLA+RQZ1edLwSCo3RFSI+rd2lzamLxbBd
         jI4rzTlhEAm+A1Wkr+wJB4Q5ca8ndRvXp1pNUhyi9l8O+rYs5E/LecdADkVzwAkE+0ft
         zI8EbpaAHwUNtLhibTTpJYB51K4PsiYD/NNMyNTgfaD98CpZ53KNsewOa6VOJgPJm+aF
         +Y1XMWhaY74i+en0XirfFm4YrrjBLGKO3Pt+zLVUsdlb6JJw1Sc0oLZI8vMJp3Hrukyo
         kthA==
X-Gm-Message-State: AOAM532JYSMWRm60dJXr9ykWsnyYon/aSmkMMcTaJSXL7QUZ7aGSWd5v
        DFep/dw7SLEDQoiiVjuk28prVlEMTCM=
X-Google-Smtp-Source: ABdhPJwVYvqKAF+LlcfpjC970dojFcr7R/hIMLiiw5cVSmr3HR1UI0qjvqWXmZ5EvH6TKWVG9fihWA==
X-Received: by 2002:ac8:4c8e:: with SMTP id j14mr16556868qtv.223.1603738514105;
        Mon, 26 Oct 2020 11:55:14 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g27sm7171004qkk.135.2020.10.26.11.55.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 11:55:13 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 09QItCrh013658;
        Mon, 26 Oct 2020 18:55:12 GMT
Subject: [PATCH 15/20] svcrdma: Support multiple Write chunks in
 svc_rdma_send_reply_chunk
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 26 Oct 2020 14:55:12 -0400
Message-ID: <160373851247.1886.687426546558863258.stgit@klimt.1015granger.net>
In-Reply-To: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
References: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor svc_rdma_send_reply_chunk() so that it Sends only the parts
of rq_res that do not contain a result payload.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h   |    2 +-
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   36 +++++++++---------------------------
 2 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index e09fafba00d7..85fbec47d4b5 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -200,7 +200,7 @@ extern int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
 				     const struct xdr_buf *xdr);
 extern int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 				     const struct svc_rdma_recv_ctxt *rctxt,
-				     struct xdr_buf *xdr);
+				     const struct xdr_buf *xdr);
 
 /* svc_rdma_sendto.c */
 extern void svc_rdma_send_ctxts_destroy(struct svcxprt_rdma *rdma);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 05dd0896860f..4efa1fa3f6fb 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -535,7 +535,7 @@ static int svc_rdma_pages_write(struct svc_rdma_write_info *info,
 /**
  * svc_rdma_xb_write - Construct RDMA Writes to write an xdr_buf
  * @xdr: xdr_buf to write
- * @info: pointer to write arguments
+ * @data: pointer to write arguments
  *
  * Returns:
  *   On succes, returns zero
@@ -543,9 +543,9 @@ static int svc_rdma_pages_write(struct svc_rdma_write_info *info,
  *   %-ENOMEM if a resource has been exhausted
  *   %-EIO if an rdma-rw error occurred
  */
-static int svc_rdma_xb_write(const struct xdr_buf *xdr,
-			     struct svc_rdma_write_info *info)
+static int svc_rdma_xb_write(const struct xdr_buf *xdr, void *data)
 {
+	struct svc_rdma_write_info *info = data;
 	int ret;
 
 	if (xdr->head[0].iov_len) {
@@ -625,11 +625,11 @@ int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
  */
 int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 			      const struct svc_rdma_recv_ctxt *rctxt,
-			      struct xdr_buf *xdr)
+			      const struct xdr_buf *xdr)
 {
 	struct svc_rdma_write_info *info;
 	struct svc_rdma_chunk *chunk;
-	int consumed, ret;
+	int ret;
 
 	if (pcl_is_empty(&rctxt->rc_reply_pcl))
 		return 0;
@@ -639,35 +639,17 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 	if (!info)
 		return -ENOMEM;
 
-	ret = svc_rdma_iov_write(info, &xdr->head[0]);
+	ret = pcl_process_nonpayloads(&rctxt->rc_write_pcl, xdr,
+				      svc_rdma_xb_write, info);
 	if (ret < 0)
 		goto out_err;
-	consumed = xdr->head[0].iov_len;
-
-	/* Send the page list in the Reply chunk only if the
-	 * client did not provide Write chunks.
-	 */
-	if (pcl_is_empty(&rctxt->rc_write_pcl) && xdr->page_len) {
-		ret = svc_rdma_pages_write(info, xdr, xdr->head[0].iov_len,
-					   xdr->page_len);
-		if (ret < 0)
-			goto out_err;
-		consumed += xdr->page_len;
-	}
-
-	if (xdr->tail[0].iov_len) {
-		ret = svc_rdma_iov_write(info, &xdr->tail[0]);
-		if (ret < 0)
-			goto out_err;
-		consumed += xdr->tail[0].iov_len;
-	}
 
 	ret = svc_rdma_post_chunk_ctxt(&info->wi_cc);
 	if (ret < 0)
 		goto out_err;
 
-	trace_svcrdma_send_reply_chunk(consumed);
-	return consumed;
+	trace_svcrdma_send_reply_chunk(xdr->len);
+	return xdr->len;
 
 out_err:
 	svc_rdma_write_info_free(info);


