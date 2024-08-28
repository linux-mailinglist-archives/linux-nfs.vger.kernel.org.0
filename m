Return-Path: <linux-nfs+bounces-5835-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34175961B2C
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 02:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64ABE1C223F7
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 00:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6038622315;
	Wed, 28 Aug 2024 00:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdUXPf0g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B03A2209F
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 00:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724805900; cv=none; b=eRQHamkA2tXjYaJsJpwfLyWf/xKQEdvrMcTnsUGj+HHdnzwyLOd56qZ6op2vdj2BeIO19MQuarnOfgfrcESzEPVWYtmKzkKN8DScctQQOExTfEBppfe+vO125b9HEFSPvhRYAdQFriiaDY9+23kq1hBwYSsV+AvP0mIZUpllB8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724805900; c=relaxed/simple;
	bh=85ElrjjR5Logdy2BRXlJvXTOLHEHEN457LOkNoEcOyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8IWJ/0Ydt8mpLaGKq4ejdCAA8cSzJp2ojv+DFsrJhlJf6SZpD3BHqphEF0wVH6V55r9w+MdQX/4hHEg6QLeqvaAUfZ+9r9WH6BCJAHoRotp2DTSrpbBRSZuT5h+VVWoYATklxUm66McQklbntHEz3CSmbi0gvD+zSuIGODZjmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdUXPf0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A520C4DDED;
	Wed, 28 Aug 2024 00:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724805899;
	bh=85ElrjjR5Logdy2BRXlJvXTOLHEHEN457LOkNoEcOyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cdUXPf0gUI4UEBhjdUq2ZHOglH72pBAFxUFMT7wS/1W7TqNVU4i+WdHGeYetisxHk
	 h1jZodeaCl1b+RkA2aYu7AcKB9t701Fa+/kKEB55raYmAnDxdwCJ/IOPHBMZCk8R2Y
	 m/B+DrpsIa0GfiQcRYRiaq8Mw3Hw8i9snjD5ul1t7485DQ2JL1X1EdzFOlOsEnD/ic
	 WHprwsLL++6458FTmU1bA7AJHgNGJnNffJf98YeLl+0CI1vhibHxbBeei6jhymjeg+
	 64comczG0o6DFFG9Bmz/MsoozNN+1FKmD5aDuzYVJXuDnCz9cJ91SxjsHX1K+i0kyr
	 89rvDM7cdAzmA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Mike Snitzer <snitzer@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: [RFC PATCH 6/6] nfsd: add nfsd_file_acquire_local()
Date: Tue, 27 Aug 2024 20:44:45 -0400
Message-ID: <20240828004445.22634-7-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240828004445.22634-1-cel@kernel.org>
References: <20240828004445.22634-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neilb@suse.de>

nfsd_file_acquire_local() can be used to look up a file by filehandle
without having a struct svc_rqst.  This can be used by NFS LOCALIO to
allow the NFS client to bypass the NFS protocol to directly access a
file provided by the NFS server which is running in the same kernel.

In nfsd_file_do_acquire() care is taken to always use fh_verify() if
rqstp is not NULL (as is the case for non-LOCALIO callers).  Otherwise
the non-LOCALIO callers will not supply the correct and required
arguments to __fh_verify (e.g. gssclient isn't passed).

Also, use GC for nfsd_file returned by nfsd_file_acquire_local.  GC
offers performance improvements if/when a file is reopened before
launderette cleans it from the filecache's LRU.

Suggested-by: Jeff Layton <jlayton@kernel.org> # use filecache's GC
Signed-off-by: NeilBrown <neilb@suse.de>
Co-developed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c | 61 +++++++++++++++++++++++++++++++++++++++------
 fs/nfsd/filecache.h |  3 +++
 fs/nfsd/nfsfh.c     | 18 ++++++++++++-
 fs/nfsd/nfsfh.h     |  5 ++++
 4 files changed, 79 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 9e9d246f993c..40f19e9af0ba 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -982,12 +982,14 @@ nfsd_file_is_cached(struct inode *inode)
 }
 
 static __be32
-nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
+nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
+		     struct svc_cred *cred,
+		     struct auth_domain *client,
+		     struct svc_fh *fhp,
 		     unsigned int may_flags, struct file *file,
 		     struct nfsd_file **pnf, bool want_gc)
 {
 	unsigned char need = may_flags & NFSD_FILE_MAY_MASK;
-	struct net *net = SVC_NET(rqstp);
 	struct nfsd_file *new, *nf;
 	bool stale_retry = true;
 	bool open_retry = true;
@@ -996,8 +998,13 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	int ret;
 
 retry:
-	status = fh_verify(rqstp, fhp, S_IFREG,
-				may_flags|NFSD_MAY_OWNER_OVERRIDE);
+	if (rqstp) {
+		status = fh_verify(rqstp, fhp, S_IFREG,
+				   may_flags|NFSD_MAY_OWNER_OVERRIDE);
+	} else {
+		status = __fh_verify(NULL, net, cred, client, NULL, fhp,
+				     S_IFREG, may_flags|NFSD_MAY_OWNER_OVERRIDE);
+	}
 	if (status != nfs_ok)
 		return status;
 	inode = d_inode(fhp->fh_dentry);
@@ -1143,7 +1150,8 @@ __be32
 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		     unsigned int may_flags, struct nfsd_file **pnf)
 {
-	return nfsd_file_do_acquire(rqstp, fhp, may_flags, NULL, pnf, true);
+	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, NULL,
+				    fhp, may_flags, NULL, pnf, true);
 }
 
 /**
@@ -1167,7 +1175,45 @@ __be32
 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  unsigned int may_flags, struct nfsd_file **pnf)
 {
-	return nfsd_file_do_acquire(rqstp, fhp, may_flags, NULL, pnf, false);
+	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, NULL,
+				    fhp, may_flags, NULL, pnf, false);
+}
+
+/**
+ * nfsd_file_acquire_local - Get a struct nfsd_file with an open file for localio
+ * @net: The network namespace in which to perform a lookup
+ * @cred: the user credential with which to validate access
+ * @client: the auth_domain for LOCALIO lookup
+ * @fhp: the NFS filehandle of the file to be opened
+ * @may_flags: NFSD_MAY_ settings for the file
+ * @pnf: OUT: new or found "struct nfsd_file" object
+ *
+ * This file lookup interface provide access to a file given the
+ * filehandle and credential.  No connection-based authorisation
+ * is performed and in that way it is quite different to other
+ * file access mediated by nfsd.  It allows a kernel module such as the NFS
+ * client to reach across network and filesystem namespaces to access
+ * a file.  The security implications of this should be carefully
+ * considered before use.
+ *
+ * The nfsd_file object returned by this API is reference-counted
+ * and garbage-collected. The object is retained for a few
+ * seconds after the final nfsd_file_put() in case the caller
+ * wants to re-use it.
+ *
+ * Return values:
+ *   %nfs_ok - @pnf points to an nfsd_file with its reference
+ *   count boosted.
+ *
+ * On error, an nfsstat value in network byte order is returned.
+ */
+__be32
+nfsd_file_acquire_local(struct net *net, struct svc_cred *cred,
+			struct auth_domain *client, struct svc_fh *fhp,
+			unsigned int may_flags, struct nfsd_file **pnf)
+{
+	return nfsd_file_do_acquire(NULL, net, cred, client,
+				    fhp, may_flags, NULL, pnf, true);
 }
 
 /**
@@ -1193,7 +1239,8 @@ nfsd_file_acquire_opened(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			 unsigned int may_flags, struct file *file,
 			 struct nfsd_file **pnf)
 {
-	return nfsd_file_do_acquire(rqstp, fhp, may_flags, file, pnf, false);
+	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, NULL,
+				    fhp, may_flags, file, pnf, false);
 }
 
 /*
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index 3fbec24eea6c..26ada78b8c1e 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -66,5 +66,8 @@ __be32 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 __be32 nfsd_file_acquire_opened(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  unsigned int may_flags, struct file *file,
 		  struct nfsd_file **nfp);
+__be32 nfsd_file_acquire_local(struct net *net, struct svc_cred *cred,
+			       struct auth_domain *client, struct svc_fh *fhp,
+			       unsigned int may_flags, struct nfsd_file **pnf);
 int nfsd_file_cache_stats_show(struct seq_file *m, void *v);
 #endif /* _FS_NFSD_FILECACHE_H */
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 80c06e170e9a..41be0f15182d 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -301,7 +301,23 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 	return error;
 }
 
-static __be32
+/**
+ * __fh_verify - filehandle lookup and access checking
+ * @rqstp: RPC transaction context, or NULL
+ * @net: net namespace in which to perform the export lookup
+ * @cred: RPC user credential
+ * @client: RPC auth domain
+ * @gssclient: RPC GSS auth domain
+ * @fhp: filehandle to be verified
+ * @type: expected type of object pointed to by filehandle
+ * @access: type of access needed to object
+ *
+ * This internal API can be used by callers who do not have an RPC
+ * transaction context (ie are not running in an nfsd thread).
+ *
+ * See fh_verify() for further descriptions of @fhp, @type, and @access.
+ */
+__be32
 __fh_verify(struct svc_rqst *rqstp,
 	    struct net *net, struct svc_cred *cred,
 	    struct auth_domain *client,
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 8d46e203d139..8dd653ba4100 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -217,6 +217,11 @@ extern char * SVCFH_fmt(struct svc_fh *fhp);
  * Function prototypes
  */
 __be32	fh_verify(struct svc_rqst *, struct svc_fh *, umode_t, int);
+__be32	__fh_verify(struct svc_rqst *rqstp,
+		    struct net *net, struct svc_cred *cred,
+		    struct auth_domain *client,
+		    struct auth_domain *gssclient,
+		    struct svc_fh *fhp, umode_t type, int access);
 __be32	fh_compose(struct svc_fh *, struct svc_export *, struct dentry *, struct svc_fh *);
 __be32	fh_update(struct svc_fh *);
 void	fh_put(struct svc_fh *);
-- 
2.45.2


