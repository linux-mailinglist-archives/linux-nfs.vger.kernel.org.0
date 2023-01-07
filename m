Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8966610A1
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Jan 2023 18:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjAGRmT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Jan 2023 12:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjAGRmP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 7 Jan 2023 12:42:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB92B868
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 09:42:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BA1FB802C6
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 17:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E10BC433F1
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 17:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673113332;
        bh=B4YVxejoLW3sUxQuhL5fwsaZCUpQjmUlg59kztt9KFY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=WQy82Ux820LVT2INsXpmBlnXOwU9z63xfjx1F1Av7Hcz5bF6DAQW7kY1AuHYuvQG8
         WvXnRKzJM+SBxQAzFWNCGIVudVoQu8lyAtH0HEKO/NO4yQhb6qzkQ7pmD+xLIie99i
         p9PNlzwa0pXkp6bAAfrut414/hmOPwPfsZPXrccq7H1cNF1Rjy6EOsNes5zzjyh3k2
         1o//FoC8GZ9VAp/oumJFIWg6i+AY2hmYFji72b+dy0SbYu82wGi8xBo3KJKDGMNAOO
         7bL5sX8JC+zlkZpFYwv5vS/YHH0FWaxP6FvWJ/fQuJNTWrt1PFbfG99bUShcj9O05/
         CPE81zNwAjHpg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 11/17] NFS: Remove unused function nfs_wb_page()
Date:   Sat,  7 Jan 2023 12:36:29 -0500
Message-Id: <20230107173635.2025233-12-trondmy@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230107173635.2025233-11-trondmy@kernel.org>
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

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/write.c         | 5 -----
 include/linux/nfs_fs.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 581ad66636a7..666e18e2ec3f 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -2115,11 +2115,6 @@ int nfs_wb_folio(struct inode *inode, struct folio *folio)
 	return ret;
 }
 
-int nfs_wb_page(struct inode *inode, struct page *page)
-{
-	return nfs_wb_folio(inode, page_folio(page));
-}
-
 #ifdef CONFIG_MIGRATION
 int nfs_migrate_folio(struct address_space *mapping, struct folio *dst,
 		struct folio *src, enum migrate_mode mode)
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index a61bfd52d551..45c44211e50e 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -580,7 +580,6 @@ extern int  nfs_update_folio(struct file *file, struct folio *folio,
 extern int nfs_sync_inode(struct inode *inode);
 extern int nfs_wb_all(struct inode *inode);
 extern int nfs_wb_folio(struct inode *inode, struct folio *folio);
-extern int nfs_wb_page(struct inode *inode, struct page *page);
 int nfs_wb_folio_cancel(struct inode *inode, struct folio *folio);
 extern int  nfs_commit_inode(struct inode *, int);
 extern struct nfs_commit_data *nfs_commitdata_alloc(void);
-- 
2.39.0

