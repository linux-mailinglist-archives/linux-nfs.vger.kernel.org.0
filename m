Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BC22B879D
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Nov 2020 23:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgKRWTo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Nov 2020 17:19:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:43816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbgKRWTo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 18 Nov 2020 17:19:44 -0500
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67C30246DC
        for <linux-nfs@vger.kernel.org>; Wed, 18 Nov 2020 22:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605737983;
        bh=6FAbLUMvbSCaMd3AP27b9h+X44wBrrfP4SPYACnVtxw=;
        h=From:To:Subject:Date:From;
        b=bTSS24nfwy1kGikqN8tk4e4Txf/F5I6G2+YCI5fXh5DuD+JNrfd3xK6JvT1QQblr8
         GB2A88zPG7f0nYifsx35SJfFMMvIM3oE2CQEijs92Jtr5ndntrCp3OJizIj+zy1a3M
         DGYU3LWp1CFXpHkkzooAhd/dr7KleUnWj4Eix66Q=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFSv4: Fix the alignment of page data in the getdeviceinfo reply
Date:   Wed, 18 Nov 2020 17:19:37 -0500
Message-Id: <20201118221939.20715-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We can fit the device_addr4 opaque data padding in the pages.

Fixes: cf500bac8fd4 ("SUNRPC: Introduce rpc_prepare_reply_pages()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4xdr.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index c6dbfcae7517..c8714381d511 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -3009,15 +3009,19 @@ static void nfs4_xdr_enc_getdeviceinfo(struct rpc_rqst *req,
 	struct compound_hdr hdr = {
 		.minorversion = nfs4_xdr_minorversion(&args->seq_args),
 	};
+	uint32_t replen;
 
 	encode_compound_hdr(xdr, req, &hdr);
 	encode_sequence(xdr, &args->seq_args, &hdr);
+
+	replen = hdr.replen + op_decode_hdr_maxsz;
+
 	encode_getdeviceinfo(xdr, args, &hdr);
 
-	/* set up reply kvec. Subtract notification bitmap max size (2)
-	 * so that notification bitmap is put in xdr_buf tail */
+	/* set up reply kvec. device_addr4 opaque data is read into the
+	 * pages */
 	rpc_prepare_reply_pages(req, args->pdev->pages, args->pdev->pgbase,
-				args->pdev->pglen, hdr.replen - 2);
+				args->pdev->pglen, replen + 2);
 	encode_nops(&hdr);
 }
 
@@ -5848,7 +5852,9 @@ static int decode_getdeviceinfo(struct xdr_stream *xdr,
 	 * and places the remaining xdr data in xdr_buf->tail
 	 */
 	pdev->mincount = be32_to_cpup(p);
-	if (xdr_read_pages(xdr, pdev->mincount) != pdev->mincount)
+	/* Calculate padding */
+	len = xdr_align_size(pdev->mincount);
+	if (xdr_read_pages(xdr, len) != len)
 		return -EIO;
 
 	/* Parse notification bitmap, verifying that it is zero. */
-- 
2.28.0

