Return-Path: <linux-nfs+bounces-15862-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DA3C28569
	for <lists+linux-nfs@lfdr.de>; Sat, 01 Nov 2025 19:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDFA14E1646
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Nov 2025 18:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9102FB973;
	Sat,  1 Nov 2025 18:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QizEv1GC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781C82FB620
	for <linux-nfs@vger.kernel.org>; Sat,  1 Nov 2025 18:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762021737; cv=none; b=Mdazh9LqkGg2qeAb2v3JT/YUKOLb+IGv5kklgYkHHIn3kgc7HGJ2L3ci5+XdjDuKWw5ymkx6SrDii4w9sMVCCRuMGhaFadiJFX/ZwcKnEBK0hUlho/05zgbHwJqgLPdMxOj17Dt66fIagr9fvCFX49Hj3auj+tYUKGRDJqeo+zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762021737; c=relaxed/simple;
	bh=NIVbLEhNWVwr/9ZA+xZBrNJEuPJ5/VLt4/GlyzuGbq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BxoqzuclaK4QxLwIQIVetVcY3xDy9wFn51GN1+XHcQaQAlWfGNLet+Y94tsgND8UypVO+bXGq0GD7aZkwmw8qpL4zpXvStMwwhg3qirjqBchGXDliGfHkrRpO/l4YplwCLF65KHXzE3nxdq7zGGdhTshWjiKqZzTqoab0Lxdvew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QizEv1GC; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A1IK2Pj027192;
	Sat, 1 Nov 2025 18:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=N2fivM2ihdx2bL6i8Mmj3tHTgD6SF
	tx7LTqzcujj4Oo=; b=QizEv1GCTBE3CQJx46plNtYvqKRCD3l8rk5W4QwKakNiA
	GSj/nISk2iySrup5quzuZRBqM7p/uPUKD7pSf9QrREFKQCI0au+IU8NYZO6e+ovB
	WcrdDvcaeAk9i06agUuWOYu5rrBMXYJ8w0aNrUjCmJr4YIavZgK3cIyVU1uxKZXh
	xMlyPFOQC2THIjEvGYqdlImP/80R5YBtqeyBulyHiStKKTC33HJFpX+R69hSzh28
	N7XKV5GS1uvOYWJB873AaR/JF7quFBt9PE35+hpvwF1l05a+1HLttXfAjGgc6tg/
	cuzbPs/dFrZOcuY8bLA9pIfNC1VanaGOEEfY+5IaA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a5qcq8055-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Nov 2025 18:28:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A1GfhBr007394;
	Sat, 1 Nov 2025 18:28:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58na8cw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Nov 2025 18:28:38 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A1ISbNQ035467;
	Sat, 1 Nov 2025 18:28:37 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4a58na8cvp-1;
	Sat, 01 Nov 2025 18:28:37 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: 
Date: Sat,  1 Nov 2025 11:25:17 -0700
Message-ID: <20251101182819.651120-1-dai.ngo@oracle.com>
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
 definitions=2025-11-01_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511010159
X-Proofpoint-ORIG-GUID: fLU97DT2ZpDet2CT4n0WvaD76vZFb0Lx
X-Proofpoint-GUID: fLU97DT2ZpDet2CT4n0WvaD76vZFb0Lx
X-Authority-Analysis: v=2.4 cv=LZ4xKzfi c=1 sm=1 tr=0 ts=69065157 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=I-1mG6jRAAAA:8 a=20KFwNOVAAAA:8 a=SEc3moZ4AAAA:8 a=5KiepZ0alBbxxWZTZwgA:9
 a=xo5jKAKm-U-Zyk2_beg_:22 a=vAntc5lzOlbkVmf1VcWC:22 a=5oRCH6oROnRZc2VpWJZ3:22
 cc=ntf awl=host:12123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDE1NyBTYWx0ZWRfX/PrZ3mMbkKqA
 qpA7sGUMUoVQAtk/4pShFKMhw/yEfgvMb8lCU9CW2N+3RQnjvsefOAnuiB8PON66CeFJjN7S7TA
 uM5vhl+coZdxFS+OJ0OSmZqsaSY40Ku45mQ0fkLb3TU/ZetfdM8jtPew+BVX+RzHcEaevvPf7p0
 u/ec5wViibPb1NK58Uu9kI+r2M/9JaZtb/mAh7Go/fGr01sLHSQJgWvdOmj2q/aGCJhe5F7BwVi
 +KuhWaT8Ih5m8YLqeFHuLmTg4KcBbCOyYuuxqXgOkXj9w2MR9MFlO1AK2qW6I2qMrB6VaXAp41b
 u4zrt2EncwaCl02m6MGIyOTb4LMRdehHlCRv+Lesc2So0C2Otoyg53seyosA2YFr0v7p4WadM9O
 jCA+wXd55augcs4mc69h+DmJyDCEnAMvYTJHZJjoj55Nxzu1+MI=

From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com,jlayton@kernel.org,neilb@ownmail.net,okorniev@redhat.com,tom@talpey.com,hch@lst.de
Cc: linux-nfs@vger.kernel.org
Bcc: Dai Ngo <dai.ngo@oracle.com>
Reply-To: 
Subject: [PATCH 0/3] NFSD: Fix problem with nfsd4_scsi_fence_client using the wrong reservation type
In-Reply-To: 

This patch series includes the following:

. Fix problem with nfsd4_scsi_fence_client using the wrong reservation type.
. No need to fence the client when server receives NFS4ERR_RETRY_UNCACHED_REP.
  This error means the client has seen and replied to the layout recall.
. Add trace point to track SCSI preempt operation.

 fs/nfsd/blocklayout.c |  7 +++++--
 fs/nfsd/nfs4layouts.c |  6 ++++++
 fs/nfsd/trace.h       | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 2 deletions(-)



