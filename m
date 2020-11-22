Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12052BC961
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Nov 2020 21:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgKVUwf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 22 Nov 2020 15:52:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:57506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbgKVUwe (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 22 Nov 2020 15:52:34 -0500
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBDFD20789
        for <linux-nfs@vger.kernel.org>; Sun, 22 Nov 2020 20:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606078354;
        bh=c/0iloXlJvuXHopXEkMeAuwXl/w6X43aVfw+X5EtKmU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZRcny5PgEdyt4DPIT+C/gyHnXXa9uvnEweajRBjcT9VhMkhpRxljGNZcsEhsHJa7x
         nECUYes2VwHJokG7TIP7T+GndqZFwqKQmN0u9rycBxO2DRt+ntfwORUa2khMKmUP+5
         5F9ZUJsmssj61S6jlM5Z3Z8U8K3wa9JIUtbCHyNM=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/8] NFSv4: Fix the alignment of page data in the getdeviceinfo reply
Date:   Sun, 22 Nov 2020 15:52:22 -0500
Message-Id: <20201122205229.3826-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201122205229.3826-1-trondmy@kernel.org>
References: <20201122205229.3826-1-trondmy@kernel.org>
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
index c6dbfcae7517..9913aec3ee32 100644
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
 
-- 
2.28.0

