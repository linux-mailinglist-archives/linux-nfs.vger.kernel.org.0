Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33FB4CEEA6
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Mar 2022 00:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbiCFXoE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 6 Mar 2022 18:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbiCFXoD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 6 Mar 2022 18:44:03 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825E93EA9E
        for <linux-nfs@vger.kernel.org>; Sun,  6 Mar 2022 15:43:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3C4A0210FF;
        Sun,  6 Mar 2022 23:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646610189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yZmSIr8ZLVyhZTWR/059cLHJTosbTOBWKNNzA+rztwo=;
        b=uSVF0aURja2cE16TbI51SF5+4dMLesvJmvWFtO6HlebfGnv1CJta1f6nYWuq40DpvWgEi/
        ifAaxh/Y00bxH+mIIDDbCNApajNKUcIcOtUhh3KxmITNezKsKUKiagVbMnJKynEFrFvEKS
        WhQbMIMU0g6TyM/1FYr4ryL+GoK4EF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646610189;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yZmSIr8ZLVyhZTWR/059cLHJTosbTOBWKNNzA+rztwo=;
        b=uxXs1kn1oNXShqgVDojgPBuG3XapoZYGSNfZH97D/3QMwcH30OxKN8qEAWFttXQKbdPdOv
        tTBFh0ChN17c1GAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CCC6134CD;
        Sun,  6 Mar 2022 23:43:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z6gpNwtHJWI9WAAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 06 Mar 2022 23:43:07 +0000
Subject: [PATCH 08/11] NFSv4: keep state manager thread active if swap is
 enabled
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 07 Mar 2022 10:41:44 +1100
Message-ID: <164661010497.31054.2736520975524167649.stgit@noble.brown>
In-Reply-To: <164660993703.31054.17075972410545449555.stgit@noble.brown>
References: <164660993703.31054.17075972410545449555.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If we are swapping over NFSv4, we may not be able to allocate memory to
start the state-manager thread at the time when we need it.
So keep it always running when swap is enabled, and just signal it to
start.

This requires updating and testing the cl_swapper count on the root
rpc_clnt after following all ->cl_parent links.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/file.c           |   15 ++++++++++++---
 fs/nfs/nfs4_fs.h        |    1 +
 fs/nfs/nfs4proc.c       |   20 ++++++++++++++++++++
 fs/nfs/nfs4state.c      |   39 +++++++++++++++++++++++++++++++++------
 include/linux/nfs_xdr.h |    2 ++
 net/sunrpc/clnt.c       |    2 ++
 6 files changed, 70 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 901f316f084d..e82f78e256e5 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -483,8 +483,9 @@ static int nfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 {
 	unsigned long blocks;
 	long long isize;
-	struct rpc_clnt *clnt = NFS_CLIENT(file->f_mapping->host);
-	struct inode *inode = file->f_mapping->host;
+	struct inode *inode = file_inode(file);
+	struct rpc_clnt *clnt = NFS_CLIENT(inode);
+	struct nfs_client *cl = NFS_SERVER(inode)->nfs_client;
 
 	spin_lock(&inode->i_lock);
 	blocks = inode->i_blocks;
@@ -497,14 +498,22 @@ static int nfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 
 	*span = sis->pages;
 
+
+	if (cl->rpc_ops->enable_swap)
+		cl->rpc_ops->enable_swap(inode);
+
 	return rpc_clnt_swap_activate(clnt);
 }
 
 static void nfs_swap_deactivate(struct file *file)
 {
-	struct rpc_clnt *clnt = NFS_CLIENT(file->f_mapping->host);
+	struct inode *inode = file_inode(file);
+	struct rpc_clnt *clnt = NFS_CLIENT(inode);
+	struct nfs_client *cl = NFS_SERVER(inode)->nfs_client;
 
 	rpc_clnt_swap_deactivate(clnt);
+	if (cl->rpc_ops->disable_swap)
+		cl->rpc_ops->disable_swap(file_inode(file));
 }
 
 const struct address_space_operations nfs_file_aops = {
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 84f39b6f1b1e..79df6e83881b 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -42,6 +42,7 @@ enum nfs4_client_state {
 	NFS4CLNT_LEASE_MOVED,
 	NFS4CLNT_DELEGATION_EXPIRED,
 	NFS4CLNT_RUN_MANAGER,
+	NFS4CLNT_MANAGER_AVAILABLE,
 	NFS4CLNT_RECALL_RUNNING,
 	NFS4CLNT_RECALL_ANY_LAYOUT_READ,
 	NFS4CLNT_RECALL_ANY_LAYOUT_RW,
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 0e0db6c27619..32c8e9951ce1 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10461,6 +10461,24 @@ static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
 	return error + error2 + error3;
 }
 
+static void nfs4_enable_swap(struct inode *inode)
+{
+	/* The state manager thread must always be running.
+	 * It will notice the client is a swapper, and stay put.
+	 */
+	struct nfs_client *clp = NFS_SERVER(inode)->nfs_client;
+
+	nfs4_schedule_state_manager(clp);
+}
+
+static void nfs4_disable_swap(struct inode *inode)
+{
+	/* The state manager thread will now exit once it is
+	 * woken.
+	 */
+	wake_up_var(&NFS_SERVER(inode)->nfs_client->cl_state);
+}
+
 static const struct inode_operations nfs4_dir_inode_operations = {
 	.create		= nfs_create,
 	.lookup		= nfs_lookup,
@@ -10538,6 +10556,8 @@ const struct nfs_rpc_ops nfs_v4_clientops = {
 	.create_server	= nfs4_create_server,
 	.clone_server	= nfs_clone_server,
 	.discover_trunking = nfs4_discover_trunking,
+	.enable_swap	= nfs4_enable_swap,
+	.disable_swap	= nfs4_disable_swap,
 };
 
 static const struct xattr_handler nfs4_xattr_nfs4_acl_handler = {
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index f5a62c0d999b..5dc52eefaffb 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1205,10 +1205,17 @@ void nfs4_schedule_state_manager(struct nfs_client *clp)
 {
 	struct task_struct *task;
 	char buf[INET6_ADDRSTRLEN + sizeof("-manager") + 1];
+	struct rpc_clnt *cl = clp->cl_rpcclient;
+
+	while (cl != cl->cl_parent)
+		cl = cl->cl_parent;
 
 	set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
-	if (test_and_set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state) != 0)
+	if (test_and_set_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state) != 0) {
+		wake_up_var(&clp->cl_state);
 		return;
+	}
+	set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state);
 	__module_get(THIS_MODULE);
 	refcount_inc(&clp->cl_count);
 
@@ -1224,6 +1231,7 @@ void nfs4_schedule_state_manager(struct nfs_client *clp)
 		printk(KERN_ERR "%s: kthread_run: %ld\n",
 			__func__, PTR_ERR(task));
 		nfs4_clear_state_manager_bit(clp);
+		clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
 		nfs_put_client(clp);
 		module_put(THIS_MODULE);
 	}
@@ -2669,11 +2677,8 @@ static void nfs4_state_manager(struct nfs_client *clp)
 			clear_bit(NFS4CLNT_RECALL_RUNNING, &clp->cl_state);
 		}
 
-		/* Did we race with an attempt to give us more work? */
-		if (!test_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state))
-			return;
-		if (test_and_set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state) != 0)
-			return;
+		return;
+
 	} while (refcount_read(&clp->cl_count) > 1 && !signalled());
 	goto out_drain;
 
@@ -2693,9 +2698,31 @@ static void nfs4_state_manager(struct nfs_client *clp)
 static int nfs4_run_state_manager(void *ptr)
 {
 	struct nfs_client *clp = ptr;
+	struct rpc_clnt *cl = clp->cl_rpcclient;
+
+	while (cl != cl->cl_parent)
+		cl = cl->cl_parent;
 
 	allow_signal(SIGKILL);
+again:
+	set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state);
 	nfs4_state_manager(clp);
+	if (atomic_read(&cl->cl_swapper)) {
+		wait_var_event_interruptible(&clp->cl_state,
+					     test_bit(NFS4CLNT_RUN_MANAGER,
+						      &clp->cl_state));
+		if (atomic_read(&cl->cl_swapper) &&
+		    test_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state))
+			goto again;
+		/* Either no longer a swapper, or were signalled */
+	}
+	clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
+
+	if (refcount_read(&clp->cl_count) > 1 && !signalled() &&
+	    test_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state) &&
+	    !test_and_set_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state))
+		goto again;
+
 	nfs_put_client(clp);
 	module_put_and_kthread_exit(0);
 	return 0;
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 728cb0c1f0b6..6861ac8af808 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1798,6 +1798,8 @@ struct nfs_rpc_ops {
 	struct nfs_server *(*clone_server)(struct nfs_server *, struct nfs_fh *,
 					   struct nfs_fattr *, rpc_authflavor_t);
 	int	(*discover_trunking)(struct nfs_server *, struct nfs_fh *);
+	void	(*enable_swap)(struct inode *inode);
+	void	(*disable_swap)(struct inode *inode);
 };
 
 /*
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 842366a2fc57..04ccf6a06ca7 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -3069,6 +3069,8 @@ rpc_clnt_swap_activate_callback(struct rpc_clnt *clnt,
 int
 rpc_clnt_swap_activate(struct rpc_clnt *clnt)
 {
+	while (clnt != clnt->cl_parent)
+		clnt = clnt->cl_parent;
 	if (atomic_inc_return(&clnt->cl_swapper) == 1)
 		return rpc_clnt_iterate_for_each_xprt(clnt,
 				rpc_clnt_swap_activate_callback, NULL);


