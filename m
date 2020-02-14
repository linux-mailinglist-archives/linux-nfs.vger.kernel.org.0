Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3902D15F87C
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2020 22:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388663AbgBNVML (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Feb 2020 16:12:11 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:45665 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388661AbgBNVML (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Feb 2020 16:12:11 -0500
Received: by mail-yb1-f196.google.com with SMTP id j78so2023395ybg.12
        for <linux-nfs@vger.kernel.org>; Fri, 14 Feb 2020 13:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y6ONWApcIATjJKTONWxSb2Z3biFUOMeWsS0lbfEG3AU=;
        b=Ot2x/EEC3xzw6epuP3uXBab2dLaWQhmSOvR4j6kHk38xhGhPU0yMJ5rQtdgYiFfryq
         Kg010z6KQ1L+XteYMKHs3JQYeKAxJaTGAj/NAUg1czyvk3NVvc8UHWye+q/0v2k61eWC
         kj1tQsBGer3oMR/rAjDkC994VT4MQZ4tmKxduyXechaZTq0X8X1hgptEdxwC6B2l5H0Y
         XNeXPLKI1mt4AnUc14ANNfO1G61MNEu4TvKQPMcyF3kql+62dTcRpR2ObtgBK26LDnit
         UPLYDR2pS7mfNVc9dZpxm1Tz/hD6NHL0re6B2zh3DPaBGaPTh8CT5wiYKkYCUcPG+v5f
         AKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Y6ONWApcIATjJKTONWxSb2Z3biFUOMeWsS0lbfEG3AU=;
        b=CnD+4OdUYs7D43+5iHqDYpR3bmdIR6q9shjYbOcwWZdUZc71Nk8b7RG14SfIXJ86H+
         wE+DaLAsa2yWe5wf7jFBS1lmL/cYkdzrBRNLgDwxsKuWdHEwsSv4hznYz/s075e6oITQ
         NfTn6mKUj1kI+iWm4M7ZnZRLaDLrXxYu39RVaOaUxTODXJ2hpafDlUTlXhaZB0kDvRlV
         ZnwyuqpuLB8zm/SLqjtbyYYX2jYR76B8k+46qzsCH1FdGWhWKU4KH0GsFY0G5ta8TDRo
         9tGVsFKQn0CPSe3KtZZNkXLKXL3QOqX+RNHgOSceeGqLi+2y0ls4Cvpz+3zV6Xev0rtY
         TwRA==
X-Gm-Message-State: APjAAAWKXuZdqEjtdXlOWlBjYC13/UeK8ODAB0GJ3YQwOwV7Pa5zasKo
        2TMuirffSG5D6q+KqdjeDtg=
X-Google-Smtp-Source: APXvYqw5YLQgqqSE85Nc39jHwWDJodCLKIy/s91+K0uo2HtaUr2gyQGIdpZ+7AFU350VkoZKDiGp/Q==
X-Received: by 2002:a5b:5cf:: with SMTP id w15mr4926942ybp.490.1581714730164;
        Fri, 14 Feb 2020 13:12:10 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id t3sm3360985ywi.18.2020.02.14.13.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 13:12:09 -0800 (PST)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 2/4] NFSD: Add READ_PLUS data support
Date:   Fri, 14 Feb 2020 16:12:04 -0500
Message-Id: <20200214211206.407725-3-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214211206.407725-1-Anna.Schumaker@Netapp.com>
References: <20200214211206.407725-1-Anna.Schumaker@Netapp.com>
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

Note that Wireshark 3.0 will report "malformed packed" when trying to
decode NFS4_CONTENT_DATA segments. This is because the actual data is
encoded as a variable length array, which RFC 4506 says should start
with a 32-bit length value. Wireshark incorrectly expects length to be a
64-bit value instead.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfsd/nfs4proc.c | 17 +++++++++
 fs/nfsd/nfs4xdr.c  | 90 ++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 101 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 0e75f7fb5fec..9643181591e3 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2522,6 +2522,16 @@ static inline u32 nfsd4_read_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
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
@@ -3058,6 +3068,13 @@ static const struct nfsd4_operation nfsd4_ops[] = {
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
index 45f0623f6488..8efb59d4fda4 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1957,7 +1957,7 @@ static const nfsd4_dec nfsd4_dec_ops[] = {
 	[OP_LAYOUTSTATS]	= (nfsd4_dec)nfsd4_decode_notsupp,
 	[OP_OFFLOAD_CANCEL]	= (nfsd4_dec)nfsd4_decode_offload_status,
 	[OP_OFFLOAD_STATUS]	= (nfsd4_dec)nfsd4_decode_offload_status,
-	[OP_READ_PLUS]		= (nfsd4_dec)nfsd4_decode_notsupp,
+	[OP_READ_PLUS]		= (nfsd4_dec)nfsd4_decode_read,
 	[OP_SEEK]		= (nfsd4_dec)nfsd4_decode_seek,
 	[OP_WRITE_SAME]		= (nfsd4_dec)nfsd4_decode_notsupp,
 	[OP_CLONE]		= (nfsd4_dec)nfsd4_decode_clone,
@@ -3664,10 +3664,11 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 
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
@@ -4379,6 +4380,83 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
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
@@ -4521,7 +4599,7 @@ static const nfsd4_enc nfsd4_enc_ops[] = {
 	[OP_LAYOUTSTATS]	= (nfsd4_enc)nfsd4_encode_noop,
 	[OP_OFFLOAD_CANCEL]	= (nfsd4_enc)nfsd4_encode_noop,
 	[OP_OFFLOAD_STATUS]	= (nfsd4_enc)nfsd4_encode_offload_status,
-	[OP_READ_PLUS]		= (nfsd4_enc)nfsd4_encode_noop,
+	[OP_READ_PLUS]		= (nfsd4_enc)nfsd4_encode_read_plus,
 	[OP_SEEK]		= (nfsd4_enc)nfsd4_encode_seek,
 	[OP_WRITE_SAME]		= (nfsd4_enc)nfsd4_encode_noop,
 	[OP_CLONE]		= (nfsd4_enc)nfsd4_encode_noop,
-- 
2.25.0

