Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05163AC1EE
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jun 2021 06:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhFREXe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Jun 2021 00:23:34 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:43364 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229522AbhFREXd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Jun 2021 00:23:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Ucn0dZ0_1623990056;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Ucn0dZ0_1623990056)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 18 Jun 2021 12:21:23 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-nfs@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH] nfs: fix acl memory leak of posix_acl_create()
Date:   Fri, 18 Jun 2021 12:20:55 +0800
Message-Id: <1623990055-222609-1-git-send-email-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When looking into another nfs xfstests report, I found acl and
default_acl in nfs3_proc_create() and nfs3_proc_mknod() error
paths are possibly leaked. Fix them in advance.

Fixes: 013cdf1088d7 ("nfs: use generic posix ACL infrastructure for v3 Posix ACLs")
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna.schumaker@netapp.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
If I read correctly..

 fs/nfs/nfs3proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 5c4e23abc345..2299446b3b89 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -385,7 +385,7 @@ static void nfs3_free_createdata(struct nfs3_createdata *data)
 				break;
 
 			case NFS3_CREATE_UNCHECKED:
-				goto out;
+				goto out_release_acls;
 		}
 		nfs_fattr_init(data->res.dir_attr);
 		nfs_fattr_init(data->res.fattr);
@@ -751,7 +751,7 @@ static int nfs3_proc_readdir(struct nfs_readdir_arg *nr_arg,
 		break;
 	default:
 		status = -EINVAL;
-		goto out;
+		goto out_release_acls;
 	}
 
 	d_alias = nfs3_do_create(dir, dentry, data);
-- 
1.8.3.1

