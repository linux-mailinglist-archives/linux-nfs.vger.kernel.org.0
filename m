Return-Path: <linux-nfs+bounces-3055-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F03EC8B5D5E
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 17:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75A128158F
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 15:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719A981AA2;
	Mon, 29 Apr 2024 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wr2Oc+UD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA5F7BB17
	for <linux-nfs@vger.kernel.org>; Mon, 29 Apr 2024 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403816; cv=none; b=MMzPNougx52gPXZi9NppjDkm0cfSAcrcNp6z4WOfOzRyi9Zy5ly3fxvxK36hJyV0rdjC6tBIImQTM8Od8ZO66d/S2qmNq1FuTDa89E/pntolrHtOnatFXnl0RfCsLvYK7vbiPn0sytvuoPcIi1UuWAF4H4RmpmqtqL3c/SRVQxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403816; c=relaxed/simple;
	bh=Oxg9jNyMjwevoOVLxr01IViPCJyTcFZ1gqUAgfZZ4JU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTlAsw4DLNoZH9FNE7Gp2/DyTkcpBg5DsuZkUDhd1MKHB8mrZ+W+4EBXafFd1bACeHpUiIChcyxHUyXZJDUfuf49t5ToRkOfSbCBoRx5piyXBWcq6KWHGkPXYTONRDt2qayq8+YHKhlA4g06Hiqa6xgD5xTZPa7NNxUNv3kLL34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wr2Oc+UD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803DBC4AF19;
	Mon, 29 Apr 2024 15:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714403815;
	bh=Oxg9jNyMjwevoOVLxr01IViPCJyTcFZ1gqUAgfZZ4JU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wr2Oc+UDsA2DWL4RtAQxU/STCYeoFyhJ/bik2r7ZlQ2La4bMKocWNdfg8mH5Is7xO
	 hAtbhPm+JWnyoVLQhW6iTvMsml+7W4pGVEsMkc9N4FziWsWiyH0sl4k9O4USeA8Qaz
	 0U1cVKbAyJh4DuFTjN4wpa2bMv3Xvi5PoHRaaByWjtbv53VcTIWGhbb52JPKjuiyHY
	 G4hafZ1xzXuMe7QDTCGCI5c4jmraEfQSsl7sZFY/Juti3lUWdLf5qIE0Q8TXsHvr9P
	 EIQSYzx7qSM6bZ2E5gICE1SbAfIfvDo58cIkavFULRdNf4mZ90Z/s8GRp4ood8W4WA
	 6FXsVP5/lTblA==
From: cel@kernel.org
To: Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <dai.ngo@oracle.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 1/4] NFS: Implement NFSv4.2's OFFLOAD_STATUS XDR
Date: Mon, 29 Apr 2024 11:16:34 -0400
Message-ID: <20240429151632.212571-7-cel@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429151632.212571-6-cel@kernel.org>
References: <20240429151632.212571-6-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6131; i=chuck.lever@oracle.com; h=from:subject; bh=Z31CFxu5ZCFO0EH+QrNcindRp3z2QGFOEwzcQbNYZHw=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmL7nW9zvkx8p6wYv1JFqilShSaOTnrRCsDhsM/ Qmdw/drCU2JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZi+51gAKCRAzarMzb2Z/ l/YZD/4sYO6UzaxY6lfaoHp3he/eZQbECQnrH+dhJvxuoLVs74NzyVECIOzoxMATw0DsSPnwAOu YzV9eQtLfwG5kc/USF7/aecnEUKo3Dup3q6gsutIb1819+kJ6MSEltaPYyK1+7KhWhnqyC2NBpu 0UrhZe9PMrN6h+o50ibh3OvYuzw46Lt0VOVUj39rK0L+J9uZT+KKNodu69gRivYIYLk1TZZd3D5 OSE4fQ528PqZlY3tqcH7lkw9ATOV73sYbl8AiOXrwu6FaGG0Jy/vozFxuFtUKF/e856EXw32i6v OKXQA1xp6d8K8IHLXya9fcpsolPFidr255y1AqOgQhCX+D4eCfwO0uE/SVU1P+wGz1Fbt4Zc+QD IsLnaLGG3SjDXL1u7B8fK+6GtD9qdEaYwhF2MEyn4yypzoIKYP80HMvcJUr9KDgz9tiyn+pYGSN ZkHOqOHN4eBomap7/w4/pLdnJfF70c7VOta1k+rMpfdwbfOWuFIdi1UbaaICAXqBAZC0VDKT3HM GDA20X20K4Vw1upEclqGh6eTZjn0Q89wKXXWr8qfztIfuNj32IoM6UU7h2MPEQN0toOJ3APm2cd 93hEjWN28CqmPIInyPbQGNNTXOVnbETR6ahO+AG+uvKkcmYHXP/ibB/JRZQqnczOHu13Fd2l6JQ B7WhmpWrbkUSGbA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Add XDR encoding and decoding functions for NFSv4.2 OFFLOAD_STATUS
operation.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs42xdr.c       | 101 +++++++++++++++++++++++++++++++++++++++-
 fs/nfs/nfs4xdr.c        |   1 +
 include/linux/nfs4.h    |   1 +
 include/linux/nfs_xdr.h |   1 +
 4 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 9e3ae53e2205..bafa0005d038 100644
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
@@ -549,7 +570,7 @@ static void nfs4_xdr_enc_copy(struct rpc_rqst *req,
 }
 
 /*
- * Encode OFFLOAD_CANEL request
+ * Encode OFFLOAD_CANCEL request
  */
 static void nfs4_xdr_enc_offload_cancel(struct rpc_rqst *req,
 					struct xdr_stream *xdr,
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
@@ -919,6 +959,39 @@ static int decode_offload_cancel(struct xdr_stream *xdr,
 	return decode_op_hdr(xdr, OP_OFFLOAD_CANCEL);
 }
 
+static int decode_offload_status(struct xdr_stream *xdr,
+				 struct nfs42_offload_status_res *res)
+{
+	int status, count;
+	__be32 *p;
+
+	status = decode_op_hdr(xdr, OP_OFFLOAD_STATUS);
+	if (status)
+		return status;
+
+	/* osr_count */
+	p = xdr_inline_decode(xdr, 12);
+	if (unlikely(!p))
+		return -EIO;
+	p = xdr_decode_hyper(p, &res->osr_count);
+
+	res->completed = false;
+	count = be32_to_cpup(p);
+	if (unlikely(count > 1))
+		return -EIO;
+
+	if (count) {
+		/* osr_status */
+		p = xdr_inline_decode(xdr, 4);
+		if (unlikely(!p))
+			return -EIO;
+
+		res->completed = true;
+		res->osr_status = be32_to_cpup(p);
+	}
+	return 0;
+}
+
 static int decode_copy_notify(struct xdr_stream *xdr,
 			      struct nfs42_copy_notify_res *res)
 {
@@ -1368,6 +1441,32 @@ static int nfs4_xdr_dec_offload_cancel(struct rpc_rqst *rqstp,
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
index 1416099dfcd1..bcb7de1c1b44 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -7711,6 +7711,7 @@ const struct rpc_procinfo nfs4_procedures[] = {
 	PROC42(CLONE,		enc_clone,		dec_clone),
 	PROC42(COPY,		enc_copy,		dec_copy),
 	PROC42(OFFLOAD_CANCEL,	enc_offload_cancel,	dec_offload_cancel),
+	PROC42(OFFLOAD_STATUS,	enc_offload_status,	dec_offload_status),
 	PROC42(COPY_NOTIFY,	enc_copy_notify,	dec_copy_notify),
 	PROC(LOOKUPP,		enc_lookupp,		dec_lookupp),
 	PROC42(LAYOUTERROR,	enc_layouterror,	dec_layouterror),
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index ef8d2d618d5b..89ed7dd29a9e 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -681,6 +681,7 @@ enum {
 	NFSPROC4_CLNT_LISTXATTRS,
 	NFSPROC4_CLNT_REMOVEXATTR,
 	NFSPROC4_CLNT_READ_PLUS,
+	NFSPROC4_CLNT_OFFLOAD_STATUS,
 };
 
 /* nfs41 types */
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index d09b9773b20c..7b55a4e506e1 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1490,6 +1490,7 @@ struct nfs42_offload_status_res {
 	struct nfs4_sequence_res	osr_seq_res;
 	uint64_t			osr_count;
 	int				osr_status;
+	bool				completed;
 };
 
 struct nfs42_copy_notify_args {
-- 
2.44.0


