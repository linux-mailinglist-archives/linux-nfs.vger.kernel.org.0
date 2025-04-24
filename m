Return-Path: <linux-nfs+bounces-11273-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BA1A9B88D
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Apr 2025 21:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846451BA01F1
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Apr 2025 19:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79102918EA;
	Thu, 24 Apr 2025 19:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPiwPkM6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83804292904
	for <linux-nfs@vger.kernel.org>; Thu, 24 Apr 2025 19:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745524622; cv=none; b=Wi3MWCww5vGsGAKlxZTnANsiN2J8fwNxR9E+XeV4oio5n5XHI4mQbqhaMG+oBK4LAdjo9U/zITu0ZjGLTp9a5hV2hYW1aW/wosx8PAw/0RajvR7lkU7F2sBeFj/ztWtpyS2j92f5467r5JerElyMooKJTqaSDqGCpGAUGKiyCxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745524622; c=relaxed/simple;
	bh=H4iSQPvB/0ZlLgt6ZqQh9VrxPZYNHfIYPk3IY48oYiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vGC6ET3VnoVcJB377ztgPHMdAX3K3u+TMqc773bpQ2sMosMA1SyGBQUghUVEjEWptPSso5MhrCbrIgP+ZpgVeiAUiCpn70k/Cg6LheETiitxSvi/DloPbdi7P/GyirDaOir8v70m8ZB5DoRYAvvT+LY5O3myhxxkqd91Ra5H/Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPiwPkM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E175C4CEE3;
	Thu, 24 Apr 2025 19:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745524621;
	bh=H4iSQPvB/0ZlLgt6ZqQh9VrxPZYNHfIYPk3IY48oYiA=;
	h=From:To:Cc:Subject:Date:From;
	b=DPiwPkM6AV4ToUQ/D0anHtXja0F+nNY4+iFNFxHhnllBc/FebC7QkCkn4LOzO3frq
	 STRjEm4VjEwS4/vfkWpzhNPB9bEVtKCFL+6kRUZ4PGOF4JhaN/ioGdVZx8g7fTvz/9
	 aQLJfeOL8d0XzGxHstWqrXEOaydMpFqsQugj3DQ4WToK7l950pTf64mJm5tb56YS3v
	 UFCdzKNsBk5gh2CloRUTzp4ufGgyHxx5vCf98mirKrCYHKT2oBkCkYz2QX/WmHAEiy
	 55fDRdfvKcLtQ+L2j0jDHfKa1vMy2Ry9pkGcm8w7XmX5LAIxBhs1awMtkw71j8LaWh
	 MGXnvM0PaM5Jg==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH] NFS: Add support for fallocate(FALLOC_FL_ZERO_RANGE)
Date: Thu, 24 Apr 2025 15:57:00 -0400
Message-ID: <20250424195700.342762-1-anna@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

This implements a suggestion from Trond that we can mimic
FALLOC_FL_ZERO_RANGE by sending a compound that first does a DEALLOCATE
to punch a hole in a file, and then an ALLOCATE to fill the hole with
zeroes. There might technically be a race here, but once the DEALLOCATE
finishes any reads from the region would return zeroes anyway, so I
don't expect it to cause problems.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/nfs42.h            |  1 +
 fs/nfs/nfs42proc.c        | 29 ++++++++++++++++--
 fs/nfs/nfs42xdr.c         | 64 +++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfs4file.c         | 10 +++++-
 fs/nfs/nfs4proc.c         |  1 +
 fs/nfs/nfs4xdr.c          |  1 +
 include/linux/nfs4.h      |  1 +
 include/linux/nfs_fs_sb.h |  1 +
 8 files changed, 105 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs42.h b/fs/nfs/nfs42.h
index 0282d93c8bcc..aafd15a4afce 100644
--- a/fs/nfs/nfs42.h
+++ b/fs/nfs/nfs42.h
@@ -21,6 +21,7 @@ int nfs42_proc_allocate(struct file *, loff_t, loff_t);
 ssize_t nfs42_proc_copy(struct file *, loff_t, struct file *, loff_t, size_t,
 			struct nl4_server *, nfs4_stateid *, bool);
 int nfs42_proc_deallocate(struct file *, loff_t, loff_t);
+int nfs42_proc_zero_range(struct file *, loff_t, loff_t);
 loff_t nfs42_proc_llseek(struct file *, loff_t, int);
 int nfs42_proc_layoutstats_generic(struct nfs_server *,
 				   struct nfs42_layoutstat_data *);
diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 5cf52ece96ac..01c01f45358b 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -146,7 +146,8 @@ int nfs42_proc_allocate(struct file *filep, loff_t offset, loff_t len)
 
 	err = nfs42_proc_fallocate(&msg, filep, offset, len);
 	if (err == -EOPNOTSUPP)
-		NFS_SERVER(inode)->caps &= ~NFS_CAP_ALLOCATE;
+		NFS_SERVER(inode)->caps &= ~(NFS_CAP_ALLOCATE |
+					     NFS_CAP_ZERO_RANGE);
 
 	inode_unlock(inode);
 	return err;
@@ -169,7 +170,31 @@ int nfs42_proc_deallocate(struct file *filep, loff_t offset, loff_t len)
 	if (err == 0)
 		truncate_pagecache_range(inode, offset, (offset + len) -1);
 	if (err == -EOPNOTSUPP)
-		NFS_SERVER(inode)->caps &= ~NFS_CAP_DEALLOCATE;
+		NFS_SERVER(inode)->caps &= ~(NFS_CAP_DEALLOCATE |
+					     NFS_CAP_ZERO_RANGE);
+
+	inode_unlock(inode);
+	return err;
+}
+
+int nfs42_proc_zero_range(struct file *filep, loff_t offset, loff_t len)
+{
+	struct rpc_message msg = {
+		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_ZERO_RANGE],
+	};
+	struct inode *inode = file_inode(filep);
+	int err;
+
+	if (!nfs_server_capable(inode, NFS_CAP_ZERO_RANGE))
+		return -EOPNOTSUPP;
+
+	inode_lock(inode);
+
+	err = nfs42_proc_fallocate(&msg, filep, offset, len);
+	if (err == 0)
+		truncate_pagecache_range(inode, offset, (offset + len) -1);
+	if (err == -EOPNOTSUPP)
+		NFS_SERVER(inode)->caps &= ~NFS_CAP_ZERO_RANGE;
 
 	inode_unlock(inode);
 	return err;
diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index b1b663468249..4cc915d5741d 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -174,6 +174,18 @@
 					 decode_putfh_maxsz + \
 					 decode_deallocate_maxsz + \
 					 decode_getattr_maxsz)
+#define NFS4_enc_zero_range_sz		(compound_encode_hdr_maxsz + \
+					 encode_sequence_maxsz + \
+					 encode_putfh_maxsz + \
+					 encode_deallocate_maxsz + \
+					 encode_allocate_maxsz + \
+					 encode_getattr_maxsz)
+#define NFS4_dec_zero_range_sz		(compound_decode_hdr_maxsz + \
+					 decode_sequence_maxsz + \
+					 decode_putfh_maxsz + \
+					 decode_deallocate_maxsz + \
+					 decode_allocate_maxsz + \
+					 decode_getattr_maxsz)
 #define NFS4_enc_read_plus_sz		(compound_encode_hdr_maxsz + \
 					 encode_sequence_maxsz + \
 					 encode_putfh_maxsz + \
@@ -648,6 +660,27 @@ static void nfs4_xdr_enc_deallocate(struct rpc_rqst *req,
 	encode_nops(&hdr);
 }
 
+/*
+ * Encode ZERO_RANGE request
+ */
+static void nfs4_xdr_enc_zero_range(struct rpc_rqst *req,
+				    struct xdr_stream *xdr,
+				    const void *data)
+{
+	const struct nfs42_falloc_args *args = data;
+	struct compound_hdr hdr = {
+		.minorversion = nfs4_xdr_minorversion(&args->seq_args),
+	};
+
+	encode_compound_hdr(xdr, req, &hdr);
+	encode_sequence(xdr, &args->seq_args, &hdr);
+	encode_putfh(xdr, args->falloc_fh, &hdr);
+	encode_deallocate(xdr, args, &hdr);
+	encode_allocate(xdr, args, &hdr);
+	encode_getfattr(xdr, args->falloc_bitmask, &hdr);
+	encode_nops(&hdr);
+}
+
 /*
  * Encode READ_PLUS request
  */
@@ -1510,6 +1543,37 @@ static int nfs4_xdr_dec_deallocate(struct rpc_rqst *rqstp,
 	return status;
 }
 
+/*
+ * Decode ZERO_RANGE request
+ */
+static int nfs4_xdr_dec_zero_range(struct rpc_rqst *rqstp,
+				   struct xdr_stream *xdr,
+				   void *data)
+{
+	struct nfs42_falloc_res *res = data;
+	struct compound_hdr hdr;
+	int status;
+
+	status = decode_compound_hdr(xdr, &hdr);
+	if (status)
+		goto out;
+	status = decode_sequence(xdr, &res->seq_res, rqstp);
+	if (status)
+		goto out;
+	status = decode_putfh(xdr);
+	if (status)
+		goto out;
+	status = decode_deallocate(xdr, res);
+	if (status)
+		goto out;
+	status = decode_allocate(xdr, res);
+	if (status)
+		goto out;
+	decode_getfattr(xdr, res->falloc_fattr, res->falloc_server);
+out:
+	return status;
+}
+
 /*
  * Decode READ_PLUS request
  */
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 1cd9652f3c28..5e9d66f3466c 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -225,8 +225,14 @@ static long nfs42_fallocate(struct file *filep, int mode, loff_t offset, loff_t
 	if (!S_ISREG(inode->i_mode))
 		return -EOPNOTSUPP;
 
-	if ((mode != 0) && (mode != (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)))
+	switch (mode) {
+	case 0:
+	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
+	case FALLOC_FL_ZERO_RANGE:
+		break;
+	default:
 		return -EOPNOTSUPP;
+	}
 
 	ret = inode_newsize_ok(inode, offset + len);
 	if (ret < 0)
@@ -234,6 +240,8 @@ static long nfs42_fallocate(struct file *filep, int mode, loff_t offset, loff_t
 
 	if (mode & FALLOC_FL_PUNCH_HOLE)
 		return nfs42_proc_deallocate(filep, offset, len);
+	else if (mode & FALLOC_FL_ZERO_RANGE)
+		return nfs42_proc_zero_range(filep, offset ,len);
 	return nfs42_proc_allocate(filep, offset, len);
 }
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index bd18ccd85d15..724d7973a0a6 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10816,6 +10816,7 @@ static const struct nfs4_minor_version_ops nfs_v4_2_minor_ops = {
 		| NFS_CAP_OFFLOAD_CANCEL
 		| NFS_CAP_COPY_NOTIFY
 		| NFS_CAP_DEALLOCATE
+		| NFS_CAP_ZERO_RANGE
 		| NFS_CAP_SEEK
 		| NFS_CAP_LAYOUTSTATS
 		| NFS_CAP_CLONE
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 55bef5fbfa47..318afde38057 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -7711,6 +7711,7 @@ const struct rpc_procinfo nfs4_procedures[] = {
 	PROC42(LISTXATTRS,	enc_listxattrs,		dec_listxattrs),
 	PROC42(REMOVEXATTR,	enc_removexattr,	dec_removexattr),
 	PROC42(READ_PLUS,	enc_read_plus,		dec_read_plus),
+	PROC42(ZERO_RANGE,	enc_zero_range,		dec_zero_range),
 };
 
 static unsigned int nfs_version4_counts[ARRAY_SIZE(nfs4_procedures)];
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 20df4480434f..e947af6a3684 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -679,6 +679,7 @@ enum {
 	NFSPROC4_CLNT_SEEK,
 	NFSPROC4_CLNT_ALLOCATE,
 	NFSPROC4_CLNT_DEALLOCATE,
+	NFSPROC4_CLNT_ZERO_RANGE,
 	NFSPROC4_CLNT_LAYOUTSTATS,
 	NFSPROC4_CLNT_CLONE,
 	NFSPROC4_CLNT_COPY,
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index a5dd543494de..c1e59954a77d 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -298,6 +298,7 @@ struct nfs_server {
 #define NFS_CAP_CASE_PRESERVING	(1U << 7)
 #define NFS_CAP_REBOOT_LAYOUTRETURN	(1U << 8)
 #define NFS_CAP_OFFLOAD_STATUS	(1U << 9)
+#define NFS_CAP_ZERO_RANGE	(1U << 10)
 #define NFS_CAP_OPEN_XOR	(1U << 12)
 #define NFS_CAP_DELEGTIME	(1U << 13)
 #define NFS_CAP_POSIX_LOCK	(1U << 14)
-- 
2.49.0


