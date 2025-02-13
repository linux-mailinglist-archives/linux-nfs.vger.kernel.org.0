Return-Path: <linux-nfs+bounces-10106-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3D2A34E89
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 20:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28BE16BEEF
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 19:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E128024A049;
	Thu, 13 Feb 2025 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DW0sHuUF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B14924A050
	for <linux-nfs@vger.kernel.org>; Thu, 13 Feb 2025 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739475478; cv=none; b=gjoZ6znqW5izoW/GvLI+XE7IWRbpJR+2sRRnIWyEWg6fg9QUlJI97fqPZMY8dCeS9hek06hENYtdjwTRvpCRxi8uybOSGmEzyodizpM9HffHxsZelHIF9q0mGjxveWEh9CziB+p5YklxL7xapyGe6/4CigdK6P+7F2OcfaA3Ckc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739475478; c=relaxed/simple;
	bh=d4KiwMCvSQelCWncZ+vmxjwFO0Dq/bAWFVduVVQm37I=;
	h=From:To:Cc:Subject:Date:Message-Id; b=bliXyohWb4g8o62w1Seoz8y/2SR3ADvzlSZA72GS7gfOhmOaR8A5MwIQ7rF/sbVNrddqPswaIIawFQDc4VpBZswnh0rOUdWpyRuemUqUvsmoj6eYrQ4jdwldhTJOVcqGNsHT7mXO7iTMZzibyCjqr+dEH6tbRER27ROZ4cMBxXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DW0sHuUF; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DGfgjA008217;
	Thu, 13 Feb 2025 19:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:message-id:subject:to; s=corp-2023-11-20; bh=WnqN3cQH
	JJQyVKK6ojkiknYRUYMAwyuRwingD3el65k=; b=DW0sHuUF75Bq+o74OGwjAzMO
	WFPcianHiiWy7Rc+PUgBZXKNZ2I0rTGrFYTFl9c+z372zTN1xtzjXCQWf4TH9fUF
	wzSEy8jgJm9UvsYhHTqTUiQySS7iauIJJYDRIQtCq1aR5KZe2c0WH9CkSAbP7A2/
	GtWmjr2yWQubZfQOzMt9mSZWSkIgj/6njKdV+Vjr5QeigFFFVXOR6+oe1ozEUgE2
	PK76NdeS4yz9gLbF/cRJEe/X8XbaDXD9vuHQePBjLCt8QmvTlZZCKH4si1qxd9G9
	UCuz8SXLItHThWHpyZ/Gw8msbYyoGAtrFzCSCjxa75pnLTLm9V7nNJKP2QiADA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0s42b95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 19:37:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DIe2s7001233;
	Thu, 13 Feb 2025 19:37:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44p632m3th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 19:37:40 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51DJbd0j036455;
	Thu, 13 Feb 2025 19:37:39 GMT
Received: from ca-common-sca.us.oracle.com (ca-common-sca.us.oracle.com [10.132.20.202])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44p632m3t9-1;
	Thu, 13 Feb 2025 19:37:39 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
Subject: [PATCH 0/2] NFSD: offer write delegation for OPEN with OPEN4_SHARE_ACCESS only
Date: Thu, 13 Feb 2025 11:37:16 -0800
Message-Id: <1739475438-5640-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=859 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130138
X-Proofpoint-GUID: MT_QWO2TPPhsTAz1woFgybD4Hnml5kNL
X-Proofpoint-ORIG-GUID: MT_QWO2TPPhsTAz1woFgybD4Hnml5kNL
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

RFC8881 does not explicitly state that server must grant write delegation
to OPEN with OPEN4_SHARE_ACCESS_WRITE only. However there are text in the
RFC that implies it is up to the server implementation to offer write
delegation for OPEN with OPEN4_SHARE_ACCESS_WRITE only.

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
only. When this condition is detected in nfsd4_encode_read the access mode
FMODE_READ is temporarily added to the file's f_mode and is removed when
the read is done.

 fs/nfsd/nfs4proc.c  | 15 ++++++++++++++-
 fs/nfsd/nfs4state.c | 34 +++++++++++++---------------------
 fs/nfsd/nfs4xdr.c   |  8 ++++++++
 fs/nfsd/xdr4.h      |  1 +
 4 files changed, 36 insertions(+), 22 deletions(-)


