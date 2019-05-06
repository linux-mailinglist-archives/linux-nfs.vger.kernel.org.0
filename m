Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49EE9143D3
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2019 05:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbfEFDwr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 5 May 2019 23:52:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34924 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725813AbfEFDwq (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 5 May 2019 23:52:46 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7CC15A01BD6B789E204F;
        Mon,  6 May 2019 11:52:44 +0800 (CST)
Received: from RH5885H-V3.huawei.com (10.90.53.225) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Mon, 6 May 2019 11:52:36 +0800
From:   ZhangXiaoxu <zhangxiaoxu5@huawei.com>
To:     <trond.myklebust@hammerspace.com>, <nna.schumaker@netapp.com>,
        <linux-nfs@vger.kernel.org>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH] NFS4: Fix v4.0 client state corruption when mount
Date:   Mon, 6 May 2019 11:57:03 +0800
Message-ID: <1557115023-86769-1-git-send-email-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

stat command with soft mount never return after server is stopped.

When alloc a new client, the state of the client will be set to
NFS4CLNT_LEASE_EXPIRED.

When the server is stopped, the state manager will work, and accord
the state to recover. But the state is NFS4CLNT_LEASE_EXPIRED, it
will drain the slot table and lead other task to wait queue, until
the client recovered. Then the stat command is hung.

When discover server trunking, the client will renew the lease,
but check the client state, it lead the client state corruption.

So, we need to call state manager to recover it when detect server
ip trunking.

Signed-off-by: ZhangXiaoxu <zhangxiaoxu5@huawei.com>
---
 fs/nfs/nfs4state.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 3de3647..f502f1c 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -159,6 +159,10 @@ int nfs40_discover_server_trunking(struct nfs_client *clp,
 		/* Sustain the lease, even if it's empty.  If the clientid4
 		 * goes stale it's of no use for trunking discovery. */
 		nfs4_schedule_state_renewal(*result);
+
+		/* If the client state need to recover, do it. */
+		if (clp->cl_state)
+			nfs4_schedule_state_manager(clp);
 	}
 out:
 	return status;
-- 
2.7.4

