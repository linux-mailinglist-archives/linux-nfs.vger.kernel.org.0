Return-Path: <linux-nfs+bounces-8484-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E3A9EA10C
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 22:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A107165853
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 21:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B0F1A2C21;
	Mon,  9 Dec 2024 21:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3on9JWu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC03A1A2872;
	Mon,  9 Dec 2024 21:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733778865; cv=none; b=LN2mCmroYmhAsLwjlQgr6E5pLG1ebCCKiPxgUM48BkgEuVwtzECCqproeR4xMtbp1ULM3q1m18feyKfzfp2uwzsc9pTOpwTyWcg5Mm1B1+7T9xZJZ0dGpmmZ8IbYMRNVaLizV6QADBbhFk9iKohnwrmd5ywakxh1PJKQSTkR4e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733778865; c=relaxed/simple;
	bh=jEIHZHGB3LcQ5OA6n0zIqwT6xIC1e/cBXnH0LpUlWAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eBcC2vmbHU3waeNGBGJyFk+Pa9c08QtB4VcE/xkuIOCNockFeDgq43IYyHr9ZlGV9vS18yRLn4teQZR7hVBdJCwVkqePHfrgUuuo9WD407LL1lkOgOSodh2jm/TFwz8bdexTvrykMIL+ng6dwhVHDkBNZpa90+XUJxkjpPJk6Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3on9JWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C27C4CEE2;
	Mon,  9 Dec 2024 21:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733778865;
	bh=jEIHZHGB3LcQ5OA6n0zIqwT6xIC1e/cBXnH0LpUlWAo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p3on9JWuv/6k2Dv5Tyfty/33mRf66NZwgIZpmcTSe0X1p5+3RA6t7BObl+h17rzs7
	 eICs92ZM56LjMBitS/jVx2EyP1OU6R/pzsFgj5tp9+Y9Kkxp3xtjUlR7EEmp6p7idu
	 S22cZzQW0C8N4M11Q/KIcD+jwoTGNqWEuNUPIAk0hTAjD37W2HLWEV5s0rvMC5Rd5N
	 VSgmnGULGHjByENHxIxKMcl/N11u8wyPdck1nHd4h/AlJ6SvCyZDSWrHGli/KO8LTr
	 4w+MxKruwZmg6hinWK6ioq9rYL28tVVPrGbLyKF7I0ehWhLrfPyBBKWYfVTQS38sps
	 eZbvKfEtqTNFA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 09 Dec 2024 16:14:00 -0500
Subject: [PATCH v5 08/10] nfsd: add support for delegated timestamps
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-delstid-v5-8-42308228f692@kernel.org>
References: <20241209-delstid-v5-0-42308228f692@kernel.org>
In-Reply-To: <20241209-delstid-v5-0-42308228f692@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jonathan Corbet <corbet@lwn.net>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14535; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=jEIHZHGB3LcQ5OA6n0zIqwT6xIC1e/cBXnH0LpUlWAo=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnV12lrukETtO4v7y15z0rkNJ6T3c9oVCfFQh1h
 SKl0RU4Q7yJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ1ddpQAKCRAADmhBGVaC
 FZ/wEACYkSd4VQSCK7FgaKN4TdmwYwKXPfPyQXrlCvU/TIy4NRJnA6PHLgXleOvWY0mozOsvaW4
 6vwZJgc6t0i28iAq+oZS2hS78ztJ13BaARH8vgvTnl1Uy6ksYzg9c1egpIY9ZQYIQ4U3YUCYmPf
 pRJkH4ePROFJlNbqZiigkJ04Is8U+1L/3eqqSDI+FsVxTU8wuFrW+GIFB/+NwqIrlp0AvdZBC4/
 cgCmCOHTV8Vl1lvZVlXTUaUT8yDKbC+lgEQ09CXktM+JUI6yHerv72a9en0wW0OuR2E7cP7MfEu
 C3FSwU7cU6hYuChobPNt2Fe9RRaacNOPdctLm/hiCoTrDObUDgTjez5GKCmiB0subwQHkpBbuaj
 5/yYNsQsH5VEzCBLhyPOo+4xKbpKSKvsVRRv2SLFD3In/LQ8I+M+E4IzcQ8sqKw1ygXbyVFh4qX
 w5QN0sL+bGTilzBZ41uouFpDoxf2u0z45UAKbuavxGztEAdapx3qXP2eWfvc/2BD9Vlx1ANi3ko
 UrA71FTGAuqJh58Y6ERKk4s+JP79R0zTiNYYltVUHK1MUixBt9wxB2z74ybuMcW5Cn4kqVqEMTS
 dwqsSqugJkcI5V2XeW15cllMlggo5wKUrryGEr2VgakQysDqu3NDC3QN1PHmblLZeAO+T5whQQe
 ZtXnaNMk5PLqm2Q==
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
---
 fs/nfsd/nfs4callback.c | 42 +++++++++++++++++++--
 fs/nfsd/nfs4state.c    | 99 +++++++++++++++++++++++++++++++++++++++++++-------
 fs/nfsd/nfs4xdr.c      | 15 +++++++-
 fs/nfsd/nfsd.h         |  2 +
 fs/nfsd/state.h        |  2 +
 fs/nfsd/xdr4cb.h       | 10 +++--
 include/linux/time64.h |  5 +++
 7 files changed, 152 insertions(+), 23 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 25acb8624b854f5d0d184efec660e1f72cad8885..0d1ebeaca14a40980d08e223cb6598e20c6ce21a 100644
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
 
@@ -636,7 +666,7 @@ static int nfs4_xdr_dec_cb_getattr(struct rpc_rqst *rqstp,
 	struct nfs4_cb_compound_hdr hdr;
 	int status;
 	u32 bitmap[3] = {0};
-	u32 attrlen;
+	u32 attrlen, maxlen;
 	struct nfs4_cb_fattr *ncf =
 		container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
 
@@ -655,7 +685,11 @@ static int nfs4_xdr_dec_cb_getattr(struct rpc_rqst *rqstp,
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
index 4c36e50b9eda119948461411ae8bc851907b2eb3..c882eeba7830b0249ccd74654f81e63b12a30f14 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5842,13 +5842,14 @@ static struct nfs4_delegation *
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
@@ -5873,7 +5874,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	 */
 	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_BOTH) {
 		nf = find_rw_file(fp);
-		dl_type = OPEN_DELEGATE_WRITE;
+		dl_type = deleg_ts ? OPEN_DELEGATE_WRITE_ATTRS_DELEG : OPEN_DELEGATE_WRITE;
 	}
 
 	/*
@@ -5882,7 +5883,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	 */
 	if (!nf && (open->op_share_access & NFS4_SHARE_ACCESS_READ)) {
 		nf = find_readable_file(fp);
-		dl_type = OPEN_DELEGATE_READ;
+		dl_type = deleg_ts ? OPEN_DELEGATE_READ_ATTRS_DELEG : OPEN_DELEGATE_READ;
 	}
 
 	if (!nf)
@@ -6040,13 +6041,14 @@ static void
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
@@ -6087,12 +6089,14 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
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
@@ -8901,6 +8905,78 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
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
@@ -8927,7 +9003,6 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 	struct file_lock_context *ctx;
 	struct nfs4_delegation *dp = NULL;
 	struct file_lease *fl;
-	struct iattr attrs;
 	struct nfs4_cb_fattr *ncf;
 	struct inode *inode = d_inode(dentry);
 
@@ -8989,11 +9064,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
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
index 7b867d0e5099608cc199c216a6140f3d45292376..0561c99b5def2eccf679bf3ea0e5b1a57d5d8374 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3399,7 +3399,8 @@ static __be32 nfsd4_encode_fattr4_xattr_support(struct xdr_stream *xdr,
 
 #define NFSD_OA_SHARE_ACCESS_WANT	(BIT(OPEN_ARGS_SHARE_ACCESS_WANT_ANY_DELEG)		| \
 					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_NO_DELEG)		| \
-					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL))
+					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL)		| \
+					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS))
 
 #define NFSD_OA_OPEN_CLAIM	(BIT(OPEN_ARGS_OPEN_CLAIM_NULL)		| \
 				 BIT(OPEN_ARGS_OPEN_CLAIM_PREVIOUS)	| \
@@ -3592,7 +3593,11 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
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
@@ -3607,8 +3612,14 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
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
index d8d7e568cf15e5cd84e00ed5548d164892ba7639..554041da8593e14987439cb1c152d1a072bd00ad 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -159,6 +159,8 @@ struct nfs4_cb_fattr {
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
2.47.1


