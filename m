Return-Path: <linux-nfs+bounces-3713-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9DA9062FE
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 06:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBDB9284710
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 04:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDC913213E;
	Thu, 13 Jun 2024 04:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZdYqWag"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169F0132114
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 04:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718252265; cv=none; b=rXFvpKa1gGUhsAuUvMq0NX9MGklgAyuxl2BKy7dxBtfUHgppt1ZRM1upj3Xvl/aMpOLKioBNtxc3izueIot1/fdREaUuwBl8/wqei2u0yMeBYltL//zr3jmzCPogA+UqehKuh+Mq1M0H1PR3lGKECen8gyVZdMQo320JY6VZykU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718252265; c=relaxed/simple;
	bh=RKnx8TqGkworGn0L2i8+t79TZpqlV/3OSdHEWmd7FYQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fy5kGweicMsbEL4OPk0TcsgJjo532BUtExqA9QLe45vD4Y8U0ksuJDNlC5qdCe/XdwyZPFLfhigbAgLF4NVCGtEpcrFxHDwa8ygNGCoZ5GXo3y2xILHuPBs+YDGNN3owkRda7+D5VjTRcI4IWqAU2jQ2Gi3dRXm1Mpj+QtPqmd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZdYqWag; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-62a2424ed00so7585147b3.1
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 21:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718252263; x=1718857063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kECqbDJ7em0dM3SPVzyC3iT2ndqlyqpNW4GykyAK58M=;
        b=JZdYqWaguCfb1q72WpOVlVzdxInw7hRgHCjhR2w9w/IoqBHnTzHoMjPqy9pU4826NO
         AWetYXtOxxsT2/o+KrAsbLPPEYAWCxPbk0vSMHXrhQdRKzuXHUZTDJ/0cgHC3VF3e6Lu
         OIdBqEidEBWIJ12axIic2M8BmarYZ4TeGS5EmRvpsKNtn39viWHL3sdY32M8bi/euJd0
         62iZY+onY1cEmo+cEWluS2RtgYlY3JSBJx0s32BL1xeAfP/cHuGhJwUIMBpdSrIAbA1Z
         kdEw96367jsbmCbmT0231v40V6JegsiG2W00Xg1y/bkEVvW5lt89yatKpQF/x9XIA6Iw
         5vrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718252263; x=1718857063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kECqbDJ7em0dM3SPVzyC3iT2ndqlyqpNW4GykyAK58M=;
        b=xCla6xvg1cJ3vfv1PCiBpDlXGE4F/4I0nroWqTp8vouSMlpr/IhT76dzLfQel/LRCp
         Hn1LlokSTqah1UPgsl4jpjNWHarTK3y4dnAnMCFwcXf6iq9H0xhETUXXzCr5fnQdMwi9
         faEIb5cu/MkRvuR+mNKlc+xnXa88FxOSjpK3D5TQ0SLRW8SfIPTvLgsqr7eqFoS6sDG5
         ASkVqD56ojOGikQs04W+brnmSg1xx4YTfN8M4yvXDsN1A/ogSkpYzq/kOdlhQP482i3A
         ouGp7BRsw6GAFbIGZL8YoxlELd5HHYCrEpO+a/AqwsOrtrNP5JZ4iQZWv77S4ROWW4jQ
         goDg==
X-Gm-Message-State: AOJu0Yy+VbedLdjpe50CzT9MBy7yw95yDjHf3odO8Ez/K5jtmEsfvVyK
	rtkI9l3LiQano2fzeB2/VzP7NvzB5Wf1o70VkiE40Gi7bgIZ5FPOgESI
X-Google-Smtp-Source: AGHT+IFAsjQrJmO4JStcRzOKEPqDlMq/m8ukebpB+yxhbsDIeGLTr3E5AxFHNRAodlLsd7UI+fuEvw==
X-Received: by 2002:a25:df8e:0:b0:dfd:c2df:32 with SMTP id 3f1490d57ef6-dfe68d07110mr3391563276.63.1718252262705;
        Wed, 12 Jun 2024 21:17:42 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c68ff3sm2851546d6.74.2024.06.12.21.17.41
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 21:17:42 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 04/19] NFSv4: Plumb in XDR support for the new delegation-only setattr op
Date: Thu, 13 Jun 2024 00:11:21 -0400
Message-ID: <20240613041136.506908-5-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613041136.506908-4-trond.myklebust@hammerspace.com>
References: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
 <20240613041136.506908-2-trond.myklebust@hammerspace.com>
 <20240613041136.506908-3-trond.myklebust@hammerspace.com>
 <20240613041136.506908-4-trond.myklebust@hammerspace.com>
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
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c       | 25 ++++++++++++++++++++
 fs/nfs/nfs4xdr.c        | 51 +++++++++++++++++++++++++++++++++++++++++
 include/linux/nfs_xdr.h | 10 ++++++++
 3 files changed, 86 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ce47cf2f9301..0ed734ab448e 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6554,6 +6554,7 @@ struct nfs4_delegreturndata {
 		u32 roc_barrier;
 		bool roc;
 	} lr;
+	struct nfs4_delegattr sattr;
 	struct nfs_fattr fattr;
 	int rpc_status;
 	struct inode *inode;
@@ -6578,6 +6579,30 @@ static void nfs4_delegreturn_done(struct rpc_task *task, void *calldata)
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


