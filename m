Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DBC4C5FD1
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 00:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbiB0XTT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 27 Feb 2022 18:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbiB0XTQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 27 Feb 2022 18:19:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3892252D
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 15:18:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEE77611DB
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B15CC340F2
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646003918;
        bh=pA00yNVHw9URX5sskZDtMPEKnwD6o9DGbDJRTLW3YKY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fXPk6I9iKAOdiiXTCLEPg7e8/O2TCtiDE0jgvvoJgdTO+OMyrA7igfpXJoZYzYvCd
         omdPEU6bICjHOI4WB0j0AySW2ClwgiwoTdWnsCCyD0Z0ST3u0aPDITH7SLuxbHcH2p
         zuOce3tGeP1IF+Brq3aYwr7qwiWzR4d/xVU7xb0oWugnYXSC+kSx5lp+ZT7Zq8+r8S
         18+pQn5JnSAonRlihZWr9XRyPiPf1I61/8n/Lev7aUc9s5oGhbxwgzlbTI28+iDxRu
         xqSm9Zfld/q8Yz8DhuSQ6/rtiBbSdIbPjzhKq+n4g5+N0vnVJ3HItJcq1u4zASIq15
         2Tm+aV6D64UjQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 11/27] NFS: If the cookie verifier changes, we must invalidate the page cache
Date:   Sun, 27 Feb 2022 18:12:11 -0500
Message-Id: <20220227231227.9038-12-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227231227.9038-11-trondmy@kernel.org>
References: <20220227231227.9038-1-trondmy@kernel.org>
 <20220227231227.9038-2-trondmy@kernel.org>
 <20220227231227.9038-3-trondmy@kernel.org>
 <20220227231227.9038-4-trondmy@kernel.org>
 <20220227231227.9038-5-trondmy@kernel.org>
 <20220227231227.9038-6-trondmy@kernel.org>
 <20220227231227.9038-7-trondmy@kernel.org>
 <20220227231227.9038-8-trondmy@kernel.org>
 <20220227231227.9038-9-trondmy@kernel.org>
 <20220227231227.9038-10-trondmy@kernel.org>
 <20220227231227.9038-11-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index ca71271b5c62..eaf8d5cddb0f 100644
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

