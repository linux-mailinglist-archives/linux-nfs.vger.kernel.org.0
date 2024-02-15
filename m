Return-Path: <linux-nfs+bounces-1965-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAB5856CA1
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 19:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07CF1C2178D
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 18:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405211386B5;
	Thu, 15 Feb 2024 18:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="onG3NOh6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9178D137C2E
	for <linux-nfs@vger.kernel.org>; Thu, 15 Feb 2024 18:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021621; cv=none; b=kP1CfiXom1+o9e9p4ugE4sH4tztni8FIwIMBgWeLwXYY5cmq3i382SRU/CLEvWVpa32+ng+1iHVrhj9AL41Yf5mOmzvmcSpZhLkb/VmYtG5+p3TYl37+MWKSNoznzg7rcB2hSfcUID2ky9K3gjlE7RNZUYlnUH+d/KJqEizAufA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021621; c=relaxed/simple;
	bh=MYhf8wtMq3YH82p7q43f/uLRtI85EGqVEG6ctB0MOb0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=dklWtGFAnL/Aw6vTJOTndDsRsdM3X7PGaJFm0xT3SYaRHKT+tdQn4p3pD5HdZUeVhpJcP5aqf8eO2kaKvBugYecr8oj9pJ777oJ/goUpL2CFIkvjvs/mBsDx2JfgjCYM2DNUb6iFKOID6mvUY0uA1lFv3Ug7Q8VYHp2FFIzeNRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=onG3NOh6; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FFT5aT022525;
	Thu, 15 Feb 2024 18:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=UKm2LowyGYy9j5QN9sQ1X82XaTtMQz+/jLESJC1XIJg=;
 b=onG3NOh6HYTgmHFMRaDnOlCxC01QT0tBw0dMNjmkiQh4rHMTleAueFhgKb8VFbdG19XX
 JoBZf1zR6NBoND/Ykb9+S9CR9vopcov8YD9zmQ5zEsnmUTr/AnGdBHHCSH4MHM1q3ECf
 16C4CFVPJ9+ARqBEccXMXk0fnBhd1eggzlnSjUq6ah9Mr2i44MhXyvNuTQFLTz45JRH+
 joMS7hpxBYwCnHvvwvW8w5UR/BiVWv/WiMu30ci+K/RSeItEpA+zCDSjgc2emyAxSlmP
 HzytPm0d/EfXC7hPSDTKHUmW+Jz3COzvwJV8QjtYhWSuAe7D6z64ilHGWKwIrPXeX4Cq XA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92db2y67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 18:26:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FHmdcl000793;
	Thu, 15 Feb 2024 18:26:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykay7hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 18:26:55 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41FIQsmQ032173;
	Thu, 15 Feb 2024 18:26:54 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3w5ykay7gf-1;
	Thu, 15 Feb 2024 18:26:54 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: PATCH [v2 0/2] NFSD: use CB_GETATTR to handle GETATTR conflict with write delegation
Date: Thu, 15 Feb 2024 10:26:42 -0800
Message-Id: <1708021604-28321-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_17,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150149
X-Proofpoint-GUID: GXa0yIll79Cpg2GqJYOlZtCrtuyF0s64
X-Proofpoint-ORIG-GUID: GXa0yIll79Cpg2GqJYOlZtCrtuyF0s64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

Currently GETATTR conflict with a write delegation is handled by
recalling the delegation before replying to the GETATTR.

This patch series add supports for CB_GETATTR callback to get the latest
change_info and size information of the file from the client that holds
the delegation to reply to the GETATTR from the second client.

NOTE: this patch series is mostly the same as the previous patches which
were backed out when un unrelated problem of NFSD server hang on reboot
was reported.

The only difference is the wait_on_bit() in nfsd4_deleg_getattr_conflict was
replaced with wait_on_bit_timeout() with 30ms timeout to avoid a potential
DOS attack by exhausting NFSD kernel threads with GETATTR conflicts.

v2:
  . update comments in nfsd4_deleg_getattr_conflict

 fs/nfsd/nfs4callback.c |  97 +++++++++++++++++++++++++++++++++++-
 fs/nfsd/nfs4state.c    | 119 ++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfs4xdr.c      |  10 +++-
 fs/nfsd/nfsd.h         |   1 +
 fs/nfsd/state.h        |  24 ++++++++-
 fs/nfsd/xdr4cb.h       |  18 +++++++
 6 files changed, 255 insertions(+), 14 deletions(-)

