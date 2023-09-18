Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AE67A4BA2
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjIRPTz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjIRPTz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:19:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA591B1
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:17:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6F2C116AA;
        Mon, 18 Sep 2023 13:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045549;
        bh=2tTiLWjSE0xTFsPSbpcVZBTqanE16fMKfgbZbzhmOI4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=scbRAqURoKU3q+/txUObmUjjEg4CG4/eWFVH8QNsJ/xnQupPLCmFEl7ZO8oJ7C6ZF
         xowMNHrW+MeVJLGaY7jLnAlZXGzit6jUp1ZnL5RENQyd+olbgmKZQFdJqL3YtTOKs0
         1kAPfZbK27gr7hHUhxBYxZ/5YKeIe6URWriV0e3J1obHo/8rH9eBpy/Uft58p6yFTB
         4c0k8fI9jONU0v0GmCNQec1u15LJGfAP+uh2oegwH+e6v9oA4lsMxfsG28dQi89aRj
         z/ysqtETBQ5+dXrPs/GRAQHD5aB5Ljcyt5nIQrZ7kiHVDdiEFZz2xuFJt2APdaH0NL
         dbGD99oeUUO/A==
Subject: [PATCH v1 22/52] NFSD: Add nfsd4_encode_fattr4_files_total()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 09:59:08 -0400
Message-ID: <169504554835.133720.17294133416349563907.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_FILES_TOTAL into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index ee5fd6ff12e0..e024742abc73 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3154,6 +3154,12 @@ static __be32 nfsd4_encode_fattr4_files_free(struct xdr_stream *xdr,
 	return nfsd4_encode_uint64_t(xdr, args->statfs.f_ffree);
 }
 
+static __be32 nfsd4_encode_fattr4_files_total(struct xdr_stream *xdr,
+					      const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_uint64_t(xdr, args->statfs.f_files);
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3388,10 +3394,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_FILES_TOTAL) {
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-			goto out_resource;
-		p = xdr_encode_hyper(p, (u64) args.statfs.f_files);
+		status = nfsd4_encode_fattr4_files_total(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_FS_LOCATIONS) {
 		status = nfsd4_encode_fs_locations(xdr, rqstp, exp);


