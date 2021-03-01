Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67CE32824D
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbhCAPT5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:19:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:41660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237088AbhCAPTy (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 10:19:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DD4164DF5
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 15:19:14 +0000 (UTC)
Subject: [PATCH v1 39/42] NFSD: Clean up after updating NFSv2 ACL encoders
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Mar 2021 10:19:13 -0500
Message-ID: <161461195350.8508.17078965724068535834.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfsxdr.c |   64 ------------------------------------------------------
 fs/nfsd/xdr.h    |    1 -
 2 files changed, 65 deletions(-)

diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 1fed3a8deb18..b800cfefcab7 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -201,64 +201,6 @@ svcxdr_decode_sattr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	return true;
 }
 
-static __be32 *
-encode_fattr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp,
-	     struct kstat *stat)
-{
-	struct user_namespace *userns = nfsd_user_namespace(rqstp);
-	struct dentry	*dentry = fhp->fh_dentry;
-	int type;
-	struct timespec64 time;
-	u32 f;
-
-	type = (stat->mode & S_IFMT);
-
-	*p++ = htonl(nfs_ftypes[type >> 12]);
-	*p++ = htonl((u32) stat->mode);
-	*p++ = htonl((u32) stat->nlink);
-	*p++ = htonl((u32) from_kuid_munged(userns, stat->uid));
-	*p++ = htonl((u32) from_kgid_munged(userns, stat->gid));
-
-	if (S_ISLNK(type) && stat->size > NFS_MAXPATHLEN) {
-		*p++ = htonl(NFS_MAXPATHLEN);
-	} else {
-		*p++ = htonl((u32) stat->size);
-	}
-	*p++ = htonl((u32) stat->blksize);
-	if (S_ISCHR(type) || S_ISBLK(type))
-		*p++ = htonl(new_encode_dev(stat->rdev));
-	else
-		*p++ = htonl(0xffffffff);
-	*p++ = htonl((u32) stat->blocks);
-	switch (fsid_source(fhp)) {
-	default:
-	case FSIDSOURCE_DEV:
-		*p++ = htonl(new_encode_dev(stat->dev));
-		break;
-	case FSIDSOURCE_FSID:
-		*p++ = htonl((u32) fhp->fh_export->ex_fsid);
-		break;
-	case FSIDSOURCE_UUID:
-		f = ((u32*)fhp->fh_export->ex_uuid)[0];
-		f ^= ((u32*)fhp->fh_export->ex_uuid)[1];
-		f ^= ((u32*)fhp->fh_export->ex_uuid)[2];
-		f ^= ((u32*)fhp->fh_export->ex_uuid)[3];
-		*p++ = htonl(f);
-		break;
-	}
-	*p++ = htonl((u32) stat->ino);
-	*p++ = htonl((u32) stat->atime.tv_sec);
-	*p++ = htonl(stat->atime.tv_nsec ? stat->atime.tv_nsec / 1000 : 0);
-	time = stat->mtime;
-	lease_get_mtime(d_inode(dentry), &time); 
-	*p++ = htonl((u32) time.tv_sec);
-	*p++ = htonl(time.tv_nsec ? time.tv_nsec / 1000 : 0); 
-	*p++ = htonl((u32) stat->ctime.tv_sec);
-	*p++ = htonl(stat->ctime.tv_nsec ? stat->ctime.tv_nsec / 1000 : 0);
-
-	return p;
-}
-
 /**
  * svcxdr_encode_fattr - Encode NFSv2 file attributes
  * @rqstp: Context of a completed RPC transaction
@@ -328,12 +270,6 @@ svcxdr_encode_fattr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	return true;
 }
 
-/* Helper function for NFSv2 ACL code */
-__be32 *nfs2svc_encode_fattr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp, struct kstat *stat)
-{
-	return encode_fattr(rqstp, p, fhp, stat);
-}
-
 /*
  * XDR decode functions
  */
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index ad7f7eabf41a..f45b4bc93f52 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -168,7 +168,6 @@ void nfssvc_release_diropres(struct svc_rqst *rqstp);
 void nfssvc_release_readres(struct svc_rqst *rqstp);
 
 /* Helper functions for NFSv2 ACL code */
-__be32 *nfs2svc_encode_fattr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp, struct kstat *stat);
 bool svcxdr_decode_fhandle(struct xdr_stream *xdr, struct svc_fh *fhp);
 bool svcxdr_encode_stat(struct xdr_stream *xdr, __be32 status);
 bool svcxdr_encode_fattr(struct svc_rqst *rqstp, struct xdr_stream *xdr,


