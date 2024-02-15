Return-Path: <linux-nfs+bounces-1975-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 081E2856FC6
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 23:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ADF31C2082B
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 22:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49311419A9;
	Thu, 15 Feb 2024 22:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YOBxHqAk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25C31419A2
	for <linux-nfs@vger.kernel.org>; Thu, 15 Feb 2024 22:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708034740; cv=none; b=sN3kFPLKgsL+L61V4xfMjrrhKWk2MP4CoP0R8p29A3nIXx3WOwQmuDIlHLBMQDiJSgEwe/U/2iOomEIPoa8ySiw4EtzKuQTvR5heiIROy77QoPvJuem77jOdMnVOTTwgh25+7lIFwxTWjiS3VwIRAmsGMegyO6rzg88QitzpVZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708034740; c=relaxed/simple;
	bh=Dbn6WkIoKQDp+RtHFsKGFwXscW4se35c3OdOinfcxOs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=h9AaTMQV9UgAXKeuU92iitokMZw7J2hGVzMocvxGsfT9QogtarLy+SAkwPeevBscKItr/q9zZQmT3/83Ta3A9iKlTG18UquLiO6bgF9fbzHmjtqs9k5lNlrUeFTPvZp/oqf/zLQLklIZM9tF9SGktphC4LrTAzRgBOD/uNC1RMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YOBxHqAk; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FLRrgE027462;
	Thu, 15 Feb 2024 22:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=7ACx8ITEqpwcvET0HbNVakLsRUBHuC0eu95qDMwLvPo=;
 b=YOBxHqAke3IEiNJLI7ewbgHnO3DxqfRgeYtuK+VI86zEfX6v+LLOyQ3peHkbmajyBg4u
 jS0veZkEea6RVRiQ2IjBkK782HYeBKLTXHcTweWeJ+VCyCxbEH8skADtNI/rCwaokztN
 aydPbsTLCom617Vv8Ik+hdhShs4e9jkXH1RxHNpesGXpV+0c46TMB2x3dn8kxnKAqELD
 SxI55AqqWulAF/3ar/CSO/08ksytSFdp5DfC88A6ImGUtZPLddAeD5IcMchKG5Tp7iHi
 W8V3oRTK/dWNTD7crPxRv+dq4OUQau9Pi/VuLPWFvBgLNyZOb5waMSmXx/S2eQjj1cP9 hw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w9301kdn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 22:05:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FLlHA5015208;
	Thu, 15 Feb 2024 22:05:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykb72rk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 22:05:34 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41FM5XEb007551;
	Thu, 15 Feb 2024 22:05:33 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3w5ykb72r7-1;
	Thu, 15 Feb 2024 22:05:33 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: PATCH [v3 0/2] NFSD: use CB_GETATTR to handle GETATTR conflict with write delegation
Date: Thu, 15 Feb 2024 14:05:20 -0800
Message-Id: <1708034722-15329-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_21,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150172
X-Proofpoint-GUID: SnYq9Wdt78mB5X9h7HEEvliT6XsEwGYc
X-Proofpoint-ORIG-GUID: SnYq9Wdt78mB5X9h7HEEvliT6XsEwGYc
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

v3:
  . rebase with nfsd-next

 fs/nfsd/nfs4callback.c |  97 ++++++++++++++++++++++++++++++++++++-
 fs/nfsd/nfs4state.c    | 115 ++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfs4xdr.c      |  10 +++-
 fs/nfsd/nfsd.h         |   1 +
 fs/nfsd/state.h        |  24 ++++++++-
 fs/nfsd/xdr4cb.h       |  18 +++++++
 6 files changed, 251 insertions(+), 14 deletions(-)


