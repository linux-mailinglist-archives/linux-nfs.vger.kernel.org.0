Return-Path: <linux-nfs+bounces-8578-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474119F332B
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2024 15:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9F2E1625AF
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2024 14:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186ED206292;
	Mon, 16 Dec 2024 14:25:40 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9407205E25;
	Mon, 16 Dec 2024 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734359140; cv=none; b=igFViJ20BpVqycq6iWu3tUWHtPq12tHwFtuTz2oJrAAJ+o57aTFBL/WxS33POYoIIGeD+pHbw1eSetugQMiL8/9sL9aju1rvitSQarqMFMJhJTYd5RHIdUtjwz8NbMsEgkOeht8kGCHW5UleG/g79hsQR34W2xC51wnaEXOi1DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734359140; c=relaxed/simple;
	bh=FJ+zZo7Q4MEMV6H65VX1mUt1fWAqnZDGhMap4AjCKWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PdEtlwtHUBbctRuO1cH98x9K2xq/8RQ14Cf7HcdTIMLBL4dVtjUBjd4vOUT/qHnAac2lDFPJ2s/4zbg7d3j3d13xA/09tj7tDS2FpXSsuHTSLIlDvXoVGM+s8dLEVqHxarpN29tD59ihmgGhFOxoHIt9m9isE0DXAqPi2d+20Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YBhzs2MDSz4f3lW3;
	Mon, 16 Dec 2024 22:25:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C66C31A018D;
	Mon, 16 Dec 2024 22:25:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBHIoZXOGBnSTcXEw--.14700S5;
	Mon, 16 Dec 2024 22:25:33 +0800 (CST)
From: Yang Erkun <yangerkun@huaweicloud.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org
Cc: yangerkun@huawei.com,
	yangerkun@huaweicloud.com,
	yi.zhang@huawei.com
Subject: [RFC PATCH 1/5] nfsd: Revert "nfsd: release svc_expkey/svc_export with rcu_work"
Date: Mon, 16 Dec 2024 22:21:52 +0800
Message-Id: <20241216142156.4133267-2-yangerkun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241216142156.4133267-1-yangerkun@huaweicloud.com>
References: <20241216142156.4133267-1-yangerkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHIoZXOGBnSTcXEw--.14700S5
X-Coremail-Antispam: 1UD129KBjvJXoWxCFykKw1UGrW5XFy3KF13CFg_yoWrAw15pa
	yfAay7KaykXF1jgw4UJa1jvw13KasYvw1ku348G3yYvF1rtr18G3WrAFyj9ry5t3y8W3y3
	ur4jqa1DCw18ZFDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I
	0E8cxan2IY04v7MxkF7I0En4kS14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCa
	FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
	6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr
	0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	YxBIdaVFxhVjvjDU0xZFpf9x0pEYLvJUUUUU=
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

From: Yang Erkun <yangerkun@huawei.com>

This reverts commit f8c989a0c89a75d30f899a7cabdc14d72522bb8d.

Before this commit, svc_export_put or expkey_put will call path_put with
sync mode. After this commit, path_put will be called with async mode.
And this can lead the unexpected results show as follow.

mkfs.xfs -f /dev/sda
echo "/ *(rw,no_root_squash,fsid=0)" > /etc/exports
echo "/mnt *(rw,no_root_squash,fsid=1)" >> /etc/exports
exportfs -ra
service nfs-server start
mount -t nfs -o vers=4.0 127.0.0.1:/mnt /mnt1
mount /dev/sda /mnt/sda
touch /mnt1/sda/file
exportfs -r
umount /mnt/sda # failed unexcepted

The touch will finally call nfsd_cross_mnt, add refcount to mount, and
then add cache_head. Before this commit, exportfs -r will call
cache_flush to cleanup all cache_head, and path_put in
svc_export_put/expkey_put will be finished with sync mode. So, the
latter umount will always success. However, after this commit, path_put
will be called with async mode, the latter umount may failed, and if
we add some delay, umount will success too. Personally I think this bug
and should be fixed. We first revert before bugfix patch, and then fix
the original bug with a different way.

Fixes: f8c989a0c89a ("nfsd: release svc_expkey/svc_export with rcu_work")
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 fs/nfsd/export.c | 31 ++++++-------------------------
 fs/nfsd/export.h |  4 ++--
 2 files changed, 8 insertions(+), 27 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index eacafe46e3b6..aa4712362b3b 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -40,24 +40,15 @@
 #define	EXPKEY_HASHMAX		(1 << EXPKEY_HASHBITS)
 #define	EXPKEY_HASHMASK		(EXPKEY_HASHMAX -1)
 
-static void expkey_put_work(struct work_struct *work)
+static void expkey_put(struct kref *ref)
 {
-	struct svc_expkey *key =
-		container_of(to_rcu_work(work), struct svc_expkey, ek_rcu_work);
+	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
 
 	if (test_bit(CACHE_VALID, &key->h.flags) &&
 	    !test_bit(CACHE_NEGATIVE, &key->h.flags))
 		path_put(&key->ek_path);
 	auth_domain_put(key->ek_client);
-	kfree(key);
-}
-
-static void expkey_put(struct kref *ref)
-{
-	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
-
-	INIT_RCU_WORK(&key->ek_rcu_work, expkey_put_work);
-	queue_rcu_work(system_wq, &key->ek_rcu_work);
+	kfree_rcu(key, ek_rcu);
 }
 
 static int expkey_upcall(struct cache_detail *cd, struct cache_head *h)
@@ -364,26 +355,16 @@ static void export_stats_destroy(struct export_stats *stats)
 					    EXP_STATS_COUNTERS_NUM);
 }
 
-static void svc_export_put_work(struct work_struct *work)
+static void svc_export_put(struct kref *ref)
 {
-	struct svc_export *exp =
-		container_of(to_rcu_work(work), struct svc_export, ex_rcu_work);
-
+	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
 	path_put(&exp->ex_path);
 	auth_domain_put(exp->ex_client);
 	nfsd4_fslocs_free(&exp->ex_fslocs);
 	export_stats_destroy(exp->ex_stats);
 	kfree(exp->ex_stats);
 	kfree(exp->ex_uuid);
-	kfree(exp);
-}
-
-static void svc_export_put(struct kref *ref)
-{
-	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
-
-	INIT_RCU_WORK(&exp->ex_rcu_work, svc_export_put_work);
-	queue_rcu_work(system_wq, &exp->ex_rcu_work);
+	kfree_rcu(exp, ex_rcu);
 }
 
 static int svc_export_upcall(struct cache_detail *cd, struct cache_head *h)
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index 6f2fbaae01fa..4d92b99c1ffd 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -75,7 +75,7 @@ struct svc_export {
 	u32			ex_layout_types;
 	struct nfsd4_deviceid_map *ex_devid_map;
 	struct cache_detail	*cd;
-	struct rcu_work		ex_rcu_work;
+	struct rcu_head		ex_rcu;
 	unsigned long		ex_xprtsec_modes;
 	struct export_stats	*ex_stats;
 };
@@ -92,7 +92,7 @@ struct svc_expkey {
 	u32			ek_fsid[6];
 
 	struct path		ek_path;
-	struct rcu_work		ek_rcu_work;
+	struct rcu_head		ek_rcu;
 };
 
 #define EX_ISSYNC(exp)		(!((exp)->ex_flags & NFSEXP_ASYNC))
-- 
2.39.2


