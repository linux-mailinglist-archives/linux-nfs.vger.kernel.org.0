Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0262D1379C7
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2020 23:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgAJWfo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Jan 2020 17:35:44 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:37133 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgAJWfo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Jan 2020 17:35:44 -0500
Received: by mail-yb1-f195.google.com with SMTP id o199so1372978ybc.4
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2020 14:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZDFyN6GaEQgVFJv09EIzqSqPKD1FAcJxGvZJzf+l6rQ=;
        b=WlE0ER4bhT9O0GgkAHhw17rCpu+TJpgMLepoy3rEEgE0zLWv6pI7v4ygWR9GgVfZA0
         21/tVsOEFxg7nMeMgQUAqgRfkO7SElZrjiYhv4CVKQlQPqAW4gQgs2d6mCcx6/O+i6wf
         /U1j/v3btB1+Y6Qd/P+pDA1Fv+cOm8WaghWZkZ/cFIhC10BoZcKHHebYp1G/3M5M4So6
         Q4bp8RN1md9p54b203b+eUnOpJzwCrQtMps7KxZky9OmmtMHayP3+Pn1uQ+Ch6GjtPlB
         /ckWo6TDYGNBeKQ6CsCnXjQxaSHnz8horR2fGEV8jwTn+4RMFBgXS0ySPXswAEXtm7e1
         K9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ZDFyN6GaEQgVFJv09EIzqSqPKD1FAcJxGvZJzf+l6rQ=;
        b=hYyjfOjYeqG/hjwz2E9hkRdUDf6EIUU9p+++J8qaUQMxMa3hWBlyxxWXVwcvqH9KQ2
         q/FLk0W7/7Jxp5mtPwMlAMcn1c6GOhNEE0mH2T7gA4M3mcAl+kLqMeYkB8NQurhQMx8V
         t7/a765+/LKcXsXUdlWHakeTGu8HNWlgRQUK+EZpvsCElHysrRWJzO3cJdN8TfgWIIyC
         mJ46ar4Y4zJMuys3YmcQKZZN9Csj95oGgICXa4G+N+Db3pBmVDC675bNntK25etiKkQ8
         pJ0gPcv95Hq0B/wo3jY9BvTVq47Wcq0v+Lda1Q16rBlbq+dgWz6YcUD09bCnNJcAjqXw
         phug==
X-Gm-Message-State: APjAAAX7Y6K8MaXF5JleHi5IFpLb1nwBygVTyQmbiWN0vE/PtO5uq49x
        NUk1jJ2l8QviTQHnatILb9aejdxIaqo=
X-Google-Smtp-Source: APXvYqxqt4IWC+HCzw0vy0F1TKELwNFmBTcXhUJQTkVv1R/7ajIXa45DJtsycGWJRcMpATtQ7gAr2A==
X-Received: by 2002:a25:d1d4:: with SMTP id i203mr4238045ybg.484.1578695742977;
        Fri, 10 Jan 2020 14:35:42 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id h23sm1607735ywc.105.2020.01.10.14.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 14:35:42 -0800 (PST)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 2/4] NFSD: Add READ_PLUS data support
Date:   Fri, 10 Jan 2020 17:35:36 -0500
Message-Id: <20200110223538.528560-3-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110223538.528560-1-Anna.Schumaker@Netapp.com>
References: <20200110223538.528560-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This patch adds READ_PLUS support for returning a single
NFS4_CONTENT_DATA segment to the client. This is basically the same as
the READ operation, only with the extra information about data segments.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfsd/nfs4proc.c | 17 +++++++++
 fs/nfsd/nfs4xdr.c  | 90 ++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 101 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 4798667af647..3c11ca9bd5d7 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2179,6 +2179,16 @@ static inline u32 nfsd4_read_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
 	return (op_encode_hdr_size + 2 + XDR_QUADLEN(rlen)) * sizeof(__be32);
 }
 
+static inline u32 nfsd4_read_plus_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+{
+	u32 maxcount = svc_max_payload(rqstp);
+	u32 rlen = min(op->u.read.rd_length, maxcount);
+	/* enough extra xdr space for encoding either a hole or data segment. */
+	u32 segments = 1 + 2 + 2;
+
+	return (op_encode_hdr_size + 2 + segments + XDR_QUADLEN(rlen)) * sizeof(__be32);
+}
+
 static inline u32 nfsd4_readdir_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
 {
 	u32 maxcount = 0, rlen = 0;
@@ -2700,6 +2710,13 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_name = "OP_COPY",
 		.op_rsize_bop = nfsd4_copy_rsize,
 	},
+	[OP_READ_PLUS] = {
+		.op_func = nfsd4_read,
+		.op_release = nfsd4_read_release,
+		.op_name = "OP_READ_PLUS",
+		.op_rsize_bop = nfsd4_read_plus_rsize,
+		.op_get_currentstateid = nfsd4_get_readstateid,
+	},
 	[OP_SEEK] = {
 		.op_func = nfsd4_seek,
 		.op_name = "OP_SEEK",
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 812e82097879..014e05365c17 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1882,7 +1882,7 @@ static const nfsd4_dec nfsd4_dec_ops[] = {
 	[OP_LAYOUTSTATS]	= (nfsd4_dec)nfsd4_decode_notsupp,
 	[OP_OFFLOAD_CANCEL]	= (nfsd4_dec)nfsd4_decode_offload_status,
 	[OP_OFFLOAD_STATUS]	= (nfsd4_dec)nfsd4_decode_offload_status,
-	[OP_READ_PLUS]		= (nfsd4_dec)nfsd4_decode_notsupp,
+	[OP_READ_PLUS]		= (nfsd4_dec)nfsd4_decode_read,
 	[OP_SEEK]		= (nfsd4_dec)nfsd4_decode_seek,
 	[OP_WRITE_SAME]		= (nfsd4_dec)nfsd4_decode_notsupp,
 	[OP_CLONE]		= (nfsd4_dec)nfsd4_decode_clone,
@@ -3589,10 +3589,11 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 	if (nfserr)
 		xdr_truncate_encode(xdr, starting_len);
-
-	read->rd_length = maxcount;
-	*p++ = htonl(eof);
-	*p++ = htonl(maxcount);
+	else {
+		read->rd_length = maxcount;
+		*p++ = htonl(eof);
+		*p++ = htonl(maxcount);
+	}
 
 	return nfserr;
 }
@@ -4264,6 +4265,83 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
 		return nfserr_resource;
 	p = xdr_encode_hyper(p, os->count);
 	*p++ = cpu_to_be32(0);
+	return nfserr;
+}
+
+static __be32
+nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
+			    struct nfsd4_read *read,
+			    unsigned long maxcount,  u32 *eof)
+{
+	struct xdr_stream *xdr = &resp->xdr;
+	struct file *file = read->rd_nf->nf_file;
+	__be32 nfserr;
+	__be32 *p;
+
+	/* Content type, offset, byte count */
+	p = xdr_reserve_space(xdr, 4 + 8 + 4);
+	if (!p)
+		return nfserr_resource;
+	xdr_commit_encode(xdr);
+
+	if (file->f_op->splice_read &&
+	    test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags))
+		nfserr = nfsd4_encode_splice_read(resp, read, file, &maxcount, eof);
+	else
+		nfserr = nfsd4_encode_readv(resp, read, file, &maxcount, eof);
+
+	if (nfserr)
+		return nfserr;
+
+	*p++ = htonl(NFS4_CONTENT_DATA);
+	 p   = xdr_encode_hyper(p, read->rd_offset);
+	*p++ = htonl(maxcount);
+
+	read->rd_offset += maxcount;
+	read->rd_length  = (maxcount > 0) ? read->rd_length - maxcount : 0;
+	return nfserr;
+}
+
+static __be32
+nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
+		       struct nfsd4_read *read)
+{
+	unsigned long maxcount;
+	u32 eof;
+	struct xdr_stream *xdr = &resp->xdr;
+	struct file *file;
+	int starting_len = xdr->buf->len;
+	__be32 *p;
+
+	if (nfserr)
+		return nfserr;
+	file = read->rd_nf->nf_file;
+
+	/* eof flag, segment count */
+	p = xdr_reserve_space(xdr, 4 + 4);
+	if (!p) {
+		WARN_ON_ONCE(test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags));
+		return nfserr_resource;
+	}
+	if (resp->xdr.buf->page_len &&
+	    test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags)) {
+		WARN_ON_ONCE(1);
+		return nfserr_resource;
+	}
+	xdr_commit_encode(xdr);
+
+	maxcount = svc_max_payload(resp->rqstp);
+	maxcount = min_t(unsigned long, maxcount,
+			 (xdr->buf->buflen - xdr->buf->len));
+	maxcount = min_t(unsigned long, maxcount, read->rd_length);
+
+	nfserr = nfsd4_encode_read_plus_data(resp, read, maxcount, &eof);
+	if (nfserr)
+		xdr_truncate_encode(xdr, starting_len);
+	else {
+		*p++ = htonl(eof);
+		*p++ = htonl(1);
+	}
 
 	return nfserr;
 }
@@ -4372,7 +4450,7 @@ static const nfsd4_enc nfsd4_enc_ops[] = {
 	[OP_LAYOUTSTATS]	= (nfsd4_enc)nfsd4_encode_noop,
 	[OP_OFFLOAD_CANCEL]	= (nfsd4_enc)nfsd4_encode_noop,
 	[OP_OFFLOAD_STATUS]	= (nfsd4_enc)nfsd4_encode_offload_status,
-	[OP_READ_PLUS]		= (nfsd4_enc)nfsd4_encode_noop,
+	[OP_READ_PLUS]		= (nfsd4_enc)nfsd4_encode_read_plus,
 	[OP_SEEK]		= (nfsd4_enc)nfsd4_encode_seek,
 	[OP_WRITE_SAME]		= (nfsd4_enc)nfsd4_encode_noop,
 	[OP_CLONE]		= (nfsd4_enc)nfsd4_encode_noop,
-- 
2.24.1

