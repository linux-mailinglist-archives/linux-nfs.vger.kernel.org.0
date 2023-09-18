Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B267A4BF5
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240802AbjIRPXz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240711AbjIRPXv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:23:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3238E18D
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:22:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5D2C116A8;
        Mon, 18 Sep 2023 13:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045543;
        bh=c0pK+arqvnDF4Pc2CeR1UNms2aINpfYvH+nnr6+zfDM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GQjXYDVuhFXEaA3gRL64QMByp+SBzN12Jh3YQAfTlOz0pwOdQQ1tlCVCNAKC3BcdV
         bYSb67zJ7sNaSabKJ0YLtghm7ejD83cdz5CJzLkwmjRrxzoA3bkZ1LttokRFL7If/0
         w0eMK+KFKN/3jNw8eHwUyuy0R+YPIohwAYyu4S7bLQ4AEhMmwi/mf0zOlv6ZeAgmro
         ut5Lz7/0g17w0Z78x0Hy0WU7nNiOPlgRh0k0EHmZ6PqV/9or+1i1C4ZXQJMc8zQ6Uh
         gDPkRbgebQ+Sx9VMcSh/q2jHhpTjCJHLIN7PvJJW7i0MfuCvtRs8syZWI4CoSIngVj
         I5vDG2Czullrw==
Subject: [PATCH v1 21/52] NFSD: Add nfsd4_encode_fattr4_files_free()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 09:59:01 -0400
Message-ID: <169504554195.133720.8954634709081256034.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_FILES_FREE into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 737c13c4bf82..ee5fd6ff12e0 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3148,6 +3148,12 @@ static __be32 nfsd4_encode_fattr4_files_avail(struct xdr_stream *xdr,
 	return nfsd4_encode_uint64_t(xdr, args->statfs.f_ffree);
 }
 
+static __be32 nfsd4_encode_fattr4_files_free(struct xdr_stream *xdr,
+					     const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_uint64_t(xdr, args->statfs.f_ffree);
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3377,10 +3383,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_FILES_FREE) {
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-			goto out_resource;
-		p = xdr_encode_hyper(p, (u64) args.statfs.f_ffree);
+		status = nfsd4_encode_fattr4_files_free(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_FILES_TOTAL) {
 		p = xdr_reserve_space(xdr, 8);


