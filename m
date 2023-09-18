Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5037A4BF7
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240708AbjIRPYA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240922AbjIRPX4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:23:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3B91FC9
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:20:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46B3C433BB;
        Mon, 18 Sep 2023 13:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045453;
        bh=GEsAEExO4y+S5I/UadBh8vwvamHfz4M2jAlEXh+qgVk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=h92miaQXWtMtNT0TupCFi7FgGifGWeOeUh3ppXmAQQAHPuu6TGllZW3djpkjpogMi
         shMeo9u3rSJrfzlRQpf1bWMtmqi+4Ecz3lxBDfJGTyw0g8FL5mW09lXj9tdl2j6XZT
         23Xz1avKVQbPI8azFj8E2/TTLL3VtS2ij8fam0hIrxVYF//xU7c4I6hlpRdIO4PTJ4
         6P1hmIJxfUGbbMDScz85jnH/Uw0oK2c+VP/XVlIkmM+o2J9H6E1OHMcGXJU6h4hdg1
         Oycmor35OYWW/h+y7Hp+iogdJ74pad+/df6ki2YA8B9HR8+QJffIWJvWNd/kjcMbOM
         0p3R1AxSgxkcA==
Subject: [PATCH v1 07/52] NFSD: Add nfsd4_encode_fattr4_supported_attrs()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 09:57:32 -0400
Message-ID: <169504545266.133720.1680333025960206097.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_SUPPORTED_ATTRS into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 91f3b03f297b..da5df33cac04 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2939,7 +2939,9 @@ nfsd4_encode_bitmap4(struct xdr_stream *xdr, u32 bmval0, u32 bmval1, u32 bmval2)
 }
 
 struct nfsd4_fattr_args {
+	struct svc_rqst		*rqstp;
 	struct svc_fh		*fhp;
+	struct dentry		*dentry;
 	struct kstat		stat;
 	struct kstatfs		statfs;
 	struct nfs4_acl		*acl;
@@ -2959,6 +2961,22 @@ static __be32 nfsd4_encode_fattr4__false(struct xdr_stream *xdr,
 	return nfsd4_encode_bool(xdr, false);
 }
 
+static __be32 nfsd4_encode_fattr4_supported_attrs(struct xdr_stream *xdr,
+						  const struct nfsd4_fattr_args *args)
+{
+	struct nfsd4_compoundres *resp = args->rqstp->rq_resp;
+	u32 minorversion = resp->cstate.minorversion;
+	u32 supp[3];
+
+	memcpy(supp, nfsd_suppattrs[minorversion], sizeof(supp));
+	if (!IS_POSIXACL(d_inode(args->dentry)))
+		supp[0] &= ~FATTR4_WORD0_ACL;
+	if (!args->contextsupport)
+		supp[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
+
+	return nfsd4_encode_bitmap4(xdr, supp[0], supp[1], supp[2]);
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -2996,6 +3014,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	BUG_ON(bmval1 & NFSD_WRITEONLY_ATTRS_WORD1);
 	BUG_ON(!nfsd_attrs_supported(minorversion, bmval));
 
+	args.rqstp = rqstp;
+	args.dentry = dentry;
+
 	args.rdattr_err = 0;
 	if (exp->ex_fslocs.migrated) {
 		status = fattr_handle_absent_fs(&bmval0, &bmval1, &bmval2,
@@ -3081,30 +3102,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		goto out_resource;
 
 	if (bmval0 & FATTR4_WORD0_SUPPORTED_ATTRS) {
-		u32 supp[3];
-
-		memcpy(supp, nfsd_suppattrs[minorversion], sizeof(supp));
-
-		if (!IS_POSIXACL(dentry->d_inode))
-			supp[0] &= ~FATTR4_WORD0_ACL;
-		if (!args.contextsupport)
-			supp[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
-		if (!supp[2]) {
-			p = xdr_reserve_space(xdr, 12);
-			if (!p)
-				goto out_resource;
-			*p++ = cpu_to_be32(2);
-			*p++ = cpu_to_be32(supp[0]);
-			*p++ = cpu_to_be32(supp[1]);
-		} else {
-			p = xdr_reserve_space(xdr, 16);
-			if (!p)
-				goto out_resource;
-			*p++ = cpu_to_be32(3);
-			*p++ = cpu_to_be32(supp[0]);
-			*p++ = cpu_to_be32(supp[1]);
-			*p++ = cpu_to_be32(supp[2]);
-		}
+		status = nfsd4_encode_fattr4_supported_attrs(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_TYPE) {
 		p = xdr_reserve_space(xdr, 4);


