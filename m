Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD027A4C1D
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbjIRP0g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbjIRP0e (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:26:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E479D
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:23:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26911C116D5;
        Mon, 18 Sep 2023 14:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045689;
        bh=LKBwjOs5grznuP43WvwJlJfLxSIlS02lg4NcoKyC+TA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=S3T+xOqY2NM2QCbUSr0n6i3evymGAuXxcZdBZsSCPgwhokl3EQ6gAO+m6GyvLS6Yc
         bwiajfhm7wR9enODPcJe4gp6/NsHZK8HOzWNXlrq2rCp11nt2rz0qUuNZObU9D/DP6
         lxXJQUEi0P8zUcWnHVSXz5AvbYZ1GFF9GFQDA9HKsPE6iFnh2uIElee+0fZ7mGhtms
         Fb9TSpVe+gtK1YCEv4gN7gjiu5ae0UZxVxFGfBlCHNstYq3hLTBvTNLuihRkb1odVu
         tUq8AQnE+tLDHg/Mn2KmLmoRVvo+8dpfBhpmpVDMUZHAolkXyVuHeyqBvURXK7qBaG
         B4SQJYqptHf1g==
Subject: [PATCH v1 44/52] NFSD: Add nfsd4_encode_fattr4_fs_layout_types()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 10:01:28 -0400
Message-ID: <169504568820.133720.7893935930026220174.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_FS_LAYOUT_TYPES into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 929be84482b9..d67fa4b2a2f6 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3292,6 +3292,28 @@ static __be32 nfsd4_encode_fattr4_mounted_on_fileid(struct xdr_stream *xdr,
 	return nfsd4_encode_uint64_t(xdr, ino);
 }
 
+#ifdef CONFIG_NFSD_PNFS
+
+static __be32 nfsd4_encode_fattr4_fs_layout_types(struct xdr_stream *xdr,
+						  const struct nfsd4_fattr_args *args)
+{
+	unsigned long mask = args->exp->ex_layout_types;
+	int i;
+
+	/* Hamming weight of @mask is the number of layout types to return */
+	if (xdr_stream_encode_u32(xdr, hweight_long(mask)) != XDR_UNIT)
+		return nfserr_resource;
+	for (i = LAYOUT_NFSV4_1_FILES; i < LAYOUT_TYPE_MAX; ++i)
+		if (mask & BIT(i)) {
+			/* layouttype4 */
+			if (xdr_stream_encode_u32(xdr, i) != XDR_UNIT)
+				return nfserr_resource;
+		}
+	return nfs_ok;
+}
+
+#endif
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3647,7 +3669,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	}
 #ifdef CONFIG_NFSD_PNFS
 	if (bmval1 & FATTR4_WORD1_FS_LAYOUT_TYPES) {
-		status = nfsd4_encode_layout_types(xdr, exp->ex_layout_types);
+		status = nfsd4_encode_fattr4_fs_layout_types(xdr, &args);
 		if (status)
 			goto out;
 	}


