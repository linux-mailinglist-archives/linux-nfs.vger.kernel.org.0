Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6495E7A3EC5
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 01:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjIQXMH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 17 Sep 2023 19:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238437AbjIQXME (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 17 Sep 2023 19:12:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3750120
        for <linux-nfs@vger.kernel.org>; Sun, 17 Sep 2023 16:11:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7E0C433C7;
        Sun, 17 Sep 2023 23:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694992318;
        bh=3erpsaEK2+lUc6zmfC9K5oPLp01NQD9LuTDVFXKXZaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CJ1ix7o2aLGj00n2up9ZdXANmIahSZ0ryLL2Mdr63nBEZArs8unCTVqhy6+9/lgUc
         zydCLPNU5ci4ToV+TSk7TDynVYwaPSmi47FLMnVTqNxgR++Pd5mi711QGGvN8A4p00
         fDNG6sZMZFY4W7V3NnNVaYNlzf+FBX+ImGjDU5PAfw3nlAARy2e5+Y4SK1yX4KkbxJ
         hZ07V+gjBx7GvUJsbTf1yONqUeykUdQz6gyEUBMs6QbRq3FQQnLgzRubIqGhSi+Rx/
         C/+ePGHIlJTQEQmhstKPJWBA4DSnZTjQM5DPJee5UH+WB5BOuXdEadBz82BcN6kmZ9
         ZjO4JBavwpb1Q==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, Neil Brown <neilb@suse.de>
Subject: [PATCH 2/2] NFSv4: Fix a state manager thread deadlock regression
Date:   Sun, 17 Sep 2023 19:05:51 -0400
Message-ID: <20230917230551.30483-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230917230551.30483-1-trondmy@kernel.org>
References: <20230917230551.30483-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Commit 4dc73c679114 reintroduces the deadlock that was fixed by commit
aeabb3c96186 ("NFSv4: Fix a NFSv4 state manager deadlock") because it
prevents the setup of new threads to handle reboot recovery, while the
older recovery thread is stuck returning delegations.

Fixes: 4dc73c679114 ("NFSv4: keep state manager thread active if swap is enabled")
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c  |  4 +++-
 fs/nfs/nfs4state.c | 38 ++++++++++++++++++++++++++------------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 5deeaea8026e..a19e809cad16 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10652,7 +10652,9 @@ static void nfs4_disable_swap(struct inode *inode)
 	 */
 	struct nfs_client *clp = NFS_SERVER(inode)->nfs_client;
 
-	nfs4_schedule_state_manager(clp);
+	set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
+	clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
+	wake_up_var(&clp->cl_state);
 }
 
 static const struct inode_operations nfs4_dir_inode_operations = {
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 0bc160fbabec..5751a6886da4 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1209,16 +1209,26 @@ void nfs4_schedule_state_manager(struct nfs_client *clp)
 {
 	struct task_struct *task;
 	char buf[INET6_ADDRSTRLEN + sizeof("-manager") + 1];
+	struct rpc_clnt *clnt = clp->cl_rpcclient;
+	bool swapon = false;
 
-	if (clp->cl_rpcclient->cl_shutdown)
+	if (clnt->cl_shutdown)
 		return;
 
 	set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
-	if (test_and_set_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state) != 0) {
-		wake_up_var(&clp->cl_state);
-		return;
+
+	if (atomic_read(&clnt->cl_swapper)) {
+		swapon = !test_and_set_bit(NFS4CLNT_MANAGER_AVAILABLE,
+					   &clp->cl_state);
+		if (!swapon) {
+			wake_up_var(&clp->cl_state);
+			return;
+		}
 	}
-	set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state);
+
+	if (test_and_set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state) != 0)
+		return;
+
 	__module_get(THIS_MODULE);
 	refcount_inc(&clp->cl_count);
 
@@ -1235,8 +1245,9 @@ void nfs4_schedule_state_manager(struct nfs_client *clp)
 			__func__, PTR_ERR(task));
 		if (!nfs_client_init_is_complete(clp))
 			nfs_mark_client_ready(clp, PTR_ERR(task));
+		if (swapon)
+			clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
 		nfs4_clear_state_manager_bit(clp);
-		clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
 		nfs_put_client(clp);
 		module_put(THIS_MODULE);
 	}
@@ -2748,22 +2759,25 @@ static int nfs4_run_state_manager(void *ptr)
 
 	allow_signal(SIGKILL);
 again:
-	set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state);
 	nfs4_state_manager(clp);
-	if (atomic_read(&cl->cl_swapper)) {
+
+	if (test_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state) &&
+	    !test_and_set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state)) {
 		wait_var_event_interruptible(&clp->cl_state,
 					     test_bit(NFS4CLNT_RUN_MANAGER,
 						      &clp->cl_state));
-		if (atomic_read(&cl->cl_swapper) &&
-		    test_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state))
+		if (!atomic_read(&cl->cl_swapper))
+			clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
+		if (refcount_read(&clp->cl_count) > 1 && !signalled())
 			goto again;
 		/* Either no longer a swapper, or were signalled */
+		clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
+		nfs4_clear_state_manager_bit(clp);
 	}
-	clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
 
 	if (refcount_read(&clp->cl_count) > 1 && !signalled() &&
 	    test_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state) &&
-	    !test_and_set_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state))
+	    !test_and_set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state))
 		goto again;
 
 	nfs_put_client(clp);
-- 
2.41.0

