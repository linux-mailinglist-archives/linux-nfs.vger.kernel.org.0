Return-Path: <linux-nfs+bounces-8775-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D89D9FC3E2
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2024 08:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843F81883614
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2024 07:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D89153BC1;
	Wed, 25 Dec 2024 07:02:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC44145FFF;
	Wed, 25 Dec 2024 07:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735110177; cv=none; b=WbA375fWWgliY9QgQjzzIb+FhCGWN+LWuGDwQxsOqbixxoa8iP2YKP+hfsEKUaDOdvwaesGu/nNSWgt/w9gyXmdCJl+B16sdyvvESxRKBwTpYGTFBYQFqB2qLqJdlFbRyQ4/CA1SMPWd3LYCctFPfa56IigMkv4Z3aNCOSdI+2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735110177; c=relaxed/simple;
	bh=Yyjz2J7ZGAJ0mIRmPMOtulZnv0T+LazP7gUqsED1r4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wxx9n5UI0sIygNcNdqb9w07eXALW93+4I/3UViREYoNwvVkQQ5UYSE07Zuv3eRk0Jt2TrF0yeRGM/Zq0U5/FBE8Zpxr1ti0GrzW7ok2VXlPiJu9ARRJviCik+kZ/ARunfW9ERiireHCZ6bf7VT62KiSjAsvXm7UY05GQhQTdrvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YJ2kz3bFkz4f3jqq;
	Wed, 25 Dec 2024 15:02:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 229761A06E6;
	Wed, 25 Dec 2024 15:02:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgAHL4MRrmtnO8dPFg--.38269S8;
	Wed, 25 Dec 2024 15:02:49 +0800 (CST)
From: Yang Erkun <yangerkun@huawei.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	yangerkun@huawei.com,
	yangerkun@huaweicloud.com,
	liumingrui@huawei.com
Subject: [PATCH v2 4/4] nfsd: fix UAF when access ex_uuid or ex_stats
Date: Wed, 25 Dec 2024 14:59:08 +0800
Message-ID: <20241225065908.1547645-5-yangerkun@huawei.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241225065908.1547645-1-yangerkun@huawei.com>
References: <20241225065908.1547645-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHL4MRrmtnO8dPFg--.38269S8
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1fWFy8Kw43Ar13GFWfXwb_yoW5tFWrpa
	4kAayxJrykJFyUArsFy3Wjqw1ftanavr1I9rn2kw4a9F13tr18CFy5Zryq9ryjkrW8Cayx
	u3WjyFs8Gw4FywUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7Iv64x0x7Aq67IIx4CEVc8vx2IErcIFxwACI4
	02YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCF
	04k20xvEw4C26cxK6c8Ij28IcwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU0sXo7
	UUUUU==
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

We can access exp->ex_stats or exp->ex_uuid in rcu context(c_show and
e_show). All these resources should be released using kfree_rcu. Fix this
by using call_rcu, clean them all after a rcu grace period.

==================================================================
BUG: KASAN: slab-use-after-free in svc_export_show+0x362/0x430 [nfsd]
Read of size 1 at addr ff11000010fdc120 by task cat/870

CPU: 1 UID: 0 PID: 870 Comm: cat Not tainted 6.12.0-rc3+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.1-2.fc37 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x53/0x70
 print_address_description.constprop.0+0x2c/0x3a0
 print_report+0xb9/0x280
 kasan_report+0xae/0xe0
 svc_export_show+0x362/0x430 [nfsd]
 c_show+0x161/0x390 [sunrpc]
 seq_read_iter+0x589/0x770
 seq_read+0x1e5/0x270
 proc_reg_read+0xe1/0x140
 vfs_read+0x125/0x530
 ksys_read+0xc1/0x160
 do_syscall_64+0x5f/0x170
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Allocated by task 830:
 kasan_save_stack+0x20/0x40
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0x8f/0xa0
 __kmalloc_node_track_caller_noprof+0x1bc/0x400
 kmemdup_noprof+0x22/0x50
 svc_export_parse+0x8a9/0xb80 [nfsd]
 cache_do_downcall+0x71/0xa0 [sunrpc]
 cache_write_procfs+0x8e/0xd0 [sunrpc]
 proc_reg_write+0xe1/0x140
 vfs_write+0x1a5/0x6d0
 ksys_write+0xc1/0x160
 do_syscall_64+0x5f/0x170
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Freed by task 868:
 kasan_save_stack+0x20/0x40
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0x37/0x50
 kfree+0xf3/0x3e0
 svc_export_put+0x87/0xb0 [nfsd]
 cache_purge+0x17f/0x1f0 [sunrpc]
 nfsd_destroy_serv+0x226/0x2d0 [nfsd]
 nfsd_svc+0x125/0x1e0 [nfsd]
 write_threads+0x16a/0x2a0 [nfsd]
 nfsctl_transaction_write+0x74/0xa0 [nfsd]
 vfs_write+0x1a5/0x6d0
 ksys_write+0xc1/0x160
 do_syscall_64+0x5f/0x170
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: ae74136b4bb6 ("SUNRPC: Allow cache lookups to use RCU protection rather than the r/w spinlock")
Reviewed-by: NeilBrown <neilb@suse.de>
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 fs/nfsd/export.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index c6168bccfb6c..0363720280d4 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -355,16 +355,25 @@ static void export_stats_destroy(struct export_stats *stats)
 					    EXP_STATS_COUNTERS_NUM);
 }
 
-static void svc_export_put(struct kref *ref)
+static void svc_export_release(struct rcu_head *rcu_head)
 {
-	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
-	path_put(&exp->ex_path);
-	auth_domain_put(exp->ex_client);
+	struct svc_export *exp = container_of(rcu_head, struct svc_export,
+			ex_rcu);
+
 	nfsd4_fslocs_free(&exp->ex_fslocs);
 	export_stats_destroy(exp->ex_stats);
 	kfree(exp->ex_stats);
 	kfree(exp->ex_uuid);
-	kfree_rcu(exp, ex_rcu);
+	kfree(exp);
+}
+
+static void svc_export_put(struct kref *ref)
+{
+	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
+
+	path_put(&exp->ex_path);
+	auth_domain_put(exp->ex_client);
+	call_rcu(&exp->ex_rcu, svc_export_release);
 }
 
 static int svc_export_upcall(struct cache_detail *cd, struct cache_head *h)
-- 
2.46.1


