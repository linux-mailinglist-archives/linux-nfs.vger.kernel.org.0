Return-Path: <linux-nfs+bounces-10086-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6E1A341ED
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 15:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA763A4091
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 14:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAEE281345;
	Thu, 13 Feb 2025 14:25:01 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B497028135A;
	Thu, 13 Feb 2025 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456701; cv=none; b=ljupW9drqhhi5OCWiaDn3lYU+Y+W/egoY2sXnFU3vkDZPlHB7MSiF6Bq7X6d8OTpXUKpLSyMwn1bz6VwvK/6Any20/vwP1RjLS3/mQ9cgdp2XjVQ+HS3HJ3ZE35SdZwP5rLidqX+4rONW2asiPzHR7NWSzq4vYERNvMbRTqP49w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456701; c=relaxed/simple;
	bh=xnzELmoh7abzL9m1IEvTPPrap/skeMH5SYaGFuCx6PY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RNhmNITmVdyOlCAWlMs0JVNLcqjpIppydx1I6ds/m9O9kkNMM3bus1MWDnjlQBzwLwI3/+T65oArW9QOynI7c+xydZN8EqDEVLQmdxJtJ2fFD2st1pYIp+9kvZa5YFwzJufcBZpfB0c/qIpDySY+lDBhOS5dc+x/XF9mswrfO3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Yty5w4H8Vz1V6S6;
	Thu, 13 Feb 2025 22:21:08 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 82E18140202;
	Thu, 13 Feb 2025 22:24:56 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 13 Feb
 2025 22:24:55 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
	<okorniev@redhat.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH v2] nfsd: put dl_stid if fail to queue dl_recall
Date: Thu, 13 Feb 2025 22:42:20 +0800
Message-ID: <20250213144220.156089-1-lilingfeng3@huawei.com>
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

Before calling nfsd4_run_cb to queue dl_recall to the callback_wq, we
increment the reference count of dl_stid.
We expect that after the corresponding work_struct is processed, the
reference count of dl_stid will be decremented through the callback
function nfsd4_cb_recall_release.
However, if the call to nfsd4_run_cb fails, the incremented reference
count of dl_stid will not be decremented correspondingly, leading to the
following nfs4_stid leak:
unreferenced object 0xffff88812067b578 (size 344):
  comm "nfsd", pid 2761, jiffies 4295044002 (age 5541.241s)
  hex dump (first 32 bytes):
    01 00 00 00 6b 6b 6b 6b b8 02 c0 e2 81 88 ff ff  ....kkkk........
    00 6b 6b 6b 6b 6b 6b 6b 00 00 00 00 ad 4e ad de  .kkkkkkk.....N..
  backtrace:
    kmem_cache_alloc+0x4b9/0x700
    nfsd4_process_open1+0x34/0x300
    nfsd4_open+0x2d1/0x9d0
    nfsd4_proc_compound+0x7a2/0xe30
    nfsd_dispatch+0x241/0x3e0
    svc_process_common+0x5d3/0xcc0
    svc_process+0x2a3/0x320
    nfsd+0x180/0x2e0
    kthread+0x199/0x1d0
    ret_from_fork+0x30/0x50
    ret_from_fork_asm+0x1b/0x30
unreferenced object 0xffff8881499f4d28 (size 368):
  comm "nfsd", pid 2761, jiffies 4295044005 (age 5541.239s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 30 4d 9f 49 81 88 ff ff  ........0M.I....
    30 4d 9f 49 81 88 ff ff 20 00 00 00 01 00 00 00  0M.I.... .......
  backtrace:
    kmem_cache_alloc+0x4b9/0x700
    nfs4_alloc_stid+0x29/0x210
    alloc_init_deleg+0x92/0x2e0
    nfs4_set_delegation+0x284/0xc00
    nfs4_open_delegation+0x216/0x3f0
    nfsd4_process_open2+0x2b3/0xee0
    nfsd4_open+0x770/0x9d0
    nfsd4_proc_compound+0x7a2/0xe30
    nfsd_dispatch+0x241/0x3e0
    svc_process_common+0x5d3/0xcc0
    svc_process+0x2a3/0x320
    nfsd+0x180/0x2e0
    kthread+0x199/0x1d0
    ret_from_fork+0x30/0x50
    ret_from_fork_asm+0x1b/0x30
Fix it by checking the result of nfsd4_run_cb and call nfs4_put_stid if
fail to queue dl_recall.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
Changes in v2:
- Add a comment to nfs4_free_deleg.
---
 fs/nfsd/nfs4state.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 153eeea2c7c9..d442d61e2947 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1050,6 +1050,12 @@ static struct nfs4_ol_stateid * nfs4_alloc_open_stateid(struct nfs4_client *clp)
 	return openlockstateid(stid);
 }
 
+/*
+ * As the sc_free callback of deleg, this may be called by nfs4_put_stid
+ * in nfsd_break_one_deleg.
+ * Considering nfsd_break_one_deleg is called with the flc->flc_lock held,
+ * this function mustn't ever sleep.
+ */
 static void nfs4_free_deleg(struct nfs4_stid *stid)
 {
 	struct nfs4_delegation *dp = delegstateid(stid);
@@ -5414,6 +5420,7 @@ static const struct nfsd4_callback_ops nfsd4_cb_recall_ops = {
 
 static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
 {
+	bool queued;
 	/*
 	 * We're assuming the state code never drops its reference
 	 * without first removing the lease.  Since we're in this lease
@@ -5422,7 +5429,10 @@ static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
 	 * we know it's safe to take a reference.
 	 */
 	refcount_inc(&dp->dl_stid.sc_count);
-	WARN_ON_ONCE(!nfsd4_run_cb(&dp->dl_recall));
+	queued = nfsd4_run_cb(&dp->dl_recall);
+	WARN_ON_ONCE(!queued);
+	if (!queued)
+		nfs4_put_stid(&dp->dl_stid);
 }
 
 /* Called from break_lease() with flc_lock held. */
-- 
2.31.1


