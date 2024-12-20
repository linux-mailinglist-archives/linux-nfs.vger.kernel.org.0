Return-Path: <linux-nfs+bounces-8690-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A548C9F95B4
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2024 16:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83C2E16E8FD
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2024 15:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB915219A63;
	Fri, 20 Dec 2024 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7ktc4NR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A31218EA8
	for <linux-nfs@vger.kernel.org>; Fri, 20 Dec 2024 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709362; cv=none; b=hxUciLJeYseO13rDu1JmBWGIVexuAd+BEVqvzQpzGH/Yr+rZrrrpf7qEqSY6XDfZEeX0vNTNENPTPSIu9kaG8YUSkXOnprZBM+YfhrgPXR5MSCucaoBOx6q+HK5T5keyI+IZJMigO/z1euvWtGs/kRFVWXJ3gJWzlORsCQeZHjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709362; c=relaxed/simple;
	bh=UHYvkJ/Qmw8fb6OtUDOkOorY6lSj4IVXt1zWIkSVVuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IniWkLfyY0VoahglE9Z02A7jDzf45cQOWeZCuKEhW41QNq+IvMcQxnf2Xr+AS97lqLUrQ0diyVjpxQ8xJ7vj3jHikbilXvI0pxEN9xVP4EUDWOJMCnwZOreFaAhlsIEbDsgbxhMCRvkuDRmmiwjI45chLeSDfF/6IoQDZDSMiNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7ktc4NR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99C8C4CEDC;
	Fri, 20 Dec 2024 15:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734709362;
	bh=UHYvkJ/Qmw8fb6OtUDOkOorY6lSj4IVXt1zWIkSVVuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s7ktc4NRX/ZX2ecBMuECi2UkraoCVHPrSgkQ3Oi+5IbOP35dSGpRAGEWV/bAiZ42B
	 ldZGT46FdYPt9FkvPhEi2UolH3tiqlf9Yx7Hxl95mdTfcR6ZTRZ8GZILvaO3XQIzmI
	 +eDgHk+VD7n3dwMj9dWflDAmyLercCHh+dcDZEhRhHXegPiiqOprRI+PeJ7WhReq6/
	 HbHdo+F0l+zWoGs+v+5cvoLRZKKL2a8/5lo1XTr13S+dMMgwsGCaMpxW8RMaRb7Wug
	 8hd1ZhXuh4fPOzo3fosKkDbrqLxQ/E9/iPjJfMDgUHPAOVtsVIu8ZSMyZ2PWWvRT36
	 G6ut+uP1JuQ7Q==
From: cel@kernel.org
To: Olga Kornievskaia <okorniev@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 4/7] NFS: Implement NFSv4.2's OFFLOAD_STATUS XDR
Date: Fri, 20 Dec 2024 10:42:32 -0500
Message-ID: <20241220154227.16873-13-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241220154227.16873-9-cel@kernel.org>
References: <20241220154227.16873-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5792; i=chuck.lever@oracle.com; h=from:subject; bh=VVja45jvjBnwA3YK9gym7fzUL0QdIxmHxMQFFKKkUpQ=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnZZBqhVDTbw1zxqw0jFYj1hGPnXzRPUAwUwLxx gMEHCYAGWKJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZ2WQagAKCRAzarMzb2Z/ l6btD/9DzJo6pwmtLFAKTjYP5LVTh+v+rQNIaYDFK5U4E/lnWsXcuXFn6uw1wrFa6jCo3TdQA9Y hGEKt01jpShCBXBmOSOkWLzpo0vTQli116wTp0stbtI2rHpR8cn4xPo7jOPkOOkIpzfvBbnR5kC 26+9BNw4pFDRkB8sf8r06YYmf4SPySEQ13ARxMvu+bQ5XhCIK7lCThYo6MLGwH3zYr66+FYhybn lT/SVoOID6Naq5e8amAK0jvExhipqVEqVqc/+pbwwDTCmywKirw9B1tD/KPtZWEZ8P+CNHevBmt WtgLV4+A31HXAP3RB2N1dHXqeocuwU9WBS41HeYbetNlicwOy6z+m2KB9iUhvXRxMvYdVMZTsRc 9DQ8QzkSegQPJn0/e8a4+12yVWvHslr2PozQmz15OEEOarWJVUsXIAMI1H5sF1CaTm9X4VEPcOM we4UbIVfZppovDWgqRa75NRS4jVna/5zq1JD/LyYdAaELbPiuLIi14NqKG5vWBIvpHOnGwRoIsy RaKLhnuE+6j2ltLLp0FXUovx/xPViMvyshagqGDOCsAWpBNX06N59Op/OO/TBtBlKHHbvwxIk5m MKLjj3K+NcAYRDEVy5e63PrRrLv+Xh/IP851vc8h8tz8e1J627cz7i2Em0oQ/NGzjAbYqTlwxN4 jYekHFd2wi96jow==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Add XDR encoding and decoding functions for the NFSv4.2
OFFLOAD_STATUS operation.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs42xdr.c       | 86 +++++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfs4xdr.c        |  1 +
 include/linux/nfs4.h    |  1 +
 include/linux/nfs_xdr.h |  5 ++-
 4 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index ef5730c5e704..a928b7f90e59 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -35,6 +35,11 @@
 #define encode_offload_cancel_maxsz	(op_encode_hdr_maxsz + \
 					 XDR_QUADLEN(NFS4_STATEID_SIZE))
 #define decode_offload_cancel_maxsz	(op_decode_hdr_maxsz)
+#define encode_offload_status_maxsz	(op_encode_hdr_maxsz + \
+					 XDR_QUADLEN(NFS4_STATEID_SIZE))
+#define decode_offload_status_maxsz	(op_decode_hdr_maxsz + \
+					 2 /* osr_count */ + \
+					 2 /* osr_complete */)
 #define encode_copy_notify_maxsz	(op_encode_hdr_maxsz + \
 					 XDR_QUADLEN(NFS4_STATEID_SIZE) + \
 					 1 + /* nl4_type */ \
@@ -143,6 +148,14 @@
 					 decode_sequence_maxsz + \
 					 decode_putfh_maxsz + \
 					 decode_offload_cancel_maxsz)
+#define NFS4_enc_offload_status_sz	(compound_encode_hdr_maxsz + \
+					 encode_sequence_maxsz + \
+					 encode_putfh_maxsz + \
+					 encode_offload_status_maxsz)
+#define NFS4_dec_offload_status_sz	(compound_decode_hdr_maxsz + \
+					 decode_sequence_maxsz + \
+					 decode_putfh_maxsz + \
+					 decode_offload_status_maxsz)
 #define NFS4_enc_copy_notify_sz		(compound_encode_hdr_maxsz + \
 					 encode_putfh_maxsz + \
 					 encode_copy_notify_maxsz)
@@ -343,6 +356,14 @@ static void encode_offload_cancel(struct xdr_stream *xdr,
 	encode_nfs4_stateid(xdr, &args->osa_stateid);
 }
 
+static void encode_offload_status(struct xdr_stream *xdr,
+				  const struct nfs42_offload_status_args *args,
+				  struct compound_hdr *hdr)
+{
+	encode_op_hdr(xdr, OP_OFFLOAD_STATUS, decode_offload_status_maxsz, hdr);
+	encode_nfs4_stateid(xdr, &args->osa_stateid);
+}
+
 static void encode_copy_notify(struct xdr_stream *xdr,
 			       const struct nfs42_copy_notify_args *args,
 			       struct compound_hdr *hdr)
@@ -567,6 +588,25 @@ static void nfs4_xdr_enc_offload_cancel(struct rpc_rqst *req,
 	encode_nops(&hdr);
 }
 
+/*
+ * Encode OFFLOAD_STATUS request
+ */
+static void nfs4_xdr_enc_offload_status(struct rpc_rqst *req,
+					struct xdr_stream *xdr,
+					const void *data)
+{
+	const struct nfs42_offload_status_args *args = data;
+	struct compound_hdr hdr = {
+		.minorversion = nfs4_xdr_minorversion(&args->osa_seq_args),
+	};
+
+	encode_compound_hdr(xdr, req, &hdr);
+	encode_sequence(xdr, &args->osa_seq_args, &hdr);
+	encode_putfh(xdr, args->osa_src_fh, &hdr);
+	encode_offload_status(xdr, args, &hdr);
+	encode_nops(&hdr);
+}
+
 /*
  * Encode COPY_NOTIFY request
  */
@@ -919,6 +959,26 @@ static int decode_offload_cancel(struct xdr_stream *xdr,
 	return decode_op_hdr(xdr, OP_OFFLOAD_CANCEL);
 }
 
+static int decode_offload_status(struct xdr_stream *xdr,
+				 struct nfs42_offload_status_res *res)
+{
+	ssize_t result;
+	int status;
+
+	status = decode_op_hdr(xdr, OP_OFFLOAD_STATUS);
+	if (status)
+		return status;
+	/* osr_count */
+	if (xdr_stream_decode_u64(xdr, &res->osr_count) < 0)
+		return -EIO;
+	/* osr_complete<1> */
+	result = xdr_stream_decode_uint32_array(xdr, &res->osr_complete, 1);
+	if (result < 0)
+		return -EIO;
+	res->complete_count = result;
+	return 0;
+}
+
 static int decode_copy_notify(struct xdr_stream *xdr,
 			      struct nfs42_copy_notify_res *res)
 {
@@ -1368,6 +1428,32 @@ static int nfs4_xdr_dec_offload_cancel(struct rpc_rqst *rqstp,
 	return status;
 }
 
+/*
+ * Decode OFFLOAD_STATUS response
+ */
+static int nfs4_xdr_dec_offload_status(struct rpc_rqst *rqstp,
+				       struct xdr_stream *xdr,
+				       void *data)
+{
+	struct nfs42_offload_status_res *res = data;
+	struct compound_hdr hdr;
+	int status;
+
+	status = decode_compound_hdr(xdr, &hdr);
+	if (status)
+		goto out;
+	status = decode_sequence(xdr, &res->osr_seq_res, rqstp);
+	if (status)
+		goto out;
+	status = decode_putfh(xdr);
+	if (status)
+		goto out;
+	status = decode_offload_status(xdr, res);
+
+out:
+	return status;
+}
+
 /*
  * Decode COPY_NOTIFY response
  */
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index e8ac3f615f93..08be0a0cce24 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -7702,6 +7702,7 @@ const struct rpc_procinfo nfs4_procedures[] = {
 	PROC42(CLONE,		enc_clone,		dec_clone),
 	PROC42(COPY,		enc_copy,		dec_copy),
 	PROC42(OFFLOAD_CANCEL,	enc_offload_cancel,	dec_offload_cancel),
+	PROC42(OFFLOAD_STATUS,	enc_offload_status,	dec_offload_status),
 	PROC42(COPY_NOTIFY,	enc_copy_notify,	dec_copy_notify),
 	PROC(LOOKUPP,		enc_lookupp,		dec_lookupp),
 	PROC42(LAYOUTERROR,	enc_layouterror,	dec_layouterror),
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 8d7430d9f218..5de96243a252 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -695,6 +695,7 @@ enum {
 	NFSPROC4_CLNT_LISTXATTRS,
 	NFSPROC4_CLNT_REMOVEXATTR,
 	NFSPROC4_CLNT_READ_PLUS,
+	NFSPROC4_CLNT_OFFLOAD_STATUS,
 };
 
 /* nfs41 types */
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 559273a0f16d..9ac6c7a26b44 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1520,8 +1520,9 @@ struct nfs42_offload_status_args {
 
 struct nfs42_offload_status_res {
 	struct nfs4_sequence_res	osr_seq_res;
-	uint64_t			osr_count;
-	int				osr_status;
+	u64				osr_count;
+	int				complete_count;
+	u32				osr_complete;
 };
 
 struct nfs42_copy_notify_args {
-- 
2.47.0


