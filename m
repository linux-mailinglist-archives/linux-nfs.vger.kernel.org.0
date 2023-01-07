Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E2566109F
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Jan 2023 18:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjAGRmR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Jan 2023 12:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbjAGRmP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 7 Jan 2023 12:42:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276C61111
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 09:42:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B94D360B39
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 17:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE36C433D2
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 17:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673113333;
        bh=ELaqUw/MNdKLky2mtFVzVFlZE3JLmoqqAUasY0UwhVY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VYbH/XYLAaYQEfxPxGvkwoyTKBH2cMBUb6TDg/8mMRsa5glka5Z5kpLi3zSgc6k5z
         f281Ood7gatbIzomCM0Ey9EJuiq4lEAF8lbnW6SVpS/fzmS9MT03prAUyakjnalcgT
         Z2qgMS46aV+O3zhOnfM7Tpyj6bWyy4+RHPVWerSF02hf93kRIMajx/Nea5eALiFyDV
         jy+H77mXpB3XG2wFTEPbEGgPqoN6xLQNXoffd62w8lVU+HnzCW+q+JS0qKZ1G/7Bk0
         wVvwXHfNvcrnWGxzIiwKImu5fgi81W7YWlY8JsrLyHVTs7eVlcGyuFc9JbZzEx+MCI
         q10a3exBAlpOQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 13/17] NFS: Fix up nfs_vm_page_mkwrite() for folios
Date:   Sat,  7 Jan 2023 12:36:31 -0500
Message-Id: <20230107173635.2025233-14-trondmy@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230107173635.2025233-13-trondmy@kernel.org>
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
 fs/nfs/file.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 39ee7fb3f79f..563c5e0c55e8 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -556,23 +556,22 @@ const struct address_space_operations nfs_file_aops = {
  */
 static vm_fault_t nfs_vm_page_mkwrite(struct vm_fault *vmf)
 {
-	struct page *page = vmf->page;
 	struct file *filp = vmf->vma->vm_file;
 	struct inode *inode = file_inode(filp);
 	unsigned pagelen;
 	vm_fault_t ret = VM_FAULT_NOPAGE;
 	struct address_space *mapping;
-	struct folio *folio = page_folio(page);
+	struct folio *folio = page_folio(vmf->page);
 
 	dfprintk(PAGECACHE, "NFS: vm_page_mkwrite(%pD2(%lu), offset %lld)\n",
-		filp, filp->f_mapping->host->i_ino,
-		(long long)page_offset(page));
+		 filp, filp->f_mapping->host->i_ino,
+		 (long long)folio_file_pos(folio));
 
 	sb_start_pagefault(inode->i_sb);
 
 	/* make sure the cache has finished storing the page */
-	if (PageFsCache(page) &&
-	    wait_on_page_fscache_killable(vmf->page) < 0) {
+	if (folio_test_fscache(folio) &&
+	    folio_wait_fscache_killable(folio) < 0) {
 		ret = VM_FAULT_RETRY;
 		goto out;
 	}
@@ -581,14 +580,14 @@ static vm_fault_t nfs_vm_page_mkwrite(struct vm_fault *vmf)
 			   nfs_wait_bit_killable,
 			   TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
 
-	lock_page(page);
-	mapping = page_file_mapping(page);
+	folio_lock(folio);
+	mapping = folio_file_mapping(folio);
 	if (mapping != inode->i_mapping)
 		goto out_unlock;
 
-	wait_on_page_writeback(page);
+	folio_wait_writeback(folio);
 
-	pagelen = nfs_page_length(page);
+	pagelen = nfs_folio_length(folio);
 	if (pagelen == 0)
 		goto out_unlock;
 
@@ -599,7 +598,7 @@ static vm_fault_t nfs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	ret = VM_FAULT_SIGBUS;
 out_unlock:
-	unlock_page(page);
+	folio_unlock(folio);
 out:
 	sb_end_pagefault(inode->i_sb);
 	return ret;
-- 
2.39.0

