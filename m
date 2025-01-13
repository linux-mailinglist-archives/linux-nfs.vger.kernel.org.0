Return-Path: <linux-nfs+bounces-9167-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079C9A0BC16
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 16:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A0A47A1340
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 15:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741BE1C5D6B;
	Mon, 13 Jan 2025 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOBKU0db"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C8A1C5D4F
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782370; cv=none; b=jT8pHauTn75NbafOmznDvn85B+rRaHAM0XR6JIJss6T6Q+1JCCO0leeNA1RSqOJ1rApEfV36MuQFkNfs+1+jyzSgfAWVkYvLomIXGmXECfW3PsscQVHOHbADdChHheiHYp9u3xtjhNI6Ec5efmffi37KV5cnmmldC/ZVwr1Fsic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782370; c=relaxed/simple;
	bh=9ESQg7KqaiZejbVROqJA6sQpvxMHcZf4EsfmZIbUn2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epF65ME6TV6JT2E/0ab3WDFRpk5uis6KkOkDQIVBdrf5Zb4x6iBeSDwzW3iAmmNdrJff2sThyDqaxfFyMxacKJeXR42bZvsuzwAzzYWd0rrH6YP+SgLDDM9f4tLyLMoxa3zqc/wUw0HNF9T5AkjSttFlsqtWygxRXAcKC8eOv3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOBKU0db; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E259C4CEE3;
	Mon, 13 Jan 2025 15:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736782369;
	bh=9ESQg7KqaiZejbVROqJA6sQpvxMHcZf4EsfmZIbUn2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QOBKU0db1/bgFgfRwZO5JvSGflSZfY4mGc29D8jrxUMBdEUkeIgswCri/EBwRjHBt
	 FanTdIhiutvuBzCCP2BlOz2ZAY7RY+knjQ/NAEk+pVaU43CTrWYv3pgk8eh4WJhMLw
	 KY8swJnmYnWwQqgCsVCdB4sT6mQid8D1YRTcuSkkZh6WesYAQtDSMMyTenkaEwzpxW
	 RB99q1dYEbXeaVHKta5DNmI+PDXjDgY5iBjh68PwqBVczQ7YX/crKo87UqdqdQU+NG
	 O39vd0M2hY9L0jmj/dG5CEEU89YA2BSZsLYugUXYrl0PaYUr/0u9TtfXorXhmqUgdH
	 bo+tEPYzJkBhQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 4/7] NFS: Implement NFSv4.2's OFFLOAD_STATUS XDR
Date: Mon, 13 Jan 2025 10:32:39 -0500
Message-ID: <20250113153235.48706-13-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250113153235.48706-9-cel@kernel.org>
References: <20250113153235.48706-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5839; i=chuck.lever@oracle.com; h=from:subject; bh=5skOVYdGzJnHGNfdQalH1CauZDqdcwSDW3RSNzfQPa8=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnhTIae4wPFS+MvO8BYXPDMISWibpRAZbRAkaxa ZiK7lPiakSJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZ4UyGgAKCRAzarMzb2Z/ l/bdD/9U7JcpZcZ7fxvHa3+KCN5NYutHhwhmU1bUAEYUQUkC9MsK5+IWLtIfYofe8QJ23xcoQxV neng22D1vnDFsG0D04vg+opemmG2g8xAHtLt1b9NBWuLOOTsMoXW8/ibPbVwI6WKQjDCqbM9B7b eUNgmNCqNu3jBLoQYDbsvSC13Nw+NtPdTMQV6/5bCrq0MvuXTW7qS+//WcPH6INz93lnMn+ow+N KUm+S/CD6IHGLsKX2ABlhgw4opGFxuOj9kYhwY4nZyxb7zC1kbaGoKFoQ4b5YqypXW7+Xn7HubG QlnlEHxvytw8Nmy4ENi+WFtMZbjOqde84sH+nI0JS9Wl13JLTEYvbveqGxVyi8y6YJCnOjyXnKP phHpx1fNIVyk/O8lF5J/iZW2YwMMTZFtLoxhe0Z+NpDM0d3nl8O6l431q/lRPNNGZ4DgV2MBD7W gkIrl793agRFRB6J3CfADGCPWFXNod/Wc0VQhQDZx7A2J8BhwxylemCfwn0GGdiqh3ypYYsYsns j8PDUGF9Tjlg/cwgLrks9PHY7AP3C+16NWorU0ynH2M8XAz1xZu5ZUStdF8wo/q0cybWTrb5wWK yOFD1zygeKwVfSwOIoRH/qhGjKqn3RZi9Xll0xv7Oyaed03LbN3u+W4VjYxLuVK+4FI5/bnBAGk yZdV59PkrSTkrjw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Add XDR encoding and decoding functions for the NFSv4.2
OFFLOAD_STATUS operation.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
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


