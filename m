Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3286932FDDF
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Mar 2021 23:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhCFWdV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 6 Mar 2021 17:33:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:34718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229709AbhCFWdI (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 6 Mar 2021 17:33:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 832876509D
        for <linux-nfs@vger.kernel.org>; Sat,  6 Mar 2021 22:33:08 +0000 (UTC)
Subject: [PATCH v2 39/43] NFSD: Update the NFSv3 GETACL result encoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sat, 06 Mar 2021 17:33:07 -0500
Message-ID: <161506998778.4312.6707477843251712087.stgit@klimt.1015granger.net>
In-Reply-To: <161506956174.4312.17478383686779759287.stgit@klimt.1015granger.net>
References: <161506956174.4312.17478383686779759287.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3acl.c |   33 +++++++++++++++++++--------------
 fs/nfsd/nfs3xdr.c |   23 +++++++++++++++++++++--
 fs/nfsd/xdr3.h    |    3 +++
 3 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 9a6f18d74d14..11991026ab3a 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -168,22 +168,25 @@ static int nfs3svc_decode_setaclargs(struct svc_rqst *rqstp, __be32 *p)
 /* GETACL */
 static int nfs3svc_encode_getaclres(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_getaclres *resp = rqstp->rq_resp;
 	struct dentry *dentry = resp->fh.fh_dentry;
+	struct kvec *head = rqstp->rq_res.head;
+	struct inode *inode = d_inode(dentry);
+	unsigned int base;
+	int n;
+	int w;
 
-	*p++ = resp->status;
-	p = nfs3svc_encode_post_op_attr(rqstp, p, &resp->fh);
-	if (resp->status == 0 && dentry && d_really_is_positive(dentry)) {
-		struct inode *inode = d_inode(dentry);
-		struct kvec *head = rqstp->rq_res.head;
-		unsigned int base;
-		int n;
-		int w;
-
-		*p++ = htonl(resp->mask);
-		if (!xdr_ressize_check(rqstp, p))
+	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
+		return 0;
+	switch (resp->status) {
+	case nfs_ok:
+		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
 			return 0;
-		base = (char *)p - (char *)head->iov_base;
+		if (xdr_stream_encode_u32(xdr, resp->mask) < 0)
+			return 0;
+
+		base = (char *)xdr->p - (char *)head->iov_base;
 
 		rqstp->rq_res.page_len = w = nfsacl_size(
 			(resp->mask & NFS_ACL)   ? resp->acl_access  : NULL,
@@ -204,9 +207,11 @@ static int nfs3svc_encode_getaclres(struct svc_rqst *rqstp, __be32 *p)
 					  NFS_ACL_DEFAULT);
 		if (n <= 0)
 			return 0;
-	} else
-		if (!xdr_ressize_check(rqstp, p))
+		break;
+	default:
+		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
 			return 0;
+	}
 
 	return 1;
 }
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 646bbfc5b779..941740a97f8f 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -107,7 +107,16 @@ svcxdr_decode_nfs_fh3(struct xdr_stream *xdr, struct svc_fh *fhp)
 	return true;
 }
 
-static bool
+/**
+ * svcxdr_encode_nfsstat3 - Encode an NFSv3 status code
+ * @xdr: XDR stream
+ * @status: status value to encode
+ *
+ * Return values:
+ *   %false: Send buffer space was exhausted
+ *   %true: Success
+ */
+bool
 svcxdr_encode_nfsstat3(struct xdr_stream *xdr, __be32 status)
 {
 	__be32 *p;
@@ -464,7 +473,17 @@ svcxdr_encode_pre_op_attr(struct xdr_stream *xdr, const struct svc_fh *fhp)
 	return svcxdr_encode_wcc_attr(xdr, fhp);
 }
 
-static bool
+/**
+ * svcxdr_encode_post_op_attr - Encode NFSv3 post-op attributes
+ * @rqstp: Context of a completed RPC transaction
+ * @xdr: XDR stream
+ * @fhp: File handle to encode
+ *
+ * Return values:
+ *   %false: Send buffer space was exhausted
+ *   %true: Success
+ */
+bool
 svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 			   const struct svc_fh *fhp)
 {
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index b851458373db..746c5f79964f 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -308,5 +308,8 @@ int nfs3svc_encode_entryplus3(void *data, const char *name, int namlen,
 __be32 *nfs3svc_encode_post_op_attr(struct svc_rqst *rqstp, __be32 *p,
 				struct svc_fh *fhp);
 bool svcxdr_decode_nfs_fh3(struct xdr_stream *xdr, struct svc_fh *fhp);
+bool svcxdr_encode_nfsstat3(struct xdr_stream *xdr, __be32 status);
+bool svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
+				const struct svc_fh *fhp);
 
 #endif /* _LINUX_NFSD_XDR3_H */


