Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842BD7A4BA6
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjIRPUR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjIRPUQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:20:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EF3E75
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:18:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA57C116B9;
        Mon, 18 Sep 2023 14:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045638;
        bh=hmYbnv+NI+RmySPbTF73qcSDypUOl0VihBv0TCZ4oC0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BVegSLdbiUZNX1twat76tJpS7wibnYDQW4+k5DdcvlPkH80SbP6GecyzpKUYo6E3p
         DQ9T1M+jU2vqvsBHIB3TiuWXiDibCgV4f/63zpwMncnfHrcjG76O5Wf0O5DZMlIES/
         yNuDx/dQbKPZYQEp0gRYEYqqYKfRS4s313DQot3vXe4H19AKgHfClQo1sW2p9zri2S
         b2ejjmCufYfZzXBXtDnsybE5e1uUyQrz2iqumKCO3lHIKe+xkHKQZE3Q8Wjxstpegc
         v+keAYaK7btp5RY2G6J73W6HHwXW90u7aPFfzUtSxiR6wDtKHAwEz6zcha200s6z/d
         3ES5Zvee75bpg==
Subject: [PATCH v1 36/52] NFSD: Add nfsd4_encode_fattr4_space_total()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 10:00:37 -0400
Message-ID: <169504563722.133720.16090756244061462044.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_SPACE_TOTAL into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index a9f99f07c904..963fa2ccadd7 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3240,6 +3240,14 @@ static __be32 nfsd4_encode_fattr4_space_free(struct xdr_stream *xdr,
 	return nfsd4_encode_uint64_t(xdr, free);
 }
 
+static __be32 nfsd4_encode_fattr4_space_total(struct xdr_stream *xdr,
+					      const struct nfsd4_fattr_args *args)
+{
+	u64 total = (u64)args->statfs.f_blocks * (u64)args->statfs.f_bsize;
+
+	return nfsd4_encode_uint64_t(xdr, total);
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3554,11 +3562,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_SPACE_TOTAL) {
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-			goto out_resource;
-		dummy64 = (u64)args.statfs.f_blocks * (u64)args.statfs.f_bsize;
-		p = xdr_encode_hyper(p, dummy64);
+		status = nfsd4_encode_fattr4_space_total(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_SPACE_USED) {
 		p = xdr_reserve_space(xdr, 8);


