Return-Path: <linux-nfs+bounces-16021-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6571EC325B9
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 18:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25F63A9F2E
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 17:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A53F331A7C;
	Tue,  4 Nov 2025 17:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jUCQFQ5u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BC727F73A
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 17:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277493; cv=none; b=l8wXVs2v8jBHF6IF2ssT9xf/PbuM1bqS2TTZ1NEyYlSV8BMOYTctqZdt7l28re+P0I5ZCTX6yJcISyGq7BiW6/yNSPm0Kn0T5Uwmj6DNMrej00XU56iWWRfldiMGue15XCmnz/KpramSzOLY5Mo18qv38KK3o5YNfEjm4S0lh/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277493; c=relaxed/simple;
	bh=AU84YS1pdYtY/ueyTGDUW4ZCL9G38C0p5IOpbcM7EU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrEwqnUjv6CHU2p3uV9Nv1lXLcFF/KYXH3snABDwB8YsIZxBw3Q+GG61sspD9nfh8Ur2eWd+a8pFH+Jze75wiN47QNjigR/aDCoycEo/CV+8YLZ+aKWJtzD8SG15wBj40ifx8F9ttJqijiegvGHHzlSp6KUHPfPS4lVeJ3f3kvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jUCQFQ5u; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4HNNXg016007;
	Tue, 4 Nov 2025 17:31:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=YgQOq
	/sy9XXcBCXs6bKpWhhizM43FsIkPGUl+bks58I=; b=jUCQFQ5ulwxnLA3BhvStC
	YGUweWa3SSc2CYBpiROELfa86UHaEpKJTUrrVZoSZHJIitE/FmD9Vgvthi47yb3B
	Ox3isU4CZLJmAJgx+s4oO9QuxX43Hn9YIgbSqnUuEfZ8dfHx6TrnYz3wVK9useFO
	o4rvCK9/+iP9L9VCOLwwUnUfyXUFJ21REwpVI3k1LLWX4kxM5/ywYofwBhdaSVP4
	C1lsm/9QnDs22dKQYVj7nPZmG+P+dv0iG3c7W5S1o/tyQfXS1PpWdXcPQkCgxcCa
	ucqstnSzmm0pU4SwPBOicuMzUhqcS/vbP78URDKDNJzjVSRSnESrQlQ65zLdFAlp
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a7nmx01wp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 17:31:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4GiRlJ010082;
	Tue, 4 Nov 2025 17:31:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nddwp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 17:31:17 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A4HVFvm033666;
	Tue, 4 Nov 2025 17:31:17 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4a58nddwmf-2;
	Tue, 04 Nov 2025 17:31:16 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/2] NFSD: Fix problem with nfsd4_scsi_fence_client using the wrong reservation type
Date: Tue,  4 Nov 2025 09:27:25 -0800
Message-ID: <20251104173103.2893787-2-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251104173103.2893787-1-dai.ngo@oracle.com>
References: <20251104173103.2893787-1-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511040146
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE0NCBTYWx0ZWRfX4CPjG875eMZS
 +duSmfbANvFoMCYlecfSijKeY7Z/BwlO/koaw5H15wL/JReqqyTRSXyIF3w+9KLQmHFMFUB7Ht6
 KJfJHrGJMTUFp/0BaptRmuyR/EcQiGUiPRKt2WjIHwk/gyZzR/AuolmQTcBhB1+dnXyWPhC7+7x
 K3B+sCmsx2BsR9j30wXlNlJGmBZetyMsGfs8jJBWa4FxSjF5qKAjzF5HNEYeirOlo8VuxFfPRhq
 AxpdcVQ+b+RmwYHItTTMFRPW8mDP4JBSqfInQj4xIcNdLwMG35B8VHYWhXM6qzGCs5BfASidaRD
 PdgVST2/W4Ao1Atznvm0WP5xQy5BzQ3ZhjIO/w8UEwfRB4jlbt1Au2XqXa9GPhtBCWMoVVjQVkP
 Pr4v8Q5k7MaUHdJI/+SqYB0/e2LvLzpQ5zoOi/3MihEZMI9yUgI=
X-Authority-Analysis: v=2.4 cv=LtWfC3dc c=1 sm=1 tr=0 ts=690a3866 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=mu5SI4wEB297gwYIvLwA:9 cc=ntf awl=host:12123
X-Proofpoint-ORIG-GUID: WP6jIQbjabVe5K6lMXEMbRVuoNtAlo6d
X-Proofpoint-GUID: WP6jIQbjabVe5K6lMXEMbRVuoNtAlo6d

The reservation type argument for the pr_preempt call should match the
one used in nfsd4_block_get_device_info_scsi.

Fixes: f99d4fbdae67 ("nfsd: add SCSI layout support")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/blocklayout.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index fde5539cf6a6..815c6e0cde5e 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -342,7 +342,8 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
 	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
 
 	bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
-			nfsd4_scsi_pr_key(clp), 0, true);
+			nfsd4_scsi_pr_key(clp),
+			PR_EXCLUSIVE_ACCESS_REG_ONLY, true);
 }
 
 const struct nfsd4_layout_ops scsi_layout_ops = {
-- 
2.47.3


