Return-Path: <linux-nfs+bounces-2925-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8128A8ADC1B
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 05:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADB24B22183
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 03:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CC618AED;
	Tue, 23 Apr 2024 03:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iXSamUlo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E2618049
	for <linux-nfs@vger.kernel.org>; Tue, 23 Apr 2024 03:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713841971; cv=none; b=srrJUwTWUNgHoSK8KxBmZbpo413wfUT0ncvHzBxqP4tvVAfJf6xB5N/DhXAc+Jws3Nrm8AFe2QN5Ju90uRt2fuGR0j3iUGlu2BnFQ7lxdQmTgjkvcc5C9j5Iv7oGO1YCNW/OeyJuEEBgkvaMIwSa3TU+brpq19S5h5SI/HmgMlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713841971; c=relaxed/simple;
	bh=XhUO1tt436EWYLvr2NFHeAYCECHX1TZvWeGtddLQJM4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=PrcXvbYZ9w0Cu9krruHfmK2XjhTbCIJ/pqlzaCsBTa+mwBZvMhWUm8sSnilF8l3eSRiEos6sfCnoo2rLgw08NDNzI8Uz4vYd3U1ghYfrrAO/Er/3nAcrjJlC/QY6NPhabfESbQVm1mVq9kt/R//lX501RzUsrFmFLBYsvRR3COw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iXSamUlo; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MHnOoY013914;
	Tue, 23 Apr 2024 03:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=EL08xpwGisc4q476xwEH4g0LKuLk2SKDCtku78GMlno=;
 b=iXSamUloakTYPHwZj2lFMC4r4MRfGUbY1tPjxS0THXvWixrN3PDjUKIBmBKV7AaVvCck
 5hmhdvtoFCsidowccOaf13XDvZK2xf+ncywqABwuq3xE1g11MzXYkgZhLDePPnfumxX+
 F+5bFrBHLMnLr7fjvWFwkdzDgWoQYAZWklFBJccRgkZK0rJatI0Aa2BZnM0Bh43Tmsmm
 Z9MCO1U3XZ6OSkuBS0R/UeT8baJYFVg65er2lzuLB/TjUcpDPLcfs2mG0utk0prStYlS
 gMhSYKzrPCEW+vjbHrbKlcGDzuD4Fxu/wAVK/fnEu995agXfYqwSuuZJ8zfZUY1NI5zG Xw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4a2c4gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 03:12:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43N0eIdL040675;
	Tue, 23 Apr 2024 03:12:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm456j41y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 03:12:45 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43N3CjTj016779;
	Tue, 23 Apr 2024 03:12:45 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xm456j41v-1;
	Tue, 23 Apr 2024 03:12:45 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: PATCH [v2 0/3] NFSD: drop TCP connections when NFSv4 client enters courtesy state
Date: Mon, 22 Apr 2024 20:12:30 -0700
Message-Id: <1713841953-19594-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_02,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404230008
X-Proofpoint-GUID: 8ll8Wi6QWoxWoIegxmHY9EXaEjqBHGA8
X-Proofpoint-ORIG-GUID: 8ll8Wi6QWoxWoIegxmHY9EXaEjqBHGA8
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

When a v4.0 client enters courtesy state all its v4 states remain valid
and its fore and back channel TCP connection remained in ESTABLISHED
state until the TCP keep-alive mechanism timed out and shuts down the
back channel connection. The fore channel connection remains in ESTABLISHED
state between 6 - 12 minutes before the NFSv4 server's 6-minute idle timer
(svc_age_temp_xprts) shuts down the idle connection.

Since NFSv4.1 mount uses the same TCP connection for both fore and back
channel connection there is no TCP keep-alive packet sent from the server
to the client. The server's idle timer does not shutdown an idle v4.1
connection since the svc_xprt->xpt_ref is more than 1:  1 for sv_tempsocks
list, one for the session's nfsd4_conn and 1 for the back channel.
 
To conserve system resources in large configuration where there are lots
of idle clients, this patch series drop the fore and back channel connection
of NFSv4 client as soon as it enters the courtesy state. The fore and back
channel connections are automatically re-established when the courtesy
client reconnects.

v1 - v2:
[patch 3/3]: a more reliable way to check if the connection needs to be dropped. 

 fs/nfsd/nfs4callback.c | 14 ++++++++++++--
 fs/nfsd/nfs4state.c    | 32 ++++++++++++++++++++++++++++++--
 fs/nfsd/state.h        |  2 ++
 3 files changed, 44 insertions(+), 4 deletions(-)


