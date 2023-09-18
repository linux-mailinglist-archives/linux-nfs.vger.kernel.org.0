Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F2A7A4B90
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjIRPSv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbjIRPSu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:18:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3F11A5
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:17:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FABC116AF;
        Mon, 18 Sep 2023 13:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045587;
        bh=InadVBSo7OT/pmDWDwEtwVs+CXyYxyCgjheZH7QSbIA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QHaM3kdxz9jNVV7LdlmZDIO4pvJNJxrTwP2ZbUGfnpCzumWX0xqNukX27E/wiF/6S
         Bnzsktz3DCO36BFM5m3UeLNx0X32BtlRbGtH8sMAzG4MhcHTsU6vTOMf5lIkCV5y2D
         7k1Xy3Ad7IF747UM61rLQUBr3uQHAsEnW1RZJ4ogz0/lByIgtSG9zhnYHOVnI9lXki
         yZL3fFkfBNChVjyVfrMdeWk+BgTz7fj7wgexFn/7t0DiFFZl65K8AaTvaCRYTnxPE9
         8dk4DkF1BePXGYlGPWsBlZk2piqcarAMOZzrNbT5io+tBDhJ4EbSSXh810DJxQZ/iK
         9rEWG/1yaNTiQ==
Subject: [PATCH v1 28/52] NFSD: Add nfsd4_encode_fattr4_maxwrite()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 09:59:46 -0400
Message-ID: <169504558635.133720.13043616190229667215.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_MAXWRITE into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 35911ecccfbd..39ff6d1bd41d 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3176,6 +3176,12 @@ static __be32 nfsd4_encode_fattr4_maxread(struct xdr_stream *xdr,
 	return nfsd4_encode_uint64_t(xdr, svc_max_payload(args->rqstp));
 }
 
+static __be32 nfsd4_encode_fattr4_maxwrite(struct xdr_stream *xdr,
+					   const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_uint64_t(xdr, svc_max_payload(args->rqstp));
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3445,10 +3451,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_MAXWRITE) {
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-			goto out_resource;
-		p = xdr_encode_hyper(p, (u64) svc_max_payload(rqstp));
+		status = nfsd4_encode_fattr4_maxwrite(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_MODE) {
 		p = xdr_reserve_space(xdr, 4);


