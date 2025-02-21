Return-Path: <linux-nfs+bounces-10284-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91C2A4039D
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Feb 2025 00:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 844537A7DBB
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 23:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F85250BF3;
	Fri, 21 Feb 2025 23:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lXB3XRxo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00492500B1
	for <linux-nfs@vger.kernel.org>; Fri, 21 Feb 2025 23:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740181377; cv=none; b=J7ERiPO+hiE+pilynDhBMYEOStiiV3fzuJO9OQNy0vDuSfImeuGQzllUUQiaaRx1P16R1RV7NKJxVvbZOFMpzxq6b6YALWs5+btewffEqGqv1JqJheIa/JqVaHCeNU9QTLswYBWIV37gsOskePRoqTHiU7YURjeGEmbnw0X+0hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740181377; c=relaxed/simple;
	bh=Oc9XIAr8kNHYPytz5APE7eG2DHKBSYeIUaKhKRCKjM4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=DSWG7TlTOTUkx9XxPA1yFu1MQEVycbmHRXQR1Y5ifkNgVcmKihVcHTE+AdX8u1o2W35f7DxRNa2BmsucqWLt0NngVT1p/wKQXfg74BiX5XqzyswrDxB0Xd23YN1r7gd9BfQdnNxwuUuwdzpKk8diG4Ubu26GqRIE1YD8wJbaLdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lXB3XRxo; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LMBd6o030223;
	Fri, 21 Feb 2025 23:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:message-id:subject:to; s=corp-2023-11-20; bh=Jolp7xbS
	FrzWso5M90xSlBCMT4mXiuLu5Qxr8M8J/yQ=; b=lXB3XRxovNCxYMm1VSTWGseS
	EIu72cEDY9t0I0bAj2TlEK6KKmk+7nQvgUJC6NJveO2t5bdEb6lr9EQePhaE3xg4
	Wd517SalZcnCQzgqPXMiAr+NE56iqdb9Yt7t0Q29yhsc8oIAEiixXGPaQbNNjR+y
	s6lBoXZrneJeSVP3hDzqInyMUMYQlibnjm+oa553YzwDIR7TJDHImhPMpB4HP3Kl
	Dl/bK6H/9k54GcHyBUlP4HLWx7Sn1crEvcyqq0Adp2eaWCmkVWSI24/qgwTwIrzP
	VrJZOiFWq4Kr/CSOwcCIP4+3mLrtRS5NTH0Y4s+jlEExPAk/BI7UWa2VsTzrGw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w02yqafh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 23:42:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51LL271o026196;
	Fri, 21 Feb 2025 23:42:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0ssumcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 23:42:42 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51LNbkJJ037041;
	Fri, 21 Feb 2025 23:42:41 GMT
Received: from ca-common-sca.us.oracle.com (ca-common-sca.us.oracle.com [10.132.20.202])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 44w0ssumcp-1;
	Fri, 21 Feb 2025 23:42:41 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
Subject: [PATCH V2 0/2] NFSD: offer write delegation for OPEN with OPEN4_SHARE_ACCESS only
Date: Fri, 21 Feb 2025 15:42:18 -0800
Message-Id: <1740181340-14562-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=771 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502210162
X-Proofpoint-ORIG-GUID: NFw9_mJCgpoUvC9G8P2DNrfUr8XlMb8Z
X-Proofpoint-GUID: NFw9_mJCgpoUvC9G8P2DNrfUr8XlMb8Z
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

From RFC8881 does not explicitly state that server must grant write
delegation to OPEN with OPEN4_SHARE_ACCESS_WRITE only. However there
are text in the RFC that implies it is up to the server implementation
to offer write delegation for OPEN with OPEN4_SHARE_ACCESS_WRITE only.

Section 9.1.2:

  "In the case of READ, the server may perform the corresponding
   check on the access mode, or it may choose to allow READ for
   OPEN4_SHARE_ACCESS_WRITE, to accommodate clients whose WRITE
   implementation may unavoidably do (e.g., due to buffer cache
   constraints)."

Also in section 10.4.1

  "Similarly, when closing a file opened for OPEN4_SHARE_ACCESS_WRITE/
   OPEN4_SHARE_ACCESS_BOTH and if an OPEN_DELEGATE_WRITE delegation
   is in effect"

This patch series offers write delegation for OPEN with OPEN4_SHARE_ACCESS_WRITE
only. The file struct, nfs4_file and nfs4_ol_stateid are upgraded
accordingly from write only access to read/write access. When the
delegation is returned, the file struct, nfs4_file and nfs4_ol_stateid
are downgraded according to remove the read access.

-- changes from v1:
0002: The file access mode is upgraded to include read access at the time
      the delegation is granted and read access is removed when the delegation
      is returned.

 fs/nfsd/nfs4state.c | 96 +++++++++++++++++++++++++++++++++++++-----------
 fs/nfsd/state.h     |  2 +
 2 files changed, 77 insertions(+), 21 deletions(-)


