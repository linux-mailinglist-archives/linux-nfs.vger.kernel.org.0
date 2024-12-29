Return-Path: <linux-nfs+bounces-8837-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8752D9FDF50
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Dec 2024 15:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C813A0594
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Dec 2024 14:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C08328691;
	Sun, 29 Dec 2024 14:47:18 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DAA2594A6;
	Sun, 29 Dec 2024 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735483638; cv=none; b=ht6eweCkrYmuPId2wbGvSJn9KZl+zhj47bkEdz4ZBPTg0WBetoMGypdrAwJ3H8oJAdXzPkXNPmBXqOJs3I8DUeu4jpa863f6CeCl51BOEiaqVjleWycwJcWJu+y5Vh8tlFwjrmFaOOAlHzVbiYovC5MbycKOU21HMCV7QHtX64c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735483638; c=relaxed/simple;
	bh=Rg1PbKBINREC4avwH+xxhHmTQwUm4wj3iO8naBUOwtM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lDR9gKGjrjufD1lvL3bjye2YMe2JrEedvz0/wlT7JIGQq0vzQzg9HDzqQ7vWZj3MVxaAR/rdw7gitWKVcMGZTJNgCPmo2Y7BASmkVGi5x0dkmYf1UkzKr5tJuVCYuC0QkK+1STNGlTP/b5CQCPMATZbHndIfbTHTOTK9Ef1xlsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id EAC5A23375;
	Sun, 29 Dec 2024 17:47:04 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: "J . Bruce Fields" <bfields@fieldses.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org,
	Yang Erkun <yangerkun@huaweicloud.com>
Subject: [PATCH 5.10/5.15/6.1] nfsd: cancel nfsd_shrinker_work using sync mode in nfs4_state_shutdown_net
Date: Sun, 29 Dec 2024 17:45:57 +0300
Message-Id: <20241229144557.1203112-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Erkun <yangerkun@huaweicloud.com>

[ Upstream commit d5ff2fb2e7167e9483846e34148e60c0c016a1f6 ]

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

Fixes: 7c24fa225081 ("NFSD: replace delayed_work with work_struct for nfsd_client_shrinker")
Signed-off-by: Yang Erkun <yangerkun@huaweicloud.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
(cherry picked from commit f965dc0f099a54fca100acf6909abe52d0c85328)
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
Backport to fix CVE-2024-50121
Link: https://www.cve.org/CVERecord/?id=CVE-2024-50121
---
 fs/nfsd/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 8bceae771c1c75..f6fa719ee32668 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8208,7 +8208,7 @@ nfs4_state_shutdown_net(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	unregister_shrinker(&nn->nfsd_client_shrinker);
-	cancel_work(&nn->nfsd_shrinker_work);
+	cancel_work_sync(&nn->nfsd_shrinker_work);
 	cancel_delayed_work_sync(&nn->laundromat_work);
 	locks_end_grace(&nn->nfsd4_manager);
 
-- 
2.33.8


