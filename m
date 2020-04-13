Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310631A6D5D
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Apr 2020 22:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgDMUi4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Apr 2020 16:38:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725272AbgDMUiz (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 13 Apr 2020 16:38:55 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F302206DA
        for <linux-nfs@vger.kernel.org>; Mon, 13 Apr 2020 20:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586810335;
        bh=8uBtColgtv4trvfSoluhUbFmT7BbSU7oKjTFjhW1HOU=;
        h=From:To:Subject:Date:From;
        b=yf7XP/fKpT+uVE8qZgIRA4M1P1vtjO9CVJ+DWLiLI8jJh9V7Mp+eEkUvViE4Dq7KF
         m69b6YKQbU3cDkDOBQSsVqb2FBywcTas6FymtETIfLBphdHTan7A9+8cuLOZ+b1MRN
         izb4pdznd4gvtxdm8XLPaKKcodrT2LU2dXO4gNyo=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Fix an ABBA spinlock issue in pnfs_update_layout()
Date:   Mon, 13 Apr 2020 16:36:41 -0400
Message-Id: <20200413203641.255752-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We need to drop the inode spinlock while calling nfs4_select_rw_stateid(),
since nfs4_copy_delegation_stateid() could take the delegation lock.
Note that it is safe to do this, since all other calls to
pnfs_update_layout() for that inode will find themselves blocked by
the lock we hold on NFS_LAYOUT_FIRST_LAYOUTGET.

Fixes: fc51b1cf391d ("NFS: Beware when dereferencing the delegation cred")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index f2dc35c22964..b8d78f393365 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2023,6 +2023,7 @@ pnfs_update_layout(struct inode *ino,
 			goto lookup_again;
 		}
 
+		spin_unlock(&ino->i_lock);
 		first = true;
 		status = nfs4_select_rw_stateid(ctx->state,
 					iomode == IOMODE_RW ? FMODE_WRITE : FMODE_READ,
@@ -2032,12 +2033,12 @@ pnfs_update_layout(struct inode *ino,
 			trace_pnfs_update_layout(ino, pos, count,
 					iomode, lo, lseg,
 					PNFS_UPDATE_LAYOUT_INVALID_OPEN);
-			spin_unlock(&ino->i_lock);
 			nfs4_schedule_stateid_recovery(server, ctx->state);
 			pnfs_clear_first_layoutget(lo);
 			pnfs_put_layout_hdr(lo);
 			goto lookup_again;
 		}
+		spin_lock(&ino->i_lock);
 	} else {
 		nfs4_stateid_copy(&stateid, &lo->plh_stateid);
 	}
-- 
2.25.2

