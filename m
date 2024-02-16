Return-Path: <linux-nfs+bounces-1987-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9025F85736E
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Feb 2024 02:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4DB2B2198A
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Feb 2024 01:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE322DF53;
	Fri, 16 Feb 2024 01:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6wltFO2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892C7DF4E
	for <linux-nfs@vger.kernel.org>; Fri, 16 Feb 2024 01:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708047060; cv=none; b=oF7Vte3XeH4/1i4ae2ENrs7WzZgtoagU+XDIHChGjzuyTfeKOK1WrXMN62/HdabQ14eHmv2ABlAik9XuKnp3S9H6tToOlOIziB72Uk4Pfb6YgAB7agsF8KQKkMPulufqYQAmX/qWAjxy7ghFdXE8vdn/xpqBVocZW3N8vxiQOHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708047060; c=relaxed/simple;
	bh=mFbN28mjrpntuJaozlKmoi2f6UZ602k9YxV6mm1ASw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2+pvAB/HKci55RFZE2qvn++CA+WqB/ophTZweWbLRprcL67Nyujyg+H1MKPAfuV0htM8nRfaHX8HSg9mv9s1crJCjuZB3paxjQObpa64ZlaHaRri7ws6rIyk5YjYMr/UKmPHocC1krooZn4Xcuz8wTK0ve7F4x+aGwUrxdPBw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6wltFO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4C0C43390;
	Fri, 16 Feb 2024 01:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708047059;
	bh=mFbN28mjrpntuJaozlKmoi2f6UZ602k9YxV6mm1ASw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t6wltFO2oCP+x72XSFYC3PmwYTeqjEuL9L6zA4AX0Waqwm7ojWL3twIbffSGBddzO
	 cOVKucnwFHS0QZ0/G/5AXaiTNAZpzo3dEcDeKXmfRVtmOnkorxA6dsumugR82ek8cD
	 bmiNsuWoxiE/iwoUtTqgLAE9qtn/LCRlyb1SFyjawIyZnrSIP4z34/M5gEMv5sZjqd
	 6VwIvQlU+BWx0aMOkY3EUm9ghy+6A4WkoWcl/m59MOwlrpyBoPWoCmzsfAH0mxtrXT
	 piZXQWNkH9x8hsfv/M+bT3qNJcRBVyWBghI5F0cHDLwojO3B+r75M+osHp60iVzru6
	 TvHQ96sQaqL8w==
From: trondmy@kernel.org
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/2] nfsd: Fix NFSv3 atomicity bugs in nfsd_setattr()
Date: Thu, 15 Feb 2024 20:24:51 -0500
Message-ID: <20240216012451.22725-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240216012451.22725-2-trondmy@kernel.org>
References: <20240216012451.22725-1-trondmy@kernel.org>
 <20240216012451.22725-2-trondmy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The main point of the guarded SETATTR is to prevent races with other
WRITE and SETATTR calls. That requires that the check of the guard time
against the inode ctime be done after taking the inode lock.

Furthermore, we need to take into account the 32-bit nature of
timestamps in NFSv3, and the possibility that files may change at a
faster rate than once a second.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfs3proc.c  |  6 ++++--
 fs/nfsd/nfs3xdr.c   |  5 +----
 fs/nfsd/nfs4proc.c  |  3 +--
 fs/nfsd/nfs4state.c |  2 +-
 fs/nfsd/nfsproc.c   |  6 +++---
 fs/nfsd/vfs.c       | 20 +++++++++++++-------
 fs/nfsd/vfs.h       |  2 +-
 fs/nfsd/xdr3.h      |  2 +-
 8 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index b78eceebd945..dfcc957e460d 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -71,13 +71,15 @@ nfsd3_proc_setattr(struct svc_rqst *rqstp)
 	struct nfsd_attrs attrs = {
 		.na_iattr	= &argp->attrs,
 	};
+	const struct timespec64 *guardtime = NULL;
 
 	dprintk("nfsd: SETATTR(3)  %s\n",
 				SVCFH_fmt(&argp->fh));
 
 	fh_copy(&resp->fh, &argp->fh);
-	resp->status = nfsd_setattr(rqstp, &resp->fh, &attrs,
-				    argp->check_guard, argp->guardtime);
+	if (argp->check_guard)
+		guardtime = &argp->guardtime;
+	resp->status = nfsd_setattr(rqstp, &resp->fh, &attrs, guardtime);
 	return rpc_success;
 }
 
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index f32128955ec8..a7a07470c1f8 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -295,17 +295,14 @@ svcxdr_decode_sattr3(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 static bool
 svcxdr_decode_sattrguard3(struct xdr_stream *xdr, struct nfsd3_sattrargs *args)
 {
-	__be32 *p;
 	u32 check;
 
 	if (xdr_stream_decode_bool(xdr, &check) < 0)
 		return false;
 	if (check) {
-		p = xdr_inline_decode(xdr, XDR_UNIT * 2);
-		if (!p)
+		if (!svcxdr_decode_nfstime3(xdr, &args->guardtime))
 			return false;
 		args->check_guard = 1;
-		args->guardtime = be32_to_cpup(p);
 	} else
 		args->check_guard = 0;
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index e6d8624efc83..ae48690f4c7c 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1171,8 +1171,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto out;
 	save_no_wcc = cstate->current_fh.fh_no_wcc;
 	cstate->current_fh.fh_no_wcc = true;
-	status = nfsd_setattr(rqstp, &cstate->current_fh, &attrs,
-				0, (time64_t)0);
+	status = nfsd_setattr(rqstp, &cstate->current_fh, &attrs, NULL);
 	cstate->current_fh.fh_no_wcc = save_no_wcc;
 	if (!status)
 		status = nfserrno(attrs.na_labelerr);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2fa54cfd4882..538edd85b51e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5191,7 +5191,7 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
 		return 0;
 	if (!(open->op_share_access & NFS4_SHARE_ACCESS_WRITE))
 		return nfserr_inval;
-	return nfsd_setattr(rqstp, fh, &attrs, 0, (time64_t)0);
+	return nfsd_setattr(rqstp, fh, &attrs, NULL);
 }
 
 static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index a7315928a760..36370b957b63 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -103,7 +103,7 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
 		}
 	}
 
-	resp->status = nfsd_setattr(rqstp, fhp, &attrs, 0, (time64_t)0);
+	resp->status = nfsd_setattr(rqstp, fhp, &attrs, NULL);
 	if (resp->status != nfs_ok)
 		goto out;
 
@@ -390,8 +390,8 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		 */
 		attr->ia_valid &= ATTR_SIZE;
 		if (attr->ia_valid)
-			resp->status = nfsd_setattr(rqstp, newfhp, &attrs, 0,
-						    (time64_t)0);
+			resp->status = nfsd_setattr(rqstp, newfhp, &attrs,
+						    NULL);
 	}
 
 out_unlock:
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 58fab461bc00..3602e35e83d2 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -476,7 +476,6 @@ static int __nfsd_setattr(struct dentry *dentry, struct iattr *iap)
  * @rqstp: controlling RPC transaction
  * @fhp: filehandle of target
  * @attr: attributes to set
- * @check_guard: set to 1 if guardtime is a valid timestamp
  * @guardtime: do not act if ctime.tv_sec does not match this timestamp
  *
  * This call may adjust the contents of @attr (in particular, this
@@ -488,8 +487,7 @@ static int __nfsd_setattr(struct dentry *dentry, struct iattr *iap)
  */
 __be32
 nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
-	     struct nfsd_attrs *attr,
-	     int check_guard, time64_t guardtime)
+	     struct nfsd_attrs *attr, const struct timespec64 *guardtime)
 {
 	struct dentry	*dentry;
 	struct inode	*inode;
@@ -538,9 +536,6 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	nfsd_sanitize_attrs(inode, iap);
 
-	if (check_guard && guardtime != inode_get_ctime_sec(inode))
-		return nfserr_notsync;
-
 	/*
 	 * The size case is special, it changes the file in addition to the
 	 * attributes, and file systems don't expect it to be mixed with
@@ -558,6 +553,16 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	err = fh_fill_pre_attrs(fhp);
 	if (err)
 		goto out_unlock;
+
+	if (guardtime) {
+		struct timespec64 ctime = inode_get_ctime(inode);
+		if ((u32)guardtime->tv_sec != (u32)ctime.tv_sec ||
+		    guardtime->tv_nsec != ctime.tv_nsec) {
+			err = nfserr_notsync;
+			goto out_fill_attrs;
+		}
+	}
+
 	for (retries = 1;;) {
 		struct iattr attrs;
 
@@ -585,6 +590,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		attr->na_aclerr = set_posix_acl(&nop_mnt_idmap,
 						dentry, ACL_TYPE_DEFAULT,
 						attr->na_dpacl);
+out_fill_attrs:
 	fh_fill_post_attrs(fhp);
 out_unlock:
 	inode_unlock(inode);
@@ -1409,7 +1415,7 @@ nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	 * if the attributes have not changed.
 	 */
 	if (iap->ia_valid)
-		status = nfsd_setattr(rqstp, resfhp, attrs, 0, (time64_t)0);
+		status = nfsd_setattr(rqstp, resfhp, attrs, NULL);
 	else
 		status = nfserrno(commit_metadata(resfhp));
 
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 702fbc4483bf..7d77303ef5f7 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -69,7 +69,7 @@ __be32		 nfsd_lookup_dentry(struct svc_rqst *, struct svc_fh *,
 				const char *, unsigned int,
 				struct svc_export **, struct dentry **);
 __be32		nfsd_setattr(struct svc_rqst *, struct svc_fh *,
-				struct nfsd_attrs *, int, time64_t);
+			     struct nfsd_attrs *, const struct timespec64 *);
 int nfsd_mountpoint(struct dentry *, struct svc_export *);
 #ifdef CONFIG_NFSD_V4
 __be32		nfsd4_vfs_fallocate(struct svc_rqst *, struct svc_fh *,
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 03fe4e21306c..522067b7fd75 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -14,7 +14,7 @@ struct nfsd3_sattrargs {
 	struct svc_fh		fh;
 	struct iattr		attrs;
 	int			check_guard;
-	time64_t		guardtime;
+	struct timespec64	guardtime;
 };
 
 struct nfsd3_diropargs {
-- 
2.43.1


