Return-Path: <linux-nfs+bounces-1911-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 681398538E8
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Feb 2024 18:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 125F1B2A216
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Feb 2024 17:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A6160257;
	Tue, 13 Feb 2024 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EdfzP7WM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEC86024A
	for <linux-nfs@vger.kernel.org>; Tue, 13 Feb 2024 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846465; cv=none; b=DqoEXOdUNC784h0EFtc7S6nj4B3yglUiQx76LgHaFaqdnSG9XG3G/HcLmwb/NhkOZbXZVBukVBW9ds8iFDcrig1Sk/RrfDQRj7bFWz0pSgIauKIGngcwDhimCN/fD8cmEgcz17IxR4+ZRxhkaT/aNb8ZO56J5ec0nnSYoTxmPfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846465; c=relaxed/simple;
	bh=+msueTY3r5/fEl9fJfjsQ/0z3cgWitp3F3a0C9OCAS8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=cwKItLnccJejuLzL98GxAwxXEZ1oE5+jloy0OWVX3kB8ALMQqNmGTqt5iW6RiNo3aX4DcDZJiDxZGfYeeSEZFauAspWmIvSSo1lygYcarwmOfbe/WH42Q/2KD3APW+jkroOUniS9UsyzzW/VGRAJfkl6XdxGnTntNsuBsMh0bEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EdfzP7WM; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DGXHCC010256;
	Tue, 13 Feb 2024 17:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=BBIknkphlJz2VSVHhmxZsuQSPJ7mex4iKirVIQL1R4k=;
 b=EdfzP7WMY8wyNRkv2Yf8P17snFqPzmrY9fWJI5fOM13UTJTFJfV0TXoEm9hSl/VkH4dL
 Tr9Msl4/sxHN65T6GCxCT0bgrfYajnOcDtnsdMlipN4dR7p7HclbOEQ8O/pGP6FrNfII
 MNEYiNvws2+k83ywXLtcOgQ/GmntBaHqFHhu2QMErCSNScmCjYvXFbMMLFBUKqvRIt2F
 dNaxe7yfCYhD4xEZiuIyk1fr7yflh87u4tikKsyREoHC5+Bm4Rmqr0bX275qeu+K8pP2
 JaEXLqXY2tWQ0Vp0L0GerGEES7e2G6WC6nEeqmEN2Oqd/BCBt2Oz6/lCwkaX/W+0MzX/ 0w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8c1s0b4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 17:47:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41DGVNqR014965;
	Tue, 13 Feb 2024 17:47:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk7ekys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 17:47:40 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41DHhlh6002073;
	Tue, 13 Feb 2024 17:47:39 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3w5yk7eky3-1;
	Tue, 13 Feb 2024 17:47:39 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: PATCH [0/2] NFSD: use CB_GETATTR to handle GETATTR conflict with write delegation
Date: Tue, 13 Feb 2024 09:47:25 -0800
Message-Id: <1707846447-21042-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_10,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130140
X-Proofpoint-GUID: JzaJ1oMTHFNmJL7jh-aujvwm8a4rB7gJ
X-Proofpoint-ORIG-GUID: JzaJ1oMTHFNmJL7jh-aujvwm8a4rB7gJ
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

Currently GETATTR conflict with a write delegation is handled by
recalling the delegation before replying to the GETATTR.

This patch series add supports for CB_GETATTR callback to get the latest
change_info and size information of the file from the client that holds
the delegation to reply to the GETATTR from the second client.

NOTE: this patch series is mostly the same as the previous patches which
were backed out when un unrelated problem of NFSD server hang on reboot
was reported.

The only difference is the wait_on_bit() in nfsd4_deleg_getattr_conflict was
replaced with wait_on_bit_timeout() with 30ms timeout to avoid a potential
DOS attack by exhausting NFSD kernel threads with GETATTR conflicts.

 fs/nfsd/nfs4callback.c |  97 +++++++++++++++++++++++++++++++++++-
 fs/nfsd/nfs4state.c    | 119 ++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfs4xdr.c      |  10 +++-
 fs/nfsd/nfsd.h         |   1 +
 fs/nfsd/state.h        |  24 ++++++++-
 fs/nfsd/xdr4cb.h       |  18 +++++++
 6 files changed, 255 insertions(+), 14 deletions(-)

