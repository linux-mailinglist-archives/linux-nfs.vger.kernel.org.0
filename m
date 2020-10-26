Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C9C2995EB
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Oct 2020 19:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1790490AbgJZSyN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Oct 2020 14:54:13 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:41532 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1790983AbgJZSyL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Oct 2020 14:54:11 -0400
Received: by mail-qv1-f67.google.com with SMTP id t20so4804891qvv.8;
        Mon, 26 Oct 2020 11:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=5rXx/16uib6np7VcLhT7mPqPQTU8gPTikD6nti0nPkM=;
        b=QflcznoL1pqRsgK0u3urRKjkBYQ5IjcBl1uxYSOHHRnG8x8ZUfXGzaH8fCzFmvspgf
         BBWlCbAy0sI2pMmmz6wfxPbUmZZYaId07DsO0chlgp2eh3AN+lkG+j/2GHdTBhODL5lX
         D08OtYsewGWz8Eh+c3zinzQfaMOgzoT4qiXJ17BH/OIPblj6FMEZU/z5hgzjxcp8s+F5
         XneV9g045RBpHyglXSISOB0rlfMBJsQuu1REhoNf0Bx2J/I+7rSvmlEIj+G8NHU6cREF
         q2AphsNUd26IzXPOkTE61g/UdzCzWpzTOx7ce7cxFjBXeFaWyOaa8nj9GuAqxbSxBwMI
         /qFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=5rXx/16uib6np7VcLhT7mPqPQTU8gPTikD6nti0nPkM=;
        b=I+l3TIKkVlyVYMYxWLqS/B4xJck3ownCdsCNHgqhpE8zWC/ZcD8JMnPwE8NU0ECmeS
         kRVdtF+wpccgI8ZLleXolcGKGrHV7MSOzcRMbMlxmf4wgKH0mIZTpQilriG4sSXzTlHD
         RXcI4HI5nWu2DQvkWfACq9Hf34TalZ6Gwl8AuoxGinK65/RsKYOWpvn7FSh92voW8nFP
         DXl4XlV1KWo5/PI4Hlhuo8Uxk2TFKCR0t3yAj9HVhH8ov0Y7EsXULn24DtYCqHtXe3Jy
         1Da+AhYt5xzJDXBq5D6Od/3zIHDEsZUL3FLmtIMu4jTNNLfF0F7Qj3a1awSNZDXRxgfK
         /cQA==
X-Gm-Message-State: AOAM531wn9zPNJHXAiialnuv/FA3X/OAkuIlznWJbkL2thuwskyXJn8S
        0joTyYCCNDGicNSUPNnPe6pL0N/taGE=
X-Google-Smtp-Source: ABdhPJxFUrGyOB/SSZNPD2te7SpWiQvih7piu3T+wIMlFnZuOhFlgTK+v44UHmKuKbx8nl00eeFH7g==
X-Received: by 2002:a0c:8d05:: with SMTP id r5mr15704324qvb.31.1603738450538;
        Mon, 26 Oct 2020 11:54:10 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 185sm7035475qke.16.2020.10.26.11.54.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 11:54:09 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 09QIs821013622;
        Mon, 26 Oct 2020 18:54:08 GMT
Subject: [PATCH 03/20] svcrdma: Refactor the RDMA Write path
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 26 Oct 2020 14:54:08 -0400
Message-ID: <160373844889.1886.5773551832943365156.stgit@klimt.1015granger.net>
In-Reply-To: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
References: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor for subsequent changes.

Constify the xdr_buf argument to ensure the code here does not
modify it, and to enable callers to pass in a
"const struct xdr_buf *".

At the same time, rename the helper functions, which emit RDMA
Writes, not RDMA Sends, and add documenting comments.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   56 +++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index d8b2e22c56c1..03c32b441d32 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -493,27 +493,42 @@ svc_rdma_build_writes(struct svc_rdma_write_info *info,
 	return -E2BIG;
 }
 
-/* Send one of an xdr_buf's kvecs by itself. To send a Reply
- * chunk, the whole RPC Reply is written back to the client.
- * This function writes either the head or tail of the xdr_buf
- * containing the Reply.
+/**
+ * svc_rdma_iov_write - Construct RDMA Writes from an iov
+ * @info: pointer to write arguments
+ * @iov: kvec to write
+ *
+ * Returns:
+ *   On succes, returns zero
+ *   %-E2BIG if the client-provided Write chunk is too small
+ *   %-ENOMEM if a resource has been exhausted
+ *   %-EIO if an rdma-rw error occurred
  */
-static int svc_rdma_send_xdr_kvec(struct svc_rdma_write_info *info,
-				  struct kvec *vec)
+static int svc_rdma_iov_write(struct svc_rdma_write_info *info,
+			      const struct kvec *iov)
 {
-	info->wi_base = vec->iov_base;
+	info->wi_base = iov->iov_base;
 	return svc_rdma_build_writes(info, svc_rdma_vec_to_sg,
-				     vec->iov_len);
+				     iov->iov_len);
 }
 
-/* Send an xdr_buf's page list by itself. A Write chunk is just
- * the page list. A Reply chunk is @xdr's head, page list, and
- * tail. This function is shared between the two types of chunk.
+/**
+ * svc_rdma_pages_write - Construct RDMA Writes from pages
+ * @info: pointer to write arguments
+ * @xdr: xdr_buf with pages to write
+ * @offset: offset into the content of @xdr
+ * @length: number of bytes to write
+ *
+ * Returns:
+ *   On succes, returns zero
+ *   %-E2BIG if the client-provided Write chunk is too small
+ *   %-ENOMEM if a resource has been exhausted
+ *   %-EIO if an rdma-rw error occurred
  */
-static int svc_rdma_send_xdr_pagelist(struct svc_rdma_write_info *info,
-				      struct xdr_buf *xdr,
-				      unsigned int offset,
-				      unsigned long length)
+static int svc_rdma_pages_write(struct svc_rdma_write_info *info,
+				const struct xdr_buf *xdr,
+				unsigned int offset,
+				unsigned long length)
 {
 	info->wi_xdr = xdr;
 	info->wi_next_off = offset - xdr->head[0].iov_len;
@@ -550,7 +565,7 @@ int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma, __be32 *wr_ch,
 	if (!info)
 		return -ENOMEM;
 
-	ret = svc_rdma_send_xdr_pagelist(info, xdr, offset, length);
+	ret = svc_rdma_pages_write(info, xdr, offset, length);
 	if (ret < 0)
 		goto out_err;
 
@@ -590,7 +605,7 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 	if (!info)
 		return -ENOMEM;
 
-	ret = svc_rdma_send_xdr_kvec(info, &xdr->head[0]);
+	ret = svc_rdma_iov_write(info, &xdr->head[0]);
 	if (ret < 0)
 		goto out_err;
 	consumed = xdr->head[0].iov_len;
@@ -599,16 +614,15 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 	 * client did not provide Write chunks.
 	 */
 	if (!rctxt->rc_write_list && xdr->page_len) {
-		ret = svc_rdma_send_xdr_pagelist(info, xdr,
-						 xdr->head[0].iov_len,
-						 xdr->page_len);
+		ret = svc_rdma_pages_write(info, xdr, xdr->head[0].iov_len,
+					   xdr->page_len);
 		if (ret < 0)
 			goto out_err;
 		consumed += xdr->page_len;
 	}
 
 	if (xdr->tail[0].iov_len) {
-		ret = svc_rdma_send_xdr_kvec(info, &xdr->tail[0]);
+		ret = svc_rdma_iov_write(info, &xdr->tail[0]);
 		if (ret < 0)
 			goto out_err;
 		consumed += xdr->tail[0].iov_len;


