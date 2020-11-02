Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D477B2A32AE
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 19:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgKBSRZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 13:17:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:40900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbgKBSRY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 2 Nov 2020 13:17:24 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 500012222B
        for <linux-nfs@vger.kernel.org>; Mon,  2 Nov 2020 18:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604341043;
        bh=kerKzjIvafmw3bS9/iH3h6ChBScraTFc//G5vJ1W18M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iiPG8N5Z8QYE3TX6cyf3nCC1BV7ipjA5hit9rj1laXWnictZhY/BWOz1hnlJrGSUH
         IX20XNSICTi7xjOqKlqrxmarZJBKqbuc6J66ovodOsjYDqF/IYj4kJ/Tq0MCn6d2Kd
         hWQCMlP2GIwPVOIslpgGEB5AUZDnheF2HZHDZBuE=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 06/12] NFS: Remove unnecessary kmap in nfs_readdir_xdr_to_array()
Date:   Mon,  2 Nov 2020 13:06:52 -0500
Message-Id: <20201102180658.6218-7-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201102180658.6218-6-trondmy@kernel.org>
References: <20201102180658.6218-1-trondmy@kernel.org>
 <20201102180658.6218-2-trondmy@kernel.org>
 <20201102180658.6218-3-trondmy@kernel.org>
 <20201102180658.6218-4-trondmy@kernel.org>
 <20201102180658.6218-5-trondmy@kernel.org>
 <20201102180658.6218-6-trondmy@kernel.org>
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
index 6f84038735a1..560a9c1553e5 100644
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

