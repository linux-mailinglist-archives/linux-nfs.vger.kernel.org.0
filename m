Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64979EC217
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Nov 2019 12:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbfKALll (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Nov 2019 07:41:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44938 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726710AbfKALlk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 1 Nov 2019 07:41:40 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 76BFF4D15B998DB7EA0E;
        Fri,  1 Nov 2019 19:41:38 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Fri, 1 Nov 2019 19:41:28 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <bfields@redhat.com>, <chuck.lever@oracle.com>,
        <trond.myklebust@primarydata.com>, <dros@primarydata.com>,
        <jeff.layton@primarydata.com>, <richard.sharpe@primarydata.com>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Mao Wenan <maowenan@huawei.com>
Subject: [PATCH -next] nfsd: Drop LIST_HEAD where the variable it declares is never used.
Date:   Fri, 1 Nov 2019 19:40:54 +0800
Message-ID: <20191101114054.50225-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The declarations were introduced with the file, but the declared
variables were not used.

Fixes: 65294c1f2c5e ("nfsd: add a new struct file caching facility to nfsd")
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 fs/nfsd/filecache.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index ef55e9b..32a9bf2 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -685,8 +685,6 @@ nfsd_file_cache_purge(struct net *net)
 void
 nfsd_file_cache_shutdown(void)
 {
-	LIST_HEAD(dispose);
-
 	set_bit(NFSD_FILE_SHUTDOWN, &nfsd_file_lru_flags);
 
 	lease_unregister_notifier(&nfsd_file_lease_notifier);
-- 
2.7.4

