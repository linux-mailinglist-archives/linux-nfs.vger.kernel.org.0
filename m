Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D869D7A4BF8
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240063AbjIRPX6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240741AbjIRPXx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:23:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5111A6
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:20:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69037C32778;
        Mon, 18 Sep 2023 14:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045714;
        bh=QBNnRML3S6bGG3pfz5hCJOHDxJoyRg3wt3u2Fmuj6K0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ide9T8JKmXIDAf6LgMyl/CK9DWB7jE//EG1xrlnV4r9jZVkywousLHEYPmInwJ4Pr
         ABJ80VmDxOXAI7pWx/lnRjR8ZMwi47HpXBKTjKXmKviQ8Lt70NTCMQPScdfDWd4QVL
         pdUPfkYJ/5ZD+BSqBZdGNiJzjco2BRLd6+VqCsuIuOuBqlNJFbho1cSiZwXD4ju1nl
         Ym6yTOsjsOYZT1Pd3KgLf8z1j6fmAGvL8HEwaTL5tpIsbVqoC6t8m7x1qNIWW2/cpk
         dlaKMTINKelnJA9QSTXKnf+4AgA27rZqXGaIbMMT9iLJ8/4c1yW5KFXeVhHBztIAhp
         F9ItidsohkTRw==
Subject: [PATCH v1 48/52] NFSD: Add nfsd4_encode_fattr4_sec_label()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 10:01:53 -0400
Message-ID: <169504571355.133720.18035352251995094063.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_SEC_LABEL into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 02a28d07d6e4..137e7368dbfd 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2893,6 +2893,10 @@ struct nfsd4_fattr_args {
 	struct kstat		stat;
 	struct kstatfs		statfs;
 	struct nfs4_acl		*acl;
+#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
+	void			*context;
+	int			contextlen;
+#endif
 	u32			rdattr_err;
 	bool			contextsupport;
 	bool			ignore_crossmnt;
@@ -3333,6 +3337,15 @@ static __be32 nfsd4_encode_fattr4_suppattr_exclcreat(struct xdr_stream *xdr,
 	return nfsd4_encode_bitmap4(xdr, supp[0], supp[1], supp[2]);
 }
 
+#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
+static __be32 nfsd4_encode_fattr4_sec_label(struct xdr_stream *xdr,
+					    const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_security_label(xdr, args->rqstp,
+					   args->context, args->contextlen);
+}
+#endif
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3353,10 +3366,6 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	int attrlen_offset;
 	__be32 status;
 	int err;
-#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
-	void *context = NULL;
-	int contextlen;
-#endif
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
 	u32 minorversion = resp->cstate.minorversion;
 	struct path path = {
@@ -3430,11 +3439,12 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	args.contextsupport = false;
 
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
+	args.context = NULL;
 	if ((bmval2 & FATTR4_WORD2_SECURITY_LABEL) ||
 	     bmval0 & FATTR4_WORD0_SUPPORTED_ATTRS) {
 		if (exp->ex_flags & NFSEXP_SECURITY_LABEL)
 			err = security_inode_getsecctx(d_inode(dentry),
-						&context, &contextlen);
+						&args.context, &args.contextlen);
 		else
 			err = -EOPNOTSUPP;
 		args.contextsupport = (err == 0);
@@ -3713,8 +3723,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	if (bmval2 & FATTR4_WORD2_SECURITY_LABEL) {
-		status = nfsd4_encode_security_label(xdr, rqstp, context,
-								contextlen);
+		status = nfsd4_encode_fattr4_sec_label(xdr, &args);
 		if (status)
 			goto out;
 	}
@@ -3733,8 +3742,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
 out:
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
-	if (context)
-		security_release_secctx(context, contextlen);
+	if (args.context)
+		security_release_secctx(args.context, args.contextlen);
 #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
 	kfree(args.acl);
 	if (tempfh) {


