Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D0E625DE0
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Nov 2022 16:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbiKKPIx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Nov 2022 10:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234864AbiKKPH6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Nov 2022 10:07:58 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E8276FBC;
        Fri, 11 Nov 2022 07:05:50 -0800 (PST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N827v4msrz15MVY;
        Fri, 11 Nov 2022 23:05:31 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 23:05:46 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 11 Nov
 2022 23:05:45 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <trond.myklebust@hammerspace.com>, <anna@kernel.org>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenxiaosong2@huawei.com>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>
Subject: [PATCH] NFSv4.1: handle memory allocation failure in nfs4_schedule_state_manager()
Date:   Sat, 12 Nov 2022 00:10:33 +0800
Message-ID: <20221111161033.899541-1-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If memory allocation fail in nfs4_schedule_state_manager() when mount
NFSv4.1/NFSv4.2, nfs4_run_state_manager() will not be called, and current
construction state will never be marked as ready or failed,
nfs_wait_client_init_complete() will wait forever, as shown below:

  syscall(mount)
  ...
    nfs4_init_client
      nfs4_discover_server_trunking
        nfs41_discover_server_trunking
          nfs4_schedule_state_manager
            kthread_run /* nfs4_run_state_manager() will not be called */
              kthread_create
                kthread_create_on_node
                  __kthread_create_on_node
                    create = kmalloc() = NULL
                    return ERR_PTR(-ENOMEM)
          nfs_wait_client_init_complete /* wait forever */

Fix this by checking return value of nfs4_schedule_state_manager() which
can indicate whether kernel thread is created successful.

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 fs/nfs/nfs4_fs.h   |  2 +-
 fs/nfs/nfs4state.c | 15 ++++++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index cfef738d765e..74c6d1504010 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -502,7 +502,7 @@ extern int nfs4_state_mark_reclaim_nograce(struct nfs_client *, struct nfs4_stat
 extern void nfs4_schedule_lease_recovery(struct nfs_client *);
 extern int nfs4_wait_clnt_recover(struct nfs_client *clp);
 extern int nfs4_client_recover_expired_lease(struct nfs_client *clp);
-extern void nfs4_schedule_state_manager(struct nfs_client *);
+extern int nfs4_schedule_state_manager(struct nfs_client *);
 extern void nfs4_schedule_path_down_recovery(struct nfs_client *clp);
 extern int nfs4_schedule_stateid_recovery(const struct nfs_server *, struct nfs4_state *);
 extern int nfs4_schedule_migration_recovery(const struct nfs_server *);
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index a2d2d5d1b088..127027f777c8 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -376,8 +376,9 @@ int nfs41_discover_server_trunking(struct nfs_client *clp,
 		else
 			set_bit(NFS4CLNT_LEASE_CONFIRM, &clp->cl_state);
 	}
-	nfs4_schedule_state_manager(clp);
-	status = nfs_wait_client_init_complete(clp);
+	status = nfs4_schedule_state_manager(clp);
+	if (!status)
+		status = nfs_wait_client_init_complete(clp);
 	if (status < 0)
 		nfs_put_client(clp);
 	return status;
@@ -1201,11 +1202,12 @@ static void nfs4_clear_state_manager_bit(struct nfs_client *clp)
 /*
  * Schedule the nfs_client asynchronous state management routine
  */
-void nfs4_schedule_state_manager(struct nfs_client *clp)
+int nfs4_schedule_state_manager(struct nfs_client *clp)
 {
 	struct task_struct *task;
 	char buf[INET6_ADDRSTRLEN + sizeof("-manager") + 1];
 	struct rpc_clnt *cl = clp->cl_rpcclient;
+	int ret = 0;
 
 	while (cl != cl->cl_parent)
 		cl = cl->cl_parent;
@@ -1213,7 +1215,7 @@ void nfs4_schedule_state_manager(struct nfs_client *clp)
 	set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
 	if (test_and_set_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state) != 0) {
 		wake_up_var(&clp->cl_state);
-		return;
+		goto out;
 	}
 	set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state);
 	__module_get(THIS_MODULE);
@@ -1228,13 +1230,16 @@ void nfs4_schedule_state_manager(struct nfs_client *clp)
 	rcu_read_unlock();
 	task = kthread_run(nfs4_run_state_manager, clp, "%s", buf);
 	if (IS_ERR(task)) {
+		ret = PTR_ERR(task);
 		printk(KERN_ERR "%s: kthread_run: %ld\n",
-			__func__, PTR_ERR(task));
+			__func__, ret);
 		nfs4_clear_state_manager_bit(clp);
 		clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
 		nfs_put_client(clp);
 		module_put(THIS_MODULE);
 	}
+out:
+	return ret;
 }
 
 /*
-- 
2.31.1

