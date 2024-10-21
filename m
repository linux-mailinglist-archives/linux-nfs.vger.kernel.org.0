Return-Path: <linux-nfs+bounces-7320-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D5E9A5E9E
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 10:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF1D1F2188F
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 08:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD901E201D;
	Mon, 21 Oct 2024 08:28:20 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E471E1C10
	for <linux-nfs@vger.kernel.org>; Mon, 21 Oct 2024 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729499300; cv=none; b=fQPMyOLQyd+GAhL3rCI0mv31Gbr+ax/a4oJOD8ya39pP1z9leIyDrmpFIrzV4WDsJyDSBzT43Y3rOD3E3VJGDjNDDzh3F7nBfWyhbOfMeATF3mMhFG257ixxXq8kb7gNVmjLcFa03Q+lHgOeBQkCfILOmP3Z4ctAICk+0mpocaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729499300; c=relaxed/simple;
	bh=5CW1IVV3L6sprYx3JUU6wyg9Gk3n+JLVIumuixM1eAM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DWInVRBmrRkbwsnD7KwVOV+13KIr8+bngEtruJT2TZ73vVCNA3RVDTV27t6DYNN/d5eSPcS2I51uSju8sU/wnDk7fENDxEPZtkk4n+RzBrvu9wx5R1uevPe0tfUKZMClmz94pQ6Ldx5y26ECDkHXXYp+gk79rC06FnsebLLy6NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XX7jY2jrxz4f3jqt
	for <linux-nfs@vger.kernel.org>; Mon, 21 Oct 2024 16:28:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9BA3B1A018D
	for <linux-nfs@vger.kernel.org>; Mon, 21 Oct 2024 16:28:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAHPMiZEBZn5UjMEg--.13808S4;
	Mon, 21 Oct 2024 16:28:13 +0800 (CST)
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
Subject: [PATCH] nfsd: cancel nfsd_shrinker_work using sync mode in nfs4_state_shutdown_net
Date: Mon, 21 Oct 2024 16:25:40 +0800
Message-Id: <20241021082540.2885014-1-yangerkun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHPMiZEBZn5UjMEg--.13808S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCFWDKF4ruF15CF18KrW7Jwb_yoW5uw45pr
	s3GryxJr15X34DJwsrJ3W8Jr18CFs5Ar1UWryrWr1Fqr4fZw1UXF4jqry0qryUGrWkAr48
	WF1UKF98Ww18AFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUUxR6UUUUU
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

In the normal case, when we excute `echo 0 > /proc/fs/nfsd/threads`, the
function `nfs4_state_destroy_net` in `nfs4_state_shutdown_net` will
release all resources related to the hashed `nfs4_client`. If the
`nfsd_client_shrinker` is running concurrently, the `expire_client`
function will first unhash this client and then destroy it. This can
lead to the following warning. Additionally, numerous use-after-free
errors may occur as well.

nfsd_client_shrinker         echo 0 > /proc/fs/nfsd/threads

expire_client                nfsd_shutdown_net
  unhash_client                ...
                               nfs4_state_shutdown_net
                                 /* won't wait shrinker exit */
  /*                             cancel_work(&nn->nfsd_shrinker_work)
   * nfsd_file for this          /* won't destroy unhashed client1 */
   * client1 still alive         nfs4_state_destroy_net
   */

                               nfsd_file_cache_shutdown
                                 /* trigger warning */
                                 kmem_cache_destroy(nfsd_file_slab)
                                 kmem_cache_destroy(nfsd_file_mark_slab)
  /* release nfsd_file and mark */
  __destroy_client

====================================================================
BUG nfsd_file (Not tainted): Objects remaining in nfsd_file on
__kmem_cache_shutdown()
--------------------------------------------------------------------
CPU: 4 UID: 0 PID: 764 Comm: sh Not tainted 6.12.0-rc3+ #1

 dump_stack_lvl+0x53/0x70
 slab_err+0xb0/0xf0
 __kmem_cache_shutdown+0x15c/0x310
 kmem_cache_destroy+0x66/0x160
 nfsd_file_cache_shutdown+0xac/0x210 [nfsd]
 nfsd_destroy_serv+0x251/0x2a0 [nfsd]
 nfsd_svc+0x125/0x1e0 [nfsd]
 write_threads+0x16a/0x2a0 [nfsd]
 nfsctl_transaction_write+0x74/0xa0 [nfsd]
 vfs_write+0x1a5/0x6d0
 ksys_write+0xc1/0x160
 do_syscall_64+0x5f/0x170
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

====================================================================
BUG nfsd_file_mark (Tainted: G    B   W         ): Objects remaining
nfsd_file_mark on __kmem_cache_shutdown()
--------------------------------------------------------------------

 dump_stack_lvl+0x53/0x70
 slab_err+0xb0/0xf0
 __kmem_cache_shutdown+0x15c/0x310
 kmem_cache_destroy+0x66/0x160
 nfsd_file_cache_shutdown+0xc8/0x210 [nfsd]
 nfsd_destroy_serv+0x251/0x2a0 [nfsd]
 nfsd_svc+0x125/0x1e0 [nfsd]
 write_threads+0x16a/0x2a0 [nfsd]
 nfsctl_transaction_write+0x74/0xa0 [nfsd]
 vfs_write+0x1a5/0x6d0
 ksys_write+0xc1/0x160
 do_syscall_64+0x5f/0x170
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

To resolve this issue, cancel `nfsd_shrinker_work` using synchronous
mode in nfs4_state_shutdown_net.

Fixes: 7746b32f467b ("NFSD: add shrinker to reap courtesy clients on low memory condition")
Signed-off-by: Yang Erkun <yangerkun@huaweicloud.com>
---
 fs/nfsd/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 56b261608af4..158d67186777 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8684,7 +8684,7 @@ nfs4_state_shutdown_net(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	shrinker_free(nn->nfsd_client_shrinker);
-	cancel_work(&nn->nfsd_shrinker_work);
+	cancel_work_sync(&nn->nfsd_shrinker_work);
 	cancel_delayed_work_sync(&nn->laundromat_work);
 	locks_end_grace(&nn->nfsd4_manager);
 
-- 
2.39.2


