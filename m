Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6688D7A4C0D
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbjIRPZb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbjIRPZa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:25:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209A510B
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:22:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBEBC116B7;
        Mon, 18 Sep 2023 14:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045619;
        bh=neirfrnQbQuonWQbTaGfXOUbDRFNitlMukdByJdYq/M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OK7D7e1hTzAvjwhRoWXb3Zj5GPgCbxRyLT1ZvJYooS5/H1B51DsoXE11Dx3nQxHcE
         E0AneDJ/+31sI6LbTlIN7X2NjQ/pzsCdR9c4BowABZSEsrVLkJBkJlCAi949iILqnG
         013fJrmRdsp3+eb6wWlnhAu3FtzOU1LHFS9yMRLr2JWZ1RUP/YwZIeoxUAvHAbdI9E
         J6IkA9hbVEXMK9LuQHpb3nKMvo3nNf6J7wKXdZ5DFIsVGSI7rAuuwX/sPWjt8Jz575
         dn81D9R0YITA2kltBKVjrY6+xCxILF3ChXf2u3bi+PQntPXHItJT6CHoOM64yn7DzA
         ExgqfOAZnxp2g==
Subject: [PATCH v1 33/52] NFSD: Add nfsd4_encode_fattr4_rawdev()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 10:00:18 -0400
Message-ID: <169504561813.133720.13629335937477563549.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_RAWDEV into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 91ac991dea9d..146ac641ef8e 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2550,6 +2550,17 @@ static __be32 nfsd4_encode_nfstime4(struct xdr_stream *xdr,
 	return nfs_ok;
 }
 
+static __be32 nfsd4_encode_specdata4(struct xdr_stream *xdr,
+				     unsigned int major, unsigned int minor)
+{
+	__be32 status;
+
+	status = nfsd4_encode_uint32_t(xdr, major);
+	if (status != nfs_ok)
+		return status;
+	return nfsd4_encode_uint32_t(xdr, minor);
+}
+
 /*
  * ctime (in NFSv4, time_metadata) is not writeable, and the client
  * doesn't really care what resolution could theoretically be stored by
@@ -3206,6 +3217,13 @@ static __be32 nfsd4_encode_fattr4_owner_group(struct xdr_stream *xdr,
 	return nfsd4_encode_group(xdr, args->rqstp, args->stat.gid);
 }
 
+static __be32 nfsd4_encode_fattr4_rawdev(struct xdr_stream *xdr,
+					 const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_specdata4(xdr, MAJOR(args->stat.rdev),
+				      MINOR(args->stat.rdev));
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3505,11 +3523,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_RAWDEV) {
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32((u32) MAJOR(args.stat.rdev));
-		*p++ = cpu_to_be32((u32) MINOR(args.stat.rdev));
+		status = nfsd4_encode_fattr4_rawdev(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_SPACE_AVAIL) {
 		p = xdr_reserve_space(xdr, 8);


