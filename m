Return-Path: <linux-nfs+bounces-7166-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF2A99D76C
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 21:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB5F9B22DF9
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 19:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CEE1D0F42;
	Mon, 14 Oct 2024 19:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8Sp5YKk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79AE1D0E11;
	Mon, 14 Oct 2024 19:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728934037; cv=none; b=rg9+uheZ5s2nQjy4XuoWIKmxrdIuzt5FVUqTzuT36jj1+pn5i3NkO4Bt+VOcpZzRkk+SO5tW6/PyVhwLceoeluI96skDrOGY46JpNk9VkgAzQmHHugBSl0L0KPdA1rNBySLWCqo4pjjao3wAVoUPmUafHDBSTCpqAILfzC3Dgzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728934037; c=relaxed/simple;
	bh=dGisJLqg+eYXaCTTby/7OSGEFV+swIbLcK0osBkVzXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t7ZyCjXRwPo61pEJaQw8a3rsXdypxHXMPYoChD/MtQIldIlv2Wh7OA7LWy14f9FXVVEC8gSIhfKxiPeO2uTsna+FRTUoDGO/srJtf2TTe7Gca1OeVPcUI/FkEh/+6oHFzjPfkb8Cr6PTfuRR6B13AmQz8m2TNG9UYiUgRxV1upA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8Sp5YKk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132D2C4CEC3;
	Mon, 14 Oct 2024 19:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728934036;
	bh=dGisJLqg+eYXaCTTby/7OSGEFV+swIbLcK0osBkVzXI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=t8Sp5YKkz6tJPQ1KIsDf0jqUefEjiALBdmpikZPtxQUkgEvD+x6Tg48HDggYt3Iox
	 khftxO4trS7SH2KjYKWylM8litC/8Ys/fgCAnFAS/uXG2c3dqVJuTQHGwYmfxQVH2f
	 eQCsup0HRFbYOtIIQI1FsBlCa5zcouGvMB5XmQWAUlTt7FuD5KeFKLdqsyMmfj8e7o
	 eo3oow6pediWPD0IfG51IPY/674YjCKD0XBbHaeN5NXrX9Kkt1m9WxpED0OyIGlBy4
	 yuNIgFpoJCbAzfj7x4C9l/umynzTBmMnRC5x2BSUTN7xHsjEK+WLHd+wutx8pY+CK2
	 aLZ/2wzaW63Fg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 14 Oct 2024 15:26:53 -0400
Subject: [PATCH 5/6] nfsd: add support for delegated timestamps
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-delstid-v1-5-7ce8a2f4dd24@kernel.org>
References: <20241014-delstid-v1-0-7ce8a2f4dd24@kernel.org>
In-Reply-To: <20241014-delstid-v1-0-7ce8a2f4dd24@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jonathan Corbet <corbet@lwn.net>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Thomas Haynes <loghyr@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14554; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=dGisJLqg+eYXaCTTby/7OSGEFV+swIbLcK0osBkVzXI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnDXCLJ4yxG39i7M0cYMbhO/c1gYbvdaslrfTKI
 +Fk0J+sQWiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZw1wiwAKCRAADmhBGVaC
 FfqxD/98bfSMTOe2kLj4WruxtgG+Mor+qXiVjWOQPtUFl823Vm8suNZfNA+kyfLzmh5TsUXWMok
 asJecnzlApGMK1NAuT88NWn5JFiEV9ZZZaJ/9qj68SVFPL1mhTFeOANkZImWO/wnGGhVtands69
 SlqvOo/8Cw+yKCszsrfgHuqcNgHIaSXF34ujXU8XMqhPOA86oi5q+2EmPHn4J2nvYnKTui6SLCF
 8JOfgkp4zBeBvaPtGrgw72vYaHJFi1HrMVxZnIrj41Yws0SKqKpIcj/CR2FHLcH0EAf3AlfeJyM
 V3h8c0cfE80lkfhq/RSSjV4r1CTXTH+UmtdIyONCuQfmZDqrZOd9mMpgZIiA/fSLakM7qLxVvQg
 9yg1LoRjz6pve2SaGied3EA13NQLdzMyQxBEkcrojkfIHReVDYh7g0GFBDPsXRivhz2OLSDArcS
 6u8kv63vf2AX2JrwcdeZNpM8ZEMdW651pDzgH2m/CIXcjRmQ1EopIyPjBZkLwxyUP7Te5teLGEB
 U8i/e1plJzRSTmqzlmmE+UYBW9nBreuN/hqxW/V9zae8wSjMe+AEClKIiyKvgM2XPHJXkVrhuAD
 6RuTWP7/uB+tRkwjWRq51baotMaxH/uEKH08w9PUOGC8N3gzRDkHw6M8e8beU3EK3cztadBoo69
 CMk7TUDqezDJGQg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add support for the delegated timestamps on write delegations. This
allows the server to proxy timestamps from the delegation holder to
other clients that are doing GETATTRs vs. the same inode.

When OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS bit is set in the OPEN
call, set the dl_type to the *_ATTRS_DELEG flavor of delegation.

Add timespec64 fields to nfs4_cb_fattr and decode the timestamps into
those. Vet those timestamps according to the delstid spec and update
the inode attrs if necessary.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c | 42 +++++++++++++++++++--
 fs/nfsd/nfs4state.c    | 99 +++++++++++++++++++++++++++++++++++++++++++-------
 fs/nfsd/nfs4xdr.c      | 13 ++++++-
 fs/nfsd/nfsd.h         |  2 +
 fs/nfsd/state.h        |  2 +
 fs/nfsd/xdr4cb.h       | 10 +++--
 include/linux/time64.h |  5 +++
 7 files changed, 151 insertions(+), 22 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 776838bb83e6b707a4df76326cdc68f32daf1755..08245596289a960eb8b2e78df276544e7d3f4ff8 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -42,6 +42,7 @@
 #include "trace.h"
 #include "xdr4cb.h"
 #include "xdr4.h"
+#include "nfs4xdr_gen.h"
 
 #define NFSDDBG_FACILITY                NFSDDBG_PROC
 
@@ -93,12 +94,35 @@ static int decode_cb_fattr4(struct xdr_stream *xdr, uint32_t *bitmap,
 {
 	fattr->ncf_cb_change = 0;
 	fattr->ncf_cb_fsize = 0;
+	fattr->ncf_cb_atime.tv_sec = 0;
+	fattr->ncf_cb_atime.tv_nsec = 0;
+	fattr->ncf_cb_mtime.tv_sec = 0;
+	fattr->ncf_cb_mtime.tv_nsec = 0;
+
 	if (bitmap[0] & FATTR4_WORD0_CHANGE)
 		if (xdr_stream_decode_u64(xdr, &fattr->ncf_cb_change) < 0)
 			return -NFSERR_BAD_XDR;
 	if (bitmap[0] & FATTR4_WORD0_SIZE)
 		if (xdr_stream_decode_u64(xdr, &fattr->ncf_cb_fsize) < 0)
 			return -NFSERR_BAD_XDR;
+	if (bitmap[2] & FATTR4_WORD2_TIME_DELEG_ACCESS) {
+		fattr4_time_deleg_access access;
+
+		if (!xdrgen_decode_fattr4_time_deleg_access(xdr, &access))
+			return -NFSERR_BAD_XDR;
+		fattr->ncf_cb_atime.tv_sec = access.seconds;
+		fattr->ncf_cb_atime.tv_nsec = access.nseconds;
+
+	}
+	if (bitmap[2] & FATTR4_WORD2_TIME_DELEG_MODIFY) {
+		fattr4_time_deleg_modify modify;
+
+		if (!xdrgen_decode_fattr4_time_deleg_modify(xdr, &modify))
+			return -NFSERR_BAD_XDR;
+		fattr->ncf_cb_mtime.tv_sec = modify.seconds;
+		fattr->ncf_cb_mtime.tv_nsec = modify.nseconds;
+
+	}
 	return 0;
 }
 
@@ -364,15 +388,21 @@ encode_cb_getattr4args(struct xdr_stream *xdr, struct nfs4_cb_compound_hdr *hdr,
 	struct nfs4_delegation *dp = container_of(fattr, struct nfs4_delegation, dl_cb_fattr);
 	struct knfsd_fh *fh = &dp->dl_stid.sc_file->fi_fhandle;
 	struct nfs4_cb_fattr *ncf = &dp->dl_cb_fattr;
-	u32 bmap[1];
+	u32 bmap_size = 1;
+	u32 bmap[3];
 
 	bmap[0] = FATTR4_WORD0_SIZE;
 	if (!ncf->ncf_file_modified)
 		bmap[0] |= FATTR4_WORD0_CHANGE;
 
+	if (deleg_attrs_deleg(dp->dl_type)) {
+		bmap[1] = 0;
+		bmap[2] = FATTR4_WORD2_TIME_DELEG_ACCESS | FATTR4_WORD2_TIME_DELEG_MODIFY;
+		bmap_size = 3;
+	}
 	encode_nfs_cb_opnum4(xdr, OP_CB_GETATTR);
 	encode_nfs_fh4(xdr, fh);
-	encode_bitmap4(xdr, bmap, ARRAY_SIZE(bmap));
+	encode_bitmap4(xdr, bmap, bmap_size);
 	hdr->nops++;
 }
 
@@ -597,7 +627,7 @@ static int nfs4_xdr_dec_cb_getattr(struct rpc_rqst *rqstp,
 	struct nfs4_cb_compound_hdr hdr;
 	int status;
 	u32 bitmap[3] = {0};
-	u32 attrlen;
+	u32 attrlen, maxlen;
 	struct nfs4_cb_fattr *ncf =
 		container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
 
@@ -616,7 +646,11 @@ static int nfs4_xdr_dec_cb_getattr(struct rpc_rqst *rqstp,
 		return -NFSERR_BAD_XDR;
 	if (xdr_stream_decode_u32(xdr, &attrlen) < 0)
 		return -NFSERR_BAD_XDR;
-	if (attrlen > (sizeof(ncf->ncf_cb_change) + sizeof(ncf->ncf_cb_fsize)))
+	maxlen = sizeof(ncf->ncf_cb_change) + sizeof(ncf->ncf_cb_fsize);
+	if (bitmap[2] != 0)
+		maxlen += (sizeof(ncf->ncf_cb_mtime.tv_sec) +
+			   sizeof(ncf->ncf_cb_mtime.tv_nsec)) * 2;
+	if (attrlen > maxlen)
 		return -NFSERR_BAD_XDR;
 	status = decode_cb_fattr4(xdr, bitmap, ncf);
 	return status;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 62f9aeb159d0f2ab4d293bf5c0c56ad7b86eb9d6..2c8d2bb5261ad189c6dfb1c4050c23d8cf061325 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5803,13 +5803,14 @@ static struct nfs4_delegation *
 nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 		    struct svc_fh *parent)
 {
-	int status = 0;
+	bool deleg_ts = open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS;
 	struct nfs4_client *clp = stp->st_stid.sc_client;
 	struct nfs4_file *fp = stp->st_stid.sc_file;
 	struct nfs4_clnt_odstate *odstate = stp->st_clnt_odstate;
 	struct nfs4_delegation *dp;
 	struct nfsd_file *nf = NULL;
 	struct file_lease *fl;
+	int status = 0;
 	u32 dl_type;
 
 	/*
@@ -5834,7 +5835,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	 */
 	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_BOTH) {
 		nf = find_rw_file(fp);
-		dl_type = OPEN_DELEGATE_WRITE;
+		dl_type = deleg_ts ? OPEN_DELEGATE_WRITE_ATTRS_DELEG : OPEN_DELEGATE_WRITE;
 	}
 
 	/*
@@ -5843,7 +5844,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	 */
 	if (!nf && (open->op_share_access & NFS4_SHARE_ACCESS_READ)) {
 		nf = find_readable_file(fp);
-		dl_type = OPEN_DELEGATE_READ;
+		dl_type = deleg_ts ? OPEN_DELEGATE_READ_ATTRS_DELEG : OPEN_DELEGATE_READ;
 	}
 
 	if (!nf)
@@ -6001,13 +6002,14 @@ static void
 nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 		     struct svc_fh *currentfh)
 {
-	struct nfs4_delegation *dp;
+	bool deleg_ts = open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS;
 	struct nfs4_openowner *oo = openowner(stp->st_stateowner);
 	struct nfs4_client *clp = stp->st_stid.sc_client;
 	struct svc_fh *parent = NULL;
-	int cb_up;
-	int status = 0;
+	struct nfs4_delegation *dp;
 	struct kstat stat;
+	int status = 0;
+	int cb_up;
 
 	cb_up = nfsd4_cb_channel_good(oo->oo_owner.so_client);
 	open->op_recall = false;
@@ -6048,12 +6050,14 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 			destroy_delegation(dp);
 			goto out_no_deleg;
 		}
-		open->op_delegate_type = OPEN_DELEGATE_WRITE;
+		open->op_delegate_type = deleg_ts ? OPEN_DELEGATE_WRITE_ATTRS_DELEG :
+						    OPEN_DELEGATE_WRITE;
 		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
 		dp->dl_cb_fattr.ncf_initial_cinfo = nfsd4_change_attribute(&stat);
 		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
 	} else {
-		open->op_delegate_type = OPEN_DELEGATE_READ;
+		open->op_delegate_type = deleg_ts ? OPEN_DELEGATE_READ_ATTRS_DELEG :
+						    OPEN_DELEGATE_READ;
 		trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
 	}
 	nfs4_put_stid(&dp->dl_stid);
@@ -8887,6 +8891,78 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
 	get_stateid(cstate, &u->write.wr_stateid);
 }
 
+/**
+ * set_cb_time - vet and set the timespec for a cb_getattr update
+ * @cb: timestamp from the CB_GETATTR response
+ * @orig: original timestamp in the inode
+ * @now: current time
+ *
+ * Given a timestamp in a CB_GETATTR response, check it against the
+ * current timestamp in the inode and the current time. Returns true
+ * if the inode's timestamp needs to be updated, and false otherwise.
+ * @cb may also be changed if the timestamp needs to be clamped.
+ */
+static bool set_cb_time(struct timespec64 *cb, const struct timespec64 *orig,
+			const struct timespec64 *now)
+{
+
+	/*
+	 * "When the time presented is before the original time, then the
+	 *  update is ignored." Also no need to update if there is no change.
+	 */
+	if (timespec64_compare(cb, orig) <= 0)
+		return false;
+
+	/*
+	 * "When the time presented is in the future, the server can either
+	 *  clamp the new time to the current time, or it may
+	 *  return NFS4ERR_DELAY to the client, allowing it to retry."
+	 */
+	if (timespec64_compare(cb, now) > 0) {
+		/* clamp it */
+		*cb = *now;
+	}
+
+	return true;
+}
+
+static int cb_getattr_update_times(struct dentry *dentry, struct nfs4_delegation *dp)
+{
+	struct inode *inode = d_inode(dentry);
+	struct timespec64 now = current_time(inode);
+	struct nfs4_cb_fattr *ncf = &dp->dl_cb_fattr;
+	struct iattr attrs = { };
+	int ret;
+
+	if (deleg_attrs_deleg(dp->dl_type)) {
+		struct timespec64 atime = inode_get_atime(inode);
+		struct timespec64 mtime = inode_get_mtime(inode);
+
+		attrs.ia_atime = ncf->ncf_cb_atime;
+		attrs.ia_mtime = ncf->ncf_cb_mtime;
+
+		if (set_cb_time(&attrs.ia_atime, &atime, &now))
+			attrs.ia_valid |= ATTR_ATIME | ATTR_ATIME_SET;
+
+		if (set_cb_time(&attrs.ia_mtime, &mtime, &now)) {
+			attrs.ia_valid |= ATTR_CTIME | ATTR_MTIME | ATTR_MTIME_SET;
+			attrs.ia_ctime = attrs.ia_mtime;
+		}
+	} else {
+		attrs.ia_valid |= ATTR_MTIME | ATTR_CTIME;
+		attrs.ia_mtime = attrs.ia_ctime = now;
+	}
+
+	if (!attrs.ia_valid)
+		return 0;
+
+	attrs.ia_valid |= ATTR_DELEG;
+	inode_lock(inode);
+	ret = notify_change(&nop_mnt_idmap, dentry, &attrs, NULL);
+	inode_unlock(inode);
+	return ret;
+}
+
 /**
  * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
  * @rqstp: RPC transaction context
@@ -8913,7 +8989,6 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 	struct file_lock_context *ctx;
 	struct nfs4_delegation *dp = NULL;
 	struct file_lease *fl;
-	struct iattr attrs;
 	struct nfs4_cb_fattr *ncf;
 	struct inode *inode = d_inode(dentry);
 
@@ -8975,11 +9050,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 		 * not update the file's metadata with the client's
 		 * modified size
 		 */
-		attrs.ia_mtime = attrs.ia_ctime = current_time(inode);
-		attrs.ia_valid = ATTR_MTIME | ATTR_CTIME | ATTR_DELEG;
-		inode_lock(inode);
-		err = notify_change(&nop_mnt_idmap, dentry, &attrs, NULL);
-		inode_unlock(inode);
+		err = cb_getattr_update_times(dentry, dp);
 		if (err) {
 			status = nfserrno(err);
 			goto out_status;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 1c9d9349e4447c0078c7de0d533cf6278941679d..0e9f59f6be015bfa37893973f38fec880ff4c0b1 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3409,6 +3409,7 @@ static __be32 nfsd4_encode_fattr4_xattr_support(struct xdr_stream *xdr,
 #define NFSD_OA_SHARE_ACCESS_WANT	(BIT(OPEN_ARGS_SHARE_ACCESS_WANT_ANY_DELEG)		| \
 					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_NO_DELEG)		| \
 					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL)		| \
+					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS)	| \
 					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION))
 
 #define NFSD_OA_OPEN_CLAIM	(BIT(OPEN_ARGS_OPEN_CLAIM_NULL)		| \
@@ -3602,7 +3603,11 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		if (status)
 			goto out;
 	}
-	if (attrmask[0] & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
+	if ((attrmask[0] & (FATTR4_WORD0_CHANGE |
+			    FATTR4_WORD0_SIZE)) ||
+	    (attrmask[1] & (FATTR4_WORD1_TIME_ACCESS |
+			    FATTR4_WORD1_TIME_MODIFY |
+			    FATTR4_WORD1_TIME_METADATA))) {
 		status = nfsd4_deleg_getattr_conflict(rqstp, dentry, &dp);
 		if (status)
 			goto out;
@@ -3617,8 +3622,14 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		if (ncf->ncf_file_modified) {
 			++ncf->ncf_initial_cinfo;
 			args.stat.size = ncf->ncf_cur_fsize;
+			if (!timespec64_is_epoch(&ncf->ncf_cb_mtime))
+				args.stat.mtime = ncf->ncf_cb_mtime;
 		}
 		args.change_attr = ncf->ncf_initial_cinfo;
+
+		if (!timespec64_is_epoch(&ncf->ncf_cb_atime))
+			args.stat.atime = ncf->ncf_cb_atime;
+
 		nfs4_put_stid(&dp->dl_stid);
 	} else {
 		args.change_attr = nfsd4_change_attribute(&args.stat);
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 1955c8e9c4c793728fa75dd136cadc735245483f..004415651295891b3440f52a4c986e3a668a48cb 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -459,6 +459,8 @@ enum {
 	FATTR4_WORD2_MODE_UMASK | \
 	NFSD4_2_SECURITY_ATTRS | \
 	FATTR4_WORD2_XATTR_SUPPORT | \
+	FATTR4_WORD2_TIME_DELEG_ACCESS | \
+	FATTR4_WORD2_TIME_DELEG_MODIFY | \
 	FATTR4_WORD2_OPEN_ARGUMENTS)
 
 extern const u32 nfsd_suppattrs[3][3];
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 9d0e844515aa6ea0ec62f2b538ecc2c6a5e34652..6351e6eca7cc63ccf82a3a081cef39042d52f4e9 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -142,6 +142,8 @@ struct nfs4_cb_fattr {
 	/* from CB_GETATTR reply */
 	u64 ncf_cb_change;
 	u64 ncf_cb_fsize;
+	struct timespec64 ncf_cb_mtime;
+	struct timespec64 ncf_cb_atime;
 
 	unsigned long ncf_cb_flags;
 	bool ncf_file_modified;
diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
index e8b00309c449fe2667f7d48cda88ec0cff924f93..f1a315cd31b74f73f1d52702ae7b5c93d51ddf82 100644
--- a/fs/nfsd/xdr4cb.h
+++ b/fs/nfsd/xdr4cb.h
@@ -59,16 +59,20 @@
  * 1: CB_GETATTR opcode (32-bit)
  * N: file_handle
  * 1: number of entry in attribute array (32-bit)
- * 1: entry 0 in attribute array (32-bit)
+ * 3: entry 0-2 in attribute array (32-bit * 3)
  */
 #define NFS4_enc_cb_getattr_sz		(cb_compound_enc_hdr_sz +       \
 					cb_sequence_enc_sz +            \
-					1 + enc_nfs4_fh_sz + 1 + 1)
+					1 + enc_nfs4_fh_sz + 1 + 3)
 /*
  * 4: fattr_bitmap_maxsz
  * 1: attribute array len
  * 2: change attr (64-bit)
  * 2: size (64-bit)
+ * 2: atime.seconds (64-bit)
+ * 1: atime.nanoseconds (32-bit)
+ * 2: mtime.seconds (64-bit)
+ * 1: mtime.nanoseconds (32-bit)
  */
 #define NFS4_dec_cb_getattr_sz		(cb_compound_dec_hdr_sz  +      \
-			cb_sequence_dec_sz + 4 + 1 + 2 + 2 + op_dec_sz)
+			cb_sequence_dec_sz + 4 + 1 + 2 + 2 + 2 + 1 + 2 + 1 + op_dec_sz)
diff --git a/include/linux/time64.h b/include/linux/time64.h
index f1bcea8c124a361b6c1e3c98ef915840c22a8413..9934331c7b86b7fb981c7aec0494ac2f5e72977e 100644
--- a/include/linux/time64.h
+++ b/include/linux/time64.h
@@ -49,6 +49,11 @@ static inline int timespec64_equal(const struct timespec64 *a,
 	return (a->tv_sec == b->tv_sec) && (a->tv_nsec == b->tv_nsec);
 }
 
+static inline bool timespec64_is_epoch(const struct timespec64 *ts)
+{
+	return ts->tv_sec == 0 && ts->tv_nsec == 0;
+}
+
 /*
  * lhs < rhs:  return <0
  * lhs == rhs: return 0

-- 
2.47.0


