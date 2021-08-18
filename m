Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B2F3EF7B6
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Aug 2021 03:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbhHRBwy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Aug 2021 21:52:54 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:17032 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbhHRBwx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 Aug 2021 21:52:53 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gq9m20TMQzbblL;
        Wed, 18 Aug 2021 09:48:34 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 18
 Aug 2021 09:52:17 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next] NFSv3: Delete duplicate judgement in nfs3_async_handle_jukebox
Date:   Wed, 18 Aug 2021 10:02:52 +0800
Message-ID: <20210818020252.3708891-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

As eb96d5c97b08 ("SUNRPC handle EKEYEXPIRED in call_refreshresult")
commit handle EKEYEXPIRED in call_refreshresult, so there is only handle
when "task->tk_status" is equal "-EJUKEBOX" in nfs3_async_handle_jukebox.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/nfs/nfs3proc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 2299446b3b89..f7524310ddf4 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -49,8 +49,7 @@ nfs3_async_handle_jukebox(struct rpc_task *task, struct inode *inode)
 {
 	if (task->tk_status != -EJUKEBOX)
 		return 0;
-	if (task->tk_status == -EJUKEBOX)
-		nfs_inc_stats(inode, NFSIOS_DELAY);
+	nfs_inc_stats(inode, NFSIOS_DELAY);
 	task->tk_status = 0;
 	rpc_restart_call(task);
 	rpc_delay(task, NFS_JUKEBOX_RETRY_TIME);
-- 
2.31.1

