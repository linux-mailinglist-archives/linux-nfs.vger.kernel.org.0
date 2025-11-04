Return-Path: <linux-nfs+bounces-16004-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32586C31C18
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 16:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C031882D83
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 15:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5101B0439;
	Tue,  4 Nov 2025 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOrNkBq2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992FBB661
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268807; cv=none; b=LirgUOJewh/eNqubSPDmxr0YFseS5HQvbElyA95rtpKmtWDRu8zPSOh3wFoDOVVS+Xs/3Jz6lsetPvMxO5291hWmokdKm59ODIpnd8FyC8U8912bEEcjSvXP/SWskBPqfsOUrwRBzw660bCaMx4k6LPuOOgsbe0NGJsG7PlY2dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268807; c=relaxed/simple;
	bh=IYgNx6RbRMpAa9RETsEMNIbpdMlF6Xh7P8jxUhv4WXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jb81ZohU8uWOi1DCfD4/gkTu5FZyR/dKm4tKPlT8W1zJOolnqSRJupOqY00TudDRmUGO7TBuhnBGXXSGWADrlXRbsAwNt6S2daMgvnFTgkRPUPMmVsyYA7g+P8Hbwbs3kQj8ijnOxLB3UUC8s4Ot6iEqVTSCeMdOTe0/P65Rz4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOrNkBq2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF03BC116C6;
	Tue,  4 Nov 2025 15:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762268807;
	bh=IYgNx6RbRMpAa9RETsEMNIbpdMlF6Xh7P8jxUhv4WXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EOrNkBq289KyMpZFqihLGs2vT+E18Ax3BYX6I0KZIVY2a3zexoP7syTNK6s/sOl6J
	 SHh1DfHw9htLjeXR3ZgPq8B0FaclYvIL9kDHRiVIuxUWLEnRYTVU4v/eTbuhMF6QjL
	 ph6MNwLeNALfr1nyxZtcQR+uMigN2w3oF4RxMdlu6pDns68D6QUQjX8dCn0PrLD+eh
	 vifkE/QNmj6UNe85S9knHSRGXr5QAxF8+vR0Oe3cot/3HfdgOLULfqywhMmRRkhOKn
	 LBaaNEY2mdxiLXKd/TfNxeI5IIQz+mScG4XMZ8213o92px1j1/7vE/QNYsBN2p0QG6
	 3tg1cFUyqh3dw==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH 1/5] NFS: Add support for sending GDD_GETATTR
Date: Tue,  4 Nov 2025 10:06:41 -0500
Message-ID: <20251104150645.719865-2-anna@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251104150645.719865-1-anna@kernel.org>
References: <20251104150645.719865-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

I add this to the existing GETATTR compound as an option extra step that
we can send if the "dir_deleg" flag is set to 'true'. Actually enabling
this value will happen in a later patch.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/nfs4xdr.c        | 106 ++++++++++++++++++++++++++++++++++++++++
 include/linux/nfs_xdr.h |   7 +++
 2 files changed, 113 insertions(+)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 1d0e6c10f921..b6fe30577fab 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -393,6 +393,20 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 				XDR_QUADLEN(NFS4_MAX_SESSIONID_LEN) + 5)
 #define encode_reclaim_complete_maxsz	(op_encode_hdr_maxsz + 4)
 #define decode_reclaim_complete_maxsz	(op_decode_hdr_maxsz + 4)
+#define encode_get_dir_deleg_maxsz (op_encode_hdr_maxsz + \
+				    4 /* gdda_signal_deleg_avail */ + \
+				    8 /* gdda_notification_types */ + \
+				    nfstime4_maxsz /* gdda_child_attr_delay */ + \
+				    nfstime4_maxsz /* gdda_dir_attr_delay */ + \
+				    nfs4_fattr_bitmap_maxsz /* gdda_child_attributes */ + \
+				    nfs4_fattr_bitmap_maxsz /* gdda_dir_attributes */)
+#define decode_get_dir_deleg_maxsz (op_decode_hdr_maxsz + \
+				    4 /* gddrnf_status */ + \
+				    encode_verifier_maxsz /* gddr_cookieverf */ + \
+				    encode_stateid_maxsz /* gddr_stateid */ + \
+				    8 /* gddr_notification */ + \
+				    nfs4_fattr_maxsz /* gddr_child_attributes */ + \
+				    nfs4_fattr_maxsz /* gddr_dir_attributes */)
 #define encode_getdeviceinfo_maxsz (op_encode_hdr_maxsz + \
 				XDR_QUADLEN(NFS4_DEVICEID4_SIZE) + \
 				1 /* layout type */ + \
@@ -444,6 +458,8 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 #else /* CONFIG_NFS_V4_1 */
 #define encode_sequence_maxsz	0
 #define decode_sequence_maxsz	0
+#define encode_get_dir_deleg_maxsz 0
+#define decode_get_dir_deleg_maxsz 0
 #define encode_layoutreturn_maxsz 0
 #define decode_layoutreturn_maxsz 0
 #define encode_layoutget_maxsz	0
@@ -631,11 +647,13 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 #define NFS4_enc_getattr_sz	(compound_encode_hdr_maxsz + \
 				encode_sequence_maxsz + \
 				encode_putfh_maxsz + \
+				encode_get_dir_deleg_maxsz + \
 				encode_getattr_maxsz + \
 				encode_renew_maxsz)
 #define NFS4_dec_getattr_sz	(compound_decode_hdr_maxsz + \
 				decode_sequence_maxsz + \
 				decode_putfh_maxsz + \
+				decode_get_dir_deleg_maxsz + \
 				decode_getattr_maxsz + \
 				decode_renew_maxsz)
 #define NFS4_enc_lookup_sz	(compound_encode_hdr_maxsz + \
@@ -2007,6 +2025,33 @@ static void encode_sequence(struct xdr_stream *xdr,
 }
 
 #ifdef CONFIG_NFS_V4_1
+static void
+encode_get_dir_delegation(struct xdr_stream *xdr, struct compound_hdr *hdr)
+{
+	struct timespec64 ts = { 0, 0 };
+	u32 notifications[1] = { 0 };
+	u32 attributes[1] = { 0 };
+	__be32 *p;
+
+	encode_op_hdr(xdr, OP_GET_DIR_DELEGATION, decode_get_dir_deleg_maxsz, hdr);
+
+	/* We don't handle CB_RECALLABLE_OBJ_AVAIL yet. */
+	xdr_stream_encode_bool(xdr, false);
+
+	xdr_encode_bitmap4(xdr, notifications, ARRAY_SIZE(notifications));
+
+	/* Request no delay on attribute updates */
+	p = reserve_space(xdr, 12 + 12);
+	p = xdr_encode_nfstime4(p, &ts);
+	xdr_encode_nfstime4(p, &ts);
+
+	/* Requested child attributes */
+	xdr_encode_bitmap4(xdr, attributes, ARRAY_SIZE(attributes));
+
+	/* Requested dir attributes */
+	xdr_encode_bitmap4(xdr, attributes, ARRAY_SIZE(attributes));
+}
+
 static void
 encode_getdeviceinfo(struct xdr_stream *xdr,
 		     const struct nfs4_getdeviceinfo_args *args,
@@ -2142,6 +2187,11 @@ static void encode_free_stateid(struct xdr_stream *xdr,
 	encode_nfs4_stateid(xdr, &args->stateid);
 }
 #else
+static inline void
+encode_get_dir_delegation(struct xdr_stream *xdr, struct compound_hdr *hdr)
+{
+}
+
 static inline void
 encode_layoutreturn(struct xdr_stream *xdr,
 		    const struct nfs4_layoutreturn_args *args,
@@ -2356,6 +2406,8 @@ static void nfs4_xdr_enc_getattr(struct rpc_rqst *req, struct xdr_stream *xdr,
 	encode_compound_hdr(xdr, req, &hdr);
 	encode_sequence(xdr, &args->seq_args, &hdr);
 	encode_putfh(xdr, args->fh, &hdr);
+	if (args->get_dir_deleg)
+		encode_get_dir_delegation(xdr, &hdr);
 	encode_getfattr(xdr, args->bitmask, &hdr);
 	encode_nops(&hdr);
 }
@@ -5994,6 +6046,49 @@ static int decode_layout_stateid(struct xdr_stream *xdr, nfs4_stateid *stateid)
 	return decode_stateid(xdr, stateid);
 }
 
+static int decode_get_dir_delegation(struct xdr_stream *xdr,
+				     struct nfs4_getattr_res *res)
+{
+	struct nfs4_gdd_res *gdd_res = res->gdd_res;
+	nfs4_verifier cookieverf;
+	u32 bitmap[1];
+	int status;
+
+	status = decode_op_hdr(xdr, OP_GET_DIR_DELEGATION);
+	if (status)
+		return status;
+
+	if (xdr_stream_decode_u32(xdr, &gdd_res->status))
+		return -EIO;
+
+	if (gdd_res->status == GDD4_UNAVAIL)
+		return xdr_inline_decode(xdr, 4) ? 0 : -EIO;
+
+	status = decode_verifier(xdr, &cookieverf);
+	if (status)
+		return status;
+
+	status = decode_delegation_stateid(xdr, &gdd_res->deleg);
+	if (status)
+		return status;
+
+	/* Decode supported notification types. */
+	status = decode_bitmap4(xdr, bitmap, ARRAY_SIZE(bitmap));
+	if (status < 0)
+		return status;
+
+	/* Decode supported child attributes. */
+	status = decode_bitmap4(xdr, bitmap, ARRAY_SIZE(bitmap));
+	if (status < 0)
+		return status;
+
+	/* Decode supported attributes. */
+	status = decode_bitmap4(xdr, bitmap, ARRAY_SIZE(bitmap));
+	if (status < 0)
+		return status;
+	return 0;
+}
+
 static int decode_getdeviceinfo(struct xdr_stream *xdr,
 				struct nfs4_getdeviceinfo_res *res)
 {
@@ -6208,6 +6303,12 @@ static int decode_free_stateid(struct xdr_stream *xdr,
 	return res->status;
 }
 #else
+static int decode_get_dir_delegation(struct xdr_stream *xdr,
+				     struct nfs4_getattr_res *res)
+{
+	return 0;
+}
+
 static inline
 int decode_layoutreturn(struct xdr_stream *xdr,
 			       struct nfs4_layoutreturn_res *res)
@@ -6525,6 +6626,11 @@ static int nfs4_xdr_dec_getattr(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
 	status = decode_putfh(xdr);
 	if (status)
 		goto out;
+	if (res->gdd_res) {
+		status = decode_get_dir_delegation(xdr, res);
+		if (status)
+			goto out;
+	}
 	status = decode_getfattr(xdr, res->fattr, res->server);
 out:
 	return status;
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 31463286402f..8bf6cba96c46 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1092,12 +1092,19 @@ struct nfs4_getattr_arg {
 	struct nfs4_sequence_args	seq_args;
 	const struct nfs_fh *		fh;
 	const u32 *			bitmask;
+	bool				get_dir_deleg;
+};
+
+struct nfs4_gdd_res {
+	u32				status;
+	nfs4_stateid			deleg;
 };
 
 struct nfs4_getattr_res {
 	struct nfs4_sequence_res	seq_res;
 	const struct nfs_server *	server;
 	struct nfs_fattr *		fattr;
+	struct nfs4_gdd_res *		gdd_res;
 };
 
 struct nfs4_link_arg {
-- 
2.51.2


