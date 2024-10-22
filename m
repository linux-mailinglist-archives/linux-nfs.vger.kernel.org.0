Return-Path: <linux-nfs+bounces-7349-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F159A966B
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 04:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C0F283712
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 02:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC4B42AA5;
	Tue, 22 Oct 2024 02:49:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C8323A9;
	Tue, 22 Oct 2024 02:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729565342; cv=none; b=ojLMbOSJnF/WLv9chzcYD/WQ+wTJ8AkHrvKjFPDRwzfr4Un61dCmG1DEjAP+3r+53c8AeBL8EWDztnadVsZULNiTWNqVNRpdTFEjB6hiTvnLJ1BhjhZljOGIJXZ/VopVM5bZxigGprmkz1SjZdLd/Y+5AatTBfZBiuwnaSTcOC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729565342; c=relaxed/simple;
	bh=KOPYXW6T2xzBP8d/HilR6BFXZKqiDkTkP/GBtbxVc88=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cz5fmRCeeqe2eqh+CSo9wr42QdSbxIOH12S8HzTIV152h2U3gE6PIA+hLIb5pxfkJweT00QJXwRn9O6w9AO3YKG9dl97+VDxDoXtGUsOORpVXkfabn1/82sP9+ahGtYYHWintLoKNjcfsEVOVT6+7t1DDfIFhVafXlg2TZVwRAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XXc6H6pDjz2Fb8r;
	Tue, 22 Oct 2024 10:47:35 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 67462140361;
	Tue, 22 Oct 2024 10:48:57 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 22 Oct
 2024 10:48:56 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>
CC: <trond.myklebust@hammerspace.com>, <jlayton@kernel.org>,
	<linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH v2] nfs: maintain nfs_server in the reclaim process
Date: Tue, 22 Oct 2024 11:03:17 +0800
Message-ID: <20241022030317.324027-1-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg500017.china.huawei.com (7.202.181.81)

In the reclaim process, there may be a situation where all files are
closed and the file system is unmounted, which will result in the
release of nfs_server.

This will trigger UAF in nfs4_put_open_state when the count of
nfs4_state is decremented to zero, because the freed nfs_server will be
accessed when evicting inode.

Maintaining the nfs_server throughout the entire reclaim process by
adding nfs_sb_active and nfs_sb_deactive to fix it.

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
v1->v2:
  Get reference counting inside the lock's protection.

 fs/nfs/nfs4state.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index dafd61186557..acf608957f57 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1935,6 +1935,12 @@ static int nfs4_do_reclaim(struct nfs_client *clp, const struct nfs4_state_recov
 				continue;
 			if (!atomic_inc_not_zero(&sp->so_count))
 				continue;
+			if (!(server->super && nfs_sb_active(server->super))) {
+				spin_unlock(&clp->cl_lock);
+				rcu_read_unlock();
+				nfs4_put_state_owner(sp);
+				goto restart;
+			}
 			spin_unlock(&clp->cl_lock);
 			rcu_read_unlock();
 
@@ -1947,10 +1953,12 @@ static int nfs4_do_reclaim(struct nfs_client *clp, const struct nfs4_state_recov
 				nfs4_put_state_owner(sp);
 				status = nfs4_recovery_handle_error(clp, status);
 				nfs4_free_state_owners(&freeme);
+				nfs_sb_deactive(server->super);
 				return (status != 0) ? status : -EAGAIN;
 			}
 
 			nfs4_put_state_owner(sp);
+			nfs_sb_deactive(server->super);
 			goto restart;
 		}
 		spin_unlock(&clp->cl_lock);
-- 
2.31.1


