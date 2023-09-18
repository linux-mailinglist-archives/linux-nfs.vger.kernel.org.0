Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171E17A4B8E
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjIRPSu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbjIRPSt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:18:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1861A6
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:17:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C553C43140;
        Mon, 18 Sep 2023 13:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045466;
        bh=yTYFgeQLf6mn8Ofiq0L4auswDUEn+UMSP1VMECXDKIU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eW2Wkc/HbbuhsnU5dis/7ojANlfMU+tSkEGDWLUDl1wJVb3jsI4+FjIQtuZVSjOZd
         oTxujHzgQAbPwZRfDx3gyVLh1zV3I3TtmCQNy0m4zYhEDGmerPSCgpIZNLyH0PWb3m
         jO1R7RZLquA31Z9cbQmXtAggJLr6vZuhP0wl0pZo1wJ56nODZxwp9JfDGCFuVuFk/8
         IWjBFfm0S6qYOBLwiCfyDxLtH+D/Ode6AshGN7J1bjeubBvBIA7O6ZXoKkwy2ahGhq
         uQ+VCAzgUix4BO+WV4ja71HRHhoU91y/ls6+/F6g27aHM/jw3bOjGe+8xX1BTauj6k
         x6oPWILSqO3wQ==
Subject: [PATCH v1 09/52] NFSD: Add nfsd4_encode_fattr4_fh_expire_type()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 09:57:45 -0400
Message-ID: <169504546537.133720.11707175189232518946.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_FH_EXPIRE_TYPE into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c1dc6810f043..e7f1a856fb0b 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2927,6 +2927,7 @@ nfsd4_encode_bitmap4(struct xdr_stream *xdr, u32 bmval0, u32 bmval1, u32 bmval2)
 struct nfsd4_fattr_args {
 	struct svc_rqst		*rqstp;
 	struct svc_fh		*fhp;
+	struct svc_export	*exp;
 	struct dentry		*dentry;
 	struct kstat		stat;
 	struct kstatfs		statfs;
@@ -3001,6 +3002,17 @@ static __be32 nfsd4_encode_fattr4_type(struct xdr_stream *xdr,
 	return nfs_ok;
 }
 
+static __be32 nfsd4_encode_fattr4_fh_expire_type(struct xdr_stream *xdr,
+						 const struct nfsd4_fattr_args *args)
+{
+	u32 mask;
+
+	mask = NFS4_FH_PERSISTENT;
+	if (!(args->exp->ex_flags & NFSEXP_NOSUBTREECHECK))
+		mask |= NFS4_FH_VOL_RENAME;
+	return nfsd4_encode_uint32_t(xdr, mask);
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3038,6 +3050,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	BUG_ON(!nfsd_attrs_supported(minorversion, bmval));
 
 	args.rqstp = rqstp;
+	args.exp = exp;
 	args.dentry = dentry;
 
 	args.rdattr_err = 0;
@@ -3135,14 +3148,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_FH_EXPIRE_TYPE) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		if (exp->ex_flags & NFSEXP_NOSUBTREECHECK)
-			*p++ = cpu_to_be32(NFS4_FH_PERSISTENT);
-		else
-			*p++ = cpu_to_be32(NFS4_FH_PERSISTENT|
-						NFS4_FH_VOL_RENAME);
+		status = nfsd4_encode_fattr4_fh_expire_type(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_CHANGE) {
 		p = xdr_reserve_space(xdr, 8);


