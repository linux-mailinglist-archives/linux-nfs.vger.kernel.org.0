Return-Path: <linux-nfs+bounces-16629-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 95812C75CC2
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 18:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 443324E29D1
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 17:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE842F7AC4;
	Thu, 20 Nov 2025 17:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5UzvSNB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FE22EAD09
	for <linux-nfs@vger.kernel.org>; Thu, 20 Nov 2025 17:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763660914; cv=none; b=SEeUXkx/uajCWtLn26y4bzHwr6YmJRUg0skw++nMoE+chsgXbELNH42vtnDoaIk00sxsIqsco+YGA5dJr9rLR67DgBCTtnNjeDE3AJ77PglzPwhQdVMDKEUEjnK+UL5ZXpDizFWgdlwsIHTRmKMdbKE0Z8j16CtFsdl9YWKVlDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763660914; c=relaxed/simple;
	bh=fj14PL3pYedUd0UFXySYNYCX6sCf9YQyPk9TDH1WH/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k1yN+Ovp5afCnQ1DJMp5oX5zsBe4c79zSjTv4yR85ts6TW+cpNbf4N6UfICz25dj2bxNE2nHJNXf5+infDobeL1QH0PQNuOuq9mxlJHN0+gaVcdSOiDA7p0eaqCo4dxU7Wz0ZFrGpjMapH7jq757REGHr7tJqxBU6TrmqzQgjAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5UzvSNB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A72C4CEF1;
	Thu, 20 Nov 2025 17:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763660913;
	bh=fj14PL3pYedUd0UFXySYNYCX6sCf9YQyPk9TDH1WH/Q=;
	h=From:To:Cc:Subject:Date:From;
	b=D5UzvSNBJfWcN8rh4oxDNX3MoMmA1D2JFF+m/6Z/D926rGTVpwm8BAFKQfwNpoYZ5
	 YWVNXvGMR5FkIRCNsoxEFDgDkCLX7bFVr9De/a4pR7LmSftV16eTYPWkh8LnKD2/Jn
	 qVQa30SK5nAyLm3aePollX8mLnewjbMlM1wiQW7B8+ob1MMCbtCl61VPeVh6ndNI8w
	 Sc8Rjg6/NUq5o5ZsC0tC4tSBPL+KOCxO21gBZjSKxj6eIZq2zyA1uGZhmsYFmPLHa4
	 dzt2tkglnpa+qrDzrB3z40uxsMRyvpOzt049fA4s4DQTAMNKPmH0JRhaCSs/PtHK4O
	 FmyX6IE2PI3kw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH] locks: Add lm_would_deadlock callback to prevent NFSD hangs
Date: Thu, 20 Nov 2025 12:48:31 -0500
Message-ID: <20251120174831.5860-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

When multiple pNFS layout conflicts occur on an NFS server, the NFSD
thread pool can become exhausted while threads are waiting in
__break_lease for clients to return their layouts. If all NFSD
threads are blocked, none are available to process incoming
LAYOUTRETURNs, creating a deadlock.

The approach proposed here, although somewhat expedient, avoids
fencing responsive clients.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 Documentation/filesystems/locking.rst |  2 ++
 fs/locks.c                            | 12 ++++++++++
 fs/nfsd/nfs4layouts.c                 | 33 +++++++++++++++++++++++++++
 include/linux/filelock.h              |  1 +
 4 files changed, 48 insertions(+)

This is 100% untested and falls squarely in the "crazy ideas"
category. I'm posting to provide an alternative and encourage some
creative thinking about this sticky problem.

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 77704fde9845..6b0cb5fd03fd 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -403,6 +403,7 @@ prototypes::
 	bool (*lm_breaker_owns_lease)(struct file_lock *);
         bool (*lm_lock_expirable)(struct file_lock *);
         void (*lm_expire_lock)(void);
+        bool (*lm_would_deadlock)(struct file_lock *);
 
 locking rules:
 
@@ -416,6 +417,7 @@ lm_change		yes		no			no
 lm_breaker_owns_lease:	yes     	no			no
 lm_lock_expirable	yes		no			no
 lm_expire_lock		no		no			yes
+lm_would_deadlock	yes		no			no
 ======================	=============	=================	=========
 
 buffer_head
diff --git a/fs/locks.c b/fs/locks.c
index 04a3f0e20724..4ea473c885a8 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1615,6 +1615,18 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 	percpu_up_read(&file_rwsem);
 
 	locks_dispose_list(&dispose);
+
+	/* Check if lease manager predicts a deadlock situation */
+	if (fl->fl_lmops && fl->fl_lmops->lm_would_deadlock &&
+	    fl->fl_lmops->lm_would_deadlock(fl)) {
+		trace_break_lease_noblock(inode, new_fl);
+		error = -EWOULDBLOCK;
+		percpu_down_read(&file_rwsem);
+		spin_lock(&ctx->flc_lock);
+		__locks_delete_block(&new_fl->c);
+		goto out;
+	}
+
 	error = wait_event_interruptible_timeout(new_fl->c.flc_wait,
 						 list_empty(&new_fl->c.flc_blocked_member),
 						 break_time);
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 683bd1130afe..748a1b1b0626 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -764,9 +764,42 @@ nfsd4_layout_lm_change(struct file_lease *onlist, int arg,
 	return lease_modify(onlist, arg, dispose);
 }
 
+static bool
+nfsd4_layout_lm_would_deadlock(struct file_lease *fl)
+{
+	struct svc_rqst *rqstp;
+	struct svc_pool *pool;
+	struct llist_node *idle;
+
+	/*
+	 * Check if we're running in an NFSD thread context.
+	 * If not, we can't cause an NFSD deadlock.
+	 */
+	rqstp = nfsd_current_rqst();
+	if (!rqstp)
+		return false;
+
+	pool = rqstp->rq_pool;
+
+	/*
+	 * Check the number of idle threads in the pool. We use
+	 * READ_ONCE as sp_idle_threads is a lockless list.
+	 * If we have 0 or 1 idle threads remaining and the current
+	 * thread is about to block, we risk deadlock as there may
+	 * not be enough threads available to process the LAYOUTRETURN
+	 * RPCs needed to unblock.
+	 */
+	idle = READ_ONCE(pool->sp_idle_threads.first);
+	if (!idle || !READ_ONCE(idle->next))
+		return true;
+
+	return false;
+}
+
 static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
 	.lm_break	= nfsd4_layout_lm_break,
 	.lm_change	= nfsd4_layout_lm_change,
+	.lm_would_deadlock = nfsd4_layout_lm_would_deadlock,
 };
 
 int
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index c2ce8ba05d06..7c46444a3d50 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -49,6 +49,7 @@ struct lease_manager_operations {
 	int (*lm_change)(struct file_lease *, int, struct list_head *);
 	void (*lm_setup)(struct file_lease *, void **);
 	bool (*lm_breaker_owns_lease)(struct file_lease *);
+	bool (*lm_would_deadlock)(struct file_lease *);
 };
 
 struct lock_manager {
-- 
2.51.0


