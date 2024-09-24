Return-Path: <linux-nfs+bounces-6624-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3F5983B41
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Sep 2024 04:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F6D1C20C31
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Sep 2024 02:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA03C8EB;
	Tue, 24 Sep 2024 02:36:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73E71B85DA;
	Tue, 24 Sep 2024 02:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727145368; cv=none; b=Suq9W694O5uq0L3yfcfFCyQ9U/NadR/mAxbb2a4Qol2ON/Is9GQNn2WuCypaTzaUOPx3I+afFjsxsu/Qsm7Ws4GJ2tnnkBhnoarYTNUwSxVdtyW5+YRAW3UUL+RRDo8x/VfLDetFgbnlSBMTxVMWxLNIJ9KsP+bKctN74ZYUt/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727145368; c=relaxed/simple;
	bh=h/9KeGAQlE4FEuRlNyt97Jd0e9xZmPRkV6TE6oY+udQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B5L7pAlYZTk0uV3iwYK8mJthatvwcUUfjz4K3Ql4h5gQKBS87iisabEledMBzI1dtjthIuWKy0Snh7tT65O8G9WGpIRwEszIYxv3IKio5Odo3i88DTEpDN7/7KXkCKkq3JXMMnyVYg6UkIxjAnFvIZ4fQXcyipAuNqYEMPXm3Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XCP9070bBz1SBTc;
	Tue, 24 Sep 2024 10:35:16 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E95D1A016C;
	Tue, 24 Sep 2024 10:36:03 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 24 Sep
 2024 10:36:02 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>
CC: <trond.myklebust@hammerspace.com>, <jlayton@kernel.org>,
	<linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH] nfs: maintain nfs_server in the reclaim process
Date: Tue, 24 Sep 2024 10:45:21 +0800
Message-ID: <20240924024521.2898776-1-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg500017.china.huawei.com (7.202.181.81)

In the reclaim process, there may be a situation where all files are
closed and the file system is unmounted, which will result in the release
of nfs_server.
This will trigger UAF in nfs4_put_open_state when the count of nfs4_state
is decremented to zero, because the freed nfs_server will be accessed
when evicting inode.

Maintaining the nfs_server throughout the entire reclaim process by adding
nfs_sb_active and nfs_sb_deactive to fix it.

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 fs/nfs/nfs4state.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 877f682b45f2..f09f63b5a7c0 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1934,6 +1934,8 @@ static int nfs4_do_reclaim(struct nfs_client *clp, const struct nfs4_state_recov
 restart:
 	rcu_read_lock();
 	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link) {
+		if (!(server->super && nfs_sb_active(server->super)))
+			continue;
 		nfs4_purge_state_owners(server, &freeme);
 		spin_lock(&clp->cl_lock);
 		for (pos = rb_first(&server->state_owners);
@@ -1942,10 +1944,14 @@ static int nfs4_do_reclaim(struct nfs_client *clp, const struct nfs4_state_recov
 			sp = rb_entry(pos,
 				struct nfs4_state_owner, so_server_node);
 			if (!test_and_clear_bit(ops->owner_flag_bit,
-							&sp->so_flags))
+							&sp->so_flags)) {
+				nfs_sb_deactive(server->super);
 				continue;
-			if (!atomic_inc_not_zero(&sp->so_count))
+			}
+			if (!atomic_inc_not_zero(&sp->so_count)) {
+				nfs_sb_deactive(server->super);
 				continue;
+			}
 			spin_unlock(&clp->cl_lock);
 			rcu_read_unlock();
 
@@ -1961,9 +1967,11 @@ static int nfs4_do_reclaim(struct nfs_client *clp, const struct nfs4_state_recov
 			}
 
 			nfs4_put_state_owner(sp);
+			nfs_sb_deactive(server->super);
 			goto restart;
 		}
 		spin_unlock(&clp->cl_lock);
+		nfs_sb_deactive(server->super);
 	}
 	rcu_read_unlock();
 	nfs4_free_state_owners(&freeme);
-- 
2.31.1


