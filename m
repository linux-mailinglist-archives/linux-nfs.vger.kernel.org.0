Return-Path: <linux-nfs+bounces-1189-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7991830C60
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jan 2024 19:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6584528195D
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jan 2024 18:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90D522631;
	Wed, 17 Jan 2024 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A77Qicea"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C61022318
	for <linux-nfs@vger.kernel.org>; Wed, 17 Jan 2024 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705514526; cv=none; b=uwTXKlQwOakxDnCP22LsQ8SLuC0P7VpmV2mm3Zot3fjtIVr/iMgj9tRmwDo/Du/K71w8dhf/z65PMWGgb/JnXcHu3CjTHQWeBMQ/3Uqr685Xiqd0om3YUePAknTuM/Ti01dfh2N/awFHqfDcw3gKePBjAztlCpc6EcnEI1NjmcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705514526; c=relaxed/simple;
	bh=y4Hqg3tUdRSb9wyHtYXHoY4LnYiYahhi1hYpXZtgqsw=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID; b=URfhGiuV3YQqZim7oQzxLFRByNpa98QdA2Hbv/phGAGeTp9X5VY/P9uSqarBon8qNrJYAEMddh8FAOjV25Jzgmc/VdE8MYAu7yQvEOGfNIWtLjGB2HNuo5RWlapDnuwP/f44HxspYcPGs57LcZ8AS4PQfsqtb39jZh7FfxxWPUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A77Qicea; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40HFx1u8011617;
	Wed, 17 Jan 2024 18:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=nh26HoOLBTkN39ks1RGgR2UqRe1VwOL6NY8hpCBYAV8=;
 b=A77QiceacEokUfeVRFYqmIUlYUJav7oaPJW9mdZWtG5c+LixW9JZ1XvcdNEnEzL6JJHj
 UssxNVtxeqp6y7gTC5PYjXgcOIVp2FkRTVSzsX9EGTZ8B86pCTnhePMyRS12P5a0TTEk
 apac+wDhIuDwafF8kSMGDIm9lcmBmxP5jP/TSv/p6Qb8F3/dWizA/il/RvtDXVfnyF+Y
 YfObJU6k7UkRYHO9U5TkSv1AOk3mx+2m/6JKhXTgVIqleMOVDK9cGRXzKDq54EyBX0cm
 B6CqPIduuS5TYJPitr8li9//rVlzTgQU3u3smhlMQeLGtcd1fuGdZhKlO9fskkCU3gii Fg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkm2hredu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 18:01:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40HGwSN6025000;
	Wed, 17 Jan 2024 18:01:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgyb24xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 18:01:57 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40HI1uEl011207;
	Wed, 17 Jan 2024 18:01:56 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vkgyb24w8-1;
	Wed, 17 Jan 2024 18:01:56 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: Jorge.Mora@netapp.com
Cc: linux-nfs@vger.kernel.org, brauner@kernel.org
Subject: [PATCH 1/1] nfstest_posix: add check for EINVAL when open(2) called with O_DIRECTORY|O_CREAT
Date: Wed, 17 Jan 2024 10:01:41 -0800
Message-Id: <1705514501-2098-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_11,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401170130
X-Proofpoint-GUID: nUwBfekH3sZ3mxmvwKmYrxr8vzI0FBjW
X-Proofpoint-ORIG-GUID: nUwBfekH3sZ3mxmvwKmYrxr8vzI0FBjW
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The 'open' tests of nfstest_posix failed with 6.7 kernel with these errors:

FAIL: open - opening existent file should return an error when O_EXCL|O_CREAT is used (256 passed, 256 failed)
FAIL: open - opening symbolic link should return an error when O_EXCL|O_CREAT is used (256 passed, 256 failed)

These tests failed due to the commit 43b450632676 that fixes problems
with VFS API:

43b450632676: open: return EINVAL for O_DIRECTORY | O_CREAT

This patch fixes the problem by adding a check for EINVAL when the
open(2) was called with O_DIRECTORY | O_CREAT.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 test/nfstest_posix | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/test/nfstest_posix b/test/nfstest_posix
index 57db5d69b072..6d5fd0dfffee 100755
--- a/test/nfstest_posix
+++ b/test/nfstest_posix
@@ -1232,7 +1232,12 @@ class PosixTest(TestUtil):
                         fstat = posix.fstat(fd)
 
                     if ftype in [EXISTENT, SYMLINK]:
-                        if posix.O_EXCL in flags and posix.O_CREAT in flags:
+                        if posix.O_CREAT in flags and posix.O_DIRECTORY in flags:
+                            # O_CREAT and O_DIRECTORY are set
+                            (expr, fmsg) = self._oserror(openerr, errno.EINVAL)
+                            msg = "open - opening %s should return EINVAL error when O_CREAT|O_DIRECTORY is used" % fmap[ftype]
+                            self.test(expr, msg, subtest=flag_str, failmsg=fmsg)
+                        elif posix.O_EXCL in flags and posix.O_CREAT in flags:
                             # O_EXCL and O_CREAT are set
                             (expr, fmsg) = self._oserror(openerr, errno.EEXIST)
                             msg = "open - opening %s should return an error when O_EXCL|O_CREAT is used" % fmap[ftype]
-- 
2.9.5


