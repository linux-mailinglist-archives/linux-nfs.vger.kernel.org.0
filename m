Return-Path: <linux-nfs+bounces-15869-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C8EC285B7
	for <lists+linux-nfs@lfdr.de>; Sat, 01 Nov 2025 19:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB62D3B206F
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Nov 2025 18:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4278528E;
	Sat,  1 Nov 2025 18:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PcdJqEhU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1072FC895
	for <linux-nfs@vger.kernel.org>; Sat,  1 Nov 2025 18:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762023185; cv=none; b=jFxUt/TVqvtiFLM6SCoATAu2+wyzmGl8JqqK21auMB/X5d7HWK8CnYashOVUV6ul0+ruUqk/xM2RsJXh5rX9MvQ5nMTegByDy45vDbXR8yvaAxlfk/0p8teqduMFhQsO1ePD43jC4961IM1nVyUnoWNki51oBurEQV333VEPO6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762023185; c=relaxed/simple;
	bh=BMfVoLDEofxxk1lyb8w4h2ysFZ3N/YDQLGDkLDgBHpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GB9V8AUJeQ3/+7f5BWEpLvQXq6CaWgX8Rw4Ph7T8oZV/MO5MUAVjBveJ0Aq5urM0raZFWoRl9isvYsq/UwYfztndMnrakxrRLfa4//5FVPC2UGjfa/MLoGAkjy8rALvJZE1P+RDtoYKlLAdC2zqDbDjO9qRJAd7V05SDLclAyuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PcdJqEhU; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A1IZ8wE012732;
	Sat, 1 Nov 2025 18:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=h4kef
	Ktc3DylkIN/jhlKol7a26TNO7lxiW35pS4E898=; b=PcdJqEhUMcD5gUe7Jysju
	0YBy+4bTF5AhSGz+297V0svmEuhFU/WGW99UCqId2XKr17s3LTysDKO9ncHG4PVB
	+UqPgpT/7bGoZqdPf2p+QLbntnWcZvzbPYjhAJG5xRN8cdxnmlb4+5woynwdzw/t
	aP0QBg6C/pxBpo9fRvnC/D/WO+ypA7Xj3mxnQ6x5EgiXjNaqkyjBzGRtDyF34Hv0
	OykCP7RS2aWNHuNlt5FJZjIwvjYQadjOI/oVbZP7u7UOPrH8P8KJ/ZpnOigz5ydV
	uXVP9m5vGFSHPccV0ZtOoFCXP02+zIjEjYJ2D6MWQdY2Z+AF41Qe+8GdSrd6hAXg
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a5qf2r0t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Nov 2025 18:52:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A1HP14f016729;
	Sat, 1 Nov 2025 18:52:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58n6ggm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Nov 2025 18:52:30 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A1IqTSg011363;
	Sat, 1 Nov 2025 18:52:30 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a58n6ggks-3;
	Sat, 01 Nov 2025 18:52:30 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFSD: Do not fence the client on NFS4ERR_RETRY_UNCACHED_REP error
Date: Sat,  1 Nov 2025 11:51:34 -0700
Message-ID: <20251101185220.663905-3-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251101185220.663905-1-dai.ngo@oracle.com>
References: <20251101185220.663905-1-dai.ngo@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511010162
X-Proofpoint-GUID: 8D6IQDW5FEvf2kP6Hw_IYWYJrtSzC1K6
X-Authority-Analysis: v=2.4 cv=HODO14tv c=1 sm=1 tr=0 ts=690656ef cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=UvsxsoL7GTTpKtPkNekA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 8D6IQDW5FEvf2kP6Hw_IYWYJrtSzC1K6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDE1OCBTYWx0ZWRfX7Z20iDZw51xm
 6tqR9veQtVz6OVZcfV9aCQsQycx75zp56jh0Oz0Vmwc7VsKojWUx6qBeBkToSQgi3IpP7VwJc5F
 ZTC85aFfK9O4LNm8ts9v47x339AWlEByZz8XSMaEHZ5oM7Vz1Za0wQDpqCJZKuwynIPHX9PWafI
 wDF6QDOL3E05u7h35ApW8OKN0G6OAyOPLuQQF70BqYp9yl5nk299fPusAv2GBdVWUjgMtv4dqzc
 b1IIyld6Q/JZoXjUvkIWrD70obG5b0jXeUs2NPRxAcnInmB9BO7lhJxs0KD6M2KyS9+wmCH8igo
 iCkNoFfOyTJvFpr3SstyZV3pG6c+jfMCK//6jtLHO/08ArVoJLGvdzgktlzoMQsPS3zjCEdDsRM
 M46U66fFwIHw0sA+zw0zCgnsFYW+9A==

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


