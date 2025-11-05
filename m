Return-Path: <linux-nfs+bounces-16094-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7480FC37C73
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 21:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912813B1E30
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 20:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9559D2D8371;
	Wed,  5 Nov 2025 20:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QIU6b3Mk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090D92D6E5C
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762375682; cv=none; b=F2wCZYBCVIE/wTDQy0FhUFvgjpcesVj8d2v5YPz9LeBMBzulBrGyBkumfeh9O9krt88oRY0uhCbhhxCkeDdhF2MgWXHRGvKmHUKxc9+mC1UFSaDc9V59Uuh0K95jGoXLxztlxbGT/WSILmXVHvcpBoyUdooIICcHV4DBpydXWMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762375682; c=relaxed/simple;
	bh=AU84YS1pdYtY/ueyTGDUW4ZCL9G38C0p5IOpbcM7EU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FjVIIG4N5eHuzq08sNOC4FqqD0irps9/63UkZSAqzCvvQFzu4avGa6HoTvx1MXwr7LbZDuoYwsgWzZCM/jPty4za7ZH4Yz4FDAwhD4RMD7Ns8vgtfIeIzY+zaONyqWBJA9cGJT7+3wlohz12WTeJbWOD5TcidTDWDvNfv0nqrxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QIU6b3Mk; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5H4pwc014135;
	Wed, 5 Nov 2025 20:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=YgQOq
	/sy9XXcBCXs6bKpWhhizM43FsIkPGUl+bks58I=; b=QIU6b3Mka/Cm9wwcI8PT0
	dkjg0KI0ObrjdD/OchP/5ieU+4CK6zpqupCSzu4v9V0qpCbXw7+7yfJ4aoLuvicO
	fM2wlPz4EM9d2mGUScp8i7Tk/hpliRUbvMG1b4TaDAlPKh9Fsg93UN6hLNnRIfza
	5wDgEax/dyGrgXfrZYb+BKCZDuBg+USo4scejl1QkLE2dDPFGUQ23IlFkpn8qtF7
	04SmYVeajczd4Z91YouCE9QXMnCwXsmm+fiYb3UQkRbv88giy3b6CATl2M4w4IXJ
	/KhI9YTo/hNZNJpbBKVRgpMA8J0ZkdtHFHlXbGqxJl/1d1KzQ4Wjhw7v9z84HA+1
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8anjgfyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 20:47:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5JqUcS002651;
	Wed, 5 Nov 2025 20:47:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nf346q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 20:47:50 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A5KlnEi033889;
	Wed, 5 Nov 2025 20:47:50 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4a58nf345c-2;
	Wed, 05 Nov 2025 20:47:50 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/2] NFSD: use correct reservation type in nfsd4_scsi_fence_client
Date: Wed,  5 Nov 2025 12:45:54 -0800
Message-ID: <20251105204737.3815186-2-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251105204737.3815186-1-dai.ngo@oracle.com>
References: <20251105204737.3815186-1-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_07,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511050162
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzMyBTYWx0ZWRfX4KrWXDKGxf1k
 QmzRErqptSaK4TJ4KUDdFp+QxTmAn2bKij95LULbvfFrR0bnxW45nhuXazyw6osmqZhj5+ReyEw
 w2Hat8fSpD5l/DyTIC5Syr8k8HZcVvS7iLIYe9css0VNdU/e/xD6l0PwJSpcPCDh163oEj9mF+q
 7BbgVWrpveKBRdazKvaSj7MBSEafPXwTEhq0tdby3rW9GZ8v3QxH6IoaXw7DAf026csZWf82Jj0
 8+YwTfeLTc/Ag3Qxfm7xoMr31K7GW1LvoJEgANQ20f8DLU6WGgGpFHDXmcaaHNJiRhbeZI4fd55
 0c2gr3UujIJf866GC0AdmVCVj2RAVGj2BZ9S+ZqlnbUn3wsA5gZFeKlut4iXX52xkTiDSmp0ZUp
 nJFh1PBPQ8BAAGgOHoq+PsHno0wHvKBwvw0Nj2hwUCEvhGn5Liw=
X-Authority-Analysis: v=2.4 cv=dfqNHHXe c=1 sm=1 tr=0 ts=690bb7f7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=mu5SI4wEB297gwYIvLwA:9 cc=ntf awl=host:13657
X-Proofpoint-GUID: DhdGC3kpI2IbUFRlnsrIp5AlieHZf01w
X-Proofpoint-ORIG-GUID: DhdGC3kpI2IbUFRlnsrIp5AlieHZf01w

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


