Return-Path: <linux-nfs+bounces-3863-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BD290A1B4
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 03:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E525C1C21480
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 01:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59A2D27A;
	Mon, 17 Jun 2024 01:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4CI4cdW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907A6C2E9
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718587511; cv=none; b=P9BcEwaPFEZ0wWUobDF9B62avWqCEqMw9m5upiLBH5P4z3gLgSz8A8QqmpdRlwfPa4xVgksq/wTKRaWuDK2oMSmWfzAcMZuwXdVktQ3gnNe0XRlnVAmtt+89vXjwDF4cJA7igens77qEFwXaauaffZIksYrj+dJXf+ctonj9Hss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718587511; c=relaxed/simple;
	bh=q8SMVtXqUQGCz5cA322/qlOWjJ3KYksWJaw5q59qRdw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKVhkKu6EajIOU3VyIZnuSbxW1AKef8jaWuJfi92IKhmIGuEKfk5FpFh0xxUnwWHVD3wW7Og6bUFK83SOEv7ZgCYj5LZqbI3C3504jnpeLbuAxZpOrTxSszFxCHNBhV/X/eqc0NQS3kO2FiMfjJvqf+eIs94CUUuTo+tgKArCGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4CI4cdW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F4FC4AF48
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718587511;
	bh=q8SMVtXqUQGCz5cA322/qlOWjJ3KYksWJaw5q59qRdw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=X4CI4cdWylZRrPs7dRGOmjBtCD5W993n4VKE6mTQH71zmss7735iS3hN5ODo88dLW
	 2SQZ/igtyaUOWYRic18V8Pen9Rx2bWXd8WW1cTpeauGoOzgLNjqXZfwbujBqyXx/KG
	 bSiy9Wd61ZaAFgLDPwmV89634+Bdt7QOsJROUyWKuyhpoXFYe3RWyWCP/KsPCJ/eoq
	 Y2O5mf9zJhLR1FSSGxCMrviSUJHxCCSaZOJnOHdkjr344JJ9FpzyCMp3xuM3eg/XRc
	 agqjE2Zy6IvxDpfxwWeU8edzbv05qY/zHzyzmLXeD6D+qnM3iYtLMor2ioyeR9FMj+
	 v/OE8zaunu9Eg==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH v2 04/19] NFSv4: Plumb in XDR support for the new delegation-only setattr op
Date: Sun, 16 Jun 2024 21:21:22 -0400
Message-ID: <20240617012137.674046-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617012137.674046-4-trondmy@kernel.org>
References: <20240617012137.674046-1-trondmy@kernel.org>
 <20240617012137.674046-2-trondmy@kernel.org>
 <20240617012137.674046-3-trondmy@kernel.org>
 <20240617012137.674046-4-trondmy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

We want to send the updated atime and mtime as part of the delegreturn
compound. Add a special structure to hold those variables.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c       | 25 ++++++++++++++++++++
 fs/nfs/nfs4xdr.c        | 51 +++++++++++++++++++++++++++++++++++++++++
 include/linux/nfs_xdr.h | 10 ++++++++
 3 files changed, 86 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 90df37f3866a..af0758210162 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6575,6 +6575,7 @@ struct nfs4_delegreturndata {
 		u32 roc_barrier;
 		bool roc;
 	} lr;
+	struct nfs4_delegattr sattr;
 	struct nfs_fattr fattr;
 	int rpc_status;
 	struct inode *inode;
@@ -6599,6 +6600,30 @@ static void nfs4_delegreturn_done(struct rpc_task *task, void *calldata)
 			  &data->res.lr_ret) == -EAGAIN)
 		goto out_restart;
 
+	if (data->args.sattr_args && task->tk_status != 0) {
+		switch(data->res.sattr_ret) {
+		case 0:
+			data->args.sattr_args = NULL;
+			data->res.sattr_res = false;
+			break;
+		case -NFS4ERR_ADMIN_REVOKED:
+		case -NFS4ERR_DELEG_REVOKED:
+		case -NFS4ERR_EXPIRED:
+		case -NFS4ERR_BAD_STATEID:
+			/* Let the main handler below do stateid recovery */
+			break;
+		case -NFS4ERR_OLD_STATEID:
+			if (nfs4_refresh_delegation_stateid(&data->stateid,
+						data->inode))
+				goto out_restart;
+			fallthrough;
+		default:
+			data->args.sattr_args = NULL;
+			data->res.sattr_res = false;
+			goto out_restart;
+		}
+	}
+
 	switch (task->tk_status) {
 	case 0:
 		renew_lease(data->res.server, data->timestamp);
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 119061da5298..4c22b865b9c9 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -224,6 +224,11 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 				 encode_attrs_maxsz)
 #define decode_setattr_maxsz	(op_decode_hdr_maxsz + \
 				 nfs4_fattr_bitmap_maxsz)
+#define encode_delegattr_maxsz	(op_encode_hdr_maxsz + \
+				 encode_stateid_maxsz + \
+				nfs4_fattr_bitmap_maxsz + \
+				2*nfstime4_maxsz)
+#define decode_delegattr_maxsz	(decode_setattr_maxsz)
 #define encode_read_maxsz	(op_encode_hdr_maxsz + \
 				 encode_stateid_maxsz + 3)
 #define decode_read_maxsz	(op_decode_hdr_maxsz + 2 + pagepad_maxsz)
@@ -758,12 +763,14 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 				encode_sequence_maxsz + \
 				encode_putfh_maxsz + \
 				encode_layoutreturn_maxsz + \
+				encode_delegattr_maxsz + \
 				encode_delegreturn_maxsz + \
 				encode_getattr_maxsz)
 #define NFS4_dec_delegreturn_sz (compound_decode_hdr_maxsz + \
 				decode_sequence_maxsz + \
 				decode_putfh_maxsz + \
 				decode_layoutreturn_maxsz + \
+				decode_delegattr_maxsz + \
 				decode_delegreturn_maxsz + \
 				decode_getattr_maxsz)
 #define NFS4_enc_getacl_sz	(compound_encode_hdr_maxsz + \
@@ -1735,6 +1742,33 @@ static void encode_setattr(struct xdr_stream *xdr, const struct nfs_setattrargs
 			server->attr_bitmask);
 }
 
+static void encode_delegattr(struct xdr_stream *xdr,
+		const nfs4_stateid *stateid,
+		const struct nfs4_delegattr *attr,
+		struct compound_hdr *hdr)
+{
+	uint32_t bitmap[3] = { 0 };
+	uint32_t len = 0;
+	__be32 *p;
+
+	encode_op_hdr(xdr, OP_SETATTR, encode_delegattr_maxsz, hdr);
+	encode_nfs4_stateid(xdr, stateid);
+	if (attr->atime_set) {
+		bitmap[2] |= FATTR4_WORD2_TIME_DELEG_ACCESS;
+		len += (nfstime4_maxsz << 2);
+	}
+	if (attr->mtime_set) {
+		bitmap[2] |= FATTR4_WORD2_TIME_DELEG_MODIFY;
+		len += (nfstime4_maxsz << 2);
+	}
+	xdr_encode_bitmap4(xdr, bitmap, ARRAY_SIZE(bitmap));
+	xdr_stream_encode_opaque_inline(xdr, (void **)&p, len);
+	if (bitmap[2] & FATTR4_WORD2_TIME_DELEG_ACCESS)
+		p = xdr_encode_nfstime4(p, &attr->atime);
+	if (bitmap[2] & FATTR4_WORD2_TIME_DELEG_MODIFY)
+		p = xdr_encode_nfstime4(p, &attr->mtime);
+}
+
 static void encode_setclientid(struct xdr_stream *xdr, const struct nfs4_setclientid *setclientid, struct compound_hdr *hdr)
 {
 	__be32 *p;
@@ -2812,6 +2846,8 @@ static void nfs4_xdr_enc_delegreturn(struct rpc_rqst *req,
 	encode_putfh(xdr, args->fhandle, &hdr);
 	if (args->lr_args)
 		encode_layoutreturn(xdr, args->lr_args, &hdr);
+	if (args->sattr_args)
+		encode_delegattr(xdr, args->stateid, args->sattr_args, &hdr);
 	if (args->bitmask)
 		encode_getfattr(xdr, args->bitmask, &hdr);
 	encode_delegreturn(xdr, args->stateid, &hdr);
@@ -5163,9 +5199,11 @@ static int decode_rw_delegation(struct xdr_stream *xdr,
 
 	switch (res->open_delegation_type) {
 	case NFS4_OPEN_DELEGATE_READ:
+	case NFS4_OPEN_DELEGATE_READ_ATTRS_DELEG:
 		res->type = FMODE_READ;
 		break;
 	case NFS4_OPEN_DELEGATE_WRITE:
+	case NFS4_OPEN_DELEGATE_WRITE_ATTRS_DELEG:
 		res->type = FMODE_WRITE|FMODE_READ;
 		if (decode_space_limit(xdr, &res->pagemod_limit) < 0)
 				return -EIO;
@@ -5207,6 +5245,8 @@ static int decode_delegation(struct xdr_stream *xdr,
 		return 0;
 	case NFS4_OPEN_DELEGATE_READ:
 	case NFS4_OPEN_DELEGATE_WRITE:
+	case NFS4_OPEN_DELEGATE_READ_ATTRS_DELEG:
+	case NFS4_OPEN_DELEGATE_WRITE_ATTRS_DELEG:
 		return decode_rw_delegation(xdr, res);
 	case NFS4_OPEN_DELEGATE_NONE_EXT:
 		return decode_no_delegation(xdr, res);
@@ -5480,6 +5520,11 @@ static int decode_setattr(struct xdr_stream *xdr)
 	return -EIO;
 }
 
+static int decode_delegattr(struct xdr_stream *xdr)
+{
+	return decode_setattr(xdr);
+}
+
 static int decode_setclientid(struct xdr_stream *xdr, struct nfs4_setclientid_res *res)
 {
 	__be32 *p;
@@ -7052,6 +7097,12 @@ static int nfs4_xdr_dec_delegreturn(struct rpc_rqst *rqstp,
 		if (status)
 			goto out;
 	}
+	if (res->sattr_res) {
+		status = decode_delegattr(xdr);
+		res->sattr_ret = status;
+		if (status)
+			goto out;
+	}
 	if (res->fattr) {
 		status = decode_getfattr(xdr, res->fattr, res->server);
 		if (status != 0)
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 682559e19d9d..f40be64ce942 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -622,6 +622,13 @@ struct nfs_release_lockowner_res {
 	struct nfs4_sequence_res	seq_res;
 };
 
+struct nfs4_delegattr {
+	struct timespec64	atime;
+	struct timespec64	mtime;
+	bool			atime_set;
+	bool			mtime_set;
+};
+
 struct nfs4_delegreturnargs {
 	struct nfs4_sequence_args	seq_args;
 	const struct nfs_fh *fhandle;
@@ -629,6 +636,7 @@ struct nfs4_delegreturnargs {
 	const u32 *bitmask;
 	u32 bitmask_store[NFS_BITMASK_SZ];
 	struct nfs4_layoutreturn_args *lr_args;
+	struct nfs4_delegattr *sattr_args;
 };
 
 struct nfs4_delegreturnres {
@@ -637,6 +645,8 @@ struct nfs4_delegreturnres {
 	struct nfs_server *server;
 	struct nfs4_layoutreturn_res *lr_res;
 	int lr_ret;
+	bool sattr_res;
+	int sattr_ret;
 };
 
 /*
-- 
2.45.2


