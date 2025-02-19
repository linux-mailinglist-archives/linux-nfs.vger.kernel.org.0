Return-Path: <linux-nfs+bounces-10198-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DB7A3C9BD
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Feb 2025 21:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 222BB3ACE56
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Feb 2025 20:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008A523027D;
	Wed, 19 Feb 2025 20:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HpRYeOz3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D67D2356B5
	for <linux-nfs@vger.kernel.org>; Wed, 19 Feb 2025 20:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996891; cv=none; b=XmRwsWke3QKeBse+QxLG2/RZ8tHSXqRtD4AZw5NM817Z+Fadz1p4lpa/6H5c6BEqMtic2Au0h6W/KgQeIdAEKnpMkeBIrsLqXRly3tylm4FpqprVOZhWkvD6K8jmpSRzUg/HpoCwyGe/roISW6JlI2TW1PeC/MlwBjAvbgP0Nuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996891; c=relaxed/simple;
	bh=RPlS6guvX9ILH9ac7doTq/LLHtilMiW16VRWPmfwDv4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kd3H38feNavvWG+UThK8ahvCmW0MRdaWSoabeLN7oCZqBmEQPfSFlQLkg+WuP7P2xtg8Xht4iiIPviLDEhPWySInNCB7t6SyYxdJdjU+44SvMmllyjs/ZH6m3E9KOFSG8L73CqHqR/y4ZSu7RB6qFSHdxtkASHjxxlw7FxQLrW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HpRYeOz3; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JJNfLe009408
	for <linux-nfs@vger.kernel.org>; Wed, 19 Feb 2025 20:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=nn1ZPJmg194S7c2PBeTO87lLVq8Tg
	jGdDScIsXjf+W8=; b=HpRYeOz3JZEuk11MOI4krmQBql8JgWIMA+N0Twszt6qSI
	DLKZ1NtTBr9TPkVabf4++4va54bHaipd1uGDXYQSXr2opUy+npxnnhIFa8DE+k7H
	ftwbHc3RWnpyHT7/BMH156+LCDdKzhv2YAPlF45JRVFCaVUhgys3UfretDfYGWWE
	erauDEOT5I5vAy+gGtJSpEUbUqc57rwIsO92AU1yuImv4CN4A33rqxx+ykyrJTuK
	jMLV/BqSsxRTx3ioCFcew4EzPRlCTjJBg+M28ZTbso4UE4u8hQgoYie7WPq0Qfqx
	/waGHgTt1zdnLLuc3yMB62MS8Bh1lSrdbJP5+HY7A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00njnqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Wed, 19 Feb 2025 20:28:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51JIj6ix012019
	for <linux-nfs@vger.kernel.org>; Wed, 19 Feb 2025 20:28:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w0b308c8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Wed, 19 Feb 2025 20:28:05 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51JKKlcr011112
	for <linux-nfs@vger.kernel.org>; Wed, 19 Feb 2025 20:28:05 GMT
Received: from vm-ol9.uk.oracle.com (dhcp-10-154-40-131.vpn.oracle.com [10.154.40.131])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44w0b308aq-1;
	Wed, 19 Feb 2025 20:28:04 +0000
From: Calum Mackay <calum.mackay@oracle.com>
To: linux-nfs@vger.kernel.org
Subject: [PATCH pynfs] update maintainer info in setup calls
Date: Wed, 19 Feb 2025 20:27:25 +0000
Message-ID: <20250219202757.14150-1-calum.mackay@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_08,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502190155
X-Proofpoint-GUID: cC9ZmoaH6mnbdAa-4NK1KnXvgkhZi4rv
X-Proofpoint-ORIG-GUID: cC9ZmoaH6mnbdAa-4NK1KnXvgkhZi4rv

There are a number of issues with the setup() calls; for now, adjust
the incorrect maintainer info.
---
 nfs4.0/setup.py | 4 ++--
 nfs4.1/setup.py | 6 +++---
 rpc/setup.py    | 6 +++---
 setup.py        | 6 +++---
 xdr/setup.py    | 6 +++---
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/nfs4.0/setup.py b/nfs4.0/setup.py
index 0f8380e51577..47e56259b06a 100755
--- a/nfs4.0/setup.py
+++ b/nfs4.0/setup.py
@@ -70,8 +70,8 @@ setup(name = "newpynfs",
       long_description = DESCRIPTION,
       author = "Fred Isaman",
       author_email = "iisaman@citi.umich.edu",
-      maintainer = "Fred Isaman",
-      maintainer_email = "iisaman@citi.umich.edu",
+      maintainer = "Calum Mackay",
+      maintainer_email = "calum.mackay@oracle.com",
 
       package_dir = {'': 'lib'},
       packages = ['servertests', 'rpc', 'rpc.rpcsec'],
diff --git a/nfs4.1/setup.py b/nfs4.1/setup.py
index bfadea15e679..d91928e3ef94 100644
--- a/nfs4.1/setup.py
+++ b/nfs4.1/setup.py
@@ -62,9 +62,9 @@ setup(name = "nfs4",
       # These will be the same
       author = "Fred Isaman",
       author_email = "iisaman@citi.umich.edu",
-      maintainer = "Fred Isaman",
-      maintainer_email = "iisaman@citi.umich.edu",
-      url = "http://www.citi.umich.edu/projects/nfsv4/pynfs/",
+      maintainer = "Calum Mackay",
+      maintainer_email = "calum.mackay@oracle.com",
+      url = "https://linux-nfs.org/wiki/index.php/Pynfs",
       license = "GPL"
       )
 
diff --git a/rpc/setup.py b/rpc/setup.py
index 922838f5cb90..ece1a9165cb4 100644
--- a/rpc/setup.py
+++ b/rpc/setup.py
@@ -54,9 +54,9 @@ setup(name = "rpc",
       # These will be the same
       author = "Fred Isaman",
       author_email = "iisaman@citi.umich.edu",
-      maintainer = "Fred Isaman",
-      maintainer_email = "iisaman@citi.umich.edu",
-      url = "http://www.citi.umich.edu/projects/nfsv4/pynfs/",
+      maintainer = "Calum Mackay",
+      maintainer_email = "calum.mackay@oracle.com",
+      url = "https://linux-nfs.org/wiki/index.php/Pynfs",
       license = "GPL"
       )
 
diff --git a/setup.py b/setup.py
index 203514d72c44..91890d6f38a2 100755
--- a/setup.py
+++ b/setup.py
@@ -36,9 +36,9 @@ setup(name = "pynfs",
       # These will be the same
       author = "Fred Isaman",
       author_email = "iisaman@citi.umich.edu",
-      maintainer = "Fred Isaman",
-      maintainer_email = "iisaman@citi.umich.edu",
-      url = "http://www.citi.umich.edu/projects/nfsv4/pynfs/",
+      maintainer = "Calum Mackay",
+      maintainer_email = "calum.mackay@oracle.com",
+      url = "https://linux-nfs.org/wiki/index.php/Pynfs",
       license = "GPL"
       
       )
diff --git a/xdr/setup.py b/xdr/setup.py
index 3778abbe9969..8f565619063a 100644
--- a/xdr/setup.py
+++ b/xdr/setup.py
@@ -21,9 +21,9 @@ setup(name = "xdrgen",
       # These will be the same
       author = "Fred Isaman",
       author_email = "iisaman@citi.umich.edu",
-      maintainer = "Fred Isaman",
-      maintainer_email = "iisaman@citi.umich.edu",
-      url = "http://www.citi.umich.edu/projects/nfsv4/pynfs/",
+      maintainer = "Calum Mackay",
+      maintainer_email = "calum.mackay@oracle.com",
+      url = "https://linux-nfs.org/wiki/index.php/Pynfs",
       license = "GPL"
       )
 
-- 
2.43.0


