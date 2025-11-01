Return-Path: <linux-nfs+bounces-15863-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3701AC2856C
	for <lists+linux-nfs@lfdr.de>; Sat, 01 Nov 2025 19:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7645A1893069
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Nov 2025 18:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC072FB963;
	Sat,  1 Nov 2025 18:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BHzGVK6z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE1D2FB987
	for <linux-nfs@vger.kernel.org>; Sat,  1 Nov 2025 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762021739; cv=none; b=iuRrOZiNim4zumEBsnu5K8SEleTBxYlVFvYlhtDwtZDxCPEjDB7oodbMbqgK6N/RNJhoaB6kMsjoLIJuXAYCMqB2cNoPUNdeIulFirX2Ge583zdh8gUrZmqswAFiBVRKUeAmz+o5juBw+22tUKMAmKBK207PGN2RTvgJC+ZVEC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762021739; c=relaxed/simple;
	bh=BMfVoLDEofxxk1lyb8w4h2ysFZ3N/YDQLGDkLDgBHpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Siuyk2l7jHgLjSE5/4FO/+wLUJY2DaTPFUMOSyq376i6g1Xjg2m4+R+bLl1Mz9ERFE1mdzls+sZjChTvrTud6FeTXChSB7VMAXzgcWoS5K9AKGYpDjMixMpdqN74ReS/hy78wYDY2RjRc8XDBIXcIdEaZYoZBmYs6KywvXUQK0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BHzGVK6z; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A1HxeqO009382;
	Sat, 1 Nov 2025 18:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=h4kef
	Ktc3DylkIN/jhlKol7a26TNO7lxiW35pS4E898=; b=BHzGVK6zmsa1fyszUpUBu
	wl4xAi3ymt5aKFFXyVCJ0NgR8NpRdItNnMWEBV9f2nhq0ezXWkp3zSeuzsZg8Mkr
	e2KmKkKTePHpGlyBN9lJiKZndSowJV4XPAardG1Jx+KD5+BJqLJUkedDNVfGDS3M
	H/PXt++pP3Z9yOVPhLskHIXVi+R00yDLXvw0FDFuOvY1NKKprqk8TFDnPQzmaVXs
	NYL3ILT1Zo6wuDcpkKC/XuiE+pv0fQZoDF4zQOJPIF/c4l/b0N65OTIyaGpC1/ku
	W6PTVyTNCxNgUaAQHrluCUoGxZDVyYcjIuKpfE6wMFrO1Vj2uM39nwQZlvmlgTGg
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a5q3b00mm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Nov 2025 18:28:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A1H69uo007399;
	Sat, 1 Nov 2025 18:28:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58na8cwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Nov 2025 18:28:40 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A1ISbNU035467;
	Sat, 1 Nov 2025 18:28:40 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4a58na8cvp-3;
	Sat, 01 Nov 2025 18:28:39 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFSD: Do not fence the client on NFS4ERR_RETRY_UNCACHED_REP error
Date: Sat,  1 Nov 2025 11:25:19 -0700
Message-ID: <20251101182819.651120-3-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251101182819.651120-1-dai.ngo@oracle.com>
References: <20251101182819.651120-1-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-01_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511010159
X-Proofpoint-GUID: SL5l7_9bOykq7SjUaLm9oNZ5D2nrr2Oc
X-Authority-Analysis: v=2.4 cv=Ae+83nXG c=1 sm=1 tr=0 ts=69065159 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=UvsxsoL7GTTpKtPkNekA:9 cc=ntf awl=host:12123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDE1NSBTYWx0ZWRfX1hZ9emIpLkwb
 QX8Rb5zESD7jTXqh6RPnACbkL0DPBHaaN9S7gjlwaCuSSCv31S+tIjLeSsl1uHAfsi1P9G6EBrL
 i4e0TfC3AS9IdCrYUBuu5ZqM/4MPmHXyi4+dxkWdjSAJgjiu8tzc4ZouSSgjTvn5jNkQio+Iofo
 EyCZal+2RiZzgSqvWz/4bzPoC5rkqCOhSxRK4MKqnPXi3e3BnCAL2e6gQ/AFVwK3pgnp9ReIJMo
 2qzF04SskCW9cqfKhvxUZPy6M+3B47fcrBi8ZopoeA5FEcl2I2yJ3kCu5+nkbr11xj8rVnfUMRn
 MhIat6VX4d/HaBZ2t6FJO6p1NnrISHu5rvZPV9yhPeipyK7n2Jd2cGUN3ZD7MUA8O7h1o4XGAEW
 n0tYZnhadIlALMO89OKg85Npc1fWsfO06cMQhMpG18EQhwCzitg=
X-Proofpoint-ORIG-GUID: SL5l7_9bOykq7SjUaLm9oNZ5D2nrr2Oc

NFS4ERR_RETRY_UNCACHED_REP error means client has seen and replied
to the layout recall, no fencing is needed.

Fixes: f99d4fbdae67 ("nfsd: add SCSI layout support")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4layouts.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 683bd1130afe..cfce8bfd396c 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -715,6 +715,12 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb, struct rpc_task *task)
 			nfsd_file_put(fl);
 		}
 		return 1;
+	case -NFS4ERR_RETRY_UNCACHED_REP:
+		/*
+		 * client has seen and replied to this request,
+		 * no need to fence the client
+		 */
+		return 1;
 	case -NFS4ERR_NOMATCHING_LAYOUT:
 		trace_nfsd_layout_recall_done(&ls->ls_stid.sc_stateid);
 		task->tk_status = 0;
-- 
2.47.3


