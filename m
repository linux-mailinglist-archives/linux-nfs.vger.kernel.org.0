Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBDB34DCB1
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Mar 2021 02:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhC3AAo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Mar 2021 20:00:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230052AbhC3AA1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 29 Mar 2021 20:00:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 858B56191B
        for <linux-nfs@vger.kernel.org>; Tue, 30 Mar 2021 00:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617062426;
        bh=gybvpyBgkLAZU65DjL+UtXkCiWHYSDuVT+0kcOPqPZg=;
        h=From:To:Subject:Date:From;
        b=qwls112K6h/5G+WSD06LGxU8BKWfl1arb2DjWBHW+mqf5IXsCpOEkcE7CcHclSWDQ
         p/BTA2q4dcmH0JP94WC6VOtwmaQSoz2WmxOM3vwoweDehGjsI+ZUO9k15fJlx/QL8x
         UHRnXOaD//OSU8YjQPqRbGwJ8xjzO0WIt60kZVTtYQea1LgQTmjo4VZF2dXjAzf021
         QNsv5DEfKMzbvKpRct4iVgfsXBTpSo5u//PUSnKzjKE8ZZtFMxPPfgx2CNDZ2TBKlF
         FKtQw+zWp7N/TfuXqcOkRIUrU6IK8T6wTIZ10IY7LpdX4k8CCBUfvcCuPhojdCasDm
         oEOKL3LOmHVVw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Fix fscache invalidation in nfs_set_cache_invalid()
Date:   Mon, 29 Mar 2021 20:00:23 -0400
Message-Id: <20210330000023.41367-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that we invalidate the fscache before we strip the
NFS_INO_INVALID_DATA flag.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index a7fb076a5f44..ff737be559dc 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -223,11 +223,11 @@ void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 
 	if (!nfs_has_xattr_cache(nfsi))
 		flags &= ~NFS_INO_INVALID_XATTR;
+	if (flags & NFS_INO_INVALID_DATA)
+		nfs_fscache_invalidate(inode);
 	if (inode->i_mapping->nrpages == 0)
 		flags &= ~(NFS_INO_INVALID_DATA|NFS_INO_DATA_INVAL_DEFER);
 	nfsi->cache_validity |= flags;
-	if (flags & NFS_INO_INVALID_DATA)
-		nfs_fscache_invalidate(inode);
 }
 EXPORT_SYMBOL_GPL(nfs_set_cache_invalid);
 
-- 
2.30.2

