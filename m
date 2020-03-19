Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 648B818BADD
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2020 16:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgCSPUh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Mar 2020 11:20:37 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43359 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbgCSPUh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Mar 2020 11:20:37 -0400
Received: by mail-qk1-f193.google.com with SMTP id x18so3378922qki.10;
        Thu, 19 Mar 2020 08:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=HMqB6B32gcebmHDDCkX4+KrgHIuxRBFp34c6lzvAzzU=;
        b=a+BMqUzQu4/bLLGeDQ+zSX6D8aRrZpujiAFBFAjrY9CXgfYt86/IfsTwHzLtRm7wcW
         eXcr8S2ZG2oWK9Jqlp1Yw19Uue/PtZNri7XI7h0XV0DUMLkocma6KyUqnttSn2zGP1hN
         ESuhmgzKxqu2eLtBFt8XQnSfLO0r2vabKqPc2IesZvUhow3qdKiq+WB9GjDRFHovdx/G
         q9aI7eImJB7yVSIP/TX7AHFGsdr9l8XOODPhurfEJd0lC4b+fJ2eysq8r+TPFpP0X/x8
         i+BkdOLDK68Vl388TgRkabLcON9mpcKpest/WokqWtFOFf61UoJWWQLX3HZtPLy553bf
         1eLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=HMqB6B32gcebmHDDCkX4+KrgHIuxRBFp34c6lzvAzzU=;
        b=KZc7taaNSkaWIJ4P3zBndiO9KE46RoI8gsRhptUa84K/MaUuIhbe2KOSp4dyrUDvyc
         /3USse8OrXgfu8VQfmdRtr+zHC/cNApsITuJ0fV5aDULS0JPNzMZktbR4YFpVJQOqIw5
         KEsYp3G0P647383tXdl+s+LUmweMExdsOobnlLoVyZDnQbxrziVpFttTi7E3LAICmZmq
         vuOOHy9N01dB81YAVJArwYIyPLr6zCLrJXdwW1tyN3S+LFmuAwaWnm1sZG02m1UEYi2M
         eUJD1SoUHPpLuYvCkHHISUJRBhLTTBW8fIgWJWRp8l37wMG3cIWkFl87PO4Amlg8hLew
         eIBw==
X-Gm-Message-State: ANhLgQ1TrlCZGSd59XIbl9E1DStS9etHkBr/6tqM0T37Q0CV0RaAkpU4
        QWebzu3/FJTCg1GUo0M60Bt5LWveBCA=
X-Google-Smtp-Source: ADFU+vtuiNfmEuAwKn19+gN8wSQ6P3/HVrmLKh/WrUqx5ka/9tast/eA7sVKZ8xLX3ppcTW4C1p3Ag==
X-Received: by 2002:a05:620a:715:: with SMTP id 21mr2909485qkc.81.1584631235430;
        Thu, 19 Mar 2020 08:20:35 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o14sm1694479qtq.12.2020.03.19.08.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 08:20:34 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 02JFKY6Y011151;
        Thu, 19 Mar 2020 15:20:34 GMT
Subject: [PATCH RFC 02/11] svcrdma: Clean up RDMA Write path
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 19 Mar 2020 11:20:34 -0400
Message-ID: <20200319152034.16298.54031.stgit@klimt.1015granger.net>
In-Reply-To: <20200319150136.16298.68813.stgit@klimt.1015granger.net>
References: <20200319150136.16298.68813.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Constify the xdr_buf argument to ensure the code here does not
modify it, to enable callers to also use "const struct xdr_buf *".

Also, rename the helper functions, which emit RDMA Writes, not
RDMA Sends.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index bd7c195d872e..529f00a6896c 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -161,7 +161,7 @@ struct svc_rdma_write_info {
 	__be32			*wi_segs;
 
 	/* SGL constructor arguments */
-	struct xdr_buf		*wi_xdr;
+	const struct xdr_buf	*wi_xdr;
 	unsigned char		*wi_base;
 	unsigned int		wi_next_off;
 
@@ -369,7 +369,7 @@ static void svc_rdma_pagelist_to_sg(struct svc_rdma_write_info *info,
 				    struct svc_rdma_rw_ctxt *ctxt)
 {
 	unsigned int sge_no, sge_bytes, page_off, page_no;
-	struct xdr_buf *xdr = info->wi_xdr;
+	const struct xdr_buf *xdr = info->wi_xdr;
 	struct scatterlist *sg;
 	struct page **page;
 
@@ -470,27 +470,22 @@ svc_rdma_build_writes(struct svc_rdma_write_info *info,
 	return -EIO;
 }
 
-/* Send one of an xdr_buf's kvecs by itself. To send a Reply
- * chunk, the whole RPC Reply is written back to the client.
- * This function writes either the head or tail of the xdr_buf
- * containing the Reply.
+/* RDMA Write an iov.
  */
-static int svc_rdma_send_xdr_kvec(struct svc_rdma_write_info *info,
-				  struct kvec *vec)
+static int svc_rdma_write_vec(struct svc_rdma_write_info *info,
+			      const struct kvec *vec)
 {
 	info->wi_base = vec->iov_base;
 	return svc_rdma_build_writes(info, svc_rdma_vec_to_sg,
 				     vec->iov_len);
 }
 
-/* Send an xdr_buf's page list by itself. A Write chunk is just
- * the page list. A Reply chunk is @xdr's head, page list, and
- * tail. This function is shared between the two types of chunk.
+/* RDMA Write an xdr_buf's page list by itself.
  */
-static int svc_rdma_send_xdr_pagelist(struct svc_rdma_write_info *info,
-				      struct xdr_buf *xdr,
-				      unsigned int offset,
-				      unsigned long length)
+static int svc_rdma_write_pages(struct svc_rdma_write_info *info,
+				const struct xdr_buf *xdr,
+				unsigned int offset,
+				unsigned long length)
 {
 	info->wi_xdr = xdr;
 	info->wi_next_off = offset - xdr->head[0].iov_len;
@@ -527,7 +522,7 @@ int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma, __be32 *wr_ch,
 	if (!info)
 		return -ENOMEM;
 
-	ret = svc_rdma_send_xdr_pagelist(info, xdr, offset, length);
+	ret = svc_rdma_write_pages(info, xdr, offset, length);
 	if (ret < 0)
 		goto out_err;
 
@@ -567,7 +562,7 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 	if (!info)
 		return -ENOMEM;
 
-	ret = svc_rdma_send_xdr_kvec(info, &xdr->head[0]);
+	ret = svc_rdma_write_vec(info, &xdr->head[0]);
 	if (ret < 0)
 		goto out_err;
 	consumed = xdr->head[0].iov_len;
@@ -576,16 +571,15 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 	 * client did not provide Write chunks.
 	 */
 	if (!rctxt->rc_write_list && xdr->page_len) {
-		ret = svc_rdma_send_xdr_pagelist(info, xdr,
-						 xdr->head[0].iov_len,
-						 xdr->page_len);
+		ret = svc_rdma_write_pages(info, xdr, xdr->head[0].iov_len,
+					   xdr->page_len);
 		if (ret < 0)
 			goto out_err;
 		consumed += xdr->page_len;
 	}
 
 	if (xdr->tail[0].iov_len) {
-		ret = svc_rdma_send_xdr_kvec(info, &xdr->tail[0]);
+		ret = svc_rdma_write_vec(info, &xdr->tail[0]);
 		if (ret < 0)
 			goto out_err;
 		consumed += xdr->tail[0].iov_len;

