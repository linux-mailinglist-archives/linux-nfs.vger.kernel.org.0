Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5829352340
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Apr 2021 01:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbhDAXNQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Apr 2021 19:13:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54950 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbhDAXNQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Apr 2021 19:13:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131N8WIG140629;
        Thu, 1 Apr 2021 23:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=YmYfS3h4fUtjiEIHjP9A6W5ryyLXZiDghPkPtYPLWr0=;
 b=0aaNpO4LaBtCQI95dE75eDKzNZ9ahd5PghJ2/Y0pXgxQAysa/F9f2B+pKXBxRkqYa5Qa
 DMzcJu+wQCfRBiaANLA21rTeYxTHFypr6xB3rlToO1LPkRO1vVzuwd4m33OlEygbUTku
 pZ8/n+EKWitbtBuolNOlY5O9qTow/4JEvz8LTMLCsz4t2AMMkEoGYBaIsx78z2ZZMc5T
 lHBRIfJ6qfU0cfB+lu92nx+ZARDik5cFAEOERimQfLbM6VJ96A+U3eXJBBnvNKWed9L/
 7APPL6yOG0BQn50kMM0vRC2hoeNsHLfOZGorhrjw0xjkSw+lDdwePYMh4g1WcKGp1qEq bw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 37n2a03chq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 23:13:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131N9c1b119179;
        Thu, 1 Apr 2021 23:13:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 37n2ate1v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 23:13:03 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 131ND15E130727;
        Thu, 1 Apr 2021 23:13:02 GMT
Received: from aserp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3030.oracle.com with ESMTP id 37n2ate1u4-2;
        Thu, 01 Apr 2021 23:13:02 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     olga.kornievskaia@gmail.com
Cc:     linux-nfs@vger.kernel.org, trondmy@hammerspace.com,
        bfields@fieldses.org, chuck.lever@oracle.com
Subject: [PATCH 1/2] NFSD: delay unmount source's export after inter-server copy completed.
Date:   Thu,  1 Apr 2021 19:12:57 -0400
Message-Id: <20210401231258.63292-2-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
In-Reply-To: <20210401231258.63292-1-dai.ngo@oracle.com>
References: <20210401231258.63292-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hyaodjwPNGCvlny2lTO8U5uwzLFb0lyS
X-Proofpoint-ORIG-GUID: hyaodjwPNGCvlny2lTO8U5uwzLFb0lyS
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010149
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
 fs/nfsd/nfs4proc.c      | 136 ++++++++++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/nfsd.h          |   4 ++
 fs/nfsd/nfssvc.c        |   3 ++
 include/linux/nfs_ssc.h |  17 ++++++
 4 files changed, 157 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index dd9f38d072dd..4e9a53d477a0 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -55,6 +55,74 @@ module_param(inter_copy_offload_enable, bool, 0644);
 MODULE_PARM_DESC(inter_copy_offload_enable,
 		 "Enable inter server to server copy offload. Default: false");
 
+#ifdef CONFIG_NFSD_V4_2_INTER_SSC
+static int nfsd4_ssc_umount_timeout = 900000;		/* default to 15 mins */
+module_param(nfsd4_ssc_umount_timeout, int, 0644);
+MODULE_PARM_DESC(nfsd4_ssc_umount_timeout,
+		"idle msecs before unmount export from source server");
+
+static struct nfsd4_ssc_umount nfsd4_ssc_umount;
+
+/* nfsd4_ssc_umount.nsu_lock must be held */
+static void nfsd4_scc_update_umnt_timo(void)
+{
+	struct nfsd4_ssc_umount_item *ni = 0;
+
+	if (!list_empty(&nfsd4_ssc_umount.nsu_list)) {
+		ni = list_first_entry(&nfsd4_ssc_umount.nsu_list,
+			struct nfsd4_ssc_umount_item, nsui_list);
+		nfsd4_ssc_umount.nsu_expire = ni->nsui_expire;
+		schedule_delayed_work(&nfsd4_ssc_umount.nsu_umount_work,
+			ni->nsui_expire - jiffies);
+	} else
+		nfsd4_ssc_umount.nsu_expire = 0;
+}
+
+void nfsd4_ssc_expire_umount(struct work_struct *work)
+{
+	struct nfsd4_ssc_umount_item *ni = 0;
+	struct nfsd4_ssc_umount_item *tmp;
+
+	down_write(&nfsd4_ssc_umount.nsu_sem);
+	spin_lock(&nfsd4_ssc_umount.nsu_lock);
+	list_for_each_entry_safe(ni, tmp, &nfsd4_ssc_umount.nsu_list, nsui_list) {
+		if (time_after(jiffies, ni->nsui_expire)) {
+			list_del(&ni->nsui_list);
+			cancel_delayed_work(&nfsd4_ssc_umount.nsu_umount_work);
+			spin_unlock(&nfsd4_ssc_umount.nsu_lock);
+			up_write(&nfsd4_ssc_umount.nsu_sem);
+
+			mntput(ni->nsui_vfsmount);
+			kfree(ni);
+
+			down_write(&nfsd4_ssc_umount.nsu_sem);
+			spin_lock(&nfsd4_ssc_umount.nsu_lock);
+			continue;
+		}
+		break;
+	}
+	nfsd4_scc_update_umnt_timo();
+	spin_unlock(&nfsd4_ssc_umount.nsu_lock);
+	up_write(&nfsd4_ssc_umount.nsu_sem);
+}
+EXPORT_SYMBOL_GPL(nfsd4_ssc_expire_umount);
+
+static DECLARE_DELAYED_WORK(nfsd4, nfsd4_ssc_expire_umount);
+
+void nfsd4_ssc_init_umount_work(void)
+{
+	if (nfsd4_ssc_umount.nsu_inited)
+		return;
+	INIT_DELAYED_WORK(&nfsd4_ssc_umount.nsu_umount_work,
+		nfsd4_ssc_expire_umount);
+	INIT_LIST_HEAD(&nfsd4_ssc_umount.nsu_list);
+	spin_lock_init(&nfsd4_ssc_umount.nsu_lock);
+	init_rwsem(&nfsd4_ssc_umount.nsu_sem);
+	nfsd4_ssc_umount.nsu_inited = true;
+}
+EXPORT_SYMBOL_GPL(nfsd4_ssc_init_umount_work);
+#endif
+
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 #include <linux/security.h>
 
@@ -1181,6 +1249,8 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
 	char *ipaddr, *dev_name, *raw_data;
 	int len, raw_len;
 	__be32 status = nfserr_inval;
+	struct nfsd4_ssc_umount_item *ni = 0;
+	struct nfsd4_ssc_umount_item *tmp;
 
 	naddr = &nss->u.nl4_addr;
 	tmp_addrlen = rpc_uaddr2sockaddr(SVC_NET(rqstp), naddr->addr,
@@ -1229,11 +1299,33 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
 		goto out_free_rawdata;
 	snprintf(dev_name, len + 5, "%s%s%s:/", startsep, ipaddr, endsep);
 
+	/* wait for ssc unmount task */
+	down_read(&nfsd4_ssc_umount.nsu_sem);
+
 	/* Use an 'internal' mount: SB_KERNMOUNT -> MNT_INTERNAL */
 	ss_mnt = vfs_kern_mount(type, SB_KERNMOUNT, dev_name, raw_data);
 	module_put(type->owner);
-	if (IS_ERR(ss_mnt))
+	if (IS_ERR(ss_mnt)) {
+		up_read(&nfsd4_ssc_umount.nsu_sem);
 		goto out_free_devname;
+	}
+
+	 /* delete work entry if it exists */
+	spin_lock(&nfsd4_ssc_umount.nsu_lock);
+	list_for_each_entry_safe(ni, tmp, &nfsd4_ssc_umount.nsu_list, nsui_list) {
+		if (ni->nsui_vfsmount->mnt_sb != ss_mnt->mnt_sb)
+			continue;
+		list_del(&ni->nsui_list);
+		cancel_delayed_work(&nfsd4_ssc_umount.nsu_umount_work);
+		nfsd4_scc_update_umnt_timo();
+		spin_unlock(&nfsd4_ssc_umount.nsu_lock);
+		mntput(ni->nsui_vfsmount);
+		kfree(ni);
+		goto out_done;
+	}
+	spin_unlock(&nfsd4_ssc_umount.nsu_lock);
+out_done:
+	up_read(&nfsd4_ssc_umount.nsu_sem);
 
 	status = 0;
 	*mount = ss_mnt;
@@ -1301,10 +1393,48 @@ static void
 nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct nfsd_file *src,
 			struct nfsd_file *dst)
 {
+	long timeout;
+	struct nfsd4_ssc_umount_item *work, *tmp;
+	struct nfsd4_ssc_umount_item *ni = 0;
+
 	nfs42_ssc_close(src->nf_file);
-	fput(src->nf_file);
 	nfsd_file_put(dst);
-	mntput(ss_mnt);
+	fput(src->nf_file);
+
+	work = kzalloc(sizeof(*work), GFP_KERNEL);
+	if (!work) {
+		mntput(ss_mnt);
+		return;
+	}
+	timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
+	work->nsui_vfsmount = ss_mnt;
+	work->nsui_expire = jiffies + timeout;
+
+	spin_lock(&nfsd4_ssc_umount.nsu_lock);
+	/*
+	 * check if entry for vfsmount->mnt_sb exists, if it does
+	 * then remove it, update expire time and re-insert at tail,
+	 * do the mntput for this call and return. Otherwise create
+	 * new work entry.
+	 */
+	list_for_each_entry_safe(ni, tmp, &nfsd4_ssc_umount.nsu_list,
+		nsui_list) {
+		if (ni->nsui_vfsmount->mnt_sb == ss_mnt->mnt_sb) {
+			list_del(&ni->nsui_list);
+			mntput(ss_mnt);
+			kfree(work);
+			ni->nsui_expire = jiffies + timeout;
+			work = ni;
+			break;
+		}
+	}
+	list_add_tail(&work->nsui_list, &nfsd4_ssc_umount.nsu_list);
+	if (!nfsd4_ssc_umount.nsu_expire) {
+		nfsd4_ssc_umount.nsu_expire = work->nsui_expire;
+		schedule_delayed_work(&nfsd4_ssc_umount.nsu_umount_work,
+			timeout);
+	}
+	spin_unlock(&nfsd4_ssc_umount.nsu_lock);
 }
 
 #else /* CONFIG_NFSD_V4_2_INTER_SSC */
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 8bdc37aa2c2e..b3bf8a5f4472 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -483,6 +483,10 @@ static inline bool nfsd_attrs_supported(u32 minorversion, const u32 *bmval)
 extern int nfsd4_is_junction(struct dentry *dentry);
 extern int register_cld_notifier(void);
 extern void unregister_cld_notifier(void);
+#ifdef CONFIG_NFSD_V4_2_INTER_SSC
+extern void nfsd4_ssc_init_umount_work(void);
+#endif
+
 #else /* CONFIG_NFSD_V4 */
 static inline int nfsd4_is_junction(struct dentry *dentry)
 {
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 6de406322106..2558db55b88b 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -322,6 +322,9 @@ static int nfsd_startup_generic(int nrservs)
 	ret = nfs4_state_start();
 	if (ret)
 		goto out_file_cache;
+#ifdef CONFIG_NFSD_V4_2_INTER_SSC
+	nfsd4_ssc_init_umount_work();
+#endif
 	return 0;
 
 out_file_cache:
diff --git a/include/linux/nfs_ssc.h b/include/linux/nfs_ssc.h
index f5ba0fbff72f..337d740dad17 100644
--- a/include/linux/nfs_ssc.h
+++ b/include/linux/nfs_ssc.h
@@ -8,6 +8,7 @@
  */
 
 #include <linux/nfs_fs.h>
+#include <linux/sunrpc/svc.h>
 
 extern struct nfs_ssc_client_ops_tbl nfs_ssc_client_tbl;
 
@@ -52,6 +53,22 @@ static inline void nfs42_ssc_close(struct file *filep)
 	if (nfs_ssc_client_tbl.ssc_nfs4_ops)
 		(*nfs_ssc_client_tbl.ssc_nfs4_ops->sco_close)(filep);
 }
+
+struct nfsd4_ssc_umount_item {
+	struct list_head nsui_list;
+	unsigned long nsui_expire;
+	struct vfsmount *nsui_vfsmount;
+};
+
+struct nfsd4_ssc_umount {
+	struct list_head nsu_list;
+	struct delayed_work nsu_umount_work;
+	spinlock_t nsu_lock;
+	struct rw_semaphore nsu_sem;
+	unsigned long nsu_expire;
+	bool nsu_inited;
+};
+
 #endif
 
 /*
-- 
2.9.5

