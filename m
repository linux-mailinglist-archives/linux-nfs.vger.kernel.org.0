Return-Path: <linux-nfs+bounces-10160-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E92BA39DC7
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 14:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C86ED7A51A6
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 13:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3F62698B8;
	Tue, 18 Feb 2025 13:37:10 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B9A246326;
	Tue, 18 Feb 2025 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885830; cv=none; b=ivbczuF+UUgYgV3GxwEmM7J8CnL+Wt27pETfr7dNT64jjZjDpyxiyZOe7wpDVtCUrErUgZs/bPd5zt6B0+GpHu7igZrjs7JXDxwOVGWccT47dW7x1pwYlRP7kduQA7CErgK8gvKfLfoI+Z8HuF6dnNiEJlen07BI5QGkysOwmYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885830; c=relaxed/simple;
	bh=RgZzlg6Ld/avdXkpvLKLeXpzWvHVcfkymWlll9vVukw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SBXFU2IwzkacvfMN3N1SZsnVIg+Uqtjs541b/acbak3ZaeicsqnUHJlo8WVAA0yhu0cLQcLzoZTTkWKHR0zGCTfW9vY+8UbcCHcvWd73V/h0OwvTuU9if0gaGQg7/aSG0zCR3sBKo7QMApVB85Rzsy+/eHjVNDi1YyjY7mCH/kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Yy0ps3l8lzhZtG;
	Tue, 18 Feb 2025 21:33:41 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id B37EC1800DB;
	Tue, 18 Feb 2025 21:37:04 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 18 Feb
 2025 21:37:03 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
	<okorniev@redhat.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH] nfsd: decrease cl_cb_inflight if fail to queue cb_work
Date: Tue, 18 Feb 2025 21:54:23 +0800
Message-ID: <20250218135423.1487309-1-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg500017.china.huawei.com (7.202.181.81)

In nfsd4_run_cb, cl_cb_inflight is increased before attempting to queue
cb_work to callback_wq. This count can be decreased in three situations:
1) If queuing fails in nfsd4_run_cb, the count will be decremented
accordingly.
2) After cb_work is running, the count is decreased in the exception
branch of nfsd4_run_cb_work via nfsd41_destroy_cb.
3) The count is decreased in the release callback of rpc_task — either
directly calling nfsd41_cb_inflight_end in nfsd4_cb_probe_release, or
calling nfsd41_destroy_cb in nfsd4_cb_release.

However, in nfsd4_cb_release, if the current cb_work needs to restart, the
count will not be decreased, with the expectation that it will be reduced
once cb_work is running.
If queuing fails here, then the count will leak, ultimately causing the
nfsd service to be unable to exit as shown below:
[root@nfs_test2 ~]# cat /proc/2271/stack
[<0>] nfsd4_shutdown_callback+0x22b/0x290
[<0>] __destroy_client+0x3cd/0x5c0
[<0>] nfs4_state_destroy_net+0xd2/0x330
[<0>] nfs4_state_shutdown_net+0x2ad/0x410
[<0>] nfsd_shutdown_net+0xb7/0x250
[<0>] nfsd_last_thread+0x15f/0x2a0
[<0>] nfsd_svc+0x388/0x3f0
[<0>] write_threads+0x17e/0x2b0
[<0>] nfsctl_transaction_write+0x91/0xf0
[<0>] vfs_write+0x1c4/0x750
[<0>] ksys_write+0xcb/0x170
[<0>] do_syscall_64+0x70/0x120
[<0>] entry_SYSCALL_64_after_hwframe+0x78/0xe2
[root@nfs_test2 ~]#

Fix this by decreasing cl_cb_inflight if the restart fails.

Fixes: cba5f62b1830 ("nfsd: fix callback restarts")
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 fs/nfsd/nfs4callback.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 484077200c5d..8a7d24efdd08 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1459,12 +1459,16 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
 static void nfsd4_cb_release(void *calldata)
 {
 	struct nfsd4_callback *cb = calldata;
+	struct nfs4_client *clp = cb->cb_clp;
+	int queued;
 
 	trace_nfsd_cb_rpc_release(cb->cb_clp);
 
-	if (cb->cb_need_restart)
-		nfsd4_queue_cb(cb);
-	else
+	if (cb->cb_need_restart) {
+		queued = nfsd4_queue_cb(cb);
+		if (!queued)
+			nfsd41_cb_inflight_end(clp);
+	} else
 		nfsd41_destroy_cb(cb);
 
 }
-- 
2.31.1


