Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB4E7A4C10
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbjIRPZn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbjIRPZm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:25:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3ECEA
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:24:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C832DC116D4;
        Mon, 18 Sep 2023 14:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045683;
        bh=J3LpBgaMi3k7+6kgzaZ4NJOFtzEpmNGp6BzTjh0Ny9w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qxRxBMCkECQgoQsoUa3S7JKgOlSkgFkpXWxNu7yh5H52bOKkEiGpOYy/5QL7XvjiW
         Sj6bDu/WCv7taJCV14VwRY+Pex6Y7V4rvp5mvLY0OGbZEA/WVpapivW8UwiUrJgRMW
         QGF2JO71omO7+FlYLXZCytlfPhDE30FAQcqZtJtrWRN6tqxzp8OZlarqzPXXohN5UU
         n05Rul3bKtSPb8sHqy/ZD9w2FEMY24lPEIaq+IhoIShH5mQe4dRnM95sQtYKg3F/Uw
         tvbThu4G6Xw6tWeuYcDk9HUyZxz5DWbBBUhuw8M/xiZtQGR9ItFD3ujmiARwO87oVy
         PE/Xv6q5D0uSg==
Subject: [PATCH v1 43/52] NFSD: Add nfsd4_encode_fattr4_mounted_on_fileid()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 10:01:21 -0400
Message-ID: <169504568186.133720.2744006796725296542.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_MOUNTED_ON_FILEID into a helper. In
a subsequent patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 730596c53258..929be84482b9 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2914,6 +2914,7 @@ struct nfsd4_fattr_args {
 	struct nfs4_acl		*acl;
 	u32			rdattr_err;
 	bool			contextsupport;
+	bool			ignore_crossmnt;
 };
 
 static __be32 nfsd4_encode_fattr4__true(struct xdr_stream *xdr,
@@ -3274,6 +3275,23 @@ static __be32 nfsd4_encode_fattr4_time_modify(struct xdr_stream *xdr,
 	return nfsd4_encode_nfstime4(xdr, &args->stat.mtime);
 }
 
+static __be32 nfsd4_encode_fattr4_mounted_on_fileid(struct xdr_stream *xdr,
+						    const struct nfsd4_fattr_args *args)
+{
+	u64 ino;
+	int err;
+
+	if (!args->ignore_crossmnt &&
+	    args->dentry == args->exp->ex_path.mnt->mnt_root) {
+		err = nfsd4_get_mounted_on_ino(args->exp, &ino);
+		if (err)
+			return nfserrno(err);
+	} else
+		ino = args->stat.ino;
+
+	return nfsd4_encode_uint64_t(xdr, ino);
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3311,6 +3329,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	args.rqstp = rqstp;
 	args.exp = exp;
 	args.dentry = dentry;
+	args.ignore_crossmnt = (ignore_crossmnt != 0);
 
 	args.rdattr_err = 0;
 	if (exp->ex_fslocs.migrated) {
@@ -3622,23 +3641,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_MOUNTED_ON_FILEID) {
-		u64 ino = args.stat.ino;
-
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-                	goto out_resource;
-		/*
-		 * Get ino of mountpoint in parent filesystem, if not ignoring
-		 * crossmount and this is the root of a cross-mounted
-		 * filesystem.
-		 */
-		if (ignore_crossmnt == 0 &&
-		    dentry == exp->ex_path.mnt->mnt_root) {
-			err = nfsd4_get_mounted_on_ino(exp, &ino);
-			if (err)
-				goto out_nfserr;
-		}
-		p = xdr_encode_hyper(p, ino);
+		status = nfsd4_encode_fattr4_mounted_on_fileid(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 #ifdef CONFIG_NFSD_PNFS
 	if (bmval1 & FATTR4_WORD1_FS_LAYOUT_TYPES) {


