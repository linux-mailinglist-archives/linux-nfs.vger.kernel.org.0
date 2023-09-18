Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD127A4C2C
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjIRP1u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjIRP1T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:27:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02EE19BA
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:24:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CCE2C116D6;
        Mon, 18 Sep 2023 14:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045695;
        bh=E8m7IBAU38rUn/tzgzdGVKAGGb/FUXzES+W+Yuv2ErU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=b3SM/ChNoVguyh4RGdM3852LQuRWb0imjkWqYU+oMAio2xeoisKhEJZ+aU5+grLx1
         +Mus/6EadyADISGbLDc71vJmvjwBnzzwwzTmWbLryNoFW5frxmrFir32XOqqu3W4UQ
         7BlJ+cCh0GQVtBl0hGAB3/eL+oG5u3AOV0olrVNRCoRZUy4aFA9iShxUKs0DS98kCw
         HqJhOEvfwYNHS3qYHQZau3ZSrt9CNOSu387yl1BNBmJ4x5kY659BYskGfBCdC53Kpa
         61iUq5x/1P60AltrRC5HLITGh40ewNpm1mfS1jXMs6KARwNe06Oevg9WI+mzkQ0Ltf
         Vk9gwzFGLFCNw==
Subject: [PATCH v1 45/52] NFSD: Add nfsd4_encode_fattr4_layout_types()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 10:01:34 -0400
Message-ID: <169504569453.133720.12458816197833544713.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_LAYOUT_TYPES into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index d67fa4b2a2f6..bc0b5bc3e655 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2784,25 +2784,6 @@ static __be32 nfsd4_encode_nfsace4(struct xdr_stream *xdr, struct svc_rqst *rqst
 	return nfsd4_encode_user(xdr, rqstp, ace->who_uid);
 }
 
-static inline __be32
-nfsd4_encode_layout_types(struct xdr_stream *xdr, u32 layout_types)
-{
-	__be32		*p;
-	unsigned long	i = hweight_long(layout_types);
-
-	p = xdr_reserve_space(xdr, 4 + 4 * i);
-	if (!p)
-		return nfserr_resource;
-
-	*p++ = cpu_to_be32(i);
-
-	for (i = LAYOUT_NFSV4_1_FILES; i < LAYOUT_TYPE_MAX; ++i)
-		if (layout_types & (1 << i))
-			*p++ = cpu_to_be32(i);
-
-	return 0;
-}
-
 #define WORD0_ABSENT_FS_ATTRS (FATTR4_WORD0_FS_LOCATIONS | FATTR4_WORD0_FSID | \
 			      FATTR4_WORD0_RDATTR_ERROR)
 #define WORD1_ABSENT_FS_ATTRS FATTR4_WORD1_MOUNTED_ON_FILEID
@@ -3312,6 +3293,24 @@ static __be32 nfsd4_encode_fattr4_fs_layout_types(struct xdr_stream *xdr,
 	return nfs_ok;
 }
 
+static __be32 nfsd4_encode_fattr4_layout_types(struct xdr_stream *xdr,
+					       const struct nfsd4_fattr_args *args)
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
 #endif
 
 /*
@@ -3675,7 +3674,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	}
 
 	if (bmval2 & FATTR4_WORD2_LAYOUT_TYPES) {
-		status = nfsd4_encode_layout_types(xdr, exp->ex_layout_types);
+		status = nfsd4_encode_fattr4_layout_types(xdr, &args);
 		if (status)
 			goto out;
 	}


