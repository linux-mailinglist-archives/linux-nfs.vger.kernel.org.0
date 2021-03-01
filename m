Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4416D328210
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbhCAPQs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:16:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:40346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236921AbhCAPQR (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 10:16:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F1F664DF5
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 15:15:37 +0000 (UTC)
Subject: [PATCH v1 03/42] NFSD: Update the NFSv3 ACCESS3res encoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Mar 2021 10:15:36 -0500
Message-ID: <161461173665.8508.1057988392558545100.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3xdr.c |   50 +++++++++++++++++++++++++++++++++++++++++++++-----
 fs/nfsd/vfs.h     |    2 +-
 2 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 75739861d235..9d6c989df6d8 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -383,6 +383,35 @@ encode_saved_post_attr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp)
 	return encode_fattr3(rqstp, p, fhp, &fhp->fh_post_attr);
 }
 
+static bool
+svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
+			   const struct svc_fh *fhp)
+{
+	struct dentry *dentry = fhp->fh_dentry;
+	struct kstat stat;
+
+	/*
+	 * The inode may be NULL if the call failed because of a
+	 * stale file handle. In this case, no attributes are
+	 * returned.
+	 */
+	if (fhp->fh_no_wcc || !dentry || !d_really_is_positive(dentry))
+		goto no_post_op_attrs;
+	if (fh_getattr(fhp, &stat) != nfs_ok)
+		goto no_post_op_attrs;
+
+	if (xdr_stream_encode_item_present(xdr) < 0)
+		return false;
+	lease_get_mtime(d_inode(dentry), &stat.mtime);
+	if (!svcxdr_encode_fattr3(rqstp, xdr, fhp, &stat))
+		return false;
+
+	return true;
+
+no_post_op_attrs:
+	return xdr_stream_encode_item_absent(xdr) > 0;
+}
+
 /*
  * Encode post-operation attributes.
  * The inode may be NULL if the call failed because of a stale file
@@ -835,13 +864,24 @@ nfs3svc_encode_diropres(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_encode_accessres(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_accessres *resp = rqstp->rq_resp;
 
-	*p++ = resp->status;
-	p = encode_post_op_attr(rqstp, p, &resp->fh);
-	if (resp->status == 0)
-		*p++ = htonl(resp->access);
-	return xdr_ressize_check(rqstp, p);
+	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
+		return 0;
+	switch (resp->status) {
+	case nfs_ok:
+		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
+			return 0;
+		if (xdr_stream_encode_u32(xdr, resp->access) < 0)
+			return 0;
+		break;
+	default:
+		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
+			return 0;
+	}
+
+	return 1;
 }
 
 /* READLINK */
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index a2442ebe5acf..b21b76e6b9a8 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -152,7 +152,7 @@ static inline void fh_drop_write(struct svc_fh *fh)
 	}
 }
 
-static inline __be32 fh_getattr(struct svc_fh *fh, struct kstat *stat)
+static inline __be32 fh_getattr(const struct svc_fh *fh, struct kstat *stat)
 {
 	struct path p = {.mnt = fh->fh_export->ex_path.mnt,
 			 .dentry = fh->fh_dentry};


