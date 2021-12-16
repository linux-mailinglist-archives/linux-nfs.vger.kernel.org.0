Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416C04780FB
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 00:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhLPXya (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Dec 2021 18:54:30 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47280 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbhLPXy3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Dec 2021 18:54:29 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0FD6C2111A;
        Thu, 16 Dec 2021 23:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639698868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0YlWWmo2jWTqt7N81UWi0KQAD+FCdGohmTtrWNDINy4=;
        b=inDo9UjNmQEg+QtkTjpBTGCaytQv2VjTF0/XFJNQ9cRjYRy3ooi7OAXHAgyQz6JSpB4Sbg
        0DZBq8dUII3svHW7oyN468XGTabuoN3YN9+/VrEl2SH2VQxyXIzM6kKaKmLp7mPo0lOpkR
        6zw3mB04GX6QNxf9RLkyerhcaiCEucE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639698868;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0YlWWmo2jWTqt7N81UWi0KQAD+FCdGohmTtrWNDINy4=;
        b=9QiAhPNwjhDf314YUAVOc6SMTJT+15xL2fGJ3N7fHjTm85zT/VMCIYDMmtGDvbKG4w8MpE
        7BIW8t4MurqtFSAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04A4F13EFD;
        Thu, 16 Dec 2021 23:54:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XeORLLDRu2EQXAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 16 Dec 2021 23:54:24 +0000
Subject: [PATCH 17/18] NFSv4: keep state manager thread active if swap is
 enabled
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 17 Dec 2021 10:48:23 +1100
Message-ID: <163969850343.20885.13733170689644192942.stgit@noble.brown>
In-Reply-To: <163969801519.20885.3977673503103544412.stgit@noble.brown>
References: <163969801519.20885.3977673503103544412.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
index 996dfb3c74b2..6ad054b9bbd0 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -490,8 +490,9 @@ static int nfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	unsigned long blocks;
 	long long isize;
 	int ret;
-	struct rpc_clnt *clnt = NFS_CLIENT(file->f_mapping->host);
-	struct inode *inode = file->f_mapping->host;
+	struct inode *inode = file_inode(file);
+	struct rpc_clnt *clnt = NFS_CLIENT(inode);
+	struct nfs_client *cl = NFS_SERVER(inode)->nfs_client;
 
 	spin_lock(&inode->i_lock);
 	blocks = inode->i_blocks;
@@ -512,14 +513,22 @@ static int nfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	}
 	*span = sis->pages;
 	sis->flags |= SWP_FS_OPS;
+
+	if (cl->rpc_ops->enable_swap)
+		cl->rpc_ops->enable_swap(inode);
+
 	return ret;
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
index ed5eaca6801e..8a9ce0f42efd 100644
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
index ee3bc79f6ca3..ab6382f9cbf0 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10347,6 +10347,24 @@ static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
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
@@ -10423,6 +10441,8 @@ const struct nfs_rpc_ops nfs_v4_clientops = {
 	.free_client	= nfs4_free_client,
 	.create_server	= nfs4_create_server,
 	.clone_server	= nfs_clone_server,
+	.enable_swap	= nfs4_enable_swap,
+	.disable_swap	= nfs4_disable_swap,
 };
 
 static const struct xattr_handler nfs4_xattr_nfs4_acl_handler = {
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index f63dfa01001c..ebe470e6aa8f 100644
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
@@ -2665,11 +2673,8 @@ static void nfs4_state_manager(struct nfs_client *clp)
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
 
@@ -2689,9 +2694,31 @@ static void nfs4_state_manager(struct nfs_client *clp)
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
 	module_put_and_exit(0);
 	return 0;
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 967a0098f0a9..04cf3a8fb949 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1795,6 +1795,8 @@ struct nfs_rpc_ops {
 	struct nfs_server *(*create_server)(struct fs_context *);
 	struct nfs_server *(*clone_server)(struct nfs_server *, struct nfs_fh *,
 					   struct nfs_fattr *, rpc_authflavor_t);
+	void	(*enable_swap)(struct inode *inode);
+	void	(*disable_swap)(struct inode *inode);
 };
 
 /*
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index cb76fbea3ed5..4cb403a0f334 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -3066,6 +3066,8 @@ rpc_clnt_swap_activate_callback(struct rpc_clnt *clnt,
 int
 rpc_clnt_swap_activate(struct rpc_clnt *clnt)
 {
+	while (clnt != clnt->cl_parent)
+		clnt = clnt->cl_parent;
 	if (atomic_inc_return(&clnt->cl_swapper) == 1)
 		return rpc_clnt_iterate_for_each_xprt(clnt,
 				rpc_clnt_swap_activate_callback, NULL);


