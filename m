Return-Path: <linux-nfs+bounces-16093-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FB5C37C70
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 21:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7170518C6A9C
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 20:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8521A2D8379;
	Wed,  5 Nov 2025 20:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iyafQgDP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090502D6E59
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762375682; cv=none; b=UA1HbErToMDNdEfWNaUPPM5LJMUETErUytV1OUOcvUXcpnJ3dIcyuI00mS3L+GeXdw9h4n7bS6Xqdew2E0l10Q7o6ppgoRffNOnYbx22aZzO3WCnxkX60fg6XcncP/OKc6SoamRWgbTlCd8E5eS2z8F9542kDdBHKUqq5zVg1Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762375682; c=relaxed/simple;
	bh=RauDvOet+j0A+VYMIFEtRSVAMQ3zRP2te1BHGivLP3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eip505QJYUAVtIxZJVokj+h2Jh0O1ieiLPhuf8/U44U/f77L59qVNjH2HkAR9ASTrgST6MXquDApxxw+aII6nYLd8Daqoqdt2wG9mZ7EoJkeUEFsCKueV7bithGlAVWGs3ccoGNR+u96ON3NMywSxUW60tvfImuADnFCTQXRSxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iyafQgDP; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5HA2IE018596;
	Wed, 5 Nov 2025 20:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=t89+HI2DZX9lKm17Fkspp/g9CJHSr
	at4uctv3ve/lY0=; b=iyafQgDP9fNwzUInddY7Do5MbDflTSdkxzXIKwyS1foUS
	dj828cR6pg5Pi2tT694sYAsXfBhxYq5R1KLdK8F9EZrizxhQ7sftgLdgNLgj8Oph
	MWmHaU/rmef/AzzM2ojQlaj0mBhNeCqP7pELiKSfyE8g+jPJgqnUKutYeduLchgJ
	NNKfrQ/egwNofQC1nXRLJzgr/qZQVD++oVvdbvsmvw4C0KupJYdvw8o7tOI7KJ7Y
	OWtAVI0m9XVPO74ODt+FW0iXhfGL0rrVrI1+PafW+4ke++x9btsssPcWpHT1l13b
	Xa614jHJc1JEc7qpJLJT3ZkOOcnmd+oD2ZQ2R0twg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8aqw8fxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 20:47:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5K1fVf002723;
	Wed, 5 Nov 2025 20:47:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nf3466-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 20:47:49 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A5KlnEg033889;
	Wed, 5 Nov 2025 20:47:49 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4a58nf345c-1;
	Wed, 05 Nov 2025 20:47:49 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v3 0/2] NFSD: Fix problem with nfsd4_scsi_fence_client
Date: Wed,  5 Nov 2025 12:45:53 -0800
Message-ID: <20251105204737.3815186-1-dai.ngo@oracle.com>
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
 definitions=2025-11-05_07,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=932 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511050162
X-Authority-Analysis: v=2.4 cv=NajrFmD4 c=1 sm=1 tr=0 ts=690bb7f6 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=vwvN4hcQ-1Vlz0ZMyMEA:9 cc=ntf
 awl=host:13657
X-Proofpoint-ORIG-GUID: KJFD_PyJAvdhr-23NCoUCnB-G4DcIvvB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzMyBTYWx0ZWRfX0cwrBK6uOh8L
 O35eW535dTiKwSyjtY/dQYI412QoJVW62I3bM+GSVK3SC7xYrGKS3Dsay47Sshb6Q09YNrn+epb
 M3LjQlrEYqRg5KKgis9i3EmrBwdYv5EmVT7GgMAOMU5kQrwFpV4MlYzjXJ+9yJWPacJQS9p3S4d
 mTNZRT53ft2U0uRAPEcpX8142YKH3f4tESSJzATiaW25Io6Hq9o15b+WtoXUoAwYA5hjjkUZhrY
 fePvcL+8CUn1Zz6ZMuC3CGXXg5pPS90IAXPxcigzWaJzWJM5aRUGuGQY0QKU3WCslCZghZ2ha1b
 1MrqMTMQAt3ZUJktt3jiSzkG/EFdZsrFnDIedH0xVPMKEmPZrUr8v2StB8GL2eBFWTF/6AiUqQk
 JFkGYeAqPLSyHW1zNFYSJ0DO16Tv05FkPNG1K5Vo0BnadAwCyW8=
X-Proofpoint-GUID: KJFD_PyJAvdhr-23NCoUCnB-G4DcIvvB

This patchset includes the following:

. Fix problem with nfsd4_scsi_fence_client using the wrong reservation type.
. Add trace point to track SCSI preempt operation.

v2:
. drop patch that skips fencing on NFS4ERR_RETRY_UNCACHED_REP
. add namespace number in output of fencing trace point

v3:
. reword title of patch 1/2

 fs/nfsd/blocklayout.c |  8 ++++++--
 fs/nfsd/trace.h       | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 2 deletions(-)

