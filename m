Return-Path: <linux-nfs+bounces-15765-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 946EDC1DAFE
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 00:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1436534C0FF
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Oct 2025 23:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A3A30FF25;
	Wed, 29 Oct 2025 23:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dMi8Ethl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BE72D0C90
	for <linux-nfs@vger.kernel.org>; Wed, 29 Oct 2025 23:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761780583; cv=none; b=aMogaY6hJHmvf455sU/ha5WAPgCYTkg89ZYCeM0AQN4qo1ocFor7+hHj9QiWAGUXm7EcttOCnwpW1mbfzGe6lKE3YugIqTOGUrTpiJwuU9/K8WWnKmOO7rhUNqN0xzx5UJoeJGTy8YY0BZFP7cxvNoqj23iRTw9bz7C/t/sLV88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761780583; c=relaxed/simple;
	bh=i7iaB+CsbA6PAZBmxfjiSiqAxFp5zis19DztMXSvHQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZsOERJ9iqUQiKKlMicQEtI+ofhG/PI8sVTX4MYm/3TzFljPAkQ0H5g8xP4sS01plzRtVETUgJqq9kFPHGvEabcHETl/l9n6B9P87uyPHIkJtMr48GhQXvrmAiS4x9GALJXHCPhyLBqDm9nIiWyvV9RnkK5SwSbIxXja7ZPMPCq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dMi8Ethl; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TKKHsP015226;
	Wed, 29 Oct 2025 23:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=HXPCt54gkJGrVs1oE3jr2+GjPHxxO
	akW8Ys3oqqDlWU=; b=dMi8EthlT4FnLsfOOYdrJR/vpS7CBiPLVhpL6T1sAPFrA
	mPEw+t+RhrFlUihN0cqSYskL4YLIf5z1j+t2L+1tIKoOxCMpP6lh8jwXkejZDqBM
	PV3ye93p1+XPZW6diloCL7c1ryTX1BUN2fHMuN82joBRWnpijGpNI3gxnXB+Twkh
	Rc8OR8WtAnO3GS1n2impuTTctb/+ZYN8z0mQvX7Dix1cIuHppQ6Sj9TZ8iTIvNtR
	2h6oPD2sgE+7bLQqtXhQ9UJCtPIxshb567KJBc9qUS45nf3LpNGDLXysFeta+JD7
	A1XOu2+47vtBBUxqAlqxztr+zgXpGKi38piDl4F9w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a33vxk77h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 23:29:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59TL3CdN011192;
	Wed, 29 Oct 2025 23:29:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33vxvbgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 23:29:28 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59TNTR2V038791;
	Wed, 29 Oct 2025 23:29:27 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a33vxvbgs-1;
	Wed, 29 Oct 2025 23:29:27 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSD: Fix problem with nfsd4_scsi_fence_client using the wrong reservation type
Date: Wed, 29 Oct 2025 16:28:26 -0700
Message-ID: <20251029232917.2212873-1-dai.ngo@oracle.com>
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
 definitions=2025-10-29_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510290189
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2MiBTYWx0ZWRfX9/XRGsEJZOPt
 cvC9+FrnHTsmdYUoFbF+TnaoM/NCC1JPFpklYpKxl1tDFHA0exzu/ypp+jhkRNB4VnGdFPD8qjB
 h/qPSb/6lHd8Svqze3tECjY7m4Yp4vVKacI94b3wqas6xBQtwrXLw0LARJAOz5/SyjqrX+ja0Mb
 CbTHq+pFd1Jrc8udT5MnsmERv9OHA8VOnaYk5bniapLzDVOOZt11lXfeBhy8Tk2bfGBJ5WTpf/i
 2SR6tjsV9/WCaBHcQDwdikgAVcOYfW2iayVTK5Se5MpQsFWE0WLx+nV6svBoHFLoXSuVLx7m1sQ
 5Oig8WCDe//WtQqvdMv/NTgrUMomJBQNYGREPHFjK0K/eJFMd8JQQlw74H6oEtSA2ZXEDZbyZDS
 nl2ic2QySLFfyspiVFEZtYT/aaICEw==
X-Authority-Analysis: v=2.4 cv=M/9A6iws c=1 sm=1 tr=0 ts=6902a358 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=xpbcDPnvV1YTWCZAQtMA:9
X-Proofpoint-ORIG-GUID: brfDGSZhIZ28Z_yM_VfyEKSZv07HZdZ6
X-Proofpoint-GUID: brfDGSZhIZ28Z_yM_VfyEKSZv07HZdZ6

The reservation type argument for the pr_preempt call should match the
one used in nfsd4_block_get_device_info_scsi. Additionally, the pr_preempt
operation only needs to be executed once per SCSI target.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/blocklayout.c | 17 +++++++++++++++--
 fs/nfsd/state.h       |  1 +
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index fde5539cf6a6..4ca6cb420736 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -340,9 +340,22 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
 {
 	struct nfs4_client *clp = ls->ls_stid.sc_client;
 	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
+	int error;
+
+	if (ls->ls_fenced)
+		return;
+	ls->ls_fenced = true;
+	error = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
+			nfsd4_scsi_pr_key(clp),
+			PR_EXCLUSIVE_ACCESS_REG_ONLY, true);
+	if (error) {
+		char addr_str[INET6_ADDRSTRLEN];
 
-	bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
-			nfsd4_scsi_pr_key(clp), 0, true);
+		ls->ls_fenced = false;
+		rpc_ntop((struct sockaddr *)&clp->cl_addr, addr_str, sizeof(addr_str));
+		dprintk("nfsd: failed to fence client %s error %d\n",
+			addr_str, error);
+	}
 }
 
 const struct nfsd4_layout_ops scsi_layout_ops = {
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 1e736f402426..1de4acc7d539 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -735,6 +735,7 @@ struct nfs4_layout_stateid {
 	stateid_t			ls_recall_sid;
 	bool				ls_recalled;
 	struct mutex			ls_mutex;
+	bool				ls_fenced;
 };
 
 static inline struct nfs4_layout_stateid *layoutstateid(struct nfs4_stid *s)
-- 
2.47.3


