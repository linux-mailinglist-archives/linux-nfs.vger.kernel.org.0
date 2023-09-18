Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E337E7A4BDE
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjIRPXN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239865AbjIRPXM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:23:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60369C
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:18:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89ADAC116AB;
        Mon, 18 Sep 2023 13:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045555;
        bh=8igG2bOvJV6gb5Z0K/jxYV0hxPwdZTTiiBz9YVdPno8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Z/URcogfnWYTZ4SmCW787BgZAWQ7fR1p6Ph4UFUVe2ryQQHgpn9fYnHy++CZ7XdS6
         J2Z+9cYZ2wuQ6wUzHH3WYNPrFCknLW7eisJnILD7mHiYg8PiQTCkw05JBWP2aFoRK5
         MjFQ81PBUjf0Pmi2nQf/u8yENogP5fu4ha7R2MFx7hIxPA73xMKOljjZwm9nVNpX7D
         PzwSWhP4JV5U8x7JbPDMQq0N+evP9cucZWVWHBRb8evqXlx5teYcweFnM3+O/yylx4
         MPr9m7MhbaV7K3hOncka82Z1k1Jx4HdheutJVHsQNd3X7qNaG5ZNsUzjzU4bdawzlk
         VuuiSMKkQsu8A==
Subject: [PATCH v1 23/52] NFSD: Add nfsd4_encode_fattr4_fs_locations()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 09:59:14 -0400
Message-ID: <169504555464.133720.2700015104145924369.stgit@manet.1015granger.net>
In-Reply-To: <169504501081.133720.4162400017732492854.stgit@manet.1015granger.net>
References: <169504501081.133720.4162400017732492854.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Refactor the encoder for FATTR4_FS_LOCATIONS into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   66 ++++++++++++++++++++++-------------------------------
 1 file changed, 28 insertions(+), 38 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e024742abc73..f247fd6f02f5 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2658,9 +2658,6 @@ static __be32 nfsd4_encode_components(struct xdr_stream *xdr, char sep,
 	return nfsd4_encode_components_esc(xdr, sep, components, 0, 0);
 }
 
-/*
- * encode a location element of a fs_locations structure
- */
 static __be32 nfsd4_encode_fs_location4(struct xdr_stream *xdr,
 					struct nfsd4_fs_location *location)
 {
@@ -2673,15 +2670,12 @@ static __be32 nfsd4_encode_fs_location4(struct xdr_stream *xdr,
 	status = nfsd4_encode_components(xdr, '/', location->path);
 	if (status)
 		return status;
-	return 0;
+	return nfs_ok;
 }
 
-/*
- * Encode a path in RFC3530 'pathname4' format
- */
-static __be32 nfsd4_encode_path(struct xdr_stream *xdr,
-				const struct path *root,
-				const struct path *path)
+static __be32 nfsd4_encode_pathname4(struct xdr_stream *xdr,
+				     const struct path *root,
+				     const struct path *path)
 {
 	struct path cur = *path;
 	__be32 *p;
@@ -2749,44 +2743,34 @@ static __be32 nfsd4_encode_path(struct xdr_stream *xdr,
 	return err;
 }
 
-static __be32 nfsd4_encode_fsloc_fsroot(struct xdr_stream *xdr,
-			struct svc_rqst *rqstp, const struct path *path)
+static __be32 nfsd4_encode_fs_locations4(struct xdr_stream *xdr,
+					 struct svc_rqst *rqstp,
+					 struct svc_export *exp)
 {
+	struct nfsd4_fs_locations *fslocs = &exp->ex_fslocs;
 	struct svc_export *exp_ps;
-	__be32 res;
+	unsigned int i;
+	__be32 status;
 
+	/* fs_root */
 	exp_ps = rqst_find_fsidzero_export(rqstp);
 	if (IS_ERR(exp_ps))
 		return nfserrno(PTR_ERR(exp_ps));
-	res = nfsd4_encode_path(xdr, &exp_ps->ex_path, path);
+	status = nfsd4_encode_pathname4(xdr, &exp_ps->ex_path, &exp->ex_path);
 	exp_put(exp_ps);
-	return res;
-}
-
-/*
- *  encode a fs_locations structure
- */
-static __be32 nfsd4_encode_fs_locations(struct xdr_stream *xdr,
-			struct svc_rqst *rqstp, struct svc_export *exp)
-{
-	__be32 status;
-	int i;
-	__be32 *p;
-	struct nfsd4_fs_locations *fslocs = &exp->ex_fslocs;
-
-	status = nfsd4_encode_fsloc_fsroot(xdr, rqstp, &exp->ex_path);
-	if (status)
+	if (status != nfs_ok)
 		return status;
-	p = xdr_reserve_space(xdr, 4);
-	if (!p)
+
+	/* locations<> */
+	if (xdr_stream_encode_u32(xdr, fslocs->locations_count) != XDR_UNIT)
 		return nfserr_resource;
-	*p++ = cpu_to_be32(fslocs->locations_count);
-	for (i=0; i<fslocs->locations_count; i++) {
+	for (i = 0; i < fslocs->locations_count; i++) {
 		status = nfsd4_encode_fs_location4(xdr, &fslocs->locations[i]);
-		if (status)
+		if (status != nfs_ok)
 			return status;
 	}
-	return 0;
+
+	return nfs_ok;
 }
 
 static __be32 nfsd4_encode_nfsace4(struct xdr_stream *xdr, struct svc_rqst *rqstp,
@@ -3160,6 +3144,12 @@ static __be32 nfsd4_encode_fattr4_files_total(struct xdr_stream *xdr,
 	return nfsd4_encode_uint64_t(xdr, args->statfs.f_files);
 }
 
+static __be32 nfsd4_encode_fattr4_fs_locations(struct xdr_stream *xdr,
+					       const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_fs_locations4(xdr, args->rqstp, args->exp);
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3399,8 +3389,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_FS_LOCATIONS) {
-		status = nfsd4_encode_fs_locations(xdr, rqstp, exp);
-		if (status)
+		status = nfsd4_encode_fattr4_fs_locations(xdr, &args);
+		if (status != nfs_ok)
 			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_HOMOGENEOUS) {


