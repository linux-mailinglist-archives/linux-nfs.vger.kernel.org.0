Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0A766109C
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Jan 2023 18:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjAGRmP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Jan 2023 12:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjAGRmO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 7 Jan 2023 12:42:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F48A240
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 09:42:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD584B801BE
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 17:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F246C433F0
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 17:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673113330;
        bh=NQ15bTTnOcqSRxnA6kbNuxpAlTwB4Owa/LgTB+DfsiA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=plSuJGaZHEMzXlbdjL3CcM/uRL0XUHhlTIEAZwofq0UyMZYglqnQJs4TZF25JZsDK
         Ro8pVUcYThK8OMGI5o4C+/AR+2iiLOS8xoizbOFq/5NLwvA8iTAoCYTHn6mwigIkUf
         Z4oAy4d55yU1hHTsIFpCp4pnE7SFLxyLfEvTkad6kkqfg0ZUMNUyOoWroBsZ3P34rd
         7cy6fRnMI+W31X+Gk6QVn8FH0LFNTIgq3SgR5KBGZ4WXNwy+2GyOqdBfFm0xA82w3x
         tqe+vCiHjfrFHGCDMzF0uWhdVQPn2Om4q0RwJVImIuMc5hVhU4ZxRtXoCH8UVw4gRd
         RsllvoxiXJvug==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 07/17] NFS: Add a helper nfs_wb_folio()
Date:   Sat,  7 Jan 2023 12:36:25 -0500
Message-Id: <20230107173635.2025233-8-trondmy@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230107173635.2025233-7-trondmy@kernel.org>
References: <20230107173635.2025233-1-trondmy@kernel.org>
 <20230107173635.2025233-2-trondmy@kernel.org>
 <20230107173635.2025233-3-trondmy@kernel.org>
 <20230107173635.2025233-4-trondmy@kernel.org>
 <20230107173635.2025233-5-trondmy@kernel.org>
 <20230107173635.2025233-6-trondmy@kernel.org>
 <20230107173635.2025233-7-trondmy@kernel.org>
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

...and use it in nfs_launder_folio().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/file.c          |  2 +-
 fs/nfs/write.c         | 13 +++++++++++++
 include/linux/nfs_fs.h |  1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index d8ec889a4b3f..8704bd071d3a 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -469,7 +469,7 @@ static int nfs_launder_folio(struct folio *folio)
 		inode->i_ino, folio_pos(folio));
 
 	folio_wait_fscache(folio);
-	return nfs_wb_page(inode, &folio->page);
+	return nfs_wb_folio(inode, folio);
 }
 
 static int nfs_swap_activate(struct swap_info_struct *sis, struct file *file,
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index f624b3d98cf7..0fbb119022d9 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -2106,6 +2106,19 @@ int nfs_wb_page(struct inode *inode, struct page *page)
 	return ret;
 }
 
+/**
+ * nfs_wb_folio - Write back all requests on one page
+ * @inode: pointer to page
+ * @folio: pointer to folio
+ *
+ * Assumes that the folio has been locked by the caller, and will
+ * not unlock it.
+ */
+int nfs_wb_folio(struct inode *inode, struct folio *folio)
+{
+	return nfs_wb_page(inode, &folio->page);
+}
+
 #ifdef CONFIG_MIGRATION
 int nfs_migrate_folio(struct address_space *mapping, struct folio *dst,
 		struct folio *src, enum migrate_mode mode)
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index d92fdfd2444c..66b5de42f6b8 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -578,6 +578,7 @@ extern int  nfs_updatepage(struct file *, struct page *, unsigned int, unsigned
  */
 extern int nfs_sync_inode(struct inode *inode);
 extern int nfs_wb_all(struct inode *inode);
+extern int nfs_wb_folio(struct inode *inode, struct folio *folio);
 extern int nfs_wb_page(struct inode *inode, struct page *page);
 int nfs_wb_folio_cancel(struct inode *inode, struct folio *folio);
 extern int  nfs_commit_inode(struct inode *, int);
-- 
2.39.0

