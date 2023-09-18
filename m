Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F127A4F47
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 18:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjIRQhR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 12:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjIRQhG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 12:37:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3157171C
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 09:32:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221B8C4166B;
        Mon, 18 Sep 2023 13:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045479;
        bh=KHpYt6z3tDgpzHy2k6y8Y5rZ4ZCZLSs4BRcrSAwGlkc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EV0fF/v3jF+1DbB3Vs3UR40t/KIVW1IUytGrebEaBjjunleXLM8MbsbSoYXEl5Jug
         /P/3M0Y2IyGBKXTPKtiiTfDRlX9qeri2gRq4GkD+SVRPBhsITNCPOcD69G2tdfBZue
         BxE0LfBSTPaUUKAY+DWOpbWvVMACXXrbdtYiisGC+WJeQv4DFyG8p+xPQ3kuaL8Lzd
         +jcuCKgKToF4k+ssvu3jPzNVC1FvWJp6Qs+Uryxx8vitNBL917oh2UA3Jjrh2Y39cH
         nQRjbov0maclfk31O8L1IHOd3r8wXltOMkcJaXHW6AzXODMUV4Rau6gk2i9+dfOZXz
         aKy8/FQF2YMqQ==
Subject: [PATCH v1 11/52] NFSD: Add nfsd4_encode_fattr4_size()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 09:57:58 -0400
Message-ID: <169504547814.133720.4907073026998034966.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_SIZE into a helper. In a subsequent
patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 3149cfcdac35..601b3a0e61d4 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3024,6 +3024,12 @@ static __be32 nfsd4_encode_fattr4_change(struct xdr_stream *xdr,
 	return nfsd4_encode_changeid4(xdr, c);
 }
 
+static __be32 nfsd4_encode_fattr4_size(struct xdr_stream *xdr,
+				       const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_uint64_t(xdr, args->stat.size);
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3169,10 +3175,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_SIZE) {
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-			goto out_resource;
-		p = xdr_encode_hyper(p, args.stat.size);
+		status = nfsd4_encode_fattr4_size(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_LINK_SUPPORT) {
 		status = nfsd4_encode_fattr4__true(xdr, &args);


