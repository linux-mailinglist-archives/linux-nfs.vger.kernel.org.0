Return-Path: <linux-nfs+bounces-2007-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3EC85916B
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Feb 2024 19:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FAF21F210FA
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Feb 2024 18:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE51B7E0ED;
	Sat, 17 Feb 2024 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c20Vut+I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CD77C6E9
	for <linux-nfs@vger.kernel.org>; Sat, 17 Feb 2024 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708192876; cv=none; b=pAKqkAn2/bgjjHmXAqkGIIubH1NV0Xt1CnVnqvt//uABquERuef+WQKoCm1pKFeggsUToAwJNOBon9HqPY7oB3QmI/ivqGqgwhHSLv9Sldy/+H1hVI6CjpzWKVE5PwqXdKlTj7fMmyLqckvbb1iJsA2EDxY4udp47uE8AsHRe98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708192876; c=relaxed/simple;
	bh=4xlqMGpWETLn7P3qyEGDoHs4m9ygpCTecMrBkUfR3QU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=OLUJjyPStkJpgmLTMk97lFINwo8QK+DUnxTj5Eb1KyXz6z7gWMeOUiYRBGfCwPgCPWREOzOsR6tRmUJjqC5y4kZMscS2Wl7xUqlFKD9kRSfUM/73Sx6oiU8y/XkbJ7oyS4vwilCTBZK7wWDoBRh6Cn4y/rfhMl+tWreVYpMhYlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c20Vut+I; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41HCDrZf020260;
	Sat, 17 Feb 2024 18:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=4/iipnvUr5YGehT1hhGtKi21Kij73x3jqkPVi/nCJZ4=;
 b=c20Vut+I8r68rCDP9tFngIDjCwCwUFXjLzFKTafgdpTE4sXjit0gF7wjy3jt2WWWJNI8
 BrWequbPOwkOYMucmFZiwne/T/gNr6kPkR7Z8c8rJLxFioSKFgDEP5ChBw0Q/O/Hntht
 6hVnMLQRCPkEby8Wg5ezEoij8/wc4n0u9T0b5s53RINnpl5SBqlvT9WOhQqICdqlcIk4
 NOqLFuZ7iWlLvpXvMuZ3VHP/9hJnCSZLargS2ocCBK7ZWxWqsWgoItQrm4aNlRa6DZvt
 MoUSdWvrpd4Da8RUD7GsU2PbgujnTb5pQOJBchhLLwZaJMljeHoGONPp5oeSRWN1tQNP Tg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamdts0es-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Feb 2024 18:01:04 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41HHeBSN029223;
	Sat, 17 Feb 2024 18:01:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak84c506-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Feb 2024 18:01:04 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41HI13DM019666;
	Sat, 17 Feb 2024 18:01:03 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3wak84c4y5-1;
	Sat, 17 Feb 2024 18:01:03 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSD: send OP_CB_RECALL_ANY to clients when number of delegations reach a threshold
Date: Sat, 17 Feb 2024 10:00:59 -0800
Message-Id: <1708192859-25002-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-17_16,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402170147
X-Proofpoint-GUID: YoJgE2t6BXA-oJtfELTRxpI-vzH-lK1r
X-Proofpoint-ORIG-GUID: YoJgE2t6BXA-oJtfELTRxpI-vzH-lK1r
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

When the number of granted delegation becomes large, there are some
undesire effects happen on the NFS server. Besides the consumption
of system resources, the number of entries on the linked lists of the
file cache can grow significantly.

When this condition happens, the NFS performace grounds to a halt as
reported here [1].

This patch attempts to alleviate this problem by asking the clients to
voluntarily return any unused delegations when the number of delegation
reaches 3/4 of the max_delegations by sending OP_CB_RECALL_ANY to all
clients that hold delegations.

[1] https://lore.kernel.org/all/PH0PR14MB5493F59229B802B871407F9CAA442@PH0PR14MB5493.namprd14.prod.outlook.com

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index fdc95bfbfbb6..5fb83853533f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -130,6 +130,7 @@ static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
 static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops;
 
 static struct workqueue_struct *laundry_wq;
+static void deleg_reaper(struct nfsd_net *nn);
 
 int nfsd4_create_laundry_wq(void)
 {
@@ -696,6 +697,9 @@ static struct nfsd_file *find_any_file_locked(struct nfs4_file *f)
 static atomic_long_t num_delegations;
 unsigned long max_delegations;
 
+/* threshold to trigger deleg_reaper */
+static unsigned long delegations_soft_limit;
+
 /*
  * Open owner state (share locks)
  */
@@ -6466,6 +6470,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 	struct nfs4_cpntf_state *cps;
 	copy_stateid_t *cps_t;
 	int i;
+	long n;
 
 	if (clients_still_reclaiming(nn)) {
 		lt.new_timeo = 0;
@@ -6550,6 +6555,9 @@ nfs4_laundromat(struct nfsd_net *nn)
 	/* service the server-to-server copy delayed unmount list */
 	nfsd4_ssc_expire_umount(nn);
 #endif
+	n = atomic_long_inc_return(&num_delegations);
+	if (n > delegations_soft_limit)
+		deleg_reaper(nn);
 out:
 	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
 }
@@ -8482,6 +8490,7 @@ set_max_delegations(void)
 	 * giving a worst case usage of about 6% of memory.
 	 */
 	max_delegations = nr_free_buffer_pages() >> (20 - 2 - PAGE_SHIFT);
+	delegations_soft_limit = (max_delegations / 4) * 3;
 }
 
 static int nfs4_state_create_net(struct net *net)
-- 
2.39.3


