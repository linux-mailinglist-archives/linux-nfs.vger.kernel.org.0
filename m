Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10AE328251
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbhCAPUk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:20:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:41866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237103AbhCAPUN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 10:20:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 30D2564E38
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 15:19:32 +0000 (UTC)
Subject: [PATCH v1 42/42] NFSD: Clean up after updating NFSv3 ACL encoders
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Mar 2021 10:19:31 -0500
Message-ID: <161461197148.8508.13731520013684008432.stgit@klimt.1015granger.net>
In-Reply-To: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
References: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3xdr.c |   86 -----------------------------------------------------
 fs/nfsd/xdr3.h    |    2 -
 2 files changed, 88 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index b8f894e00b6d..6989a3c8452e 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -48,13 +48,6 @@ static const u32 nfs3_ftypes[] = {
  * Basic NFSv3 data types (RFC 1813 Sections 2.5 and 2.6)
  */
 
-static __be32 *
-encode_time3(__be32 *p, struct timespec64 *time)
-{
-	*p++ = htonl((u32) time->tv_sec); *p++ = htonl(time->tv_nsec);
-	return p;
-}
-
 static __be32 *
 encode_nfstime3(__be32 *p, const struct timespec64 *time)
 {
@@ -396,54 +389,6 @@ svcxdr_encode_fattr3(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	return true;
 }
 
-static __be32 *encode_fsid(__be32 *p, struct svc_fh *fhp)
-{
-	u64 f;
-	switch(fsid_source(fhp)) {
-	default:
-	case FSIDSOURCE_DEV:
-		p = xdr_encode_hyper(p, (u64)huge_encode_dev
-				     (fhp->fh_dentry->d_sb->s_dev));
-		break;
-	case FSIDSOURCE_FSID:
-		p = xdr_encode_hyper(p, (u64) fhp->fh_export->ex_fsid);
-		break;
-	case FSIDSOURCE_UUID:
-		f = ((u64*)fhp->fh_export->ex_uuid)[0];
-		f ^= ((u64*)fhp->fh_export->ex_uuid)[1];
-		p = xdr_encode_hyper(p, f);
-		break;
-	}
-	return p;
-}
-
-static __be32 *
-encode_fattr3(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp,
-	      struct kstat *stat)
-{
-	struct user_namespace *userns = nfsd_user_namespace(rqstp);
-	*p++ = htonl(nfs3_ftypes[(stat->mode & S_IFMT) >> 12]);
-	*p++ = htonl((u32) (stat->mode & S_IALLUGO));
-	*p++ = htonl((u32) stat->nlink);
-	*p++ = htonl((u32) from_kuid_munged(userns, stat->uid));
-	*p++ = htonl((u32) from_kgid_munged(userns, stat->gid));
-	if (S_ISLNK(stat->mode) && stat->size > NFS3_MAXPATHLEN) {
-		p = xdr_encode_hyper(p, (u64) NFS3_MAXPATHLEN);
-	} else {
-		p = xdr_encode_hyper(p, (u64) stat->size);
-	}
-	p = xdr_encode_hyper(p, ((u64)stat->blocks) << 9);
-	*p++ = htonl((u32) MAJOR(stat->rdev));
-	*p++ = htonl((u32) MINOR(stat->rdev));
-	p = encode_fsid(p, fhp);
-	p = xdr_encode_hyper(p, stat->ino);
-	p = encode_time3(p, &stat->atime);
-	p = encode_time3(p, &stat->mtime);
-	p = encode_time3(p, &stat->ctime);
-
-	return p;
-}
-
 static bool
 svcxdr_encode_wcc_attr(struct xdr_stream *xdr, const struct svc_fh *fhp)
 {
@@ -512,37 +457,6 @@ svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	return xdr_stream_encode_item_absent(xdr) > 0;
 }
 
-/*
- * Encode post-operation attributes.
- * The inode may be NULL if the call failed because of a stale file
- * handle. In this case, no attributes are returned.
- */
-static __be32 *
-encode_post_op_attr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp)
-{
-	struct dentry *dentry = fhp->fh_dentry;
-	if (!fhp->fh_no_wcc && dentry && d_really_is_positive(dentry)) {
-	        __be32 err;
-		struct kstat stat;
-
-		err = fh_getattr(fhp, &stat);
-		if (!err) {
-			*p++ = xdr_one;		/* attributes follow */
-			lease_get_mtime(d_inode(dentry), &stat.mtime);
-			return encode_fattr3(rqstp, p, fhp, &stat);
-		}
-	}
-	*p++ = xdr_zero;
-	return p;
-}
-
-/* Helper for NFSv3 ACLs */
-__be32 *
-nfs3svc_encode_post_op_attr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp)
-{
-	return encode_post_op_attr(rqstp, p, fhp);
-}
-
 /*
  * Encode weak cache consistency data
  */
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 746c5f79964f..933008382bbe 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -305,8 +305,6 @@ int nfs3svc_encode_entry3(void *data, const char *name, int namlen,
 int nfs3svc_encode_entryplus3(void *data, const char *name, int namlen,
 			      loff_t offset, u64 ino, unsigned int d_type);
 /* Helper functions for NFSv3 ACL code */
-__be32 *nfs3svc_encode_post_op_attr(struct svc_rqst *rqstp, __be32 *p,
-				struct svc_fh *fhp);
 bool svcxdr_decode_nfs_fh3(struct xdr_stream *xdr, struct svc_fh *fhp);
 bool svcxdr_encode_nfsstat3(struct xdr_stream *xdr, __be32 status);
 bool svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, struct xdr_stream *xdr,


