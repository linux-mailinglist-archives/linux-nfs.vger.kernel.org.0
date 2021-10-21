Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D422C435D1F
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Oct 2021 10:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhJUIoa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Oct 2021 04:44:30 -0400
Received: from mx24.baidu.com ([111.206.215.185]:45828 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231467AbhJUIoZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 21 Oct 2021 04:44:25 -0400
Received: from BC-Mail-Ex11.internal.baidu.com (unknown [172.31.51.51])
        by Forcepoint Email with ESMTPS id D74713269B6F6BE839CC;
        Thu, 21 Oct 2021 16:42:08 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex11.internal.baidu.com (172.31.51.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 21 Oct 2021 16:42:08 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 21 Oct 2021 16:42:08 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] NFSD: Make use of the helper macro kthread_run()
Date:   Thu, 21 Oct 2021 16:42:05 +0800
Message-ID: <20211021084206.2236-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-EX02.internal.baidu.com (172.31.51.42) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Repalce kthread_create/wake_up_process() with kthread_run()
to simplify the code.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 fs/nfsd/nfs4proc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index a36261f89bdf..69428cb31a55 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1685,15 +1685,15 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		memcpy(&copy->cp_res.cb_stateid, &copy->cp_stateid.stid,
 			sizeof(copy->cp_res.cb_stateid));
 		dup_copy_fields(copy, async_copy);
-		async_copy->copy_task = kthread_create(nfsd4_do_async_copy,
-				async_copy, "%s", "copy thread");
+		async_copy->copy_task = kthread_run(nfsd4_do_async_copy,
+						    async_copy, "%s",
+						    "copy thread");
 		if (IS_ERR(async_copy->copy_task))
 			goto out_err;
 		spin_lock(&async_copy->cp_clp->async_lock);
 		list_add(&async_copy->copies,
 				&async_copy->cp_clp->async_copies);
 		spin_unlock(&async_copy->cp_clp->async_lock);
-		wake_up_process(async_copy->copy_task);
 		status = nfs_ok;
 	} else {
 		status = nfsd4_do_copy(copy, 1);
-- 
2.25.1

