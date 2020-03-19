Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEF9518BAF0
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2020 16:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgCSPV0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Mar 2020 11:21:26 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:42728 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbgCSPV0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Mar 2020 11:21:26 -0400
Received: by mail-qv1-f67.google.com with SMTP id ca9so1178685qvb.9;
        Thu, 19 Mar 2020 08:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=gpO5ar6l5mf3CxyUoyQziF/JWwmHy57fKI7SFtAvMFI=;
        b=M7Ikn4fDyjNwqvpXEOzphdMtJIO9vT3y34Ig6HfNR+5f0iDZ3RpNV2ahnlHvJcKrWe
         b8LXMkFgTzoCtjumosSy9OjzMw+G355kHYSGyiu7lz9jMzH5mQ3urJjpIptRI09o9pOq
         vcrlvBF5Jj979h3cLq61sfB/ckyqEINO29ASzSHCWUspQ8f3TEagUQrVJfOrmVl2qyAA
         k+1ntjOH0BOom9Ph035I7zEUEO/JcbW3YvugzuU9GCfoqK3N3/CmhO9/nnc03FIUlfdM
         sn09qLSG6LZKiPPWqZJaQHBsMvAOxOJUpCzJfpQ53PXTfNpIcR4djTyMCHzPzBF7y9ic
         Q2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=gpO5ar6l5mf3CxyUoyQziF/JWwmHy57fKI7SFtAvMFI=;
        b=CMPrdfJSyXxZ2EJ0yVrQ4zBKjsXTVC7UAQggFnknlf6Mqj5O/ZVCqG51HgKH/9jAd6
         Wm6XOVrspsoHpa+TY7z5nBzkMP/WurWD9T9/ji+2KjhYWtRn0ivRKxw4bJ9Rm3EM4/Ps
         FjXT3lAtb5gVxMVxpmnwKQyDbG5/ind3JKDbSXHGeAWTL3WWFecxjBU4W323IZTvmaJo
         SCjRa7h7rCpAUEmICeAUyqfHphXd0dhjlWH3MqUNs72cq85SA5wfTEVSbLnykO+noYrE
         YVYwrw0BYWZex06nq5IURpxGesLfKnmr4FM+hAUBHXEq2fDNe3lwR++YEiRcXBpLfNQ5
         hxJw==
X-Gm-Message-State: ANhLgQ37Xg+A6y7JHSMK9cILzmahAFN9GT1L5bFRMdm8FRxkODjkc7iV
        D2SOfH9kHxGSUzagZ5zspytjVRrWVTk=
X-Google-Smtp-Source: ADFU+vsiEheXBND/xC1S5G06JovVh4Bt3dw35QXC6KwrMbHp59VSwGd2hLSJxqAR2ZDuVLQ8rjqkJw==
X-Received: by 2002:ad4:42ce:: with SMTP id f14mr3394240qvr.115.1584631283231;
        Thu, 19 Mar 2020 08:21:23 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id t123sm1695152qkc.81.2020.03.19.08.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 08:21:22 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 02JFLL12011178;
        Thu, 19 Mar 2020 15:21:21 GMT
Subject: [PATCH RFC 11/11] svcrdma: Support multiple Write chunks in
 svc_rdma_send_reply_chunk
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 19 Mar 2020 11:21:21 -0400
Message-ID: <20200319152121.16298.31324.stgit@klimt.1015granger.net>
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

This should be the last stop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h   |    2 +-
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   35 ++++++++---------------------------
 2 files changed, 9 insertions(+), 28 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 6f235d66e6fc..2ea119edae8f 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -187,7 +187,7 @@ extern int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
 				     __be32 *wr_ch, const struct xdr_buf *xdr);
 extern int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 				     const struct svc_rdma_recv_ctxt *rctxt,
-				     struct xdr_buf *xdr);
+				     const struct xdr_buf *xdr);
 
 /* svc_rdma_sendto.c */
 extern void svc_rdma_send_ctxts_destroy(struct svcxprt_rdma *rdma);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 5f326c18b47c..88dbcf9e580f 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -516,7 +516,7 @@ static int svc_rdma_pages_write(struct svc_rdma_write_info *info,
 /**
  * svc_rdma_xb_write - Construct RDMA Writes to write an xdr_buf
  * @xdr: xdr_buf to write
- * @info: pointer to write arguments
+ * @data: pointer to write arguments
  *
  * Returns:
  *   On succes, returns zero
@@ -524,9 +524,9 @@ static int svc_rdma_pages_write(struct svc_rdma_write_info *info,
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
@@ -605,10 +605,10 @@ int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma, __be32 *wr_ch,
  */
 int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 			      const struct svc_rdma_recv_ctxt *rctxt,
-			      struct xdr_buf *xdr)
+			      const struct xdr_buf *xdr)
 {
 	struct svc_rdma_write_info *info;
-	int consumed, ret;
+	int ret;
 
 	if (!rctxt->rc_reply_chunk)
 		return 0;
@@ -617,35 +617,16 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 	if (!info)
 		return -ENOMEM;
 
-	ret = svc_rdma_iov_write(info, &xdr->head[0]);
+	ret = svc_rdma_skip_payloads(xdr, rctxt, svc_rdma_xb_write, info);
 	if (ret < 0)
 		goto out_err;
-	consumed = xdr->head[0].iov_len;
-
-	/* Send the page list in the Reply chunk only if the
-	 * client did not provide Write chunks.
-	 */
-	if (!rctxt->rc_cur_payload && xdr->page_len) {
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

