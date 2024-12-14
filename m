Return-Path: <linux-nfs+bounces-8560-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495569F1F2D
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Dec 2024 14:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE5F1633B7
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Dec 2024 13:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C9C17E015;
	Sat, 14 Dec 2024 13:52:59 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A62263C
	for <linux-nfs@vger.kernel.org>; Sat, 14 Dec 2024 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734184379; cv=none; b=XI2EXGjRc6AyTemZVpSDQCZQEPf6xg/6/Jo3kIqczhdH7kWWU53ecAvYghGWxau5SI1vaWvQxIiNCmE8h3J7C14Z9VomyIUS1p9fQmVQqSVw5mNpQEK5ALO7FCyssI6gnTYYofG+rsF9j2NyAmlZw48qRgoV+THUcEoSo1lgUBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734184379; c=relaxed/simple;
	bh=qpTg6JryKQvbZpVa2u/MN0Wfs8PZgblGqDCVnf4Yfv4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kZxwERCtP24FIvlPGV8XGAu4Pv2WDHGPH9s2TVjZLhAcrh6qesHKBgaHJzw+2g3Opb9pFO2csRVDoIWaiX0zwDQTHtxEjzIeSDcyGsxpluGshOCeQEJC+jseyJHhAmgVVODftaERNfC9qc9SB0JhIvG4NqCQ4B72jVMt4ePZOo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y9SM31pncz4f3jqC
	for <linux-nfs@vger.kernel.org>; Sat, 14 Dec 2024 21:52:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9BBAA1A018D
	for <linux-nfs@vger.kernel.org>; Sat, 14 Dec 2024 21:52:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCXcYWojV1n9+pTEg--.34271S4;
	Sat, 14 Dec 2024 21:52:45 +0800 (CST)
From: Yang Erkun <yangerkun@huaweicloud.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org
Cc: yangerkun@huawei.com,
	yangerkun@huaweicloud.com,
	liumingrui@huawei.com
Subject: [PATCH] nfsd: do not use async mode when not in rcu context
Date: Sat, 14 Dec 2024 21:49:16 +0800
Message-Id: <20241214134916.422488-1-yangerkun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXcYWojV1n9+pTEg--.34271S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZFyktFykJFy3Ww1UXF45GFg_yoWrCrW7pF
	WfJ3y3KaykJF1qgws8Ja4jvwnxK3WFv3s5Aw18G3yYvr15Jr18Cw1rZFyj9ryYqrW8W3y3
	Zr4jqa1DGw48ZFDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVW8
	ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRpOJnUUU
	UU=
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

From: Yang Erkun <yangerkun@huawei.com>

shell:

mkfs.xfs -f /dev/sda
echo "/ *(rw,no_root_squash,fsid=0)" > /etc/exports
echo "/mnt *(rw,no_root_squash,fsid=1)" >> /etc/exports
exportfs -ra
service nfs-server start
mount -t nfs -o vers=4.0 127.0.0.1:/mnt /mnt1
mount /dev/sda /mnt/sda
touch /mnt1/sda/file
exportfs -r
umount /mnt/sda

Commit f8c989a0c89a ("nfsd: release svc_expkey/svc_export with rcu_work")
describe that when we call e_show/c_show, the last reference can down to
0, and we will call expkey_put/svc_export_put with rcu context, this may
lead uaf or sleep in atomic bug. Finally, we introduce async mode to the
release and fix the bug. However, some other command may also finally call
expkey_put/svc_export_put without rcu context, but expect that the sync
mode for the resource release. Like upper shell, before that commit,
exportfs -r will remove all entry with sync mode, and the last umount
/mnt/sda will always success. But after this commit, the umount will always
fail, after we add some delay, they will success again. Personally, I think
is actually a bug, and need be fixed.

Use rcu_read_lock_any_held to distinguish does we really under rcu context,
and if no, release resource with sync mode.

Fixes: f8c989a0c89a ("nfsd: release svc_expkey/svc_export with rcu_work")
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 fs/nfsd/export.c | 44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index eacafe46e3b6..25f13e877c2f 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -40,11 +40,8 @@
 #define	EXPKEY_HASHMAX		(1 << EXPKEY_HASHBITS)
 #define	EXPKEY_HASHMASK		(EXPKEY_HASHMAX -1)
 
-static void expkey_put_work(struct work_struct *work)
+static void expkey_release(struct svc_expkey *key)
 {
-	struct svc_expkey *key =
-		container_of(to_rcu_work(work), struct svc_expkey, ek_rcu_work);
-
 	if (test_bit(CACHE_VALID, &key->h.flags) &&
 	    !test_bit(CACHE_NEGATIVE, &key->h.flags))
 		path_put(&key->ek_path);
@@ -52,12 +49,25 @@ static void expkey_put_work(struct work_struct *work)
 	kfree(key);
 }
 
+static void expkey_put_work(struct work_struct *work)
+{
+	struct svc_expkey *key =
+		container_of(to_rcu_work(work), struct svc_expkey, ek_rcu_work);
+
+	expkey_release(key);
+}
+
 static void expkey_put(struct kref *ref)
 {
 	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
 
-	INIT_RCU_WORK(&key->ek_rcu_work, expkey_put_work);
-	queue_rcu_work(system_wq, &key->ek_rcu_work);
+	if (rcu_read_lock_any_held()) {
+		INIT_RCU_WORK(&key->ek_rcu_work, expkey_put_work);
+		queue_rcu_work(system_wq, &key->ek_rcu_work);
+	} else {
+		synchronize_rcu();
+		expkey_release(key);
+	}
 }
 
 static int expkey_upcall(struct cache_detail *cd, struct cache_head *h)
@@ -364,11 +374,8 @@ static void export_stats_destroy(struct export_stats *stats)
 					    EXP_STATS_COUNTERS_NUM);
 }
 
-static void svc_export_put_work(struct work_struct *work)
+static void svc_export_release(struct svc_export *exp)
 {
-	struct svc_export *exp =
-		container_of(to_rcu_work(work), struct svc_export, ex_rcu_work);
-
 	path_put(&exp->ex_path);
 	auth_domain_put(exp->ex_client);
 	nfsd4_fslocs_free(&exp->ex_fslocs);
@@ -378,12 +385,25 @@ static void svc_export_put_work(struct work_struct *work)
 	kfree(exp);
 }
 
+static void svc_export_put_work(struct work_struct *work)
+{
+	struct svc_export *exp =
+		container_of(to_rcu_work(work), struct svc_export, ex_rcu_work);
+
+	svc_export_release(exp);
+}
+
 static void svc_export_put(struct kref *ref)
 {
 	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
 
-	INIT_RCU_WORK(&exp->ex_rcu_work, svc_export_put_work);
-	queue_rcu_work(system_wq, &exp->ex_rcu_work);
+	if (rcu_read_lock_any_held()) {
+		INIT_RCU_WORK(&exp->ex_rcu_work, svc_export_put_work);
+		queue_rcu_work(system_wq, &exp->ex_rcu_work);
+	} else {
+		synchronize_rcu();
+		svc_export_release(exp);
+	}
 }
 
 static int svc_export_upcall(struct cache_detail *cd, struct cache_head *h)
-- 
2.39.2


