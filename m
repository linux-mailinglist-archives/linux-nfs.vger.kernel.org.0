Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 276FB15DBBB
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2020 16:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbgBNPtv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Feb 2020 10:49:51 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45471 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730228AbgBNPtv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Feb 2020 10:49:51 -0500
Received: by mail-yw1-f66.google.com with SMTP id a125so4419274ywe.12;
        Fri, 14 Feb 2020 07:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=tlq8aUoprJMWXpxoa50zOMDKiEEvhN58MkV638k1cfc=;
        b=nQxrCsoYLlmURJF7wJA7gxQa/wWUoujnxqMVKxD5WizKz4Wl+LYvEMj0wRB82GoFz4
         ZLZmbP7bYWj1djfb2H2VFf/GjFqCFUWjY0HI8kaxzMBFASVBc7SbjiIeXPuHbSUXJH4V
         7XzYurotGTJLfJR+4dUMDFjUmmlKJ6x1dEnTu1DT2uiXBkjYAAI0LujJkyApE7HwYjg/
         FVBbNzIG5uLd1q+FaBQmFDImmmJ1syLX3jgoh+k4nheE84DuEx1KV788hjEBUmX2a4Zo
         Ge6L5dlbkonKJYcwV62ezjFSy20iCXTBTkKS+aMZeyUdnQr3VqPey42iNhA7Ol0sazX6
         rKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=tlq8aUoprJMWXpxoa50zOMDKiEEvhN58MkV638k1cfc=;
        b=SdW+UCRCMa4Gp/98bhnTduVcd16SvmLYp7T2BuOfUZx4pdZ4RnOP1j5OjNir09pvmv
         f4B+LDEJoHdENJkks1IpKQg6B72tEZZYxYw81zUrDz+ke80XvLu/bUfElU/mJAoxt3U0
         ICC+Ja/vJuOkzveb8XpcLG37BgkphTacp6aMCgZ0L2sbvsx/hhSsSRLjqs8WgAzrmWer
         hexOdJkKHivpeCx/syPYJiHvGkphDHydgfB7QND8JB3pZnp/qFNm3/OMavXzPa75Ks21
         UthOJ0YBqB4d7vqnOJBf6HKvYXLer5e/BVUuY/NujtnklLGHIBviA0j/jTt6qVfTjcrG
         ma/w==
X-Gm-Message-State: APjAAAUQk793nrI7Sc2JzqJhi5hHxiIfQYgWX4yrCX//LPUuhHQ8GXff
        7LOa2/Q4Dm+BWomCddbdiE4kyphk
X-Google-Smtp-Source: APXvYqwktDGXK8uS6HZjmPZqh42AP8uwa8Nh6eitw2rTtBZijQV0gvpa74dbO2w5ngsAzCBdXfdVHw==
X-Received: by 2002:a81:7c06:: with SMTP id x6mr2947897ywc.500.1581695389003;
        Fri, 14 Feb 2020 07:49:49 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id l19sm2653627ywe.29.2020.02.14.07.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2020 07:49:48 -0800 (PST)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 01EFnlN9029150;
        Fri, 14 Feb 2020 15:49:47 GMT
Subject: [PATCH RFC 1/9] nfsd: Fix NFSv4 READ on RDMA when using readv
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 14 Feb 2020 10:49:47 -0500
Message-ID: <20200214154947.3848.12451.stgit@klimt.1015granger.net>
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

svcrdma expects that the payload falls precisely into the xdr_buf
page vector. This does not seem to be the case for
nfsd4_encode_readv().

This code is called only when fops->splice_read is missing or when
RQ_SPLICE_OK is clear, so it's not a noticeable problem in many
common cases.

Add new transport method: ->xpo_read_payload so that when a READ
payload does not fit exactly in rq_res's page vector, the XDR
encoder can inform the RPC transport exactly where that payload is,
without the payload's XDR pad.

That way, when a Write chunk is present, the transport knows what
byte range in the Reply message is supposed to be matched with the
chunk.

Note that the Linux NFS server implementation of NFS/RDMA can
currently handle only one Write chunk per RPC-over-RDMA message.
This simplifies the implementation of this fix.

Fixes: b04209806384 ("nfsd4: allow exotic read compounds")
Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=198053
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c                        |   20 ++++++++-------
 include/linux/sunrpc/svc.h               |    3 ++
 include/linux/sunrpc/svc_rdma.h          |    8 +++++-
 include/linux/sunrpc/svc_xprt.h          |    2 ++
 net/sunrpc/svc.c                         |   16 ++++++++++++
 net/sunrpc/svcsock.c                     |    8 ++++++
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |    1 +
 net/sunrpc/xprtrdma/svc_rdma_rw.c        |   30 ++++++++++++++---------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    |   40 +++++++++++++++++++++++++++++-
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    1 +
 10 files changed, 106 insertions(+), 23 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 9761512674a0..60be969d8be1 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3594,17 +3594,17 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 	u32 zzz = 0;
 	int pad;
 
+	/*
+	 * svcrdma requires every READ payload to start somewhere
+	 * in xdr->pages.
+	 */
+	if (xdr->iov == xdr->buf->head) {
+		xdr->iov = NULL;
+		xdr->end = xdr->p;
+	}
+
 	len = maxcount;
 	v = 0;
-
-	thislen = min_t(long, len, ((void *)xdr->end - (void *)xdr->p));
-	p = xdr_reserve_space(xdr, (thislen+3)&~3);
-	WARN_ON_ONCE(!p);
-	resp->rqstp->rq_vec[v].iov_base = p;
-	resp->rqstp->rq_vec[v].iov_len = thislen;
-	v++;
-	len -= thislen;
-
 	while (len) {
 		thislen = min_t(long, len, PAGE_SIZE);
 		p = xdr_reserve_space(xdr, (thislen+3)&~3);
@@ -3623,6 +3623,8 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 	read->rd_length = maxcount;
 	if (nfserr)
 		return nfserr;
+	if (svc_encode_read_payload(resp->rqstp, starting_len + 8, maxcount))
+		return nfserr_io;
 	xdr_truncate_encode(xdr, starting_len + 8 + ((maxcount+3)&~3));
 
 	tmp = htonl(eof);
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 1afe38eb33f7..82665ff360fd 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -517,6 +517,9 @@ int		   svc_register(const struct svc_serv *, struct net *, const int,
 void		   svc_reserve(struct svc_rqst *rqstp, int space);
 struct svc_pool *  svc_pool_for_cpu(struct svc_serv *serv, int cpu);
 char *		   svc_print_addr(struct svc_rqst *, char *, size_t);
+int		   svc_encode_read_payload(struct svc_rqst *rqstp,
+					   unsigned int offset,
+					   unsigned int length);
 unsigned int	   svc_fill_write_vector(struct svc_rqst *rqstp,
 					 struct page **pages,
 					 struct kvec *first, size_t total);
diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 40f65888dd38..04e4a34d1c6a 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -137,6 +137,8 @@ struct svc_rdma_recv_ctxt {
 	unsigned int		rc_page_count;
 	unsigned int		rc_hdr_count;
 	u32			rc_inv_rkey;
+	unsigned int		rc_read_payload_offset;
+	unsigned int		rc_read_payload_length;
 	struct page		*rc_pages[RPCSVC_MAXPAGES];
 };
 
@@ -170,7 +172,9 @@ extern int svc_rdma_recv_read_chunk(struct svcxprt_rdma *rdma,
 				    struct svc_rqst *rqstp,
 				    struct svc_rdma_recv_ctxt *head, __be32 *p);
 extern int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
-				     __be32 *wr_ch, struct xdr_buf *xdr);
+				     __be32 *wr_ch, struct xdr_buf *xdr,
+				     unsigned int offset,
+				     unsigned long length);
 extern int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 				     __be32 *rp_ch, bool writelist,
 				     struct xdr_buf *xdr);
@@ -189,6 +193,8 @@ extern int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 				  struct svc_rdma_send_ctxt *ctxt,
 				  struct xdr_buf *xdr, __be32 *wr_lst);
 extern int svc_rdma_sendto(struct svc_rqst *);
+extern int svc_rdma_read_payload(struct svc_rqst *rqstp, unsigned int offset,
+				 unsigned int length);
 
 /* svc_rdma_transport.c */
 extern int svc_rdma_create_listen(struct svc_serv *, int, struct sockaddr *);
diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index ea6f46be9cb7..9e1e046de176 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -21,6 +21,8 @@ struct svc_xprt_ops {
 	int		(*xpo_has_wspace)(struct svc_xprt *);
 	int		(*xpo_recvfrom)(struct svc_rqst *);
 	int		(*xpo_sendto)(struct svc_rqst *);
+	int		(*xpo_read_payload)(struct svc_rqst *, unsigned int,
+					    unsigned int);
 	void		(*xpo_release_rqst)(struct svc_rqst *);
 	void		(*xpo_detach)(struct svc_xprt *);
 	void		(*xpo_free)(struct svc_xprt *);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 187dd4e73d64..18676d36f490 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1637,6 +1637,22 @@ u32 svc_max_payload(const struct svc_rqst *rqstp)
 EXPORT_SYMBOL_GPL(svc_max_payload);
 
 /**
+ * svc_encode_read_payload - mark a range of bytes as a READ payload
+ * @rqstp: svc_rqst to operate on
+ * @offset: payload's byte offset in rqstp->rq_res
+ * @length: size of payload, in bytes
+ *
+ * Returns zero on success, or a negative errno if a permanent
+ * error occurred.
+ */
+int svc_encode_read_payload(struct svc_rqst *rqstp, unsigned int offset,
+			    unsigned int length)
+{
+	return rqstp->rq_xprt->xpt_ops->xpo_read_payload(rqstp, offset, length);
+}
+EXPORT_SYMBOL_GPL(svc_encode_read_payload);
+
+/**
  * svc_fill_write_vector - Construct data argument for VFS write call
  * @rqstp: svc_rqst to operate on
  * @pages: list of pages containing data payload
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 2934dd711715..758ab10690de 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -279,6 +279,12 @@ static int svc_sendto(struct svc_rqst *rqstp, struct xdr_buf *xdr)
 	return len;
 }
 
+static int svc_sock_read_payload(struct svc_rqst *rqstp, unsigned int offset,
+				 unsigned int length)
+{
+	return 0;
+}
+
 /*
  * Report socket names for nfsdfs
  */
@@ -653,6 +659,7 @@ static struct svc_xprt *svc_udp_create(struct svc_serv *serv,
 	.xpo_create = svc_udp_create,
 	.xpo_recvfrom = svc_udp_recvfrom,
 	.xpo_sendto = svc_udp_sendto,
+	.xpo_read_payload = svc_sock_read_payload,
 	.xpo_release_rqst = svc_release_udp_skb,
 	.xpo_detach = svc_sock_detach,
 	.xpo_free = svc_sock_free,
@@ -1171,6 +1178,7 @@ static struct svc_xprt *svc_tcp_create(struct svc_serv *serv,
 	.xpo_create = svc_tcp_create,
 	.xpo_recvfrom = svc_tcp_recvfrom,
 	.xpo_sendto = svc_tcp_sendto,
+	.xpo_read_payload = svc_sock_read_payload,
 	.xpo_release_rqst = svc_release_skb,
 	.xpo_detach = svc_tcp_sock_detach,
 	.xpo_free = svc_sock_free,
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 96bccd398469..71127d898562 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -193,6 +193,7 @@ void svc_rdma_recv_ctxts_destroy(struct svcxprt_rdma *rdma)
 
 out:
 	ctxt->rc_page_count = 0;
+	ctxt->rc_read_payload_length = 0;
 	return ctxt;
 
 out_empty:
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 48fe3b16b0d9..b0ac535c8728 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -482,18 +482,19 @@ static int svc_rdma_send_xdr_kvec(struct svc_rdma_write_info *info,
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
+				      unsigned int offset,
+				      unsigned long length)
 {
 	info->wi_xdr = xdr;
-	info->wi_next_off = 0;
+	info->wi_next_off = offset - xdr->head[0].iov_len;
 	return svc_rdma_build_writes(info, svc_rdma_pagelist_to_sg,
-				     xdr->page_len);
+				     length);
 }
 
 /**
@@ -501,6 +502,8 @@ static int svc_rdma_send_xdr_pagelist(struct svc_rdma_write_info *info,
  * @rdma: controlling RDMA transport
  * @wr_ch: Write chunk provided by client
  * @xdr: xdr_buf containing the data payload
+ * @offset: payload's byte offset in @xdr
+ * @length: size of payload, in bytes
  *
  * Returns a non-negative number of bytes the chunk consumed, or
  *	%-E2BIG if the payload was larger than the Write chunk,
@@ -510,19 +513,20 @@ static int svc_rdma_send_xdr_pagelist(struct svc_rdma_write_info *info,
  *	%-EIO if rdma_rw initialization failed (DMA mapping, etc).
  */
 int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma, __be32 *wr_ch,
-			      struct xdr_buf *xdr)
+			      struct xdr_buf *xdr,
+			      unsigned int offset, unsigned long length)
 {
 	struct svc_rdma_write_info *info;
 	int ret;
 
-	if (!xdr->page_len)
+	if (!length)
 		return 0;
 
 	info = svc_rdma_write_info_alloc(rdma, wr_ch);
 	if (!info)
 		return -ENOMEM;
 
-	ret = svc_rdma_send_xdr_pagelist(info, xdr);
+	ret = svc_rdma_send_xdr_pagelist(info, xdr, offset, length);
 	if (ret < 0)
 		goto out_err;
 
@@ -531,7 +535,7 @@ int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma, __be32 *wr_ch,
 		goto out_err;
 
 	trace_svcrdma_encode_write(xdr->page_len);
-	return xdr->page_len;
+	return length;
 
 out_err:
 	svc_rdma_write_info_free(info);
@@ -571,7 +575,9 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma, __be32 *rp_ch,
 	 * client did not provide Write chunks.
 	 */
 	if (!writelist && xdr->page_len) {
-		ret = svc_rdma_send_xdr_pagelist(info, xdr);
+		ret = svc_rdma_send_xdr_pagelist(info, xdr,
+						 xdr->head[0].iov_len,
+						 xdr->page_len);
 		if (ret < 0)
 			goto out_err;
 		consumed += xdr->page_len;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index f3f108090aa4..a11983c2056f 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -858,7 +858,18 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 
 	if (wr_lst) {
 		/* XXX: Presume the client sent only one Write chunk */
-		ret = svc_rdma_send_write_chunk(rdma, wr_lst, xdr);
+		unsigned long offset;
+		unsigned int length;
+
+		if (rctxt->rc_read_payload_length) {
+			offset = rctxt->rc_read_payload_offset;
+			length = rctxt->rc_read_payload_length;
+		} else {
+			offset = xdr->head[0].iov_len;
+			length = xdr->page_len;
+		}
+		ret = svc_rdma_send_write_chunk(rdma, wr_lst, xdr, offset,
+						length);
 		if (ret < 0)
 			goto err2;
 		svc_rdma_xdr_encode_write_list(rdma_resp, wr_lst, ret);
@@ -900,3 +911,30 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	ret = -ENOTCONN;
 	goto out;
 }
+
+/**
+ * svc_rdma_read_payload - special processing for a READ payload
+ * @rqstp: svc_rqst to operate on
+ * @offset: payload's byte offset in @xdr
+ * @length: size of payload, in bytes
+ *
+ * Returns zero on success.
+ *
+ * For the moment, just record the xdr_buf location of the READ
+ * payload. svc_rdma_sendto will use that location later when
+ * we actually send the payload.
+ */
+int svc_rdma_read_payload(struct svc_rqst *rqstp, unsigned int offset,
+			  unsigned int length)
+{
+	struct svc_rdma_recv_ctxt *rctxt = rqstp->rq_xprt_ctxt;
+
+	/* XXX: Just one READ payload slot for now, since our
+	 * transport implementation currently supports only one
+	 * Write chunk.
+	 */
+	rctxt->rc_read_payload_offset = offset;
+	rctxt->rc_read_payload_length = length;
+
+	return 0;
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

