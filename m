Return-Path: <linux-nfs+bounces-16139-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D98C3C913
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 17:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31243188649D
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 16:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0802C237E;
	Thu,  6 Nov 2025 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T4vc5yP5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE7B274650
	for <linux-nfs@vger.kernel.org>; Thu,  6 Nov 2025 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447719; cv=none; b=DohASEPyw34C2peJv68kWEYagHHnj2yzDzhtw3dDnwsDQPv4UNnWCynyGyo/9R/1+TSwOM3sa7NxX7Ks9pKSXyOt+GeKhJobb74V7K7EoVp8hDAIj1VeBaxRoKFzWgZAIQlShijpTQhXlqSKvcEX/Xm8zFly+5YBHNACpwhv50s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447719; c=relaxed/simple;
	bh=YkLNOMxwwBrdEM923v9aiNd7pFnoxYqTsQLteY+Gcl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAtmC4m8aBdZU9768fZoJOyVIeHq/RN1LA6s1iw3KB1WfULBjfR78GxE89fNPvouxg73XoEr9cb1uOQAtPRodsW5SEUuqSfAKoLlV+JF2gKw8aZnYZgKVGrnvrqRD2O868OXZZHivEuvtF7ojeJOWnJhVy6Vpv2wzArq8N0p5gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T4vc5yP5; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6Bj0c5001542;
	Thu, 6 Nov 2025 16:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=AQ4HM
	Y/ATy5W4Q60Bc/7YUR1Ll7NeTFMi8TNiJv69dA=; b=T4vc5yP5E1L5V8H1xaDpG
	Ub7MVxK2Rf6wAu94X7AhQ/oPvhsO4aShFE1CuPNRsNEcwte5/yDfgXmb2b8FtwGi
	W+Bt78KUT5BlQky8wsEqVPBy9/ZcxpVRSzzUin2a7uhVYsBt2JCpSrVC4J36VTij
	VKDgw+arpGxjIBu467XEFpgENoheAaQEK92z3VKUTEaxYwqvdgZXs9iUfP5OIJ0P
	kUTt4flD2R/8zNUWPmmZNJtLyz6Khyamk4A2tleLB5vY2fdssIFI9m2q88WTkmSn
	Wq5oE354PlF3YncY6n0bOrXlKrHmZ/POQts2k+Ml7SUqWy/+kkCCh5pa+AwX1sbN
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8aqwafjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 16:48:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6G0BSc039477;
	Thu, 6 Nov 2025 16:48:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ncd4mp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 16:48:28 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A6GmQjh021205;
	Thu, 6 Nov 2025 16:48:27 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a58ncd4kb-3;
	Thu, 06 Nov 2025 16:48:27 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFSD: Fix server hang when there are multiple layout conflicts
Date: Thu,  6 Nov 2025 08:47:39 -0800
Message-ID: <20251106164821.300872-3-dai.ngo@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=NajrFmD4 c=1 sm=1 tr=0 ts=690cd15d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=57DVBpu5xdd1SRTCfJcA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: DIjUuySfP_gV4whFVQbLIJUzjYcihZ5G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzMyBTYWx0ZWRfX7gDuKJZj5iL6
 t8dTEAeUWkm0RDIpyB3Gg+h7XXRZ5JtWGP5eeGPi/9ClLHP1SB8blC9C0dL6OUyShuTqh+hIp9t
 GBkAoxzVmEk3Pov+Xcr2n7SaP5SSB7LeWNiMSogoCWvNjXa1CLROtMYFubk2kUofuvnIYT4IQBc
 nfB87S2YBjwBT0UsB4LX2xx1zDivW+9+5YhdzXigZGEsiPim8cKF4VnpzP2whQxjo+KFjGWUKoB
 3pqLSMBEb34CKYzYKjCSCZfq9/tgkEJ64xX8vneM1DFDLTkNCm6Oqx2v3xj5xyUrkQ5CJfkrauS
 GFiUmvoonY0G1jLI0VKLU8WBHrvBSCb4g2FI+w+e9bTsCuF0fx4DXIvrSR4Zl7XM6MEkfZHSfXw
 Rj3BYbGobephe0YCtbc6oeo9eHX5oQ==
X-Proofpoint-GUID: DIjUuySfP_gV4whFVQbLIJUzjYcihZ5G

When a layout conflict triggers a call to __break_lease, the function
nfsd4_layout_lm_break clears the fl_break_time timeout before sending
the CB_LAYOUTRECALL. As a result, __break_lease repeatedly restarts
its loop, waiting indefinitely for the conflicting file lease to be
released.

If the number of lease conflicts matches the number of NFSD threads
(which defaults to 8), all available NFSD threads become occupied.
Consequently, there are no threads left to handle incoming requests
or callback replies, leading to a total hang of the NFS server.

This issue is reliably reproducible by running the Git test suite
on a configuration using SCSI layout.

This patch addresses the problem by using the break lease timeout
and ensures that the unresponsive client is fenced, preventing it from
accessing the data server directly.

Fixes: f99d4fbdae67 ("nfsd: add SCSI layout support")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4layouts.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 683bd1130afe..b9b1eb32624c 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -747,11 +747,10 @@ static bool
 nfsd4_layout_lm_break(struct file_lease *fl)
 {
 	/*
-	 * We don't want the locks code to timeout the lease for us;
-	 * we'll remove it ourself if a layout isn't returned
-	 * in time:
+	 * Enforce break lease timeout to prevent starvation of
+	 * NFSD threads in __break_lease that causes server to
+	 * hang.
 	 */
-	fl->fl_break_time = 0;
 	nfsd4_recall_file_layout(fl->c.flc_owner);
 	return false;
 }
@@ -764,9 +763,27 @@ nfsd4_layout_lm_change(struct file_lease *onlist, int arg,
 	return lease_modify(onlist, arg, dispose);
 }
 
+static void nfsd_layout_breaker_timedout(struct file_lease *fl)
+{
+	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
+	struct nfsd_file *nf;
+
+	rcu_read_lock();
+	nf = nfsd_file_get(ls->ls_file);
+	rcu_read_unlock();
+	if (nf) {
+		int type = ls->ls_layout_type;
+
+		if (nfsd4_layout_ops[type]->fence_client)
+			nfsd4_layout_ops[type]->fence_client(ls, nf);
+		nfsd_file_put(nf);
+	}
+}
+
 static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
 	.lm_break	= nfsd4_layout_lm_break,
 	.lm_change	= nfsd4_layout_lm_change,
+	.lm_breaker_timedout	= nfsd_layout_breaker_timedout,
 };
 
 int
-- 
2.47.3


