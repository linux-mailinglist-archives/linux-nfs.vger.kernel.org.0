Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40AD4C1D90
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 22:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242449AbiBWVUF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 16:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242415AbiBWVUD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 16:20:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE45F4ECCD
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 13:19:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69459618A2
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 21:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A63C340F0
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 21:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645651174;
        bh=TwH9XBO4tFY1Wb3RcdoVj19uDIH4r8SdsJDVWUodJrI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XAfoequ8V7zLl/Y/l+KlprCyE2BkvQiwVamyG3NdBbRol2Xm67G163q6Vn6h7MFTL
         i1kqHHM+h7hr+nYdFVkMuqFLcisTVkAQI1hzvIgVL4cvSgY4ZVJNEgRmnJtwX8HPzT
         v2Z/yOYR1FSEbmfmIdnuVIuFJxPsZEtSqx/5xT+H36aZb3F6+LmXj0dF3Lasgs3mxQ
         ZlplR2EBhb2wHLL3VftZWm003YyLCag9MeybNag2zxwvFRmDRDc9UloM45DTWkTjva
         pWj4BPcNAHY4YWel4Il+l9eFt8/mU8ZRM9qn3BMsqnxwEp7rk4xN1IjmlDlQnJ4AtX
         VDCWCh8bX7rxg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 06/21] NFS: If the cookie verifier changes, we must invalidate the page cache
Date:   Wed, 23 Feb 2022 16:12:50 -0500
Message-Id: <20220223211305.296816-7-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220223211305.296816-6-trondmy@kernel.org>
References: <20220223211305.296816-1-trondmy@kernel.org>
 <20220223211305.296816-2-trondmy@kernel.org>
 <20220223211305.296816-3-trondmy@kernel.org>
 <20220223211305.296816-4-trondmy@kernel.org>
 <20220223211305.296816-5-trondmy@kernel.org>
 <20220223211305.296816-6-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that if the cookie verifier changes when we use the zero-valued
cookie, then we invalidate any cached pages.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 5d9367d9b651..7932d474ce00 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -945,9 +945,14 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 		/*
 		 * Set the cookie verifier if the page cache was empty
 		 */
-		if (desc->page_index == 0)
+		if (desc->last_cookie == 0 &&
+		    memcmp(nfsi->cookieverf, verf, sizeof(nfsi->cookieverf))) {
 			memcpy(nfsi->cookieverf, verf,
 			       sizeof(nfsi->cookieverf));
+			invalidate_inode_pages2_range(desc->file->f_mapping,
+						      desc->page_index_max + 1,
+						      -1);
+		}
 	}
 	res = nfs_readdir_search_array(desc);
 	if (res == 0)
-- 
2.35.1

