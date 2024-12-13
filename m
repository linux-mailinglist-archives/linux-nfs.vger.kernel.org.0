Return-Path: <linux-nfs+bounces-8537-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB369F033B
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2024 04:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4698A162849
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2024 03:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6085D82866;
	Fri, 13 Dec 2024 03:46:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B4D39FD9;
	Fri, 13 Dec 2024 03:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734061560; cv=none; b=rS05+0356JlHKU/05WeeulMl8H7NqI5UQr3F8pWJjrj3ewc7ahczfYfDKf5FNKPeFn4NAB2b9aj23bVSoSWz6C8KTFgHLi+tTf/kDfxDy6xFZHZ4CYgyu2pfqc8y3pSvfYuNijtC48W8kZWixde4Wj3+03M+E8kXrxDBZ6vIIJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734061560; c=relaxed/simple;
	bh=4MtF0ddoPmtJmrgr8IJB5wJDaaEMwNuMox0UYP3pJYY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A9HXJYd+hfI15eXMKuREMd3QCvJ8tM4jrqnmyzE6pZF3RqRQw19FOLW03pZRZ8kEitDHORfs8gzDiUoxMtZD3+1melf9d/OcCFTnKBoSwvFnBDqlJp7dJJTf97zsTRG6cTnmTSbdVlnLlYsd2/vjUglcEoPqmWm3vuf0jskYsfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Y8Ztb65Kjz1T70Y;
	Fri, 13 Dec 2024 11:43:19 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 665BB140259;
	Fri, 13 Dec 2024 11:45:48 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 13 Dec
 2024 11:45:47 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>
CC: <trond.myklebust@hammerspace.com>, <jlayton@kernel.org>,
	<linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH] NFSv4: Fix deadlock during the running of state manager
Date: Fri, 13 Dec 2024 11:59:08 +0800
Message-ID: <20241213035908.1789132-1-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg500017.china.huawei.com (7.202.181.81)

Unlinking file may cause the following deadlock in state manager:
[root@localhost test]# cat /proc/2943/stack
[<0>] rpc_wait_bit_killable+0x1a/0x90
[<0>] _nfs4_proc_delegreturn+0x60f/0x760
[<0>] nfs4_proc_delegreturn+0x13d/0x2a0
[<0>] nfs_do_return_delegation+0xba/0x110
[<0>] nfs_end_delegation_return+0x32c/0x620
[<0>] nfs_complete_unlink+0xc7/0x290
[<0>] nfs_dentry_iput+0x36/0x50
[<0>] __dentry_kill+0xaa/0x250
[<0>] dput.part.0+0x26c/0x4d0
[<0>] __put_nfs_open_context+0x1d9/0x260
[<0>] nfs4_open_reclaim+0x77/0xa0
[<0>] nfs4_do_reclaim+0x385/0xf40
[<0>] nfs4_state_manager+0x762/0x14e0
[<0>] nfs4_run_state_manager+0x181/0x330
[<0>] kthread+0x1a7/0x1f0
[<0>] ret_from_fork+0x34/0x60
[<0>] ret_from_fork_asm+0x1a/0x30
[root@localhost test]#

It can be reproduced by following steps:
1) client: open file
2) client: unlink file
3) server: service restart(trigger state manager in client)
4) client: close file(in nfs4_open_reclaim, between nfs4_do_open_reclaim
and put_nfs_open_context)

Since the file has been open, unlinking will just set DCACHE_NFSFS_RENAMED
for the dentry like this:
nfs_unlink
 nfs_sillyrename
  nfs_async_unlink
   // set DCACHE_NFSFS_RENAMED

Restarting service will trigger state manager in client.
(1) NFS4_SLOT_TBL_DRAINING will be set to nfs4_slot_table since session
has been reset.
(2) DCACHE_NFSFS_RENAMED is detected in nfs_dentry_iput. Therefore,
nfs_complete_unlink is called to trigger delegation return.
(3) Due to the slot table being in draining state and sa_privileged being
0, the delegation return will be queued and wait.
nfs4_state_manager
 nfs4_reset_session
  nfs4_begin_drain_session
   nfs4_drain_slot_tbl
    // set NFS4_SLOT_TBL_DRAINING (1)
 nfs4_do_reclaim
  nfs4_open_reclaim
   __put_nfs_open_context
    __dentry_kill
     nfs_dentry_iput // check DCACHE_NFSFS_RENAMED (2)
      nfs_complete_unlink
       nfs_end_delegation_return
        nfs_do_return_delegation
         nfs4_proc_delegreturn
          _nfs4_proc_delegreturn
           rpc_run_task
            ...
            nfs4_delegreturn_prepare
             nfs4_setup_sequence
              nfs4_slot_tbl_draining // check NFS4_SLOT_TBL_DRAINING
                                     // and sa_privileged is 0 (3)
               rpc_sleep_on // set queued and add to slot_tbl_waitq
                // rpc_task is async and wait in __rpc_execute
           rpc_wait_for_completion_task
            __rpc_wait_for_completion_task
             out_of_line_wait_on_bit
              rpc_wait_bit_killable // wait for rpc_task to complete
 <-------- can not get here to wake up rpc_task -------->
 nfs4_end_drain_session
  nfs4_end_drain_slot_table
   nfs41_wake_slot_table

On the one hand, the state manager is blocked by the unfinished delegation
return. As a result, nfs4_end_drain_session cannot be invoked to clear
NFS4_SLOT_TBL_DRAINING and wake up waiting tasks.
On the other hand, since NFS4_SLOT_TBL_DRAINING is not cleared,
delegation return can only wait in the queue, resulting in a deadlock.

Fix it by turning the delegation return into a privileged operation for
the case where the nfs_client is in NFS4CLNT_RECLAIM_REBOOT state.

Fixes: 977fcc2b0b41 ("NFS: Add a delegation return into nfs4_proc_unlink_setup()")
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 fs/nfs/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 405f17e6e0b4..f3b1f2725c4e 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6878,7 +6878,7 @@ static int _nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred,
 		data->res.sattr_res = true;
 	}
 
-	if (!data->inode)
+	if (!data->inode || test_bit(NFS4CLNT_RECLAIM_REBOOT, &server->nfs_client->cl_state))
 		nfs4_init_sequence(&data->args.seq_args, &data->res.seq_res, 1,
 				   1);
 	else
-- 
2.31.1


