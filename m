Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CBF4C5FD6
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 00:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiB0XTV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 27 Feb 2022 18:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiB0XTS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 27 Feb 2022 18:19:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B26822504
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 15:18:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 382E6611D7
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84465C340F4
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646003920;
        bh=5h/9ONhR9JbTNfkbM1Nf4RX6uqiE1+CzDp93/8OWHsA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Y+uJm4RKamIn8qTNLnfV+95FPTmMmguUzTpngsQhsrkmkukSaJ6FZ0/dTJt0L8hz8
         0nCLCExaj25NV5fvRdlARFZbA+g0F2CGXBSQg6mVj6EoxA0J6Tr9Q3/WpP+H3N352G
         0VkpW061EvHrUmXDvrgE+3kA313m/szA8vMt0JjWRMH6kGSK8MZJUpuBN6YAWwHn56
         zLIHMdbdQndxrSkSD/WYFTE+aPaRKug16wh4afWV2yGN2/uHcRqahwGJbSwPaO+8Q6
         br9rvDuTTZiqiPtFkmzNg0/G/OfAhl+SARe7bHET7k7ggm+9FUh5H9om+dscj6Rflg
         epIT6nkqL9rrA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 17/27] NFS: Readdirplus can't help lookup for case insensitive filesystems
Date:   Sun, 27 Feb 2022 18:12:17 -0500
Message-Id: <20220227231227.9038-18-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227231227.9038-17-trondmy@kernel.org>
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
 <20220227231227.9038-12-trondmy@kernel.org>
 <20220227231227.9038-13-trondmy@kernel.org>
 <20220227231227.9038-14-trondmy@kernel.org>
 <20220227231227.9038-15-trondmy@kernel.org>
 <20220227231227.9038-16-trondmy@kernel.org>
 <20220227231227.9038-17-trondmy@kernel.org>
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

If the filesystem is case insensitive, then readdirplus can't help with
cache misses, since it won't return case folded variants of the filename.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index c5c7175a257c..5892c4ee3a6d 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -694,6 +694,8 @@ void nfs_readdir_record_entry_cache_miss(struct inode *dir)
 
 static void nfs_lookup_advise_force_readdirplus(struct inode *dir)
 {
+	if (nfs_server_capable(dir, NFS_CAP_CASE_INSENSITIVE))
+		return;
 	nfs_readdir_record_entry_cache_miss(dir);
 }
 
-- 
2.35.1

