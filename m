Return-Path: <linux-nfs+bounces-17106-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B755CBF5E4
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 19:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 042F930012FF
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 18:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6655B312807;
	Mon, 15 Dec 2025 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EuFgzQPT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A100324B1E
	for <linux-nfs@vger.kernel.org>; Mon, 15 Dec 2025 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765822492; cv=none; b=BTlkTXnMf2qGciwEloM82LV/jnNsc6Er+Pey9zCwxgjeCsDodg3jFsYDUsMIpXiNB99eE1zBRptuRuFCMkjV8gEfdtdQd/nyDuETvKjnSrmdQEQvZXS4HgMWvogbztpAV/eXV8mo8QWsUZ3w5n2fjRpBt47PwlDdR9aZs9dFE00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765822492; c=relaxed/simple;
	bh=CVvAttq0bLLA3SDVEb6qkWlFDsLWxcGfsx59CZO514M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D0yiWu9C10ULF5Pu+jjdqSh7TDL+e/NAPt1U9tioPiNMqAA2sjs1ZpgnIX7IKu0PnDX9aCwqjYW96LWz5zws6/UuhTd6SzbUQaC8p87Xmr0SSJ0qVZqmoTdTJ7/C80BF6WEe32q80rYRU0GyBxMnMEfTwjQXrxpBcCa+PvNgVY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EuFgzQPT; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFFNZBS2330570;
	Mon, 15 Dec 2025 18:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=I4em+02+rD6cv0MKrGC1+yM3r/WQXJfqbMQ1AhFts7w=; b=
	EuFgzQPTh/NLhF7CARMbQY/uWuBRwBprkEc4CyC+k2IlGqZV5WBLT1b7iIiHePJy
	xRtn9GS5BglUGUkgLA16Sqr4MvHP6l50Pi91QjOjbFwYMz9jUeqaRkOMGSef/gL3
	UvIAzY8CyR38k9Ki76hx+1bZtrQoQzfLrTKdNUQa2zc6GVqqR+95eu7BSuatObAM
	b3aQRZP2lMtwhxE7LJucYTBpw7CNkxxH9lxH2vCuw77VqZLu4XPqGSqCyFE6GeZo
	grAPzFl3lCeb34jaG8ReZJn4BSujDBklfIYjsEoxrTn3HVcY+Ccf1kgVV+rRfx0N
	GU6IpfQiiDx7nMLvy/i2KA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0xqxtm22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 18:14:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFI154m024951;
	Mon, 15 Dec 2025 18:14:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk98b99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 18:14:25 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BFIEOYK011653;
	Mon, 15 Dec 2025 18:14:25 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4b0xk98b7y-3;
	Mon, 15 Dec 2025 18:14:25 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFSD: Add infrastructure for tracking persistent SCSI registration keys
Date: Mon, 15 Dec 2025 10:13:34 -0800
Message-ID: <20251215181418.2201035-3-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251215181418.2201035-1-dai.ngo@oracle.com>
References: <20251215181418.2201035-1-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_04,2025-12-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150158
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDE1OCBTYWx0ZWRfX1OsemFfr7YwB
 A6YDwYVx02P1gi2dDDynzD9qwwSkuZ+awZ1qZEN6Kaa1fTlWEQrzIEoCOof3hoQnNAB1ahtNUHp
 MmXdbHgm9o/TPDmS7UV//UbfD3bNWTekRyBeGzCSj0vBlBED8GfDv9/VyzzaT6Nqd+/lK8I+Q3p
 hZhMYJ3xqUBmU0nIJ730xkp1ODECEX5N1CE8fUgWuYlSpxgcXpX+zokXtglcp6KF33yC0yGqe4a
 CCvg7AWsi4DmWPYIx+AdXI8ewru9VmScLS5WnC4Lb1tadb45QjpoxBlWCMH9GxRDj5jx4xLkb22
 0DY8hGpt9Ol1QAArgu+mfSrqkpr4qi/52w3nbO22ZQ724i/XY1sgb+X9CwqG/jBcnbZ3kKUIkeZ
 yu+zrN2AHH/IehVsSsGVLK83l80uSA==
X-Proofpoint-GUID: dXvWNosmahI_UiGPXijAotusyREXV1dE
X-Proofpoint-ORIG-GUID: dXvWNosmahI_UiGPXijAotusyREXV1dE
X-Authority-Analysis: v=2.4 cv=BYDVE7t2 c=1 sm=1 tr=0 ts=69405002 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=-T7NtEw7ogVVi_X37dUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10

Introduce a per-net namespace hash table to maintain records of
NFSv4 clients that have been assigned persistent registration
keys for accessing SCSI block devices. Each entry in this table
consists of the client’s ID, the associated SCSI block device
(dev_t), and a fenced status flag.

This infrastructure is used to prevent duplicate fencing operations.

Implementation details:

When a client receives a persistent registration key for a SCSI
device the server creates a new record (with the ‘fenced’ flag set
to false) and inserts it into the hash table for the corresponding
network namespace.

When the server needs to perform a fencing operation, it consults
the client’s record to check the existing fenced status and avoids
issuing redundant fencing operations if the client is already
fenced.

Whenever a client issues a GETDEVINFO call to obtain a new layout,
the server resets the client’s fenced flag to false, allowing for
new fencing actions as appropriate.

Upon client unmount or session teardown, all records belonging to
that client are cleaned up in __destroy_client. The entire hash table
and all contained client records are freed when the corresponding
network namespace is shut down.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/blocklayout.c | 129 ++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/netns.h       |   2 +
 fs/nfsd/nfs4state.c   |   1 +
 fs/nfsd/nfsd.h        |  16 ++++++
 fs/nfsd/nfssvc.c      |   9 ++-
 fs/nfsd/pnfs.h        |  11 ++++
 6 files changed, 166 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index afa16d7a8013..f2ab264af88e 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -426,4 +426,133 @@ const struct nfsd4_layout_ops scsi_layout_ops = {
 	.proc_layoutcommit	= nfsd4_scsi_proc_layoutcommit,
 	.fence_client		= nfsd4_scsi_fence_client,
 };
+
+int
+nfsd4_scsi_pr_init_hashtbl(struct nfsd_net *nn)
+{
+	int ix;
+
+	nn->client_pr_record_hashtbl = kmalloc_array(CLIENT_HASH_SIZE,
+					sizeof(struct list_head),
+					GFP_KERNEL);
+	if (!nn->client_pr_record_hashtbl)
+		return -ENOMEM;
+	spin_lock_init(&nn->client_pr_record_hashtbl_lock);
+	for (ix = 0; ix < CLIENT_HASH_SIZE; ix++)
+		INIT_LIST_HEAD(&nn->client_pr_record_hashtbl[ix]);
+	return 0;
+}
+
+static struct scsi_pr_record *
+nfsd4_pr_find_client(struct nfs4_client *clp, struct block_device *blkdev)
+{
+	struct scsi_pr_record *pr_rec = NULL;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
+	unsigned int idhashval;
+	dev_t bdev = blkdev->bd_dev;
+
+	assert_spin_locked(&nn->client_pr_record_hashtbl_lock);
+	idhashval = clientid_hashval(clp->cl_clientid.cl_id);
+	list_for_each_entry(pr_rec, &nn->client_pr_record_hashtbl[idhashval],
+					spr_hash) {
+		if (same_clid(&pr_rec->spr_clid, &clp->cl_clientid) &&
+				pr_rec->spr_bdev == bdev) {
+			return pr_rec;
+		}
+	}
+	return NULL;
+}
+
+static int
+nfsd4_scsi_pr_add_client(struct nfs4_client *clp, struct block_device *blkdev)
+{
+	unsigned int idhashval;
+	struct scsi_pr_record *pr_rec = NULL;
+	struct scsi_pr_record *rec;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
+	dev_t bdev = blkdev->bd_dev;
+
+	spin_lock(&nn->client_pr_record_hashtbl_lock);
+	rec = nfsd4_pr_find_client(clp, blkdev);
+	if (rec) {
+		rec->spr_fenced = false;
+		spin_unlock(&nn->client_pr_record_hashtbl_lock);
+		return 0;
+	}
+	spin_unlock(&nn->client_pr_record_hashtbl_lock);
+
+	pr_rec = kzalloc(sizeof(struct scsi_pr_record), GFP_KERNEL);
+	if (!pr_rec)
+		return -ENOMEM;
+	pr_rec->spr_clid = clp->cl_clientid;
+	pr_rec->spr_bdev = bdev;
+	pr_rec->spr_fenced = false;
+
+	idhashval = clientid_hashval(clp->cl_clientid.cl_id);
+	spin_lock(&nn->client_pr_record_hashtbl_lock);
+	rec = nfsd4_pr_find_client(clp, blkdev);
+	if (rec) {
+		rec->spr_fenced = false;
+		spin_unlock(&nn->client_pr_record_hashtbl_lock);
+		kfree(pr_rec);
+		return 0;
+	}
+	list_add(&pr_rec->spr_hash, &nn->client_pr_record_hashtbl[idhashval]);
+	spin_unlock(&nn->client_pr_record_hashtbl_lock);
+	return 0;
+
+}
+
+bool
+nfsd4_scsi_pr_fence(struct nfs4_client *clp, struct block_device *blkdev)
+{
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
+	struct scsi_pr_record *rec;
+
+	assert_spin_locked(&nn->client_pr_record_hashtbl_lock);
+	rec = nfsd4_pr_find_client(clp, blkdev);
+	if (rec && !rec->spr_fenced) {
+		rec->spr_fenced = true;
+		return true;
+	}
+	return false;
+}
+
+void
+nfsd4_scsi_pr_del_client(struct nfs4_client *clp)
+{
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
+	struct scsi_pr_record *entry, *tmp;
+	unsigned int idhashval;
+
+	idhashval = clientid_hashval(clp->cl_clientid.cl_id);
+	spin_lock(&nn->client_pr_record_hashtbl_lock);
+	list_for_each_entry_safe(entry, tmp,
+			&nn->client_pr_record_hashtbl[idhashval], spr_hash) {
+		if (same_clid(&entry->spr_clid, &clp->cl_clientid)) {
+			list_del(&entry->spr_hash);
+			kfree(entry);
+		}
+	}
+	spin_unlock(&nn->client_pr_record_hashtbl_lock);
+}
+
+void
+nfsd4_scsi_pr_shutdown(struct nfsd_net *nn)
+{
+	int ix;
+	struct scsi_pr_record *entry;
+
+	spin_lock(&nn->client_pr_record_hashtbl_lock);
+	for (ix = 0; ix < CLIENT_HASH_SIZE; ix++) {
+		while (!list_empty(&nn->client_pr_record_hashtbl[ix])) {
+			entry = list_entry(nn->client_pr_record_hashtbl[ix].next,
+					struct scsi_pr_record, spr_hash);
+			list_del(&entry->spr_hash);
+			kfree(entry);
+		}
+	}
+	spin_unlock(&nn->client_pr_record_hashtbl_lock);
+	kfree(nn->client_pr_record_hashtbl);
+}
 #endif /* CONFIG_NFSD_SCSILAYOUT */
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 3e2d0fde80a7..466f8478d8f3 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -217,6 +217,8 @@ struct nfsd_net {
 	spinlock_t              local_clients_lock;
 	struct list_head	local_clients;
 #endif
+	spinlock_t		client_pr_record_hashtbl_lock;
+	struct list_head	*client_pr_record_hashtbl;
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 13b4dc89b1e8..70009e882a4a 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2528,6 +2528,7 @@ __destroy_client(struct nfs4_client *clp)
 		svc_xprt_put(clp->cl_cb_conn.cb_xprt);
 	atomic_add_unless(&nn->nfs4_client_count, -1, 0);
 	nfsd4_dec_courtesy_client_count(nn, clp);
+	nfsd4_scsi_pr_del_client(clp);
 	free_client(clp);
 	wake_up_all(&expiry_wq);
 }
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 369efe6ed665..4572daa94a79 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -570,6 +570,15 @@ extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
 
 extern void nfsd4_init_leases_net(struct nfsd_net *nn);
 
+extern int nfsd4_scsi_pr_init_hashtbl(struct nfsd_net *net);
+extern void nfsd4_scsi_pr_shutdown(struct nfsd_net *net);
+struct nfs4_client;
+extern void nfsd4_scsi_pr_del_client(struct nfs4_client *clp);
+extern int nfsd4_scsi_pr_add_client(struct nfs4_client *clp,
+		struct block_device *blkdev);
+extern bool nfsd4_scsi_pr_fence(struct nfs4_client *clp,
+		struct block_device *blkdev);
+
 #else /* CONFIG_NFSD_V4 */
 static inline int nfsd4_is_junction(struct dentry *dentry)
 {
@@ -578,6 +587,13 @@ static inline int nfsd4_is_junction(struct dentry *dentry)
 
 static inline void nfsd4_init_leases_net(struct nfsd_net *nn) { };
 
+extern inline int nfsd4_scsi_pr_init_hashtbl(struct nfsd_net *nn)
+{
+	return 0;
+}
+
+extern inline void nfsd4_scsi_pr_shutdown(struct nfsd_net *nn) {};
+
 #define register_cld_notifier() 0
 #define unregister_cld_notifier() do { } while(0)
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index f6cae4430ba4..d4f96291b4b5 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -381,13 +381,17 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
 #ifdef CONFIG_NFSD_V4_2_INTER_SSC
 	nfsd4_ssc_init_umount_work(nn);
 #endif
-	ret = nfs4_state_start_net(net);
+	ret = nfsd4_scsi_pr_init_hashtbl(nn);
 	if (ret)
 		goto out_reply_cache;
-
+	ret = nfs4_state_start_net(net);
+	if (ret)
+		goto out_pr_client;
 	nn->nfsd_net_up = true;
 	return 0;
 
+out_pr_client:
+	nfsd4_scsi_pr_shutdown(nn);
 out_reply_cache:
 	nfsd_reply_cache_shutdown(nn);
 out_filecache:
@@ -423,6 +427,7 @@ static void nfsd_shutdown_net(struct net *net)
 
 	wait_for_completion(&nn->nfsd_net_free_done);
 	percpu_ref_exit(&nn->nfsd_net_ref);
+	nfsd4_scsi_pr_shutdown(nn);
 
 	nn->nfsd_net_up = false;
 	nfsd_shutdown_generic();
diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
index db9af780438b..9ae02b6d922d 100644
--- a/fs/nfsd/pnfs.h
+++ b/fs/nfsd/pnfs.h
@@ -67,6 +67,17 @@ __be32 nfsd4_return_client_layouts(struct svc_rqst *rqstp,
 int nfsd4_set_deviceid(struct nfsd4_deviceid *id, const struct svc_fh *fhp,
 		u32 device_generation);
 struct nfsd4_deviceid_map *nfsd4_find_devid_map(int idx);
+
+int nfsd4_scsi_pr_init_hashtbl(struct nfsd_net *nn);
+void nfsd4_scsi_pr_shutdown(struct nfsd_net *nn);
+void nfsd4_scsi_pr_del_client(struct nfs4_client *clp);
+
+struct scsi_pr_record {
+	struct list_head spr_hash;
+	clientid_t spr_clid;
+	dev_t spr_bdev;
+	bool spr_fenced;
+};
 #endif /* CONFIG_NFSD_V4 */
 
 #ifdef CONFIG_NFSD_PNFS
-- 
2.47.3


