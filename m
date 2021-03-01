Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02531328246
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbhCAPTi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:19:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237033AbhCAPTb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 10:19:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 209A864E04
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 15:18:50 +0000 (UTC)
Subject: [PATCH v1 35/42] NFSD: Update the NFSv2 GETACL result encoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Mar 2021 10:18:49 -0500
Message-ID: <161461192941.8508.6445439886413261129.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs2acl.c |   42 ++++++++++++++++--------------------------
 fs/nfsd/nfsxdr.c  |   24 ++++++++++++++++++++++--
 fs/nfsd/xdr.h     |    3 +++
 3 files changed, 41 insertions(+), 28 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 855e17772eba..4a15ae6fdbc2 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -242,51 +242,41 @@ static int nfsaclsvc_decode_accessargs(struct svc_rqst *rqstp, __be32 *p)
 /* GETACL */
 static int nfsaclsvc_encode_getaclres(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_getaclres *resp = rqstp->rq_resp;
 	struct dentry *dentry = resp->fh.fh_dentry;
 	struct inode *inode;
-	struct kvec *head = rqstp->rq_res.head;
-	unsigned int base;
-	int n;
 	int w;
 
-	*p++ = resp->status;
-	if (resp->status != nfs_ok)
-		return xdr_ressize_check(rqstp, p);
+	if (!svcxdr_encode_stat(xdr, resp->status))
+		return 0;
 
-	/*
-	 * Since this is version 2, the check for nfserr in
-	 * nfsd_dispatch actually ensures the following cannot happen.
-	 * However, it seems fragile to depend on that.
-	 */
 	if (dentry == NULL || d_really_is_negative(dentry))
-		return 0;
+		return 1;
 	inode = d_inode(dentry);
 
-	p = nfs2svc_encode_fattr(rqstp, p, &resp->fh, &resp->stat);
-	*p++ = htonl(resp->mask);
-	if (!xdr_ressize_check(rqstp, p))
+	if (!svcxdr_encode_fattr(rqstp, xdr, &resp->fh, &resp->stat))
+		return 0;
+	if (xdr_stream_encode_u32(xdr, resp->mask) < 0)
 		return 0;
-	base = (char *)p - (char *)head->iov_base;
 
 	rqstp->rq_res.page_len = w = nfsacl_size(
 		(resp->mask & NFS_ACL)   ? resp->acl_access  : NULL,
 		(resp->mask & NFS_DFACL) ? resp->acl_default : NULL);
 	while (w > 0) {
 		if (!*(rqstp->rq_next_page++))
-			return 0;
+			return 1;
 		w -= PAGE_SIZE;
 	}
 
-	n = nfsacl_encode(&rqstp->rq_res, base, inode,
-			  resp->acl_access,
-			  resp->mask & NFS_ACL, 0);
-	if (n > 0)
-		n = nfsacl_encode(&rqstp->rq_res, base + n, inode,
-				  resp->acl_default,
-				  resp->mask & NFS_DFACL,
-				  NFS_ACL_DEFAULT);
-	return (n > 0);
+	if (!nfs_stream_encode_acl(xdr, inode, resp->acl_access,
+				   resp->mask & NFS_ACL, 0))
+		return 0;
+	if (!nfs_stream_encode_acl(xdr, inode, resp->acl_default,
+				   resp->mask & NFS_DFACL, NFS_ACL_DEFAULT))
+		return 0;
+
+	return 1;
 }
 
 static int nfsaclsvc_encode_attrstatres(struct svc_rqst *rqstp, __be32 *p)
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 5df6f00d76fd..1fed3a8deb18 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -26,7 +26,16 @@ static const u32 nfs_ftypes[] = {
  * Basic NFSv2 data types (RFC 1094 Section 2.3)
  */
 
-static bool
+/**
+ * svcxdr_encode_stat - Encode an NFSv2 status code
+ * @xdr: XDR stream
+ * @status: status value to encode
+ *
+ * Return values:
+ *   %false: Send buffer space was exhausted
+ *   %true: Success
+ */
+bool
 svcxdr_encode_stat(struct xdr_stream *xdr, __be32 status)
 {
 	__be32 *p;
@@ -250,7 +259,18 @@ encode_fattr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp,
 	return p;
 }
 
-static bool
+/**
+ * svcxdr_encode_fattr - Encode NFSv2 file attributes
+ * @rqstp: Context of a completed RPC transaction
+ * @xdr: XDR stream
+ * @fhp: File handle to encode
+ * @stat: Attributes to encode
+ *
+ * Return values:
+ *   %false: Send buffer space was exhausted
+ *   %true: Success
+ */
+bool
 svcxdr_encode_fattr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		    const struct svc_fh *fhp, const struct kstat *stat)
 {
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index bfffcb70a5f8..ad7f7eabf41a 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -170,5 +170,8 @@ void nfssvc_release_readres(struct svc_rqst *rqstp);
 /* Helper functions for NFSv2 ACL code */
 __be32 *nfs2svc_encode_fattr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp, struct kstat *stat);
 bool svcxdr_decode_fhandle(struct xdr_stream *xdr, struct svc_fh *fhp);
+bool svcxdr_encode_stat(struct xdr_stream *xdr, __be32 status);
+bool svcxdr_encode_fattr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
+			 const struct svc_fh *fhp, const struct kstat *stat);
 
 #endif /* LINUX_NFSD_H */


