Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB7B4C4DE4
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 19:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbiBYSfW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Feb 2022 13:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbiBYSfQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Feb 2022 13:35:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB18B1AC294
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 10:34:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F9EDB8330E
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6653C340F2
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645814082;
        bh=Pi6QQmcZUZFhmZaJYFwgo7fNTcZupt9kMXmORg1j7EY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=L/xV9kfM0t3ZTuESMdzw92rIPEz+1+I8CGUCOT7j0ACKZ8u2Fy+wvoz8zQwO57SFW
         O9u0bPYyeQJ9dAEZ8USMvO5mEi8v8ToVgQddXphoBBlY47TxHrjlxvuMFqzB5KlW+l
         V8QEAIoYjsjq3vsOLLUejOqko54Ih847a5/wpsOqQ92fPl/7hY2UcbDU9SW3epnkHV
         zaYKrWZrw7A/wiwkT3v23SS0GX9W4PyZ+HszW0LFJS4zdeM+SZW7WRdV0D4tIJldYy
         w18fjFhFQUPFG4jtu4B5NnW2GXiwa0wGYBekExhLmewhS1nKhw9Qi3MN04XU5CwRjL
         AVmk4UN9YTKCA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 15/24] NFSv4: Ask for a full XDR buffer of readdir goodness
Date:   Fri, 25 Feb 2022 13:28:20 -0500
Message-Id: <20220225182829.1236093-16-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225182829.1236093-15-trondmy@kernel.org>
References: <20220225182829.1236093-1-trondmy@kernel.org>
 <20220225182829.1236093-2-trondmy@kernel.org>
 <20220225182829.1236093-3-trondmy@kernel.org>
 <20220225182829.1236093-4-trondmy@kernel.org>
 <20220225182829.1236093-5-trondmy@kernel.org>
 <20220225182829.1236093-6-trondmy@kernel.org>
 <20220225182829.1236093-7-trondmy@kernel.org>
 <20220225182829.1236093-8-trondmy@kernel.org>
 <20220225182829.1236093-9-trondmy@kernel.org>
 <20220225182829.1236093-10-trondmy@kernel.org>
 <20220225182829.1236093-11-trondmy@kernel.org>
 <20220225182829.1236093-12-trondmy@kernel.org>
 <20220225182829.1236093-13-trondmy@kernel.org>
 <20220225182829.1236093-14-trondmy@kernel.org>
 <20220225182829.1236093-15-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Instead of pretending that we know the ratio of directory info vs
readdirplus attribute info, just set the 'dircount' field to the same
value as the 'maxcount' field.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs3xdr.c | 7 ++++---
 fs/nfs/nfs4xdr.c | 6 +++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index 7ab60ad98776..d6779ceeb39e 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -1261,6 +1261,8 @@ static void nfs3_xdr_enc_readdir3args(struct rpc_rqst *req,
 static void encode_readdirplus3args(struct xdr_stream *xdr,
 				    const struct nfs3_readdirargs *args)
 {
+	uint32_t dircount = args->count;
+	uint32_t maxcount = args->count;
 	__be32 *p;
 
 	encode_nfs_fh3(xdr, args->fh);
@@ -1273,9 +1275,8 @@ static void encode_readdirplus3args(struct xdr_stream *xdr,
 	 * readdirplus: need dircount + buffer size.
 	 * We just make sure we make dircount big enough
 	 */
-	*p++ = cpu_to_be32(args->count >> 3);
-
-	*p = cpu_to_be32(args->count);
+	*p++ = cpu_to_be32(dircount);
+	*p = cpu_to_be32(maxcount);
 }
 
 static void nfs3_xdr_enc_readdirplus3args(struct rpc_rqst *req,
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 8e70b92df4cc..b7780b97dc4d 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1605,7 +1605,8 @@ static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_readdir_arg
 		FATTR4_WORD0_RDATTR_ERROR,
 		FATTR4_WORD1_MOUNTED_ON_FILEID,
 	};
-	uint32_t dircount = readdir->count >> 1;
+	uint32_t dircount = readdir->count;
+	uint32_t maxcount = readdir->count;
 	__be32 *p, verf[2];
 	uint32_t attrlen = 0;
 	unsigned int i;
@@ -1618,7 +1619,6 @@ static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_readdir_arg
 			FATTR4_WORD1_SPACE_USED|FATTR4_WORD1_TIME_ACCESS|
 			FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY;
 		attrs[2] |= FATTR4_WORD2_SECURITY_LABEL;
-		dircount >>= 1;
 	}
 	/* Use mounted_on_fileid only if the server supports it */
 	if (!(readdir->bitmask[1] & FATTR4_WORD1_MOUNTED_ON_FILEID))
@@ -1634,7 +1634,7 @@ static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_readdir_arg
 	encode_nfs4_verifier(xdr, &readdir->verifier);
 	p = reserve_space(xdr, 12 + (attrlen << 2));
 	*p++ = cpu_to_be32(dircount);
-	*p++ = cpu_to_be32(readdir->count);
+	*p++ = cpu_to_be32(maxcount);
 	*p++ = cpu_to_be32(attrlen);
 	for (i = 0; i < attrlen; i++)
 		*p++ = cpu_to_be32(attrs[i]);
-- 
2.35.1

