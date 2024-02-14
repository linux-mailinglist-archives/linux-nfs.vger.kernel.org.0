Return-Path: <linux-nfs+bounces-1930-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AD385563C
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Feb 2024 23:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CEAEB25A4D
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Feb 2024 22:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FA71864C;
	Wed, 14 Feb 2024 22:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+GHMRk1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8387718639
	for <linux-nfs@vger.kernel.org>; Wed, 14 Feb 2024 22:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707950465; cv=none; b=BRihIrIQFNz2TrLDeCTc4cM3UtnZ3SpklQ/ZP3+mLZqJZONCkidACGN7e9DbKYCKbawLSmbJRqY4U+qjJ+SnrpEEpeRFCJ+wnU5/MqKfvFxIBZF78M9DEtry2daLmKoWdTkqdae2im+oiFEfUCoAZTqkv8fXuvyBlXJPTqbsoPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707950465; c=relaxed/simple;
	bh=IetT4/8w46vJjJ+DywERYRy2ve9pBVvesOxMOrvzKpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hOVAqUR6a70xyU/xvTkPqq/h1cUdruCCTOyVh8Lxq8gR9h4JmJbopsBxrx2ptiTr1h0T31pKSHiBIsD2987b+LcwOdbavYsVFVjPV1IBcCQCRlylGjRfi4tdp7bljsbicqcTJQA7H5jA3YAaYr9L94sXzr+mjAqWliMtOGVz7tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+GHMRk1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5909C433C7;
	Wed, 14 Feb 2024 22:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707950465;
	bh=IetT4/8w46vJjJ+DywERYRy2ve9pBVvesOxMOrvzKpM=;
	h=From:To:Cc:Subject:Date:From;
	b=l+GHMRk16BtonGlx7I4LDRS/uJQGScayoLwoNNkgJz8xnFySV8HZhynlBIDkffSWt
	 aJ3Oc/6z0m5UQSGTr/FcxZ56v0ajlteV3VxT74yhiuchk7O53Wvex2NcvMLso6U5vz
	 RQEA33U2zfQqmoS2x9kCaWNs+RPk0e13xwJTGGEhxDOADljhcFBuwA+AFgJEayRitp
	 i7t2gBssCop0zPqy2x6UbHzrxb3axxPiNu2m/CywyASz1dkGBm+6uUnLryUaSSpW0K
	 G7+jJ8UFjaHFI+J5VN2i3kS47tjE2+eKWxtd+4KRI9PAfwS86HLSr5jb1mUZArF9MF
	 7ieXh/Fm2AYow==
From: trondmy@kernel.org
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: Fix NFSv3 atomicity bugs in nfsd_setattr()
Date: Wed, 14 Feb 2024 17:35:01 -0500
Message-ID: <20240214223501.205822-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.43.0
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
index 14712fa08f76..0294f5cce5dd 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1168,8 +1168,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	if (status)
 		goto out;
-	status = nfsd_setattr(rqstp, &cstate->current_fh, &attrs,
-				0, (time64_t)0);
+	status = nfsd_setattr(rqstp, &cstate->current_fh, &attrs, NULL);
 	if (!status)
 		status = nfserrno(attrs.na_labelerr);
 	if (!status)
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
index 6e7e37192461..cc17eb8633ea 100644
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
@@ -555,6 +550,17 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 	inode_lock(inode);
+	if (guardtime) {
+		struct timespec64 ctime = inode_get_ctime(inode);
+		if ((u32)guardtime->tv_sec != (u32)ctime.tv_sec ||
+		    guardtime->tv_nsec != ctime.tv_nsec) {
+			inode_unlock(inode);
+			if (size_change)
+				put_write_access(inode);
+			return nfserr_notsync;
+		}
+	}
+
 	for (retries = 1;;) {
 		struct iattr attrs;
 
@@ -1404,7 +1410,7 @@ nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
2.43.0


