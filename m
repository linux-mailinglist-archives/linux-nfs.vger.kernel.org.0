Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF85E674B8F
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jan 2023 06:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjATFB7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Jan 2023 00:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjATFBi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Jan 2023 00:01:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6FFBD15F
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 20:49:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5671BB8274E
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 21:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2282C433EF;
        Thu, 19 Jan 2023 21:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674164424;
        bh=hj6KO9NNz4UFVymLW7NCjFeKaRLONASwWuaE6qomTNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mm5Pgp6edZhfOC8EXjTbCfB2CXHob7M081JCHhmGFcYUIhfqlKR5/vOAcoXW8hjUF
         dFZGpfXDNryADhJrVkzxMSJDaTSmdDR5fkHvUt9iWBZueWmQy8CBut0qmgAJMQpZ24
         9RGcARDj+IAD/FQxcrVVjkjo7cqjaakuUBzLBXEHlPyuTB2VyZZz13mLUqev1Xf4NL
         3dTFk90Cy+4dfpSkEnQvMABB3BvkApmd90CfahgodPAG7ctw1JpKPHdVkntAFcF+zK
         byMsNzeahZkUrKfI6G5AwltTBIP7gCgXMS2HLHWOhxcbpDl0MM5WaTlKS7W6gWAPNq
         UyaRDIw8+CHtQ==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 11/18] NFS: Remove unused function nfs_wb_page()
Date:   Thu, 19 Jan 2023 16:33:44 -0500
Message-Id: <20230119213351.443388-12-trondmy@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119213351.443388-11-trondmy@kernel.org>
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
index 442aee011871..77e6c033ca95 100644
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

