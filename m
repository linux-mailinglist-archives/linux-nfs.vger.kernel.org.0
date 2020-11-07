Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350042AA5D0
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Nov 2020 15:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgKGONl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Nov 2020 09:13:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:58254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728064AbgKGONk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 7 Nov 2020 09:13:40 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC53220719
        for <linux-nfs@vger.kernel.org>; Sat,  7 Nov 2020 14:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604758419;
        bh=aLIy4T1iqz/koOtPwtTuhoLqZQ/3YwMWjDwarpayCos=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VjJGX6AGnXaFpF8El79Iy0JcIHKHEPvligAUX1wHDqh8KVT7usx4YL3ZaAG2LnWcV
         GV5VPRzf/sM4+pdkDLF6UbjEJp5mFdxmWx7P2xCZH4OaU6mcQxyoK5qFC5qryJooUr
         jDv9dTZ/VV5ok26eLUdp7iqBCdMVVgh/weeGdxpg=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 08/21] NFS: Remove unnecessary kmap in nfs_readdir_xdr_to_array()
Date:   Sat,  7 Nov 2020 09:03:12 -0500
Message-Id: <20201107140325.281678-9-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107140325.281678-8-trondmy@kernel.org>
References: <20201107140325.281678-1-trondmy@kernel.org>
 <20201107140325.281678-2-trondmy@kernel.org>
 <20201107140325.281678-3-trondmy@kernel.org>
 <20201107140325.281678-4-trondmy@kernel.org>
 <20201107140325.281678-5-trondmy@kernel.org>
 <20201107140325.281678-6-trondmy@kernel.org>
 <20201107140325.281678-7-trondmy@kernel.org>
 <20201107140325.281678-8-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The kmapped pointer is only used once per loop to check if we need to
exit.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index f7248145c333..e8b0fcc1bc9e 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -759,7 +759,6 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
 	struct page *pages[NFS_MAX_READDIR_PAGES];
 	struct nfs_entry entry;
 	struct file	*file = desc->file;
-	struct nfs_cache_array *array;
 	int status = -ENOMEM;
 	unsigned int array_size = ARRAY_SIZE(pages);
 
@@ -778,11 +777,9 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
 		goto out;
 	}
 
-	array = kmap(page);
-
 	status = nfs_readdir_alloc_pages(pages, array_size);
 	if (status < 0)
-		goto out_release_array;
+		goto out_release_label;
 	do {
 		unsigned int pglen;
 		status = nfs_readdir_xdr_filler(pages, desc, &entry, file, inode);
@@ -797,11 +794,10 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
 		}
 
 		status = nfs_readdir_page_filler(desc, &entry, pages, page, pglen);
-	} while (!status && !nfs_readdir_array_is_full(array));
+	} while (!status && nfs_readdir_page_needs_filling(page));
 
 	nfs_readdir_free_pages(pages, array_size);
-out_release_array:
-	kunmap(page);
+out_release_label:
 	nfs4_label_free(entry.label);
 out:
 	nfs_free_fattr(entry.fattr);
-- 
2.28.0

