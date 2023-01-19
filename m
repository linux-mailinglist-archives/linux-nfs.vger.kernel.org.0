Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB4E674571
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jan 2023 23:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjASWDR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Jan 2023 17:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjASWCo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Jan 2023 17:02:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC1E59FF
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 13:40:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40D1561D82
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 21:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53870C433F1;
        Thu, 19 Jan 2023 21:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674164427;
        bh=3cjd6viynUsFkHy+3/0wpZu3G6DvhCBXaVk2A/zgJCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=teA+IqDUxI1rD0Gurp6CcrzHiBNjP9pR5LyDSeh2HWw9/IRUUcXTz2PKgQulssIvz
         lcaXqaK4hhlu0fhmWIZFY8jUur9ZjcimV8i3SGNFhgN6/YJUNYTGCAGBvQ7uBsBMzj
         rBCeE+PeEle1qBbZyrpV3jfMkvJkJnqXuS6irkneNRW3+wieQQelv9jNGLnbAc3stH
         Kkl1bGBAv4+i6FTPpzbL659ixALZc7r6WDTVhCgUW9QsVe23oDSvOPtRr9ehlfx7WO
         0X4LYwTEcyrRx6gnj/3oVCFwp931ruhMGoqf0nSlhVb+HlMGggdg2U7165fuiSYpSW
         DdtsZBLvgkLEQ==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 17/18] NFS: Improve tracing of nfs_wb_folio()
Date:   Thu, 19 Jan 2023 16:33:50 -0500
Message-Id: <20230119213351.443388-18-trondmy@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119213351.443388-17-trondmy@kernel.org>
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
 <20230119213351.443388-16-trondmy@kernel.org>
 <20230119213351.443388-17-trondmy@kernel.org>
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

Include info about which folio is being traced.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfstrace.h | 5 +++--
 fs/nfs/write.c    | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index d3aa330fef36..a778713343df 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -152,8 +152,6 @@ DEFINE_NFS_INODE_EVENT(nfs_getattr_enter);
 DEFINE_NFS_INODE_EVENT_DONE(nfs_getattr_exit);
 DEFINE_NFS_INODE_EVENT(nfs_setattr_enter);
 DEFINE_NFS_INODE_EVENT_DONE(nfs_setattr_exit);
-DEFINE_NFS_INODE_EVENT(nfs_writeback_page_enter);
-DEFINE_NFS_INODE_EVENT_DONE(nfs_writeback_page_exit);
 DEFINE_NFS_INODE_EVENT(nfs_writeback_inode_enter);
 DEFINE_NFS_INODE_EVENT_DONE(nfs_writeback_inode_exit);
 DEFINE_NFS_INODE_EVENT(nfs_fsync_enter);
@@ -1032,6 +1030,9 @@ DECLARE_EVENT_CLASS(nfs_folio_event_done,
 DEFINE_NFS_FOLIO_EVENT(nfs_aop_readpage);
 DEFINE_NFS_FOLIO_EVENT_DONE(nfs_aop_readpage_done);
 
+DEFINE_NFS_FOLIO_EVENT(nfs_writeback_folio);
+DEFINE_NFS_FOLIO_EVENT_DONE(nfs_writeback_folio_done);
+
 DEFINE_NFS_FOLIO_EVENT(nfs_invalidate_folio);
 DEFINE_NFS_FOLIO_EVENT_DONE(nfs_launder_folio_done);
 
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 77e6c033ca95..78cacaaded64 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -2093,7 +2093,7 @@ int nfs_wb_folio(struct inode *inode, struct folio *folio)
 	};
 	int ret;
 
-	trace_nfs_writeback_page_enter(inode);
+	trace_nfs_writeback_folio(inode, folio);
 
 	for (;;) {
 		folio_wait_writeback(folio);
@@ -2111,7 +2111,7 @@ int nfs_wb_folio(struct inode *inode, struct folio *folio)
 			goto out_error;
 	}
 out_error:
-	trace_nfs_writeback_page_exit(inode, ret);
+	trace_nfs_writeback_folio_done(inode, folio, ret);
 	return ret;
 }
 
-- 
2.39.0

