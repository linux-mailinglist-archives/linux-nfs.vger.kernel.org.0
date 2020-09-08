Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF268261541
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Sep 2020 18:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbgIHQrI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Sep 2020 12:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731920AbgIHQ0T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Sep 2020 12:26:19 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3666CC06179B
        for <linux-nfs@vger.kernel.org>; Tue,  8 Sep 2020 09:26:04 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id w8so15980268ilj.8
        for <linux-nfs@vger.kernel.org>; Tue, 08 Sep 2020 09:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oed030nq5SBvqYHM9ReFakSIqfjHoKnXwhpHolYoM1Q=;
        b=rClrCUR7XX92MHQShouRzPWBRpR0IQz9ne4hmT3MjiMOlBWmnbIpYV2uJWCkwQLJk3
         0BuCH5lFj1DTA1R+1Z5Wgn7SPGazSXSY+KpwFlLnUZbwnJesLZeSlwfCb0xbfBv2cicC
         HxHPgVFoqC18pj8cdBoGsjC42uJWnCHhqWdLEKA0xLb4zlDrXsvqA2PPyfkibbu34AiU
         0i5Y6Puh/mxIBZXly8mfyvAnfge0FOSwOzdDZXb37c/0gy+NFSUCeQHkVgdqyH9PfgLx
         ANQMRP0tNzT90KAPAcGi3ZhjXbOvzjIQKVlNovzYjOYflQ+is0QnW9c4Ie+cRskDoaud
         BsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Oed030nq5SBvqYHM9ReFakSIqfjHoKnXwhpHolYoM1Q=;
        b=CG2jSNklQpQk7PBonYy04ZshvXcCLwBlrMML3yv3OA5D9VrFAad+M1a2ZvIGPvsh2d
         lf+ULJtWZF/Dx+UWqPUdxGJh1VV5pfQJaToP+KHVsPbB5GuQAYlAjZE68b3DayLjoEFJ
         OiwFYq9E2G1Wkxk3DDoXyLUbKK2lc/sa2jDDPv+qSY1aNshRegkaTHGnvAqjPqfjMQbJ
         DueTKINEGngdDa/RK79An7aeGr9XRBj+l7el2xLZDl9MEAT+rNHrKeDUKrUMjRzy65OE
         39aXhrUH34KXcN2HrRMu4pLdQKzsZ5b+SdKr8s+EKue36FtuEoC/ujChq/3gcwhARe3I
         5Ixw==
X-Gm-Message-State: AOAM531ygym7EOYeoIaXutb2coueQOUkGVpNzN+YIkrE9V9rCcX5Rg4F
        d+ABPQnhfZ0+tUuTzlCebPE=
X-Google-Smtp-Source: ABdhPJyIAlfYWIpdv/teDgcesuTdiLJDhSzctD8A/OX+PQXvvZPq7AOrCHA6uloxmplLNvG/uGGT1Q==
X-Received: by 2002:a92:906:: with SMTP id y6mr22441181ilg.106.1599582363522;
        Tue, 08 Sep 2020 09:26:03 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id v7sm10269657ilg.83.2020.09.08.09.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 09:26:02 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, chuck.lever@oracle.com,
        linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v5 2/5] NFSD: Add READ_PLUS data support
Date:   Tue,  8 Sep 2020 12:25:56 -0400
Message-Id: <20200908162559.509113-3-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908162559.509113-1-Anna.Schumaker@Netapp.com>
References: <20200908162559.509113-1-Anna.Schumaker@Netapp.com>
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
v5: Fix up nfsd4_read_plus_rsize() calculation
---
 fs/nfsd/nfs4proc.c | 20 +++++++++++
 fs/nfsd/nfs4xdr.c  | 83 ++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index eaf50eafa935..0a3df5f10501 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2591,6 +2591,19 @@ static inline u32 nfsd4_read_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
 	return (op_encode_hdr_size + 2 + XDR_QUADLEN(rlen)) * sizeof(__be32);
 }
 
+static inline u32 nfsd4_read_plus_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+{
+	u32 maxcount = svc_max_payload(rqstp);
+	u32 rlen = min(op->u.read.rd_length, maxcount);
+	/*
+	 * Worst case is a single large data segment, so make
+	 * sure we have enough room to encode that
+	 */
+	u32 seg_len = 1 + 2 + 1;
+
+	return (op_encode_hdr_size + 2 + seg_len + XDR_QUADLEN(rlen)) * sizeof(__be32);
+}
+
 static inline u32 nfsd4_readdir_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
 {
 	u32 maxcount = 0, rlen = 0;
@@ -3163,6 +3176,13 @@ static const struct nfsd4_operation nfsd4_ops[] = {
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
index 0be194de4888..26d12e3edf33 100644
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
@@ -4597,6 +4597,85 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
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
@@ -4974,7 +5053,7 @@ static const nfsd4_enc nfsd4_enc_ops[] = {
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

