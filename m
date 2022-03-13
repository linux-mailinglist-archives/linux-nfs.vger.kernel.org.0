Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7E74D7719
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Mar 2022 18:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbiCMRNU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 13 Mar 2022 13:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbiCMRNT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 13 Mar 2022 13:13:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8A6139CEB
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 10:12:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79F84B80CD7
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E862BC340F4
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647191528;
        bh=TOS0XCwLf/WnsgOrHUiGoZpLs1RPW2/+yir76Ac/O78=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=crAjlvQ7ihe2jgXhOHBv6MEYSUnjtWuAcyw0ybwnin1tjBxBk67Atra4IeFNC+XW7
         06ulrixa4ypR6m3nT19o5HgHo3HYdQZoJ9ARnQB+IgO1rAXQWBpmlN0bSxhQNEKplP
         5sbApUUR3La5Ur+CGKUMDY3uETdAtpI7TvdYA9GYnlppHeBnwBhs788XpDb03AhqqT
         ncaqj8IfJusSpfMD1MB91lcVtDZjqgKgaxe7rwWby/Xy8vpNdpn5E5uUqJ4iYJvCrk
         fPqJ8vJtroaF3HpIb4hXJXTC+FU3PBi88WBxL0aMLcLQjv92G1EI3rhrHrvPXL5qUO
         J9uo33IXq+GJg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 11/26] NFS: If the cookie verifier changes, we must invalidate the page cache
Date:   Sun, 13 Mar 2022 13:05:42 -0400
Message-Id: <20220313170557.5940-12-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220313170557.5940-11-trondmy@kernel.org>
References: <20220313170557.5940-1-trondmy@kernel.org>
 <20220313170557.5940-2-trondmy@kernel.org>
 <20220313170557.5940-3-trondmy@kernel.org>
 <20220313170557.5940-4-trondmy@kernel.org>
 <20220313170557.5940-5-trondmy@kernel.org>
 <20220313170557.5940-6-trondmy@kernel.org>
 <20220313170557.5940-7-trondmy@kernel.org>
 <20220313170557.5940-8-trondmy@kernel.org>
 <20220313170557.5940-9-trondmy@kernel.org>
 <20220313170557.5940-10-trondmy@kernel.org>
 <20220313170557.5940-11-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 520dc3ec4aef..9998d7d17367 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -990,9 +990,14 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
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

