Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3194E35EB
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Mar 2022 02:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbiCVBYA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Mar 2022 21:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbiCVBX5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Mar 2022 21:23:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45139289BC
        for <linux-nfs@vger.kernel.org>; Mon, 21 Mar 2022 18:22:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8579D615E2
        for <linux-nfs@vger.kernel.org>; Tue, 22 Mar 2022 01:22:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE4EC340EE;
        Tue, 22 Mar 2022 01:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647912149;
        bh=jBsBs0MYAmbMA+BaUY2qfe0Peph2k09n9zyI5ZjvPMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UivfGdqSdXZi0VsoX6VKOSqFVPPvfw5EpeliHjDk2rw3LRw5RgeCkJwzonMzWeNym
         dJdIiCrBd9JOXIPg3bzuYUw/tCJhFYyMZhtnZq/S6cy/eNC9wUaWQ1vHI2+WxhYLOA
         QXu0eIw9+qMl+/e2/IcoAQelNwzpiLo+MdE8uG3FFhWjsfk20ZmthwKej9qyPxdr/t
         YOjpjUWJIXPNf3U1QXnLInZ2rrPlahl9RpQ0wcBX6gxmCtyw+9DYpuWkcmX2Zv1QBd
         XLWgK6DcWQVlFpEbrqzMpMYBYTZax7YWxaPqWU+FPBaftHPZXoItP1wqbCf3P31+0U
         P7MZ6AYQ9KPbQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Cc:     Neil Brown <neilb@suse.de>
Subject: [PATCH v2 9/9] pNFS/files: Ensure pNFS allocation modes are consistent with nfsiod
Date:   Mon, 21 Mar 2022 21:16:18 -0400
Message-Id: <20220322011618.1052288-10-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322011618.1052288-9-trondmy@kernel.org>
References: <20220322011618.1052288-1-trondmy@kernel.org>
 <20220322011618.1052288-2-trondmy@kernel.org>
 <20220322011618.1052288-3-trondmy@kernel.org>
 <20220322011618.1052288-4-trondmy@kernel.org>
 <20220322011618.1052288-5-trondmy@kernel.org>
 <20220322011618.1052288-6-trondmy@kernel.org>
 <20220322011618.1052288-7-trondmy@kernel.org>
 <20220322011618.1052288-8-trondmy@kernel.org>
 <20220322011618.1052288-9-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that pNFS file commit allocations in rpciod/nfsiod callbacks can
fail in low memory mode, so that the threads don't block and loop
forever.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/filelayout/filelayout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index 9c96e3e5ed35..76deddab0a8f 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -1075,7 +1075,7 @@ filelayout_setup_ds_info(struct pnfs_ds_commit_info *fl_cinfo,
 	unsigned int size = (fl->stripe_type == STRIPE_SPARSE) ?
 		fl->dsaddr->ds_num : fl->dsaddr->stripe_count;
 
-	new = pnfs_alloc_commit_array(size, GFP_NOIO);
+	new = pnfs_alloc_commit_array(size, nfs_io_gfp_mask());
 	if (new) {
 		spin_lock(&inode->i_lock);
 		array = pnfs_add_commit_array(fl_cinfo, new, lseg);
-- 
2.35.1

