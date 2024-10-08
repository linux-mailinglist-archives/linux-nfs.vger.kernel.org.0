Return-Path: <linux-nfs+bounces-6933-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC08C995095
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 15:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48CF81F25537
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 13:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F361DF96E;
	Tue,  8 Oct 2024 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlsHKktH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7127113959D
	for <linux-nfs@vger.kernel.org>; Tue,  8 Oct 2024 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395262; cv=none; b=Xa8uNLEwjLJa0HDOnjepcAjCJjLGLKbGsz1SmFXb4zT8NXQyKq3TcSikKcran8GY8qjeT0Ks4Gc9t5pO6nmrcF7ozEHVdsrXH0hdgjAzV9bh87FAfgmPnQuPs0hci9KhjsuuTwdlb5KMD2//GWd4KcMpR/0nfFa5swybjHwTFn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395262; c=relaxed/simple;
	bh=10qgMmKU0mBH7X62+YE4LHUhsde4DYDMcNlY44hAu4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpDDpA4ZTYR4qC02tQUqYMD5aXHLqxrNyI0daSbtgvqoptwcPnhssE7TVc72+eix8IPzT6XLzskGFOB/bHjE4kq7Erj8rSpbHceaLQ2MpRYHCL+IoRWDuKHDzm46/8O2MdaCbo/J6lJyhQndWuG0JQS1OLqHfAS4T1i049sc3/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlsHKktH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B630C4CEC7;
	Tue,  8 Oct 2024 13:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728395262;
	bh=10qgMmKU0mBH7X62+YE4LHUhsde4DYDMcNlY44hAu4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WlsHKktH3XMzZjReL6EdN4hPCrFI9ZTqLRNjJlo55TIrqjklBc/SA93+NvTRa6Foj
	 sfrdaWFQpUy7Kdn/iakJI42QY76bL16fwMbTX5LPlNjIGl03QG25XjC3FMpdBMUAIN
	 ZgovITvaadub8SDgGazVns89YbUG4LP9gCeGSTgsHNVpdcGAf63NiSdVPT8Xan28uw
	 /Y4YCtrU0xayu3WRZa8oD1XkDgQAfnDgB3hbiSQnt4aK+FywaTCcXcvdtC+Se5Gm7k
	 chbrPP2PuD/4o8/hIfRL/qTKOywlmtKbJaZ33lF2p0t9+m8B87fZnOd8m1wJsl0K5C
	 e7LLxbtgMmQlw==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 5/9] NFS: Implement NFSv4.2's OFFLOAD_STATUS XDR
Date: Tue,  8 Oct 2024 09:47:24 -0400
Message-ID: <20241008134719.116825-16-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008134719.116825-11-cel@kernel.org>
References: <20241008134719.116825-11-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5794; i=chuck.lever@oracle.com; h=from:subject; bh=QZq5ul7uYvH8Xb1l4B2DuMAL2V3+j8T+DZ1aGtQPhiI=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnBTfzlCMChIT39BI29eibG9DjeH/UbkhMva4v7 HHzCuXTB7eJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZwU38wAKCRAzarMzb2Z/ lzIIEACCRQ5ur5Pq8vCTl+MPl7cslenDpxCncgS5DiEviRCJgHEZML+M1fb9UnNGK+Zkq5ssJWO 0DhpE4i4UbdlVRcTGISwv+9clBSWYpDg9x/Ygp33ImUKGIABK83QngYvyJzESJrVLV+kqlXevqC iFqabpilZikxyjN8gHloMqtjcTl1a565BFEncEEtpcV2aQrsUhfTDxknpUqudon4IBN1yR0wIOn YvzsIE6FGEDb31J8IvMjtKjrsi9g78Hjloj2chFjYBTQ9F7Oy8RGbI8Psy2fLROURK5POMH06Iu U8m/r6i0spmotkmzBvwR2u+d2ScXVcLIT7Gl8GVeZbM6sbNdQSGEW+vh2EnwWW9p3Auwo805tW8 Q6Hup6XTJE3vMnj3NdUJB3cWm5CmCHNWuV0yFGhMh+uIN0cL05/gl0u1G4QlMwaxWUn949vyqMB FRhB3ElOP+FHIuScVhi4UEpT/U8dELKzaUz787S/4fyY6woKz6HbkThxzXpayrYzxU5a1jD0IX0 KP+tZXK4/Qk0H7vGmyf+u9pw3rMkMq1zaOdg3LGWCAtUuhcga5sfIQbJZPaEd6tXYmN4AooyuHq ehNIO1sAA0UfIjeqxYpwSiHjQkpjiIU65BGr8CUnNU69u+N8SjZvpnY1e6GNHLapgNIphOLj4KP EAuQ+SyKaheFVfA==
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
index 12d8e47bc5a3..ad337c0ebdba 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1520,8 +1520,9 @@ struct nfs42_offload_status_args {
 
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
2.46.2


