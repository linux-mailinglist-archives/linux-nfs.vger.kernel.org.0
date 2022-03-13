Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8F14D771F
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Mar 2022 18:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbiCMRNW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 13 Mar 2022 13:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbiCMRNT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 13 Mar 2022 13:13:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D67D13A1C5
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 10:12:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B967760FDD
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F155BC340E8
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647191530;
        bh=Pi6QQmcZUZFhmZaJYFwgo7fNTcZupt9kMXmORg1j7EY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tkZfC8wvQ6z6m0IjxyizBM8VEEwKY9jZRbxVh0k7wqWbCGHMjoq9Y2Z1rm+umdrhj
         46K2dDgP+t1otq884Zy9pfPcp4MwoQCUAonFkIJMD4ZUT0A4GtMMcx49oPySBwQTpE
         D631Fklv4VPFUeLoCBD1gPs2NBB/vYcTCdWp0nPXzhYl6/pq6I0rPYYWKfoUYEIBWc
         ABmVUEqjE83R4NedTt1fW3kqqQ7ckqu/BkfgaprLjftDUEQmyWe5jnGbXCr47K5bZU
         x1V+jIs/EWNGhsbV+aCXvYMG27WovUpDj1PwKbju6NpQsEu+3H/QmsuwY9moFeNMHW
         WQZpV3huD3Nag==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 16/26] NFSv4: Ask for a full XDR buffer of readdir goodness
Date:   Sun, 13 Mar 2022 13:05:47 -0400
Message-Id: <20220313170557.5940-17-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220313170557.5940-16-trondmy@kernel.org>
References: <20220313170557.5940-1-trondmy@kernel.org>
 <20220313170557.5940-2-trondmy@kernel.org>
 <20220313170557.5940-3-trondmy@kernel.org>
 <20220313170557.5940-4-trondmy@kernel.org>
 <20220313170557.5940-5-trondmy@kernel.org>
 <20220313170557.5940-6-trondmy@kernel.org>
 <20220313170557.5940-7-trondmy@kernel.org>
 <20220313170557.5940-8-trondmy@kernel.org>
 <20220313170557.5940-9-trondmy@kernel.org>
 <20220313170557.5940-10-trondmy@kernel.org>
 <20220313170557.5940-11-trondmy@kernel.org>
 <20220313170557.5940-12-trondmy@kernel.org>
 <20220313170557.5940-13-trondmy@kernel.org>
 <20220313170557.5940-14-trondmy@kernel.org>
 <20220313170557.5940-15-trondmy@kernel.org>
 <20220313170557.5940-16-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

