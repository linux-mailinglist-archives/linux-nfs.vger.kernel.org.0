Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9D94931E7
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jan 2022 01:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245274AbiASAcL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jan 2022 19:32:11 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52128 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbiASAcL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jan 2022 19:32:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06AE5B81885
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jan 2022 00:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B16C340E0;
        Wed, 19 Jan 2022 00:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642552328;
        bh=J0p/UyIlrs70MT8vC8z+RQFCLbNv82RinZPlLfIHBEs=;
        h=From:To:Cc:Subject:Date:From;
        b=me3Na73ypidHM0eTRhVE7wtq9DAxeRJH3h+t3Kx6PYOSIl2mPJMCIiCgnGy5u4Yn8
         DMQ58PTP9Z4YF9aJY9uZwMMmRiKF8F//fxsUbQglHpdfhq87Ib1DTBdAG6ONACcwEq
         2vyRrvfqYplvz9izp2+YVnJmCglzFK2qC13L/7PPmsJE8zzaF+tqoOZqr5GDACSuIt
         oGJKLsU20f+65BrztoY27W8C7x2HkeppIMrcXXGPmbQRaGsjC5ta0O9Oy/Nwzo7j2e
         Ke6yS/zhP6BNvxpieI4YJ5/pND8C4/TzsZHvAw11kYH4WBH06Ah7DKazd8Ldwfn8Vo
         EfGq7deBRTxYg==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Don't overfill uncached readdir pages
Date:   Tue, 18 Jan 2022 19:25:42 -0500
Message-Id: <20220119002542.245587-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If we're doing an uncached read of the directory, then we ideally want
to read only the exact set of entries that will fit in the buffer
supplied by the getdents() system call. So unlike the case where we're
reading into the page cache, let's send only one READDIR call, before
trying to fill up the buffer.

Fixes: 35df59d3ef69 ("NFS: Reduce number of RPC calls when doing uncached readdir")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 24ce5652d9be..cbf1a304ca18 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -866,7 +866,8 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
 
 		status = nfs_readdir_page_filler(desc, entry, pages, pglen,
 						 arrays, narrays);
-	} while (!status && nfs_readdir_page_needs_filling(page));
+	} while (!status && nfs_readdir_page_needs_filling(page) &&
+		 page_mapping(page));
 
 	nfs_readdir_free_pages(pages, array_size);
 out:
-- 
2.34.1

