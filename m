Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3043C9FC9A
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2019 10:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfH1IGh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 04:06:37 -0400
Received: from mgwym01.jp.fujitsu.com ([211.128.242.40]:22981 "EHLO
        mgwym01.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfH1IGh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Aug 2019 04:06:37 -0400
X-Greylist: delayed 670 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Aug 2019 04:06:35 EDT
Received: from yt-mxoi1.gw.nic.fujitsu.com (unknown [192.168.229.67]) by mgwym01.jp.fujitsu.com with smtp
         id 1a8f_35ab_b7ce99b1_367d_4ac0_9a7b_582933f0df42;
        Wed, 28 Aug 2019 16:55:22 +0900
Received: from g01jpfmpwyt03.exch.g01.fujitsu.local (g01jpfmpwyt03.exch.g01.fujitsu.local [10.128.193.57])
        by yt-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id 95299AC0229
        for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2019 16:55:21 +0900 (JST)
Received: from g01jpexchyt36.g01.fujitsu.local (unknown [10.128.193.4])
        by g01jpfmpwyt03.exch.g01.fujitsu.local (Postfix) with ESMTP id CB8F446E51A;
        Wed, 28 Aug 2019 16:55:20 +0900 (JST)
Received: from luna3.soft.fujitsu.com (10.124.196.199) by
 g01jpexchyt36.g01.fujitsu.local (10.128.193.54) with Microsoft SMTP Server id
 14.3.439.0; Wed, 28 Aug 2019 16:55:20 +0900
From:   Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
To:     <linux-nfs@vger.kernel.org>, <trond.myklebust@hammerspace.com>
CC:     <misono.tomohiro@jp.fujitsu.com>
Subject: [PATCH] NFS: direct.c: Fix memory leak of dreq when nfs_get_lock_context fails
Date:   Wed, 28 Aug 2019 17:01:22 +0900
Message-ID: <20190828080122.22123-1-misono.tomohiro@jp.fujitsu.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-GCONF: 00
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When dreq is allocated by nfs_direct_req_alloc(), dreq->kref is
initialized to 2. Therefore we need to call nfs_direct_req_release()
twice to release the allocated dreq. Usually it is called in
nfs_file_direct_{read, write}() and nfs_direct_complete().

However, current code only calls nfs_direct_req_relese() once if
nfs_get_lock_context() fails in nfs_file_direct_{read, write}().
So, that case would result in memory leak.

Fix this by adding the missing call.

Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
---
 Hello,

 I noticed this when reading the code.

 Thanks.

 fs/nfs/direct.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 0cb442406168..18eff685e5fe 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -586,6 +586,7 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter)
 	l_ctx = nfs_get_lock_context(dreq->ctx);
 	if (IS_ERR(l_ctx)) {
 		result = PTR_ERR(l_ctx);
+		nfs_direct_req_release(dreq);
 		goto out_release;
 	}
 	dreq->l_ctx = l_ctx;
@@ -1014,6 +1015,7 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter)
 	l_ctx = nfs_get_lock_context(dreq->ctx);
 	if (IS_ERR(l_ctx)) {
 		result = PTR_ERR(l_ctx);
+		nfs_direct_req_release(dreq);
 		goto out_release;
 	}
 	dreq->l_ctx = l_ctx;
-- 
2.20.1

