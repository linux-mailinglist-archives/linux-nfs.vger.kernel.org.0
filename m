Return-Path: <linux-nfs+bounces-5413-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF8B9548FC
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Aug 2024 14:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A225F1C24035
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Aug 2024 12:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7BB1B8E85;
	Fri, 16 Aug 2024 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7TvqmQK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DCC1B86FB;
	Fri, 16 Aug 2024 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723812157; cv=none; b=FQe3roroq8kU9ZFLaQSnVH5Rl7yKS5vaXY6BhkcOkDQsSBUu3edk+XgC4E9EIbw3D+EJRnxyh4q0oYg9gvrG4mMvGFYxl20S4T5hdwv7+Fb90p3o0M+W5Kt6uHWTk/XJcm6AVikdbAaQCUCsQqN30bNPITa7tF16SbxbgSNHrZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723812157; c=relaxed/simple;
	bh=2Rn+7obbQILo75kJbV/0b2zIBmSLl5DIxT28qY2BWXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fydi5HcCYnyps4OalFtZdxwtgQ7Nnb89z4Yzrw2nXRI5aBKnpY3+8D4zM96aJTfnuKdj43t4lIRsEsecGu5ib2t/7Z4ZKTwvge2lzBa6fp51b4ewvUJnh0jBbDW8sIgOlsN6U9utp9JPkMpSkwLCHxyxi2ucNH9s2XudxGTTZsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7TvqmQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1253BC32782;
	Fri, 16 Aug 2024 12:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723812157;
	bh=2Rn+7obbQILo75kJbV/0b2zIBmSLl5DIxT28qY2BWXU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A7TvqmQKvEqghTYmZSsxs8PX1YQTz2iorX6Y0k8t2jXQzqIzGAzPEJaWjyuqKqpkp
	 jRtd7rLV6DK67O8qai3l32IIZkQsYydxmm+V9rQ7azHzS6CFMxZMOorZuTbX9WTuIQ
	 M+5fEU0mFUurpRKBZUQclG50M0NfPP+5oMiFTUNr4A7SXRptXC/GkvYDT/kBTJvdPX
	 LPisENFRshMAtbdfmmiEWG+SQQ/OM+U2T57n8yHnZ03mTQ5LYpTsSggq6KcIrrHUrj
	 3SLS2HAXjI/53Eaw6o9JfMwT3iXFQOXuk+GO05GZADs7IDKFa2BP3jCJp2LSLdIdaS
	 5a0XyY7hjYzow==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 16 Aug 2024 08:42:09 -0400
Subject: [PATCH 3/3] nfsd: implement
 OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-delstid-v1-3-c221c3dc14cd@kernel.org>
References: <20240816-delstid-v1-0-c221c3dc14cd@kernel.org>
In-Reply-To: <20240816-delstid-v1-0-c221c3dc14cd@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Tom Haynes <loghyr@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5770; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=2Rn+7obbQILo75kJbV/0b2zIBmSLl5DIxT28qY2BWXU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmv0k4OSAyuXEt4tdH+4tnp4U6uVekWYFeDvkph
 VC5Vc2vPEiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZr9JOAAKCRAADmhBGVaC
 FfrqD/4u58lJLNqhuJn0g+OhIMScCoQw5x8/UOS3b9Fsxp4xkdlewMUw9P+k7t0oazQvB6QKICW
 y94PQKDi9dMezICQJI+h7qnf28tFciP4hUMc6c+rRY2QGouoXycilp8LoX59i+yWtxbrK/ArOnv
 woiMSSyIht4CPVTfPOCeGPT+VD5RCe+muaqfJB8fL/ivMjiZdmk98sYsy8ve3rRb2ARKQh1gVEs
 sM0U2/rLsH8/iFaPdgp/SEO5HuGhKIk0cjmnI4qnmyGsw9aVx2nJX5LeEcTelguVhKsmePgmmjt
 C+srLNpj14stn12u7Yp0heVdwC3ffJScRZkLQaV1bdvkGZImOEWD39jnUUimJdIlY8wWX6BczO+
 3a4UpG4Ynnogty/SuisPRtJJ3IOSddOKUUm+PpC2WU1oK7H81I9vTXs/kitlWhYutt8BMbmxFp3
 HZrPGs6feBApBrHmg6Qykw9+whOtfiUP7CBTwxbbh9Z7+irEWnO2NyIFPqL+AEi21brOV54uaCt
 0bS3JtRerhGHUrXik1fsM6N//YT+8ghc5LEdppeo6kbx9o4zxOIf23MtGXx/na9TiBVjrAeo1Y9
 YncdobMaQJNJnV12Y34f22Fpt2I+QLG/nBhwzvO3nYRcgktdY1jcqqhZNFGXD+OZm0s3xxMl6Ss
 d8by10kunM5lwpA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Allow clients to request getting a delegation xor an open stateid if a
delegation isn't available. This allows the client to avoid sending a
final CLOSE for the (useless) open stateid, when it is granted a
delegation.

This is done by moving the increment of the open stateid and unlocking
of the st_mutex until after we acquire a delegation. If we get a
delegation, we zero out the op_stateid field and set the NO_OPEN_STATEID
flag. If the open stateid was brand new, then unhash it too in this case
since it won't be needed.

If we can't get a delegation or the new flag wasn't requested, then just
increment and copy the open stateid as usual.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c       | 29 +++++++++++++++++++++++++----
 fs/nfsd/nfs4xdr.c         |  5 +++--
 include/uapi/linux/nfs4.h |  7 +++++--
 3 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b67f151837c1..9d209cbd95cd 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -56,6 +56,7 @@
 #include "pnfs.h"
 #include "filecache.h"
 #include "trace.h"
+#include "delstid_xdr.h"
 
 #define NFSDDBG_FACILITY                NFSDDBG_PROC
 
@@ -6029,6 +6030,17 @@ static void nfsd4_deleg_xgrade_none_ext(struct nfsd4_open *open,
 	 */
 }
 
+/* Are we only returning a delegation stateid? */
+static bool open_xor_delegation(struct nfsd4_open *open)
+{
+	if (!(open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION))
+		return false;
+	if (open->op_delegate_type != NFS4_OPEN_DELEGATE_READ &&
+	    open->op_delegate_type != NFS4_OPEN_DELEGATE_WRITE)
+		return false;
+	return true;
+}
+
 /**
  * nfsd4_process_open2 - finish open processing
  * @rqstp: the RPC transaction being executed
@@ -6051,6 +6063,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	struct nfs4_delegation *dp = NULL;
 	__be32 status;
 	bool new_stp = false;
+	bool deleg_only = false;
 
 	/*
 	 * Lookup file; if found, lookup stateid and check open request,
@@ -6105,9 +6118,6 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 			open->op_odstate = NULL;
 	}
 
-	nfs4_inc_and_copy_stateid(&open->op_stateid, &stp->st_stid);
-	mutex_unlock(&stp->st_mutex);
-
 	if (nfsd4_has_session(&resp->cstate)) {
 		if (open->op_deleg_want & NFS4_SHARE_WANT_NO_DELEG) {
 			open->op_delegate_type = NFS4_OPEN_DELEGATE_NONE_EXT;
@@ -6121,7 +6131,18 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	* OPEN succeeds even if we fail.
 	*/
 	nfs4_open_delegation(open, stp, &resp->cstate.current_fh);
+	deleg_only = open_xor_delegation(open);
 nodeleg:
+	if (deleg_only) {
+		memcpy(&open->op_stateid, &zero_stateid, sizeof(open->op_stateid));
+		open->op_rflags |= OPEN4_RESULT_NO_OPEN_STATEID;
+		if (new_stp)
+			release_open_stateid(stp);
+	} else {
+		nfs4_inc_and_copy_stateid(&open->op_stateid, &stp->st_stid);
+	}
+	mutex_unlock(&stp->st_mutex);
+
 	status = nfs_ok;
 	trace_nfsd_open(&stp->st_stid.sc_stateid);
 out:
@@ -6137,7 +6158,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	/*
 	* To finish the open response, we just need to set the rflags.
 	*/
-	open->op_rflags = NFS4_OPEN_RESULT_LOCKTYPE_POSIX;
+	open->op_rflags |= NFS4_OPEN_RESULT_LOCKTYPE_POSIX;
 	if (nfsd4_has_session(&resp->cstate))
 		open->op_rflags |= NFS4_OPEN_RESULT_MAY_NOTIFY_LOCK;
 	else if (!(open->op_openowner->oo_flags & NFS4_OO_CONFIRMED))
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index dbaadb0ad980..ecc9ddf4c28d 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1067,7 +1067,7 @@ static __be32 nfsd4_decode_share_access(struct nfsd4_compoundargs *argp, u32 *sh
 		return nfs_ok;
 	if (!argp->minorversion)
 		return nfserr_bad_xdr;
-	switch (w & NFS4_SHARE_WANT_MASK) {
+	switch (w & NFS4_SHARE_WANT_TYPE_MASK) {
 	case NFS4_SHARE_WANT_NO_PREFERENCE:
 	case NFS4_SHARE_WANT_READ_DELEG:
 	case NFS4_SHARE_WANT_WRITE_DELEG:
@@ -3411,7 +3411,8 @@ static __be32 nfsd4_encode_fattr4_xattr_support(struct xdr_stream *xdr,
 
 #define NFSD_OA_SHARE_ACCESS_WANT	(BIT(OPEN_ARGS_SHARE_ACCESS_WANT_ANY_DELEG)		| \
 					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_NO_DELEG)		| \
-					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL))
+					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL)		| \
+					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION))
 
 #define NFSD_OA_OPEN_CLAIM	(BIT(OPEN_ARGS_OPEN_CLAIM_NULL)		| \
 				 BIT(OPEN_ARGS_OPEN_CLAIM_PREVIOUS)	| \
diff --git a/include/uapi/linux/nfs4.h b/include/uapi/linux/nfs4.h
index caf4db2fcbb9..4273e0249fcb 100644
--- a/include/uapi/linux/nfs4.h
+++ b/include/uapi/linux/nfs4.h
@@ -58,7 +58,7 @@
 #define NFS4_SHARE_DENY_BOTH	0x0003
 
 /* nfs41 */
-#define NFS4_SHARE_WANT_MASK		0xFF00
+#define NFS4_SHARE_WANT_TYPE_MASK	0xFF00
 #define NFS4_SHARE_WANT_NO_PREFERENCE	0x0000
 #define NFS4_SHARE_WANT_READ_DELEG	0x0100
 #define NFS4_SHARE_WANT_WRITE_DELEG	0x0200
@@ -66,13 +66,16 @@
 #define NFS4_SHARE_WANT_NO_DELEG	0x0400
 #define NFS4_SHARE_WANT_CANCEL		0x0500
 
-#define NFS4_SHARE_WHEN_MASK		0xF0000
+#define NFS4_SHARE_WHEN_MASK				0xF0000
 #define NFS4_SHARE_SIGNAL_DELEG_WHEN_RESRC_AVAIL	0x10000
 #define NFS4_SHARE_PUSH_DELEG_WHEN_UNCONTENDED		0x20000
 
+#define NFS4_SHARE_WANT_MOD_MASK			0xF00000
 #define NFS4_SHARE_WANT_DELEG_TIMESTAMPS		0x100000
 #define NFS4_SHARE_WANT_OPEN_XOR_DELEGATION		0x200000
 
+#define NFS4_SHARE_WANT_MASK	(NFS4_SHARE_WANT_TYPE_MASK | NFS4_SHARE_WANT_MOD_MASK)
+
 #define NFS4_CDFC4_FORE	0x1
 #define NFS4_CDFC4_BACK 0x2
 #define NFS4_CDFC4_BOTH 0x3

-- 
2.46.0


