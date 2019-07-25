Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF4C759DB
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jul 2019 23:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfGYVou (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Jul 2019 17:44:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfGYVou (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 25 Jul 2019 17:44:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 33C68300CA4D;
        Thu, 25 Jul 2019 21:44:49 +0000 (UTC)
Received: from dwysocha.rdu.csb (dhcp-12-212-173.gsslab.rdu.redhat.com [10.12.212.173])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC6DB600C7;
        Thu, 25 Jul 2019 21:44:48 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     bfields@fieldses.org
Cc:     neilb@suse.com, linux-nfs@vger.kernel.org
Subject: [RFC PATCH] SUNRPC: Harden the cache 'channel' interface to only allow legitimate daemons
Date:   Thu, 25 Jul 2019 17:44:48 -0400
Message-Id: <1564091088-32034-1-git-send-email-dwysocha@redhat.com>
In-Reply-To: <20190725185421.GA15073@fieldses.org>
References: <20190725185421.GA15073@fieldses.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 25 Jul 2019 21:44:49 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The 'channel' interface has a heuristic that is based on the number of
times any process opens it for reading.  This has shown to be problematic
and any rogue userspace process that just happens to open the 'channel'
file for reading may throw off the kernel logic and even steal a message
from the kernel.

Harden this interface by making a small daemon state machine that is based
on what the current userspace daemons actually do.  Specifically they open
the file either RW or W-only, then issue a poll().  Once these two operations
have been done by the same pid, we mark it as 'registered' as the daemon for
this cache.  We then disallow any other pid to read or write to the 'channel'
file by EIO any attempt.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfsd/nfs4idmap.c          |  4 ++--
 include/linux/sunrpc/cache.h | 34 +++++++++++++++++++++++++----
 net/sunrpc/cache.c           | 52 +++++++++++++++++++++++++++++---------------
 3 files changed, 66 insertions(+), 24 deletions(-)

diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
index d1f2852..a1f1f02 100644
--- a/fs/nfsd/nfs4idmap.c
+++ b/fs/nfsd/nfs4idmap.c
@@ -187,7 +187,7 @@ static struct ent *idtoname_update(struct cache_detail *, struct ent *,
 	.cache_request	= idtoname_request,
 	.cache_parse	= idtoname_parse,
 	.cache_show	= idtoname_show,
-	.warn_no_listener = warn_no_idmapd,
+	.warn_no_daemon = warn_no_idmapd,
 	.match		= idtoname_match,
 	.init		= ent_init,
 	.update		= ent_init,
@@ -350,7 +350,7 @@ static struct ent *nametoid_update(struct cache_detail *, struct ent *,
 	.cache_request	= nametoid_request,
 	.cache_parse	= nametoid_parse,
 	.cache_show	= nametoid_show,
-	.warn_no_listener = warn_no_idmapd,
+	.warn_no_daemon = warn_no_idmapd,
 	.match		= nametoid_match,
 	.init		= ent_init,
 	.update		= ent_init,
diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
index c7f38e8..7fa9300 100644
--- a/include/linux/sunrpc/cache.h
+++ b/include/linux/sunrpc/cache.h
@@ -61,6 +61,31 @@ struct cache_head {
 
 #define	CACHE_NEW_EXPIRY 120	/* keep new things pending confirmation for 120 seconds */
 
+/*
+ * State machine for the userspace daemon servicing a cache.
+ * Only one pid may be registered to the 'channel' file at any given time.
+ * A pid must transition to the final "POLL" state to finish registration.
+ * Any read or write to a 'channel' file by any pid other than the registered
+ * daemon pid will result in an EIO.
+ *
+ * Close
+ * Open -------------------------> Open (daemon_pid = current)
+ *         open(channel)
+ *
+ * Open -------------------------> Poll
+ *          poll(channel) &&
+ *          daemon_pid == current
+ *
+ * Poll -------------------------> Close (daemon_pid = -1)
+ *          close(channel) &&
+ *          daemon_pid == current
+ */
+enum cache_daemon_state {
+	CACHE_DAEMON_STATE_CLOSE = 1, /* Close: daemon unknown */
+	CACHE_DAEMON_STATE_OPEN = 2,  /* Open: daemon open() 'channel' */
+	CACHE_DAEMON_STATE_POLL = 3   /* Poll: daemon poll() 'channel' */
+};
+
 struct cache_detail {
 	struct module *		owner;
 	int			hash_size;
@@ -83,7 +108,7 @@ struct cache_detail {
 	int			(*cache_show)(struct seq_file *m,
 					      struct cache_detail *cd,
 					      struct cache_head *h);
-	void			(*warn_no_listener)(struct cache_detail *cd,
+	void			(*warn_no_daemon)(struct cache_detail *cd,
 					      int has_died);
 
 	struct cache_head *	(*alloc)(void);
@@ -107,15 +132,16 @@ struct cache_detail {
 	/* fields for communication over channel */
 	struct list_head	queue;
 
-	atomic_t		readers;		/* how many time is /chennel open */
-	time_t			last_close;		/* if no readers, when did last close */
-	time_t			last_warn;		/* when we last warned about no readers */
+	time_t			last_close;		/* when did last close */
+	time_t			last_warn;		/* when we last warned about no daemon */
 
 	union {
 		struct proc_dir_entry	*procfs;
 		struct dentry		*pipefs;
 	};
 	struct net		*net;
+	int			daemon_pid;
+	enum cache_daemon_state daemon_state;
 };
 
 
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 6f1528f..5ea24c8 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -38,7 +38,7 @@
 
 static bool cache_defer_req(struct cache_req *req, struct cache_head *item);
 static void cache_revisit_request(struct cache_head *item);
-static bool cache_listeners_exist(struct cache_detail *detail);
+static bool cache_daemon_exists(struct cache_detail *detail);
 
 static void cache_init(struct cache_head *h, struct cache_detail *detail)
 {
@@ -305,7 +305,7 @@ int cache_check(struct cache_detail *detail,
 				cache_fresh_unlocked(h, detail);
 				break;
 			}
-		} else if (!cache_listeners_exist(detail))
+		} else if (!cache_daemon_exists(detail))
 			rv = try_to_negate_entry(detail, h);
 	}
 
@@ -373,9 +373,10 @@ void sunrpc_init_cache_detail(struct cache_detail *cd)
 	spin_lock(&cache_list_lock);
 	cd->nextcheck = 0;
 	cd->entries = 0;
-	atomic_set(&cd->readers, 0);
 	cd->last_close = 0;
 	cd->last_warn = -1;
+	cd->daemon_pid = -1;
+	cd->daemon_state = CACHE_DAEMON_STATE_CLOSE;
 	list_add(&cd->others, &cache_list);
 	spin_unlock(&cache_list_lock);
 
@@ -810,6 +811,10 @@ static ssize_t cache_read(struct file *filp, char __user *buf, size_t count,
 	if (count == 0)
 		return 0;
 
+	if (cd->daemon_pid != task_pid_nr(current) ||
+	    cd->daemon_state != CACHE_DAEMON_STATE_POLL)
+		return -EIO;
+
 	inode_lock(inode); /* protect against multiple concurrent
 			      * readers on this file */
  again:
@@ -948,6 +953,10 @@ static ssize_t cache_write(struct file *filp, const char __user *buf,
 	if (!cd->cache_parse)
 		goto out;
 
+	if (cd->daemon_pid != task_pid_nr(current) ||
+	    cd->daemon_state != CACHE_DAEMON_STATE_POLL)
+		return -EIO;
+
 	inode_lock(inode);
 	ret = cache_downcall(mapping, buf, count, cd);
 	inode_unlock(inode);
@@ -964,6 +973,9 @@ static __poll_t cache_poll(struct file *filp, poll_table *wait,
 	struct cache_reader *rp = filp->private_data;
 	struct cache_queue *cq;
 
+	if (cd->daemon_pid == task_pid_nr(current))
+		cd->daemon_state = CACHE_DAEMON_STATE_POLL;
+
 	poll_wait(filp, &queue_wait, wait);
 
 	/* alway allow write */
@@ -1029,11 +1041,14 @@ static int cache_open(struct inode *inode, struct file *filp,
 		}
 		rp->offset = 0;
 		rp->q.reader = 1;
-		atomic_inc(&cd->readers);
 		spin_lock(&queue_lock);
 		list_add(&rp->q.list, &cd->queue);
 		spin_unlock(&queue_lock);
 	}
+	if (filp->f_mode & FMODE_WRITE) {
+		cd->daemon_pid = task_pid_nr(current);
+		cd->daemon_state = CACHE_DAEMON_STATE_OPEN;
+	}
 	filp->private_data = rp;
 	return 0;
 }
@@ -1063,7 +1078,10 @@ static int cache_release(struct inode *inode, struct file *filp,
 		kfree(rp);
 
 		cd->last_close = seconds_since_boot();
-		atomic_dec(&cd->readers);
+	}
+	if (cd->daemon_pid == task_pid_nr(current)) {
+		cd->daemon_pid = -1;
+		cd->daemon_state = CACHE_DAEMON_STATE_CLOSE;
 	}
 	module_put(cd->owner);
 	return 0;
@@ -1160,30 +1178,28 @@ void qword_addhex(char **bpp, int *lp, char *buf, int blen)
 }
 EXPORT_SYMBOL_GPL(qword_addhex);
 
-static void warn_no_listener(struct cache_detail *detail)
+static void warn_no_daemon(struct cache_detail *detail)
 {
 	if (detail->last_warn != detail->last_close) {
 		detail->last_warn = detail->last_close;
-		if (detail->warn_no_listener)
-			detail->warn_no_listener(detail, detail->last_close != 0);
+		if (detail->warn_no_daemon)
+			detail->warn_no_daemon(detail, detail->last_close != 0);
 	}
 }
 
-static bool cache_listeners_exist(struct cache_detail *detail)
+static bool cache_daemon_exists(struct cache_detail *detail)
 {
-	if (atomic_read(&detail->readers))
+	if (detail->daemon_pid != -1 &&
+	    detail->daemon_state == CACHE_DAEMON_STATE_POLL)
 		return true;
-	if (detail->last_close == 0)
-		/* This cache was never opened */
-		return false;
-	if (detail->last_close < seconds_since_boot() - 30)
+	if (detail->last_close > seconds_since_boot() - 30)
 		/*
 		 * We allow for the possibility that someone might
 		 * restart a userspace daemon without restarting the
 		 * server; but after 30 seconds, we give up.
 		 */
-		 return false;
-	return true;
+		 return true;
+	return false;
 }
 
 /*
@@ -1202,8 +1218,8 @@ int sunrpc_cache_pipe_upcall(struct cache_detail *detail, struct cache_head *h)
 	if (!detail->cache_request)
 		return -EINVAL;
 
-	if (!cache_listeners_exist(detail)) {
-		warn_no_listener(detail);
+	if (!cache_daemon_exists(detail)) {
+		warn_no_daemon(detail);
 		return -EINVAL;
 	}
 	if (test_bit(CACHE_CLEANED, &h->flags))
-- 
1.8.3.1

