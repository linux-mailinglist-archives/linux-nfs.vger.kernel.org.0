Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4FD1BB752
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2020 09:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgD1HSa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Apr 2020 03:18:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41556 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726284AbgD1HSa (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 28 Apr 2020 03:18:30 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8D35D3B30969C8CAFF1F;
        Tue, 28 Apr 2020 15:18:25 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 28 Apr 2020 15:18:15 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-nfs@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] NFSv4: Use GFP_ATOMIC under spin lock in _pnfs_grab_empty_layout()
Date:   Tue, 28 Apr 2020 07:19:32 +0000
Message-ID: <20200428071932.69976-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A spin lock is taken here so we should use GFP_ATOMIC.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 fs/nfs/pnfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index dd2e14f5875d..d84c1b7b71d2 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2170,7 +2170,7 @@ _pnfs_grab_empty_layout(struct inode *ino, struct nfs_open_context *ctx)
 	struct pnfs_layout_hdr *lo;
 
 	spin_lock(&ino->i_lock);
-	lo = pnfs_find_alloc_layout(ino, ctx, GFP_KERNEL);
+	lo = pnfs_find_alloc_layout(ino, ctx, GFP_ATOMIC);
 	if (!lo)
 		goto out_unlock;
 	if (!test_bit(NFS_LAYOUT_INVALID_STID, &lo->plh_flags))



