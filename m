Return-Path: <linux-nfs+bounces-4530-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BAC924238
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 17:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A6B1C2099C
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 15:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969C41BB6A9;
	Tue,  2 Jul 2024 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pi06NEP3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7183F1BA868
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933631; cv=none; b=FclnpS/tYlp8H9I5pi0E+xDay30s2ZYUS1oaOw352EyIJZXPLE6nY7lcIOOnaL9oySLJFgk+eV5ATst1xc0FpdBtwF/2oSbPZvp3ncqIp0AdaJsc21mG5o9ePOxKZrCFe3TF1HLx3INLLMoIPiyrpzyPxchcawQ9eZQTDd4+mzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933631; c=relaxed/simple;
	bh=nU8PzLnCGdJoBzEmXv7G4/knHrqrabOg//s0tnmPTAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZ1U5eApHlc47VfN43GCImzHFe3EfQ437noknBoPl7voP9HzGFhCGCdrYDA2+JT9PHv2/5W0w1HwYhk0JnM6yQzsZ+w5KqFwUtRDe5ATy5GqCv2bex45ZSWiwxffNK0bPGuT/2gyhVNIvZeNwjvQaSiO2u3drMPJjz3cJQ0iK5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pi06NEP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB92AC116B1;
	Tue,  2 Jul 2024 15:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719933631;
	bh=nU8PzLnCGdJoBzEmXv7G4/knHrqrabOg//s0tnmPTAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pi06NEP3IFQj/9j+n8lRZBG0KQli66OqgmJhjFVcdGw1mUZbgzIe9KHb4xRiGhL4/
	 ZkA8paOERW7MWWjkdRI/G8p8ywiwLJsqUKYD/zGuJ5+Y86rEoYOUxdc6LixivK+2Nd
	 FYvJowuJsZWSoMGOYIKakLJEgSLEivWw6SlKyQKhoev6wEqHWtdPACoSNil4MFINif
	 SSxt6Ybu+iEQQVORHqil/KBb2sBVVRoCdrsYh8luUa7MHYG/hVOfaWtugCZnCvxl5D
	 iS+5teIMqopjYdkXW21DVXEN1+V7UmQqi3qrLGHFZ6W7B4zQSwrGtwenXQaGHpwS35
	 bv91TMMIMVaog==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 2/6] NFS: Implement NFSv4.2's OFFLOAD_STATUS XDR
Date: Tue,  2 Jul 2024 11:19:50 -0400
Message-ID: <20240702151947.549814-10-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702151947.549814-8-cel@kernel.org>
References: <20240702151947.549814-8-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5794; i=chuck.lever@oracle.com; h=from:subject; bh=mZSVZGictBIHGhxqPex3Koaq7nik6NWOJ22ujwpodEM=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmhBqZPeLDvC6Fp1+UQWwC8U7sj6BGwZSZkn2a9 Ulc7+3jKN2JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZoQamQAKCRAzarMzb2Z/ lxrSD/0e3DgYqDIBivF9O4dG0hgFw1b+ETJ1cGbIr0ZARS3lT3fDYpHzHWsmYtSORv6nS9qS55T e9nsh32Q7qSE4LoaWWFkMbJkJVcaZ2PgPX0pe0v5xSLXYcMz077QXYpBj0D9C0xAW/1p0OO88Ch ygbmCp8g1xER62IZTi82CjZ9a90TjkVU+5x95DJzXte2K3wJz7OC4PzdeJ0MWSshclq/mVpyNfj eEyVW5ZQ7jtTPCNy3IroYnwC80+0+P+/iTYxj+J0gDh8FDDDhiT1RH1Vnj0A7PVGB8eoM9HuOFw W4ssNokjX7UxEEM6lNNhi988uFl2tzsdQDFBcOKqCuOTIi/kKTCs69D8k5T8Cjq/I0yotohJbRC qIvXwtv8nS94kiXy8s1W9LHcta9xijyRb46kMqf8mp9EO/Jv/5EWYxewCmCUl9Pi8PXKbKN9uqh o/prXtkkXU2RGmas98FDyZMpd9SqHTp2jccJsy9QJTrLnbXiJkc4L0JWru8cFnNL4CftDW0q0Hk oXTZ3bP4Iaco55//5ST3t9YucugHC0UN753OQ9AiLzfjIejFiQNvA6r/574/LyGrNHK83ENLyeY 7mGb7TNMBqxOc4Pn/qIrLPtaFmyohuGkCCd0lcV3CyHVyBe4zukRoRgCEi3dA0KLU2x3XDUsi9o j+LpbpMINjmPszA==
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
index ef5730c5e704..ad3d1293f917 100644
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
+	result = xdr_stream_decode_uint32_array(xdr, res->osr_complete, 1);
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
index 0d896ce296ce..66e9f2f11fa1 100644
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
index d09b9773b20c..3372971360d8 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1488,8 +1488,9 @@ struct nfs42_offload_status_args {
 
 struct nfs42_offload_status_res {
 	struct nfs4_sequence_res	osr_seq_res;
-	uint64_t			osr_count;
-	int				osr_status;
+	u64				osr_count;
+	int				complete_count;
+	u32				osr_complete[1];
 };
 
 struct nfs42_copy_notify_args {
-- 
2.45.2


