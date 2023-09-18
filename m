Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F697A4C0F
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjIRPZk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbjIRPZk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:25:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE00119
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:23:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD52BC116B8;
        Mon, 18 Sep 2023 14:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045632;
        bh=0rA61je4MVgM+7olbkTsgnOxdL1bTPc/psNMqineibA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=vLameYeYZKkvr2FaL2F33anrv1iCF+5g5BozyuHTXjF6StmcIBN9O9A0gio/jphcv
         Z8Do6htFs1g8ebHkBOE1bZODoB/j35LV3KjkmA62AAdNurbNGNe2UEFV08jbSPz6GC
         KEP5okifcHp1wB6gsBvo7Hoj/LvUUjuU98JW1OQKpn6qLt2zCCo5wUE3szft5imyk7
         nm18RBTY/8NRwtRUIDuiDeioRQcCWjcxFhu60LQYxmuiUgKInmvinhvyAUW2X5DcWb
         xKnDwt87dAvOhsvsfhkhQMOfDifLkvs3dn2zq7y/hw+Bxvl+3ub8tMbBUAc+4VIftu
         N9Ub6l4cMvORQ==
Subject: [PATCH v1 35/52] NFSD: Add nfsd4_encode_fattr4_space_free()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 10:00:30 -0400
Message-ID: <169504563082.133720.7559115861114168422.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_SPACE_FREE into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 42ce95b8db43..a9f99f07c904 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3232,6 +3232,14 @@ static __be32 nfsd4_encode_fattr4_space_avail(struct xdr_stream *xdr,
 	return nfsd4_encode_uint64_t(xdr, avail);
 }
 
+static __be32 nfsd4_encode_fattr4_space_free(struct xdr_stream *xdr,
+					     const struct nfsd4_fattr_args *args)
+{
+	u64 free = (u64)args->statfs.f_bfree * (u64)args->statfs.f_bsize;
+
+	return nfsd4_encode_uint64_t(xdr, free);
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3541,11 +3549,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_SPACE_FREE) {
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-			goto out_resource;
-		dummy64 = (u64)args.statfs.f_bfree * (u64)args.statfs.f_bsize;
-		p = xdr_encode_hyper(p, dummy64);
+		status = nfsd4_encode_fattr4_space_free(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_SPACE_TOTAL) {
 		p = xdr_reserve_space(xdr, 8);


