Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232D77A4BA7
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjIRPUR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjIRPUQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:20:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F7910DC
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:18:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBC3C116AE;
        Mon, 18 Sep 2023 13:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045568;
        bh=Yegaz6cGZwJJsAj6SZEdsba96jxIHs4Vb/e5LSdFc2w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LJrxFs/OLvszUeCrNZDBg33LCNZFxzysf7E99ijpNYVjYDiM3WAcf9M3IKIwmIvQ7
         6t6I2qEEiS+qR9xL+54KClJJFFxhgq1NXTNXXUuUALV0Yc8kg05j4Efa6HrTu4F6Ku
         nGEQqv3sazGx7XwZFVUzQA6lh/M5TXxdKXIrwVfweNT5FXQ36cz5b5bamo7L+SHeKZ
         g7e4Kb/OMWriNG6uVxN4YL3nUsfXAnOZkHox8ng4bBO9UhfS08a0Dj5T216IVQIRYM
         afWii2ofHpexhaL83w/t45l3cSykjYaFoI4Ld513tA7ymnLGRwscvSMO3DVdsoNml2
         hIvTpydb0uxbA==
Subject: [PATCH v1 25/52] NFSD: Add nfsd4_encode_fattr4_maxlink()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 09:59:27 -0400
Message-ID: <169504556726.133720.8757481551055565977.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_MAXLINK into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index eb7bc713f85c..05d3b4409d03 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3158,6 +3158,12 @@ static __be32 nfsd4_encode_fattr4_maxfilesize(struct xdr_stream *xdr,
 	return nfsd4_encode_uint64_t(xdr, sb->s_maxbytes);
 }
 
+static __be32 nfsd4_encode_fattr4_maxlink(struct xdr_stream *xdr,
+					  const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_uint32_t(xdr, 255);
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3412,10 +3418,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_MAXLINK) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(255);
+		status = nfsd4_encode_fattr4_maxlink(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_MAXNAME) {
 		p = xdr_reserve_space(xdr, 4);


