Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D005614CDF7
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2020 17:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgA2QJg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Jan 2020 11:09:36 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39742 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgA2QJg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Jan 2020 11:09:36 -0500
Received: by mail-yw1-f65.google.com with SMTP id h126so68897ywc.6
        for <linux-nfs@vger.kernel.org>; Wed, 29 Jan 2020 08:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=YWb6W4W0bAey5G1twxdG8nPbjFaIcfh7a77eUBo17aw=;
        b=QQk5mpzV8w6qV/iXxag6TNa02XNpVpw4RY5v92/FmyHdb4AspLIrtM7Vz55hkbgLd0
         XBcaxRSM1933lv97EYiEEQT59sRisEjcOwd8BIHWtAH40rU+KdQrPHd8BZm4Q3Mv6eQy
         A8q22YPsV7a8ulDG9N6NFmNkz52U54Fvu66HhdhQBkSBe03+Xtes/NpfCYoP7u9N77HJ
         27R503vcFTt/kgP7jLfbGHdQceZPdNg1h+K8C5GazjTTUPVcMhS81p4J18/JKrel6AVt
         LA+DpyW35po07kfDyzsnAHoFHgZmPr/g7pF3o0/VXY45g7mujIlVwReVC3HQS3ZRukn5
         nBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=YWb6W4W0bAey5G1twxdG8nPbjFaIcfh7a77eUBo17aw=;
        b=RepqdqLjDhaONje5HUsFUpPSNitYoedTf+7tVlaqpzXQAuLJiSv0jUxZ8n7u0R1XaU
         TsipLW+6KO+wFrcvoB0snZVVqUpe/qFThgkBIfrBjLGFegB1kVMa58DQFCudyve3qoF+
         fdM2ZeedPKSu0wjM4zrsfkF51YaU0uY6J5q5jnNIWmACLR42LbctFfpaLL9kMYQRwlq1
         yaBfyGEadJLueqDfBSUgvYfIAoEcXcps2x4Ua5L36s9toQBs05g24TTKpgVPqR9T28LK
         QLSdnmfuvnaV+Ssp5DSfrjFn58CbBccGlnreC/2fpHMlm8O0we7SRNTIrODk/tmbXRxk
         7Rig==
X-Gm-Message-State: APjAAAV9EGPj741rJwS6saDCD+CguRuNJePyAPPZ7jMAkG/ZW8ZL88BT
        qVMNxXHfcls8PSjFhKkKd4s=
X-Google-Smtp-Source: APXvYqz0CezxXTfFJw3hKQ7ANmy5LlxbPn2NPcyvt7xIZ9rt2nzsR357QiY0rS7/g1qATedAMnIeKQ==
X-Received: by 2002:a81:49d2:: with SMTP id w201mr21094383ywa.123.1580314174884;
        Wed, 29 Jan 2020 08:09:34 -0800 (PST)
Received: from bazille.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id l39sm1159874ywk.36.2020.01.29.08.09.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jan 2020 08:09:34 -0800 (PST)
Subject: [PATCH RFC 2/8] SUNRPC: Add XDR infrastructure for automatically
 padding xdr_buf::pages
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 29 Jan 2020 11:09:33 -0500
Message-ID: <20200129160933.3024.87495.stgit@bazille.1015granger.net>
In-Reply-To: <20200129155516.3024.56575.stgit@bazille.1015granger.net>
References: <20200129155516.3024.56575.stgit@bazille.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Server/client agnostic API changes to support padding xdr_buf::pages
automatically.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/xdr.h |   74 ++++++++++++++++++++++++++++++++++----------
 net/sunrpc/svc.c           |    2 +
 net/sunrpc/svc_xprt.c      |   14 +++++---
 3 files changed, 67 insertions(+), 23 deletions(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index b41f34977995..47f55aad5a1e 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -24,6 +24,34 @@
  */
 #define XDR_QUADLEN(l)		(((l) + 3) >> 2)
 
+/**
+ * xdr_align_size - Calculate padded size of an object
+ * @n: Size of an object being XDR encoded (in bytes)
+ *
+ * Return value:
+ *   Size (in bytes) of the object including xdr padding
+ */
+static inline size_t
+xdr_align_size(size_t n)
+{
+	const size_t mask = sizeof(__u32) - 1;
+
+	return (n + mask) & ~mask;
+}
+
+/**
+ * xdr_pad_size - Calculate XDR padding size
+ * @len: Actual size of object being XDR encoded (in bytes)
+ *
+ * Return value:
+ *   Size (in bytes) of needed XDR padding
+ */
+static inline size_t
+xdr_pad_size(size_t len)
+{
+	return xdr_align_size(len) - len;
+}
+
 /*
  * Generic opaque `network object.' At the kernel level, this type
  * is used only by lockd.
@@ -39,9 +67,6 @@ struct xdr_netobj {
  * Features a header (for a linear buffer containing RPC headers
  * and the data payload for short messages), and then an array of
  * pages.
- * The tail iovec allows you to append data after the page array. Its
- * main interest is for appending padding to the pages in order to
- * satisfy the int_32-alignment requirements in RFC1832.
  *
  * For the future, we might want to string several of these together
  * in a list if anybody wants to make use of NFSv4 COMPOUND
@@ -55,6 +80,7 @@ struct xdr_buf {
 	struct page **	pages;		/* Array of pages */
 	unsigned int	page_base,	/* Start of page data */
 			page_len,	/* Length of page data */
+			page_pad,	/* XDR padding needed for pages */
 			flags;		/* Flags for data disposition */
 #define XDRBUF_READ		0x01		/* target of file read */
 #define XDRBUF_WRITE		0x02		/* source of file write */
@@ -72,11 +98,39 @@ struct xdr_buf {
 	buf->tail[0].iov_len = 0;
 	buf->pages = NULL;
 	buf->page_len = 0;
+	buf->page_pad = 0;
 	buf->flags = 0;
 	buf->len = 0;
 	buf->buflen = len;
 }
 
+/**
+ * xdr_buf_set_pagelen - Set the length of the page list
+ * @buf: XDR buffer containing a message
+ * @len: Size of @buf's page list (in bytes)
+ *
+ */
+static inline void
+xdr_buf_set_pagelen(struct xdr_buf *buf, size_t len)
+{
+	buf->page_len = len;
+	buf->page_pad = xdr_pad_size(len);
+}
+
+/**
+ * xdr_buf_msglen - Return the length of the content in @buf
+ * @buf: XDR buffer containing an XDR-encoded message
+ *
+ * Return value:
+ *   Size (in bytes) of the content in @buf
+ */
+static inline size_t
+xdr_buf_msglen(const struct xdr_buf *buf)
+{
+	return buf->head[0].iov_len + buf->page_len + buf->page_pad +
+		buf->tail[0].iov_len;
+}
+
 /*
  * pre-xdr'ed macros.
  */
@@ -285,20 +339,6 @@ ssize_t xdr_stream_decode_string(struct xdr_stream *xdr, char *str,
 		size_t size);
 ssize_t xdr_stream_decode_string_dup(struct xdr_stream *xdr, char **str,
 		size_t maxlen, gfp_t gfp_flags);
-/**
- * xdr_align_size - Calculate padded size of an object
- * @n: Size of an object being XDR encoded (in bytes)
- *
- * Return value:
- *   Size (in bytes) of the object including xdr padding
- */
-static inline size_t
-xdr_align_size(size_t n)
-{
-	const size_t mask = sizeof(__u32) - 1;
-
-	return (n + mask) & ~mask;
-}
 
 /**
  * xdr_stream_encode_u32 - Encode a 32-bit integer
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 187dd4e73d64..63a3afac7100 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1516,7 +1516,7 @@ static __printf(2,3) void svc_printk(struct svc_rqst *rqstp, const char *fmt, ..
 	rqstp->rq_res.pages = rqstp->rq_respages + 1;
 	rqstp->rq_res.len = 0;
 	rqstp->rq_res.page_base = 0;
-	rqstp->rq_res.page_len = 0;
+	xdr_buf_set_pagelen(&rqstp->rq_res, 0);
 	rqstp->rq_res.buflen = PAGE_SIZE;
 	rqstp->rq_res.tail[0].iov_base = NULL;
 	rqstp->rq_res.tail[0].iov_len = 0;
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index de3c077733a7..032c3bc91d43 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -510,7 +510,7 @@ static void svc_xprt_release(struct svc_rqst *rqstp)
 	rqstp->rq_deferred = NULL;
 
 	svc_free_res_pages(rqstp);
-	rqstp->rq_res.page_len = 0;
+	xdr_buf_set_pagelen(&rqstp->rq_res, 0);
 	rqstp->rq_res.page_base = 0;
 
 	/* Reset response buffer and release
@@ -666,7 +666,7 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
 	arg->pages = rqstp->rq_pages + 1;
 	arg->page_base = 0;
 	/* save at least one page for response */
-	arg->page_len = (pages-2)*PAGE_SIZE;
+	xdr_buf_set_pagelen(arg, (pages - 2) << PAGE_SHIFT);
 	arg->len = (pages-1)*PAGE_SIZE;
 	arg->tail[0].iov_len = 0;
 	return 0;
@@ -902,9 +902,13 @@ int svc_send(struct svc_rqst *rqstp)
 
 	/* calculate over-all length */
 	xb = &rqstp->rq_res;
-	xb->len = xb->head[0].iov_len +
-		xb->page_len +
-		xb->tail[0].iov_len;
+	xb->len = xdr_buf_msglen(xb);
+	if ((xb->head[0].iov_len & 3) != 0)
+		trace_printk("head=[%p,%zu] page=%u/%u tail=[%p,%zu] msglen=%zu buflen=%u",
+			xb->head[0].iov_base, xb->head[0].iov_len,
+			xb->page_len, xb->page_pad,
+			xb->tail[0].iov_base, xb->tail[0].iov_len,
+			xdr_buf_msglen(xb), xb->buflen);
 
 	/* Grab mutex to serialize outgoing data. */
 	mutex_lock(&xprt->xpt_mutex);

