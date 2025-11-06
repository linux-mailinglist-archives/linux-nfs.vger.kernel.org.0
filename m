Return-Path: <linux-nfs+bounces-16138-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D80AC3C901
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 17:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD3A6352391
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 16:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E658E2D1F64;
	Thu,  6 Nov 2025 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gppTre6T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF362BFC60
	for <linux-nfs@vger.kernel.org>; Thu,  6 Nov 2025 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447719; cv=none; b=fRmLg7WsNyajGbmVFrZxNFtXlyS4v/uXa1/zvY2pfqRYkDvOx7X7wym7hdEoQ7tkxM/CscjyPDzV36K7o7sOipxc5r5w4bt9CiHkOOiBIi1LG5EY6cA/7JUkw1vJ7o6SQo6cixSOSvYPGiwxVaKbSiVPDE34JQQ+/mq1auAQq5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447719; c=relaxed/simple;
	bh=mb7cfLou3to9TE/Rme3Rw2b8n7pHKZ0AGUd3pIBmR7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SC9kkTIo710sHTzxegHdrxLc2sdvW2Fwqgq0t4J1DEUd2Wn2mPKhRJqJtbF2XasWHHBAeNwUUazOUd1K/nLKb6+Rln29TY1ER13tiyzmb7FvcYnMQr2mxrY+svCH1GLuth8YzzMtE74ardkb7CjrskCfciQNM3V6e+Jze8wDpoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gppTre6T; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6BTxFX002486;
	Thu, 6 Nov 2025 16:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=ix+vz5Z3RJbr7r01y1AOS2oMatg1l
	mmqh5ZOfRC3hmg=; b=gppTre6Tv21G51D4Uw+wAy0ET55iXfPNUfLs1o/Oa9OPs
	M3xj2dF2N9eIHGbDzlF/GYooBF0SLwpk6OGrAj1aBP6lk3LRAvA7Gz7T9KKi9uzv
	uuIuloGm+CQT/KXd0KaS8/BwUvDRYnXSCa9diyp7vw6LcKgJnwVimediS7VlUcMZ
	cOcbC7CLRR8Md2pTLcNT5yyIIy88bSj5N5dvQ76RBe19aROxEeTbK2qVsPMeSr4o
	lVHO4M9LOCJKEwjqDEXZKloIcKEgs85WCfXa6SkE9rZ4A4O57LMlftqoDGkaUwkG
	VOb+xEauWjktKiPiQ4OA6Yw74s+iuGKFAElkLzUGg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8aqwafje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 16:48:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6FrpsU039707;
	Thu, 6 Nov 2025 16:48:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ncd4m0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 16:48:27 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A6GmQjd021205;
	Thu, 6 Nov 2025 16:48:26 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a58ncd4kb-1;
	Thu, 06 Nov 2025 16:48:26 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [Patch 0/2] NFSD: Fix server hang when there are multiple layout conflicts
Date: Thu,  6 Nov 2025 08:47:37 -0800
Message-ID: <20251106164821.300872-1-dai.ngo@oracle.com>
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
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511060134
X-Authority-Analysis: v=2.4 cv=NajrFmD4 c=1 sm=1 tr=0 ts=690cd15c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=iQKRUGprwFFxlDHd1zoA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: Rpt8g2c3nBVv9N0vQNIAu7rDqT9tTP-k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzMyBTYWx0ZWRfX0cod96cGfykH
 a9Ggvs/8fUrhLx71rlLuo+x/h364wzEUrBzR74wsq860OnLARqPS6kqYfTdU6NX4MlcLBbn7KN0
 uteadzXENerRImL+kOHR9pw6IjkDUepqRq1bYQzellzUtXNsy8O/aC0usPbZABTmxCEP2rNYASt
 ySKS39KZmVpG/QI6xX66kzgj60q3d5Uoe4pyGQAi87OmviK2SKi1QdT6hklsGcRFbE7VZryTtvd
 2fuHtrA3TEtdSL8mEvMFSTCnevZCYx5yLwvkF9hIY0AoldJZzzqKbggTN+XqucIz0Hdep8Id6MU
 pEX+j8p307JuQN5w0LRxvAKurrzA9hnJKTD4RQrh+Z/m9eecmPfPxYyjfFr5gA+cE10B5oocb4I
 grV5NkPoKhEbW5uEbby0p0B+oA9KWA==
X-Proofpoint-GUID: Rpt8g2c3nBVv9N0vQNIAu7rDqT9tTP-k

When a layout conflict triggers a call to __break_lease, the function
nfsd4_layout_lm_break clears the fl_break_time timeout before sending
the CB_LAYOUTRECALL. As a result, __break_lease repeatedly restarts
its loop, waiting indefinitely for the conflicting file lease to be
released.

If the number of lease conflicts matches the number of NFSD threads (which
defaults to 8), all available NFSD threads become occupied. Consequently,
there are no threads left to handle incoming requests or callback replies,
leading to a total hang of the NFS server.

This issue is reliably reproducible by running the Git test suite on a
configuration using SCSI layout.

This patchset fixes this problem by introducing the new lm_breaker_timedout
operation to lease_manager_operations and using timeout for layout
lease break.

 Documentation/filesystems/locking.rst |  2 ++
 fs/locks.c                            | 14 +++++++++++---
 fs/nfsd/nfs4layouts.c                 | 25 +++++++++++++++++++++----
 include/linux/filelock.h              |  2 ++
 4 files changed, 36 insertions(+), 7 deletions(-)


