Return-Path: <linux-nfs+bounces-2919-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CBC8AD6AD
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Apr 2024 23:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C60BCB233FD
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Apr 2024 21:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12BA1CAB7;
	Mon, 22 Apr 2024 21:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WBk7AIcr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263231CD2C
	for <linux-nfs@vger.kernel.org>; Mon, 22 Apr 2024 21:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713821495; cv=none; b=fa1JZYOpa6ZRJ9u7TmYfChcRi+sh7H+jHZybc7gZyRGj//UYxmp2b6ibq/gToWt+NweacqPHnoVjhU/W8yrJ2pLzwivaXMaWf28rP7gRf5nIzmhhAi2AVEv+So+mVJIeGGn3jFg0Iuvn80zwJXZOgicrNxWeOJ3ta//ZeZeyq9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713821495; c=relaxed/simple;
	bh=B2fAJX/R6vZ5gNyO7GmdvCzYwZ4WsfSzJ9OcNNiipcg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=SYHgX7e2u79nu+GzBI+Q91q61VeS2Uc3cqtmm6HaHVUiq8Gm1rMz266jlsNm8jzBFkF3LOZuFrYIKP8wNhRf28zp8B9yCO+0Sipjv61E/DKJ0kJCd3FTFtBOkFNRxVNqYbVX5Qpk9+5TG5hGzQyUtiK+ZAPl133vn0ck66BvXLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WBk7AIcr; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MHnaNu014606;
	Mon, 22 Apr 2024 21:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=riXqy19BN5nQnuz0ecHAgwXhOmADuxju4/b8x+JP8C0=;
 b=WBk7AIcrqzX2dhYWN1vs6rrn2R68zC7Mx8Uh+Ijfz9aRWgcyUOvrzywfnPjvfANaSPs7
 y1BOpPm3RjWiIIAmKmh/x09/3G8VEfIq4pk5t22RmzIcNH4exiacjU4/MjkSTz3qxN70
 nwwDqtZdGATqKBTYcbcbEUquvcLY/7WODqfNwL/gkKxLLTtqaOY0Q268euMOKathSRBv
 LGu2yrRVfxbG8w1gMak6yJk+hq9HbOEb2ns+QaYKV8kwGy+yOBY+Gp5JJkr4WccLgXBS
 9sZXlv0Fm0n+u6BHwI3pL8+nfu8ju0XbufYcycCndRFsh9JHb25j9Sq3sbjp74as38sD dQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm68vbpfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 21:31:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43ML7Zdd033764;
	Mon, 22 Apr 2024 21:31:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm456980k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 21:31:29 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43MLUw1L008733;
	Mon, 22 Apr 2024 21:31:29 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xm456980c-1;
	Mon, 22 Apr 2024 21:31:29 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: PATCH [0/3] NFSD: drop TCP connections when NFSv4 client enters courtesy state
Date: Mon, 22 Apr 2024 14:31:12 -0700
Message-Id: <1713821475-21474-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_15,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404220090
X-Proofpoint-GUID: 6zHv1PxdSXGxSKtOaX_6y8jb3ApxFcgA
X-Proofpoint-ORIG-GUID: 6zHv1PxdSXGxSKtOaX_6y8jb3ApxFcgA
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

 fs/nfsd/nfs4callback.c | 14 ++++++++++++--
 fs/nfsd/nfs4state.c    | 26 +++++++++++++++++++++++++-
 fs/nfsd/state.h        |  2 ++
 3 files changed, 39 insertions(+), 3 deletions(-)


