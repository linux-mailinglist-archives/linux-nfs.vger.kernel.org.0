Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAA0172D46
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2020 01:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbgB1Aa4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Feb 2020 19:30:56 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55305 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbgB1Aa4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Feb 2020 19:30:56 -0500
Received: by mail-pj1-f65.google.com with SMTP id a18so501410pjs.5;
        Thu, 27 Feb 2020 16:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=PxXEbyCt2Y5aTckU+MyVu/CMPVJ9yuH9or7Jnd/zP6o=;
        b=TOqgQ9TsNg47yc1Fw0yWdvw6lZoCxHASK5LRVWiWzgVQW+48ondnDmbD4QRwYKICZb
         +cyq0aRu2lfuuKcEuOMkhp4siJzv6/Z6JJ5/OdlrzQmwKGaVzzaF0tkAntblCmFpEN3z
         2R2I7sT9v1s7RFf1k43LnT0Nvi4pEVph6yozmgP5nEJVAZzFa2t3OwWmGSnNCt4vsGd5
         7wq0oX5CjvrWnDD6Hkneb64YaOH7Uwo1o7CePh58CwzOb2Wg+1X82tO7u+HiVOrxLRoD
         g4vBkS7lLToyikWqAqbi+KTirumvqRom4sRcT8RdiGgCi+wCEaMYcp9oMuFNoHhWjvh+
         i3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=PxXEbyCt2Y5aTckU+MyVu/CMPVJ9yuH9or7Jnd/zP6o=;
        b=Sdf3Hlbhl2G2+sA0PFhQ3IAROjLL1olEtc0Avd8BPufSar8RbnuW0ERG9zcZqvpIaE
         tckF6VHptRkk0qdppNZmroKw8moFbzlYCSgcKMeJG8qc8NSnBOHQ7L6Qm/5kZraEMmPn
         89Jae5RzHoZiNHwr37zAlo7X0aXpWlTfnStctrQomNqBEDagvPIrvTgqqaengAxTfA0X
         nPHPmeJ8vjy31BrYqW3Wh6HgSL8twkv96w/+7Xn/P+cGhhuUkod1rnJP9P9tC6wOyDHr
         2e75tJLEx7119EG6VvnAqn22Bh5FJGCKYC60Ypzw/SOiaEtJ8zWc8uXsEWNeShYZVTqB
         KzZg==
X-Gm-Message-State: APjAAAUYZpsUgwE1k5pm07QvSgYadrGZsbwrx68FlBTPMBg2f7CoNUXS
        KH7bP4I6RBVab6DKZM+cT3qVTEXykto=
X-Google-Smtp-Source: APXvYqyjQXna0tMDUNC9GKxsMIW0LBEA1U21JcB+qx0SSuzMSMDC8RY26dkznuQMOy5WLUsoNnXgdg==
X-Received: by 2002:a17:90a:2565:: with SMTP id j92mr1675159pje.117.1582849854749;
        Thu, 27 Feb 2020 16:30:54 -0800 (PST)
Received: from seurat29.1015granger.net (ip-184-250-247-225.sanjca.spcsdns.net. [184.250.247.225])
        by smtp.gmail.com with ESMTPSA id w11sm7822133pgh.5.2020.02.27.16.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:30:54 -0800 (PST)
Subject: [PATCH v1 04/16] SUNRPC: Add xdr_pad_size() helper
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 27 Feb 2020 19:30:53 -0500
Message-ID: <158284985308.38468.4975436193883884123.stgit@seurat29.1015granger.net>
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

Introduce a helper function to compute the XDR pad size of a
variable-length XDR object.

Clean up: Replace open-coded calculation of XDR pad sizes.
I'm sure I haven't found every instance of this calculation.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/xdr.h            |   16 ++++++++++++++++
 net/sunrpc/auth_gss/auth_gss.c        |    4 ++--
 net/sunrpc/auth_gss/svcauth_gss.c     |    4 ++--
 net/sunrpc/xprtrdma/rpc_rdma.c        |    3 ++-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |    9 ++-------
 5 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index b41f34977995..80972512edfd 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -300,6 +300,22 @@ xdr_align_size(size_t n)
 	return (n + mask) & ~mask;
 }
 
+/**
+ * xdr_pad_size - Calculate size of an object's pad
+ * @n: Size of an object being XDR encoded (in bytes)
+ *
+ * This implementation avoids the need for conditional
+ * branches or modulo division.
+ *
+ * Return value:
+ *   Size (in bytes) of the needed XDR pad
+ */
+static inline size_t
+xdr_pad_size(size_t n)
+{
+	return xdr_align_size(n) - n;
+}
+
 /**
  * xdr_stream_encode_u32 - Encode a 32-bit integer
  * @xdr: pointer to xdr_stream
diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 24ca861815b1..60a8f46973dc 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -1877,7 +1877,7 @@ static int gss_wrap_req_priv(struct rpc_cred *cred, struct gss_cl_ctx *ctx,
 	else
 		iov = snd_buf->head;
 	p = iov->iov_base + iov->iov_len;
-	pad = 3 - ((snd_buf->len - offset - 1) & 3);
+	pad = xdr_pad_size(snd_buf->len - offset);
 	memset(p, 0, pad);
 	iov->iov_len += pad;
 	snd_buf->len += pad;
@@ -1949,7 +1949,7 @@ gss_unwrap_resp_integ(struct rpc_task *task, struct rpc_cred *cred,
 	if (unlikely(!p))
 		goto unwrap_failed;
 	integ_len = be32_to_cpup(p++);
-	if (integ_len & 3)
+	if (xdr_pad_size(integ_len))
 		goto unwrap_failed;
 	data_offset = (u8 *)(p) - (u8 *)rcv_buf->head[0].iov_base;
 	mic_offset = integ_len + data_offset;
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 65b67b257302..dd03096922c9 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -961,7 +961,7 @@ unwrap_priv_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct gs
 	/* XXX: This is very inefficient.  It would be better to either do
 	 * this while we encrypt, or maybe in the receive code, if we can peak
 	 * ahead and work out the service and mechanism there. */
-	offset = buf->head[0].iov_len % 4;
+	offset = xdr_pad_size(buf->head[0].iov_len);
 	if (offset) {
 		buf->buflen = RPCSVC_MAXPAYLOAD;
 		xdr_shift_buf(buf, offset);
@@ -1680,7 +1680,7 @@ svcauth_gss_wrap_resp_integ(struct svc_rqst *rqstp)
 		goto out;
 	integ_offset = (u8 *)(p + 1) - (u8 *)resbuf->head[0].iov_base;
 	integ_len = resbuf->len - integ_offset;
-	BUG_ON(integ_len % 4);
+	BUG_ON(xdr_pad_size(integ_len));
 	*p++ = htonl(integ_len);
 	*p++ = htonl(gc->gc_seq);
 	if (xdr_buf_subsegment(resbuf, &integ_buf, integ_offset, integ_len)) {
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 28020ec104d4..b51e92d43dfd 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -1305,7 +1305,8 @@ rpcrdma_decode_msg(struct rpcrdma_xprt *r_xprt, struct rpcrdma_rep *rep,
 	base = (char *)xdr_inline_decode(xdr, 0);
 	rpclen = xdr_stream_remaining(xdr);
 	r_xprt->rx_stats.fixup_copy_count +=
-		rpcrdma_inline_fixup(rqst, base, rpclen, writelist & 3);
+		rpcrdma_inline_fixup(rqst, base, rpclen,
+				     xdr_pad_size(writelist));
 
 	r_xprt->rx_stats.total_rdma_reply += writelist;
 	return rpclen + xdr_align_size(writelist);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 354c5619176a..4add875277f8 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -322,11 +322,6 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct ib_send_wr *wr)
 	return ret;
 }
 
-static u32 xdr_padsize(u32 len)
-{
-	return (len & 3) ? (4 - (len & 3)) : 0;
-}
-
 /* Returns length of transport header, in bytes.
  */
 static unsigned int svc_rdma_reply_hdr_len(__be32 *rdma_resp)
@@ -595,7 +590,7 @@ static int svc_rdma_pull_up_reply_msg(struct svcxprt_rdma *rdma,
 	if (wr_lst) {
 		u32 xdrpad;
 
-		xdrpad = xdr_padsize(xdr->page_len);
+		xdrpad = xdr_pad_size(xdr->page_len);
 		if (taillen && xdrpad) {
 			tailbase += xdrpad;
 			taillen -= xdrpad;
@@ -670,7 +665,7 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 	if (wr_lst) {
 		base = xdr->tail[0].iov_base;
 		len = xdr->tail[0].iov_len;
-		xdr_pad = xdr_padsize(xdr->page_len);
+		xdr_pad = xdr_pad_size(xdr->page_len);
 
 		if (len && xdr_pad) {
 			base += xdr_pad;

