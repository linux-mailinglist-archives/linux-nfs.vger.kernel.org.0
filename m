Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29A3714F349
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jan 2020 21:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgAaUmB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 31 Jan 2020 15:42:01 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44292 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgAaUmB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 31 Jan 2020 15:42:01 -0500
Received: by mail-yw1-f67.google.com with SMTP id t141so6049900ywc.11;
        Fri, 31 Jan 2020 12:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=bN014R4yAGrLyPnLZqtkVF6H+rJ1L3XEFy2WLZW7lsg=;
        b=G9rTYRRLK00lo7gnQw8w7fdimUCD9qOVDolugf4hxattWIyiuU2IB3q5vMaYzxpp9N
         oDcYSmVYKm/8spU1SXGT28vBz78p3jPyTPX6cpvUTcZg1qErlE9DYY6YwrVVEn3wd2Nh
         3CzM6lN9gQvELzEQ1vH6eTiSki8zIYKx4B9XMjfJDjmAwcGMtf0j0hrflGtoEhNca2AY
         gJb9FBdRw6aE/bo0dqxZytue4j/i3xD4W+8DG+NJsQtpqdHSBIMHKJ+1PZhUVOTAV7Xh
         /VUYwJgoz+4oO/gdDmWOZHZErU9jD8+YS6xwqo+O1vfLsBx3eAct2EGOFJLtYTwCv6mA
         EeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=bN014R4yAGrLyPnLZqtkVF6H+rJ1L3XEFy2WLZW7lsg=;
        b=gxy2ANJMUYHXhz7e+Z0p/jHx9kaeP70phNM9wKNIa1rshpKWVa6mXpJujsgvnJVUcw
         Zs8AQerdhx/VUXUEyIKjpOnnz/y2qzT0CpQP5VEOQhKZbBScyrH8RdjjpD0W2Wk+1NUc
         41me5vTHC2UH3YhjuAvx10aKmn0WwpB9KAr+LACzfoNRKfQjE1Ygr76XVXjwol9pez7H
         eS5jm4jje4Ly6G742JWsmNHaRl5ZV3nUzCAT7chwTtmIEFn0X0erk/qIwVsDlx0LCugg
         LilNs2hJGLKmY80qtbOu7l/0CHnMC2paJC5kfN1wSS1ToI2BhbNcSX0/QsWtyLz7WDtT
         0u/g==
X-Gm-Message-State: APjAAAWyVC24qq/vacKi0Lf5lymYvpOXAHVQq8OZL3lbcIYDgpHTuzfr
        rp5VvnyULPIgV72cglFmwy9DkP5d
X-Google-Smtp-Source: APXvYqyRsMxulMxaWmKdHzxsBE+xiAjMbbqx98aWtRo+x2JzxJvOFjdEQJYqQEB0ZoXGME4Ki/xEXg==
X-Received: by 2002:a25:bc85:: with SMTP id e5mr10130625ybk.184.1580503320045;
        Fri, 31 Jan 2020 12:42:00 -0800 (PST)
Received: from bazille.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d13sm4627715ywj.91.2020.01.31.12.41.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jan 2020 12:41:59 -0800 (PST)
Subject: [PATCH RFC2 3/3] NFSD: Enable nfsd4_encode_readv() for NFS/RDMA
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 31 Jan 2020 15:41:58 -0500
Message-ID: <20200131204158.31409.97424.stgit@bazille.1015granger.net>
In-Reply-To: <20200131203727.31409.63652.stgit@bazille.1015granger.net>
References: <20200131203727.31409.63652.stgit@bazille.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add new transport method: ->xpo_read_payload so that when a READ
payload does not fit exactly in rq_res's page vector, the XDR
encoder can inform the RPC transport exactly where that payload is.

That way, when a Write chunk is present, the transport knows what
byte range in the Reply message is supposed to be matched with the
chunk.

Note that the Linux NFS server implementation of NFS/RDMA can
currently handle only one Write chunk per RPC-over-RDMA message.
This simplifies the implementation of this fix.

Eventually, the new method could enable additional improvements:
- Support for clients that provision multiple Write chunks
- Support for sending Write chunks outside the transport mutex

Fixes: b04209806384 ("nfsd4: allow exotic read compounds")
Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=198053
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c                        |    1 +
 include/linux/sunrpc/svc.h               |    3 +++
 include/linux/sunrpc/svc_rdma.h          |    6 +++++-
 include/linux/sunrpc/svc_xprt.h          |    2 ++
 net/sunrpc/svc.c                         |   14 ++++++++++++++
 net/sunrpc/svcsock.c                     |    7 +++++++
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |    1 +
 net/sunrpc/xprtrdma/svc_rdma_rw.c        |   29 +++++++++++++++++++----------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    |   26 +++++++++++++++++++++++++-
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    1 +
 10 files changed, 78 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 92a6ada60932..e0e3e790e859 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3547,6 +3547,7 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 	read->rd_length = maxcount;
 	if (nfserr)
 		return nfserr;
+	svc_mark_read_payload(resp->rqstp, xdr->pos, read->rd_length);
 	xdr_truncate_encode(xdr, starting_len + 8 + ((maxcount+3)&~3));
 
 	tmp = htonl(eof);
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 1afe38eb33f7..e0610e0e34f7 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -517,6 +517,9 @@ int		   svc_register(const struct svc_serv *, struct net *, const int,
 void		   svc_reserve(struct svc_rqst *rqstp, int space);
 struct svc_pool *  svc_pool_for_cpu(struct svc_serv *serv, int cpu);
 char *		   svc_print_addr(struct svc_rqst *, char *, size_t);
+void		   svc_mark_read_payload(struct svc_rqst *rqstp,
+					 unsigned int pos,
+					 unsigned long length);
 unsigned int	   svc_fill_write_vector(struct svc_rqst *rqstp,
 					 struct page **pages,
 					 struct kvec *first, size_t total);
diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 40f65888dd38..4fd3b8a16dfd 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -137,6 +137,7 @@ struct svc_rdma_recv_ctxt {
 	unsigned int		rc_page_count;
 	unsigned int		rc_hdr_count;
 	u32			rc_inv_rkey;
+	unsigned long		rc_read_payload_length;
 	struct page		*rc_pages[RPCSVC_MAXPAGES];
 };
 
@@ -170,7 +171,8 @@ extern int svc_rdma_recv_read_chunk(struct svcxprt_rdma *rdma,
 				    struct svc_rqst *rqstp,
 				    struct svc_rdma_recv_ctxt *head, __be32 *p);
 extern int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
-				     __be32 *wr_ch, struct xdr_buf *xdr);
+				     __be32 *wr_ch, struct xdr_buf *xdr,
+				     struct svc_rdma_recv_ctxt *rctxt);
 extern int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 				     __be32 *rp_ch, bool writelist,
 				     struct xdr_buf *xdr);
@@ -189,6 +191,8 @@ extern int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 				  struct svc_rdma_send_ctxt *ctxt,
 				  struct xdr_buf *xdr, __be32 *wr_lst);
 extern int svc_rdma_sendto(struct svc_rqst *);
+extern void svc_rdma_read_payload(struct svc_rqst *rqstp, unsigned int pos,
+				  unsigned long length);
 
 /* svc_rdma_transport.c */
 extern int svc_rdma_create_listen(struct svc_serv *, int, struct sockaddr *);
diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index ea6f46be9cb7..d272acf7531f 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -21,6 +21,8 @@ struct svc_xprt_ops {
 	int		(*xpo_has_wspace)(struct svc_xprt *);
 	int		(*xpo_recvfrom)(struct svc_rqst *);
 	int		(*xpo_sendto)(struct svc_rqst *);
+	void		(*xpo_read_payload)(struct svc_rqst *, unsigned int,
+					    unsigned long);
 	void		(*xpo_release_rqst)(struct svc_rqst *);
 	void		(*xpo_detach)(struct svc_xprt *);
 	void		(*xpo_free)(struct svc_xprt *);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 187dd4e73d64..d4a0134f1ca1 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1637,6 +1637,20 @@ u32 svc_max_payload(const struct svc_rqst *rqstp)
 EXPORT_SYMBOL_GPL(svc_max_payload);
 
 /**
+ * svc_mark_read_payload - mark a range of bytes as a READ payload
+ * @rqstp: svc_rqst to operate on
+ * @pos: payload's byte offset in the RPC Reply message
+ * @length: size of payload, in bytes
+ *
+ */
+void svc_mark_read_payload(struct svc_rqst *rqstp, unsigned int pos,
+			   unsigned long length)
+{
+	rqstp->rq_xprt->xpt_ops->xpo_read_payload(rqstp, pos, length);
+}
+EXPORT_SYMBOL_GPL(svc_mark_read_payload);
+
+/**
  * svc_fill_write_vector - Construct data argument for VFS write call
  * @rqstp: svc_rqst to operate on
  * @pages: list of pages containing data payload
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 2934dd711715..fe045b3e7e08 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -279,6 +279,11 @@ static int svc_sendto(struct svc_rqst *rqstp, struct xdr_buf *xdr)
 	return len;
 }
 
+static void svc_sock_read_payload(struct svc_rqst *rqstp, unsigned int pos,
+				  unsigned long length)
+{
+}
+
 /*
  * Report socket names for nfsdfs
  */
@@ -653,6 +658,7 @@ static struct svc_xprt *svc_udp_create(struct svc_serv *serv,
 	.xpo_create = svc_udp_create,
 	.xpo_recvfrom = svc_udp_recvfrom,
 	.xpo_sendto = svc_udp_sendto,
+	.xpo_read_payload = svc_sock_read_payload,
 	.xpo_release_rqst = svc_release_udp_skb,
 	.xpo_detach = svc_sock_detach,
 	.xpo_free = svc_sock_free,
@@ -1171,6 +1177,7 @@ static struct svc_xprt *svc_tcp_create(struct svc_serv *serv,
 	.xpo_create = svc_tcp_create,
 	.xpo_recvfrom = svc_tcp_recvfrom,
 	.xpo_sendto = svc_tcp_sendto,
+	.xpo_read_payload = svc_sock_read_payload,
 	.xpo_release_rqst = svc_release_skb,
 	.xpo_detach = svc_tcp_sock_detach,
 	.xpo_free = svc_sock_free,
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 393af8624f53..90f0a9ce7521 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -191,6 +191,7 @@ void svc_rdma_recv_ctxts_destroy(struct svcxprt_rdma *rdma)
 
 out:
 	ctxt->rc_page_count = 0;
+	ctxt->rc_read_payload_length = 0;
 	return ctxt;
 
 out_empty:
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 467d40a1dffa..2cef19592565 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -484,18 +484,18 @@ static int svc_rdma_send_xdr_kvec(struct svc_rdma_write_info *info,
 				     vec->iov_len);
 }
 
-/* Send an xdr_buf's page list by itself. A Write chunk is
- * just the page list. a Reply chunk is the head, page list,
- * and tail. This function is shared between the two types
- * of chunk.
+/* Send an xdr_buf's page list by itself. A Write chunk is just
+ * the page list. A Reply chunk is @xdr's head, page list, and
+ * tail. This function is shared between the two types of chunk.
  */
 static int svc_rdma_send_xdr_pagelist(struct svc_rdma_write_info *info,
-				      struct xdr_buf *xdr)
+				      struct xdr_buf *xdr,
+				      unsigned int length)
 {
 	info->wi_xdr = xdr;
 	info->wi_next_off = 0;
 	return svc_rdma_build_writes(info, svc_rdma_pagelist_to_sg,
-				     xdr->page_len);
+				     length);
 }
 
 /**
@@ -503,6 +503,7 @@ static int svc_rdma_send_xdr_pagelist(struct svc_rdma_write_info *info,
  * @rdma: controlling RDMA transport
  * @wr_ch: Write chunk provided by client
  * @xdr: xdr_buf containing the data payload
+ * @rctxt: location in @xdr of the data payload
  *
  * Returns a non-negative number of bytes the chunk consumed, or
  *	%-E2BIG if the payload was larger than the Write chunk,
@@ -512,9 +513,11 @@ static int svc_rdma_send_xdr_pagelist(struct svc_rdma_write_info *info,
  *	%-EIO if rdma_rw initialization failed (DMA mapping, etc).
  */
 int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma, __be32 *wr_ch,
-			      struct xdr_buf *xdr)
+			      struct xdr_buf *xdr,
+			      struct svc_rdma_recv_ctxt *rctxt)
 {
 	struct svc_rdma_write_info *info;
+	unsigned int length;
 	int ret;
 
 	if (!xdr->page_len)
@@ -524,7 +527,12 @@ int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma, __be32 *wr_ch,
 	if (!info)
 		return -ENOMEM;
 
-	ret = svc_rdma_send_xdr_pagelist(info, xdr);
+	/* xdr->page_len is the chunk length, unless the upper layer
+	 * has explicitly provided a payload length.
+	 */
+	length = rctxt->rc_read_payload_length ?
+			rctxt->rc_read_payload_length : xdr->page_len;
+	ret = svc_rdma_send_xdr_pagelist(info, xdr, length);
 	if (ret < 0)
 		goto out_err;
 
@@ -533,7 +541,7 @@ int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma, __be32 *wr_ch,
 		goto out_err;
 
 	trace_svcrdma_encode_write(xdr->page_len);
-	return xdr->page_len;
+	return length;
 
 out_err:
 	svc_rdma_write_info_free(info);
@@ -573,7 +581,8 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma, __be32 *rp_ch,
 	 * client did not provide Write chunks.
 	 */
 	if (!writelist && xdr->page_len) {
-		ret = svc_rdma_send_xdr_pagelist(info, xdr);
+		ret = svc_rdma_send_xdr_pagelist(info, xdr,
+						 xdr->page_len);
 		if (ret < 0)
 			goto out_err;
 		consumed += xdr->page_len;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index a9ba040c70da..6f9b49b6768f 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -871,7 +871,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 
 	if (wr_lst) {
 		/* XXX: Presume the client sent only one Write chunk */
-		ret = svc_rdma_send_write_chunk(rdma, wr_lst, xdr);
+		ret = svc_rdma_send_write_chunk(rdma, wr_lst, xdr, rctxt);
 		if (ret < 0)
 			goto err2;
 		svc_rdma_xdr_encode_write_list(rdma_resp, wr_lst, ret);
@@ -913,3 +913,27 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	ret = -ENOTCONN;
 	goto out;
 }
+
+/**
+ * svc_rdma_read_payload - mark where a READ payload sites
+ * @rqstp: svc_rqst to operate on
+ * @pos: payload's byte offset in the RPC Reply message
+ * @length: size of payload, in bytes
+ *
+ * For the moment, just record the xdr_buf location of the READ
+ * payload. svc_rdma_sendto will use that location later when
+ * we actually send the payload.
+ */
+void svc_rdma_read_payload(struct svc_rqst *rqstp, unsigned int pos,
+			   unsigned long length)
+{
+	struct svc_rdma_recv_ctxt *ctxt = rqstp->rq_xprt_ctxt;
+
+	/* XXX: Just one READ payload slot for now, since our
+	 * transport implementation currently supports only one
+	 * Write chunk. We assume the one READ payload always
+	 * starts at the head<->pages boundary.
+	 */
+	WARN_ON(rqstp->rq_res.head[0].iov_len != pos);
+	ctxt->rc_read_payload_length = length;
+}
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 145a3615c319..f6aad2798063 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -82,6 +82,7 @@ static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
 	.xpo_create = svc_rdma_create,
 	.xpo_recvfrom = svc_rdma_recvfrom,
 	.xpo_sendto = svc_rdma_sendto,
+	.xpo_read_payload = svc_rdma_read_payload,
 	.xpo_release_rqst = svc_rdma_release_rqst,
 	.xpo_detach = svc_rdma_detach,
 	.xpo_free = svc_rdma_free,

