Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E58C125B39
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2019 07:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbfLSGHH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Dec 2019 01:07:07 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:33392 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725821AbfLSGHH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Dec 2019 01:07:07 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A0B9E1542B337B0C6FF0;
        Thu, 19 Dec 2019 14:07:04 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Thu, 19 Dec 2019
 14:06:57 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <linux-nfs@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH] NFS: move dprintk after nfs_alloc_fattr in nfs3_proc_lookup
Date:   Thu, 19 Dec 2019 14:14:18 +0800
Message-ID: <1576736058-111247-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In nfs3_proc_lookup, if nfs_alloc_fattr fails, will only print
"NFS call lookup". This may be confusing, move dprintk after
nfs_alloc_fattr.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 fs/nfs/nfs3proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 9eb2f1a..0703c05 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -169,11 +169,11 @@ nfs3_proc_lookup(struct inode *dir, const struct qstr *name,
 	};
 	int			status;

-	dprintk("NFS call  lookup %s\n", name->name);
 	res.dir_attr = nfs_alloc_fattr();
 	if (res.dir_attr == NULL)
 		return -ENOMEM;

+	dprintk("NFS call  lookup %s\n", name->name);
 	nfs_fattr_init(fattr);
 	status = rpc_call_sync(NFS_CLIENT(dir), &msg, 0);
 	nfs_refresh_inode(dir, res.dir_attr);
--
2.7.4

