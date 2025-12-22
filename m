Return-Path: <linux-nfs+bounces-17251-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C785FCD48C6
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Dec 2025 03:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D79A300A30A
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Dec 2025 02:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274EA2FE582;
	Mon, 22 Dec 2025 02:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ffpxAW0H"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1E72F49F1
	for <linux-nfs@vger.kernel.org>; Mon, 22 Dec 2025 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766369434; cv=none; b=PIlLJsTcL7/hJvkDlFaHiD3HSQH49zWPQA8LsPd1TsqDoBPsigSIc8mk55DCHbvFVT/9ul7X8WgBHIiq8JoSaE4lwwha0JxiJjbfiixb4GLmjkeZRVL01aDBY9dJlBr3T5w08l9UfipK1/LRDQm70n0qbLTyR/SDA+AD104AsnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766369434; c=relaxed/simple;
	bh=bWuCPVoeVHoX5Xp/1OJjfmlFU6pWna+9cLpQ2Vmc4qI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LhJ01d3Zn4MkjyRzteaRp6npDtK8NWdp+lunf/ZfeB8iGk34GlI7pOVzSBeQQovcsrxxVieVLQk886RyyjfbTKE/Mc57LZMwhtSd/ZxK4DBRc85VoKFwtYQvD97FUs5S/6ZC8vAlHL63cbkRTXgG2+mdLjEzSwrrAR7/cyxesno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ffpxAW0H; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BM1OG4a1150627;
	Mon, 22 Dec 2025 02:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=mPB43oAOJxU7YoXNMYrE7D/2SYSmm
	g6X0ydoDhWWnrs=; b=ffpxAW0HDKtrndw+TJOhfT1NA9UGAteUNGBg6mWtwgWRJ
	XX2kBFjN7YNKCYj5OHDzZBf7/33L6DUANW0BgQYdS0Fe+rHGykcDvp41GgpasTKc
	z8ZpKUOB8nc2irBziEr9BRdR98c36kl9yCHIv6k8GwVM7YdEIpkq59kmsZUIUBt7
	DwzxnNNuL+2oQGJ6na/g+LU/7YfVqa3i1EaLiF2wQRZOXlO6eP5glksEE9Fy24T0
	R6IOZlR53d3lTdmaw9fHgezTTgeD6zHl/2CaR7eeGD6F/3A7vkwQV58MESWyu0Yv
	aDrDkmURfABavSKqcg7DKbhXpBP6GenNZJ0TMGTUA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b6v9w014m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 02:10:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BLMkMUl036979;
	Mon, 22 Dec 2025 02:10:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j86tsf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 02:10:05 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BM2A4UG028733;
	Mon, 22 Dec 2025 02:10:04 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4b5j86tsf0-1;
	Mon, 22 Dec 2025 02:10:04 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/3] NFSD: Track SCSI Persistent Registration Fencing per Client with xarray
Date: Sun, 21 Dec 2025 18:09:29 -0800
Message-ID: <20251222021002.165582-1-dai.ngo@oracle.com>
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
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512220017
X-Authority-Analysis: v=2.4 cv=Qatrf8bv c=1 sm=1 tr=0 ts=6948a87d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=Y9OclLuYqvMY4-K9HkwA:9
X-Proofpoint-GUID: SvtykyOTRPnDLDCV22xomULdqbR670MO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDAxNyBTYWx0ZWRfXxXUaZy2+F8pH
 S894l4luo5PLQ71JUuxFS0mYH78UPM53/eM2o6nOV98eDwlyC4+70hYTcEfkitAZYFFJkeaYjXB
 hUtYcmQU6xic5p74QWafPOELqHCG4YrgoateA+lKmbtoM6zELnWv0MpGIi/UbWRWN86AgobeOPc
 GML+oZJgP/ihlf7FuO2cCWr+OyZ9R2/FxGb9eKjsWQlxhf9s4p2Rphhw8aQuDShFecmNqiN5vW2
 /9xr63FX4C4vbgc9iynRCt9eXEkXJS5FV4Chm2sNR4iBjfSnCdfa3XqBRAJip62oyyfDJwbOrYw
 ugnVK2t5g7RaptDzr7Tpt+qoLNSXasioePTgR6kPFZjJ5BJo7F46fiOKOLjo1EO/yXW8Nq3M8fk
 YYPE5bHPL3p0umV4ONatCfHYwnSsXo7yZTJSXtRBpGKmuj183tJNas+tX2cTQAGAJ23W7xXnF7E
 XsxoMpWVkaGf2KOUpJQ==
X-Proofpoint-ORIG-GUID: SvtykyOTRPnDLDCV22xomULdqbR670MO

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
 fs/nfsd/blocklayout.c | 18 ++++++++++++++++++
 fs/nfsd/nfs4state.c   |  6 ++++++
 fs/nfsd/state.h       |  2 ++
 3 files changed, 26 insertions(+)

V2:
   . Replace xa_store with xas_set_mark and xas_get_mark to avoid
     memory allocation in nfsd4_scsi_fence_client.
   . Remove cl_fence_lock, use xa_lock instead.

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index afa16d7a8013..348083488823 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -357,6 +357,9 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
 		goto out_free_dev;
 	}
 
+	/* create a record for this client with the fenced flag set to 0 */
+	xa_store(&clp->cl_fenced_devs, (unsigned long)sb->s_bdev->bd_dev,
+				xa_mk_value(0), GFP_KERNEL);
 	return 0;
 
 out_free_dev:
@@ -400,10 +403,25 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
 	struct nfs4_client *clp = ls->ls_stid.sc_client;
 	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
 	int status;
+	void *entry;
+	XA_STATE(xas, &clp->cl_fenced_devs, bdev->bd_dev);
+
+	xa_lock(&clp->cl_fenced_devs);
+	entry = xas_load(&xas);
+	if (entry && xas_get_mark(&xas, XA_MARK_0)) {
+		/* device already fenced */
+		xa_unlock(&clp->cl_fenced_devs);
+		return;
+	}
+	/* Set the fenced flag for this device. */
+	xas_set_mark(&xas, XA_MARK_0);
+	xa_unlock(&clp->cl_fenced_devs);
 
 	status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
 			nfsd4_scsi_pr_key(clp),
 			PR_EXCLUSIVE_ACCESS_REG_ONLY, true);
+	if (status)
+		xas_clear_mark(&xas, XA_MARK_0);
 	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
 }
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 808c24fb5c9a..2d4a198fe41d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2381,6 +2381,9 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name,
 	INIT_LIST_HEAD(&clp->cl_revoked);
 #ifdef CONFIG_NFSD_PNFS
 	INIT_LIST_HEAD(&clp->cl_lo_states);
+#ifdef CONFIG_NFSD_SCSILAYOUT
+	xa_init(&clp->cl_fenced_devs);
+#endif
 #endif
 	INIT_LIST_HEAD(&clp->async_copies);
 	spin_lock_init(&clp->async_lock);
@@ -2537,6 +2540,9 @@ __destroy_client(struct nfs4_client *clp)
 		svc_xprt_put(clp->cl_cb_conn.cb_xprt);
 	atomic_add_unless(&nn->nfs4_client_count, -1, 0);
 	nfsd4_dec_courtesy_client_count(nn, clp);
+#ifdef CONFIG_NFSD_SCSILAYOUT
+	xa_destroy(&clp->cl_fenced_devs);
+#endif
 	free_client(clp);
 	wake_up_all(&expiry_wq);
 }
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index b052c1effdc5..8dd6f82e57de 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -527,6 +527,8 @@ struct nfs4_client {
 
 	struct nfsd4_cb_recall_any	*cl_ra;
 	time64_t		cl_ra_time;
+
+	struct xarray		cl_fenced_devs;
 };
 
 /* struct nfs4_client_reset
-- 
2.47.3


