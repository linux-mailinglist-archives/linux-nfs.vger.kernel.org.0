Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2179927FAC
	for <lists+linux-nfs@lfdr.de>; Thu, 23 May 2019 16:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbfEWO3H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 May 2019 10:29:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730760AbfEWO3G (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 23 May 2019 10:29:06 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 58187C09AD19;
        Thu, 23 May 2019 14:29:05 +0000 (UTC)
Received: from bcodding.csb (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11D1C1001E81;
        Thu, 23 May 2019 14:29:05 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id C3F45109C3CF; Thu, 23 May 2019 10:28:41 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     "J . Bruce Fields" <bfields@redhat.com>, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/5] lockd: Convert NLM service fl_owner to nlm_lockowner
Date:   Thu, 23 May 2019 10:28:38 -0400
Message-Id: <3ee16d0336923155346aeee5b71ad4d28365fea1.1558620385.git.bcodding@redhat.com>
In-Reply-To: <cover.1558620385.git.bcodding@redhat.com>
References: <cover.1558620385.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 23 May 2019 14:29:05 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Do as the NLM client: allocate and track a struct nlm_lockowner for use as
the fl_owner for locks created by the NLM sever.  This allows us to keep
the svid within this structure for matching locks, and will allow us to
track the pid of lockd in a future patch.  It should also allow easier
reference of the nlm_host in conflicting locks, and simplify lock hashing
and comparison.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/lockd/svc4proc.c         | 13 ++++-
 fs/lockd/svclock.c          | 96 +++++++++++++++++++++++++++++++++++++
 fs/lockd/svcproc.c          | 13 ++++-
 fs/lockd/svcsubs.c          |  2 +-
 fs/lockd/xdr.c              |  1 -
 fs/lockd/xdr4.c             |  1 -
 include/linux/lockd/lockd.h |  2 +
 7 files changed, 123 insertions(+), 5 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 1bddf70d9656..90d328d61933 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -46,8 +46,13 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 
 		/* Set up the missing parts of the file_lock structure */
 		lock->fl.fl_file  = file->f_file;
-		lock->fl.fl_owner = (fl_owner_t) host;
 		lock->fl.fl_lmops = &nlmsvc_lock_operations;
+		nlmsvc_locks_init_private(&lock->fl, host, (pid_t)lock->svid);
+		if (!lock->fl.fl_owner) {
+			/* lockowner allocation has failed */
+			nlmsvc_release_host(host);
+			return -ENOMEM;
+		}
 	}
 
 	return 0;
@@ -94,6 +99,7 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 	else
 		dprintk("lockd: TEST4        status %d\n", ntohl(resp->status));
 
+	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
 	return rc;
@@ -142,6 +148,7 @@ __nlm4svc_proc_lock(struct svc_rqst *rqstp, struct nlm_res *resp)
 	else
 		dprintk("lockd: LOCK         status %d\n", ntohl(resp->status));
 
+	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
 	return rc;
@@ -178,6 +185,7 @@ __nlm4svc_proc_cancel(struct svc_rqst *rqstp, struct nlm_res *resp)
 	resp->status = nlmsvc_cancel_blocked(SVC_NET(rqstp), file, &argp->lock);
 
 	dprintk("lockd: CANCEL        status %d\n", ntohl(resp->status));
+	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
 	return rpc_success;
@@ -217,6 +225,7 @@ __nlm4svc_proc_unlock(struct svc_rqst *rqstp, struct nlm_res *resp)
 	resp->status = nlmsvc_unlock(SVC_NET(rqstp), file, &argp->lock);
 
 	dprintk("lockd: UNLOCK        status %d\n", ntohl(resp->status));
+	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
 	return rpc_success;
@@ -365,6 +374,7 @@ nlm4svc_proc_share(struct svc_rqst *rqstp)
 	resp->status = nlmsvc_share_file(host, file, argp);
 
 	dprintk("lockd: SHARE         status %d\n", ntohl(resp->status));
+	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
 	return rpc_success;
@@ -399,6 +409,7 @@ nlm4svc_proc_unshare(struct svc_rqst *rqstp)
 	resp->status = nlmsvc_unshare_file(host, file, argp);
 
 	dprintk("lockd: UNSHARE       status %d\n", ntohl(resp->status));
+	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
 	return rpc_success;
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index ea719cdd6a36..193b36c741fe 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -332,6 +332,93 @@ void nlmsvc_traverse_blocks(struct nlm_host *host,
 	mutex_unlock(&file->f_mutex);
 }
 
+static struct nlm_lockowner *
+nlmsvc_get_lockowner(struct nlm_lockowner *lockowner)
+{
+	refcount_inc(&lockowner->count);
+	return lockowner;
+}
+
+static void nlmsvc_put_lockowner(struct nlm_lockowner *lockowner)
+{
+	if (!refcount_dec_and_lock(&lockowner->count, &lockowner->host->h_lock))
+		return;
+	list_del(&lockowner->list);
+	spin_unlock(&lockowner->host->h_lock);
+	nlmsvc_release_host(lockowner->host);
+	kfree(lockowner);
+}
+
+static struct nlm_lockowner *__nlmsvc_find_lockowner(struct nlm_host *host, pid_t pid)
+{
+	struct nlm_lockowner *lockowner;
+	list_for_each_entry(lockowner, &host->h_lockowners, list) {
+		if (lockowner->pid != pid)
+			continue;
+		return nlmsvc_get_lockowner(lockowner);
+	}
+	return NULL;
+}
+
+static struct nlm_lockowner *nlmsvc_find_lockowner(struct nlm_host *host, pid_t pid)
+{
+	struct nlm_lockowner *res, *new = NULL;
+
+	spin_lock(&host->h_lock);
+	res = __nlmsvc_find_lockowner(host, pid);
+
+	if (res == NULL) {
+		spin_unlock(&host->h_lock);
+		new = kmalloc(sizeof(*res), GFP_KERNEL);
+		spin_lock(&host->h_lock);
+		res = __nlmsvc_find_lockowner(host, pid);
+		if (res == NULL && new != NULL) {
+			res = new;
+			/* fs/locks.c will manage the refcount through lock_ops */
+			refcount_set(&new->count, 1);
+			new->pid = pid;
+			new->host = nlm_get_host(host);
+			list_add(&new->list, &host->h_lockowners);
+			new = NULL;
+		}
+	}
+
+	spin_unlock(&host->h_lock);
+	kfree(new);
+	return res;
+}
+
+void
+nlmsvc_release_lockowner(struct nlm_lock *lock)
+{
+	if (lock->fl.fl_owner)
+		nlmsvc_put_lockowner(lock->fl.fl_owner);
+}
+
+static void nlmsvc_locks_copy_lock(struct file_lock *new, struct file_lock *fl)
+{
+	struct nlm_lockowner *nlm_lo = (struct nlm_lockowner *)fl->fl_owner;
+	new->fl_owner = nlmsvc_get_lockowner(nlm_lo);
+}
+
+static void nlmsvc_locks_release_private(struct file_lock *fl)
+{
+	nlmsvc_put_lockowner((struct nlm_lockowner *)fl->fl_owner);
+}
+
+const struct file_lock_operations nlmsvc_lock_ops = {
+	.fl_copy_lock = nlmsvc_locks_copy_lock,
+	.fl_release_private = nlmsvc_locks_release_private,
+};
+
+void nlmsvc_locks_init_private(struct file_lock *fl, struct nlm_host *host,
+						pid_t pid)
+{
+	fl->fl_owner = nlmsvc_find_lockowner(host, pid);
+	if (fl->fl_owner != NULL)
+		fl->fl_ops = &nlmsvc_lock_ops;
+}
+
 /*
  * Initialize arguments for GRANTED call. The nlm_rqst structure
  * has been cleared already.
@@ -509,6 +596,7 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 {
 	int			error;
 	__be32			ret;
+	struct nlm_lockowner *test_owner;
 
 	dprintk("lockd: nlmsvc_testlock(%s/%ld, ty=%d, %Ld-%Ld)\n",
 				locks_inode(file->f_file)->i_sb->s_id,
@@ -522,6 +610,9 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 		goto out;
 	}
 
+	/* If there's a conflicting lock, remember to clean up the test lock */
+	test_owner = (struct nlm_lockowner *)lock->fl.fl_owner;
+
 	error = vfs_test_lock(file->f_file, &lock->fl);
 	if (error) {
 		/* We can't currently deal with deferred test requests */
@@ -548,6 +639,11 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 	conflock->fl.fl_start = lock->fl.fl_start;
 	conflock->fl.fl_end = lock->fl.fl_end;
 	locks_release_private(&lock->fl);
+
+	/* Clean up the test lock */
+	lock->fl.fl_owner = NULL;
+	nlmsvc_put_lockowner(test_owner);
+
 	ret = nlm_lck_denied;
 out:
 	return ret;
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index ea77c66d3cc3..665b7adad3c4 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -76,8 +76,13 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 
 		/* Set up the missing parts of the file_lock structure */
 		lock->fl.fl_file  = file->f_file;
-		lock->fl.fl_owner = (fl_owner_t) host;
 		lock->fl.fl_lmops = &nlmsvc_lock_operations;
+		nlmsvc_locks_init_private(&lock->fl, host, (pid_t)lock->svid);
+		if (!lock->fl.fl_owner) {
+			/* lockowner allocation has failed */
+			nlmsvc_release_host(host);
+			return -ENOMEM;
+		}
 	}
 
 	return 0;
@@ -125,6 +130,7 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 		dprintk("lockd: TEST          status %d vers %d\n",
 			ntohl(resp->status), rqstp->rq_vers);
 
+	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
 	return rc;
@@ -173,6 +179,7 @@ __nlmsvc_proc_lock(struct svc_rqst *rqstp, struct nlm_res *resp)
 	else
 		dprintk("lockd: LOCK         status %d\n", ntohl(resp->status));
 
+	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
 	return rc;
@@ -210,6 +217,7 @@ __nlmsvc_proc_cancel(struct svc_rqst *rqstp, struct nlm_res *resp)
 	resp->status = cast_status(nlmsvc_cancel_blocked(net, file, &argp->lock));
 
 	dprintk("lockd: CANCEL        status %d\n", ntohl(resp->status));
+	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
 	return rpc_success;
@@ -250,6 +258,7 @@ __nlmsvc_proc_unlock(struct svc_rqst *rqstp, struct nlm_res *resp)
 	resp->status = cast_status(nlmsvc_unlock(net, file, &argp->lock));
 
 	dprintk("lockd: UNLOCK        status %d\n", ntohl(resp->status));
+	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
 	return rpc_success;
@@ -408,6 +417,7 @@ nlmsvc_proc_share(struct svc_rqst *rqstp)
 	resp->status = cast_status(nlmsvc_share_file(host, file, argp));
 
 	dprintk("lockd: SHARE         status %d\n", ntohl(resp->status));
+	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
 	return rpc_success;
@@ -442,6 +452,7 @@ nlmsvc_proc_unshare(struct svc_rqst *rqstp)
 	resp->status = cast_status(nlmsvc_unshare_file(host, file, argp));
 
 	dprintk("lockd: UNSHARE       status %d\n", ntohl(resp->status));
+	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
 	return rpc_success;
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index 899360ba3b84..4ee04b725042 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -179,7 +179,7 @@ nlm_traverse_locks(struct nlm_host *host, struct nlm_file *file,
 		/* update current lock count */
 		file->f_locks++;
 
-		lockhost = (struct nlm_host *) fl->fl_owner;
+		lockhost = ((struct nlm_lockowner *)fl->fl_owner)->host;
 		if (match(lockhost, host)) {
 			struct file_lock lock = *fl;
 
diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
index 7147e4aebecc..ec717ae41ee3 100644
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -126,7 +126,6 @@ nlm_decode_lock(__be32 *p, struct nlm_lock *lock)
 	lock->svid  = ntohl(*p++);
 
 	locks_init_lock(fl);
-	fl->fl_owner = current->files;
 	fl->fl_pid   = (pid_t)lock->svid;
 	fl->fl_flags = FL_POSIX;
 	fl->fl_type  = F_RDLCK;		/* as good as anything else */
diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index 7ed9edf9aed4..45741adfe041 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -118,7 +118,6 @@ nlm4_decode_lock(__be32 *p, struct nlm_lock *lock)
 	lock->svid  = ntohl(*p++);
 
 	locks_init_lock(fl);
-	fl->fl_owner = current->files;
 	fl->fl_pid   = (pid_t)lock->svid;
 	fl->fl_flags = FL_POSIX;
 	fl->fl_type  = F_RDLCK;		/* as good as anything else */
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index c9b422dde542..d294dde9e546 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -282,6 +282,7 @@ void		  nlmsvc_traverse_blocks(struct nlm_host *, struct nlm_file *,
 					nlm_host_match_fn_t match);
 void		  nlmsvc_grant_reply(struct nlm_cookie *, __be32);
 void		  nlmsvc_release_call(struct nlm_rqst *);
+void		  nlmsvc_locks_init_private(struct file_lock *, struct nlm_host *, pid_t);
 
 /*
  * File handling for the server personality
@@ -289,6 +290,7 @@ void		  nlmsvc_release_call(struct nlm_rqst *);
 __be32		  nlm_lookup_file(struct svc_rqst *, struct nlm_file **,
 					struct nfs_fh *);
 void		  nlm_release_file(struct nlm_file *);
+void		  nlmsvc_release_lockowner(struct nlm_lock *);
 void		  nlmsvc_mark_resources(struct net *);
 void		  nlmsvc_free_host_resources(struct nlm_host *);
 void		  nlmsvc_invalidate_all(void);
-- 
2.20.1

