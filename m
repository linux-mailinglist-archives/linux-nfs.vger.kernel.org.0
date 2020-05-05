Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032621C6289
	for <lists+linux-nfs@lfdr.de>; Tue,  5 May 2020 23:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgEEVBU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 May 2020 17:01:20 -0400
Received: from fieldses.org ([173.255.197.46]:46964 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbgEEVBT (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 5 May 2020 17:01:19 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 484BD150A; Tue,  5 May 2020 17:01:18 -0400 (EDT)
Date:   Tue, 5 May 2020 17:01:18 -0400
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>, Shaohua Li <shli@fb.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] allow multiple kthreadd's
Message-ID: <20200505210118.GC27966@fieldses.org>
References: <1588348912-24781-1-git-send-email-bfields@redhat.com>
 <CAHk-=wiGhZ_5xCRyUN+yMFdneKMQ-S8fBvdBp8o-JWPV4v+nVw@mail.gmail.com>
 <20200501182154.GG5462@mtj.thefacebook.com>
 <20200505021514.GA43625@pick.fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505021514.GA43625@pick.fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, May 04, 2020 at 10:15:14PM -0400, J. Bruce Fields wrote:
> Though now I'm feeling greedy: it would be nice to have both some kind
> of global flag, *and* keep kthread->data pointing to svc_rqst (as that
> would give me a simpler and quicker way to figure out which client is
> conflicting).  Could I take a flag bit in kthread->flags, maybe?

Would something like this be too hacky?:

	--- a/kernel/kthread.c
	+++ b/kernel/kthread.c
	@@ -58,6 +58,7 @@ enum KTHREAD_BITS {
	 	KTHREAD_IS_PER_CPU = 0,
	 	KTHREAD_SHOULD_STOP,
	 	KTHREAD_SHOULD_PARK,
	+	KTHREAD_IS_NFSD,
	 };
	 
	 static inline void set_kthread_struct(void *kthread)
	@@ -164,6 +165,25 @@ void *kthread_data(struct task_struct *task)
	 	return to_kthread(task)->data;
	 }
	 
	+void kthread_set_nfsd()
	+{
	+	set_bit(KTHREAD_IS_NFSD, &to_kthread(current)->flags);
	+}
	+EXPORT_SYMBOL_GPL(kthread_set_nfsd);
	+
	+void *kthread_nfsd_data()
	+{
	+	struct kthread *k;
	+
	+	if (!(current->flags & PF_KTHREAD))
	+		return NULL;
	+	k = to_kthread(current);
	+	if (test_bit(KTHREAD_IS_NFSD, &k->flags))
	+		return k->data;
	+	return NULL;
	+}
	+EXPORT_SYMBOL_GPL(kthread_nfsd_data);
	+
	 /**
	  * kthread_probe_data - speculative version of kthread_data()
	  * @task: possible kthread task in question

It feels weird to make such a special case for nfsd, but it makes this
all very easy for me; complete patch below.

--b.

commit 8b0a2e86dafa
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Fri Jul 28 16:35:15 2017 -0400

    nfsd: clients don't need to break their own delegations
    
    We currently revoke read delegations on any write open or any operation
    that modifies file data or metadata (including rename, link, and
    unlink).  But if the delegation in question is the only read delegation
    and is held by the client performing the operation, that's not really
    necessary.
    
    It's not always possible to prevent this in the NFSv4.0 case, because
    there's not always a way to determine which client an NFSv4.0 delegation
    came from.  (In theory we could try to guess this from the transport
    layer, e.g., by assuming all traffic on a given TCP connection comes
    from the same client.  But that's not really correct.)
    
    In the NFSv4.1 case the session layer always tells us the client.
    
    This patch should remove such self-conflicts in all cases where we can
    reliably determine the client from the compound.
    
    To do that we need to track "who" is performing a given (possibly
    lease-breaking) file operation.  We're doing that by storing the
    information in the svc_rqst and using kthread_data() to map the current
    task back to a svc_rqst.
    
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 5057e4d9dcd1..9fdcec416614 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -425,6 +425,7 @@ prototypes::
 	int (*lm_grant)(struct file_lock *, struct file_lock *, int);
 	void (*lm_break)(struct file_lock *); /* break_lease callback */
 	int (*lm_change)(struct file_lock **, int);
+	bool (*lm_breaker_owns_lease)(struct file_lock *);
 
 locking rules:
 
@@ -435,6 +436,7 @@ lm_notify:		yes		yes			no
 lm_grant:		no		no			no
 lm_break:		yes		no			no
 lm_change		yes		no			no
+lm_breaker_owns_lease:	no		no			no
 ==========		=============	=================	=========
 
 buffer_head
diff --git a/fs/locks.c b/fs/locks.c
index b8a31c1c4fff..a3f186846e93 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1557,6 +1557,9 @@ static bool leases_conflict(struct file_lock *lease, struct file_lock *breaker)
 {
 	bool rc;
 
+	if (lease->fl_lmops->lm_breaker_owns_lease
+			&& lease->fl_lmops->lm_breaker_owns_lease(lease))
+		return false;
 	if ((breaker->fl_flags & FL_LAYOUT) != (lease->fl_flags & FL_LAYOUT)) {
 		rc = false;
 		goto trace;
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 0e75f7fb5fec..a6d73aa51ce4 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2302,6 +2302,8 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 	}
 	check_if_stalefh_allowed(args);
 
+	rqstp->rq_lease_breaker = (void **)&cstate->clp;
+
 	trace_nfsd_compound(rqstp, args->opcnt);
 	while (!status && resp->opcnt < args->opcnt) {
 		op = &args->ops[resp->opcnt++];
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e32ecedece0f..2368051bbef3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4520,6 +4520,19 @@ nfsd_break_deleg_cb(struct file_lock *fl)
 	return ret;
 }
 
+static bool nfsd_breaker_owns_lease(struct file_lock *fl)
+{
+	struct nfs4_delegation *dl = fl->fl_owner;
+	struct svc_rqst *rqst;
+	struct nfs4_client *clp;
+
+	rqst = kthread_nfsd_data();
+	if (!rqst)
+		return false;
+	clp = *(rqst->rq_lease_breaker);
+	return dl->dl_stid.sc_client == clp;
+}
+
 static int
 nfsd_change_deleg_cb(struct file_lock *onlist, int arg,
 		     struct list_head *dispose)
@@ -4531,6 +4544,7 @@ nfsd_change_deleg_cb(struct file_lock *onlist, int arg,
 }
 
 static const struct lock_manager_operations nfsd_lease_mng_ops = {
+	.lm_breaker_owns_lease = nfsd_breaker_owns_lease,
 	.lm_break = nfsd_break_deleg_cb,
 	.lm_change = nfsd_change_deleg_cb,
 };
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index ca9fd348548b..9c15b77a726f 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -888,6 +888,8 @@ nfsd(void *vrqstp)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	int err;
 
+	kthread_set_nfsd();
+
 	/* Lock module and set up kernel thread */
 	mutex_lock(&nfsd_mutex);
 
@@ -1011,6 +1013,7 @@ nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 		*statp = rpc_garbage_args;
 		return 1;
 	}
+	rqstp->rq_lease_breaker = NULL;
 	/*
 	 * Give the xdr decoder a chance to change this if it wants
 	 * (necessary in the NFSv4.0 compound case)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4f6f59b4f22a..4b784560ffaf 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1045,6 +1045,7 @@ struct lock_manager_operations {
 	bool (*lm_break)(struct file_lock *);
 	int (*lm_change)(struct file_lock *, int, struct list_head *);
 	void (*lm_setup)(struct file_lock *, void **);
+	bool (*lm_breaker_owns_lease)(struct file_lock *);
 };
 
 struct lock_manager {
diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 8bbcaad7ef0f..d374cad65931 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -58,6 +58,8 @@ bool kthread_should_park(void);
 bool __kthread_should_park(struct task_struct *k);
 bool kthread_freezable_should_stop(bool *was_frozen);
 void *kthread_data(struct task_struct *k);
+void kthread_set_nfsd(void);
+void *kthread_nfsd_data(void);
 void *kthread_probe_data(struct task_struct *k);
 int kthread_park(struct task_struct *k);
 void kthread_unpark(struct task_struct *k);
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index fd390894a584..abf4a57ce4a7 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -299,6 +299,7 @@ struct svc_rqst {
 	struct net		*rq_bc_net;	/* pointer to backchannel's
 						 * net namespace
 						 */
+	void **			rq_lease_breaker; /* The v4 client breaking a lease */
 };
 
 #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 09b103b92c5a..54d83f329b85 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -58,6 +58,7 @@ enum KTHREAD_BITS {
 	KTHREAD_IS_PER_CPU = 0,
 	KTHREAD_SHOULD_STOP,
 	KTHREAD_SHOULD_PARK,
+	KTHREAD_IS_NFSD,
 };
 
 static inline void set_kthread_struct(void *kthread)
@@ -164,6 +165,25 @@ void *kthread_data(struct task_struct *task)
 	return to_kthread(task)->data;
 }
 
+void kthread_set_nfsd()
+{
+	set_bit(KTHREAD_IS_NFSD, &to_kthread(current)->flags);
+}
+EXPORT_SYMBOL_GPL(kthread_set_nfsd);
+
+void *kthread_nfsd_data()
+{
+	struct kthread *k;
+
+	if (!(current->flags & PF_KTHREAD))
+		return NULL;
+	k = to_kthread(current);
+	if (test_bit(KTHREAD_IS_NFSD, &k->flags))
+		return k->data;
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(kthread_nfsd_data);
+
 /**
  * kthread_probe_data - speculative version of kthread_data()
  * @task: possible kthread task in question
