Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0B5261B45
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2019 09:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfGHH3r (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jul 2019 03:29:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43940 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbfGHH3r (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 8 Jul 2019 03:29:47 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6C01AD0C097DF48D4C81;
        Mon,  8 Jul 2019 15:29:43 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Mon, 8 Jul 2019
 15:29:37 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] nfsd: Make two functions static
Date:   Mon, 8 Jul 2019 15:29:33 +0800
Message-ID: <20190708072933.50496-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fix sparse warnings:

fs/nfsd/nfs4state.c:1908:6: warning: symbol 'drop_client' was not declared. Should it be static?
fs/nfsd/nfs4state.c:2518:6: warning: symbol 'force_expire_client' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/nfsd/nfs4state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 94de5c3..7857942 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1905,7 +1905,7 @@ static void __free_client(struct kref *k)
 	kmem_cache_free(client_slab, clp);
 }
 
-void drop_client(struct nfs4_client *clp)
+static void drop_client(struct nfs4_client *clp)
 {
 	kref_put(&clp->cl_nfsdfs.cl_ref, __free_client);
 }
@@ -2515,7 +2515,7 @@ static const struct file_operations client_states_fops = {
  * so the caller has a guarantee that the client's locks are gone by
  * the time the write returns:
  */
-void force_expire_client(struct nfs4_client *clp)
+static void force_expire_client(struct nfs4_client *clp)
 {
 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 	bool already_expired;
-- 
2.7.4


