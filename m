Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F109F37B8F8
	for <lists+linux-nfs@lfdr.de>; Wed, 12 May 2021 11:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhELJVR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 May 2021 05:21:17 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:49073 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230118AbhELJVR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 May 2021 05:21:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UYd96fc_1620811206;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UYd96fc_1620811206)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 12 May 2021 17:20:07 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     trond.myklebust@hammerspace.com
Cc:     anna.schumaker@netapp.com, nathan@kernel.org,
        ndesaulniers@google.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] pNFS/NFSv4: Remove redundant initialization of 'rd_size'
Date:   Wed, 12 May 2021 17:20:04 +0800
Message-Id: <1620811204-107673-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Variable 'rd_size' is being initialized however
this value is never read as 'rd_size' is assigned
a new value in for statement. Remove the redundant
assignment.

Clean up clang warning:

fs/nfs/pnfs.c:2681:6: warning: Value stored to 'rd_size' during its
initialization is never read [clang-analyzer-deadcode.DeadStores]

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/nfs/pnfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 03e0b34..f076a6f 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2678,7 +2678,7 @@ void pnfs_error_mark_layout_for_return(struct inode *inode,
 void
 pnfs_generic_pg_init_read(struct nfs_pageio_descriptor *pgio, struct nfs_page *req)
 {
-	u64 rd_size = req->wb_bytes;
+	u64 rd_size;
 
 	pnfs_generic_pg_check_layout(pgio);
 	pnfs_generic_pg_check_range(pgio, req);
-- 
1.8.3.1

