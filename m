Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68ABD7A4BD3
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbjIRPWn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239886AbjIRPWk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:22:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6221709
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:20:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F611C116AD;
        Mon, 18 Sep 2023 13:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045574;
        bh=WZ61rQvfdYA+C3Bp6913SfYWN/RR9drvMnAlL1DR2HY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rC8uv7ZbOUDfZ7ektzt8mguAnz71VYQakFU+O9PpECz71wK4MoVRFEpEcgZbPpqnT
         khT8IJ9L48VzADeawHX3LvKWL1gxGD9EhU70O8T4Kvl6UnS25ZSWJHq8777+GYVUDH
         btBSUfq1ff4rdUPfe8t/hFlc+P4XTvJ8bZBrhO61FnlpUOtPmy+Qi0JzqxEgIgBxd3
         n+6VCsgK2ruF+L9xkCU5TDOUqIOOgcGNyJRg1MLOXpNyRwgcTAIZX9v0EtvPaE2+61
         A0z4A6iZwmH214FdSbOk0ynuab4l31ouFpM2hKjFGeKkBRcVdblS1UPAvQofSZvK/d
         jkTzgoHNEPl+A==
Subject: [PATCH v1 26/52] NFSD: Add nfsd4_encode_fattr4_maxname()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 09:59:33 -0400
Message-ID: <169504557361.133720.1521968664950334982.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_MAXNAME into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 05d3b4409d03..546879759c71 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3164,6 +3164,12 @@ static __be32 nfsd4_encode_fattr4_maxlink(struct xdr_stream *xdr,
 	return nfsd4_encode_uint32_t(xdr, 255);
 }
 
+static __be32 nfsd4_encode_fattr4_maxname(struct xdr_stream *xdr,
+					  const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_uint32_t(xdr, args->statfs.f_namelen);
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3423,10 +3429,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_MAXNAME) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(args.statfs.f_namelen);
+		status = nfsd4_encode_fattr4_maxname(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_MAXREAD) {
 		p = xdr_reserve_space(xdr, 8);


