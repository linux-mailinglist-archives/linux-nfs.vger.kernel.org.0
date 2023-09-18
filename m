Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379777A4C16
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjIRP0M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjIRP0M (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:26:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B082210E3
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:24:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E4CC3277A;
        Mon, 18 Sep 2023 14:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045740;
        bh=F7a6thmp0sDPhZVNpiOt10d5AsAUD4N3eOni6yrQT/o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=o9QA3tODgqShiEGrL2HRyB6UBmRw9QK2+NFvBwMeoN07NM2C9W8QuOlX/XUk1m4tF
         qaSeXjkVahniFeF2eqs9Crdne3SWt9G9X5JaplPfGtMr2n6tkQ8dvGnYjo7pGtKEjL
         +hE3A4fL/+5lGrm9+oLo8U9gAFCKAkErTkaQ7Sa3ruothFbls8fbDBSoghuUu0UZQE
         1q9PDC1RmQhLYoMzf74qe5z4DTwQGS/UUF+wSA/8+2WoECzau+h2tAUPendp1NQ1z2
         wNp6L4QnikeUl4LBhd7OrNMKwd0c66vK7oD4DSrCB5p4k5CMYp8IHwJm8mOgVkE+11
         a8s2MHwKWUarg==
Subject: [PATCH v1 52/52] NFSD: Rename nfsd4_encode_fattr()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 10:02:18 -0400
Message-ID: <169504573893.133720.10007386925698101507.stgit@manet.1015granger.net>
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

For better alignment with the specification, NFSD's encoder function
name should match the name of the XDR data type.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index d7f690a3ea86..e38af124169b 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3470,10 +3470,10 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
  * ourselves.
  */
 static __be32
-nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
-		struct svc_export *exp,
-		struct dentry *dentry, const u32 *bmval,
-		struct svc_rqst *rqstp, int ignore_crossmnt)
+nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
+		    struct svc_fh *fhp, struct svc_export *exp,
+		    struct dentry *dentry, const u32 *bmval,
+		    int ignore_crossmnt)
 {
 	struct nfsd4_fattr_args args;
 	struct svc_fh *tempfh = NULL;
@@ -3582,11 +3582,13 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	}
 #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
 
+	/* attrmask */
 	status = nfsd4_encode_bitmap4(xdr, attrmask[0],
 				      attrmask[1], attrmask[2]);
 	if (status)
 		goto out;
 
+	/* attr_vals */
 	attrlen_offset = xdr->buf->len;
 	attrlen_p = xdr_reserve_space(xdr, XDR_UNIT);
 	if (!attrlen_p)
@@ -3646,8 +3648,8 @@ __be32 nfsd4_encode_fattr_to_buf(__be32 **p, int words,
 	__be32 ret;
 
 	svcxdr_init_encode_from_buffer(&xdr, &dummy, *p, words << 2);
-	ret = nfsd4_encode_fattr(&xdr, fhp, exp, dentry, bmval, rqstp,
-							ignore_crossmnt);
+	ret = nfsd4_encode_fattr4(rqstp, &xdr, fhp, exp, dentry, bmval,
+				  ignore_crossmnt);
 	*p = xdr.p;
 	return ret;
 }
@@ -3706,8 +3708,8 @@ nfsd4_encode_dirent_fattr(struct xdr_stream *xdr, struct nfsd4_readdir *cd,
 
 	}
 out_encode:
-	nfserr = nfsd4_encode_fattr(xdr, NULL, exp, dentry, cd->rd_bmval,
-					cd->rd_rqstp, ignore_crossmnt);
+	nfserr = nfsd4_encode_fattr4(cd->rd_rqstp, xdr, NULL, exp, dentry,
+				     cd->rd_bmval, ignore_crossmnt);
 out_put:
 	dput(dentry);
 	exp_put(exp);
@@ -3951,8 +3953,9 @@ nfsd4_encode_getattr(struct nfsd4_compoundres *resp, __be32 nfserr,
 	struct svc_fh *fhp = getattr->ga_fhp;
 	struct xdr_stream *xdr = resp->xdr;
 
-	return nfsd4_encode_fattr(xdr, fhp, fhp->fh_export, fhp->fh_dentry,
-				    getattr->ga_bmval, resp->rqstp, 0);
+	/* obj_attributes */
+	return nfsd4_encode_fattr4(resp->rqstp, xdr, fhp, fhp->fh_export,
+				   fhp->fh_dentry, getattr->ga_bmval, 0);
 }
 
 static __be32


