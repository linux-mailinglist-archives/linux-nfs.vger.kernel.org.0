Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2A66610A0
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Jan 2023 18:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjAGRmS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Jan 2023 12:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjAGRmP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 7 Jan 2023 12:42:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97394AE40
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 09:42:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3555B60B2D
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 17:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE57DC433F2
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 17:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673113334;
        bh=rOpW5muFNFVXhWhzyIdHq62jbDbbJm4/eMvtlgEM3cQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=g+ddrhH9/WzHueGH1D48HFeWRh3ABI0JaV8BQzHRsx3JOI6LWa8QDtN7qOZ8/rgjq
         d/Q8Fp2XNkULjGaR9iHA4k/EyomXPum3NGV30tKxuwxk4FivwocLlEC64u0dhIIME/
         ZzzR+L7sbgNhuA0SV4YdKheGQHSR5QjTmsQJuDXqXxZmrPAeSi3xyA5PQ/D2iDGdQl
         9PDd3H/XPRd18PU5bcXXRP+gnjFqSQI3BHInPFRef0VYw5O3rmq7ZpkmtWWGO4+3Da
         v91EA3YQBd1R3TwE5jv/aWAuppjNPWoTGtPMu8FdIsuWWr5WDZZumEvnThqBxdFNOz
         wtyE0kuqrbYVw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 15/17] NFS: fix up nfs_release_folio() to try to release the page
Date:   Sat,  7 Jan 2023 12:36:33 -0500
Message-Id: <20230107173635.2025233-16-trondmy@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230107173635.2025233-15-trondmy@kernel.org>
References: <20230107173635.2025233-1-trondmy@kernel.org>
 <20230107173635.2025233-2-trondmy@kernel.org>
 <20230107173635.2025233-3-trondmy@kernel.org>
 <20230107173635.2025233-4-trondmy@kernel.org>
 <20230107173635.2025233-5-trondmy@kernel.org>
 <20230107173635.2025233-6-trondmy@kernel.org>
 <20230107173635.2025233-7-trondmy@kernel.org>
 <20230107173635.2025233-8-trondmy@kernel.org>
 <20230107173635.2025233-9-trondmy@kernel.org>
 <20230107173635.2025233-10-trondmy@kernel.org>
 <20230107173635.2025233-11-trondmy@kernel.org>
 <20230107173635.2025233-12-trondmy@kernel.org>
 <20230107173635.2025233-13-trondmy@kernel.org>
 <20230107173635.2025233-14-trondmy@kernel.org>
 <20230107173635.2025233-15-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the gfp context allows it, and we're not kswapd, then try to write
out the folio that has private data.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/file.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 563c5e0c55e8..3bed75c5250b 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -432,8 +432,13 @@ static bool nfs_release_folio(struct folio *folio, gfp_t gfp)
 	dfprintk(PAGECACHE, "NFS: release_folio(%p)\n", folio);
 
 	/* If the private flag is set, then the folio is not freeable */
-	if (folio_test_private(folio))
-		return false;
+	if (folio_test_private(folio)) {
+		if ((current_gfp_context(gfp) & GFP_KERNEL) != GFP_KERNEL ||
+		    current_is_kswapd())
+			return false;
+		if (nfs_wb_folio(folio_file_mapping(folio)->host, folio) < 0)
+			return false;
+	}
 	return nfs_fscache_release_folio(folio, gfp);
 }
 
-- 
2.39.0

