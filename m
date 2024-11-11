Return-Path: <linux-nfs+bounces-7861-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C30BD9C424C
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 17:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11AEAB2543C
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 16:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E33C1A2557;
	Mon, 11 Nov 2024 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDdr8Inh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEFB4C66;
	Mon, 11 Nov 2024 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731340878; cv=none; b=fu76EWBdAdz4zX0ciskWDdFjTeRoJGT0i0cNO2SLd0+vyw6WefUxgNK1rIk323znAlKt87hl6QyBlYXBefFnvElZPv4PSRVBX2zp9+G/UO2JrfYCtCjEDb/qB7zv9tVGhdSbA59Ra47j+ycrcNuNgUREPcUJGkWl9kZ38aCIc7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731340878; c=relaxed/simple;
	bh=FdjD6SQVms2k4ytfPfE+ONeBDEAaFyrTBrkjJU3b/kE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=M+HtlNva6nNDtzfCTvf3mK5+2vmI+JNaqiMMX9qs25bvAkZtfk+GLeaUHkMgDlv6by3Z1+UrczW0ONz57vxjcrrIZrcPjz4auS1DB/lKws8Y39Ln2L4PMnwuyF0QKa3cuAkHiTYCTtrKTHvsgPbPgdMTVZHYNN/xFr9A94BPpDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDdr8Inh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDD8C4CECF;
	Mon, 11 Nov 2024 16:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731340877;
	bh=FdjD6SQVms2k4ytfPfE+ONeBDEAaFyrTBrkjJU3b/kE=;
	h=From:Date:Subject:To:Cc:From;
	b=uDdr8Inh2AFEMajRA7+mgMWudV8I6P8yvMMzNGAuZmfjbQcXI3BtBQ5qtYmjyMzQc
	 8t9aX0D7Yg++FrM6wP2MjmiqFDceRN87HOxZ3S/HUSxymeef68BvCKjieDr5dn2to/
	 onVpRzjDRWz8eqmzOzGwBrUUEhZFfy3ggNXXRKCeMQ31cY4qkJA0BBI9TKhiDFn8Qz
	 gIg5V3G0y+ds+HyxK7uqotUCpouZUv/TeCdR1FuozJB3kPYA6uaTqg3yZdTX93LoYf
	 5qGzKc9iqOmZqdZCvOT1/TuvhlINI7Aq96qyzEZPUEffSpuVssOOp1zSqBZWkw68WN
	 2OJhOIPRAvtKA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 11 Nov 2024 11:01:13 -0500
Subject: [PATCH v2] nfsd: drop inode parameter from
 nfsd4_change_attribute()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-master-v2-1-e0a52a156a03@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEgqMmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIxNDINDNTSwuSS3STU6yTExLTEwySU40UAIqLihKTcusABsUHVtbCwC54SL
 ZWAAAAA==
X-Change-ID: 20241111-master-cb9afaab4ca0
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5955; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=FdjD6SQVms2k4ytfPfE+ONeBDEAaFyrTBrkjJU3b/kE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnMipMe6eqzdouhLcI/E4YVjaXqGF0luZ6TzzkC
 ZmRBjNRgnqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZzIqTAAKCRAADmhBGVaC
 FTaSD/4r91kzcwtXpblBv1yFivtWWhd3AqrUEPCKW1bzNXxRXEPhMmaFsNEWkOhNJxcL1RCH6CB
 DFYxm5yhGZGIlXhYyfo9HdjpVjSAvFxX5LbgH/gbwW/ko7TXKC/k96quGskbRKhH/eOLJPzSoZm
 MlWpX4AZ0oSAmMPOzafUb2AAUXgGuGKEffvMWvZZzb5x+6bWH1L0OLr0TFqwoh9s2KkRt2Z4CJo
 RnZXq6pDrt55LG+dgfEo9v5z3pWsbqnbESjhOzrZrxZTjWWLR6B5s06rDSUjSTNnsD3Jz2NTNfN
 SDjLwWX9y8TqpkJ57iNIYfRpsGjYZzd+cCFZNMrQM9mrCxszWYokanjHtI6EX0qw9NqWfPehmEO
 lbFerONIqGps95RTowpGTRLANglfU4CYozdhWp4N6VH7CrIGZ1dM6SYiIVo2sWuvIc84JsMT7TE
 xNFxYMvek1xLRe2LuBQozgCjM57lD4QKjyVg4qNugggci6BIO5B2108lI7em2d57dzAyfv8B749
 jyGAQDkYNBFVsHdZe5C6vi2O49Ob1jzZZC7BkIEyx1XAX29DfI9SrMUSRbNWY+OaEM9MADjWQSs
 mUGx6Ucoryi2QUrwffRiULpVJn9EnA1OW4GePAyL+zRnkY78pdKqh62nccsFJ5e0lxPO9uxAv41
 vZaUyCyLco4gLaA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The inode that nfs4_open_delegation() passes to this function is
wrong, which throws off the result. The inode will end up getting a
directory-style change attr instead of a regular-file-style one.

Fix up nfs4_delegation_stat() to fetch STATX_MODE, and then drop the
inode parameter from nfsd4_change_attribute(), since it's no longer
needed.

Fixes: c5967721e106 ("NFSD: handle GETATTR conflict with write delegation")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
This version should apply cleanly to v6.12-rc7. Some later patches in
nfsd-next might need to be twiddled as a result, but it should be simple
to fix. Also, I fixed up the Fixes: to point to the right commit. This
dates back a bit further than I had originally thought.
---
 fs/nfsd/nfs4state.c |  5 ++---
 fs/nfsd/nfs4xdr.c   |  2 +-
 fs/nfsd/nfsfh.c     | 20 ++++++++++++--------
 fs/nfsd/nfsfh.h     |  3 +--
 4 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 551d2958ec2905be51b4a96414a15a5e4f87f9ea..d3cfc6471539932fadc01a95a1fe0948f2935666 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5957,7 +5957,7 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
 	path.dentry = file_dentry(nf->nf_file);
 
 	rc = vfs_getattr(&path, stat,
-			 (STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
+			 (STATX_MODE | STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
 			 AT_STATX_SYNC_AS_STAT);
 
 	nfsd_file_put(nf);
@@ -6041,8 +6041,7 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 		}
 		open->op_delegate_type = NFS4_OPEN_DELEGATE_WRITE;
 		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
-		dp->dl_cb_fattr.ncf_initial_cinfo =
-			nfsd4_change_attribute(&stat, d_inode(currentfh->fh_dentry));
+		dp->dl_cb_fattr.ncf_initial_cinfo = nfsd4_change_attribute(&stat);
 		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
 	} else {
 		open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index f118921250c3163ea45b77a53dc57ef364eec32b..8d25aef51ad150625540e1b8baba8baf9d64b788 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3040,7 +3040,7 @@ static __be32 nfsd4_encode_fattr4_change(struct xdr_stream *xdr,
 		return nfs_ok;
 	}
 
-	c = nfsd4_change_attribute(&args->stat, d_inode(args->dentry));
+	c = nfsd4_change_attribute(&args->stat);
 	return nfsd4_encode_changeid4(xdr, c);
 }
 
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 40ad58a6a0361e48a48262a2c61abbcfd908a3bb..96e19c50a5d7ee8cd610bec4ecaec617286deea3 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -667,20 +667,18 @@ fh_update(struct svc_fh *fhp)
 __be32 __must_check fh_fill_pre_attrs(struct svc_fh *fhp)
 {
 	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
-	struct inode *inode;
 	struct kstat stat;
 	__be32 err;
 
 	if (fhp->fh_no_wcc || fhp->fh_pre_saved)
 		return nfs_ok;
 
-	inode = d_inode(fhp->fh_dentry);
 	err = fh_getattr(fhp, &stat);
 	if (err)
 		return err;
 
 	if (v4)
-		fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode);
+		fhp->fh_pre_change = nfsd4_change_attribute(&stat);
 
 	fhp->fh_pre_mtime = stat.mtime;
 	fhp->fh_pre_ctime = stat.ctime;
@@ -697,7 +695,6 @@ __be32 __must_check fh_fill_pre_attrs(struct svc_fh *fhp)
 __be32 fh_fill_post_attrs(struct svc_fh *fhp)
 {
 	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
-	struct inode *inode = d_inode(fhp->fh_dentry);
 	__be32 err;
 
 	if (fhp->fh_no_wcc)
@@ -713,7 +710,7 @@ __be32 fh_fill_post_attrs(struct svc_fh *fhp)
 	fhp->fh_post_saved = true;
 	if (v4)
 		fhp->fh_post_change =
-			nfsd4_change_attribute(&fhp->fh_post_attr, inode);
+			nfsd4_change_attribute(&fhp->fh_post_attr);
 	return nfs_ok;
 }
 
@@ -804,7 +801,14 @@ enum fsid_source fsid_source(const struct svc_fh *fhp)
 	return FSIDSOURCE_DEV;
 }
 
-/*
+/**
+ * nfsd4_change_attribute - Generate an NFSv4 change_attribute value
+ * @stat: inode attributes
+ *
+ * Caller must fill in @stat before calling, typically by invoking
+ * vfs_getattr() with STATX_MODE, STATX_CTIME, and STATX_CHANGE_COOKIE.
+ * Returns an unsigned 64-bit changeid4 value (RFC 8881 Section 3.2).
+ *
  * We could use i_version alone as the change attribute.  However, i_version
  * can go backwards on a regular file after an unclean shutdown.  On its own
  * that doesn't necessarily cause a problem, but if i_version goes backwards
@@ -821,13 +825,13 @@ enum fsid_source fsid_source(const struct svc_fh *fhp)
  * assume that the new change attr is always logged to stable storage in some
  * fashion before the results can be seen.
  */
-u64 nfsd4_change_attribute(const struct kstat *stat, const struct inode *inode)
+u64 nfsd4_change_attribute(const struct kstat *stat)
 {
 	u64 chattr;
 
 	if (stat->result_mask & STATX_CHANGE_COOKIE) {
 		chattr = stat->change_cookie;
-		if (S_ISREG(inode->i_mode) &&
+		if (S_ISREG(stat->mode) &&
 		    !(stat->attributes & STATX_ATTR_CHANGE_MONOTONIC)) {
 			chattr += (u64)stat->ctime.tv_sec << 30;
 			chattr += stat->ctime.tv_nsec;
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 5b7394801dc4270dbd5236f3e2f2237130c73dad..876152a91f122f83fb94ffdfb0eedf8fca56a20c 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -297,8 +297,7 @@ static inline void fh_clear_pre_post_attrs(struct svc_fh *fhp)
 	fhp->fh_pre_saved = false;
 }
 
-u64 nfsd4_change_attribute(const struct kstat *stat,
-			   const struct inode *inode);
+u64 nfsd4_change_attribute(const struct kstat *stat);
 __be32 __must_check fh_fill_pre_attrs(struct svc_fh *fhp);
 __be32 fh_fill_post_attrs(struct svc_fh *fhp);
 __be32 __must_check fh_fill_both_attrs(struct svc_fh *fhp);

---
base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
change-id: 20241111-master-cb9afaab4ca0

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


