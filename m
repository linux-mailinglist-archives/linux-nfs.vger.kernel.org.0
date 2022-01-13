Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29F548D06B
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jan 2022 03:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiAMC0K (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Jan 2022 21:26:10 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:36146 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231593AbiAMC0I (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Jan 2022 21:26:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V1hG1CA_1642040765;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V1hG1CA_1642040765)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 Jan 2022 10:26:06 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     kolga@netapp.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] NFS: Fix nfs4_proc_get_locations() kernel-doc comment
Date:   Thu, 13 Jan 2022 10:26:04 +0800
Message-Id: <20220113022604.25617-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add the description of @server and @fhandle, and remove the excess
@inode in nfs4_proc_get_locations() kernel-doc comment to remove
warnings found by running scripts/kernel-doc, which is caused by
using 'make W=1'.

fs/nfs/nfs4proc.c:8219: warning: Function parameter or member 'server'
not described in 'nfs4_proc_get_locations'
fs/nfs/nfs4proc.c:8219: warning: Function parameter or member 'fhandle'
not described in 'nfs4_proc_get_locations'
fs/nfs/nfs4proc.c:8219: warning: Excess function parameter 'inode'
description in 'nfs4_proc_get_locations'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/nfs/nfs4proc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e6b49d6318bc..2fc814185fba 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8197,7 +8197,8 @@ int nfs4_set_nfs4_statx(struct inode *inode,
 
 /**
  * nfs4_proc_get_locations - discover locations for a migrated FSID
- * @inode: inode on FSID that is migrating
+ * @server: pointer to nfs_server to process
+ * @fhandle: pointer to the kernel NFS client file handle
  * @locations: result of query
  * @page: buffer
  * @cred: credential to use for this operation
-- 
2.20.1.7.g153144c

