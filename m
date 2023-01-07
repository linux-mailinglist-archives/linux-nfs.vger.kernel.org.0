Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8299A6610A3
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Jan 2023 18:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjAGRmV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Jan 2023 12:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjAGRmQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 7 Jan 2023 12:42:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742AB1C929
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 09:42:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12E3D60B97
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 17:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BD0C433F1
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 17:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673113334;
        bh=lOYi+fIs9C+kQMkaiHsFvwyAeISg2h7hFDuK/Ga12qs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uFklzXxMihm9nWcSi1knQe6+WPsUlDAWTUPL6Hqs+V5dWy+9HzWg5zJLgAzHlgoWC
         nYDs9PEbCMP2wbdAkDVIix+ui3MhU8DYsrNF1wid4hVG8CL7kwrDZl0oZ3s89Ma5tZ
         TracbWeJn7sPbpers/qWU6IaBxLYAATdG6/gagUPgRRpPMmM/NKjuvuwMlkM6nJv5G
         vURe4Cn3IrDtaIrh5VQI1eRLCA6E/yZkIu4UiXs77TFa1ymXGFz8YkGHg4mPVobzyY
         BVoxQGqZMzqLkwbJv6rU9bSCLacLb2roPuxNXgaDY6JL0wCNykkv3IWPMN4gZV/XIz
         S5wQ3DveYKHbw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 17/17] NFS: Improve tracing of nfs_wb_folio()
Date:   Sat,  7 Jan 2023 12:36:35 -0500
Message-Id: <20230107173635.2025233-18-trondmy@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230107173635.2025233-17-trondmy@kernel.org>
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
 <20230107173635.2025233-16-trondmy@kernel.org>
 <20230107173635.2025233-17-trondmy@kernel.org>
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
index 988f2c9b607f..624333ac1325 100644
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
index 666e18e2ec3f..d47247411877 100644
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

