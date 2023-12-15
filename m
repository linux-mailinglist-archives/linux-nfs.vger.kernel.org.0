Return-Path: <linux-nfs+bounces-634-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94985815012
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 20:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABDCD1C20371
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 19:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B3E3011D;
	Fri, 15 Dec 2023 19:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="agRjOQPn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E943FB30
	for <linux-nfs@vger.kernel.org>; Fri, 15 Dec 2023 19:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFI4PgS004793;
	Fri, 15 Dec 2023 19:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=jHjgCqefirI6ZttFuaMzvKnAqt3QcMkiO3x2cihQBs0=;
 b=agRjOQPnFWmDVlTbLT6olj3UWj3gylXwN5G7FLZ4A28d4vxupcjvoszjwXYgiRrsdFje
 d2d1nyQmsyMPDIhK+SmMp3n0VOBheee0cFd5UyOtnVQmUKgxKLbtrkxLkn5aV50wGnqA
 nBKOmIvhnyiplw5ZM0F+vRgLRb7Hs1GU9MQPiIv+eryUIGg6xewiKiw5NqMe0M3tlXcI
 UPMOUxgQnv6jDxFvKkx1JHJpzruwSIvU3i4ja8KraWrwZlccW71IH9m9Qrc1t0TYmur+
 zzXrG6EHwa+1Hu3gezXA4i8L4qFc2WpyN6FhtGys1IFoRYgZEVpPrANU317+0NlU5+fC Cg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ux5dfaryd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 19:15:24 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFIFVbs017052;
	Fri, 15 Dec 2023 19:15:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepcfqn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 19:15:23 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BFJEAbQ013855;
	Fri, 15 Dec 2023 19:15:23 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3uvepcfqmh-1;
	Fri, 15 Dec 2023 19:15:23 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-nfs@stwm.de
Subject: [PATCH 0/3] Bug fixes for NFSD callback
Date: Fri, 15 Dec 2023 11:15:00 -0800
Message-Id: <1702667703-17978-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312150135
X-Proofpoint-GUID: DKISvXwllM3rn2n0Woqlv-XSKShOf4Eq
X-Proofpoint-ORIG-GUID: DKISvXwllM3rn2n0Woqlv-XSKShOf4Eq
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

---

 fs/nfsd/nfs4state.c  | 23 ++++++++++++++++++-----
 fs/nfsd/state.h      |  2 ++
 net/sunrpc/svcsock.c |  8 +-------
 3 files changed, 21 insertions(+), 12 deletions(-)


