Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F617A4F46
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 18:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjIRQhR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 12:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjIRQhF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 12:37:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD8A10EC
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 09:32:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE2AC116C8;
        Mon, 18 Sep 2023 14:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045644;
        bh=nz7M/7fJkXOEKpIQBL+96nYyjmhMOTogIENkPcpowQ8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jesLm3b5ZD4i5szll0qSiOeV5f0yghCJAUQaishEfFg+UdOsmVS/UPnQHGFH2U94s
         iwqMci6x2LbByzTnyR1lzgYW9+CMhJAH8aPoW1+tq/5eznrTcwUIPGz5ks0IH0x+AB
         OvRKdYB+MmbaRqFESsZwmvPIESFE/nWGIeM4nJ1FTMcYCNJ6yIK3e7VjYfTZdZotD+
         xxz3GAzjLXeNjzAQaPd8QLFDP6JCplmW0kYERl8Rwkp2QHpvFltgJ65hoXU79L3d11
         6B9gStvVV8FukF4tXhuP7pO7+1LzV8//EemsH4cSWnn5VMk/md6ME/D++LTweAbfeY
         yoVVdO+fwo7gQ==
Subject: [PATCH v1 37/52] NFSD: Add nfsd4_encode_fattr4_space_used()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 10:00:43 -0400
Message-ID: <169504564361.133720.14162626952512302812.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_SPACE_USED into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 963fa2ccadd7..80be20217402 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3248,6 +3248,12 @@ static __be32 nfsd4_encode_fattr4_space_total(struct xdr_stream *xdr,
 	return nfsd4_encode_uint64_t(xdr, total);
 }
 
+static __be32 nfsd4_encode_fattr4_space_used(struct xdr_stream *xdr,
+					     const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_uint64_t(xdr, (u64)args->stat.blocks << 9);
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3266,7 +3272,6 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	__be32 *p, *attrlen_p;
 	int starting_len = xdr->buf->len;
 	int attrlen_offset;
-	u64 dummy64;
 	__be32 status;
 	int err;
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
@@ -3567,11 +3572,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_SPACE_USED) {
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-			goto out_resource;
-		dummy64 = (u64)args.stat.blocks << 9;
-		p = xdr_encode_hyper(p, dummy64);
+		status = nfsd4_encode_fattr4_space_used(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_TIME_ACCESS) {
 		status = nfsd4_encode_nfstime4(xdr, &args.stat.atime);


