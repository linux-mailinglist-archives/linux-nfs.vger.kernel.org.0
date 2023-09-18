Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C807A4BD6
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbjIRPWr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237604AbjIRPWq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:22:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141B82708
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:18:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A7CC116D7;
        Mon, 18 Sep 2023 14:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045702;
        bh=9Uap5azBaIBKFC7HoUN000H7e4t+ppeDBbqeNKDYR/I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MlQuJdHUZgx7XwN/ET1AcDreILf9acW6gtFMPsxmkWcZAtmp7dx6iTohUelCldiZy
         EoF+3BWCUuQ6pqsD8W11ervbfvrBB6FPZ7pliCeyeKUEsfkv4DWPahxdHXfUVB065J
         Tt0JcaTKnFPLH26JL6yW5hApQ8CXP6aaBDCgNJ7XrO/MGcA5JdRDXqLuOu1tYQiAs+
         fm29KanTDeedK8GbDhUC9oLy4QQyodKdljxxrV0DXz10qB6SmWcPxirS/Xr1Ewmzhx
         YnEA5rGcKuTp93nUeLyqxxeMiDvilcTiT+MB6jrgfo0lgQdDVj2g6TWJUpFIJuJzqp
         lBIdQ+6iIdoug==
Subject: [PATCH v1 46/52] NFSD: Add nfsd4_encode_fattr4_layout_blksize()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 10:01:40 -0400
Message-ID: <169504570088.133720.70116052510788365.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_LAYOUT_BLKSIZE into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index bc0b5bc3e655..aca0301dc949 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3311,6 +3311,12 @@ static __be32 nfsd4_encode_fattr4_layout_types(struct xdr_stream *xdr,
 	return nfs_ok;
 }
 
+static __be32 nfsd4_encode_fattr4_layout_blksize(struct xdr_stream *xdr,
+						 const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_uint32_t(xdr, args->stat.blksize);
+}
+
 #endif
 
 /*
@@ -3680,10 +3686,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	}
 
 	if (bmval2 & FATTR4_WORD2_LAYOUT_BLKSIZE) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(args.stat.blksize);
+		status = nfsd4_encode_fattr4_layout_blksize(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 #endif /* CONFIG_NFSD_PNFS */
 	if (bmval2 & FATTR4_WORD2_SUPPATTR_EXCLCREAT) {


