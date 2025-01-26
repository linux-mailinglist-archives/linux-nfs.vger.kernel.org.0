Return-Path: <linux-nfs+bounces-9620-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A93A1C72B
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 10:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B00097A368B
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 09:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46033CA5A;
	Sun, 26 Jan 2025 09:29:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C1A78F29;
	Sun, 26 Jan 2025 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737883784; cv=none; b=gOZCzLk5cZKEDKgMBue7iMTjhsZL62X5YZz2VdhrtGSiiZFSsigxFu8F3GfGdSjjp6bXrWwO8wfGWtizBL+p7cLkIg9JjM5HtZ/JVZiwqBMwD8tQBymhlK19YesHrpyCrBMs0yRjAF+ClffUPe8EQULnYMbVe2OZZ5kMzb59AK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737883784; c=relaxed/simple;
	bh=8500zVhRxeLKrK23Se97zS22DC6j8AODhnCFY50bY+0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iv9Y+JuV7Tm4MUxN7nOgyUQ+PR9KTtqQdzvH/7qeKjSef2wW3vswW95LWBRkAr7Hp0N5nMmjSaZiZgqZOexzbCaGB05TdvfTCsd2cRVX1nsto/c7+kYbR7HLz2J5PjHZEYtRdBEwV1dQMlWiER06VyfIG68qbKGv4pU0TXFcp6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YgmRz6y3gzrSZR;
	Sun, 26 Jan 2025 17:27:59 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 1641A1401F4;
	Sun, 26 Jan 2025 17:29:38 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 26 Jan
 2025 17:29:36 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
	<okorniev@redhat.com>, <kolga@netapp.com>, <Dai.Ngo@oracle.com>,
	<tom@talpey.com>, <Trond.Myklebust@netapp.com>, <rick.macklem@gmail.com>,
	<zhangjian496@huawei.com>, <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH v2] nfsd: clear acl_access/acl_default after releasing them
Date: Sun, 26 Jan 2025 17:47:22 +0800
Message-ID: <20250126094722.738358-1-lilingfeng3@huawei.com>
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

If getting acl_default fails, acl_access and acl_default will be released
simultaneously. However, acl_access will still retain a pointer pointing
to the released posix_acl, which will trigger a WARNING in
nfs3svc_release_getacl like this:

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 26 PID: 3199 at lib/refcount.c:28
refcount_warn_saturate+0xb5/0x170
Modules linked in:
CPU: 26 UID: 0 PID: 3199 Comm: nfsd Not tainted
6.12.0-rc6-00079-g04ae226af01f-dirty #8
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.1-2.fc37 04/01/2014
RIP: 0010:refcount_warn_saturate+0xb5/0x170
Code: cc cc 0f b6 1d b3 20 a5 03 80 fb 01 0f 87 65 48 d8 00 83 e3 01 75
e4 48 c7 c7 c0 3b 9b 85 c6 05 97 20 a5 03 01 e8 fb 3e 30 ff <0f> 0b eb
cd 0f b6 1d 8a3
RSP: 0018:ffffc90008637cd8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff83904fde
RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffff88871ed36380
RBP: ffff888158beeb40 R08: 0000000000000001 R09: fffff520010c6f56
R10: ffffc90008637ab7 R11: 0000000000000001 R12: 0000000000000001
R13: ffff888140e77400 R14: ffff888140e77408 R15: ffffffff858b42c0
FS:  0000000000000000(0000) GS:ffff88871ed00000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562384d32158 CR3: 000000055cc6a000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? refcount_warn_saturate+0xb5/0x170
 ? __warn+0xa5/0x140
 ? refcount_warn_saturate+0xb5/0x170
 ? report_bug+0x1b1/0x1e0
 ? handle_bug+0x53/0xa0
 ? exc_invalid_op+0x17/0x40
 ? asm_exc_invalid_op+0x1a/0x20
 ? tick_nohz_tick_stopped+0x1e/0x40
 ? refcount_warn_saturate+0xb5/0x170
 ? refcount_warn_saturate+0xb5/0x170
 nfs3svc_release_getacl+0xc9/0xe0
 svc_process_common+0x5db/0xb60
 ? __pfx_svc_process_common+0x10/0x10
 ? __rcu_read_unlock+0x69/0xa0
 ? __pfx_nfsd_dispatch+0x10/0x10
 ? svc_xprt_received+0xa1/0x120
 ? xdr_init_decode+0x11d/0x190
 svc_process+0x2a7/0x330
 svc_handle_xprt+0x69d/0x940
 svc_recv+0x180/0x2d0
 nfsd+0x168/0x200
 ? __pfx_nfsd+0x10/0x10
 kthread+0x1a2/0x1e0
 ? kthread+0xf4/0x1e0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x34/0x60
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel panic - not syncing: kernel: panic_on_warn set ...

Clear acl_access/acl_default after posix_acl_release is called to prevent
UAF from being triggered.

Fixes: a257cdd0e217 ("[PATCH] NFSD: Add server support for NFSv3 ACLs.")
Link: https://lore.kernel.org/all/20241107014705.2509463-1-lilingfeng@huaweicloud.com/
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
Changes in v2:
- Clear acl_access/acl_default after releasing them, instead of
  modifying the logic for setting them.
- Clear acl_access/acl_default in nfs2acl.c.
---
 fs/nfsd/nfs2acl.c | 2 ++
 fs/nfsd/nfs3acl.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 4e3be7201b1c..5fb202acb0fd 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -84,6 +84,8 @@ static __be32 nfsacld_proc_getacl(struct svc_rqst *rqstp)
 fail:
 	posix_acl_release(resp->acl_access);
 	posix_acl_release(resp->acl_default);
+	resp->acl_access = NULL;
+	resp->acl_default = NULL;
 	goto out;
 }
 
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 5e34e98db969..7b5433bd3019 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -76,6 +76,8 @@ static __be32 nfsd3_proc_getacl(struct svc_rqst *rqstp)
 fail:
 	posix_acl_release(resp->acl_access);
 	posix_acl_release(resp->acl_default);
+	resp->acl_access = NULL;
+	resp->acl_default = NULL;
 	goto out;
 }
 
-- 
2.31.1


