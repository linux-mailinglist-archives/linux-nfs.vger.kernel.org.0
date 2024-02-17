Return-Path: <linux-nfs+bounces-2006-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AFD85916A
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Feb 2024 19:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2831A1F21E4C
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Feb 2024 18:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AD87C6E9;
	Sat, 17 Feb 2024 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PoB3swff"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D867CF1A
	for <linux-nfs@vger.kernel.org>; Sat, 17 Feb 2024 18:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708192843; cv=none; b=c3hs+IIlIPrk/ovwLmkXb5l/mEtxXt8LKvnSPH/dQSF/p0nz/0sbVFVWOXCn+TUNkViOPQw8aDEiXWgI0fFPzkLyoRbZid2WVMhN+MXQZjsFV4QtUqNUjQU/O37qJsA3+OyRH1hu7ojhjgg+LJZFFbaE7KGG97WT0dWsQNM5tPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708192843; c=relaxed/simple;
	bh=92bikQuawQZ4hcRLwmd+4JEE5TaAuRFK09PbDDM4Ig4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=R9xaPXRvAaiG/qS1tCwLgwq0QjMsp3xOetkZJ0hsn33bnlkwwvl+zEk+FgfZX26zG6wdyhc7gWIFwENwJNaoBu4hRaBDneUpgHz/CLw2iMcpgld7CSr121uwLLhhCeBSiwt0dgI6AhSeqhASrQLVSwR3Xcxjft+UNhkUjmBdAGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PoB3swff; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41HClfRR008835;
	Sat, 17 Feb 2024 18:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=conn1qeVCd5MKBqlyNm8oIyOtM+Rxhc47+DijBwXDNg=;
 b=PoB3swffOseFRWKXclQGvf0ZDyvFBEhjA0dHcDfOg4myatPCqYaZq7K9qxSTWDJh/u3b
 12RLkAX7aLalc4CFtH23ABy/NZ5nuxqi64/a1cBGgG8pXnda7ohky0lP7qiwIbQpjFOC
 R6tTxBNQNEoxdKJRJ2lrPMgS5wjtFpdS6owxaN4Ms73FIUkL07mgWUXSiOBXwuNYNzvF
 OZQVNeJlgg4mY2oRs/qs28g3Hgn07zgkGH0vo6xwcEBRRWaJV3bfBYXrfIeQLNQhdWeG
 kCPk9FxmnntHtz0o3h0QTHAYQ8agGejj9aW+UTygKHhBo5+RrlSZ6+TRzSi+Nxmj2nb9 Rg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakd212re-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Feb 2024 18:00:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41HHrKVx000772;
	Sat, 17 Feb 2024 18:00:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8442w4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Feb 2024 18:00:36 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41HI0ais009447;
	Sat, 17 Feb 2024 18:00:36 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3wak8442v3-1;
	Sat, 17 Feb 2024 18:00:36 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSD: OP_CB_RECALL_ANY should recall both read and write delegations
Date: Sat, 17 Feb 2024 10:00:22 -0800
Message-Id: <1708192822-24533-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-17_16,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402170147
X-Proofpoint-GUID: 3GwoEBtigdBd3hbAMkITLvv1K03vSYDB
X-Proofpoint-ORIG-GUID: 3GwoEBtigdBd3hbAMkITLvv1K03vSYDB
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

Add RCA4_TYPE_MASK_WDATA_DLG to ra_bmval bitmask of OP_CB_RECALL_ANY

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 948148182cc5..fdc95bfbfbb6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6611,6 +6611,8 @@ deleg_reaper(struct nfsd_net *nn)
 		list_del_init(&clp->cl_ra_cblist);
 		clp->cl_ra->ra_keep = 0;
 		clp->cl_ra->ra_bmval[0] = BIT(RCA4_TYPE_MASK_RDATA_DLG);
+		clp->cl_ra->ra_bmval[0] = BIT(RCA4_TYPE_MASK_RDATA_DLG) |
+						BIT(RCA4_TYPE_MASK_WDATA_DLG);
 		trace_nfsd_cb_recall_any(clp->cl_ra);
 		nfsd4_run_cb(&clp->cl_ra->ra_cb);
 	}
-- 
2.39.3


