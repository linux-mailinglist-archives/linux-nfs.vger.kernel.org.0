Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C22F3E8682
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Aug 2021 01:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbhHJX2f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Aug 2021 19:28:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234470AbhHJX2d (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Aug 2021 19:28:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A1B860F11;
        Tue, 10 Aug 2021 23:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628638091;
        bh=6heJ4WAsNUImSa2tlyDIQMPLxIVBko5KIHmoPRwxyOI=;
        h=Date:From:To:Cc:Subject:From;
        b=ep7pSZTFRTQ1FILB0HRx7qIRF0/QubGkJXiwTKlQayATEwzO82jUG9SybKnK/PSaI
         KotRCsz3JaiiK7+LwKCMOc0fsh0xVFa2sBSlnwHUJ1BPXuycW8k57ed6VZUJFjd+XO
         XlOgsx7RxXyFjSswdP3u2+eYb3aJtopFpL2bXfp+DbSii+Rd0u9Cr0MmrBXVVE1QTW
         0NQtCY0bPcKawbYJQk+L8r7ZZFUBhkRo/rWKNpjLCgYg3Lv7ZFHuMU6LuoyLY5ovnv
         ITnCJSu66XAG6t9dTfcxDBc/pltuYJ3lUCwLu2BdwFfEPIU/AreA17iVrbWXQeZSQi
         oRrIQVu3R/F1w==
Date:   Tue, 10 Aug 2021 18:31:01 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] nfs41: pnfs: filelayout: Replace one-element array
 with flexible-array member
Message-ID: <20210810233101.GA64518@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There is a regular need in the kernel to provide a way to declare having
a dynamically sized set of trailing elements in a structure. Kernel code
should always use “flexible array members”[1] for these cases. The older
style of one-element or zero-length arrays should no longer be used[2].

Refactor the code a bit according to the use of a flexible-array member
in struct nfs4_file_layout_dsaddr instead of a one-element array, and
use the struct_size() helper.

This helps with the ongoing efforts to globally enable -Warray-bounds
and get us closer to being able to tighten the FORTIFY_SOURCE routines
on memcpy().

This issue was found with the help of Coccinelle and audited and fixed,
manually.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/109
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/nfs/filelayout/filelayout.h    | 2 +-
 fs/nfs/filelayout/filelayoutdev.c | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/filelayout/filelayout.h b/fs/nfs/filelayout/filelayout.h
index 79323b5dab0c..aed0748fd6ec 100644
--- a/fs/nfs/filelayout/filelayout.h
+++ b/fs/nfs/filelayout/filelayout.h
@@ -51,7 +51,7 @@ struct nfs4_file_layout_dsaddr {
 	u32				stripe_count;
 	u8				*stripe_indices;
 	u32				ds_num;
-	struct nfs4_pnfs_ds		*ds_list[1];
+	struct nfs4_pnfs_ds		*ds_list[];
 };
 
 struct nfs4_filelayout_segment {
diff --git a/fs/nfs/filelayout/filelayoutdev.c b/fs/nfs/filelayout/filelayoutdev.c
index 86c3f7e69ec4..acf4b88889dc 100644
--- a/fs/nfs/filelayout/filelayoutdev.c
+++ b/fs/nfs/filelayout/filelayoutdev.c
@@ -136,9 +136,7 @@ nfs4_fl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 		goto out_err_free_stripe_indices;
 	}
 
-	dsaddr = kzalloc(sizeof(*dsaddr) +
-			(sizeof(struct nfs4_pnfs_ds *) * (num - 1)),
-			gfp_flags);
+	dsaddr = kzalloc(struct_size(dsaddr, ds_list, num), gfp_flags);
 	if (!dsaddr)
 		goto out_err_free_stripe_indices;
 
-- 
2.27.0

