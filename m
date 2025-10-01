Return-Path: <linux-nfs+bounces-14848-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89877BB1FEA
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Oct 2025 00:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D9A1710F9
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Oct 2025 22:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42B42D9EE2;
	Wed,  1 Oct 2025 22:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rjlXcgyH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401382BDC00
	for <linux-nfs@vger.kernel.org>; Wed,  1 Oct 2025 22:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759357746; cv=none; b=llOwbANTjTxM2DNCBTYUT6uXXegA0e6TQrCEq/kP847IClVQ33PMtP8IjtEGDrkP/KeRTqJjmLQFhXe0kvE41kO9lLu4t9EDgzHnjY9Xo99rQ14+9UQtY9x5XmDj0z6dJ2/N46yrrSsXsnmllZZh+MkA2t3c4eZEf5Nb9u0BaQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759357746; c=relaxed/simple;
	bh=KbgsadxDsHfJFurL8QYJbJR+5RrF/XUgGiIGtUG4B0c=;
	h=From:To:Cc:Subject:Date:Message-Id; b=MPxGhiHb+BJQ0r0DjbP99CdjZQBtMI0cv7KQBQ4l39AW9/oNMBpKTgl13zvUKmR+JS/nwKb78DIiIn4WOMeizqCtI74poQm+y3xLNp5GoAK9vqIm1yaUY5B0X2x8rmOTG3qoIIMxeOiyPDV4lMrx+HHOt4+8kOMExf59ZAjIa8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rjlXcgyH; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591Lfw0u016264;
	Wed, 1 Oct 2025 22:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:message-id:subject:to; s=corp-2025-04-25; bh=Vgyyzobg
	L6/ktMeepSge/wZFGTMv62SniUZLcZZ4MZ8=; b=rjlXcgyHW1bxbK3tviIEavhD
	AAOSZ56nnP2UIKJaAQoIRmSq4BjbhBH2XswT+v0n0h0pu2kUJgDVok7NfhJDsmdW
	7+0xuIp7hWvvRoRIL3y7qugnZqjvishfFNKszOHeC0p/PK4M+qqNZNVf/RWFliNs
	Q4y0j0uRBEw1z1iuu+xIIHh0N9rhDauPmlSVE9QXu8cN3vhObwYQoPyId1dQYrRh
	sf23AadLdGRjKNdI35CkqzY71gYbWoXLllHz1Z5b1XcL+OMnQnL4t/OGf1DBEHih
	Ma6RsYn8k0k2AI5bDQIo+XRbGQu0u7ka5zJS7VxUBP5misqQDBCoHXnxKrDgwQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gm3bjeuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Oct 2025 22:29:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 591L4EKs023209;
	Wed, 1 Oct 2025 22:28:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49e6car6pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Oct 2025 22:28:56 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 591MStij029839;
	Wed, 1 Oct 2025 22:28:55 GMT
Received: from ca-common-sca.us.oracle.com (ca-common-sca.us.oracle.com [10.132.20.202])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 49e6car6ps-1;
	Wed, 01 Oct 2025 22:28:55 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: Jorge.Mora@netapp.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] DIO: add NFSv4.2 READ_PLUS support for nfstest_dio
Date: Wed,  1 Oct 2025 15:28:53 -0700
Message-Id: <1759357733-64526-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510010197
X-Proofpoint-GUID: qtupclIuVROPPipmd2SEX9oAt6xl3WQF
X-Authority-Analysis: v=2.4 cv=GsJPO01C c=1 sm=1 tr=0 ts=68ddab2f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=x6icFKpwvdMA:10 a=rOd6jeTEAAAA:8 a=yPCof4ZbAAAA:8 a=x-ia6X6FEfh5ifLx9zkA:9
 a=kfyJvcI4S63vgYPh1728:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2MiBTYWx0ZWRfX8lRugdpuiBhy
 JoOtc33/3O8ipaR88O5l+vlHgNTfjZdHxAYhS0iomZwa7mGpJ+q94XsF5JdecAFKAsnjYcEHvCg
 hUGvHKvGErjpgfwXYCPmRKfofmoA9KNLtbneEpJxI7Ey57AwHekd3BEKTWY8bWp1zKc1dTGvYmd
 JyO2Ku2VJrNJzBt5D1vsokx2O4SY6byfbaRMGw4dZpbKkP66lemnhSIw+iRXxTgmEZbpXP6rjZa
 6TlZVhzRmRv6YmLlJfyGbPcoQ2NkZYkui4VN6KO8Wvv38+lFZcWgAG5Emm/Uql4VLRv5RKxYf2b
 0ZYhTigx46AvgvF2uL/ONzbUdWBe1VJPcfhcVmRD1nAAPHZCX8xoMBLC9SLudlO9Hf9bGDgJfLh
 Mm6GYL9tO3DI0Lnr4IzDyrKXwIIbMw==
X-Proofpoint-ORIG-GUID: qtupclIuVROPPipmd2SEX9oAt6xl3WQF
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

From: Oracle Public Cloud User <opc@dngo-nfstest-client.allregionaliads.osdevelopmeniad.oraclevcn.com>

Check for nfs_version >= 4.2 and use READ_PLUS instead of READ.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 test/nfstest_dio | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/test/nfstest_dio b/test/nfstest_dio
index 093e552..653a842 100755
--- a/test/nfstest_dio
+++ b/test/nfstest_dio
@@ -617,6 +617,8 @@ class DioTest(TestUtil):
 
             if nfs_version < 4:
                 match_str = "NFS.argop == %d and NFS.fh == b'%s'" % (NFSPROC3_READ, self.pktt.escape(filehandle))
+            elif nfs_version >= 4.2:
+                match_str = "NFS.argop == %d and NFS.stateid.other == b'%s'" % (OP_READ_PLUS, self.pktt.escape(stateid))
             else:
                 match_str = "NFS.argop == %d and NFS.stateid.other == b'%s'" % (OP_READ, self.pktt.escape(stateid))
 
@@ -744,9 +746,13 @@ class DioTest(TestUtil):
             fd = None
             bfd = None
             ofd = None
-            io_str  = "WRITE" if write else "READ"
+            if self.nfs_version >= 4.2:
+                io_str  = "WRITE" if write else "READ_PLUS"
+                bio_str  = "WRITE" if buffered_write else "READ_PLUS"
+            else:
+                io_str  = "WRITE" if write else "READ"
+                bio_str  = "WRITE" if buffered_write else "READ"
             io_mode = posix.O_WRONLY|posix.O_CREAT if write else posix.O_RDONLY
-            bio_str  = "WRITE" if buffered_write else "READ"
             bio_mode = os.O_WRONLY|os.O_CREAT if buffered_write else os.O_RDONLY
 
             if not bsize:
@@ -861,6 +867,8 @@ class DioTest(TestUtil):
 
             if nfs_version < 4:
                 io_op  = NFSPROC3_WRITE if write else NFSPROC3_READ
+            elif nfs_version >= 4.2:
+                io_op  = OP_WRITE if write else OP_READ_PLUS
             else:
                 io_op  = OP_WRITE if write else OP_READ
 
@@ -985,6 +993,8 @@ class DioTest(TestUtil):
 
                 if nfs_version < 4:
                     bio_op = NFSPROC3_WRITE if buffered_write else NFSPROC3_READ
+                elif nfs_version >= 4.2:
+                    bio_op = OP_WRITE if buffered_write else OP_READ_PLUS
                 else:
                     bio_op = OP_WRITE if buffered_write else OP_READ
 
@@ -1270,6 +1280,8 @@ class DioTest(TestUtil):
 
             if nfs_version < 4:
                 io_op = NFSPROC3_WRITE if write else NFSPROC3_READ
+            elif nfs_version >= 4.2:
+                io_op  = OP_WRITE if write else OP_READ_PLUS
             else:
                 io_op = OP_WRITE if write else OP_READ
 
-- 
2.47.3


