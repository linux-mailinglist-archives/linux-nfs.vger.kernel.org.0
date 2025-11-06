Return-Path: <linux-nfs+bounces-16140-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EFAC3C94F
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 17:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1392E4F67CC
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 16:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7D019D07E;
	Thu,  6 Nov 2025 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F0B3onT8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767D02C2377
	for <linux-nfs@vger.kernel.org>; Thu,  6 Nov 2025 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447726; cv=none; b=tPyWkwZMOheNDrgENo0tdKaE7ruKGOJOAvOAlOJPIF4KIOdASqberQWk/AJbHE+VDpLN6uE0NLOqcPuUkOYToZl5X4dsGKb7tSMAHpJPcMFeCZhFcEUxZhL3ddD0lZFfH40TToge4Ua6EZD3PYTLa6xEi0IcSDTIZPu+dq8532Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447726; c=relaxed/simple;
	bh=YrCTfvsppb+Z0yj6vQ4Z4iLo0XmktOIVlHarsCvbeUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBzkUSbJP+GlTjFW9hAqUioZWOHHzuj28IqNJNLd3ocJY4cQVIXIG/h98GlzYzkyzL44dGGVFFSAFOBj7FEoqjInc/sVb6UDgmq1XVy+L88C+/GduCAp56CGIXSqzvuAj9b8lAZxoq7OcR7aFuMW2y4mhZWYU4VAIABaACavk84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F0B3onT8; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6Bj0c4001542;
	Thu, 6 Nov 2025 16:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=ogTYW
	XmchI1Tg5JKI2yyNa9kegdnnZOybJ40fGQpHDQ=; b=F0B3onT8uKMqxho+Sv0vA
	Of4H/g7/QLcwqCUrxnWoi34mBPG6OGOWp1hGg/MOKgFhxhLJ3MAfdr7i7TELPbMb
	B22wcKoN2Bn9pg6AYvHeMI45wTOPRgTHO+ueJ0mYjYtBW7awIG31IYhPP9pxSJmQ
	JbjLVlLTFbWW7HUUNYyKgULaEPqsW/Zb0j07JZM+DB2RnHIPk2qyQVBH1MTB8yz2
	zxUDzZlvyMMJtJE7i4mZlIc5Pw7ZUNO1gF8PD77RZBAvPPCxRPjjGA+OFx9a4YPJ
	nGgm6Y6JV+rmw8JDPTWl/bHP0oQidVsoqZ0avpL8PRhmnKp1hHpOg+dEXpTUKgcs
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8aqwafjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 16:48:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6FwsYl039458;
	Thu, 6 Nov 2025 16:48:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ncd4md-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 16:48:27 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A6GmQjf021205;
	Thu, 6 Nov 2025 16:48:27 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a58ncd4kb-2;
	Thu, 06 Nov 2025 16:48:27 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] locks: Introduce lm_breaker_timedout op to lease_manager_operations
Date: Thu,  6 Nov 2025 08:47:38 -0800
Message-ID: <20251106164821.300872-2-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251106164821.300872-1-dai.ngo@oracle.com>
References: <20251106164821.300872-1-dai.ngo@oracle.com>
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
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=S97X5fav3GynFx1AP6AA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: QfjYy6JA570HQDR_BaPJdKpllIX6XAGd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzMyBTYWx0ZWRfX85qEVS/qUsGa
 zjgmTudddBUy92CXWmC819Ez6sL5jJ5dcCQY53qaw0sqvfR++aVlA/7vTQh+ueB2CGQrgMOqAFi
 fLmJmS8Xis4Km6o1O+yWT6SikY4k5eecMwjskTv+yhkqfRit34hXBRSwGZJeiQhGM++U8l0psnF
 TYZfCA/Q8c7cySrtLq7FGf/cUBsi4TDkIL5i/VhdfT1dpUdF/qtS/IjhhFTQbe6lz5RcxbR+8YD
 8F2SxG2JR0QkHhKrkjf25fFaGaqdTqqsig/nkva9kOH4/j4cICbyAzTsZeUO0e5vDSXJ7/rpJoc
 5Qn3gtcMMSauYfGFFhDzYxdhAL85MJZzCWnN5lbqH6sQLOvgWcGQPcusl26fRib58v1HBskQ2DO
 hmTDEMY3/jlhS70Hno/fOzo8BUx4dw==
X-Proofpoint-GUID: QfjYy6JA570HQDR_BaPJdKpllIX6XAGd

Some consumers of the lease_manager_operations need to perform additional
actions when a lease break, triggered by a conflict, times out.

The NFS server is the first consumer of this operation.

When a pNFS layout conflict occurs, and the lease break times out -
resulting in the layout being revoked and its file_lease beeing removed
from the flc_lease list, the NFS server must issue a fence operation.
This ensures that the client is prevented from accessing the data
server after the layout is revoked.

Fixes: f99d4fbdae67 ("nfsd: add SCSI layout support")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 Documentation/filesystems/locking.rst |  2 ++
 fs/locks.c                            | 14 +++++++++++---
 include/linux/filelock.h              |  2 ++
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 77704fde9845..cd600db6c4b9 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -403,6 +403,7 @@ prototypes::
 	bool (*lm_breaker_owns_lease)(struct file_lock *);
         bool (*lm_lock_expirable)(struct file_lock *);
         void (*lm_expire_lock)(void);
+        void (*lm_breaker_timedout)(struct file_lease *);
 
 locking rules:
 
@@ -416,6 +417,7 @@ lm_change		yes		no			no
 lm_breaker_owns_lease:	yes     	no			no
 lm_lock_expirable	yes		no			no
 lm_expire_lock		no		no			yes
+lm_breaker_timedout     no              no                      yes
 ======================	=============	=================	=========
 
 buffer_head
diff --git a/fs/locks.c b/fs/locks.c
index 04a3f0e20724..1f254e0cd398 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -369,9 +369,15 @@ locks_dispose_list(struct list_head *dispose)
 	while (!list_empty(dispose)) {
 		flc = list_first_entry(dispose, struct file_lock_core, flc_list);
 		list_del_init(&flc->flc_list);
-		if (flc->flc_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT))
+		if (flc->flc_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT)) {
+			if (flc->flc_flags & FL_BREAKER_TIMEDOUT) {
+				struct file_lease *fl = file_lease(flc);
+
+				if (fl->fl_lmops->lm_breaker_timedout)
+					fl->fl_lmops->lm_breaker_timedout(fl);
+			}
 			locks_free_lease(file_lease(flc));
-		else
+		} else
 			locks_free_lock(file_lock(flc));
 	}
 }
@@ -1482,8 +1488,10 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
 		trace_time_out_leases(inode, fl);
 		if (past_time(fl->fl_downgrade_time))
 			lease_modify(fl, F_RDLCK, dispose);
-		if (past_time(fl->fl_break_time))
+		if (past_time(fl->fl_break_time)) {
 			lease_modify(fl, F_UNLCK, dispose);
+			fl->c.flc_flags |= FL_BREAKER_TIMEDOUT;
+		}
 	}
 }
 
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index c2ce8ba05d06..06ccd6b66012 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -17,6 +17,7 @@
 #define FL_OFDLCK	1024	/* lock is "owned" by struct file */
 #define FL_LAYOUT	2048	/* outstanding pNFS layout */
 #define FL_RECLAIM	4096	/* reclaiming from a reboot server */
+#define	FL_BREAKER_TIMEDOUT	8192	/* lease breaker timed out */
 
 #define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
 
@@ -49,6 +50,7 @@ struct lease_manager_operations {
 	int (*lm_change)(struct file_lease *, int, struct list_head *);
 	void (*lm_setup)(struct file_lease *, void **);
 	bool (*lm_breaker_owns_lease)(struct file_lease *);
+	void (*lm_breaker_timedout)(struct file_lease *fl);
 };
 
 struct lock_manager {
-- 
2.47.3


