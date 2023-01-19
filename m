Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E75674BA0
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jan 2023 06:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjATFDa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Jan 2023 00:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjATFDM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Jan 2023 00:03:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE7856190
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 20:50:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB1B4B8274B
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 21:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE56C433D2;
        Thu, 19 Jan 2023 21:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674164426;
        bh=rOpW5muFNFVXhWhzyIdHq62jbDbbJm4/eMvtlgEM3cQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pYQDueVZBUJMCnCcKQjUIwbUdXYD0Y5cKNm8mHT0ge5ktpNzZgvFYYQARcE8DVVaV
         pCTdkmxthRetgZXnLxHNUvv403mI3AmHbz1pKpCmFfDzGF6WdHh6QCD+qCO+aYphsS
         m7UcFbAGWxSX+U29FgPfTjkSEqv0Q7yzqKgSx3DyGoxcfHkDPjoyps4Ps5+W/bG2D1
         3vuySkofH7LLB7FYLdVRiBNlV+Gb1S7uEN6SCEQBVWs9ty/LqK68WfCf1bs6QDvOY8
         Kn/CAUdRCSM6S07oln6qmTR+iyFvaivlakAGYKlODGI7JjN6onGKn6Apz5LSJV4pPh
         KajSqGmhj3dWw==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 15/18] NFS: fix up nfs_release_folio() to try to release the page
Date:   Thu, 19 Jan 2023 16:33:48 -0500
Message-Id: <20230119213351.443388-16-trondmy@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119213351.443388-15-trondmy@kernel.org>
References: <20230119213351.443388-1-trondmy@kernel.org>
 <20230119213351.443388-2-trondmy@kernel.org>
 <20230119213351.443388-3-trondmy@kernel.org>
 <20230119213351.443388-4-trondmy@kernel.org>
 <20230119213351.443388-5-trondmy@kernel.org>
 <20230119213351.443388-6-trondmy@kernel.org>
 <20230119213351.443388-7-trondmy@kernel.org>
 <20230119213351.443388-8-trondmy@kernel.org>
 <20230119213351.443388-9-trondmy@kernel.org>
 <20230119213351.443388-10-trondmy@kernel.org>
 <20230119213351.443388-11-trondmy@kernel.org>
 <20230119213351.443388-12-trondmy@kernel.org>
 <20230119213351.443388-13-trondmy@kernel.org>
 <20230119213351.443388-14-trondmy@kernel.org>
 <20230119213351.443388-15-trondmy@kernel.org>
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

