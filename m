Return-Path: <linux-nfs+bounces-3864-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5568790A1B5
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 03:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59391F2119D
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 01:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A74DDC9;
	Mon, 17 Jun 2024 01:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRKF1eue"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C03DDC5
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718587512; cv=none; b=sP2DiJCL0NTqBINKQAlLnMIE5wOaOi0AR4sXjYWCzGkW0y5taLhACjODq1ojhl0t+P3SCBBiwZhghOV7WrD/KfkmJx1NM+7Z+VrT1LBjXIzpvJ/WCYMzrn4s5Bk01M/4I3oJQLi+dubXxwZ+cqFVcSGoGr7SMZ+IfXwGBOoiB9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718587512; c=relaxed/simple;
	bh=VNsMlPc9122XaBUxDkr/+JeG/viHc8mimEgV7VvLde8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UykkVYYadO0BMUDkAVo2wH8LEIF02QqJcJeY1VSFu6Bs32h7zBwrtZc35Zo0x3OkxqasDSyVIlf2v7kx+9ikJb6XXoSRt+FlJGW+i9aJk5VISSBhcRZzjH2LGWvOLQEQ31pCl90UerZRhHkyI/BVfpaElEaUEHm8VC21GoA9FZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRKF1eue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A890EC2BBFC
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718587511;
	bh=VNsMlPc9122XaBUxDkr/+JeG/viHc8mimEgV7VvLde8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qRKF1euehPuwzpMkpBt/CDxAg7hrpabiAk9gcRkLWo7mzs71uQlNT+EJgbYC7sd1S
	 J5XFDdMfHusYw2BObIFR3FLGFIF8sCz3xyz3Sqds7eiW5J3xTe6T4h9TL0vQMHCpbm
	 QUsNFUzSOtS1KNzQ+YZ6dGjkDLMZIzHwV+QKzhN1XRaAMOtlzGYHgfZWR256anal5M
	 i77AYVVX9TT+NvZshq0PtVFJCOsV+JWGEnLfsI0Y8M5U90xiAnMTH9lpW7Ub/q1hEu
	 G977pbEI4hyqOeCoBXCpE6BVFtw4/kxnUrml8w+lTsLK4nmffLG2aJiDg9QCNC2RET
	 aFBYhK3iBiFjw==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH v2 05/19] NFSv4: Add CB_GETATTR support for delegated attributes
Date: Sun, 16 Jun 2024 21:21:23 -0400
Message-ID: <20240617012137.674046-6-trondmy@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617012137.674046-5-trondmy@kernel.org>
References: <20240617012137.674046-1-trondmy@kernel.org>
 <20240617012137.674046-2-trondmy@kernel.org>
 <20240617012137.674046-3-trondmy@kernel.org>
 <20240617012137.674046-4-trondmy@kernel.org>
 <20240617012137.674046-5-trondmy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

When the client holds an attribute delegation, the server may retrieve
all the timestamps through a CB_GETATTR callback.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/callback.h      |  5 +++--
 fs/nfs/callback_proc.c | 14 +++++++++-----
 fs/nfs/callback_xdr.c  | 39 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/callback.h b/fs/nfs/callback.h
index 650758ee0d5f..154a6ed1299f 100644
--- a/fs/nfs/callback.h
+++ b/fs/nfs/callback.h
@@ -46,14 +46,15 @@ struct cb_compound_hdr_res {
 
 struct cb_getattrargs {
 	struct nfs_fh fh;
-	uint32_t bitmap[2];
+	uint32_t bitmap[3];
 };
 
 struct cb_getattrres {
 	__be32 status;
-	uint32_t bitmap[2];
+	uint32_t bitmap[3];
 	uint64_t size;
 	uint64_t change_attr;
+	struct timespec64 atime;
 	struct timespec64 ctime;
 	struct timespec64 mtime;
 };
diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index 76cea34477ae..199c52788640 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -37,7 +37,7 @@ __be32 nfs4_callback_getattr(void *argp, void *resp,
 	if (!cps->clp) /* Always set for v4.0. Set in cb_sequence for v4.1 */
 		goto out;
 
-	res->bitmap[0] = res->bitmap[1] = 0;
+	memset(res->bitmap, 0, sizeof(res->bitmap));
 	res->status = htonl(NFS4ERR_BADHANDLE);
 
 	dprintk_rcu("NFS: GETATTR callback request from %s\n",
@@ -59,12 +59,16 @@ __be32 nfs4_callback_getattr(void *argp, void *resp,
 	res->change_attr = delegation->change_attr;
 	if (nfs_have_writebacks(inode))
 		res->change_attr++;
+	res->atime = inode_get_atime(inode);
 	res->ctime = inode_get_ctime(inode);
 	res->mtime = inode_get_mtime(inode);
-	res->bitmap[0] = (FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE) &
-		args->bitmap[0];
-	res->bitmap[1] = (FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY) &
-		args->bitmap[1];
+	res->bitmap[0] = (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE) &
+			 args->bitmap[0];
+	res->bitmap[1] = (FATTR4_WORD1_TIME_ACCESS |
+			  FATTR4_WORD1_TIME_METADATA |
+			  FATTR4_WORD1_TIME_MODIFY) & args->bitmap[1];
+	res->bitmap[2] = (FATTR4_WORD2_TIME_DELEG_ACCESS |
+			  FATTR4_WORD2_TIME_DELEG_MODIFY) & args->bitmap[2];
 	res->status = 0;
 out_iput:
 	rcu_read_unlock();
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 9369488f2ed4..29c49a7e5fe1 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -25,8 +25,9 @@
 #define CB_OP_GETATTR_BITMAP_MAXSZ	(4 * 4) // bitmap length, 3 bitmaps
 #define CB_OP_GETATTR_RES_MAXSZ		(CB_OP_HDR_RES_MAXSZ + \
 					 CB_OP_GETATTR_BITMAP_MAXSZ + \
-					 /* change, size, ctime, mtime */\
-					 (2 + 2 + 3 + 3) * 4)
+					 /* change, size, atime, ctime,
+					  * mtime, deleg_atime, deleg_mtime */\
+					 (2 + 2 + 3 + 3 + 3 + 3 + 3) * 4)
 #define CB_OP_RECALL_RES_MAXSZ		(CB_OP_HDR_RES_MAXSZ)
 
 #if defined(CONFIG_NFS_V4_1)
@@ -635,6 +636,13 @@ static __be32 encode_attr_time(struct xdr_stream *xdr, const struct timespec64 *
 	return 0;
 }
 
+static __be32 encode_attr_atime(struct xdr_stream *xdr, const uint32_t *bitmap, const struct timespec64 *time)
+{
+	if (!(bitmap[1] & FATTR4_WORD1_TIME_ACCESS))
+		return 0;
+	return encode_attr_time(xdr,time);
+}
+
 static __be32 encode_attr_ctime(struct xdr_stream *xdr, const uint32_t *bitmap, const struct timespec64 *time)
 {
 	if (!(bitmap[1] & FATTR4_WORD1_TIME_METADATA))
@@ -649,6 +657,24 @@ static __be32 encode_attr_mtime(struct xdr_stream *xdr, const uint32_t *bitmap,
 	return encode_attr_time(xdr,time);
 }
 
+static __be32 encode_attr_delegatime(struct xdr_stream *xdr,
+				     const uint32_t *bitmap,
+				     const struct timespec64 *time)
+{
+	if (!(bitmap[2] & FATTR4_WORD2_TIME_DELEG_ACCESS))
+		return 0;
+	return encode_attr_time(xdr,time);
+}
+
+static __be32 encode_attr_delegmtime(struct xdr_stream *xdr,
+				     const uint32_t *bitmap,
+				     const struct timespec64 *time)
+{
+	if (!(bitmap[2] & FATTR4_WORD2_TIME_DELEG_MODIFY))
+		return 0;
+	return encode_attr_time(xdr,time);
+}
+
 static __be32 encode_compound_hdr_res(struct xdr_stream *xdr, struct cb_compound_hdr_res *hdr)
 {
 	__be32 status;
@@ -697,12 +723,21 @@ static __be32 encode_getattr_res(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	if (unlikely(status != 0))
 		goto out;
 	status = encode_attr_size(xdr, res->bitmap, res->size);
+	if (unlikely(status != 0))
+		goto out;
+	status = encode_attr_atime(xdr, res->bitmap, &res->atime);
 	if (unlikely(status != 0))
 		goto out;
 	status = encode_attr_ctime(xdr, res->bitmap, &res->ctime);
 	if (unlikely(status != 0))
 		goto out;
 	status = encode_attr_mtime(xdr, res->bitmap, &res->mtime);
+	if (unlikely(status != 0))
+		goto out;
+	status = encode_attr_delegatime(xdr, res->bitmap, &res->atime);
+	if (unlikely(status != 0))
+		goto out;
+	status = encode_attr_delegmtime(xdr, res->bitmap, &res->mtime);
 	*savep = htonl((unsigned int)((char *)xdr->p - (char *)(savep+1)));
 out:
 	return status;
-- 
2.45.2


