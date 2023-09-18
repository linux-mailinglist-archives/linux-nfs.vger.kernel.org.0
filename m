Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD387A4F90
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 18:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjIRQqI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 12:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjIRQp4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 12:45:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7F02D49
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 09:37:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FFAC4163D;
        Mon, 18 Sep 2023 13:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045460;
        bh=qx9Amc4/EpzHEUVIFiDXrdm8bUDFLkxqj4++LgT6vLI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qFM3zQSJYzUIdbtOgrMYzJ/oEITRolLjcysEdEDSSy2e/OR16p4/XpApmwiH5F9tu
         bvlKq442EwtcBnPsdGE4nf9uJNhHnVMOYsnd2jl4pe4JcnF8edd4vz/38G7Bze9KSO
         lWodNVS8UWqLKRtS0Mf6H0IBwpYSXdnbN+L4D/hbcv97pGeZScOMeNwmOGGTjB+0qh
         TXRrrklgRmUM2t310LsP/ycDrkBFgR/YTOQnNHCCtHIFv36b/4EM5cRAE28XEfqKiQ
         HLHoSulH3LcKcs17CNjVZWULeYRe851GSKAlsEX2x5r6xyWTFc0c1ZlmTlE7wPude3
         VpN0nXvaVVJcA==
Subject: [PATCH v1 08/52] NFSD: Add nfsd4_encode_fattr4_type()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 09:57:39 -0400
Message-ID: <169504545905.133720.14224781242740113631.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_TYPE into a helper. In a subsequent
patch, this helper will be called from a bitmask loop.

In addition, restructure the code so that byte-swapping is done on
constant values rather than at run time. Run-time swapping can be
costly on some platforms, and "type" is a frequently-requested
attribute.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   63 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index da5df33cac04..c1dc6810f043 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2792,20 +2792,6 @@ static __be32 nfsd4_encode_fs_locations(struct xdr_stream *xdr,
 	return 0;
 }
 
-static u32 nfs4_file_type(umode_t mode)
-{
-	switch (mode & S_IFMT) {
-	case S_IFIFO:	return NF4FIFO;
-	case S_IFCHR:	return NF4CHR;
-	case S_IFDIR:	return NF4DIR;
-	case S_IFBLK:	return NF4BLK;
-	case S_IFLNK:	return NF4LNK;
-	case S_IFREG:	return NF4REG;
-	case S_IFSOCK:	return NF4SOCK;
-	default:	return NF4BAD;
-	}
-}
-
 static inline __be32
 nfsd4_encode_aclname(struct xdr_stream *xdr, struct svc_rqst *rqstp,
 		     struct nfs4_ace *ace)
@@ -2977,6 +2963,44 @@ static __be32 nfsd4_encode_fattr4_supported_attrs(struct xdr_stream *xdr,
 	return nfsd4_encode_bitmap4(xdr, supp[0], supp[1], supp[2]);
 }
 
+static __be32 nfsd4_encode_fattr4_type(struct xdr_stream *xdr,
+				       const struct nfsd4_fattr_args *args)
+{
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, XDR_UNIT);
+	if (!p)
+		return nfserr_resource;
+
+	switch (args->stat.mode & S_IFMT) {
+	case S_IFIFO:
+		*p = cpu_to_be32(NF4FIFO);
+		break;
+	case S_IFCHR:
+		*p = cpu_to_be32(NF4CHR);
+		break;
+	case S_IFDIR:
+		*p = cpu_to_be32(NF4DIR);
+		break;
+	case S_IFBLK:
+		*p = cpu_to_be32(NF4BLK);
+		break;
+	case S_IFLNK:
+		*p = cpu_to_be32(NF4LNK);
+		break;
+	case S_IFREG:
+		*p = cpu_to_be32(NF4REG);
+		break;
+	case S_IFSOCK:
+		*p = cpu_to_be32(NF4SOCK);
+		break;
+	default:
+		return nfserr_serverfault;
+	}
+
+	return nfs_ok;
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -2995,7 +3019,6 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	__be32 *p, *attrlen_p;
 	int starting_len = xdr->buf->len;
 	int attrlen_offset;
-	u32 dummy;
 	u64 dummy64;
 	__be32 status;
 	int err;
@@ -3107,15 +3130,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_TYPE) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		dummy = nfs4_file_type(args.stat.mode);
-		if (dummy == NF4BAD) {
-			status = nfserr_serverfault;
+		status = nfsd4_encode_fattr4_type(xdr, &args);
+		if (status != nfs_ok)
 			goto out;
-		}
-		*p++ = cpu_to_be32(dummy);
 	}
 	if (bmval0 & FATTR4_WORD0_FH_EXPIRE_TYPE) {
 		p = xdr_reserve_space(xdr, 4);


