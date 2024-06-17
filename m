Return-Path: <linux-nfs+bounces-3873-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A27090A1C0
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 03:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDEBB1F211A4
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 01:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFA518040;
	Mon, 17 Jun 2024 01:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vb04fTkg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD09617C6A
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718587516; cv=none; b=paF+1cqr2EuwC+9S+Jm2h3GBAyT43W2A+Ut8RIVYjKBNkanADim70cZWXnDXfgXdSzUd6sUidre3Jv0b4Q6UB/IM3W8oLr4obE7w6SF5hFhCOfbavPudDZa+xDnA/QTuYMew+gL+QHjORXvKIDh+yLWBNb6uAIgkAs+x8krCqTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718587516; c=relaxed/simple;
	bh=ImOC5a3HJMxAszklTuLSDqn7yAzb4lHpQE+ptvHjtsM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSauZaDGf7AfD+q5KntHj0+CHq7TGEZJjC3mQWSDZho1knbr12zhGr1sCAviZ1h4AudipdPcleYqPWsqx/8EamoY1LL4rQGFfp6Og1lyoH1z8YvHni7JSvb58k3XP9qLtZh+DnO+sQsPnAvOnsKMoesRSRsUAY2mOy90R+ewBrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vb04fTkg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46637C2BBFC
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718587515;
	bh=ImOC5a3HJMxAszklTuLSDqn7yAzb4lHpQE+ptvHjtsM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Vb04fTkgUzh1hbHEDzSeY0xe4/rQy04YDy/qjQ9ARW5AciNIyVaauKvJ8wpNwyP/B
	 SshWlPGtM1gPPJh6QcqCEZ508+3U1jCVZeQJhGbYNEA+mx2UPAcGKtaOieWLwW3/tJ
	 nXSJ1RtxmCBkkXHCAwgSA8v/8LAt6gj5FVr4mtjNZazGh7uyKuuKMXx6vOmPrg1zx9
	 JfHfNiCJm4/wWThQAr8BJTUaJw5O3fxMsUNx2muKd2s1oM4L99o5h3gvA29MFw+bF7
	 49eLB40u6kRfDZcZZGMehqsgBRm3/fScAkbrz6aXETL60NzGaPwpTyR5XxgGk5TXQa
	 rLmKmEtRZiUvg==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH v2 14/19] NFSv4: Add support for the FATTR4_OPEN_ARGUMENTS attribute
Date: Sun, 16 Jun 2024 21:21:32 -0400
Message-ID: <20240617012137.674046-15-trondmy@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617012137.674046-14-trondmy@kernel.org>
References: <20240617012137.674046-1-trondmy@kernel.org>
 <20240617012137.674046-2-trondmy@kernel.org>
 <20240617012137.674046-3-trondmy@kernel.org>
 <20240617012137.674046-4-trondmy@kernel.org>
 <20240617012137.674046-5-trondmy@kernel.org>
 <20240617012137.674046-6-trondmy@kernel.org>
 <20240617012137.674046-7-trondmy@kernel.org>
 <20240617012137.674046-8-trondmy@kernel.org>
 <20240617012137.674046-9-trondmy@kernel.org>
 <20240617012137.674046-10-trondmy@kernel.org>
 <20240617012137.674046-11-trondmy@kernel.org>
 <20240617012137.674046-12-trondmy@kernel.org>
 <20240617012137.674046-13-trondmy@kernel.org>
 <20240617012137.674046-14-trondmy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

Query the server for the OPEN arguments that it supports so that
we can figure out which extensions we can use.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c       | 20 ++++++++++++++++++--
 fs/nfs/nfs4xdr.c        | 24 ++++++++++++++++++++++++
 include/linux/nfs4.h    |  2 ++
 include/linux/nfs_xdr.h |  9 +++++++++
 4 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index cbd340cd825e..ae91492e9521 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3885,11 +3885,14 @@ static void nfs4_close_context(struct nfs_open_context *ctx, int is_sync)
 
 #define FATTR4_WORD1_NFS40_MASK (2*FATTR4_WORD1_MOUNTED_ON_FILEID - 1UL)
 #define FATTR4_WORD2_NFS41_MASK (2*FATTR4_WORD2_SUPPATTR_EXCLCREAT - 1UL)
-#define FATTR4_WORD2_NFS42_MASK (2*FATTR4_WORD2_TIME_DELEG_MODIFY - 1UL)
+#define FATTR4_WORD2_NFS42_MASK (2*FATTR4_WORD2_OPEN_ARGUMENTS - 1UL)
 
 static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *fhandle)
 {
-	u32 bitmask[3] = {}, minorversion = server->nfs_client->cl_minorversion;
+	u32 minorversion = server->nfs_client->cl_minorversion;
+	u32 bitmask[3] = {
+		[0] = FATTR4_WORD0_SUPPORTED_ATTRS,
+	};
 	struct nfs4_server_caps_arg args = {
 		.fhandle = fhandle,
 		.bitmask = bitmask,
@@ -3915,6 +3918,14 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 
 	status = nfs4_call_sync(server->client, server, &msg, &args.seq_args, &res.seq_res, 0);
 	if (status == 0) {
+		bitmask[0] = (FATTR4_WORD0_SUPPORTED_ATTRS |
+			      FATTR4_WORD0_FH_EXPIRE_TYPE |
+			      FATTR4_WORD0_LINK_SUPPORT |
+			      FATTR4_WORD0_SYMLINK_SUPPORT |
+			      FATTR4_WORD0_ACLSUPPORT |
+			      FATTR4_WORD0_CASE_INSENSITIVE |
+			      FATTR4_WORD0_CASE_PRESERVING) &
+			     res.attr_bitmask[0];
 		/* Sanity check the server answers */
 		switch (minorversion) {
 		case 0:
@@ -3923,9 +3934,14 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 			break;
 		case 1:
 			res.attr_bitmask[2] &= FATTR4_WORD2_NFS41_MASK;
+			bitmask[2] = FATTR4_WORD2_SUPPATTR_EXCLCREAT &
+				     res.attr_bitmask[2];
 			break;
 		case 2:
 			res.attr_bitmask[2] &= FATTR4_WORD2_NFS42_MASK;
+			bitmask[2] = (FATTR4_WORD2_SUPPATTR_EXCLCREAT |
+				      FATTR4_WORD2_OPEN_ARGUMENTS) &
+				     res.attr_bitmask[2];
 		}
 		memcpy(server->attr_bitmask, res.attr_bitmask, sizeof(server->attr_bitmask));
 		server->caps &= ~(NFS_CAP_ACLS | NFS_CAP_HARDLINKS |
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index e160a275ad4a..98aab2c324c9 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -4337,6 +4337,28 @@ static int decode_attr_xattrsupport(struct xdr_stream *xdr, uint32_t *bitmap,
 	return 0;
 }
 
+static int decode_attr_open_arguments(struct xdr_stream *xdr, uint32_t *bitmap,
+		struct nfs4_open_caps *res)
+{
+	memset(res, 0, sizeof(*res));
+	if (unlikely(bitmap[2] & (FATTR4_WORD2_OPEN_ARGUMENTS - 1U)))
+		return -EIO;
+	if (likely(bitmap[2] & FATTR4_WORD2_OPEN_ARGUMENTS)) {
+		if (decode_bitmap4(xdr, res->oa_share_access, ARRAY_SIZE(res->oa_share_access)) < 0)
+			return -EIO;
+		if (decode_bitmap4(xdr, res->oa_share_deny, ARRAY_SIZE(res->oa_share_deny)) < 0)
+			return -EIO;
+		if (decode_bitmap4(xdr, res->oa_share_access_want, ARRAY_SIZE(res->oa_share_access_want)) < 0)
+			return -EIO;
+		if (decode_bitmap4(xdr, res->oa_open_claim, ARRAY_SIZE(res->oa_open_claim)) < 0)
+			return -EIO;
+		if (decode_bitmap4(xdr, res->oa_createmode, ARRAY_SIZE(res->oa_createmode)) < 0)
+			return -EIO;
+		bitmap[2] &= ~FATTR4_WORD2_OPEN_ARGUMENTS;
+	}
+	return 0;
+}
+
 static int verify_attr_len(struct xdr_stream *xdr, unsigned int savep, uint32_t attrlen)
 {
 	unsigned int attrwords = XDR_QUADLEN(attrlen);
@@ -4511,6 +4533,8 @@ static int decode_server_caps(struct xdr_stream *xdr, struct nfs4_server_caps_re
 	if ((status = decode_attr_exclcreat_supported(xdr, bitmap,
 				res->exclcreat_bitmask)) != 0)
 		goto xdr_error;
+	if ((status = decode_attr_open_arguments(xdr, bitmap, &res->open_caps)) != 0)
+		goto xdr_error;
 	status = verify_attr_len(xdr, savep, attrlen);
 xdr_error:
 	dprintk("%s: xdr returned %d!\n", __func__, -status);
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index c074e0ac390f..f9df88091c6d 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -512,6 +512,7 @@ enum {
 enum {
 	FATTR4_TIME_DELEG_ACCESS	= 84,
 	FATTR4_TIME_DELEG_MODIFY	= 85,
+	FATTR4_OPEN_ARGUMENTS		= 86,
 };
 
 /*
@@ -595,6 +596,7 @@ enum {
 #define FATTR4_WORD2_XATTR_SUPPORT	BIT(FATTR4_XATTR_SUPPORT - 64)
 #define FATTR4_WORD2_TIME_DELEG_ACCESS	BIT(FATTR4_TIME_DELEG_ACCESS - 64)
 #define FATTR4_WORD2_TIME_DELEG_MODIFY	BIT(FATTR4_TIME_DELEG_MODIFY - 64)
+#define FATTR4_WORD2_OPEN_ARGUMENTS	BIT(FATTR4_OPEN_ARGUMENTS - 64)
 
 /* MDS threshold bitmap bits */
 #define THRESHOLD_RD                    (1UL << 0)
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index d8cfa956d24c..af510a7ec46a 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1213,6 +1213,14 @@ struct nfs4_statfs_res {
 	struct nfs_fsstat	       *fsstat;
 };
 
+struct nfs4_open_caps {
+	u32				oa_share_access[1];
+	u32				oa_share_deny[1];
+	u32				oa_share_access_want[1];
+	u32				oa_open_claim[1];
+	u32				oa_createmode[1];
+};
+
 struct nfs4_server_caps_arg {
 	struct nfs4_sequence_args	seq_args;
 	struct nfs_fh		       *fhandle;
@@ -1229,6 +1237,7 @@ struct nfs4_server_caps_res {
 	u32				fh_expire_type;
 	u32				case_insensitive;
 	u32				case_preserving;
+	struct nfs4_open_caps		open_caps;
 };
 
 #define NFS4_PATHNAME_MAXCOMPONENTS 512
-- 
2.45.2


