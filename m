Return-Path: <linux-nfs+bounces-17356-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6D0CE9E87
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Dec 2025 15:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9C273012CDE
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Dec 2025 14:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47AD2494FF;
	Tue, 30 Dec 2025 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2X7abgV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07C7230BDB
	for <linux-nfs@vger.kernel.org>; Tue, 30 Dec 2025 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767104325; cv=none; b=VT8eLaseE/exCHQtn2mJ4nMmXTexxKSwlQszgHTr3Cq9c3Q+ycyipbf9KmDQggl8sMB+OuaB4NiD0u/AeQa+ZHFAE/Yk8zIryyFG6aK19YQgD4zC3gvg0TaCz5BWaCp+ZkV9XWTAgrzp64oCoFLMSE4ohQfmmmXOd9riBOv2Dnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767104325; c=relaxed/simple;
	bh=yDrb9lvl5zFw+NF300EfyqOlW1KPTn+LDDgbh/qmKBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVA0cK3zqFPDJSf45OUwRFAc6kA2/FDzWULFa/VTgWn+Hm2+QfdtUR3pSWUwGqNRXPFCXzKWrdviLxTz8Yk7peTXvQuGjT6viN9th2TekYsOV5ypUzX7qBsAO2RhuJRh54crDxpl6pUCHRG4kTrg1dIBLYvlf9/03nSmjXZ7F0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2X7abgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8190C19425;
	Tue, 30 Dec 2025 14:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767104325;
	bh=yDrb9lvl5zFw+NF300EfyqOlW1KPTn+LDDgbh/qmKBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I2X7abgVuTW/bhBszommI/zkFrhemeOMqSQcp41z/ONtqkeJVZwXMY8JPtooq5Q2D
	 qumX72s/jU61sPBcCGvw5Vy/EfQvQZpCgkcywl8Mt43QgirTcAFuyvE/IoWPJaK4GR
	 NsxRpj/UmwZNq+bQi8C+IuIjzduC4HOoSABr/3VNTj+3qd3qdzHI6GrOcsV0SMrXRo
	 dlVaEN1sfgcJF/Ly2kilF/pAiuCwNqGjvILG+A3pRPFSiU1cGLqpsgMCLs+U2YkIVr
	 WNWsC4L+0US+UzulR9/8CasDakfNYOZePO9tetV/wIOTElIeIEHGxJZe8mXPTX6xcC
	 kW8PmUgxeqZ9w==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 4/5] nfsd: revoke NFSv4 state when filesystem is unmounted
Date: Tue, 30 Dec 2025 09:18:37 -0500
Message-ID: <20251230141838.2547848-5-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230141838.2547848-1-cel@kernel.org>
References: <20251230141838.2547848-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

When an NFS server's local filesystem is unmounted while NFS
clients are still accessing it, NFSv4 state holds files open
which pins the filesystem, preventing unmount.

Currently, administrators have to manually revoke that state via
/proc/fs/nfsd/unlock_fs before a formerly exported filesystem
can be unmounted.

Use the kernel's fs_pin mechanism to detect filesystem unmounts
and revoke NFSv4 state and NLM locks associated with that
filesystem. An xarray in nfsd_net tracks per-superblock pins. When
any NFS state is created, a pin is registered (idempotently) for
that superblock. When the filesystem is unmounted, VFS invokes the
kill callback which queues work to:
 - Cancel ongoing async COPY operations (nfsd4_cancel_copy_by_sb)
 - Release NLM locks (nlmsvc_unlock_all_by_sb)
 - Revoke NFSv4 state (nfsd4_revoke_states)

The code uses pin_insert_group() to register superblock-only pins
rather than pin_insert() which registers both mount and superblock
pins. This is necessary because the VFS unmount sequence calls
mnt_pin_kill() before clearing SB_ACTIVE, but group_pin_kill()
after. Superblock-only pins with an SB_ACTIVE check after
insertion reliably detect whether VFS invokes the kill callback.

The revocation work runs on a dedicated workqueue (nfsd_pin_wq) to
avoid deadlocks since the VFS kill callback runs with locks held.
Synchronization between VFS unmount and NFSD shutdown uses
xa_erase() atomicity: the path that successfully erases the xarray
entry triggers work.

If state revocation takes an unexpectedly long time (e.g., when
re-exporting an NFS mount whose backend server is unresponsive),
periodic warnings are emitted every 30 seconds. The wait is
interruptible: if interrupted while work is already running, the
kill callback returns and revocation continues in the background.
Open files keep the superblock alive until revocation closes them.
Note that NFSD remains pinned until revocation completes.

The pin infrastructure is placed in a new file (pin.c) to keep it
separate from NFSv4-specific state management code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/Makefile    |   2 +-
 fs/nfsd/netns.h     |   4 +
 fs/nfsd/nfs4state.c |  24 ++++
 fs/nfsd/nfsctl.c    |  10 +-
 fs/nfsd/pin.c       | 270 ++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/state.h     |   7 ++
 6 files changed, 314 insertions(+), 3 deletions(-)
 create mode 100644 fs/nfsd/pin.c

diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
index f0da4d69dc74..b9ef1fe13164 100644
--- a/fs/nfsd/Makefile
+++ b/fs/nfsd/Makefile
@@ -13,7 +13,7 @@ nfsd-y			+= trace.o
 nfsd-y 			+= nfssvc.o nfsctl.o nfsfh.o vfs.o \
 			   export.o auth.o lockd.o nfscache.o \
 			   stats.o filecache.o nfs3proc.o nfs3xdr.o \
-			   netlink.o
+			   netlink.o pin.o
 nfsd-$(CONFIG_NFSD_V2) += nfsproc.o nfsxdr.o
 nfsd-$(CONFIG_NFSD_V2_ACL) += nfs2acl.o
 nfsd-$(CONFIG_NFSD_V3_ACL) += nfs3acl.o
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index d83c68872c4c..4385a0619035 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -13,6 +13,7 @@
 #include <linux/filelock.h>
 #include <linux/nfs4.h>
 #include <linux/percpu_counter.h>
+#include <linux/xarray.h>
 #include <linux/percpu-refcount.h>
 #include <linux/siphash.h>
 #include <linux/sunrpc/stats.h>
@@ -213,6 +214,9 @@ struct nfsd_net {
 	/* last time an admin-revoke happened for NFSv4.0 */
 	time64_t		nfs40_last_revoke;
 
+	/* fs_pin tracking for automatic state revocation on unmount */
+	struct xarray		nfsd_sb_pins;
+
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 	/* Local clients to be invalidated when net is shut down */
 	spinlock_t              local_clients_lock;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 61f99bcce7f6..61b5df27362e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6445,6 +6445,15 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 		status = nfserr_bad_stateid;
 		if (nfsd4_is_deleg_cur(open))
 			goto out;
+		/*
+		 * This is a new nfs4_file. Pin the superblock so that
+		 * unmount can trigger revocation of NFSv4 state (opens,
+		 * locks, delegations) held by clients on this filesystem.
+		 */
+		status = nfsd_pin_sb(SVC_NET(rqstp),
+				     current_fh->fh_export->ex_path.mnt);
+		if (status)
+			goto out;
 	}
 
 	if (!stp) {
@@ -8981,6 +8990,8 @@ static int nfs4_state_create_net(struct net *net)
 	spin_lock_init(&nn->blocked_locks_lock);
 	INIT_LIST_HEAD(&nn->blocked_locks_lru);
 
+	nfsd_sb_pins_init(nn);
+
 	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
 	/* Make sure this cannot run until client tracking is initialised */
 	disable_delayed_work(&nn->laundromat_work);
@@ -9098,6 +9109,8 @@ nfs4_state_shutdown_net(struct net *net)
 	struct list_head *pos, *next, reaplist;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
+	nfsd_sb_pins_shutdown(nn);
+
 	shrinker_free(nn->nfsd_client_shrinker);
 	cancel_work_sync(&nn->nfsd_shrinker_work);
 	disable_delayed_work_sync(&nn->laundromat_work);
@@ -9452,6 +9465,17 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 	if (rfp != fp) {
 		put_nfs4_file(fp);
 		fp = rfp;
+	} else {
+		/*
+		 * This is a new nfs4_file. Pin the superblock so that
+		 * unmount can trigger revocation of directory delegations
+		 * held by clients on this filesystem.
+		 */
+		if (nfsd_pin_sb(clp->net,
+				cstate->current_fh.fh_export->ex_path.mnt)) {
+			put_nfs4_file(fp);
+			return ERR_PTR(-EAGAIN);
+		}
 	}
 
 	/* if this client already has one, return that it's unavailable */
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 6bf1acaddb04..2d3fcd941886 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2275,9 +2275,12 @@ static int __init init_nfsd(void)
 	retval = nfsd4_create_laundry_wq();
 	if (retval)
 		goto out_free_cld;
+	retval = nfsd_pin_init();
+	if (retval)
+		goto out_free_laundry;
 	retval = register_filesystem(&nfsd_fs_type);
 	if (retval)
-		goto out_free_nfsd4;
+		goto out_free_pin;
 	retval = genl_register_family(&nfsd_nl_family);
 	if (retval)
 		goto out_free_filesystem;
@@ -2291,7 +2294,9 @@ static int __init init_nfsd(void)
 	genl_unregister_family(&nfsd_nl_family);
 out_free_filesystem:
 	unregister_filesystem(&nfsd_fs_type);
-out_free_nfsd4:
+out_free_pin:
+	nfsd_pin_exit();
+out_free_laundry:
 	nfsd4_destroy_laundry_wq();
 out_free_cld:
 	unregister_cld_notifier();
@@ -2314,6 +2319,7 @@ static void __exit exit_nfsd(void)
 	remove_proc_entry("fs/nfs", NULL);
 	genl_unregister_family(&nfsd_nl_family);
 	unregister_filesystem(&nfsd_fs_type);
+	nfsd_pin_exit();
 	nfsd4_destroy_laundry_wq();
 	unregister_cld_notifier();
 	unregister_pernet_subsys(&nfsd_net_ops);
diff --git a/fs/nfsd/pin.c b/fs/nfsd/pin.c
new file mode 100644
index 000000000000..f8d0d7cda404
--- /dev/null
+++ b/fs/nfsd/pin.c
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Filesystem pin management for NFSD.
+ *
+ * When a local filesystem is unmounted while NFS clients hold state,
+ * this code automatically revokes that state so the unmount can proceed.
+ *
+ * Copyright (C) 2025 Oracle. All rights reserved.
+ *
+ * Author: Chuck Lever <chuck.lever@oracle.com>
+ */
+
+#include <linux/fs.h>
+#include <linux/fs_pin.h>
+#include <linux/slab.h>
+#include <linux/sunrpc/svc.h>
+#include <linux/lockd/lockd.h>
+
+#include "nfsd.h"
+#include "netns.h"
+#include "state.h"
+
+#define NFSDDBG_FACILITY	NFSDDBG_PROC
+
+static struct workqueue_struct *nfsd_pin_wq;
+
+/*
+ * Structure to track fs_pin per superblock for automatic state revocation
+ * when a filesystem is unmounted.
+ */
+struct nfsd_fs_pin {
+	struct fs_pin		pin;
+	struct super_block	*sb;
+	struct net		*net;
+	struct work_struct	work;
+	struct completion	done;
+	struct rcu_head		rcu;
+};
+
+static void nfsd_fs_pin_kill(struct fs_pin *pin);
+
+static void nfsd_fs_pin_free_rcu(struct rcu_head *rcu)
+{
+	struct nfsd_fs_pin *p = container_of(rcu, struct nfsd_fs_pin, rcu);
+
+	put_net(p->net);
+	kfree(p);
+}
+
+/*
+ * Work function for nfsd_fs_pin - runs in process context.
+ * Cancels async COPYs, releases NLM locks, and revokes NFSv4 state for
+ * the superblock.
+ */
+static void nfsd_fs_pin_work(struct work_struct *work)
+{
+	struct nfsd_fs_pin *p = container_of(work, struct nfsd_fs_pin, work);
+	struct nfsd_net *nn = net_generic(p->net, nfsd_net_id);
+
+	pr_info("nfsd: unmount of %s, revoking NFS state\n", p->sb->s_id);
+
+	nfsd4_cancel_copy_by_sb(p->net, p->sb);
+	/* Errors are logged by lockd; no recovery is possible. */
+	(void)nlmsvc_unlock_all_by_sb(p->sb);
+	nfsd4_revoke_states(nn, p->sb);
+
+	pr_info("nfsd: state revocation for %s complete\n", p->sb->s_id);
+
+	pin_remove(&p->pin);
+	complete(&p->done);
+	call_rcu(&p->rcu, nfsd_fs_pin_free_rcu);
+}
+
+/* Interval for progress warnings during unmount (in seconds) */
+#define NFSD_STATE_REVOKE_INTERVAL	30
+
+/**
+ * nfsd_fs_pin_kill - Kill callback for nfsd_fs_pin
+ * @pin: fs_pin representing filesystem to be unmounted
+ *
+ * Queues state revocation and waits for completion. If interrupted,
+ * returns early; the work function handles cleanup. Open files keep
+ * the superblock alive until revocation closes them.
+ *
+ * Synchronization with nfsd_sb_pins_destroy(): xa_erase() is atomic,
+ * so exactly one of the two paths erases the entry and triggers work.
+ */
+static void nfsd_fs_pin_kill(struct fs_pin *pin)
+{
+	struct nfsd_fs_pin *p = container_of(pin, struct nfsd_fs_pin, pin);
+	struct nfsd_net *nn = net_generic(p->net, nfsd_net_id);
+	unsigned int elapsed = 0;
+	long ret;
+
+	if (!xa_erase(&nn->nfsd_sb_pins, (unsigned long)p->sb))
+		return;
+
+	queue_work(nfsd_pin_wq, &p->work);
+
+	/*
+	 * Block until state revocation completes. Periodic warnings help
+	 * diagnose stuck operations (e.g., re-exports of an NFS mount
+	 * whose backend server is unresponsive).
+	 *
+	 * The work function handles pin_remove() and freeing, so this
+	 * callback can return early on interrupt. Open files keep the
+	 * superblock alive until revocation closes them. Note that NFSD
+	 * remains pinned until revocation completes.
+	 */
+	for (;;) {
+		ret = wait_for_completion_interruptible_timeout(&p->done,
+						NFSD_STATE_REVOKE_INTERVAL * HZ);
+		if (ret > 0)
+			return;
+
+		if (ret == -ERESTARTSYS) {
+			/*
+			 * Interrupted by signal. If the work has not yet
+			 * started, cancel it and run synchronously here.
+			 * If already running, return and let work complete
+			 * in background; open files keep superblock alive.
+			 */
+			if (cancel_work(&p->work)) {
+				pr_warn("nfsd: unmount of %s interrupted, "
+					"revoking state synchronously\n",
+					p->sb->s_id);
+				nfsd_fs_pin_work(&p->work);
+				return;
+			}
+			pr_warn("nfsd: unmount of %s interrupted; mount remains "
+				"pinned until state revocation completes\n",
+				p->sb->s_id);
+			return;
+		}
+
+		/* Timed out - print warning and continue waiting */
+		elapsed += NFSD_STATE_REVOKE_INTERVAL;
+		pr_warn("nfsd: unmount of %s blocked for %u seconds "
+			"waiting for NFS state revocation\n",
+			p->sb->s_id, elapsed);
+	}
+}
+
+/**
+ * nfsd_pin_sb - register a superblock to enable state revocation
+ * @net: network namespace
+ * @mnt: vfsmount for the filesystem
+ *
+ * If NFS state is created for a file on this filesystem, pin the
+ * superblock so the kill callback can revoke that state on unmount.
+ * Returns nfs_ok on success, or an NFS error on failure.
+ *
+ * This function is idempotent - if a pin already exists for the
+ * superblock, no new pin is created.
+ */
+__be32 nfsd_pin_sb(struct net *net, struct vfsmount *mnt)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct super_block *sb = mnt->mnt_sb;
+	struct nfsd_fs_pin *new, *old;
+
+	old = xa_load(&nn->nfsd_sb_pins, (unsigned long)sb);
+	if (old)
+		return nfs_ok;
+
+	new = kzalloc(sizeof(*new), GFP_KERNEL);
+	if (!new)
+		return nfserr_jukebox;
+
+	new->sb = sb;
+	new->net = get_net(net);
+	init_fs_pin(&new->pin, nfsd_fs_pin_kill);
+	INIT_WORK(&new->work, nfsd_fs_pin_work);
+	init_completion(&new->done);
+
+	old = xa_cmpxchg(&nn->nfsd_sb_pins, (unsigned long)sb, NULL, new,
+			 GFP_KERNEL);
+	if (old) {
+		/* Another task beat us to it */
+		put_net(new->net);
+		kfree(new);
+		return nfs_ok;
+	}
+
+	pin_insert_group(&new->pin, mnt);
+
+	/*
+	 * Check if the superblock became inactive while the pin was being
+	 * registered. If VFS already started unmount, group_pin_kill()
+	 * may or may not invoke the kill callback depending on timing.
+	 *
+	 * If SB_ACTIVE is clear, clean up here. xa_erase() synchronizes
+	 * with nfsd_fs_pin_kill() and nfsd_sb_pins_destroy(): the path
+	 * that successfully erases the xarray entry performs cleanup;
+	 * the other path skips it.
+	 */
+	if (!(READ_ONCE(sb->s_flags) & SB_ACTIVE)) {
+		new = xa_erase(&nn->nfsd_sb_pins, (unsigned long)sb);
+		if (new) {
+			pin_remove(&new->pin);
+			call_rcu(&new->rcu, nfsd_fs_pin_free_rcu);
+		}
+		return nfserr_stale;
+	}
+
+	return nfs_ok;
+}
+
+/**
+ * nfsd_sb_pins_init - initialize the superblock pins xarray
+ * @nn: nfsd_net for this network namespace
+ */
+void nfsd_sb_pins_init(struct nfsd_net *nn)
+{
+	xa_init(&nn->nfsd_sb_pins);
+}
+
+/*
+ * Clean up all fs_pins during NFSD shutdown.
+ *
+ * xa_erase() synchronizes with nfsd_fs_pin_kill(): the path that
+ * successfully erases an xarray entry performs cleanup for that pin.
+ * A NULL return indicates the VFS unmount path is performing cleanup.
+ */
+static void nfsd_sb_pins_destroy(struct nfsd_net *nn)
+{
+	struct nfsd_fs_pin *p;
+	unsigned long index;
+
+	xa_for_each(&nn->nfsd_sb_pins, index, p) {
+		p = xa_erase(&nn->nfsd_sb_pins, index);
+		if (!p)
+			continue; /* VFS unmount path handling this pin */
+		pin_remove(&p->pin);
+		call_rcu(&p->rcu, nfsd_fs_pin_free_rcu);
+	}
+	xa_destroy(&nn->nfsd_sb_pins);
+}
+
+/**
+ * nfsd_sb_pins_shutdown - shutdown superblock pins for a network namespace
+ * @nn: nfsd_net for this network namespace
+ *
+ * Must be called during nfsd shutdown before tearing down client state.
+ * Flushes any pending work and waits for RCU callbacks to complete.
+ */
+void nfsd_sb_pins_shutdown(struct nfsd_net *nn)
+{
+	nfsd_sb_pins_destroy(nn);
+	flush_workqueue(nfsd_pin_wq);
+	/*
+	 * Wait for RCU callbacks from nfsd_sb_pins_destroy() to complete.
+	 * These callbacks release network namespace references via put_net()
+	 * which must happen before the namespace teardown continues.
+	 */
+	rcu_barrier();
+}
+
+int nfsd_pin_init(void)
+{
+	nfsd_pin_wq = alloc_workqueue("nfsd_pin", WQ_UNBOUND, 0);
+	if (!nfsd_pin_wq)
+		return -ENOMEM;
+	return 0;
+}
+
+void nfsd_pin_exit(void)
+{
+	destroy_workqueue(nfsd_pin_wq);
+}
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index f1c1bac173a5..6c1f22e200d8 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -850,6 +850,13 @@ static inline void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *
 }
 #endif
 
+/* superblock pin management (pin.c) */
+int nfsd_pin_init(void);
+void nfsd_pin_exit(void);
+__be32 nfsd_pin_sb(struct net *net, struct vfsmount *mnt);
+void nfsd_sb_pins_init(struct nfsd_net *nn);
+void nfsd_sb_pins_shutdown(struct nfsd_net *nn);
+
 /* grace period management */
 bool nfsd4_force_end_grace(struct nfsd_net *nn);
 
-- 
2.52.0


