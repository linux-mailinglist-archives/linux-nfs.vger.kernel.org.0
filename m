Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4E87A4ECF
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 18:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjIRQ1J (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 12:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjIRQ0u (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 12:26:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8BC282B4
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 09:23:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4694C433B9;
        Mon, 18 Sep 2023 13:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045421;
        bh=k+6YGPIKS0IuMgfCBRoQFP48rCzx+pnWcxKtf7hp8f4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HrJ0jriXuu0T/E+JaxTGrgp3sXyOc1igWvxIVPGpQCv1ZtZ48qI2zqRBqDpeEgOIg
         p5PHr0KlJLawSickuVK+ue5YhdsylYnbkAguyl2K7mFmgXnB2wJlLDZqNSk2gCelFZ
         o/QGtUwa8wRXr5hFdt6AxHPBKWQbEVxKd4bNJgS0qleHMxyF61lzExUGufn0EH/u1I
         Bq0mO2KxgGK4SL1oA7ojXdOh19ZyUKEbKT+m2u6yPNZonqOkAQvONz6ORWakijP6JL
         0fdC6fX7W0GNliT4x1qPcibKCu+Xn2QC5WDtnOvF8pcTWUBLf5hXSwLcEEdsSnDWT2
         rMvANJci2kI/A==
Subject: [PATCH v1 02/52] NFSD: Rename nfsd4_encode_bitmap()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 09:57:00 -0400
Message-ID: <169504542064.133720.5075262919655124379.stgit@manet.1015granger.net>
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

For alignment with the specification, the name of NFSD's encoder
function should match the name of the XDR type.

I've also replaced a few "naked integers" with symbolic constants
that better reflect the usage of these values.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 2e40c74d2f72..84df0f36c15b 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2906,12 +2906,12 @@ static int nfsd4_get_mounted_on_ino(struct svc_export *exp, u64 *pino)
 }
 
 static __be32
-nfsd4_encode_bitmap(struct xdr_stream *xdr, u32 bmval0, u32 bmval1, u32 bmval2)
+nfsd4_encode_bitmap4(struct xdr_stream *xdr, u32 bmval0, u32 bmval1, u32 bmval2)
 {
 	__be32 *p;
 
 	if (bmval2) {
-		p = xdr_reserve_space(xdr, 16);
+		p = xdr_reserve_space(xdr, XDR_UNIT * 4);
 		if (!p)
 			goto out_resource;
 		*p++ = cpu_to_be32(3);
@@ -2919,21 +2919,21 @@ nfsd4_encode_bitmap(struct xdr_stream *xdr, u32 bmval0, u32 bmval1, u32 bmval2)
 		*p++ = cpu_to_be32(bmval1);
 		*p++ = cpu_to_be32(bmval2);
 	} else if (bmval1) {
-		p = xdr_reserve_space(xdr, 12);
+		p = xdr_reserve_space(xdr, XDR_UNIT * 3);
 		if (!p)
 			goto out_resource;
 		*p++ = cpu_to_be32(2);
 		*p++ = cpu_to_be32(bmval0);
 		*p++ = cpu_to_be32(bmval1);
 	} else {
-		p = xdr_reserve_space(xdr, 8);
+		p = xdr_reserve_space(xdr, XDR_UNIT * 2);
 		if (!p)
 			goto out_resource;
 		*p++ = cpu_to_be32(1);
 		*p++ = cpu_to_be32(bmval0);
 	}
 
-	return 0;
+	return nfs_ok;
 out_resource:
 	return nfserr_resource;
 }
@@ -3046,7 +3046,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	}
 #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
 
-	status = nfsd4_encode_bitmap(xdr, bmval0, bmval1, bmval2);
+	status = nfsd4_encode_bitmap4(xdr, bmval0, bmval1, bmval2);
 	if (status)
 		goto out;
 
@@ -3443,7 +3443,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		supp[1] &= NFSD_SUPPATTR_EXCLCREAT_WORD1;
 		supp[2] &= NFSD_SUPPATTR_EXCLCREAT_WORD2;
 
-		status = nfsd4_encode_bitmap(xdr, supp[0], supp[1], supp[2]);
+		status = nfsd4_encode_bitmap4(xdr, supp[0], supp[1], supp[2]);
 		if (status)
 			goto out;
 	}
@@ -3802,11 +3802,13 @@ nfsd4_encode_create(struct nfsd4_compoundres *resp, __be32 nfserr,
 	struct nfsd4_create *create = &u->create;
 	struct xdr_stream *xdr = resp->xdr;
 
+	/* cinfo */
 	nfserr = nfsd4_encode_change_info4(xdr, &create->cr_cinfo);
 	if (nfserr)
 		return nfserr;
-	return nfsd4_encode_bitmap(xdr, create->cr_bmval[0],
-			create->cr_bmval[1], create->cr_bmval[2]);
+	/* attrset */
+	return nfsd4_encode_bitmap4(xdr, create->cr_bmval[0],
+				    create->cr_bmval[1], create->cr_bmval[2]);
 }
 
 static __be32
@@ -3944,8 +3946,8 @@ nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr,
 	if (xdr_stream_encode_u32(xdr, open->op_rflags) < 0)
 		return nfserr_resource;
 
-	nfserr = nfsd4_encode_bitmap(xdr, open->op_bmval[0], open->op_bmval[1],
-					open->op_bmval[2]);
+	nfserr = nfsd4_encode_bitmap4(xdr, open->op_bmval[0],
+				      open->op_bmval[1], open->op_bmval[2]);
 	if (nfserr)
 		return nfserr;
 
@@ -4529,14 +4531,14 @@ nfsd4_encode_exchange_id(struct nfsd4_compoundres *resp, __be32 nfserr,
 		break;
 	case SP4_MACH_CRED:
 		/* spo_must_enforce bitmap: */
-		nfserr = nfsd4_encode_bitmap(xdr,
+		nfserr = nfsd4_encode_bitmap4(xdr,
 					exid->spo_must_enforce[0],
 					exid->spo_must_enforce[1],
 					exid->spo_must_enforce[2]);
 		if (nfserr)
 			return nfserr;
 		/* spo_must_allow bitmap: */
-		nfserr = nfsd4_encode_bitmap(xdr,
+		nfserr = nfsd4_encode_bitmap4(xdr,
 					exid->spo_must_allow[0],
 					exid->spo_must_allow[1],
 					exid->spo_must_allow[2]);


