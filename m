Return-Path: <linux-nfs+bounces-5963-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9979646A8
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 15:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55971F21840
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 13:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882D61AE854;
	Thu, 29 Aug 2024 13:27:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033831AE84C;
	Thu, 29 Aug 2024 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938075; cv=none; b=pTw2YfKDoP9xfAyRmZWq9szbeJPmAMgV34CzCiN8ibPUdktMyszuq/0xJjVe5i+v7wqcpwB8VF9BSAOXqG/2tkCFsnlWNLXFHvOI+BPrT+iZ78ZSpheJ/K5krW27htvE/OimiAKffOSReENlbQjmMtLkOUsrMBfGhfVd4tlpJCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938075; c=relaxed/simple;
	bh=6LM37PaL2W80lbU4UvB+TGFDJbbj3kS8Xb/o/IuByWg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=noyWGmwKh1LlD5vTz3rGt/jEbCPfXdA1S0DQpVS2FusQmMegbXJty9lIxBwQeEULjfZG73owp6WGt+XokLGzghmI21O8CoqrX6WTT8S+xDU/FtTLrzGYgBrtOIn/KU4P1HvCkybN3uOTGdFw6L97ovXhUctgIcJ+r+XDlqrLWJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Wvhqg2snbz1xwG6;
	Thu, 29 Aug 2024 21:25:51 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 85BF21A0188;
	Thu, 29 Aug 2024 21:27:49 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 29 Aug
 2024 21:27:48 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>
CC: <jlayton@kernel.org>, <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yukuai1@huaweicloud.com>,
	<houtao1@huawei.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<lilingfeng@huaweicloud.com>, <lilingfeng3@huawei.com>
Subject: [PATCH v2] nfs: protect nfs41_impl_id by rcu
Date: Thu, 29 Aug 2024 21:37:43 +0800
Message-ID: <20240829133743.1008788-1-lilingfeng3@huawei.com>
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

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
v1->v2:
  Free nfs41_impl_id by call_rcu in nfs4_shutdown_client to resolve
  warning.
 fs/nfs/nfs4client.c       | 10 +++++++++-
 fs/nfs/nfs4proc.c         | 12 ++++++++++--
 fs/nfs/super.c            | 12 +++++++++---
 include/linux/nfs_fs_sb.h |  2 +-
 include/linux/nfs_xdr.h   |  1 +
 5 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 83378f69b35e..1aee1cfb6f1f 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -281,6 +281,13 @@ static void nfs4_destroy_callback(struct nfs_client *clp)
 		nfs_callback_down(clp->cl_mvops->minor_version, clp->cl_net);
 }
 
+static void nfs4_free_impl_id_rcu(struct rcu_head *head)
+{
+	struct nfs41_impl_id *impl_id = container_of(head, struct nfs41_impl_id, __rcu_head);
+
+	kfree(impl_id);
+}
+
 static void nfs4_shutdown_client(struct nfs_client *clp)
 {
 	if (__test_and_clear_bit(NFS_CS_RENEWD, &clp->cl_res_state))
@@ -293,7 +300,8 @@ static void nfs4_shutdown_client(struct nfs_client *clp)
 	rpc_destroy_wait_queue(&clp->cl_rpcwaitq);
 	kfree(clp->cl_serverowner);
 	kfree(clp->cl_serverscope);
-	kfree(clp->cl_implid);
+	if (clp->cl_implid)
+		call_rcu(&clp->cl_implid->__rcu_head, nfs4_free_impl_id_rcu);
 	kfree(clp->cl_owner_id);
 }
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index b8ffbe52ba15..6bb820bd205e 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8866,13 +8866,21 @@ struct nfs41_exchange_id_data {
 	struct nfs41_exchange_id_args args;
 };
 
+static void nfs4_free_impl_id_rcu(struct rcu_head *head)
+{
+	struct nfs41_impl_id *impl_id = container_of(head, struct nfs41_impl_id, __rcu_head);
+
+	kfree(impl_id);
+}
+
 static void nfs4_exchange_id_release(void *data)
 {
 	struct nfs41_exchange_id_data *cdata =
 					(struct nfs41_exchange_id_data *)data;
 
 	nfs_put_client(cdata->args.client);
-	kfree(cdata->res.impl_id);
+	if (cdata->res.impl_id)
+		call_rcu(&cdata->res.impl_id->__rcu_head, nfs4_free_impl_id_rcu);
 	kfree(cdata->res.server_scope);
 	kfree(cdata->res.server_owner);
 	kfree(cdata);
@@ -9034,7 +9042,7 @@ static int _nfs4_proc_exchange_id(struct nfs_client *clp, const struct cred *cre
 
 	swap(clp->cl_serverowner, resp->server_owner);
 	swap(clp->cl_serverscope, resp->server_scope);
-	swap(clp->cl_implid, resp->impl_id);
+	resp->impl_id = rcu_replace_pointer(clp->cl_implid, resp->impl_id, 1);
 
 	/* Save the EXCHANGE_ID verifier session trunk tests */
 	memcpy(clp->cl_confirm.data, argp->verifier.data,
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 97b386032b71..6097dbe8e334 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -612,13 +612,19 @@ static void show_pnfs(struct seq_file *m, struct nfs_server *server)
 
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
index 1df86ab98c77..29c98c9df42f 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -102,7 +102,7 @@ struct nfs_client {
 	bool			cl_preserve_clid;
 	struct nfs41_server_owner *cl_serverowner;
 	struct nfs41_server_scope *cl_serverscope;
-	struct nfs41_impl_id	*cl_implid;
+	struct nfs41_impl_id __rcu *cl_implid;
 	/* nfs 4.1+ state protection modes: */
 	unsigned long		cl_sp4_flags;
 #define NFS_SP4_MACH_CRED_MINIMAL  1	/* Minimal sp4_mach_cred - state ops
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 45623af3e7b8..b3c96ea2a64b 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1374,6 +1374,7 @@ struct nfs41_impl_id {
 	char				domain[NFS4_OPAQUE_LIMIT + 1];
 	char				name[NFS4_OPAQUE_LIMIT + 1];
 	struct nfstime4			date;
+	struct rcu_head			__rcu_head;
 };
 
 #define MAX_BIND_CONN_TO_SESSION_RETRIES 3
-- 
2.31.1


