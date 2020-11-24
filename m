Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBD82C28AC
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Nov 2020 14:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388577AbgKXNu2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 08:50:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:44664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388573AbgKXNu2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Nov 2020 08:50:28 -0500
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E2A920872
        for <linux-nfs@vger.kernel.org>; Tue, 24 Nov 2020 13:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606225827;
        bh=se7XLYKnaL7z6T64CNSBIx1o/gPTC/p+Z7BY45ge3Gk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VXOItgnjENGRapQXo6h6zjXXCeZfgivDWTCq8YxboSPlt57ctFi8u6jE4VwnOQOpn
         P5NnYnuf4gPkqsF5NMa/hBFNaG3M2B68Afhiqp3i7JdTz5lM+w9C6TD1g98NQPPnnf
         O9FQeSaIKUzLUJG1f0qRa0LljS71fjNY++Ys7DOE=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/9] NFSv4: Fix the alignment of page data in the getdeviceinfo reply
Date:   Tue, 24 Nov 2020 08:50:17 -0500
Message-Id: <20201124135025.1097571-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201124135025.1097571-1-trondmy@kernel.org>
References: <20201124135025.1097571-1-trondmy@kernel.org>
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
 fs/nfs/nfs4xdr.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index c6dbfcae7517..c16b93df1bc1 100644
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
+				args->pdev->pglen, replen + 2 + 1);
 	encode_nops(&hdr);
 }
 
-- 
2.28.0

