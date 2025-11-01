Return-Path: <linux-nfs+bounces-15866-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A23BC285AE
	for <lists+linux-nfs@lfdr.de>; Sat, 01 Nov 2025 19:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0851A4E06F2
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Nov 2025 18:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE922FC887;
	Sat,  1 Nov 2025 18:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b3BaazHI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851A38528E
	for <linux-nfs@vger.kernel.org>; Sat,  1 Nov 2025 18:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762023163; cv=none; b=lLkvJm82u0myDZ9WfroXCXsF6HdWTlrfvcNDwbfISJIApWx7LmrozVr01nnY/Pbe2s/ePwhoCGr1qb+bEOu9w9qGBcIfB1/WyADtoT4EdEQIT2/PahBrNVrBkMhg1ga6ahVgnQOPTqwtVLEAXSkCYz65jML731cMuN8F2rxpiCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762023163; c=relaxed/simple;
	bh=yzg29q6eqGg/DloI83uOvTew0wD+Sj/0/4fqLqSOBSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZAzXgdJAEjqp7hkaGKS/5Ld6HjgQvQjUac9Ijjc6pEzZq7i0chr+FI+QoTQL+tli+66w95JDmWRPzGoEex/6qM5yBo8K2Dj8w0dUURvE0mTP1GwZIsEGp2aJF3BotwBMeuUKR6i1KNG5VBuSn3Gcc9afHQJqg2I+tPqDxnqgBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b3BaazHI; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A1IiV6l006480;
	Sat, 1 Nov 2025 18:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=4tObf
	pvv1lgjt7DNFMKrMoan7jpKoVQMElt/F4DJ+UY=; b=b3BaazHIIpilJ8BLKYY8A
	QMsqgey+ZFXF+Zn9CfAjCRsyytcDmJ9wwNPz6atFNu1pzXFSayeZ+B5N0QKxWD42
	vuLjYJ0UHZm3IzKmMLih/ZHnkbRrN5MtPmh7Rlc54A1zV2R4uOsjJkTKdBC6RlJV
	GI06Jq/CxFXEA+F9cx06Uw/706t1D4jfNKASRUb9Tsh4IAfl+nbCKCtF2FCU52fd
	pCufb3rxDh4pCVJqCti08uvQdwPXPPPIzUS6r6LvQNQbcEhXeuLOGrWbNACPvb0V
	kEIsGey7tMEsVK7/KObCQIWiH/G2IZCbGaCEIY1AmlyNDlH1u5hKyDeZa6RXpGwd
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a5qre00cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Nov 2025 18:52:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A1Hfa5l016031;
	Sat, 1 Nov 2025 18:52:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58n6ggm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Nov 2025 18:52:30 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A1IqTSe011363;
	Sat, 1 Nov 2025 18:52:29 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a58n6ggks-2;
	Sat, 01 Nov 2025 18:52:29 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFSD: Fix problem with nfsd4_scsi_fence_client using the wrong reservation type
Date: Sat,  1 Nov 2025 11:51:33 -0700
Message-ID: <20251101185220.663905-2-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251101185220.663905-1-dai.ngo@oracle.com>
References: <20251101185220.663905-1-dai.ngo@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511010162
X-Proofpoint-ORIG-GUID: Z-YEe1CVdtU71saHqknQDImFRTKp5SUf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDE2MSBTYWx0ZWRfX8igZzoFfRD4I
 lvyOi0Y6KEt7ZTKBpFEQvrmt/94y6wLLLYWxS6qyQYxNpHvfkOsK64+gA0/gFibEXLBH7lhn6EX
 +Arpghnnb3nsMgIuIfM7oV/kvdwjlwa5R/LnjU+icRZJnN+6LDHzDeMMswl8/+rUz4qHjO1v5DX
 MCQK0xycA/rxSFahn0iYkaQIJBwesymc6DD6tR2QoeGQANP6cMN4yeASvvm6WtjgtZVcgTQ06JC
 3c2uDgk4hUykJO0HfQIBWKCITb+YzTNw450kSMIW/FLNkZLh2ahWRb7RJ89qtt2ZWXMn5Sp2Iks
 n4XkVoxEkdIr52P68Zc/2+b/j17Ht0hySot5703Yyw5PcbRruybUxK537i3lWECqDrjVCpUbP5b
 Pt/U1fNbMtji1awMztp3vNP73+Cf7g==
X-Proofpoint-GUID: Z-YEe1CVdtU71saHqknQDImFRTKp5SUf
X-Authority-Analysis: v=2.4 cv=AMtU3n5w c=1 sm=1 tr=0 ts=690656ef cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=mu5SI4wEB297gwYIvLwA:9 a=cPQSjfK2_nFv0Q5t_7PE:22

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


