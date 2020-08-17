Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4853246E96
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Aug 2020 19:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389098AbgHQRdh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Aug 2020 13:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389100AbgHQQxP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Aug 2020 12:53:15 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AD1C061345
        for <linux-nfs@vger.kernel.org>; Mon, 17 Aug 2020 09:53:14 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id k4so15112620ilr.12
        for <linux-nfs@vger.kernel.org>; Mon, 17 Aug 2020 09:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EHcR4jC1j2anjFCBSvkhULjFcz+6UCYLyghMDTwoNBI=;
        b=Y/7D6vZHCCwkq45rdmek00EJj0KWvkYiMCK5kpPayDs3lvYd4fXFWvqUP/6bttmklR
         yWiXedaIt7gx8b/tvIkSqp04RPNEctfHjdRxFQH7J6JZ/qXOt9nOhLxG0WtCLTH49mG5
         jmRAWntD/fEl/TVPxmETubPMedMeHZj/RAbIqYBSImZqlZ1RrhyoQ0ALvqghmmK/OB85
         BNO8e6Mv+p11BkkYRyCK0XmD4ZshUDjrg+TRgvw6rj6UKxbqIi5ESYGt3guJHHc2J+Fc
         PiM0O8Jy654bB4wv4I7wTSu0xUxFk6uLZ8bq+1S8GHHq2REIHfL4yByxb9WbkJlJr31m
         03Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=EHcR4jC1j2anjFCBSvkhULjFcz+6UCYLyghMDTwoNBI=;
        b=QRYHK4Bi+mGeBMMag6HigeZfDBi9IEDE8bqDyODIRYgo4SzjgnWoTg71vu4boOZTGa
         D13Uq5tIU6G6M3iSZxHcSlPji8bOSAkqek3ezR/OEvCGLt6n//RBPCmGhmcvALOrt9J0
         Sp4Y7fgWuOqmkTqTjW4AjI38B8c5t4ouS//aH14d1syWBKhfYoX3wB84uCvvgGPgke8Q
         cYYRZPkH/b+QbGS4LpbKl/EMzlpjCFOwGsiQRhY9CRsLFnYU0p7mZVxQI5Pu3XHdwVTH
         NFiFhdd8vC0bbMMH3WsiKXvqiFPCDubr5k99m6m4qydD23F3uidgvsYPv8+iRBQgEv7k
         DH7g==
X-Gm-Message-State: AOAM530Tfjdy8ONO55F3npTHi4Jb5nr5fb2RpP0bn49wmQgcvQhf38ir
        +Sck2DPQpbcnB/+cvrXKd54=
X-Google-Smtp-Source: ABdhPJw2E/+W7vBgAgcO1lEh8jKLRXr9WwtzJ82xS5UXKa6dgZu3snwG0wYcOonwSKl9TXMUOeemrA==
X-Received: by 2002:a92:d089:: with SMTP id h9mr12046437ilh.60.1597683193861;
        Mon, 17 Aug 2020 09:53:13 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id s3sm9410039iol.49.2020.08.17.09.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 09:53:13 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, chuck.lever@oracle.com,
        linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v4 2/5] NFSD: Add READ_PLUS data support
Date:   Mon, 17 Aug 2020 12:53:07 -0400
Message-Id: <20200817165310.354092-3-Anna.Schumaker@Netapp.com>
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

This patch adds READ_PLUS support for returning a single
NFS4_CONTENT_DATA segment to the client. This is basically the same as
the READ operation, only with the extra information about data segments.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfsd/nfs4proc.c | 17 ++++++++++
 fs/nfsd/nfs4xdr.c  | 83 ++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index a09c35f0f6f0..9630d33211f2 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2523,6 +2523,16 @@ static inline u32 nfsd4_read_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
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
@@ -3059,6 +3069,13 @@ static const struct nfsd4_operation nfsd4_ops[] = {
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
index 6a1c0a7fae05..9af92f538000 100644
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
@@ -4367,6 +4367,85 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
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
+	int starting_len = xdr->buf->len;
+	__be32 nfserr;
+	__be32 *p, tmp;
+	__be64 tmp64;
+
+	/* Content type, offset, byte count */
+	p = xdr_reserve_space(xdr, 4 + 8 + 4);
+	if (!p)
+		return nfserr_resource;
+
+	read->rd_vlen = xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, maxcount);
+	if (read->rd_vlen < 0)
+		return nfserr_resource;
+
+	nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
+			    resp->rqstp->rq_vec, read->rd_vlen, &maxcount, eof);
+	if (nfserr)
+		return nfserr;
+
+	tmp = htonl(NFS4_CONTENT_DATA);
+	write_bytes_to_xdr_buf(xdr->buf, starting_len,      &tmp,   4);
+	tmp64 = cpu_to_be64(read->rd_offset);
+	write_bytes_to_xdr_buf(xdr->buf, starting_len + 4,  &tmp64, 8);
+	tmp = htonl(maxcount);
+	write_bytes_to_xdr_buf(xdr->buf, starting_len + 12, &tmp,   4);
+	return nfs_ok;
+}
+
+static __be32
+nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
+		       struct nfsd4_read *read)
+{
+	unsigned long maxcount;
+	struct xdr_stream *xdr = &resp->xdr;
+	struct file *file;
+	int starting_len = xdr->buf->len;
+	int segments = 0;
+	__be32 *p, tmp;
+	u32 eof;
+
+	if (nfserr)
+		return nfserr;
+	file = read->rd_nf->nf_file;
+
+	/* eof flag, segment count */
+	p = xdr_reserve_space(xdr, 4 + 4);
+	if (!p)
+		return nfserr_resource;
+	xdr_commit_encode(xdr);
+
+	maxcount = svc_max_payload(resp->rqstp);
+	maxcount = min_t(unsigned long, maxcount,
+			 (xdr->buf->buflen - xdr->buf->len));
+	maxcount = min_t(unsigned long, maxcount, read->rd_length);
+
+	eof = read->rd_offset >= i_size_read(file_inode(file));
+	if (!eof) {
+		nfserr = nfsd4_encode_read_plus_data(resp, read, maxcount, &eof);
+		segments++;
+	}
+
+	if (nfserr)
+		xdr_truncate_encode(xdr, starting_len);
+	else {
+		tmp = htonl(eof);
+		write_bytes_to_xdr_buf(xdr->buf, starting_len,     &tmp, 4);
+		tmp = htonl(segments);
+		write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, 4);
+	}
 
 	return nfserr;
 }
@@ -4509,7 +4588,7 @@ static const nfsd4_enc nfsd4_enc_ops[] = {
 	[OP_LAYOUTSTATS]	= (nfsd4_enc)nfsd4_encode_noop,
 	[OP_OFFLOAD_CANCEL]	= (nfsd4_enc)nfsd4_encode_noop,
 	[OP_OFFLOAD_STATUS]	= (nfsd4_enc)nfsd4_encode_offload_status,
-	[OP_READ_PLUS]		= (nfsd4_enc)nfsd4_encode_noop,
+	[OP_READ_PLUS]		= (nfsd4_enc)nfsd4_encode_read_plus,
 	[OP_SEEK]		= (nfsd4_enc)nfsd4_encode_seek,
 	[OP_WRITE_SAME]		= (nfsd4_enc)nfsd4_encode_noop,
 	[OP_CLONE]		= (nfsd4_enc)nfsd4_encode_noop,
-- 
2.28.0

