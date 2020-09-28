Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B14327B2B8
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Sep 2020 19:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgI1RJH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Sep 2020 13:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1RJG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Sep 2020 13:09:06 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B137BC061755
        for <linux-nfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:06 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f142so1625943qke.13
        for <linux-nfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=48KcBzNhV3jd2hr5L/kqvpmFbYuw4+xCGImkWcJwvMs=;
        b=QThN1pK58iHHinVeum104xRPELjZRWTbIZ27jKubD/tLpLbQk8eeNQYj6Bj+eD+dZC
         nl9o6vSvtl+oWcY83EAppH9to/7KAqGqUaJbwE95gN3vORj7FVab6SLdbiDCe2SSDQ/J
         vAQ4PXnyI/lp6IAQ7Xmh7lqUdOveSz/HvoFDCudqXv0yRMzWMxmr2LhrPh7IDrTQdc3R
         GKAGl9HJmkJCenzD6WOvfwjuGlvBGsR3i97F8DdY3MlcZhcH3Oqp+Y+zGwh4OOb/WKlU
         oDeOwLyHqPV5IE83PiLo++DiZSPsAViEVKMWVvili67SQPEZu7BSv1PkROqBW9L+ddAv
         27zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=48KcBzNhV3jd2hr5L/kqvpmFbYuw4+xCGImkWcJwvMs=;
        b=rqupwt7YchWnlHpw53mFP12QEUeOj/JyRVPgWFSrujPh63qlBEVserxF1KeNL+g6Rm
         wh4UooZweoJQnKsE2R2KjyQLZv7tv1eWbFy5S8wDgRHgbiYWC98jljWY8JS96Ynd3h1P
         BD5RjGG9GfL3jtXRjbxsLUFtlTsoZHdIGDNolhC9sIeTF2TViCTyMQESY5guiP3PYTGX
         06mmyVYVutO2BNt9aruvNLjxb5G0h2yHzfK5WLy2U6r1enAS2d+3Z/W+j12f975H2sAa
         SgaZdzGI3t9LpIivx7ZFphCshbCapqb68aMfQqu5P7jB3/5Cq8npZ4HWFz2mSwajv20B
         kVtA==
X-Gm-Message-State: AOAM532iV1OuVU4TltPxlahkuKFw7dYEDzg4rbqjmI0TDOLBZmvtKNxD
        lhPkmMJiD+M4yFrEo6vgAr8=
X-Google-Smtp-Source: ABdhPJwJvU4PCP9K5wSRsq+4/tSz3gvlARaQyV6NQX9DCrEfMgN1bVNJcymx7mVJZ7IFMk/c/HXmnA==
X-Received: by 2002:a37:480f:: with SMTP id v15mr395574qka.279.1601312945817;
        Mon, 28 Sep 2020 10:09:05 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id k20sm2011631qtb.34.2020.09.28.10.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 10:09:05 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, chuck.lever@oracle.com,
        linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v6 2/5] NFSD: Add READ_PLUS data support
Date:   Mon, 28 Sep 2020 13:08:58 -0400
Message-Id: <20200928170901.707554-3-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928170901.707554-1-Anna.Schumaker@Netapp.com>
References: <20200928170901.707554-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This patch adds READ_PLUS support for returning a single
NFS4_CONTENT_DATA segment to the client. This is basically the same as
the READ operation, only with the extra information about data segments.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>

---
v6:
 - nfsd4_decode_compound() should check if we're doing a read plus so
   svc_reserve() can set the right buffer size.
 - Fix up nfsd4_read_plus_rsize() calculation to account for possibly
   sending two data segments if the file changes during encoding.
 - Limit maxcount to the amount of available buffer space
v5: Fix up nfsd4_read_plus_rsize() calculation
---
 fs/nfsd/nfs4proc.c | 21 +++++++++++
 fs/nfsd/nfs4xdr.c  | 87 ++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 105 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index eaf50eafa935..c825a6e6ad4e 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2591,6 +2591,20 @@ static inline u32 nfsd4_read_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
 	return (op_encode_hdr_size + 2 + XDR_QUADLEN(rlen)) * sizeof(__be32);
 }
 
+static inline u32 nfsd4_read_plus_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+{
+	u32 maxcount = svc_max_payload(rqstp);
+	u32 rlen = min(op->u.read.rd_length, maxcount);
+	/*
+	 * If we detect that the file changed during hole encoding, then we
+	 * recover by encoding the remaining reply as data. This means we need
+	 * to set aside enough room to encode two data segments.
+	 */
+	u32 seg_len = 2 * (1 + 2 + 1);
+
+	return (op_encode_hdr_size + 2 + seg_len + XDR_QUADLEN(rlen)) * sizeof(__be32);
+}
+
 static inline u32 nfsd4_readdir_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
 {
 	u32 maxcount = 0, rlen = 0;
@@ -3163,6 +3177,13 @@ static const struct nfsd4_operation nfsd4_ops[] = {
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
index 0be194de4888..477a7d8bb9a4 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2173,7 +2173,7 @@ static const nfsd4_dec nfsd4_dec_ops[] = {
 	[OP_LAYOUTSTATS]	= (nfsd4_dec)nfsd4_decode_notsupp,
 	[OP_OFFLOAD_CANCEL]	= (nfsd4_dec)nfsd4_decode_offload_status,
 	[OP_OFFLOAD_STATUS]	= (nfsd4_dec)nfsd4_decode_offload_status,
-	[OP_READ_PLUS]		= (nfsd4_dec)nfsd4_decode_notsupp,
+	[OP_READ_PLUS]		= (nfsd4_dec)nfsd4_decode_read,
 	[OP_SEEK]		= (nfsd4_dec)nfsd4_decode_seek,
 	[OP_WRITE_SAME]		= (nfsd4_dec)nfsd4_decode_notsupp,
 	[OP_CLONE]		= (nfsd4_dec)nfsd4_decode_clone,
@@ -2261,7 +2261,7 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 		 */
 		cachethis |= nfsd4_cache_this_op(op);
 
-		if (op->opnum == OP_READ) {
+		if (op->opnum == OP_READ || op->opnum == OP_READ_PLUS) {
 			readcount++;
 			readbytes += nfsd4_max_reply(argp->rqstp, op);
 		} else
@@ -4597,6 +4597,87 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
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
+	maxcount = min_t(unsigned long, maxcount, (xdr->buf->buflen - xdr->buf->len));
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
@@ -4974,7 +5055,7 @@ static const nfsd4_enc nfsd4_enc_ops[] = {
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

