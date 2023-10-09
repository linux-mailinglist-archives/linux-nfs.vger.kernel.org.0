Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244C17BE94F
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Oct 2023 20:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377449AbjJISae (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Oct 2023 14:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377548AbjJISad (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Oct 2023 14:30:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AF99D
        for <linux-nfs@vger.kernel.org>; Mon,  9 Oct 2023 11:30:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051ECC433C8;
        Mon,  9 Oct 2023 18:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696876231;
        bh=JIlB3tyiflJzxYg5dXRDhQGfdHiKDSpiF0IskHBLqOI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MmymIRzrgb/K/m+ytBKFmMRFTjdeClhy5OPHF4BdEuiptWm0klIqLlOOT9aiwFxjI
         RkxMUgtProdGs0CCMP7RGyw8hdXf7DANBTSbLSIiK2354p97RYyd57moK/eP/q124x
         B5elf49gzG7FTpMX/i1TrP/OR59fxCB26prU3qsW2c+Xh03sQv2JhmwxKMGiGBWMG1
         GI4zn0DG3J2OjhdDVSHssp20G7IMioL64vxl+AgFVnrCvzvCBQgvOrvuqWJBtDKTIt
         ImkYEOLRGcLf4GYPMVxS6Bxa7uoywyd42x07Wb3UdbvnCmyeyuy6aVzVyzyF2pe1dV
         3lqavWG/esesQ==
Subject: [PATCH v1 8/8] NFSD: Clean up nfsd4_encode_seek()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 09 Oct 2023 14:30:29 -0400
Message-ID: <169687622974.41382.2552596663702800716.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <169687606447.41382.568611605570999245.stgit@oracle-102.nfsv4bat.org>
References: <169687606447.41382.568611605570999245.stgit@oracle-102.nfsv4bat.org>
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

Use modern XDR encoder utilities.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c87e7c5de592..1961223d2642 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5275,13 +5275,14 @@ nfsd4_encode_seek(struct nfsd4_compoundres *resp, __be32 nfserr,
 		  union nfsd4_op_u *u)
 {
 	struct nfsd4_seek *seek = &u->seek;
-	__be32 *p;
-
-	p = xdr_reserve_space(resp->xdr, 4 + 8);
-	*p++ = cpu_to_be32(seek->seek_eof);
-	p = xdr_encode_hyper(p, seek->seek_pos);
+	struct xdr_stream *xdr = resp->xdr;
 
-	return 0;
+	/* sr_eof */
+	nfserr = nfsd4_encode_bool(xdr, seek->seek_eof);
+	if (nfserr != nfs_ok)
+		return nfserr;
+	/* sr_offset */
+	return nfsd4_encode_offset4(xdr, seek->seek_pos);
 }
 
 static __be32


