Return-Path: <linux-nfs+bounces-11713-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F6EAB64D2
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 09:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69AD03A557C
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 07:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2904202C48;
	Wed, 14 May 2025 07:50:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607B91E503C;
	Wed, 14 May 2025 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747209000; cv=none; b=J7SnfTpsVzY1mCYTwcmojY4nwSoRZZcmE4ydo/pdNcV82dcRhQH/uOXfM88hMNd5vSjcW9IE0+1gvFI6HX7S7EPzZyTYr3mjtQRVtG7s54uARLgriSrFipOO1hMeg7Q6CeumWuvHzjpPqt4Lw6A3aakrBshfXA07yapbOJnHOeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747209000; c=relaxed/simple;
	bh=oi5Bc75/tDYrWnhLecmkWZAtXFeghVW3wUO9i/tb7NI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bf0cMck1Uc3EbNduARoxxeGJdvsLlPFIqeuHR5dOrnU0ApJHVbnJEO0QxbwNPe1I/E8e4BgnAIUx1mjQtB1f+eFyJJOSBFwdJrU9CE2tSZKzfsO/p4vIujyigpaegw3dOMnW3XeobAH2PZGpFczPeQhMo6wFaWSIKyDUwjlttPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Zy5402Bt6zyQhn;
	Wed, 14 May 2025 15:45:36 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id C3D64180330;
	Wed, 14 May 2025 15:49:54 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 14 May
 2025 15:49:53 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>, <jlayton@kernel.org>,
	<bcodding@redhat.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH v3] nfs: handle failure of nfs_get_lock_context in unlock path
Date: Wed, 14 May 2025 16:08:39 +0800
Message-ID: <20250514080839.298300-1-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg500017.china.huawei.com (7.202.181.81)

When memory is insufficient, the allocation of nfs_lock_context in
nfs_get_lock_context() fails and returns -ENOMEM. If we mistakenly treat
an nfs4_unlockdata structure (whose l_ctx member has been set to -ENOMEM)
as valid and proceed to execute rpc_run_task(), this will trigger a NULL
pointer dereference in nfs4_locku_prepare. For example:

BUG: kernel NULL pointer dereference, address: 000000000000000c
PGD 0 P4D 0
Oops: Oops: 0000 [#1] SMP PTI
CPU: 15 UID: 0 PID: 12 Comm: kworker/u64:0 Not tainted 6.15.0-rc2-dirty #60
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40
Workqueue: rpciod rpc_async_schedule
RIP: 0010:nfs4_locku_prepare+0x35/0xc2
Code: 89 f2 48 89 fd 48 c7 c7 68 69 ef b5 53 48 8b 8e 90 00 00 00 48 89 f3
RSP: 0018:ffffbbafc006bdb8 EFLAGS: 00010246
RAX: 000000000000004b RBX: ffff9b964fc1fa00 RCX: 0000000000000000
RDX: 0000000000000000 RSI: fffffffffffffff4 RDI: ffff9ba53fddbf40
RBP: ffff9ba539934000 R08: 0000000000000000 R09: ffffbbafc006bc38
R10: ffffffffb6b689c8 R11: 0000000000000003 R12: ffff9ba539934030
R13: 0000000000000001 R14: 0000000004248060 R15: ffffffffb56d1c30
FS: 0000000000000000(0000) GS:ffff9ba5881f0000(0000) knlGS:00000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000000000c CR3: 000000093f244000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 __rpc_execute+0xbc/0x480
 rpc_async_schedule+0x2f/0x40
 process_one_work+0x232/0x5d0
 worker_thread+0x1da/0x3d0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x10d/0x240
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x34/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Modules linked in:
CR2: 000000000000000c
---[ end trace 0000000000000000 ]---

Free the allocated nfs4_unlockdata when nfs_get_lock_context() fails and
return NULL to terminate subsequent rpc_run_task, preventing NULL pointer
dereference.

Fixes: f30cb757f680 ("NFS: Always wait for I/O completion before unlock")
Link: https://lore.kernel.org/all/21817f2c-2971-4568-9ae4-1ccc25f7f1ef@huawei.com/
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
Changes in v3:
  Handle the error case first.
 fs/nfs/nfs4proc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 970f28dbf253..d51381bd91a9 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7074,18 +7074,28 @@ static struct nfs4_unlockdata *nfs4_alloc_unlockdata(struct file_lock *fl,
 	struct nfs4_unlockdata *p;
 	struct nfs4_state *state = lsp->ls_state;
 	struct inode *inode = state->inode;
+	struct nfs_lock_context *l_ctx;
 
 	p = kzalloc(sizeof(*p), GFP_KERNEL);
 	if (p == NULL)
 		return NULL;
+	l_ctx = nfs_get_lock_context(ctx);
+	if (IS_ERR(l_ctx)) {
+		kfree(p);
+		return NULL;
+	}
 	p->arg.fh = NFS_FH(inode);
 	p->arg.fl = &p->fl;
 	p->arg.seqid = seqid;
 	p->res.seqid = seqid;
 	p->lsp = lsp;
 	/* Ensure we don't close file until we're done freeing locks! */
+	/*
+	 * Since the caller holds a reference to ctx, the refcount must be non-zero.
+	 * Therefore, error handling for failed ctx acquisition is unnecessary here.
+	 */
 	p->ctx = get_nfs_open_context(ctx);
-	p->l_ctx = nfs_get_lock_context(ctx);
+	p->l_ctx = l_ctx;
 	locks_init_lock(&p->fl);
 	locks_copy_lock(&p->fl, fl);
 	p->server = NFS_SERVER(inode);
-- 
2.31.1


