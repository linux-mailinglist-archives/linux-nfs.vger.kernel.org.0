Return-Path: <linux-nfs+bounces-1254-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30044836FFC
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 19:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FEE3B2FEF6
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 18:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D11537EB;
	Mon, 22 Jan 2024 17:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BQ11oMDa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4093D55C
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jan 2024 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944240; cv=none; b=dBLgFo3QD99DYXmPHVo+BpFi8yl6jN8OYJyI0c8jc1j0okNtEwEIywM089P3YlJHqZGFDZy9S5DsR2OEAt7G2USEvw7MhU7DHa0rFznPf0fmnH7GTDZY+VHRXufxZ3YBb+2daeQ7gldGw/5Bcw3YqXTPpUmdZklHsV33HZDbWno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944240; c=relaxed/simple;
	bh=ZwObFOSQp/rsE4GnT0zWBH1G3Q3nQSVLy0Efxxkb87M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BE55DftiS3vGMXtjG0cTCqVaI3zCLX9ZacfwoMw9uYUKnu74ojii1DGAtW1VAbNnaU97ISOgc2NgeUQzDcIjbq2lHs4mxUlIs8o5g5NgJY6FZWyUC5Gj8haNJjyG2jhP7qQMqu2fwX2szhMLlzy0uxw8odlWAo0x2aONuuGlm5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BQ11oMDa; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40MGJoHW008675;
	Mon, 22 Jan 2024 17:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=+gKdnOMBxLtTy+mhjx4V6R3YBkY/N+Q1iya9dwGeWQg=;
 b=BQ11oMDawNbFepThmAHaEwxy02+hgTnFBPMpw1QZbLypyaEe1fcgYq1vbwF4NieHtmNu
 3EKGIZ2oA2fTvhdJQiVDQgtk33tJWolL/+PLLckhDAMUgt1yFnDadhJiEFOPX+wUwkwo
 cVU7cGmpjE56cf5qi9aCWS3MEmEPYRYPL80qAWyA1p+vS4bBlc8bl//kuj7n5JfW/KuV
 M1nVrIggMZmmcAaE+A8QGJJVUEJkb3+XxudrdzFWEgub4cGRJZvJLzYCYtsoN6vL4rei
 wa2giXXeyx+KVx3QeuxGHD8JjM3oEiJGdU4jDx+4f9b9Ty5Dr2cszwQwggGKrwgOWmYI +w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7anm5qg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 17:23:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40MGVUli018698;
	Mon, 22 Jan 2024 17:23:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs31401gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 17:23:54 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40MHNsHK038399;
	Mon, 22 Jan 2024 17:23:54 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vs31401gm-1;
	Mon, 22 Jan 2024 17:23:54 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: bcodding@redhat.com
Cc: samasth.norway.ananda@oracle.com, chuck.lever@oracle.com,
        linux-nfs@vger.kernel.org
Subject: [PATCH  1/1] NFSv4.1: Assign retries to timeout.to_retries instead of timeout.to_initval
Date: Mon, 22 Jan 2024 09:23:53 -0800
Message-ID: <20240122172353.2859254-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_07,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401220121
X-Proofpoint-GUID: RclOhd78irapBsQpUr-KPBSKIbF4jd7n
X-Proofpoint-ORIG-GUID: RclOhd78irapBsQpUr-KPBSKIbF4jd7n

In the else block we are assigning the req->rq_xprt->timeout->to_retries
value to timeout.to_initval, whereas it should have been assigned to
timeout.to_retries instead.

Fixes: 57331a59ac0d (“NFSv4.1: Use the nfs_client's rpc timeouts for backchannel")
Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
Hi,

I came across the patch 57331a59ac0d (“NFSv4.1: Use the nfs_client's rpc 
timeouts for backchannel") which assigns value to same variable in the
else block.  Can I please get your input on the patch?

Thank you.
---
 net/sunrpc/svc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index f60c93e5a25d..295266a50244 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1601,7 +1601,7 @@ void svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp)
 		timeout.to_retries = rqstp->bc_to_initval;
 	} else {
 		timeout.to_initval = req->rq_xprt->timeout->to_initval;
-		timeout.to_initval = req->rq_xprt->timeout->to_retries;
+		timeout.to_retries = req->rq_xprt->timeout->to_retries;
 	}
 	memcpy(&req->rq_snd_buf, &rqstp->rq_res, sizeof(req->rq_snd_buf));
 	task = rpc_run_bc_task(req, &timeout);
-- 
2.42.0


