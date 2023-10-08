Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3157BCF93
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Oct 2023 20:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbjJHSey (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Oct 2023 14:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjJHSey (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Oct 2023 14:34:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1050AAC
        for <linux-nfs@vger.kernel.org>; Sun,  8 Oct 2023 11:34:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5343CC433C7
        for <linux-nfs@vger.kernel.org>; Sun,  8 Oct 2023 18:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696790092;
        bh=e5s6lPiViirl7bb4wkAEg4AUXr+EIm1guo3pPbQqMAc=;
        h=From:To:Subject:Date:From;
        b=m54O/UcwU7HpqekRKqh2Tvf+/Zdf9xwzrDv/Ym0CCYoNWQ2SCkpbaZ8U8no2OBbjZ
         6ehriirzRsCRNuAr6PbSb4DSX8/FdXTmxK5H31qydBruTitZJsUmfNt12+GIHudurP
         JJ8Xj4++hdKokBFf8DyE9Fp+SZJfQva/G41VTKj5IL5hYgBPypelior6DArwKKmrXN
         jJXAquu7AGYQ5IgDqF2ogIKNyVWhQl8XQfFQpPsz0/yJR68eq2/RK5RI7J5BCGjwC+
         5Tw9c8kYt7MdK5/G8MCwWbwYuTLhYvOVQ7djSU/epdtbv/imG5XpJL1gQYumDrYTF6
         T3cYz65V0VVTw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] pNFS/flexfiles: Check the layout validity in ff_layout_mirror_prepare_stats
Date:   Sun,  8 Oct 2023 14:28:46 -0400
Message-ID: <20231008182846.12956-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that we check the layout pointer and validity after dereferencing
it in ff_layout_mirror_prepare_stats.

Fixes: 08e2e5bc6c9a ("pNFS/flexfiles: Clean up layoutstats")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index a1dc33864906..ef817a0475ff 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -2520,9 +2520,9 @@ ff_layout_mirror_prepare_stats(struct pnfs_layout_hdr *lo,
 	return i;
 }
 
-static int
-ff_layout_prepare_layoutstats(struct nfs42_layoutstat_args *args)
+static int ff_layout_prepare_layoutstats(struct nfs42_layoutstat_args *args)
 {
+	struct pnfs_layout_hdr *lo;
 	struct nfs4_flexfile_layout *ff_layout;
 	const int dev_count = PNFS_LAYOUTSTATS_MAXDEV;
 
@@ -2533,11 +2533,14 @@ ff_layout_prepare_layoutstats(struct nfs42_layoutstat_args *args)
 		return -ENOMEM;
 
 	spin_lock(&args->inode->i_lock);
-	ff_layout = FF_LAYOUT_FROM_HDR(NFS_I(args->inode)->layout);
-	args->num_dev = ff_layout_mirror_prepare_stats(&ff_layout->generic_hdr,
-						       &args->devinfo[0],
-						       dev_count,
-						       NFS4_FF_OP_LAYOUTSTATS);
+	lo = NFS_I(args->inode)->layout;
+	if (lo && pnfs_layout_is_valid(lo)) {
+		ff_layout = FF_LAYOUT_FROM_HDR(lo);
+		args->num_dev = ff_layout_mirror_prepare_stats(
+			&ff_layout->generic_hdr, &args->devinfo[0], dev_count,
+			NFS4_FF_OP_LAYOUTSTATS);
+	} else
+		args->num_dev = 0;
 	spin_unlock(&args->inode->i_lock);
 	if (!args->num_dev) {
 		kfree(args->devinfo);
-- 
2.41.0

