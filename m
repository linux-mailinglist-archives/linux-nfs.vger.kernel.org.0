Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBC8650498
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Dec 2022 21:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiLRUGg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Dec 2022 15:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLRUGe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Dec 2022 15:06:34 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5C526E0
        for <linux-nfs@vger.kernel.org>; Sun, 18 Dec 2022 12:06:32 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BIH18it003840;
        Sun, 18 Dec 2022 20:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=vMVNoxvrJy+3POCgKsFexNV+5ozliquemtJfltXstFk=;
 b=MV6nExllqdZr5OaX0rvB2PwxeoaGJd2kF5sscazJAV2Tcei4e5f79PYJE0X/4Scm8byi
 nphBhz6+pvY5w6VWOI+viK/Xaq6aA9/aU2nHUGvx6EGH2tVrda92hHe962p+5mvhF0bf
 r77XZrMAyB0u/RkTDqwhJziKR4gPhrPWOdF6sRsJOX/HaIvHwzLe/A5iDzbi+yMXgxW3
 SVijFectqtdKVcmFy1lX495g9M9fs4ERmSl75V/wBJ0g2307Lx/aKnYFhR4AXQV/Qr0j
 3syGDGOEMkQKlxWQdHS7tG27CfzWeQaenL4FETrAn95oaWv4ESdcJWTGW+ZANABjwpQk Nw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tp1nxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 18 Dec 2022 20:06:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BIIq4RX012823;
        Sun, 18 Dec 2022 20:06:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mh472q9gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 18 Dec 2022 20:06:23 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BIK6MoJ014704;
        Sun, 18 Dec 2022 20:06:22 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3mh472q9gv-1;
        Sun, 18 Dec 2022 20:06:22 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     kolga@netapp.com, linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSD: enhance inter-server copy cleanup
Date:   Sun, 18 Dec 2022 12:06:09 -0800
Message-Id: <1671393969-20900-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-18_02,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212180191
X-Proofpoint-GUID: R8ZJnCH6fOv9FFpBE6vR-9iNsGisrbIA
X-Proofpoint-ORIG-GUID: R8ZJnCH6fOv9FFpBE6vR-9iNsGisrbIA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently nfsd4_setup_inter_ssc returns the vfsmount of the source
server's export when the mount completes. After the copy is done
nfsd4_cleanup_inter_ssc is called with the vfsmount of the source
server and it searches nfsd_ssc_mount_list for a matching entry
to do the clean up.

The problems with this approach are (1) the need to search the
nfsd_ssc_mount_list and (2) the code has to handle the case where
the matching entry is not found which looks ugly.

The enhancement is instead of nfsd4_setup_inter_ssc returning the
vfsmount, it returns the nfsd4_ssc_umount_item which has the
vfsmount embedded in it. When nfsd4_cleanup_inter_ssc is called
it's passed with the nfsd4_ssc_umount_item directly to do the
clean up so no searching is needed and there is no need to handle
the 'not found' case.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4proc.c | 91 +++++++++++++++++++++---------------------------------
 fs/nfsd/xdr4.h     |  2 +-
 2 files changed, 36 insertions(+), 57 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index b79ee65ae016..91408f72982b 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1295,15 +1295,15 @@ extern void nfs_sb_deactive(struct super_block *sb);
  * setup a work entry in the ssc delayed unmount list.
  */
 static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
-		struct nfsd4_ssc_umount_item **retwork, struct vfsmount **ss_mnt)
+		struct nfsd4_ssc_umount_item **nsui)
 {
 	struct nfsd4_ssc_umount_item *ni = NULL;
 	struct nfsd4_ssc_umount_item *work = NULL;
 	struct nfsd4_ssc_umount_item *tmp;
 	DEFINE_WAIT(wait);
+	__be32 status = 0;
 
-	*ss_mnt = NULL;
-	*retwork = NULL;
+	*nsui = NULL;
 	work = kzalloc(sizeof(*work), GFP_KERNEL);
 try_again:
 	spin_lock(&nn->nfsd_ssc_lock);
@@ -1326,12 +1326,12 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
 			finish_wait(&nn->nfsd_ssc_waitq, &wait);
 			goto try_again;
 		}
-		*ss_mnt = ni->nsui_vfsmount;
+		*nsui = ni;
 		refcount_inc(&ni->nsui_refcnt);
 		spin_unlock(&nn->nfsd_ssc_lock);
 		kfree(work);
 
-		/* return vfsmount in ss_mnt */
+		/* return vfsmount in (*nsui)->nsui_vfsmount */
 		return 0;
 	}
 	if (work) {
@@ -1339,10 +1339,11 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
 		refcount_set(&work->nsui_refcnt, 2);
 		work->nsui_busy = true;
 		list_add_tail(&work->nsui_list, &nn->nfsd_ssc_mount_list);
-		*retwork = work;
-	}
+		*nsui = work;
+	} else
+		status = nfserr_resource;
 	spin_unlock(&nn->nfsd_ssc_lock);
-	return 0;
+	return status;
 }
 
 static void nfsd4_ssc_update_dul_work(struct nfsd_net *nn,
@@ -1371,7 +1372,7 @@ static void nfsd4_ssc_cancel_dul_work(struct nfsd_net *nn,
  */
 static __be32
 nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
-		       struct vfsmount **mount)
+			struct nfsd4_ssc_umount_item **nsui)
 {
 	struct file_system_type *type;
 	struct vfsmount *ss_mnt;
@@ -1382,7 +1383,6 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
 	char *ipaddr, *dev_name, *raw_data;
 	int len, raw_len;
 	__be32 status = nfserr_inval;
-	struct nfsd4_ssc_umount_item *work = NULL;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
 	naddr = &nss->u.nl4_addr;
@@ -1390,6 +1390,7 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
 					 naddr->addr_len,
 					 (struct sockaddr *)&tmp_addr,
 					 sizeof(tmp_addr));
+	*nsui = NULL;
 	if (tmp_addrlen == 0)
 		goto out_err;
 
@@ -1432,10 +1433,10 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
 		goto out_free_rawdata;
 	snprintf(dev_name, len + 5, "%s%s%s:/", startsep, ipaddr, endsep);
 
-	status = nfsd4_ssc_setup_dul(nn, ipaddr, &work, &ss_mnt);
+	status = nfsd4_ssc_setup_dul(nn, ipaddr, nsui);
 	if (status)
 		goto out_free_devname;
-	if (ss_mnt)
+	if ((*nsui)->nsui_vfsmount)
 		goto out_done;
 
 	/* Use an 'internal' mount: SB_KERNMOUNT -> MNT_INTERNAL */
@@ -1443,15 +1444,12 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
 	module_put(type->owner);
 	if (IS_ERR(ss_mnt)) {
 		status = nfserr_nodev;
-		if (work)
-			nfsd4_ssc_cancel_dul_work(nn, work);
+		nfsd4_ssc_cancel_dul_work(nn, *nsui);
 		goto out_free_devname;
 	}
-	if (work)
-		nfsd4_ssc_update_dul_work(nn, work, ss_mnt);
+	nfsd4_ssc_update_dul_work(nn, *nsui, ss_mnt);
 out_done:
 	status = 0;
-	*mount = ss_mnt;
 
 out_free_devname:
 	kfree(dev_name);
@@ -1474,8 +1472,7 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
  */
 static __be32
 nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
-		      struct nfsd4_compound_state *cstate,
-		      struct nfsd4_copy *copy, struct vfsmount **mount)
+		struct nfsd4_compound_state *cstate, struct nfsd4_copy *copy)
 {
 	struct svc_fh *s_fh = NULL;
 	stateid_t *s_stid = &copy->cp_src_stateid;
@@ -1488,7 +1485,8 @@ nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
 	if (status)
 		goto out;
 
-	status = nfsd4_interssc_connect(copy->cp_src, rqstp, mount);
+	status = nfsd4_interssc_connect(copy->cp_src, rqstp,
+				&copy->ss_nsui);
 	if (status)
 		goto out;
 
@@ -1506,54 +1504,36 @@ nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
 }
 
 static void
-nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
+nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item *ni, struct file *filp,
 			struct nfsd_file *dst)
 {
-	bool found = false;
 	long timeout;
-	struct nfsd4_ssc_umount_item *tmp;
-	struct nfsd4_ssc_umount_item *ni = NULL;
 	struct nfsd_net *nn = net_generic(dst->nf_net, nfsd_net_id);
 
 	nfs42_ssc_close(filp);
 	nfsd_file_put(dst);
 	fput(filp);
 
-	if (!nn) {
-		mntput(ss_mnt);
-		return;
-	}
 	spin_lock(&nn->nfsd_ssc_lock);
 	timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
-	list_for_each_entry_safe(ni, tmp, &nn->nfsd_ssc_mount_list, nsui_list) {
-		if (ni->nsui_vfsmount->mnt_sb == ss_mnt->mnt_sb) {
-			list_del(&ni->nsui_list);
-			/*
-			 * vfsmount can be shared by multiple exports,
-			 * decrement refcnt. If the count drops to 1 it
-			 * will be unmounted when nsui_expire expires.
-			 */
-			refcount_dec(&ni->nsui_refcnt);
-			ni->nsui_expire = jiffies + timeout;
-			list_add_tail(&ni->nsui_list, &nn->nfsd_ssc_mount_list);
-			found = true;
-			break;
-		}
-	}
+	list_del(&ni->nsui_list);
+	/*
+	 * vfsmount can be shared by multiple exports,
+	 * decrement refcnt. If the count drops to 1 it
+	 * will be unmounted when nsui_expire expires.
+	 */
+	refcount_dec(&ni->nsui_refcnt);
+	ni->nsui_expire = jiffies + timeout;
+	list_add_tail(&ni->nsui_list, &nn->nfsd_ssc_mount_list);
 	spin_unlock(&nn->nfsd_ssc_lock);
-	if (!found) {
-		mntput(ss_mnt);
-		return;
-	}
 }
 
 #else /* CONFIG_NFSD_V4_2_INTER_SSC */
 
 static __be32
 nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
-		      struct nfsd4_compound_state *cstate,
-		      struct nfsd4_copy *copy,
-		      struct vfsmount **mount)
+			struct nfsd4_compound_state *cstate,
+			struct nfsd4_copy *copy)
 {
 	*mount = NULL;
 	return nfserr_inval;
@@ -1700,7 +1680,7 @@ static void dup_copy_fields(struct nfsd4_copy *src, struct nfsd4_copy *dst)
 	memcpy(dst->cp_src, src->cp_src, sizeof(struct nl4_server));
 	memcpy(&dst->stateid, &src->stateid, sizeof(src->stateid));
 	memcpy(&dst->c_fh, &src->c_fh, sizeof(src->c_fh));
-	dst->ss_mnt = src->ss_mnt;
+	dst->ss_nsui = src->ss_nsui;
 }
 
 static void cleanup_async_copy(struct nfsd4_copy *copy)
@@ -1749,8 +1729,8 @@ static int nfsd4_do_async_copy(void *data)
 	if (nfsd4_ssc_is_inter(copy)) {
 		struct file *filp;
 
-		filp = nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
-				      &copy->stateid);
+		filp = nfs42_ssc_open(copy->ss_nsui->nsui_vfsmount,
+				&copy->c_fh, &copy->stateid);
 		if (IS_ERR(filp)) {
 			switch (PTR_ERR(filp)) {
 			case -EBADF:
@@ -1764,7 +1744,7 @@ static int nfsd4_do_async_copy(void *data)
 		}
 		nfserr = nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
 				       false);
-		nfsd4_cleanup_inter_ssc(copy->ss_mnt, filp, copy->nf_dst);
+		nfsd4_cleanup_inter_ssc(copy->ss_nsui, filp, copy->nf_dst);
 	} else {
 		nfserr = nfsd4_do_copy(copy, copy->nf_src->nf_file,
 				       copy->nf_dst->nf_file, false);
@@ -1790,8 +1770,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			status = nfserr_notsupp;
 			goto out;
 		}
-		status = nfsd4_setup_inter_ssc(rqstp, cstate, copy,
-				&copy->ss_mnt);
+		status = nfsd4_setup_inter_ssc(rqstp, cstate, copy);
 		if (status)
 			return nfserr_offload_denied;
 	} else {
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 0eb00105d845..36c3340c1d54 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -571,7 +571,7 @@ struct nfsd4_copy {
 	struct task_struct	*copy_task;
 	refcount_t		refcount;
 
-	struct vfsmount		*ss_mnt;
+	struct nfsd4_ssc_umount_item *ss_nsui;
 	struct nfs_fh		c_fh;
 	nfs4_stateid		stateid;
 };
-- 
2.9.5

