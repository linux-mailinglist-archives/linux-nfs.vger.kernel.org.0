Return-Path: <linux-nfs+bounces-17310-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C55CDCDF092
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Dec 2025 22:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68FFD3006F5C
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Dec 2025 21:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE14E28E0F;
	Fri, 26 Dec 2025 21:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GZf/A8p5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FF31FB1
	for <linux-nfs@vger.kernel.org>; Fri, 26 Dec 2025 21:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766784161; cv=none; b=VSgaVD6qE6WeiobvicX8PFdCKrkl/iZUQSQUymcak5l2nQOcaGpKP95lvxzh/x5lmbZ4jsy8lHZA4YXRhBBWgV8ZqFBVQ00QpTg6fFE6Dr+FCtC2pZxgOAfOitTdmtbhnBr2+LjeoBSPIzdhcFAM1JqcccKQu38wswj+s2XvD7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766784161; c=relaxed/simple;
	bh=cRvDzkO3BWl5c6z6hfHEl56dW6hLQA+aCW92rx3wWOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PfmK6EnGnURlUF7WHBFLS3bYyE3kFKlKn9wL7UE8tJEEx/s29oWZhDkEAsf/S2kerU5Lo0xNG3kiIhN6WXpX8bdL6BOUXSCHpCVN067QKPFWrBecorET+YZj/v4bPYkpydOgRJXtxeh9HCH7QEI7pYSPDbKOSnPQUNsfLdoQDD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GZf/A8p5; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BQ7P44F3045077;
	Fri, 26 Dec 2025 21:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=r9Tjwq+XiP3KKhL6XKPEpypGSEDnR
	hfvNyznbpe08cw=; b=GZf/A8p51Ec4qAivDa+xl1ocoG8AfyqV90q2DBN0D1wDF
	pPn2iweoOPEumBGubYItwvwPJrLlMVNgTEFy4VqGhAakdgNFWvFQ+7v7sLkdMCpy
	7VAVcM4R535c2S8cvcURXPPMiSy59wM5Qv0G0cYXZJIRxisSwoVcqLq9rnW8HZbt
	UYhY3isK5ish0pPxo89s7f75+sg+mu1yQeGt5nrJlpB9uLBv4xNkXh6WKl127HMi
	3upr1ENJZmsVKGciJImom9JAdXmoRCvUUK4Sq2hrNIoMOrKtn5An8ncZt7L6/OT6
	PR1gOcTBDnNPtaoiZbBT7S58cNmHLIsPg2dxEnIwQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b8uh619vg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Dec 2025 21:22:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BQI1DLq001965;
	Fri, 26 Dec 2025 21:22:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j8axk5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Dec 2025 21:22:16 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BQLMGxn010116;
	Fri, 26 Dec 2025 21:22:16 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4b5j8axk5n-1;
	Fri, 26 Dec 2025 21:22:16 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v4 1/1] NFSD: Track SCSI Persistent Registration Fencing per Client with xarray
Date: Fri, 26 Dec 2025 13:21:36 -0800
Message-ID: <20251226212213.1385803-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-26_06,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512260200
X-Proofpoint-GUID: 5UkwvXeWVi2MCKPPWi8XFA8H94T4D4gS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI2MDIwMSBTYWx0ZWRfX1ZdeqFbQNTdd
 RwhfPkv+tdNfBIeIX5BZShD+v77DV+lm9KVayVW/TJMBI2ikheOO47E3VrItXpNepDO5GjnZAFa
 sOUAYGx/hl8RrCFkVhrs2g1fPmbSvHLKaVg3585G3d0dquTR/Luyol+hk73yLTM3jclrktEgVGv
 V6fM+pOCvocG8LI5Hth/yasxqjONzbX5b4b2qqWNajlWaui3Ym07wMAiEc50iWqBoiKDjWoQ6Ak
 q9pgKjSeelpyH79rd+ZWAjs9azcxMEqIVsuQvcTwtVi6Zxe/OBi7jzuvMru1Y5m6rxVVNGyd/Br
 aCaP1YWQ1XplnCeMAlE1kW3XT2+4zANvgOo4V8dOAoypWtpSmb05gtdRsqmKeWr4YRHPoDJ2Wqi
 JFkz6vSfPeppEXG3Gn57ppKp68I9dljzxgFUaWR4tbQQHNkTeGgBV3Idp+rMgrS4f4H3I+nKgpl
 dBvR76SkU9P90xtQUkA==
X-Proofpoint-ORIG-GUID: 5UkwvXeWVi2MCKPPWi8XFA8H94T4D4gS
X-Authority-Analysis: v=2.4 cv=bdVmkePB c=1 sm=1 tr=0 ts=694efc89 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=Pq3YVZI4kFLPTmon__UA:9

Update the NFS server to handle SCSI persistent registration fencing on
a per-client and per-device basis by utilizing an xarray associated with
the nfs4_client structure.

Each xarray entry is indexed by the dev_t of a block device registered
by the client. The entry maintains a flag indicating whether this device
has already been fenced for the corresponding client.

When the server issues a persistent registration key to a client, it
creates a new xarray entry at the dev_t index with the fenced flag
initialized to 0.

Before performing a fence via nfsd4_scsi_fence_client, the server
checks the corresponding entry using the device's dev_t. If the fenced
flag is already set, the fence operation is skipped; otherwise, the
flag is set to 1 and fencing proceeds.

The xarray is destroyed when the nfs4_client is released in
__destroy_client.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/blocklayout.c | 33 +++++++++++++++++++++++++++++++++
 fs/nfsd/nfs4state.c   |  6 ++++++
 fs/nfsd/state.h       |  2 ++
 3 files changed, 41 insertions(+)

V2:
   . Replace xa_store with xas_set_mark and xas_get_mark to avoid
     memory allocation in nfsd4_scsi_fence_client.
   . Remove cl_fence_lock, use xa_lock instead.
V3:
   . handle xa_store error.
   . add xa_lock and xa_unlock when calling xas_clear_mark
V4:
   . rename cl_fenced_devs to cl_dev_fences
   . add comment in nfsd4_block_get_device_info_scsi

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index afa16d7a8013..e4c63e07686c 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -318,6 +318,7 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
 	struct pnfs_block_volume *b;
 	const struct pr_ops *ops;
 	int ret;
+	void *entry;
 
 	dev = kzalloc(struct_size(dev, volumes, 1), GFP_KERNEL);
 	if (!dev)
@@ -357,6 +358,20 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
 		goto out_free_dev;
 	}
 
+	/*
+	 * Create an entry for this client with the fenced flag set to 0.
+	 *
+	 * The atomicity of xa_store ensures that only a single entry
+	 * is created for each device. The maximun number of entries
+	 * in this array is determined by the number of pNFS exports
+	 * accessed by this client that use the SCSI layout type.
+	 */
+	entry = xa_store(&clp->cl_dev_fences, (unsigned long)sb->s_bdev->bd_dev,
+				xa_mk_value(0), GFP_KERNEL);
+	if (xa_is_err(entry)) {
+		ret = xa_err(entry);
+		goto out_free_dev;
+	}
 	return 0;
 
 out_free_dev:
@@ -400,10 +415,28 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
 	struct nfs4_client *clp = ls->ls_stid.sc_client;
 	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
 	int status;
+	void *entry;
+	XA_STATE(xas, &clp->cl_dev_fences, bdev->bd_dev);
+
+	xa_lock(&clp->cl_dev_fences);
+	entry = xas_load(&xas);
+	if (entry && xas_get_mark(&xas, XA_MARK_0)) {
+		/* device already fenced */
+		xa_unlock(&clp->cl_dev_fences);
+		return;
+	}
+	/* Set the fenced flag for this device. */
+	xas_set_mark(&xas, XA_MARK_0);
+	xa_unlock(&clp->cl_dev_fences);
 
 	status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
 			nfsd4_scsi_pr_key(clp),
 			PR_EXCLUSIVE_ACCESS_REG_ONLY, true);
+	if (status) {
+		xa_lock(&clp->cl_dev_fences);
+		xas_clear_mark(&xas, XA_MARK_0);
+		xa_unlock(&clp->cl_dev_fences);
+	}
 	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
 }
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 808c24fb5c9a..12537e0a783f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2381,6 +2381,9 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name,
 	INIT_LIST_HEAD(&clp->cl_revoked);
 #ifdef CONFIG_NFSD_PNFS
 	INIT_LIST_HEAD(&clp->cl_lo_states);
+#ifdef CONFIG_NFSD_SCSILAYOUT
+	xa_init(&clp->cl_dev_fences);
+#endif
 #endif
 	INIT_LIST_HEAD(&clp->async_copies);
 	spin_lock_init(&clp->async_lock);
@@ -2537,6 +2540,9 @@ __destroy_client(struct nfs4_client *clp)
 		svc_xprt_put(clp->cl_cb_conn.cb_xprt);
 	atomic_add_unless(&nn->nfs4_client_count, -1, 0);
 	nfsd4_dec_courtesy_client_count(nn, clp);
+#ifdef CONFIG_NFSD_SCSILAYOUT
+	xa_destroy(&clp->cl_dev_fences);
+#endif
 	free_client(clp);
 	wake_up_all(&expiry_wq);
 }
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index b052c1effdc5..eead2b420201 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -527,6 +527,8 @@ struct nfs4_client {
 
 	struct nfsd4_cb_recall_any	*cl_ra;
 	time64_t		cl_ra_time;
+
+	struct xarray		cl_dev_fences;
 };
 
 /* struct nfs4_client_reset
-- 
2.47.3


