Return-Path: <linux-nfs+bounces-5412-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0224E9548F9
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Aug 2024 14:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83BC31F251EE
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Aug 2024 12:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665A31B86E3;
	Fri, 16 Aug 2024 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euV7CHMS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0271B86D9;
	Fri, 16 Aug 2024 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723812156; cv=none; b=r5S3P/g8dTqSoL7WCmZkzygSxmodXF+gC2KX7SRxhE+qnq4Z9qWdoif0582EbbMsF95ObsF9VnQ98zmzqpPFBva0Unf1g6iVFkRfxI6bSpF3dvP24eJaOER7kRd2VAN0PF21ZC/TJP2zkLrDiuDnKsr5P3diQC1sVOUyh5jfv+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723812156; c=relaxed/simple;
	bh=CKoZNlO+6BHaTw/P0n89Z7vG8n4Zt/QDOReFNcFnseM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gw9SQ9n+5RU3jmHQC9g/g287+uqGthCeREMN+mbIZ3vvOa46I6MVmHKU22qHZsOass6tKw/AbTgUbuBwPJ7iVp6a8P/TghEcvm36KOO7UxklV0xsDjbDcBC53T5POEfXR21wWPf1oWY50xcXzRFrij/ZIkqi363RwuzCdkissAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euV7CHMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EB7C4AF13;
	Fri, 16 Aug 2024 12:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723812155;
	bh=CKoZNlO+6BHaTw/P0n89Z7vG8n4Zt/QDOReFNcFnseM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=euV7CHMS3W7SH0xggwpp5wMsvsY0gK8lkZSi10JiiFIqN60fz4FWCi2vy3Gb1aqzp
	 7aMmm8FK3xvhAGB75PuMnxoDuqAdGSgk+L9bKKhFuLj8Royy/Bqqd9yZDJPS+WrTJx
	 tb+mLeMLzB+hoRUjDT1F1tWiQGbi1hPQ8Yj/K1eFfC/60zqpe8kC0ckjxWel/htxap
	 PJtRFGH1Q+50JcDkniiH+kVJNFqanqrjIpwMobrkQ/ucHovqiYssHNOtbj5aFGMQSn
	 TysidcQ2sCOF+sjuzaALEnYMGngTkmn69lsZGEcNC1sUednY+84r8kFR1NKHyBujBw
	 kREIZ88FeGlwQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 16 Aug 2024 08:42:08 -0400
Subject: [PATCH 2/3] nfsd: add support for FATTR4_OPEN_ARGUMENTS
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-delstid-v1-2-c221c3dc14cd@kernel.org>
References: <20240816-delstid-v1-0-c221c3dc14cd@kernel.org>
In-Reply-To: <20240816-delstid-v1-0-c221c3dc14cd@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Tom Haynes <loghyr@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4607; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=CKoZNlO+6BHaTw/P0n89Z7vG8n4Zt/QDOReFNcFnseM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmv0k384xDAHU2ZhGgfyCvNsQuInKf+6GIKttrj
 lADjeRPhuWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZr9JNwAKCRAADmhBGVaC
 FepuD/4x2LkUlCdvtHBrs6VUHVV45f0GiR5QpoDsbKJoA/xjsBvD/Wbn4vP/wl+NmlGs5xBoukH
 I3zH0r5yakjkgtmulYGgP/ZsbnYHR0qt6j117HaSiHa8hOdUaW2Pd/HKSUGlZ722Gm4uCDgVyCv
 RnrH+X9N4rUOK+sWBjcn5XgIhlJ66xpgIOGOc+VTEOv08l3oUSL3rmpMh1l/e6wqurxL+f5FPRz
 0SxOquihSCQgkqIo4PDVsB1waKAEDcqiBRnWvrl74Q/5SWU8x6TnzI9ileZ6+lbSqGHG5z3qK5x
 UlGMZlYUt5xBfPRJhsrunk60EjVqMhX1TSPBxAG2xE2AdW5VOKnlI9Ga3Ptn5H1uw11LO3texsF
 fzDZuI6HtjbK1gqfZnUByM2yLbt5muP0zhxZXw1Q8l1UmgirgwjpuLnwpASDAKJMbkTEWeclgah
 UVJSISAg0F/AX9zP13P8UbnJVhe++lT09EA2bMnETskV9uUiTT4Kx+x/v94e7HLmWuNOSoFV3vX
 LWPwcGOIXt+AbJpfYrKoLT2SRlmkaVI6gBu8aIR0Lq6WaDGsdP6ETaHzF1gg+4m11hAd9Cmufoq
 7WxNj92ctc5VfRYg5X+bTVuiOhB9OiQpFe3OAo2y6X9zaQZ/fYCHBz9djR2UF9Uq6mpvEpEu7sq
 HAJotCnCzrwnz1g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add support for FATTR4_OPEN_ARGUMENTS. This a new mechanism for the
client to discover what OPEN features the server supports.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/delstid_xdr.c |  2 +-
 fs/nfsd/delstid_xdr.h |  3 +++
 fs/nfsd/nfs4xdr.c     | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsd.h        |  3 ++-
 4 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/delstid_xdr.c b/fs/nfsd/delstid_xdr.c
index 63494d14f5d2..b63f338da357 100644
--- a/fs/nfsd/delstid_xdr.c
+++ b/fs/nfsd/delstid_xdr.c
@@ -435,7 +435,7 @@ xdrgen_encode_open_args_createmode4(struct xdr_stream *xdr, enum open_args_creat
 	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
 }
 
-static bool __maybe_unused
+bool
 xdrgen_encode_fattr4_open_arguments(struct xdr_stream *xdr, const fattr4_open_arguments *value)
 {
 	return xdrgen_encode_open_arguments4(xdr, value);
diff --git a/fs/nfsd/delstid_xdr.h b/fs/nfsd/delstid_xdr.h
index 3ca8d0cc8569..2a91a353ab93 100644
--- a/fs/nfsd/delstid_xdr.h
+++ b/fs/nfsd/delstid_xdr.h
@@ -99,4 +99,7 @@ typedef nfstime4 fattr4_time_deleg_modify;
 
 #define OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS (0x100000)
 
+/* delstid.c */
+bool xdrgen_encode_fattr4_open_arguments(struct xdr_stream *xdr,
+					 const fattr4_open_arguments *value);
 #endif /* _DELSTID_H */
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index b3d2000c8a08..dbaadb0ad980 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3400,6 +3400,58 @@ static __be32 nfsd4_encode_fattr4_xattr_support(struct xdr_stream *xdr,
 	return nfsd4_encode_bool(xdr, err == 0);
 }
 
+#define NFSD_OA_SHARE_ACCESS	(BIT(OPEN_ARGS_SHARE_ACCESS_READ)	| \
+				 BIT(OPEN_ARGS_SHARE_ACCESS_WRITE)	| \
+				 BIT(OPEN_ARGS_SHARE_ACCESS_BOTH))
+
+#define NFSD_OA_SHARE_DENY	(BIT(OPEN_ARGS_SHARE_DENY_NONE)		| \
+				 BIT(OPEN_ARGS_SHARE_DENY_READ)		| \
+				 BIT(OPEN_ARGS_SHARE_DENY_WRITE)	| \
+				 BIT(OPEN_ARGS_SHARE_DENY_BOTH))
+
+#define NFSD_OA_SHARE_ACCESS_WANT	(BIT(OPEN_ARGS_SHARE_ACCESS_WANT_ANY_DELEG)		| \
+					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_NO_DELEG)		| \
+					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL))
+
+#define NFSD_OA_OPEN_CLAIM	(BIT(OPEN_ARGS_OPEN_CLAIM_NULL)		| \
+				 BIT(OPEN_ARGS_OPEN_CLAIM_PREVIOUS)	| \
+				 BIT(OPEN_ARGS_OPEN_CLAIM_DELEGATE_CUR)	| \
+				 BIT(OPEN_ARGS_OPEN_CLAIM_DELEGATE_PREV)| \
+				 BIT(OPEN_ARGS_OPEN_CLAIM_FH)		| \
+				 BIT(OPEN_ARGS_OPEN_CLAIM_DELEG_CUR_FH)	| \
+				 BIT(OPEN_ARGS_OPEN_CLAIM_DELEG_PREV_FH))
+
+#define NFSD_OA_CREATE_MODE	(BIT(OPEN_ARGS_CREATEMODE_UNCHECKED4)	| \
+				 BIT(OPEN_ARGS_CREATE_MODE_GUARDED)	| \
+				 BIT(OPEN_ARGS_CREATEMODE_EXCLUSIVE4)	| \
+				 BIT(OPEN_ARGS_CREATE_MODE_EXCLUSIVE4_1))
+
+static __be32 nfsd4_encode_fattr4_open_arguments(struct xdr_stream *xdr,
+						 const struct nfsd4_fattr_args *args)
+{
+	uint32_t oa_share_access = NFSD_OA_SHARE_ACCESS;
+	uint32_t oa_share_deny = NFSD_OA_SHARE_DENY;
+	uint32_t oa_share_access_want = NFSD_OA_SHARE_ACCESS_WANT;
+	uint32_t oa_open_claim = NFSD_OA_OPEN_CLAIM;
+	uint32_t oa_create_mode = NFSD_OA_CREATE_MODE;
+	struct open_arguments4 oa;
+
+	oa.oa_share_access.count = 1;
+	oa.oa_share_access.element = &oa_share_access;
+	oa.oa_share_deny.count = 1;
+	oa.oa_share_deny.element = &oa_share_deny;
+	oa.oa_share_access_want.count = 1;
+	oa.oa_share_access_want.element = &oa_share_access_want;
+	oa.oa_open_claim.count = 1;
+	oa.oa_open_claim.element = &oa_open_claim;
+	oa.oa_create_mode.count = 1;
+	oa.oa_create_mode.element = &oa_create_mode;
+
+	if (!xdrgen_encode_fattr4_open_arguments(xdr, &oa))
+		return nfserr_resource;
+	return nfs_ok;
+}
+
 static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 	[FATTR4_SUPPORTED_ATTRS]	= nfsd4_encode_fattr4_supported_attrs,
 	[FATTR4_TYPE]			= nfsd4_encode_fattr4_type,
@@ -3500,6 +3552,7 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 
 	[FATTR4_MODE_UMASK]		= nfsd4_encode_fattr4__noop,
 	[FATTR4_XATTR_SUPPORT]		= nfsd4_encode_fattr4_xattr_support,
+	[FATTR4_OPEN_ARGUMENTS]		= nfsd4_encode_fattr4_open_arguments,
 };
 
 /*
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 4ccbf014a2c7..c98fb104ba7d 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -454,7 +454,8 @@ enum {
 	(NFSD4_1_SUPPORTED_ATTRS_WORD2 | \
 	FATTR4_WORD2_MODE_UMASK | \
 	NFSD4_2_SECURITY_ATTRS | \
-	FATTR4_WORD2_XATTR_SUPPORT)
+	FATTR4_WORD2_XATTR_SUPPORT | \
+	FATTR4_WORD2_OPEN_ARGUMENTS)
 
 extern const u32 nfsd_suppattrs[3][3];
 

-- 
2.46.0


