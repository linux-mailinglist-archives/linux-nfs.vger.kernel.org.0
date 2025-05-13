Return-Path: <linux-nfs+bounces-11670-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFFEAB4CAA
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 09:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711FD1B41143
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 07:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711FB1EFFA3;
	Tue, 13 May 2025 07:24:30 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA421EDA04;
	Tue, 13 May 2025 07:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747121070; cv=none; b=tnIdjrSfXiG/zqRRQ3KzcsmWKgObz2SP4RD6SiEC6K7vHOkk0PtIPiv8SPRq7nY9Ju/CWonCt35bOeL4IDATyupZYUUIXqRjyNvNWUmefXD5+9rSaANq3Lui/Ko25lA06RxrZLGqcq9yoIdGIdAXRCMs4dGvxWJPPu9UMbd1sFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747121070; c=relaxed/simple;
	bh=8ygg5+lbmN/VLtz/D714USCmypSOCh9GpoUadQ03tCs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H5xu/zji49G9lftEECXAxBciG6RUyj1sOYkQXmWzVqZtNpZBrvQGkq+es4x2SJYS17/YB6XRb1zGh3ul+BNHSxQhtIWoarnGoHd1C2N55ZBK4Hg0Mmg560eC3fZk8RHHKezRFu5CLqWPYdx02OB/5h2C3sGuMQWzk1OV/YYlEdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZxScH0Gq5z1d1JV;
	Tue, 13 May 2025 15:22:55 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id A5DAF180477;
	Tue, 13 May 2025 15:24:19 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 13 May
 2025 15:24:18 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
	<neil@brown.name>, <okorniev@redhat.com>, <Dai.Ngo@oracle.com>,
	<tom@talpey.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH] nfsd: Invoke tracking callbacks only after initialization is complete
Date: Tue, 13 May 2025 15:43:05 +0800
Message-ID: <20250513074305.3362209-1-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg500017.china.huawei.com (7.202.181.81)

Checking whether tracking callbacks can be called based on whether
nn->client_tracking_ops is NULL may lead to callbacks being invoked
before tracking initialization completes, causing resource access
violations (UAF, NULL pointer dereference). Examples:

1) nfsd4_client_tracking_init
   // set nn->client_tracking_ops
   nfsd4_cld_tracking_init
    nfs4_cld_state_init
     nn->reclaim_str_hashtbl = kmalloc_array
    ... // error path, goto err
    nfs4_cld_state_shutdown
     kfree(nn->reclaim_str_hashtbl)
                                      write_v4_end_grace
                                       nfsd4_end_grace
                                        nfsd4_record_grace_done
                                         nfsd4_cld_grace_done
                                          nfs4_release_reclaim
                                           nn->reclaim_str_hashtbl[i]
                                           // UAF
   // clear nn->client_tracking_ops

2) nfsd4_client_tracking_init
   // set nn->client_tracking_ops
   nfsd4_cld_tracking_init
                                      write_v4_end_grace
                                       nfsd4_end_grace
                                        nfsd4_record_grace_done
                                         nfsd4_cld_grace_done
                                          alloc_cld_upcall
                                           cn = nn->cld_net
                                           spin_lock // cn->cn_lock
                                           // NULL deref
   // error path, skip init pipe
   __nfsd4_init_cld_pipe
    cn = kzalloc
    nn->cld_net = cn
   // clear nn->client_tracking_ops

After nfsd mounts, users can trigger grace_done callbacks via
/proc/fs/nfsd/v4_end_grace. If resources are uninitialized or freed
in error paths, this causes access violations.

Instead of adding locks for specific resources(e.g., reclaim_str_hashtbl),
introducing a flag to indicate whether tracking initialization has
completed and checking this flag before invoking callbacks may be better.

Fixes: 52e19c09a183 ("nfsd: make reclaim_str_hashtbl allocated per net")
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 fs/nfsd/netns.h       |  1 +
 fs/nfsd/nfs4recover.c | 13 +++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 3e2d0fde80a7..dbd782d6b063 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -113,6 +113,7 @@ struct nfsd_net {
 
 	struct file *rec_file;
 	bool in_grace;
+	bool client_tracking_init_done;
 	const struct nfsd4_client_tracking_ops *client_tracking_ops;
 
 	time64_t nfsd4_lease;
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index c1d9bd07285f..6c27c1252c0e 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -2096,7 +2096,11 @@ nfsd4_client_tracking_init(struct net *net)
 		pr_warn("NFSD: Unable to initialize client recovery tracking! (%d)\n", status);
 		pr_warn("NFSD: Is nfsdcld running? If not, enable CONFIG_NFSD_LEGACY_CLIENT_TRACKING.\n");
 		nn->client_tracking_ops = NULL;
+		nn->client_tracking_init_done = false;
+	} else {
+		nn->client_tracking_init_done = true;
 	}
+
 	return status;
 }
 
@@ -2105,6 +2109,7 @@ nfsd4_client_tracking_exit(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
+	nn->client_tracking_init_done = false;
 	if (nn->client_tracking_ops) {
 		if (nn->client_tracking_ops->exit)
 			nn->client_tracking_ops->exit(net);
@@ -2117,7 +2122,7 @@ nfsd4_client_record_create(struct nfs4_client *clp)
 {
 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 
-	if (nn->client_tracking_ops)
+	if (nn->client_tracking_ops && nn->client_tracking_init_done)
 		nn->client_tracking_ops->create(clp);
 }
 
@@ -2126,7 +2131,7 @@ nfsd4_client_record_remove(struct nfs4_client *clp)
 {
 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 
-	if (nn->client_tracking_ops)
+	if (nn->client_tracking_ops && nn->client_tracking_init_done)
 		nn->client_tracking_ops->remove(clp);
 }
 
@@ -2135,7 +2140,7 @@ nfsd4_client_record_check(struct nfs4_client *clp)
 {
 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 
-	if (nn->client_tracking_ops)
+	if (nn->client_tracking_ops && nn->client_tracking_init_done)
 		return nn->client_tracking_ops->check(clp);
 
 	return -EOPNOTSUPP;
@@ -2144,7 +2149,7 @@ nfsd4_client_record_check(struct nfs4_client *clp)
 void
 nfsd4_record_grace_done(struct nfsd_net *nn)
 {
-	if (nn->client_tracking_ops)
+	if (nn->client_tracking_ops && nn->client_tracking_init_done)
 		nn->client_tracking_ops->grace_done(nn);
 }
 
-- 
2.31.1


