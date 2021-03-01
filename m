Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50E4328211
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236921AbhCAPQu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:16:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237022AbhCAPQM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 10:16:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F89F64E01
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 15:15:31 +0000 (UTC)
Subject: [PATCH v1 02/42] NFSD: Update the GETATTR3res encoder to use struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Mar 2021 10:15:30 -0500
Message-ID: <161461173066.8508.12254702152465534604.stgit@klimt.1015granger.net>
In-Reply-To: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
References: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

As an additional clean up, some renaming is done to more closely
reflect the data type and variable names used in the NFSv3 XDR
definition provided in RFC 1813. "attrstat" is an NFSv2 thingie.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |    2 +
 fs/nfsd/nfs3xdr.c  |   95 ++++++++++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfsfh.c    |    2 +
 fs/nfsd/nfsfh.h    |    2 +
 fs/nfsd/xdr3.h     |    2 +
 5 files changed, 91 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 8675851199f8..76a84481d526 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -736,7 +736,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 	[NFS3PROC_GETATTR] = {
 		.pc_func = nfsd3_proc_getattr,
 		.pc_decode = nfs3svc_decode_fhandleargs,
-		.pc_encode = nfs3svc_encode_attrstatres,
+		.pc_encode = nfs3svc_encode_getattrres,
 		.pc_release = nfs3svc_release_fhandle,
 		.pc_argsize = sizeof(struct nfsd_fhandle),
 		.pc_ressize = sizeof(struct nfsd3_attrstatres),
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 9d9a01ce0b27..75739861d235 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -20,7 +20,7 @@
 /*
  * Mapping of S_IF* types to NFS file types
  */
-static u32	nfs3_ftypes[] = {
+static const u32 nfs3_ftypes[] = {
 	NF3NON,  NF3FIFO, NF3CHR, NF3BAD,
 	NF3DIR,  NF3BAD,  NF3BLK, NF3BAD,
 	NF3REG,  NF3BAD,  NF3LNK, NF3BAD,
@@ -39,6 +39,15 @@ encode_time3(__be32 *p, struct timespec64 *time)
 	return p;
 }
 
+static __be32 *
+encode_nfstime3(__be32 *p, const struct timespec64 *time)
+{
+	*p++ = cpu_to_be32((u32)time->tv_sec);
+	*p++ = cpu_to_be32(time->tv_nsec);
+
+	return p;
+}
+
 static bool
 svcxdr_decode_nfstime3(struct xdr_stream *xdr, struct timespec64 *timep)
 {
@@ -82,6 +91,19 @@ svcxdr_decode_nfs_fh3(struct xdr_stream *xdr, struct svc_fh *fhp)
 	return true;
 }
 
+static bool
+svcxdr_encode_nfsstat3(struct xdr_stream *xdr, __be32 status)
+{
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, sizeof(status));
+	if (!p)
+		return false;
+	*p = status;
+
+	return true;
+}
+
 static __be32 *
 encode_fh(__be32 *p, struct svc_fh *fhp)
 {
@@ -253,6 +275,58 @@ svcxdr_decode_devicedata3(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		svcxdr_decode_specdata3(xdr, args);
 }
 
+static bool
+svcxdr_encode_fattr3(struct svc_rqst *rqstp, struct xdr_stream *xdr,
+		     const struct svc_fh *fhp, const struct kstat *stat)
+{
+	struct user_namespace *userns = nfsd_user_namespace(rqstp);
+	__be32 *p;
+	u64 fsid;
+
+	p = xdr_reserve_space(xdr, XDR_UNIT * 21);
+	if (!p)
+		return false;
+
+	*p++ = cpu_to_be32(nfs3_ftypes[(stat->mode & S_IFMT) >> 12]);
+	*p++ = cpu_to_be32((u32)(stat->mode & S_IALLUGO));
+	*p++ = cpu_to_be32((u32)stat->nlink);
+	*p++ = cpu_to_be32((u32)from_kuid_munged(userns, stat->uid));
+	*p++ = cpu_to_be32((u32)from_kgid_munged(userns, stat->gid));
+	if (S_ISLNK(stat->mode) && stat->size > NFS3_MAXPATHLEN)
+		p = xdr_encode_hyper(p, (u64)NFS3_MAXPATHLEN);
+	else
+		p = xdr_encode_hyper(p, (u64)stat->size);
+
+	/* used */
+	p = xdr_encode_hyper(p, ((u64)stat->blocks) << 9);
+
+	/* rdev */
+	*p++ = cpu_to_be32((u32)MAJOR(stat->rdev));
+	*p++ = cpu_to_be32((u32)MINOR(stat->rdev));
+
+	switch(fsid_source(fhp)) {
+	case FSIDSOURCE_FSID:
+		fsid = (u64)fhp->fh_export->ex_fsid;
+		break;
+	case FSIDSOURCE_UUID:
+		fsid = ((u64 *)fhp->fh_export->ex_uuid)[0];
+		fsid ^= ((u64 *)fhp->fh_export->ex_uuid)[1];
+		break;
+	default:
+		fsid = (u64)huge_encode_dev(fhp->fh_dentry->d_sb->s_dev);
+	}
+	p = xdr_encode_hyper(p, fsid);
+
+	/* fileid */
+	p = xdr_encode_hyper(p, stat->ino);
+
+	p = encode_nfstime3(p, &stat->atime);
+	p = encode_nfstime3(p, &stat->mtime);
+	encode_nfstime3(p, &stat->ctime);
+
+	return true;
+}
+
 static __be32 *encode_fsid(__be32 *p, struct svc_fh *fhp)
 {
 	u64 f;
@@ -713,17 +787,22 @@ nfs3svc_decode_commitargs(struct svc_rqst *rqstp, __be32 *p)
 
 /* GETATTR */
 int
-nfs3svc_encode_attrstat(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_getattrres(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
 
-	*p++ = resp->status;
-	if (resp->status == 0) {
-		lease_get_mtime(d_inode(resp->fh.fh_dentry),
-				&resp->stat.mtime);
-		p = encode_fattr3(rqstp, p, &resp->fh, &resp->stat);
+	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
+		return 0;
+	switch (resp->status) {
+	case nfs_ok:
+		lease_get_mtime(d_inode(resp->fh.fh_dentry), &resp->stat.mtime);
+		if (!svcxdr_encode_fattr3(rqstp, xdr, &resp->fh, &resp->stat))
+			return 0;
+		break;
 	}
-	return xdr_ressize_check(rqstp, p);
+
+	return 1;
 }
 
 /* SETATTR, REMOVE, RMDIR */
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 10b44421eace..c475d2271f9c 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -711,7 +711,7 @@ char * SVCFH_fmt(struct svc_fh *fhp)
 	return buf;
 }
 
-enum fsid_source fsid_source(struct svc_fh *fhp)
+enum fsid_source fsid_source(const struct svc_fh *fhp)
 {
 	if (fhp->fh_handle.fh_version != 1)
 		return FSIDSOURCE_DEV;
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index f58933519f38..aff2cda5c6c3 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -82,7 +82,7 @@ enum fsid_source {
 	FSIDSOURCE_FSID,
 	FSIDSOURCE_UUID,
 };
-extern enum fsid_source fsid_source(struct svc_fh *fhp);
+extern enum fsid_source fsid_source(const struct svc_fh *fhp);
 
 
 /*
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 3e1578953f54..0822981c61b9 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -280,7 +280,7 @@ int nfs3svc_decode_symlinkargs(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_readdirargs(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_readdirplusargs(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_commitargs(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_attrstat(struct svc_rqst *, __be32 *);
+int nfs3svc_encode_getattrres(struct svc_rqst *, __be32 *);
 int nfs3svc_encode_wccstat(struct svc_rqst *, __be32 *);
 int nfs3svc_encode_diropres(struct svc_rqst *, __be32 *);
 int nfs3svc_encode_accessres(struct svc_rqst *, __be32 *);


