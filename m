Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCE832822E
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbhCAPSd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:18:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:41062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237023AbhCAPSY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 10:18:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E912F64E12
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 15:17:43 +0000 (UTC)
Subject: [PATCH v1 24/42] NFSD: Update the NFSv2 attrstat encoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Mar 2021 10:17:43 -0500
Message-ID: <161461186314.8508.4912962700048114623.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfsproc.c |    6 ++--
 fs/nfsd/nfsxdr.c  |   90 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 fs/nfsd/xdr.h     |    2 +
 3 files changed, 86 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 59080e6793b9..2ae6409ee39e 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -640,7 +640,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 	[NFSPROC_GETATTR] = {
 		.pc_func = nfsd_proc_getattr,
 		.pc_decode = nfssvc_decode_fhandleargs,
-		.pc_encode = nfssvc_encode_attrstat,
+		.pc_encode = nfssvc_encode_attrstatres,
 		.pc_release = nfssvc_release_attrstat,
 		.pc_argsize = sizeof(struct nfsd_fhandle),
 		.pc_ressize = sizeof(struct nfsd_attrstat),
@@ -651,7 +651,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 	[NFSPROC_SETATTR] = {
 		.pc_func = nfsd_proc_setattr,
 		.pc_decode = nfssvc_decode_sattrargs,
-		.pc_encode = nfssvc_encode_attrstat,
+		.pc_encode = nfssvc_encode_attrstatres,
 		.pc_release = nfssvc_release_attrstat,
 		.pc_argsize = sizeof(struct nfsd_sattrargs),
 		.pc_ressize = sizeof(struct nfsd_attrstat),
@@ -714,7 +714,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 	[NFSPROC_WRITE] = {
 		.pc_func = nfsd_proc_write,
 		.pc_decode = nfssvc_decode_writeargs,
-		.pc_encode = nfssvc_encode_attrstat,
+		.pc_encode = nfssvc_encode_attrstatres,
 		.pc_release = nfssvc_release_attrstat,
 		.pc_argsize = sizeof(struct nfsd_writeargs),
 		.pc_ressize = sizeof(struct nfsd_attrstat),
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 10cd120044b3..65c8f8f31444 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -14,7 +14,7 @@
 /*
  * Mapping of S_IF* types to NFS file types
  */
-static u32	nfs_ftypes[] = {
+static const u32 nfs_ftypes[] = {
 	NFNON,  NFCHR,  NFCHR, NFBAD,
 	NFDIR,  NFBAD,  NFBLK, NFBAD,
 	NFREG,  NFBAD,  NFLNK, NFBAD,
@@ -70,6 +70,17 @@ encode_fh(__be32 *p, struct svc_fh *fhp)
 	return p + (NFS_FHSIZE>> 2);
 }
 
+static __be32 *
+encode_timeval(__be32 *p, const struct timespec64 *time)
+{
+	*p++ = cpu_to_be32((u32)time->tv_sec);
+	if (time->tv_nsec)
+		*p++ = cpu_to_be32(time->tv_nsec / NSEC_PER_USEC);
+	else
+		*p++ = xdr_zero;
+	return p;
+}
+
 static bool
 svcxdr_decode_filename(struct xdr_stream *xdr, char **name, unsigned int *len)
 {
@@ -233,6 +244,64 @@ encode_fattr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp,
 	return p;
 }
 
+static int
+svcxdr_encode_fattr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
+		    const struct svc_fh *fhp, const struct kstat *stat)
+{
+	struct user_namespace *userns = nfsd_user_namespace(rqstp);
+	struct dentry *dentry = fhp->fh_dentry;
+	int type = stat->mode & S_IFMT;
+	struct timespec64 time;
+	__be32 *p;
+	u32 fsid;
+
+	p = xdr_reserve_space(xdr, XDR_UNIT * 17);
+	if (!p)
+		return 0;
+
+	*p++ = cpu_to_be32(nfs_ftypes[type >> 12]);
+	*p++ = cpu_to_be32((u32)stat->mode);
+	*p++ = cpu_to_be32((u32)stat->nlink);
+	*p++ = cpu_to_be32((u32)from_kuid_munged(userns, stat->uid));
+	*p++ = cpu_to_be32((u32)from_kgid_munged(userns, stat->gid));
+
+	if (S_ISLNK(type) && stat->size > NFS_MAXPATHLEN)
+		*p++ = cpu_to_be32(NFS_MAXPATHLEN);
+	else
+		*p++ = cpu_to_be32((u32) stat->size);
+	*p++ = cpu_to_be32((u32) stat->blksize);
+	if (S_ISCHR(type) || S_ISBLK(type))
+		*p++ = cpu_to_be32(new_encode_dev(stat->rdev));
+	else
+		*p++ = cpu_to_be32(0xffffffff);
+	*p++ = cpu_to_be32((u32)stat->blocks);
+
+	switch (fsid_source(fhp)) {
+	case FSIDSOURCE_FSID:
+		fsid = (u32)fhp->fh_export->ex_fsid;
+		break;
+	case FSIDSOURCE_UUID:
+		fsid = ((u32 *)fhp->fh_export->ex_uuid)[0];
+		fsid ^= ((u32 *)fhp->fh_export->ex_uuid)[1];
+		fsid ^= ((u32 *)fhp->fh_export->ex_uuid)[2];
+		fsid ^= ((u32 *)fhp->fh_export->ex_uuid)[3];
+		break;
+	default:
+		fsid = new_encode_dev(stat->dev);
+		break;
+	}
+	*p++ = cpu_to_be32(fsid);
+
+	*p++ = cpu_to_be32((u32)stat->ino);
+	p = encode_timeval(p, &stat->atime);
+	time = stat->mtime;
+	lease_get_mtime(d_inode(dentry), &time);
+	p = encode_timeval(p, &time);
+	encode_timeval(p, &stat->ctime);
+
+	return 1;
+}
+
 /* Helper function for NFSv2 ACL code */
 __be32 *nfs2svc_encode_fattr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp, struct kstat *stat)
 {
@@ -412,16 +481,21 @@ nfssvc_encode_statres(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nfssvc_encode_attrstat(struct svc_rqst *rqstp, __be32 *p)
+nfssvc_encode_attrstatres(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd_attrstat *resp = rqstp->rq_resp;
 
-	*p++ = resp->status;
-	if (resp->status != nfs_ok)
-		goto out;
-	p = encode_fattr(rqstp, p, &resp->fh, &resp->stat);
-out:
-	return xdr_ressize_check(rqstp, p);
+	if (!svcxdr_encode_stat(xdr, resp->status))
+		return 0;
+	switch (resp->status) {
+	case nfs_ok:
+		if (!svcxdr_encode_fattr(rqstp, xdr, &resp->fh, &resp->stat))
+			return 0;
+		break;
+	}
+
+	return 1;
 }
 
 int
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index a74ffcf8b9c6..a9b4ee6d098b 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -148,7 +148,7 @@ int nfssvc_decode_linkargs(struct svc_rqst *, __be32 *);
 int nfssvc_decode_symlinkargs(struct svc_rqst *, __be32 *);
 int nfssvc_decode_readdirargs(struct svc_rqst *, __be32 *);
 int nfssvc_encode_statres(struct svc_rqst *, __be32 *);
-int nfssvc_encode_attrstat(struct svc_rqst *, __be32 *);
+int nfssvc_encode_attrstatres(struct svc_rqst *, __be32 *);
 int nfssvc_encode_diropres(struct svc_rqst *, __be32 *);
 int nfssvc_encode_readlinkres(struct svc_rqst *, __be32 *);
 int nfssvc_encode_readres(struct svc_rqst *, __be32 *);


