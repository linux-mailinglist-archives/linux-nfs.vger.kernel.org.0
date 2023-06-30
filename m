Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800AD743247
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jun 2023 03:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjF3BfE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 21:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjF3BfD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 21:35:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470B6297C
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 18:35:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2E2C6167C
        for <linux-nfs@vger.kernel.org>; Fri, 30 Jun 2023 01:35:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D792C433C8;
        Fri, 30 Jun 2023 01:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688088901;
        bh=4VZU7AH0lSUk+o+b9o0SdPb5coFHQCc7GkXMMBPxJiw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qsAogDP746jMzDd8pIw451IsvrhixGDf9vis+c2/yPiBe3ZndpU2bp4K53HPyzYWI
         8Ds10Hju0I+t8I1ZxM/vDXpg+VX5wsDnkT4FuTFV+GDXAMjHhfmafwGfJEszhOtGIt
         lLON1zNMnJ4EEmuWyQiC7sfNCKctbmpjPgKleL/IAymsoR7n1XUMWZ1u8SIZxAL5dM
         /IBNDCtfLUWCz+6EmaowePg19IWq2k7HDuBWRQ9kbDkrgcsRazq1hDU1LYPizExKpT
         NRpq7HJQSBwr+5HgceKC1yk3K7564RxW/b7zoLQZOY681Fau027gBK1OvtL2Xd4Eab
         FFFx/Rurv/Ezg==
Subject: [PATCH RFC 4/4] NFSD: Encode attributes in WORD2 using a bitmask loop
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Thu, 29 Jun 2023 21:35:00 -0400
Message-ID: <168808890015.7728.16717581858127708439.stgit@manet.1015granger.net>
In-Reply-To: <168808788945.7728.6965361432016501208.stgit@manet.1015granger.net>
References: <168808788945.7728.6965361432016501208.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Replace the current implementation with a branch table. This creates
hard function scope boundaries, limiting side effects and reducing
instruction cache footprint (uncalled encoders remain out of the
cache).

This also makes it obvious which attributes are not supported by the
Linux NFS server.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |  153 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 101 insertions(+), 52 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 8335ca1e2da0..31dccf6d1caa 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2946,6 +2946,10 @@ struct nfsd4_fattr_args {
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
@@ -3421,6 +3425,14 @@ static __be32 nfsd4_encode_fattr4_layout_types(struct xdr_stream *xdr,
 	return nfsd4_encode_layout_types(xdr, args->exp->ex_layout_types);
 }
 
+static __be32 nfsd4_encode_fattr4_layout_blksize(struct xdr_stream *xdr,
+						 struct nfsd4_fattr_args *args)
+{
+	if (xdr_stream_encode_u32(xdr, args->stat.blksize) < 0)
+		return nfserr_resource;
+	return nfs_ok;
+}
+
 #endif
 
 static const nfsd4_enc_attr nfsd4_enc_fattr4_word1_ops[] = {
@@ -3462,6 +3474,84 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_word1_ops[] = {
 	[31]		= nfsd4_encode_fattr4__noop,	/* layout hint */
 };
 
+static __be32 nfsd4_encode_fattr4_suppattr_exclcreat(struct xdr_stream *xdr,
+						     struct nfsd4_fattr_args *args)
+{
+	struct nfsd4_compoundres *resp = args->rqstp->rq_resp;
+	u32 minorversion = resp->cstate.minorversion;
+	u32 supp[3];
+
+	memcpy(supp, nfsd_suppattrs[minorversion], sizeof(supp));
+	supp[0] &= NFSD_SUPPATTR_EXCLCREAT_WORD0;
+	supp[1] &= NFSD_SUPPATTR_EXCLCREAT_WORD1;
+	supp[2] &= NFSD_SUPPATTR_EXCLCREAT_WORD2;
+
+	return nfsd4_encode_bitmap(xdr, supp[0], supp[1], supp[2]);
+}
+
+#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
+static __be32 nfsd4_encode_fattr4_sec_label(struct xdr_stream *xdr,
+					    struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_security_label(xdr, args->rqstp,
+					   args->context, args->contextlen);
+}
+#endif
+
+static __be32 nfsd4_encode_fattr4_xattr_support(struct xdr_stream *xdr,
+						struct nfsd4_fattr_args *args)
+{
+	int err = xattr_supports_user_prefix(d_inode(args->dentry));
+
+	if (xdr_stream_encode_bool(xdr, err == 0) < 0)
+		return nfserr_resource;
+	return nfs_ok;
+}
+
+static const nfsd4_enc_attr nfsd4_enc_fattr4_word2_ops[] = {
+#ifdef CONFIG_NFSD_PNFS
+	[0]		= nfsd4_encode_fattr4_layout_types,
+	[1]		= nfsd4_encode_fattr4_layout_blksize,
+#else
+	[0]		= nfsd4_encode_fattr4__noop,
+	[1]		= nfsd4_encode_fattr4__noop,
+#endif
+	[2]		= nfsd4_encode_fattr4__noop,	/* layout alignment */
+	[3]		= nfsd4_encode_fattr4__noop,	/* fslocations info */
+	[4]		= nfsd4_encode_fattr4__noop,	/* mds threshold */
+	[5]		= nfsd4_encode_fattr4__noop,	/* retention get */
+	[6]		= nfsd4_encode_fattr4__noop,	/* retention set */
+	[7]		= nfsd4_encode_fattr4__noop,	/* retentevt get */
+	[8]		= nfsd4_encode_fattr4__noop,	/* retentevt set */
+	[9]		= nfsd4_encode_fattr4__noop,	/* retention hold */
+	[10]		= nfsd4_encode_fattr4__noop,	/* mode set mask */
+	[11]		= nfsd4_encode_fattr4_suppattr_exclcreat,
+	[12]		= nfsd4_encode_fattr4__noop,	/* fs charset cap */
+	[13]		= nfsd4_encode_fattr4__noop,	/* clone blksize */
+	[14]		= nfsd4_encode_fattr4__noop,	/* space freed */
+	[15]		= nfsd4_encode_fattr4__noop,	/* change attr type */
+#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
+	[16]		= nfsd4_encode_fattr4_sec_label,
+#else
+	[16]		= nfsd4_encode_fattr4__noop,
+#endif
+	[17]		= nfsd4_encode_fattr4__noop,	/* mode_umask */
+	[18]		= nfsd4_encode_fattr4_xattr_support,
+	[19]		= nfsd4_encode_fattr4__noop,	/* reserved */
+	[20]		= nfsd4_encode_fattr4__noop,	/* reserved */
+	[21]		= nfsd4_encode_fattr4__noop,	/* reserved */
+	[22]		= nfsd4_encode_fattr4__noop,	/* reserved */
+	[23]		= nfsd4_encode_fattr4__noop,	/* reserved */
+	[24]		= nfsd4_encode_fattr4__noop,	/* reserved */
+	[25]		= nfsd4_encode_fattr4__noop,	/* reserved */
+	[26]		= nfsd4_encode_fattr4__noop,	/* reserved */
+	[27]		= nfsd4_encode_fattr4__noop,	/* reserved */
+	[28]		= nfsd4_encode_fattr4__noop,	/* reserved */
+	[29]		= nfsd4_encode_fattr4__noop,	/* reserved */
+	[30]		= nfsd4_encode_fattr4__noop,	/* reserved */
+	[31]		= nfsd4_encode_fattr4__noop,	/* reserved */
+};
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3478,12 +3568,6 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	u32 bmval2 = bmval[2];
 	struct svc_fh *tempfh = NULL;
 	int starting_len = xdr->buf->len;
-#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
-	void *context = NULL;
-	int contextlen;
-#endif
-	struct nfsd4_compoundres *resp = rqstp->rq_resp;
-	u32 minorversion = resp->cstate.minorversion;
 	int err, i, attrlen_offset;
 	__be32 status, *attrlen_p;
 	struct path path = {
@@ -3491,7 +3575,6 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		.dentry	= dentry,
 	};
 	unsigned long mask;
-	__be32 *p;
 
 	args.rqstp = rqstp;
 	args.fhp = fhp;
@@ -3552,11 +3635,12 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
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
@@ -3592,48 +3676,13 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 
-#ifdef CONFIG_NFSD_PNFS
-	if (bmval2 & FATTR4_WORD2_LAYOUT_TYPES) {
-		status = nfsd4_encode_layout_types(xdr, exp->ex_layout_types);
-		if (status)
-			goto out;
-	}
-
-	if (bmval2 & FATTR4_WORD2_LAYOUT_BLKSIZE) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(args.stat.blksize);
-	}
-#endif /* CONFIG_NFSD_PNFS */
-	if (bmval2 & FATTR4_WORD2_SUPPATTR_EXCLCREAT) {
-		u32 supp[3];
-
-		memcpy(supp, nfsd_suppattrs[minorversion], sizeof(supp));
-		supp[0] &= NFSD_SUPPATTR_EXCLCREAT_WORD0;
-		supp[1] &= NFSD_SUPPATTR_EXCLCREAT_WORD1;
-		supp[2] &= NFSD_SUPPATTR_EXCLCREAT_WORD2;
-
-		status = nfsd4_encode_bitmap(xdr, supp[0], supp[1], supp[2]);
-		if (status)
-			goto out;
-	}
-
-#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
-	if (bmval2 & FATTR4_WORD2_SECURITY_LABEL) {
-		status = nfsd4_encode_security_label(xdr, rqstp, context,
-								contextlen);
-		if (status)
-			goto out;
-	}
-#endif
-
-	if (bmval2 & FATTR4_WORD2_XATTR_SUPPORT) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		err = xattr_supports_user_prefix(d_inode(dentry));
-		*p++ = cpu_to_be32(err == 0);
+	if (bmval2) {
+		mask = bmval2;
+		for_each_set_bit(i, &mask, 32) {
+			status = nfsd4_enc_fattr4_word2_ops[i](xdr, &args);
+			if (status)
+				goto out;
+		}
 	}
 
 	*attrlen_p = cpu_to_be32(xdr->buf->len - attrlen_offset - XDR_UNIT);
@@ -3641,8 +3690,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
 out:
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
-	if (context)
-		security_release_secctx(context, contextlen);
+	if (args.context)
+		security_release_secctx(args.context, args.contextlen);
 #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
 	kfree(args.acl);
 	if (tempfh) {


