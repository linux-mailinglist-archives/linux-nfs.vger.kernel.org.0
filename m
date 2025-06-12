Return-Path: <linux-nfs+bounces-12346-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B418DAD66A7
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 06:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81083A4234
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 04:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065B41C32FF;
	Thu, 12 Jun 2025 04:08:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F7E19F137;
	Thu, 12 Jun 2025 04:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749701304; cv=none; b=UVL3Uy8P5AJNmbCHzgIAAAOY823GjnYWAwJseR4f+/oY5aXsyenfcsfb6NOhAZ5qD0DHzWpDEYwnW6J0Bmatgu9YZr/cPZaZS+vlBIDa93tPhEP9cJfOFpIOP5dPlxiz3nh3fnSdRCbpCzvmPpPex3ZrjHQsvRZzb7XlpVdKLPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749701304; c=relaxed/simple;
	bh=XU7wejBwGgIJ5mrJNR8OeoF4ChRgysR4TveQLmwzHps=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HA0/Ay9u+A7OwpvdgWb5uGwCAprY601QPc0sQmtUKVqCH26J4UmcnWMfG/u7h1Y+YpRAQ6MRBhmyjwC/H0vphhdbePKrG5O3fJSuZp+cUzWt4ZORLFnIhD1raWBLbfTMDhtwhz3My8eO916wlIDXy37M70Jg5+CqJjZMpXKYQ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bHprK3kxHz2TSCk;
	Thu, 12 Jun 2025 12:06:57 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id CA3311A0171;
	Thu, 12 Jun 2025 12:08:17 +0800 (CST)
Received: from huawei.com (10.175.112.188) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 12 Jun
 2025 12:08:16 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
	<okorniev@redhat.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH v2] nfsd: Invoke tracking callbacks only after initialization is complete
Date: Thu, 12 Jun 2025 11:55:06 +0800
Message-ID: <20250612035506.3651985-1-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

Resolve the issue by leveraging nfsd_mutex to prevent concurrency.

Fixes: 52e19c09a183 ("nfsd: make reclaim_str_hashtbl allocated per net")
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
  Changes in v2:
    Use nfsd_mutex instead of adding a new flag to prevent concurrency.
 fs/nfsd/nfs4recover.c | 8 ++++++++
 fs/nfsd/nfs4state.c   | 4 ++++
 fs/nfsd/nfsctl.c      | 2 ++
 3 files changed, 14 insertions(+)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 82785db730d9..8ac089f8134c 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -162,7 +162,9 @@ legacy_recdir_name_error(struct nfs4_client *clp, int error)
 	if (error == -ENOENT) {
 		printk(KERN_ERR "NFSD: disabling legacy clientid tracking. "
 			"Reboot recovery will not function correctly!\n");
+		mutex_lock(&nfsd_mutex);
 		nfsd4_client_tracking_exit(clp->net);
+		mutex_unlock(&nfsd_mutex);
 	}
 }
 
@@ -2083,8 +2085,10 @@ nfsd4_client_record_create(struct nfs4_client *clp)
 {
 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 
+	mutex_lock(&nfsd_mutex);
 	if (nn->client_tracking_ops)
 		nn->client_tracking_ops->create(clp);
+	mutex_unlock(&nfsd_mutex);
 }
 
 void
@@ -2092,8 +2096,10 @@ nfsd4_client_record_remove(struct nfs4_client *clp)
 {
 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 
+	mutex_lock(&nfsd_mutex);
 	if (nn->client_tracking_ops)
 		nn->client_tracking_ops->remove(clp);
+	mutex_unlock(&nfsd_mutex);
 }
 
 int
@@ -2101,8 +2107,10 @@ nfsd4_client_record_check(struct nfs4_client *clp)
 {
 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 
+	mutex_lock(&nfsd_mutex);
 	if (nn->client_tracking_ops)
 		return nn->client_tracking_ops->check(clp);
+	mutex_unlock(&nfsd_mutex);
 
 	return -EOPNOTSUPP;
 }
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d5694987f86f..2794fdc8b678 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2529,7 +2529,9 @@ static void inc_reclaim_complete(struct nfs4_client *clp)
 			nn->reclaim_str_hashtbl_size) {
 		printk(KERN_INFO "NFSD: all clients done reclaiming, ending NFSv4 grace period (net %x)\n",
 				clp->net->ns.inum);
+		mutex_lock(&nfsd_mutex);
 		nfsd4_end_grace(nn);
+		mutex_unlock(&nfsd_mutex);
 	}
 }
 
@@ -6773,7 +6775,9 @@ nfs4_laundromat(struct nfsd_net *nn)
 		lt.new_timeo = 0;
 		goto out;
 	}
+	mutex_lock(&nfsd_mutex);
 	nfsd4_end_grace(nn);
+	mutex_unlock(&nfsd_mutex);
 
 	spin_lock(&nn->s2s_cp_lock);
 	idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 3f3e9f6c4250..649850b4bb60 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1085,7 +1085,9 @@ static ssize_t write_v4_end_grace(struct file *file, char *buf, size_t size)
 			if (!nn->nfsd_serv)
 				return -EBUSY;
 			trace_nfsd_end_grace(netns(file));
+			mutex_lock(&nfsd_mutex);
 			nfsd4_end_grace(nn);
+			mutex_lock(&nfsd_mutex);
 			break;
 		default:
 			return -EINVAL;
-- 
2.46.1


