Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5913A9AAE
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jun 2021 14:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbhFPMqo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Jun 2021 08:46:44 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:37433 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232403AbhFPMqo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Jun 2021 08:46:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UccgjY3_1623847470;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UccgjY3_1623847470)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Jun 2021 20:44:36 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-nfs@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH] nfs: set block size according to pnfs_blksize first
Date:   Wed, 16 Jun 2021 20:44:29 +0800
Message-Id: <1623847469-150122-1-git-send-email-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When testing fstests with ext4 over nfs 4.2, I found generic/486
failed. The root cause is that the length of its xattr value is
  min(st_blksize * 3 / 4, XATTR_SIZE_MAX)

which is 4096 * 3 / 4 = 3072 for underlayfs ext4 rather than
XATTR_SIZE_MAX = 65536 for nfs since the block size would be wsize
(=131072) if bsize is not specified.

Let's use pnfs_blksize first instead of using wsize directly if
bsize isn't specified. And the testcase itself can pass now.

Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna.schumaker@netapp.com>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
Considering bsize is not specified, we might use pnfs_blksize
directly first rather than wsize.

 fs/nfs/super.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index fe58525cfed4..5015edf0cd9a 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1068,9 +1068,13 @@ static void nfs_fill_super(struct super_block *sb, struct nfs_fs_context *ctx)
 	snprintf(sb->s_id, sizeof(sb->s_id),
 		 "%u:%u", MAJOR(sb->s_dev), MINOR(sb->s_dev));
 
-	if (sb->s_blocksize == 0)
-		sb->s_blocksize = nfs_block_bits(server->wsize,
+	if (sb->s_blocksize == 0) {
+		unsigned int blksize = server->pnfs_blksize ?
+			server->pnfs_blksize : server->wsize;
+
+		sb->s_blocksize = nfs_block_bits(blksize,
 						 &sb->s_blocksize_bits);
+	}
 
 	nfs_super_set_maxbytes(sb, server->maxfilesize);
 	server->has_sec_mnt_opts = ctx->has_sec_mnt_opts;
-- 
1.8.3.1

