Return-Path: <linux-nfs+bounces-7332-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 130009A6C14
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 16:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 839151F21431
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 14:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE4D1F9A8E;
	Mon, 21 Oct 2024 14:26:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BDA1F5830
	for <linux-nfs@vger.kernel.org>; Mon, 21 Oct 2024 14:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729520785; cv=none; b=QHmOZANiWNIAGkBxpT9Wvzxy23pJx9KvSchjwBwRub7l5LbrlrgBHc/argsfzS30oQ3p2jWrd4Z+BkL4BEB42fGModFDvdxZ/LasoqHFFs6GcUvCJcTnqPjrI3kf3xmH18GDuJH3pN14oh2/gppEsqlNSOKmz93vW0iepHaOjHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729520785; c=relaxed/simple;
	bh=QfZprb2nBBdI/vOD2wkFopvrMphKxTZ3wwC+SMwcl2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WvgGAcRw32h5KvrCYBvQkBTJ/07kUfHJxOzjDKvc6bX/v4fiNbnPRB6/vUSVFvec4uCHGxz2b2omHHgzibz/JU+vN8m4LNFIqMc8BFGpGgvFFQH5GVHX2f46IRsNv0Ys3mvo0wHu++zc9tj0QpsdRZf6aa01c9Z6P5UOnNgmJQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XXHfd5Dbwz4f3jXn
	for <linux-nfs@vger.kernel.org>; Mon, 21 Oct 2024 22:26:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 185261A0568
	for <linux-nfs@vger.kernel.org>; Mon, 21 Oct 2024 22:26:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP3 (Coremail) with SMTP id _Ch0CgAHXIiFZBZnUg5KEg--.16803S7;
	Mon, 21 Oct 2024 22:26:18 +0800 (CST)
From: Yang Erkun <yangerkun@huaweicloud.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Cc: linux-nfs@vger.kernel.org,
	yangerkun@huawei.com,
	yangerkun@huaweicloud.com,
	yi.zhang@huawei.com
Subject: [PATCH 3/3] nfsd: release svc_expkey/svc_export with rcu_work
Date: Mon, 21 Oct 2024 22:23:43 +0800
Message-Id: <20241021142343.3857891-4-yangerkun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241021142343.3857891-1-yangerkun@huaweicloud.com>
References: <20241021142343.3857891-1-yangerkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHXIiFZBZnUg5KEg--.16803S7
X-Coremail-Antispam: 1UD129KBjvJXoWxtr1kGr1UCF1fAFyxGFykKrg_yoWxJw13pa
	s3Ga4fKaykJFyj9r4DJa1jvwnxtanavryxCr92kw4avF13tr1UJF18Zryj9ryYkrW8ua97
	uF4UtF4DGw18Za7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AK
	xVW8ZVWrXwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUUo7KUUUUU
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

From: Yang Erkun <yangerkun@huawei.com>

The last reference for `cache_head` can be reduced to zero in `c_show`
and `e_show`(using `rcu_read_lock` and `rcu_read_unlock`). Consequently,
`svc_export_put` and `expkey_put` will be invoked, leading to two
issues:

1. The `svc_export_put` will directly free ex_uuid. However,
   `e_show`/`c_show` will access `ex_uuid` after `cache_put`, which can
   trigger a use-after-free issue, shown below.

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

2. We cannot sleep while using `rcu_read_lock`/`rcu_read_unlock`.
   However, `svc_export_put`/`expkey_put` will call path_put, which
   subsequently triggers a sleeping operation due to the following
   `dput`.

   =============================
   WARNING: suspicious RCU usage
   5.10.0-dirty #141 Not tainted
   -----------------------------
   ...
   Call Trace:
   dump_stack+0x9a/0xd0
   ___might_sleep+0x231/0x240
   dput+0x39/0x600
   path_put+0x1b/0x30
   svc_export_put+0x17/0x80
   e_show+0x1c9/0x200
   seq_read_iter+0x63f/0x7c0
   seq_read+0x226/0x2d0
   vfs_read+0x113/0x2c0
   ksys_read+0xc9/0x170
   do_syscall_64+0x33/0x40
   entry_SYSCALL_64_after_hwframe+0x67/0xd1

Fix these issues by using `rcu_work` to help release
`svc_expkey`/`svc_export`. This approach allows for an asynchronous
context to invoke `path_put` and also facilitates the freeing of
`uuid/exp/key` after an RCU grace period.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 fs/nfsd/export.c | 31 +++++++++++++++++++++++++------
 fs/nfsd/export.h |  4 ++--
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 49aede376d86..6d0455973d64 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -40,15 +40,24 @@
 #define	EXPKEY_HASHMAX		(1 << EXPKEY_HASHBITS)
 #define	EXPKEY_HASHMASK		(EXPKEY_HASHMAX -1)
 
-static void expkey_put(struct kref *ref)
+static void expkey_put_work(struct work_struct *work)
 {
-	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
+	struct svc_expkey *key =
+		container_of(to_rcu_work(work), struct svc_expkey, ek_rcu_work);
 
 	if (test_bit(CACHE_VALID, &key->h.flags) &&
 	    !test_bit(CACHE_NEGATIVE, &key->h.flags))
 		path_put(&key->ek_path);
 	auth_domain_put(key->ek_client);
-	kfree_rcu(key, ek_rcu);
+	kfree(key);
+}
+
+static void expkey_put(struct kref *ref)
+{
+	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
+
+	INIT_RCU_WORK(&key->ek_rcu_work, expkey_put_work);
+	queue_rcu_work(system_wq, &key->ek_rcu_work);
 }
 
 static int expkey_upcall(struct cache_detail *cd, struct cache_head *h)
@@ -355,16 +364,26 @@ static void export_stats_destroy(struct export_stats *stats)
 					    EXP_STATS_COUNTERS_NUM);
 }
 
-static void svc_export_put(struct kref *ref)
+static void svc_export_put_work(struct work_struct *work)
 {
-	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
+	struct svc_export *exp =
+		container_of(to_rcu_work(work), struct svc_export, ex_rcu_work);
+
 	path_put(&exp->ex_path);
 	auth_domain_put(exp->ex_client);
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
+	INIT_RCU_WORK(&exp->ex_rcu_work, svc_export_put_work);
+	queue_rcu_work(system_wq, &exp->ex_rcu_work);
 }
 
 static int svc_export_upcall(struct cache_detail *cd, struct cache_head *h)
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index 3794ae253a70..081afb68681e 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -75,7 +75,7 @@ struct svc_export {
 	u32			ex_layout_types;
 	struct nfsd4_deviceid_map *ex_devid_map;
 	struct cache_detail	*cd;
-	struct rcu_head		ex_rcu;
+	struct rcu_work		ex_rcu_work;
 	unsigned long		ex_xprtsec_modes;
 	struct export_stats	*ex_stats;
 };
@@ -92,7 +92,7 @@ struct svc_expkey {
 	u32			ek_fsid[6];
 
 	struct path		ek_path;
-	struct rcu_head		ek_rcu;
+	struct rcu_work		ek_rcu_work;
 };
 
 #define EX_ISSYNC(exp)		(!((exp)->ex_flags & NFSEXP_ASYNC))
-- 
2.39.2


