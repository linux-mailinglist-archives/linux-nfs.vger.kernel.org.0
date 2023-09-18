Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFFA7A4B8F
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjIRPSt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjIRPSo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:18:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA231A3
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:17:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B7AC116A7;
        Mon, 18 Sep 2023 13:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045530;
        bh=LDzmDY9+OVIwkq/9CVMxOdGFPlemS8fqVm2t+0gQaB0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CKGICMAAxl/F5BFoW/1LyFwyMJVrSBcHlL4yW5PaZBMgag2+qXeBZefz/tqidGq6g
         QbnaNTdF6P0eumhz2RcpqAvLQPJi9l08fVb/e64ZqfXhnYi3ohFIZobIja/3HmsHfP
         EHIUw9Woz64+ZgRuyXcPEfvBA56ojxnmShpuGhDfwMZabjQyvM3PVvoKmZgXree0M1
         7YZuZ3hBkMtRDjsvsuHJLx3zPv0d1bi5lK8edVkOPug0JbcjwZ4RJznzalvtDGCCbz
         MrEZq7mAkkR5zHhm02ydcgvdWQ3IMFJ4n5ZtzzxprcpkMoNYQ7tpI5BijcNKZxshvS
         RqH+K7ZyvjHRw==
Subject: [PATCH v1 19/52] NFSD: Add nfsd4_encode_fattr4_fileid()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 09:58:49 -0400
Message-ID: <169504552923.133720.14141060340723098538.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_FILEID into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 17997bf08139..e3dd05f8d28f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3136,6 +3136,12 @@ static __be32 nfsd4_encode_fattr4_filehandle(struct xdr_stream *xdr,
 	return nfsd4_encode_nfs_fh4(xdr, &args->fhp->fh_handle);
 }
 
+static __be32 nfsd4_encode_fattr4_fileid(struct xdr_stream *xdr,
+					 const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_uint64_t(xdr, args->stat.ino);
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3355,10 +3361,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_FILEID) {
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-			goto out_resource;
-		p = xdr_encode_hyper(p, args.stat.ino);
+		status = nfsd4_encode_fattr4_fileid(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_FILES_AVAIL) {
 		p = xdr_reserve_space(xdr, 8);


