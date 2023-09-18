Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218D27A4BA4
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbjIRPUH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjIRPUG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:20:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B962110E5
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:18:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0178C116A6;
        Mon, 18 Sep 2023 13:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045524;
        bh=JVowiB1qwGRQwKqjm0kyZoKJGWEGX8p3DbGw3T2pl5Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NH3W1mXa+mN+t116thnwT8P4gBFYsM850faNRQrTkUgNTHxm2+98OwTO23mlhnbbQ
         S/j27nUD7bEivfqjQDcXgrj7In6IZFzVXa1prmanlA9+niYp64l3Y/VIZg5Gu795jm
         5AtDZbtpZgOp/AY58vC7IjYSB9zEbzcZ8KBld1KpIL7mdzA4IBPRsGbAE5ofeiQNVv
         4PhjKL2hLut7tYCRhTQj1NJUDTAuB9Y36opNzXyxOR8I/lxNhvs1GjezQ002YaVrzI
         K3P0ezvaydk2vfd7te9o73MOHaQ6Z56BXEWa2rddKr6rCyfQsV/630dTu6sL45DGvy
         wumFk2q2ngYrw==
Subject: [PATCH v1 18/52] NFSD: Add nfsd4_encode_fattr4_filehandle()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 09:58:42 -0400
Message-ID: <169504552286.133720.2850816810472540761.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_FILEHANDLE into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

We can de-duplicate the other filehandle encoder (in GETFH) using
our new helper.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 5e91ed6ae0f7..17997bf08139 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2530,6 +2530,12 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 	return true;
 }
 
+static __be32 nfsd4_encode_nfs_fh4(struct xdr_stream *xdr,
+				   struct knfsd_fh *fh_handle)
+{
+	return nfsd4_encode_opaque(xdr, fh_handle->fh_raw, fh_handle->fh_size);
+}
+
 static __be32 nfsd4_encode_nfstime4(struct xdr_stream *xdr,
 				    struct timespec64 *tv)
 {
@@ -3124,6 +3130,12 @@ static __be32 nfsd4_encode_fattr4_acl(struct xdr_stream *xdr,
 	return nfs_ok;
 }
 
+static __be32 nfsd4_encode_fattr4_filehandle(struct xdr_stream *xdr,
+					     const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_nfs_fh4(xdr, &args->fhp->fh_handle);
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3338,11 +3350,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_FILEHANDLE) {
-		p = xdr_reserve_space(xdr, args.fhp->fh_handle.fh_size + 4);
-		if (!p)
-			goto out_resource;
-		p = xdr_encode_opaque(p, &args.fhp->fh_handle.fh_raw,
-					args.fhp->fh_handle.fh_size);
+		status = nfsd4_encode_fattr4_filehandle(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_FILEID) {
 		p = xdr_reserve_space(xdr, 8);
@@ -3927,18 +3937,11 @@ static __be32
 nfsd4_encode_getfh(struct nfsd4_compoundres *resp, __be32 nfserr,
 		   union nfsd4_op_u *u)
 {
-	struct svc_fh **fhpp = &u->getfh;
 	struct xdr_stream *xdr = resp->xdr;
-	struct svc_fh *fhp = *fhpp;
-	unsigned int len;
-	__be32 *p;
+	struct svc_fh *fhp = u->getfh;
 
-	len = fhp->fh_handle.fh_size;
-	p = xdr_reserve_space(xdr, len + 4);
-	if (!p)
-		return nfserr_resource;
-	p = xdr_encode_opaque(p, &fhp->fh_handle.fh_raw, len);
-	return 0;
+	/* object */
+	return nfsd4_encode_nfs_fh4(xdr, &fhp->fh_handle);
 }
 
 /*


