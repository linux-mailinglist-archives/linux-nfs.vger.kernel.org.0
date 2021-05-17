Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB58386D1A
	for <lists+linux-nfs@lfdr.de>; Tue, 18 May 2021 00:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343943AbhEQWpB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 May 2021 18:45:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:59712 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344018AbhEQWpA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 May 2021 18:45:00 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14HMekVk016887;
        Mon, 17 May 2021 22:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=BF/56vjhbPYEEGTfh7Q45HR1V6prJ2j968et9yMnLHo=;
 b=kX39epu+AtKEWysILdgjq7/pvjB/VvbN9QjAJCvkK1YgjDyVAgRsaKHBMdGFRLKv0yev
 X9Qot5bG5NZ2tc/2MTlQZFjuEa0g4AaXfqNK9BGKQpOnxqgVV02T7jcYwEzZ8iBX8Q1s
 BGmiZ/jXb6HgJOxI08bp5AhS4yLpo6psMZFxOpMtniEA4r03aZjA+YIJxGCcwYdPOcid
 meTWTQwILIVb43GYer73cGa7ghKJpam+/j6fHtD76I5Nsg6oek+r4T5WHrCc/wJhFe88
 PgWOu9pTWg5gjdskyEen+yyMU0NnCbZIzej7Ls2Ft7VEVyytusF8oFq2ZISZ+3Azj3RZ vw== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38kh0h8cm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 22:43:39 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14HMeMlx144227;
        Mon, 17 May 2021 22:43:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38kb37baw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 22:43:38 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14HMhbqA153088;
        Mon, 17 May 2021 22:43:38 GMT
Received: from aserp3030.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3020.oracle.com with ESMTP id 38kb37bavx-2;
        Mon, 17 May 2021 22:43:38 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     olga.kornievskaia@gmail.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, trondmy@hammerspace.com,
        chuck.lever@oracle.com
Subject: [PATCH v5 1/2] NFSD: delay unmount source's export after inter-server copy completed.
Date:   Mon, 17 May 2021 18:43:29 -0400
Message-Id: <20210517224330.9201-2-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
In-Reply-To: <20210517224330.9201-1-dai.ngo@oracle.com>
References: <20210517224330.9201-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cKg5XWQJ_5h4YZ15IbedClGDQJksc7PY
X-Proofpoint-ORIG-GUID: cKg5XWQJ_5h4YZ15IbedClGDQJksc7PY
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently the source's export is mounted and unmounted on every
inter-server copy operation. This patch is an enhancement to delay
the unmount of the source export for a certain period of time to
eliminate the mount and unmount overhead on subsequent copy operations.

After a copy operation completes, a delayed task is scheduled to
unmount the export after a configurable idle time. Each time the
export is being used again, its expire time is extended to allow
the export to remain mounted.

The unmount task and the mount operation of the copy request are
synced to make sure the export is not unmounted while it's being
used.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/netns.h         |   5 ++
 fs/nfsd/nfs4proc.c      | 216 +++++++++++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/nfs4state.c     |   8 ++
 fs/nfsd/nfsd.h          |   6 ++
 fs/nfsd/nfssvc.c        |   3 +
 include/linux/nfs_ssc.h |  16 ++++
 6 files changed, 250 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index c330f5bd0cf3..6018e5050cb4 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -21,6 +21,7 @@
 
 struct cld_net;
 struct nfsd4_client_tracking_ops;
+struct nfsd4_ssc_umount;
 
 enum {
 	/* cache misses due only to checksum comparison failures */
@@ -176,6 +177,10 @@ struct nfsd_net {
 	unsigned int             longest_chain_cachesize;
 
 	struct shrinker		nfsd_reply_cache_shrinker;
+
+	spinlock_t              nfsd_ssc_lock;
+	struct nfsd4_ssc_umount	*nfsd_ssc_umount;
+
 	/* utsname taken from the process that starts the server */
 	char			nfsd_name[UNX_MAXNODENAME+1];
 };
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index dd9f38d072dd..892ad72d87ae 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -55,6 +55,99 @@ module_param(inter_copy_offload_enable, bool, 0644);
 MODULE_PARM_DESC(inter_copy_offload_enable,
 		 "Enable inter server to server copy offload. Default: false");
 
+#ifdef CONFIG_NFSD_V4_2_INTER_SSC
+static int nfsd4_ssc_umount_timeout = 900000;		/* default to 15 mins */
+module_param(nfsd4_ssc_umount_timeout, int, 0644);
+MODULE_PARM_DESC(nfsd4_ssc_umount_timeout,
+		"idle msecs before unmount export from source server");
+
+void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
+{
+	bool do_wakeup = false;
+	struct nfsd4_ssc_umount_item *ni = 0;
+	struct nfsd4_ssc_umount_item *tmp;
+	struct nfsd4_ssc_umount *nu;
+
+	spin_lock(&nn->nfsd_ssc_lock);
+	if (!nn->nfsd_ssc_umount) {
+		spin_unlock(&nn->nfsd_ssc_lock);
+		return;
+	}
+	nu = nn->nfsd_ssc_umount;
+	list_for_each_entry_safe(ni, tmp, &nu->nsu_list, nsui_list) {
+		if (time_after(jiffies, ni->nsui_expire)) {
+			if (refcount_read(&ni->nsui_refcnt) > 0)
+				continue;
+
+			/* mark being unmount */
+			ni->nsui_busy = true;
+			spin_unlock(&nn->nfsd_ssc_lock);
+			mntput(ni->nsui_vfsmount);
+			spin_lock(&nn->nfsd_ssc_lock);
+
+			/* waiters need to start from begin of list */
+			list_del(&ni->nsui_list);
+			kfree(ni);
+
+			/* wakeup ssc_connect waiters */
+			do_wakeup = true;
+			continue;
+		}
+		break;
+	}
+	if (!list_empty(&nu->nsu_list)) {
+		ni = list_first_entry(&nu->nsu_list,
+			struct nfsd4_ssc_umount_item, nsui_list);
+		nu->nsu_expire = ni->nsui_expire;
+	} else
+		nu->nsu_expire = 0;
+
+	if (do_wakeup)
+		wake_up_all(&nu->nsu_waitq);
+	spin_unlock(&nn->nfsd_ssc_lock);
+}
+
+/*
+ * This is called when nfsd is being shutdown, after all inter_ssc
+ * cleanup were done, to destroy the ssc delayed unmount list.
+ */
+void nfsd4_ssc_shutdown_umount(struct nfsd_net *nn)
+{
+	struct nfsd4_ssc_umount_item *ni = 0;
+	struct nfsd4_ssc_umount_item *tmp;
+	struct nfsd4_ssc_umount *nu;
+
+	spin_lock(&nn->nfsd_ssc_lock);
+	if (!nn->nfsd_ssc_umount) {
+		spin_unlock(&nn->nfsd_ssc_lock);
+		return;
+	}
+	nu = nn->nfsd_ssc_umount;
+	nn->nfsd_ssc_umount = 0;
+	list_for_each_entry_safe(ni, tmp, &nu->nsu_list, nsui_list) {
+		list_del(&ni->nsui_list);
+		spin_unlock(&nn->nfsd_ssc_lock);
+		mntput(ni->nsui_vfsmount);
+		kfree(ni);
+		spin_lock(&nn->nfsd_ssc_lock);
+	}
+	spin_unlock(&nn->nfsd_ssc_lock);
+	kfree(nu);
+}
+
+void nfsd4_ssc_init_umount_work(struct nfsd_net *nn)
+{
+	nn->nfsd_ssc_umount = kzalloc(sizeof(struct nfsd4_ssc_umount),
+					GFP_KERNEL);
+	if (!nn->nfsd_ssc_umount)
+		return;
+	spin_lock_init(&nn->nfsd_ssc_lock);
+	INIT_LIST_HEAD(&nn->nfsd_ssc_umount->nsu_list);
+	init_waitqueue_head(&nn->nfsd_ssc_umount->nsu_waitq);
+}
+EXPORT_SYMBOL_GPL(nfsd4_ssc_init_umount_work);
+#endif
+
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 #include <linux/security.h>
 
@@ -1181,6 +1274,12 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
 	char *ipaddr, *dev_name, *raw_data;
 	int len, raw_len;
 	__be32 status = nfserr_inval;
+	struct nfsd4_ssc_umount_item *ni = 0;
+	struct nfsd4_ssc_umount_item *work = NULL;
+	struct nfsd4_ssc_umount_item *tmp;
+	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+	struct nfsd4_ssc_umount *nu;
+	DEFINE_WAIT(wait);
 
 	naddr = &nss->u.nl4_addr;
 	tmp_addrlen = rpc_uaddr2sockaddr(SVC_NET(rqstp), naddr->addr,
@@ -1229,12 +1328,76 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
 		goto out_free_rawdata;
 	snprintf(dev_name, len + 5, "%s%s%s:/", startsep, ipaddr, endsep);
 
+	work = kzalloc(sizeof(*work), GFP_KERNEL);
+try_again:
+	spin_lock(&nn->nfsd_ssc_lock);
+	if (!nn->nfsd_ssc_umount) {
+		spin_unlock(&nn->nfsd_ssc_lock);
+		kfree(work);
+		work = NULL;
+		goto skip_dul;
+	}
+	nu = nn->nfsd_ssc_umount;
+	list_for_each_entry_safe(ni, tmp, &nu->nsu_list, nsui_list) {
+		if (strncmp(ni->nsui_ipaddr, ipaddr, sizeof(ni->nsui_ipaddr)))
+			continue;
+		/* found a match */
+		if (ni->nsui_busy) {
+			/*  wait - and try again */
+			prepare_to_wait(&nu->nsu_waitq, &wait,
+				TASK_INTERRUPTIBLE);
+			spin_unlock(&nn->nfsd_ssc_lock);
+
+			/* allow 20secs for mount/unmount for now - revisit */
+			if (signal_pending(current) ||
+					(schedule_timeout(20*HZ) == 0)) {
+				status = nfserr_eagain;
+				kfree(work);
+				goto out_free_devname;
+			}
+			finish_wait(&nu->nsu_waitq, &wait);
+			goto try_again;
+		}
+		ss_mnt = ni->nsui_vfsmount;
+		if (refcount_read(&ni->nsui_refcnt) == 0)
+			refcount_set(&ni->nsui_refcnt, 1);
+		else
+			refcount_inc(&ni->nsui_refcnt);
+		spin_unlock(&nn->nfsd_ssc_lock);
+		kfree(work);
+		goto out_done;
+	}
+	/* create new entry, set busy, insert list, clear busy after mount */
+	if (work) {
+		strncpy(work->nsui_ipaddr, ipaddr, sizeof(work->nsui_ipaddr));
+		refcount_set(&work->nsui_refcnt, 1);
+		work->nsui_busy = true;
+		list_add_tail(&work->nsui_list, &nu->nsu_list);
+	}
+	spin_unlock(&nn->nfsd_ssc_lock);
+skip_dul:
+
 	/* Use an 'internal' mount: SB_KERNMOUNT -> MNT_INTERNAL */
 	ss_mnt = vfs_kern_mount(type, SB_KERNMOUNT, dev_name, raw_data);
 	module_put(type->owner);
-	if (IS_ERR(ss_mnt))
+	if (IS_ERR(ss_mnt)) {
+		if (work) {
+			spin_lock(&nn->nfsd_ssc_lock);
+			list_del(&work->nsui_list);
+			wake_up_all(&nu->nsu_waitq);
+			spin_unlock(&nn->nfsd_ssc_lock);
+			kfree(work);
+		}
 		goto out_free_devname;
-
+	}
+	if (work) {
+		spin_lock(&nn->nfsd_ssc_lock);
+		work->nsui_vfsmount = ss_mnt;
+		work->nsui_busy = false;
+		wake_up_all(&nu->nsu_waitq);
+		spin_unlock(&nn->nfsd_ssc_lock);
+	}
+out_done:
 	status = 0;
 	*mount = ss_mnt;
 
@@ -1301,10 +1464,55 @@ static void
 nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct nfsd_file *src,
 			struct nfsd_file *dst)
 {
+	bool found = false;
+	bool resched = false;
+	long timeout;
+	struct nfsd4_ssc_umount_item *tmp;
+	struct nfsd4_ssc_umount_item *ni = 0;
+	struct nfsd4_ssc_umount *nu;
+	struct nfsd_net *nn = net_generic(dst->nf_net, nfsd_net_id);
+
 	nfs42_ssc_close(src->nf_file);
-	fput(src->nf_file);
 	nfsd_file_put(dst);
-	mntput(ss_mnt);
+	fput(src->nf_file);
+
+	if (!nn) {
+		mntput(ss_mnt);
+		return;
+	}
+	spin_lock(&nn->nfsd_ssc_lock);
+	if (!nn->nfsd_ssc_umount) {
+		/* delayed unmount list not setup */
+		spin_unlock(&nn->nfsd_ssc_lock);
+		mntput(ss_mnt);
+		return;
+	}
+	nu = nn->nfsd_ssc_umount;
+	timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
+	list_for_each_entry_safe(ni, tmp, &nu->nsu_list, nsui_list) {
+		if (ni->nsui_vfsmount->mnt_sb == ss_mnt->mnt_sb) {
+			list_del(&ni->nsui_list);
+			/*
+			 * vfsmount can be shared by multiple exports,
+			 * decrement refcnt and schedule delayed task
+			 * if it drops to 0.
+			 */
+			if (refcount_dec_and_test(&ni->nsui_refcnt))
+				resched = true;
+			ni->nsui_expire = jiffies + timeout;
+			list_add_tail(&ni->nsui_list, &nu->nsu_list);
+			found = true;
+			break;
+		}
+	}
+	if (!found) {
+		spin_unlock(&nn->nfsd_ssc_lock);
+		mntput(ss_mnt);
+		return;
+	}
+	if (resched && !nu->nsu_expire)
+		nu->nsu_expire = ni->nsui_expire;
+	spin_unlock(&nn->nfsd_ssc_lock);
 }
 
 #else /* CONFIG_NFSD_V4_2_INTER_SSC */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 97447a64bad0..0cdc898f06c9 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5459,6 +5459,11 @@ nfs4_laundromat(struct nfsd_net *nn)
 		list_del_init(&nbl->nbl_lru);
 		free_blocked_lock(nbl);
 	}
+
+#ifdef CONFIG_NFSD_V4_2_INTER_SSC
+	/* service the inter-copy delayed unmount list */
+	nfsd4_ssc_expire_umount(nn);
+#endif
 out:
 	new_timeo = max_t(time64_t, new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
 	return new_timeo;
@@ -7398,6 +7403,9 @@ nfs4_state_shutdown_net(struct net *net)
 
 	nfsd4_client_tracking_exit(net);
 	nfs4_state_destroy_net(net);
+#ifdef CONFIG_NFSD_V4_2_INTER_SSC
+	nfsd4_ssc_shutdown_umount(nn);
+#endif
 	mntput(nn->nfsd_mnt);
 }
 
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 8bdc37aa2c2e..cf86d9010974 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -483,6 +483,12 @@ static inline bool nfsd_attrs_supported(u32 minorversion, const u32 *bmval)
 extern int nfsd4_is_junction(struct dentry *dentry);
 extern int register_cld_notifier(void);
 extern void unregister_cld_notifier(void);
+#ifdef CONFIG_NFSD_V4_2_INTER_SSC
+extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
+extern void nfsd4_ssc_expire_umount(struct nfsd_net *nn);
+extern void nfsd4_ssc_shutdown_umount(struct nfsd_net *nn);
+#endif
+
 #else /* CONFIG_NFSD_V4 */
 static inline int nfsd4_is_junction(struct dentry *dentry)
 {
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 6de406322106..ce89a8fe07ff 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -403,6 +403,9 @@ static int nfsd_startup_net(int nrservs, struct net *net, const struct cred *cre
 	if (ret)
 		goto out_filecache;
 
+#ifdef CONFIG_NFSD_V4_2_INTER_SSC
+	nfsd4_ssc_init_umount_work(nn);
+#endif
 	nn->nfsd_net_up = true;
 	return 0;
 
diff --git a/include/linux/nfs_ssc.h b/include/linux/nfs_ssc.h
index f5ba0fbff72f..18afe62988b5 100644
--- a/include/linux/nfs_ssc.h
+++ b/include/linux/nfs_ssc.h
@@ -8,6 +8,7 @@
  */
 
 #include <linux/nfs_fs.h>
+#include <linux/sunrpc/svc.h>
 
 extern struct nfs_ssc_client_ops_tbl nfs_ssc_client_tbl;
 
@@ -52,6 +53,21 @@ static inline void nfs42_ssc_close(struct file *filep)
 	if (nfs_ssc_client_tbl.ssc_nfs4_ops)
 		(*nfs_ssc_client_tbl.ssc_nfs4_ops->sco_close)(filep);
 }
+
+struct nfsd4_ssc_umount_item {
+	struct list_head nsui_list;
+	bool nsui_busy;
+	refcount_t nsui_refcnt;
+	unsigned long nsui_expire;
+	struct vfsmount *nsui_vfsmount;
+	char nsui_ipaddr[RPC_MAX_ADDRBUFLEN];
+};
+
+struct nfsd4_ssc_umount {
+	struct list_head nsu_list;
+	unsigned long nsu_expire;
+	wait_queue_head_t nsu_waitq;
+};
 #endif
 
 /*
-- 
2.9.5

