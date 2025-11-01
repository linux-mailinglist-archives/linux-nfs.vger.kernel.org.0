Return-Path: <linux-nfs+bounces-15865-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A43C28572
	for <lists+linux-nfs@lfdr.de>; Sat, 01 Nov 2025 19:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79295189213E
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Nov 2025 18:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C56271A7C;
	Sat,  1 Nov 2025 18:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FFRBoIHW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B942FB963
	for <linux-nfs@vger.kernel.org>; Sat,  1 Nov 2025 18:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762021756; cv=none; b=RrLG0WgYQon2Rb9gsg5PMlddbXKOv5lM+Cun/WGdz1QGEY8HDle/g2uDYo13HjzO4VW9bwkANWXw6JebKFelLgR5SIXCMExCClLOHN6Qa41x9VVqDQ5kTJEKCPNkdwprBaCdPEbeGwPpR4FQLEtwK7ERtday8UcgudFegYgQQRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762021756; c=relaxed/simple;
	bh=yzg29q6eqGg/DloI83uOvTew0wD+Sj/0/4fqLqSOBSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOZYoXtd8TJIv8qDlXtJuXNqpW1RGEUz1JYsVAYue40OS5wG3vrqRHGO/ZvJ1jNfxLj2UHrJ4ifrTAiyVQ/Ygsanor8EwGqAK1b3g91KfNwjlumnxG1Jc+bkP6pA8J/ogUaSqc4+EDVC5ZLY4u68tQIF5iAb8guB8/uGYJN790Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FFRBoIHW; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A1IPQLC031641;
	Sat, 1 Nov 2025 18:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=4tObf
	pvv1lgjt7DNFMKrMoan7jpKoVQMElt/F4DJ+UY=; b=FFRBoIHWP0xZgLC+J4akv
	r9NQLmS6A+Y2I+YtiiaBQH8vWO66zvnVysSAT+JxIzWypQ4/CNw63RwWHHCRmZ7p
	ocqdVcq4LVl7wR8ijrhdGFNxd55erX4Q8H/yDKcnFwzuEIuB/lU2Ho6KgHajqQht
	BN8y+Ltwx0qX86hj47HRFzwycJ7Jkh3bQPThtrtL4k8hiP2nUK5XhYxfGsnX5Pgh
	uPj7XCptE8so/jveJsJ/dNG7EiZmEq0P5tXY3zrYADfiPUGTHQZupTKKk2uBO5h5
	tMEZrTTxRcIE36DTX6PNq6w/by4eL/huo7zfSQRZXO/FK0ZATfAI40NpkyHSWMZ6
	w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a5qf2r02m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Nov 2025 18:28:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A1Gw9vx007975;
	Sat, 1 Nov 2025 18:28:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58na8cwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Nov 2025 18:28:39 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A1ISbNS035467;
	Sat, 1 Nov 2025 18:28:38 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4a58na8cvp-2;
	Sat, 01 Nov 2025 18:28:38 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFSD: Fix problem with nfsd4_scsi_fence_client using the wrong reservation type
Date: Sat,  1 Nov 2025 11:25:18 -0700
Message-ID: <20251101182819.651120-2-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251101182819.651120-1-dai.ngo@oracle.com>
References: <20251101182819.651120-1-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-01_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511010159
X-Proofpoint-GUID: U5KOoKxTfeAXlQiBC-GrKswa-STOcJtw
X-Authority-Analysis: v=2.4 cv=HODO14tv c=1 sm=1 tr=0 ts=69065158 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=mu5SI4wEB297gwYIvLwA:9 cc=ntf awl=host:12123
X-Proofpoint-ORIG-GUID: U5KOoKxTfeAXlQiBC-GrKswa-STOcJtw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDE1OCBTYWx0ZWRfX2wsWlxJqU0SM
 qEpWZHsuO/aVe0nTPRyg+OcOiyLtbjMor5roX6ZAsR6ao9VGQTWVSoGxLOoHO+tmt2mGPt7yNVm
 n7f4wc84vZErW88b6B7HiolNwSS2nVS90qEcwvrCBsghp8a9jI4XYZdyazzGfD5clN7uRWViftw
 BYIOnjJJx3AOoYxqnhkVn79zi7CvQa70UXqkZrzrdKYPkiMWvhYzLGk+cq56GSmukE8T0CqOKZc
 zOBQHXrEns+NHxAOPna8xQzhUuayV7v0nbDzyNoJAvEBF/QJNElFt+XStrEg2+SKpIZrVrO/t8J
 DARaCCLhTLJ4LvfcVK5toKT6Or1awY+Yvvsh+9cApRYy9zD4sOr5SU9pyRanJCwHWLoN4+G9it6
 GeXUyho4uIBXiI5AUUpFyy7Oo5GwurYvMKzQB1dCdT1iIUCIRu8=

The reservation type argument for the pr_preempt call should match the
one used in nfsd4_block_get_device_info_scsi.

Fixes: f99d4fbdae67 ("nfsd: add SCSI layout support")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/blocklayout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index fde5539cf6a6..13ff7f474190 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -342,7 +342,7 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
 	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
 
 	bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
-			nfsd4_scsi_pr_key(clp), 0, true);
+			nfsd4_scsi_pr_key(clp), PR_EXCLUSIVE_ACCESS_REG_ONLY, true);
 }
 
 const struct nfsd4_layout_ops scsi_layout_ops = {
-- 
2.47.3


