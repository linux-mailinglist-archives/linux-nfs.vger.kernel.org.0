Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99E2479EBA
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Dec 2021 02:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbhLSBox (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Dec 2021 20:44:53 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60820 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbhLSBox (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Dec 2021 20:44:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A36EC60C63
        for <linux-nfs@vger.kernel.org>; Sun, 19 Dec 2021 01:44:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E79DC36AE0;
        Sun, 19 Dec 2021 01:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639878292;
        bh=jpjmEyyljh0ZZe/TeyZ7Z6L5jk/Ri/e+zsFtxMLj+CM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ravsgWtLK8B8G5+fkWU5BX2e3J5taxYsEWVFJhE25m7U8rYHlB+GEIAqW+ZcPH/1a
         utSPrypSPfTOh0RKrd7YiT981AiLXG8sPGPXru4GO6cJ9Eju2tf1SOpS/bGZpWFm/b
         9g+xHnb9uxV7c/A2floUyDGOJ3sNDN5JCxIsa7A9B9sm4wCeKu0mRO/HlyTbH36E3x
         q6knx7eGVq5mpGR4pINVCxi+6CiYiu4whvlznDOd+ytP6izmKHbVEqEylAMSV1l2dn
         W9iC8vw+1dgjK24pqTuGQHLL5M4ibH5UJCT/jTstZoGaq+PaAV8DY4KCbDn23CGglM
         +69J58jncYbAw==
From:   trondmy@kernel.org
To:     Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 04/10] nfsd: Distinguish between required and optional NFSv3 post-op attributes
Date:   Sat, 18 Dec 2021 20:37:57 -0500
Message-Id: <20211219013803.324724-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211219013803.324724-4-trondmy@kernel.org>
References: <20211219013803.324724-1-trondmy@kernel.org>
 <20211219013803.324724-2-trondmy@kernel.org>
 <20211219013803.324724-3-trondmy@kernel.org>
 <20211219013803.324724-4-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@primarydata.com>

The fhp->fh_no_wcc flag is automatically set in nfsd_set_fh_dentry()
when the EXPORT_OP_NOWCC flag is set. In svcxdr_encode_post_op_attr(),
this then causes nfsd to skip returning the post-op attributes.

The problem is that some of these post-op attributes are not really
optional. In particular, we do want LOOKUP to always return post-op
attributes for the file that is being looked up.

The solution is therefore to explicitly label the attributes that we can
safely opt out from, and only apply the 'fhp->fh_no_wcc' test in that
case.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfs3xdr.c | 77 +++++++++++++++++++++++++++++++----------------
 1 file changed, 51 insertions(+), 26 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index c3ac1b6aa3aa..6adfc40722fa 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -415,19 +415,9 @@ svcxdr_encode_pre_op_attr(struct xdr_stream *xdr, const struct svc_fh *fhp)
 	return svcxdr_encode_wcc_attr(xdr, fhp);
 }
 
-/**
- * svcxdr_encode_post_op_attr - Encode NFSv3 post-op attributes
- * @rqstp: Context of a completed RPC transaction
- * @xdr: XDR stream
- * @fhp: File handle to encode
- *
- * Return values:
- *   %false: Send buffer space was exhausted
- *   %true: Success
- */
-bool
-svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
-			   const struct svc_fh *fhp)
+static bool
+__svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
+			     const struct svc_fh *fhp, bool force)
 {
 	struct dentry *dentry = fhp->fh_dentry;
 	struct kstat stat;
@@ -437,7 +427,7 @@ svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	 * stale file handle. In this case, no attributes are
 	 * returned.
 	 */
-	if (fhp->fh_no_wcc || !dentry || !d_really_is_positive(dentry))
+	if (!force || !dentry || !d_really_is_positive(dentry))
 		goto no_post_op_attrs;
 	if (fh_getattr(fhp, &stat) != nfs_ok)
 		goto no_post_op_attrs;
@@ -454,6 +444,31 @@ svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	return xdr_stream_encode_item_absent(xdr) > 0;
 }
 
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
+svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
+			   const struct svc_fh *fhp)
+{
+	return __svcxdr_encode_post_op_attr(rqstp, xdr, fhp, true);
+}
+
+static bool
+svcxdr_encode_post_op_attr_opportunistic(struct svc_rqst *rqstp,
+					 struct xdr_stream *xdr,
+					 const struct svc_fh *fhp)
+{
+	return __svcxdr_encode_post_op_attr(rqstp, xdr, fhp, !fhp->fh_no_wcc);
+}
+
 /*
  * Encode weak cache consistency data
  */
@@ -481,7 +496,7 @@ svcxdr_encode_wcc_data(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 neither:
 	if (xdr_stream_encode_item_absent(xdr) < 0)
 		return false;
-	if (!svcxdr_encode_post_op_attr(rqstp, xdr, fhp))
+	if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr, fhp))
 		return false;
 
 	return true;
@@ -854,11 +869,13 @@ nfs3svc_encode_lookupres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 			return false;
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
 			return false;
-		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->dirfh))
+		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
+							      &resp->dirfh))
 			return false;
 		break;
 	default:
-		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->dirfh))
+		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
+							      &resp->dirfh))
 			return false;
 	}
 
@@ -875,13 +892,15 @@ nfs3svc_encode_accessres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		return false;
 	switch (resp->status) {
 	case nfs_ok:
-		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
+		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
+							      &resp->fh))
 			return false;
 		if (xdr_stream_encode_u32(xdr, resp->access) < 0)
 			return false;
 		break;
 	default:
-		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
+		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
+							      &resp->fh))
 			return false;
 	}
 
@@ -899,7 +918,8 @@ nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		return false;
 	switch (resp->status) {
 	case nfs_ok:
-		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
+		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
+							      &resp->fh))
 			return false;
 		if (xdr_stream_encode_u32(xdr, resp->len) < 0)
 			return false;
@@ -908,7 +928,8 @@ nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 			return false;
 		break;
 	default:
-		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
+		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
+							      &resp->fh))
 			return false;
 	}
 
@@ -926,7 +947,8 @@ nfs3svc_encode_readres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		return false;
 	switch (resp->status) {
 	case nfs_ok:
-		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
+		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
+							      &resp->fh))
 			return false;
 		if (xdr_stream_encode_u32(xdr, resp->count) < 0)
 			return false;
@@ -940,7 +962,8 @@ nfs3svc_encode_readres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 			return false;
 		break;
 	default:
-		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
+		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
+							      &resp->fh))
 			return false;
 	}
 
@@ -1032,7 +1055,8 @@ nfs3svc_encode_readdirres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		return false;
 	switch (resp->status) {
 	case nfs_ok:
-		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
+		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
+							      &resp->fh))
 			return false;
 		if (!svcxdr_encode_cookieverf3(xdr, resp->verf))
 			return false;
@@ -1044,7 +1068,8 @@ nfs3svc_encode_readdirres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 			return false;
 		break;
 	default:
-		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
+		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
+							      &resp->fh))
 			return false;
 	}
 
@@ -1188,7 +1213,7 @@ svcxdr_encode_entry3_plus(struct nfsd3_readdirres *resp, const char *name,
 	if (compose_entry_fh(resp, fhp, name, namlen, ino) != nfs_ok)
 		goto out_noattrs;
 
-	if (!svcxdr_encode_post_op_attr(resp->rqstp, xdr, fhp))
+	if (!svcxdr_encode_post_op_attr_opportunistic(resp->rqstp, xdr, fhp))
 		goto out;
 	if (!svcxdr_encode_post_op_fh3(xdr, fhp))
 		goto out;
-- 
2.33.1

