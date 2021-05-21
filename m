Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA8338CDFE
	for <lists+linux-nfs@lfdr.de>; Fri, 21 May 2021 21:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbhEUTLM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 May 2021 15:11:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:9050 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237786AbhEUTLL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 May 2021 15:11:11 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14LJ7Ijq008146;
        Fri, 21 May 2021 19:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=zVObekRZ3BEvkpP8uZ69TpqxgD0Z+5x8GDJxsMDKUCU=;
 b=H5FUUXW6fhnzKAfbONqrzcG3azkxLNBveeexFAkqB15JLQB+0LtN8VwaCcLYC26+INe4
 KGlU88qs3tjMN+VkzirLUS/uLXIG/hWO/HNM3Uoabq0SSJ4ikdLk/gbNhifyOKthM8Sc
 FO4QYGoXOsuRrHTX/ytCuX6ZW3FAeY1hgp3koRVTFWNkWNDlVUlmomyk/x5YxQgnOgnv
 xmg1Ih+P6alfWEZnR9x+1pkpvyiwsSiT9jcYMAKHKWusvAmKcFctXxTfTnaWfHFhwwo0
 gFjto1cXtvL2i7xNhUImBfvTPKNf/86gLs/A7SaJeUAQjKe7IH9+cNuOL7rtM77o1wpe dA== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38nuuwgf9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 19:09:43 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14LJ9gId162319;
        Fri, 21 May 2021 19:09:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38n4931ykt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 19:09:42 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14LJ9fF1162279;
        Fri, 21 May 2021 19:09:42 GMT
Received: from aserp3030.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3020.oracle.com with ESMTP id 38n4931yjw-2;
        Fri, 21 May 2021 19:09:42 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     olga.kornievskaia@gmail.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, trondmy@hammerspace.com,
        chuck.lever@oracle.com
Subject: [PATCH v7 1/2] NFSD: delay unmount source's export after inter-server copy completed.
Date:   Fri, 21 May 2021 15:09:37 -0400
Message-Id: <20210521190938.24820-2-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
In-Reply-To: <20210521190938.24820-1-dai.ngo@oracle.com>
References: <20210521190938.24820-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kwK6VehEyTNeg33UXCXlL65oldx0r5tv
X-Proofpoint-GUID: kwK6VehEyTNeg33UXCXlL65oldx0r5tv
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently the source's export is mounted and unmounted on every
inter-server copy operation. This patch is an enhancement to delay
the unmount of the source export for a certain period of time to
eliminate the mount and unmount overhead on subsequent copy operations.

After a copy operation completes, a work entry is added to the
delayed unmount list with an expiration time. This list is serviced
by the laundromat thread to unmount the export of the expired entries.
Each time the export is being used again, its expiration time is
extended and the entry is re-inserted to the tail of the list.

The unmount task and the mount operation of the copy request are
synced to make sure the export is not unmounted while it's being
used.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/netns.h         |   6 +++
 fs/nfsd/nfs4proc.c      | 135 ++++++++++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/nfs4state.c     |  71 +++++++++++++++++++++++++
 fs/nfsd/nfsd.h          |   4 ++
 fs/nfsd/nfssvc.c        |   3 ++
 include/linux/nfs_ssc.h |  14 +++++
 6 files changed, 229 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index a75abeb1e698..935c1028c217 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -176,6 +176,12 @@ struct nfsd_net {
 	unsigned int             longest_chain_cachesize;
 
 	struct shrinker		nfsd_reply_cache_shrinker;
+
+	/* tracking server-to-server copy mounts */
+	spinlock_t              nfsd_ssc_lock;
+	struct list_head        nfsd_ssc_mount_list;
+	wait_queue_head_t       nfsd_ssc_waitq;
+
 	/* utsname taken from the process that starts the server */
 	char			nfsd_name[UNX_MAXNODENAME+1];
 };
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index f4ce93d7f26e..bc373e5a6014 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -55,6 +55,13 @@ module_param(inter_copy_offload_enable, bool, 0644);
 MODULE_PARM_DESC(inter_copy_offload_enable,
 		 "Enable inter server to server copy offload. Default: false");
 
+#ifdef CONFIG_NFSD_V4_2_INTER_SSC
+static int nfsd4_ssc_umount_timeout = 900000;		/* default to 15 mins */
+module_param(nfsd4_ssc_umount_timeout, int, 0644);
+MODULE_PARM_DESC(nfsd4_ssc_umount_timeout,
+		"idle msecs before unmount export from source server");
+#endif
+
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 #include <linux/security.h>
 
@@ -1166,6 +1173,81 @@ extern void nfs_sb_deactive(struct super_block *sb);
 #define NFSD42_INTERSSC_MOUNTOPS "vers=4.2,addr=%s,sec=sys"
 
 /*
+ * setup a work entry in the ssc delayed unmount list.
+ */
+static int nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
+		struct nfsd4_ssc_umount_item **retwork, struct vfsmount **ss_mnt)
+{
+	struct nfsd4_ssc_umount_item *ni = 0;
+	struct nfsd4_ssc_umount_item *work = NULL;
+	struct nfsd4_ssc_umount_item *tmp;
+	DEFINE_WAIT(wait);
+
+	*ss_mnt = NULL;
+	*retwork = NULL;
+	work = kzalloc(sizeof(*work), GFP_KERNEL);
+try_again:
+	spin_lock(&nn->nfsd_ssc_lock);
+	list_for_each_entry_safe(ni, tmp, &nn->nfsd_ssc_mount_list, nsui_list) {
+		if (strncmp(ni->nsui_ipaddr, ipaddr, sizeof(ni->nsui_ipaddr)))
+			continue;
+		/* found a match */
+		if (ni->nsui_busy) {
+			/*  wait - and try again */
+			prepare_to_wait(&nn->nfsd_ssc_waitq, &wait,
+				TASK_INTERRUPTIBLE);
+			spin_unlock(&nn->nfsd_ssc_lock);
+
+			/* allow 20secs for mount/unmount for now - revisit */
+			if (signal_pending(current) ||
+					(schedule_timeout(20*HZ) == 0)) {
+				kfree(work);
+				return nfserr_eagain;
+			}
+			finish_wait(&nn->nfsd_ssc_waitq, &wait);
+			goto try_again;
+		}
+		*ss_mnt = ni->nsui_vfsmount;
+		refcount_inc(&ni->nsui_refcnt);
+		spin_unlock(&nn->nfsd_ssc_lock);
+		kfree(work);
+
+		/* return vfsmount in ss_mnt */
+		return 0;
+	}
+	if (work) {
+		strncpy(work->nsui_ipaddr, ipaddr, sizeof(work->nsui_ipaddr));
+		refcount_set(&work->nsui_refcnt, 2);
+		work->nsui_busy = true;
+		list_add_tail(&work->nsui_list, &nn->nfsd_ssc_mount_list);
+		*retwork = work;
+	}
+	spin_unlock(&nn->nfsd_ssc_lock);
+	return 0;
+}
+
+static void nfsd4_ssc_update_dul_work(struct nfsd_net *nn,
+		struct nfsd4_ssc_umount_item *work, struct vfsmount *ss_mnt)
+{
+	/* set nsui_vfsmount, clear busy flag and wakeup waiters */
+	spin_lock(&nn->nfsd_ssc_lock);
+	work->nsui_vfsmount = ss_mnt;
+	work->nsui_busy = false;
+	wake_up_all(&nn->nfsd_ssc_waitq);
+	spin_unlock(&nn->nfsd_ssc_lock);
+}
+
+static void nfsd4_ssc_cancel_dul_work(struct nfsd_net *nn,
+		struct nfsd4_ssc_umount_item *work)
+{
+	spin_lock(&nn->nfsd_ssc_lock);
+	list_del(&work->nsui_list);
+	wake_up_all(&nn->nfsd_ssc_waitq);
+	spin_unlock(&nn->nfsd_ssc_lock);
+	kfree(work);
+}
+
+/*
  * Support one copy source server for now.
  */
 static __be32
@@ -1181,6 +1263,8 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
 	char *ipaddr, *dev_name, *raw_data;
 	int len, raw_len;
 	__be32 status = nfserr_inval;
+	struct nfsd4_ssc_umount_item *work = NULL;
+	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
 	naddr = &nss->u.nl4_addr;
 	tmp_addrlen = rpc_uaddr2sockaddr(SVC_NET(rqstp), naddr->addr,
@@ -1229,12 +1313,23 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
 		goto out_free_rawdata;
 	snprintf(dev_name, len + 5, "%s%s%s:/", startsep, ipaddr, endsep);
 
+	status = nfsd4_ssc_setup_dul(nn, ipaddr, &work, &ss_mnt);
+	if (status)
+		goto out_free_devname;
+	if (ss_mnt)
+		goto out_done;
+
 	/* Use an 'internal' mount: SB_KERNMOUNT -> MNT_INTERNAL */
 	ss_mnt = vfs_kern_mount(type, SB_KERNMOUNT, dev_name, raw_data);
 	module_put(type->owner);
-	if (IS_ERR(ss_mnt))
+	if (IS_ERR(ss_mnt)) {
+		if (work)
+			nfsd4_ssc_cancel_dul_work(nn, work);
 		goto out_free_devname;
-
+	}
+	if (work)
+		nfsd4_ssc_update_dul_work(nn, work, ss_mnt);
+out_done:
 	status = 0;
 	*mount = ss_mnt;
 
@@ -1301,10 +1396,42 @@ static void
 nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct nfsd_file *src,
 			struct nfsd_file *dst)
 {
+	bool found = false;
+	long timeout;
+	struct nfsd4_ssc_umount_item *tmp;
+	struct nfsd4_ssc_umount_item *ni = 0;
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
+	timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
+	list_for_each_entry_safe(ni, tmp, &nn->nfsd_ssc_mount_list, nsui_list) {
+		if (ni->nsui_vfsmount->mnt_sb == ss_mnt->mnt_sb) {
+			list_del(&ni->nsui_list);
+			/*
+			 * vfsmount can be shared by multiple exports,
+			 * decrement refcnt. If the count drops to 1 it
+			 * will be unmounted when nsui_expire expires.
+			 */
+			refcount_dec(&ni->nsui_refcnt);
+			ni->nsui_expire = jiffies + timeout;
+			list_add_tail(&ni->nsui_list, &nn->nfsd_ssc_mount_list);
+			found = true;
+			break;
+		}
+	}
+	spin_unlock(&nn->nfsd_ssc_lock);
+	if (!found) {
+		mntput(ss_mnt);
+		return;
+	}
 }
 
 #else /* CONFIG_NFSD_V4_2_INTER_SSC */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b517a8794400..2484b59a3c29 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -44,6 +44,7 @@
 #include <linux/jhash.h>
 #include <linux/string_helpers.h>
 #include <linux/fsnotify.h>
+#include <linux/nfs_ssc.h>
 #include "xdr4.h"
 #include "xdr4cb.h"
 #include "vfs.h"
@@ -5457,6 +5458,69 @@ static bool state_expired(struct laundry_time *lt, time64_t last_refresh)
 	return false;
 }
 
+#ifdef CONFIG_NFSD_V4_2_INTER_SSC
+void nfsd4_ssc_init_umount_work(struct nfsd_net *nn)
+{
+	spin_lock_init(&nn->nfsd_ssc_lock);
+	INIT_LIST_HEAD(&nn->nfsd_ssc_mount_list);
+	init_waitqueue_head(&nn->nfsd_ssc_waitq);
+}
+EXPORT_SYMBOL_GPL(nfsd4_ssc_init_umount_work);
+
+/*
+ * This is called when nfsd is being shutdown, after all inter_ssc
+ * cleanup were done, to destroy the ssc delayed unmount list.
+ */
+static void nfsd4_ssc_shutdown_umount(struct nfsd_net *nn)
+{
+	struct nfsd4_ssc_umount_item *ni = 0;
+	struct nfsd4_ssc_umount_item *tmp;
+
+	spin_lock(&nn->nfsd_ssc_lock);
+	list_for_each_entry_safe(ni, tmp, &nn->nfsd_ssc_mount_list, nsui_list) {
+		list_del(&ni->nsui_list);
+		spin_unlock(&nn->nfsd_ssc_lock);
+		mntput(ni->nsui_vfsmount);
+		kfree(ni);
+		spin_lock(&nn->nfsd_ssc_lock);
+	}
+	spin_unlock(&nn->nfsd_ssc_lock);
+}
+
+static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
+{
+	bool do_wakeup = false;
+	struct nfsd4_ssc_umount_item *ni = 0;
+	struct nfsd4_ssc_umount_item *tmp;
+
+	spin_lock(&nn->nfsd_ssc_lock);
+	list_for_each_entry_safe(ni, tmp, &nn->nfsd_ssc_mount_list, nsui_list) {
+		if (time_after(jiffies, ni->nsui_expire)) {
+			if (refcount_read(&ni->nsui_refcnt) > 1)
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
+	if (do_wakeup)
+		wake_up_all(&nn->nfsd_ssc_waitq);
+	spin_unlock(&nn->nfsd_ssc_lock);
+}
+#endif
+
 static time64_t
 nfs4_laundromat(struct nfsd_net *nn)
 {
@@ -5568,6 +5632,10 @@ nfs4_laundromat(struct nfsd_net *nn)
 		list_del_init(&nbl->nbl_lru);
 		free_blocked_lock(nbl);
 	}
+#ifdef CONFIG_NFSD_V4_2_INTER_SSC
+	/* service the server-to-server copy delayed unmount list */
+	nfsd4_ssc_expire_umount(nn);
+#endif
 out:
 	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
 }
@@ -7486,6 +7554,9 @@ nfs4_state_shutdown_net(struct net *net)
 
 	nfsd4_client_tracking_exit(net);
 	nfs4_state_destroy_net(net);
+#ifdef CONFIG_NFSD_V4_2_INTER_SSC
+	nfsd4_ssc_shutdown_umount(nn);
+#endif
 }
 
 void
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 14dbfa75059d..9664303afdaf 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -484,6 +484,10 @@ static inline bool nfsd_attrs_supported(u32 minorversion, const u32 *bmval)
 extern int nfsd4_is_junction(struct dentry *dentry);
 extern int register_cld_notifier(void);
 extern void unregister_cld_notifier(void);
+#ifdef CONFIG_NFSD_V4_2_INTER_SSC
+extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
+#endif
+
 #else /* CONFIG_NFSD_V4 */
 static inline int nfsd4_is_junction(struct dentry *dentry)
 {
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index dd5d69921676..ccb59e91011b 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -403,6 +403,9 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
 	if (ret)
 		goto out_filecache;
 
+#ifdef CONFIG_NFSD_V4_2_INTER_SSC
+	nfsd4_ssc_init_umount_work(nn);
+#endif
 	nn->nfsd_net_up = true;
 	return 0;
 
diff --git a/include/linux/nfs_ssc.h b/include/linux/nfs_ssc.h
index f5ba0fbff72f..222ae8883e85 100644
--- a/include/linux/nfs_ssc.h
+++ b/include/linux/nfs_ssc.h
@@ -8,6 +8,7 @@
  */
 
 #include <linux/nfs_fs.h>
+#include <linux/sunrpc/svc.h>
 
 extern struct nfs_ssc_client_ops_tbl nfs_ssc_client_tbl;
 
@@ -52,6 +53,19 @@ static inline void nfs42_ssc_close(struct file *filep)
 	if (nfs_ssc_client_tbl.ssc_nfs4_ops)
 		(*nfs_ssc_client_tbl.ssc_nfs4_ops->sco_close)(filep);
 }
+
+struct nfsd4_ssc_umount_item {
+	struct list_head nsui_list;
+	bool nsui_busy;
+	/*
+	 * nsui_refcnt inited to 2, 1 on list and 1 for consumer. Entry
+	 * is removed when refcnt drops to 1 and nsui_expire expires.
+	 */
+	refcount_t nsui_refcnt;
+	unsigned long nsui_expire;
+	struct vfsmount *nsui_vfsmount;
+	char nsui_ipaddr[RPC_MAX_ADDRBUFLEN];
+};
 #endif
 
 /*
-- 
2.9.5

