Return-Path: <linux-nfs+bounces-653-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3A7815215
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 22:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0495B215FE
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 21:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644D447F76;
	Fri, 15 Dec 2023 21:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n0+ay3uw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B81C48784
	for <linux-nfs@vger.kernel.org>; Fri, 15 Dec 2023 21:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFK83Mf018361;
	Fri, 15 Dec 2023 21:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=hVXnRhOi8YL1E9B851pb8gJAW6JjCP6leMcnT+RoUtg=;
 b=n0+ay3uwI4s644Lby8fbYdaRSJ7SBMYvgg9rbNNMu7U7QvrPsjxPMYvkVze2hszr+2P3
 N91Nv11YuoPAKu/MY6LMzEi+M9dAQDTvig+KYzURo9wyokbHx/84oLwdx086LjjN4r7w
 jylpyWHEhtE0YUC7UoY8SoxvBsqMjkKoI8bQcTHg0wvJnONeWCq2lNigFHj/1aQ97w+K
 hvOsHTdoEz8cUF9td1DWtFrZeAtS10xNwb8cVBtK/j9BM5y74M98g6YcX0UIX5R4a0XC
 M5iyfCydgt07xS2IoFRQSJSRYueTNP8T6eIPrQsuqO5LpZHkBy6E7ANjy6rMKd4Uq9/B RQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvf5ceed2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 21:47:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFKAjmW029890;
	Fri, 15 Dec 2023 21:47:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepchqn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 21:47:29 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BFLlSH0022773;
	Fri, 15 Dec 2023 21:47:28 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3uvepchqn0-1;
	Fri, 15 Dec 2023 21:47:28 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-nfs@stwm.de
Subject: [Patch 0/3 v2] Bug fixes for NFSD callback 
Date: Fri, 15 Dec 2023 13:47:14 -0800
Message-Id: <1702676837-31320-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=993 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312150152
X-Proofpoint-ORIG-GUID: OcNEokngZ9zhjTjUZf0P9BgW7lWpdh_g
X-Proofpoint-GUID: OcNEokngZ9zhjTjUZf0P9BgW7lWpdh_g
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

Here are some fixes for NFSD callback including one that addresses
the problem of server hang on reboot with 6.6.3 reported recently
by Wolfgang Walter <linux-nfs@stwm.de>:

0001: SUNRPC: remove printk when back channel request not found
0002: NFSD: restore delegation's sc_count if nfsd4_run_cb fails
0003: NFSD: Fix server reboot hang problem when callback workqueue

v2:
. patch 2/3:
    add reason to hold the flc_lock in commit message 
    add Fixes tag
---

 fs/nfsd/nfs4state.c  | 23 ++++++++++++++++++-----
 fs/nfsd/state.h      |  2 ++
 net/sunrpc/svcsock.c |  8 +-------
 3 files changed, 21 insertions(+), 12 deletions(-)

