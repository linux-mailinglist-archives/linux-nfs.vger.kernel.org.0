Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8556246E98
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Aug 2020 19:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388537AbgHQRdm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Aug 2020 13:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389099AbgHQQxP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Aug 2020 12:53:15 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B18C061344
        for <linux-nfs@vger.kernel.org>; Mon, 17 Aug 2020 09:53:13 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id g19so18289617ioh.8
        for <linux-nfs@vger.kernel.org>; Mon, 17 Aug 2020 09:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/SxUNl+jSH6Huy97tnl5zQzeoQGswbqbvVa0pe7sWZQ=;
        b=eutV8oXGsB32bc/7mIbre4yAY5qRTQHd8wGNVf4H8485rQ7F4mTFtkoSld+ZBvzAz2
         TzQsFISgDNC5k/i5frpRQFBrR+4XsKfJ9cxC++QHG3aesRpxECrA2zKxbM6UR0Tl8zLa
         OZiBeXrZCT6KFw1L3vTYp2DN82aJ/LbaVYnRQfR7tSTVmV6A1hCgiO98SAvlQIIRE8Qx
         ybvKiBUMTgg00UlH3nMkjQKxnpogabFqFPtg2d9eUoDbkJku23BKfaYl9shogsJCrCcM
         V1hLjJytsZtEQ0UwSOUbtOlOpZZ/kNrvU6sDDiR5L+tDPtZe10OQsGt25Oij/FU+uBCH
         O14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/SxUNl+jSH6Huy97tnl5zQzeoQGswbqbvVa0pe7sWZQ=;
        b=fVepb+1rX7MjuB76QJe2aNrVUypWlZKdWusscm6VVQ3xluwvhXZ9Thj0AzwVXFqCfr
         GmNJMMiNhLIdm6LMOcEfWOMgYoS/k/+nMu3dc5ho3HyQrXJB9ImRKNTMv+b/trR2Zpan
         xuO1ss1xkH8wU9EPteG53yA78LQHv/QKQDXOkn0bVa5fy8FBsYtdUg0k7ztyaGWpm4oQ
         1/DTTjSs5B2K1nLum+KEA0HlOLbi3fMQDeT1UuDeIzkQCDYZzG27HefPrUhBnWiLORQ3
         eQb5+alR1QQMZV7b9GcMfa/Sff7REovXOoLvyPvvQFGlTPeWWdm/Bpuz2QY3yzx2Urz6
         n3BQ==
X-Gm-Message-State: AOAM531AMuO2LMPdYrqTiDUrYCpl72eIlx9TwBx7mTFTxd09H7oj6A2g
        lz+b/AuKtEAp2wNiR3ZKmAw=
X-Google-Smtp-Source: ABdhPJx1cLuKtOxKAx3rmidxB8wpOTYUrdz3NjcBA3YJ8I8EwTzB66LKB1mvLL0fzDn16+dSxH/MqQ==
X-Received: by 2002:a02:7691:: with SMTP id z139mr15877294jab.6.1597683192843;
        Mon, 17 Aug 2020 09:53:12 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id s3sm9410039iol.49.2020.08.17.09.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 09:53:12 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, chuck.lever@oracle.com,
        linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v4 1/5] SUNRPC/NFSD: Implement xdr_reserve_space_vec()
Date:   Mon, 17 Aug 2020 12:53:06 -0400
Message-Id: <20200817165310.354092-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817165310.354092-1-Anna.Schumaker@Netapp.com>
References: <20200817165310.354092-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Reserving space for a large READ payload requires special handling when
reserving space in the xdr buffer pages. One problem we can have is use
of the scratch buffer, which is used to get a pointer to a contiguous
region of data up to PAGE_SIZE. When using the scratch buffer, calls to
xdr_commit_encode() shift the data to it's proper alignment in the xdr
buffer. If we've reserved several pages in a vector, then this could
potentially invalidate earlier pointers and result in incorrect READ
data being sent to the client.

I get around this by looking at the amount of space left in the current
page, and never reserve more than that for each entry in the read
vector. This lets us place data directly where it needs to go in the
buffer pages.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfsd/nfs4xdr.c          | 28 +++---------------------
 include/linux/sunrpc/xdr.h |  2 ++
 net/sunrpc/xdr.c           | 45 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 25 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 996ac01ee977..6a1c0a7fae05 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3584,36 +3584,14 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 {
 	struct xdr_stream *xdr = &resp->xdr;
 	u32 eof;
-	int v;
 	int starting_len = xdr->buf->len - 8;
-	long len;
-	int thislen;
 	__be32 nfserr;
 	__be32 tmp;
-	__be32 *p;
 	int pad;
 
-	/*
-	 * svcrdma requires every READ payload to start somewhere
-	 * in xdr->pages.
-	 */
-	if (xdr->iov == xdr->buf->head) {
-		xdr->iov = NULL;
-		xdr->end = xdr->p;
-	}
-
-	len = maxcount;
-	v = 0;
-	while (len) {
-		thislen = min_t(long, len, PAGE_SIZE);
-		p = xdr_reserve_space(xdr, thislen);
-		WARN_ON_ONCE(!p);
-		resp->rqstp->rq_vec[v].iov_base = p;
-		resp->rqstp->rq_vec[v].iov_len = thislen;
-		v++;
-		len -= thislen;
-	}
-	read->rd_vlen = v;
+	read->rd_vlen = xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, maxcount);
+	if (read->rd_vlen < 0)
+		return nfserr_resource;
 
 	nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
 			    resp->rqstp->rq_vec, read->rd_vlen, &maxcount,
diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 22c207b2425f..bac459584dd0 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -234,6 +234,8 @@ typedef int	(*kxdrdproc_t)(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
 extern void xdr_init_encode(struct xdr_stream *xdr, struct xdr_buf *buf,
 			    __be32 *p, struct rpc_rqst *rqst);
 extern __be32 *xdr_reserve_space(struct xdr_stream *xdr, size_t nbytes);
+extern int xdr_reserve_space_vec(struct xdr_stream *xdr, struct kvec *vec,
+		size_t nbytes);
 extern void xdr_commit_encode(struct xdr_stream *xdr);
 extern void xdr_truncate_encode(struct xdr_stream *xdr, size_t len);
 extern int xdr_restrict_buflen(struct xdr_stream *xdr, int newbuflen);
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index be11d672b5b9..6dfe5dc8b35f 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -648,6 +648,51 @@ __be32 * xdr_reserve_space(struct xdr_stream *xdr, size_t nbytes)
 }
 EXPORT_SYMBOL_GPL(xdr_reserve_space);
 
+
+/**
+ * xdr_reserve_space_vec - Reserves a large amount of buffer space for sending
+ * @xdr: pointer to xdr_stream
+ * @vec: pointer to a kvec array
+ * @nbytes: number of bytes to reserve
+ *
+ * Reserves enough buffer space to encode 'nbytes' of data and stores the
+ * pointers in 'vec'. The size argument passed to xdr_reserve_space() is
+ * determined based on the number of bytes remaining in the current page to
+ * avoid invalidating iov_base pointers when xdr_commit_encode() is called.
+ */
+int xdr_reserve_space_vec(struct xdr_stream *xdr, struct kvec *vec, size_t nbytes)
+{
+	int thislen;
+	int v = 0;
+	__be32 *p;
+
+	/*
+	 * svcrdma requires every READ payload to start somewhere
+	 * in xdr->pages.
+	 */
+	if (xdr->iov == xdr->buf->head) {
+		xdr->iov = NULL;
+		xdr->end = xdr->p;
+	}
+
+	while (nbytes) {
+		thislen = xdr->buf->page_len % PAGE_SIZE;
+		thislen = min_t(size_t, nbytes, PAGE_SIZE - thislen);
+
+		p = xdr_reserve_space(xdr, thislen);
+		if (!p)
+			return -EIO;
+
+		vec[v].iov_base = p;
+		vec[v].iov_len = thislen;
+		v++;
+		nbytes -= thislen;
+	}
+
+	return v;
+}
+EXPORT_SYMBOL_GPL(xdr_reserve_space_vec);
+
 /**
  * xdr_truncate_encode - truncate an encode buffer
  * @xdr: pointer to xdr_stream
-- 
2.28.0

