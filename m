Return-Path: <linux-nfs+bounces-17690-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DC501D0AACB
	for <lists+linux-nfs@lfdr.de>; Fri, 09 Jan 2026 15:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 599583018356
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jan 2026 14:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4E93612E0;
	Fri,  9 Jan 2026 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sps53KBr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B213612C9;
	Fri,  9 Jan 2026 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969590; cv=none; b=iALU17bdD+wlDLGTGyEHPzI5n2ypOK1B+jMekDgrfpPSvpD08iOaW0w4pLLPZK09eoxd16KvYFmcaEPYuyCODjXzaiplnKH6qgO424WSUsrY5dNvJ3HT6rlWhRHmwb4jJy2u2VPfvIIElDlQaB8KUciHK5bdpLRivwWoR/17XF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969590; c=relaxed/simple;
	bh=CM1RJh917k7L4mUGMpZUiQwvjPlDvdh3fX3hN8q/nW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zb+xtrKyRE82NrBAqtx3phfi8gg8ZIGQsAnpg99qx7ZNMI5f1e1z8LIqHwcbpUk191Ltc/JavvhJmcy5xpqChzX3wD9N5jXCgH8N2arZk/tcJspPZbCAcGco7Sp04jjwMryRXMUKNP0wMFaW9Q5DfzL/sA+0uu6vW8vtepRhziU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sps53KBr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3369C19422;
	Fri,  9 Jan 2026 14:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767969590;
	bh=CM1RJh917k7L4mUGMpZUiQwvjPlDvdh3fX3hN8q/nW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sps53KBrhXXvYuj0W7mnkxem4OJ8zH1oF/UvrUNf4PtVnYEA1Z2fSSSahEMbDRr9d
	 4WAk8jP/YUtvnczA1wLr3k8MRAeGqakqxw4yUkdcCR20M3xN7i37c55zNzxsAgaMnf
	 sWCi8//kR+zXRpKeWteXcTEkw3iZHWtp+htkPWJFFetkTjAEQAttVeBKeMcF/RjFmw
	 zu3IJ+izH8dl1avjbHq/ePGM7MiA0MdAxm2g/VhRdq8wm59aA4JUOXmO4GXlS5myHT
	 NitIqCZ4oEoLp7Y2IbMZBaVXQqpK5WWmuzWxAfJ8pGYqbid0RtNF4S5OoseW6EANsb
	 9emr2V6OE/rNA==
From: Chuck Lever <cel@kernel.org>
To: <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [PATCH 6.6.y v3 2/4] nfsd: Fix NFSv3 atomicity bugs in nfsd_setattr()
Date: Fri,  9 Jan 2026 09:39:44 -0500
Message-ID: <20260109143946.4173043-3-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <2025122941-civic-revered-b250@gregkh>
References: <2025122941-civic-revered-b250@gregkh>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 24d92de9186ebc340687caf7356e1070773e67bc ]

nfsd: Fix NFSv3 atomicity bugs in nfsd_setattr()

The main point of the guarded SETATTR is to prevent races with other
WRITE and SETATTR calls. That requires that the check of the guard time
against the inode ctime be done after taking the inode lock.

Furthermore, we need to take into account the 32-bit nature of
timestamps in NFSv3, and the possibility that files may change at a
faster rate than once a second.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neilb@suse.de>
Stable-dep-of: 442d27ff09a2 ("nfsd: set security label during create operations")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
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
index 666bad8182e5..f4ccbb1f49ba 100644
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
index 37b918e4a53d..c9ae789bb045 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1160,8 +1160,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
index 57f1f6aa19c9..511fedc37008 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5223,7 +5223,7 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
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
index 1faf65147223..51c2ad3847c4 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -459,7 +459,6 @@ static int __nfsd_setattr(struct dentry *dentry, struct iattr *iap)
  * @rqstp: controlling RPC transaction
  * @fhp: filehandle of target
  * @attr: attributes to set
- * @check_guard: set to 1 if guardtime is a valid timestamp
  * @guardtime: do not act if ctime.tv_sec does not match this timestamp
  *
  * This call may adjust the contents of @attr (in particular, this
@@ -471,8 +470,7 @@ static int __nfsd_setattr(struct dentry *dentry, struct iattr *iap)
  */
 __be32
 nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
-	     struct nfsd_attrs *attr,
-	     int check_guard, time64_t guardtime)
+	     struct nfsd_attrs *attr, const struct timespec64 *guardtime)
 {
 	struct dentry	*dentry;
 	struct inode	*inode;
@@ -521,9 +519,6 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	nfsd_sanitize_attrs(inode, iap);
 
-	if (check_guard && guardtime != inode_get_ctime_sec(inode))
-		return nfserr_notsync;
-
 	/*
 	 * The size case is special, it changes the file in addition to the
 	 * attributes, and file systems don't expect it to be mixed with
@@ -541,6 +536,16 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
 
@@ -568,6 +573,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		attr->na_aclerr = set_posix_acl(&nop_mnt_idmap,
 						dentry, ACL_TYPE_DEFAULT,
 						attr->na_dpacl);
+out_fill_attrs:
 	fh_fill_post_attrs(fhp);
 out_unlock:
 	inode_unlock(inode);
@@ -1374,7 +1380,7 @@ nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	 * if the attributes have not changed.
 	 */
 	if (iap->ia_valid)
-		status = nfsd_setattr(rqstp, resfhp, attrs, 0, (time64_t)0);
+		status = nfsd_setattr(rqstp, resfhp, attrs, NULL);
 	else
 		status = nfserrno(commit_metadata(resfhp));
 
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index e3c29596f4df..b476028e020b 100644
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
2.52.0


