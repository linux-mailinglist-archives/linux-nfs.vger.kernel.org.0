Return-Path: <linux-nfs+bounces-7352-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2689AA14D
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 13:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59283B22A82
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 11:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D9619B5AC;
	Tue, 22 Oct 2024 11:44:34 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7053E154426;
	Tue, 22 Oct 2024 11:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729597474; cv=none; b=NEMtBRsjwhr6db5ZMPXomAk8kRSx6zt6tmcDl37GQ6Bz9xWC8Ah2fjIAgX+DAFudiaNoNuTEQtDcAElwdHB+O8KOF8mJ0KhfKxyl0+KiIoQ9Ea7dfFnTJGgt5rv7bvWYu2BoFdhWY3OFRYWGSdp7vXhFkVWcvp7v0NSTUrU64rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729597474; c=relaxed/simple;
	bh=vEpNDEObsF2QUOJn8Wef9bk2+XMhRt8VUONNCn7X2rQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sDnf+638wfceM0n82iGquE1F201PmB7RvF+BvJJk31ShYFr5OK0SWDHkSP3iCz/yKqBd59di0EP+F70enrbuCqoS7BHgznN7yiggK/e6QJalMR3QTN+WDAZ6Tb6FvfqSdmdWUQ7tD1M/KK5wQ8QYBxlHNtbadoFG5cgGJRg4ajI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XXr095Qt7z2Fb30;
	Tue, 22 Oct 2024 19:43:05 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id ACC7014010D;
	Tue, 22 Oct 2024 19:44:27 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 22 Oct
 2024 19:44:26 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>
CC: <dros@netapp.com>, <trond.myklebust@hammerspace.com>,
	<jlayton@kernel.org>, <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yukuai1@huaweicloud.com>,
	<houtao1@huawei.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<lilingfeng@huaweicloud.com>, <lilingfeng3@huawei.com>
Subject: [PATCH v3] nfs: protect nfs41_impl_id by rcu
Date: Tue, 22 Oct 2024 19:58:47 +0800
Message-ID: <20241022115847.1283892-1-lilingfeng3@huawei.com>
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

When performing exchange id call, a new nfs41_impl_id will be allocated to
store some information from server. The pointers to the old and new
nfs41_impl_ids are swapped, and the old one will be freed.

However, UAF may be triggered as follows:

After T2 has got a pointer to the nfs41_impl_id, the nfs41_impl_id is
freed by T1 before it is used.
         T1                                           T2
nfs4_proc_exchange_id
 _nfs4_proc_exchange_id
  nfs4_run_exchange_id
   kzalloc // alloc nfs41_impl_id-B
   rpc_run_task
                                nfs_show_stats
                                 show_implementation_id
                                  impl_id = nfss->nfs_client->cl_implid
                                  // get alloc nfs41_impl_id-A
  swap(clp->cl_implid, resp->impl_id)
  rpc_put_task
   ...
    nfs4_exchange_id_release
     kfree // free nfs41_impl_id-A
                                  impl_id->name // UAF

Fix this issue by using rcu to protect the nfs41_impl_id.

Fixes: 7d2ed9ac22bc ("NFSv4: parse and display server implementation ids")
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
v1->v2:
  Free nfs41_impl_id by call_rcu in nfs4_shutdown_client to resolve
  warning.
v2->v3:
  Free nfs41_impl_id by kfree_rcu and check CONFIG_NFS_V4_1 before
  freeing nfs41_impl_id in nfs4_shutdown_client.

 fs/nfs/nfs4client.c       |  5 ++++-
 fs/nfs/nfs4proc.c         |  5 +++--
 fs/nfs/super.c            | 12 +++++++++---
 include/linux/nfs_fs_sb.h |  2 +-
 include/linux/nfs_xdr.h   |  3 ++-
 5 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 83378f69b35e..852a64294fec 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -293,7 +293,10 @@ static void nfs4_shutdown_client(struct nfs_client *clp)
 	rpc_destroy_wait_queue(&clp->cl_rpcwaitq);
 	kfree(clp->cl_serverowner);
 	kfree(clp->cl_serverscope);
-	kfree(clp->cl_implid);
+#ifdef CONFIG_NFS_V4_1
+	if (clp->cl_implid)
+		kfree_rcu(clp->cl_implid, __rcu_head);
+#endif
 	kfree(clp->cl_owner_id);
 }
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index cd2fbde2e6d7..b6a9bcabb531 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8884,7 +8884,8 @@ static void nfs4_exchange_id_release(void *data)
 					(struct nfs41_exchange_id_data *)data;
 
 	nfs_put_client(cdata->args.client);
-	kfree(cdata->res.impl_id);
+	if (cdata->res.impl_id)
+		kfree_rcu(cdata->res.impl_id, __rcu_head);
 	kfree(cdata->res.server_scope);
 	kfree(cdata->res.server_owner);
 	kfree(cdata);
@@ -9046,7 +9047,7 @@ static int _nfs4_proc_exchange_id(struct nfs_client *clp, const struct cred *cre
 
 	swap(clp->cl_serverowner, resp->server_owner);
 	swap(clp->cl_serverscope, resp->server_scope);
-	swap(clp->cl_implid, resp->impl_id);
+	resp->impl_id = rcu_replace_pointer(clp->cl_implid, resp->impl_id, 1);
 
 	/* Save the EXCHANGE_ID verifier session trunk tests */
 	memcpy(clp->cl_confirm.data, argp->verifier.data,
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 9723b6c53397..57665a82f12b 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -615,13 +615,19 @@ static void show_pnfs(struct seq_file *m, struct nfs_server *server)
 
 static void show_implementation_id(struct seq_file *m, struct nfs_server *nfss)
 {
-	if (nfss->nfs_client && nfss->nfs_client->cl_implid) {
-		struct nfs41_impl_id *impl_id = nfss->nfs_client->cl_implid;
+	struct nfs_client *clp = nfss->nfs_client;
+	struct nfs41_impl_id *impl_id;
+
+	if (!clp)
+		return;
+	rcu_read_lock();
+	impl_id = rcu_dereference(clp->cl_implid);
+	if (impl_id)
 		seq_printf(m, "\n\timpl_id:\tname='%s',domain='%s',"
 			   "date='%llu,%u'",
 			   impl_id->name, impl_id->domain,
 			   impl_id->date.seconds, impl_id->date.nseconds);
-	}
+	rcu_read_unlock();
 }
 #else
 #if IS_ENABLED(CONFIG_NFS_V4)
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index b804346a9741..fcad3f0ea68b 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -104,7 +104,7 @@ struct nfs_client {
 	bool			cl_preserve_clid;
 	struct nfs41_server_owner *cl_serverowner;
 	struct nfs41_server_scope *cl_serverscope;
-	struct nfs41_impl_id	*cl_implid;
+	struct nfs41_impl_id __rcu *cl_implid;
 	/* nfs 4.1+ state protection modes: */
 	unsigned long		cl_sp4_flags;
 #define NFS_SP4_MACH_CRED_MINIMAL  1	/* Minimal sp4_mach_cred - state ops
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 12d8e47bc5a3..a9d8a58ddb7c 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1374,6 +1374,7 @@ struct nfs41_impl_id {
 	char				domain[NFS4_OPAQUE_LIMIT + 1];
 	char				name[NFS4_OPAQUE_LIMIT + 1];
 	struct nfstime4			date;
+	struct rcu_head			__rcu_head;
 };
 
 #define MAX_BIND_CONN_TO_SESSION_RETRIES 3
@@ -1397,7 +1398,7 @@ struct nfs41_exchange_id_res {
 	u32				flags;
 	struct nfs41_server_owner	*server_owner;
 	struct nfs41_server_scope	*server_scope;
-	struct nfs41_impl_id		*impl_id;
+	struct nfs41_impl_id __rcu	*impl_id;
 	struct nfs41_state_protection	state_protect;
 };
 
-- 
2.31.1


