Return-Path: <linux-nfs+bounces-17104-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D9CCBF641
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 19:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DBBD301E98D
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 18:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62115322C73;
	Mon, 15 Dec 2025 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c6vSqQ5s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4319312807
	for <linux-nfs@vger.kernel.org>; Mon, 15 Dec 2025 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765822489; cv=none; b=H5JdB+EE++/FxKCqQ16HMDkLIEkfCSqNcccTbGXi+fAzVzM/jfk8Sr5kVJuZXr6TC0zcmO99vHrWotKlchpxPFxyiVp/wKQhtNBqbTlpOtja6Ar1679UPEycNq8PzbHr2AjzVy24DV1c1A8eYKTWBxMguAo01auQsr6za65vdfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765822489; c=relaxed/simple;
	bh=ImxRKSRexPJXHxUw+iWq31uzf6wlO3cM0usNU5xDf6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Po7n/pKQQRRnm36BeazdSutZe+y/ZjTT5nBPkBrBrpsrPYBhfRlNBv6v/lI5qqLTO+sVyQ4XvjfjoT3kDAOfXhp3wt1AUvTvfoVrZCpFZL7u8eIAYKZxGhgxmaJyE8sgUZ8hFAjLys2Sz/428g8KClgo2449PCdKy/DZRhZaZ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c6vSqQ5s; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFFNNvj2650115;
	Mon, 15 Dec 2025 18:14:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=4SbgnQmuJiXGux7nExMh6sFSP9RGc
	qJUwGdDLLZNEkE=; b=c6vSqQ5s6iTt6bg0O+/aM9OVj66/Jh4PIx/IeyMAakGBD
	h9MlT7V9fwhEl64Fm7J4QsDiBJZ1MGgTqRGSmJgkMRu5uRXqQ+VAYZI10up7GWOS
	Ol0P0UPePjoT/3nHY/n4/VfE4Tjp8Am96yInqVAwqp98Opc1/xcP4FN0TdVNvGhV
	JQAmuotLC7uuQ4xifxTP9xhiiIk5QsuQC9Ffzia8gLV91cBi3luYxwd1Ka5/TKkN
	B7d+GRaUWATcUGGV3IV+2vmMxii1T58D85seo1INSNk9SJ/JVf0bwJvUirU+8ZZ+
	jGGn04zGEjrkg+0w+yTerX4hgx3gh8biCLRfDXjdA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b106cah68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 18:14:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFHrhBg024826;
	Mon, 15 Dec 2025 18:14:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk98b8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 18:14:24 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BFIEOYG011653;
	Mon, 15 Dec 2025 18:14:24 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4b0xk98b7y-1;
	Mon, 15 Dec 2025 18:14:24 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 0/3] NFSD: Prevent dupplicate SCSI fencing operation.
Date: Mon, 15 Dec 2025 10:13:32 -0800
Message-ID: <20251215181418.2201035-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_04,2025-12-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150158
X-Proofpoint-ORIG-GUID: 9vDvwvgxs5HMuFS0UfdzIYEGb-s2FIQM
X-Proofpoint-GUID: 9vDvwvgxs5HMuFS0UfdzIYEGb-s2FIQM
X-Authority-Analysis: v=2.4 cv=et/SD4pX c=1 sm=1 tr=0 ts=69405001 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Sr0U8fyxAOGNvxHOk2YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDE1OCBTYWx0ZWRfX3YAN3EBSYEce
 moajboo1OKGleb9iqUC/Wv8tHAFbTe39m8KN9ann2BWtAPdvP//gNu9nZoHABQ8ch7koovAwHGQ
 RqXCCDfwSo5R0bheiDXliLzR8hwH3xDYhuetdTItax1bTJlbtOgIz3s9fT7qp1sIhlFH7oCb9e6
 Lkipa3RikY3rWHWnnQrjDDGLdbSUywH/mZyj/fbQSwf8xbydyyvA5yU9xbNH2kAhLUxsWceX/UL
 YpYNrgNV3jJksEtt4TYZHQ4yMOsmcRjxQl44QWDENyMn9o5tKo6u7hrZWOH8zrfIXK4LOiH25E2
 wSHBmca6pqSIc4s5VQ5LDhS7bi0U4ryhnIKNWBkSuSYsdUdDdV6+/9ShvMCQggzSf4yEErlVbJ+
 XuUS8U9igLdjSxupxLz58C4fTRNapA==

This patchset implements a mechanism to avoid issuing redundant
SCSI client fencing operations for the same client and SCSI device:

Introduce a hash table per net namespace to store records of clients
that has been assigned persistent registration key to use for
accessing the SCSI block devices.

Each record contains the clientID, dev_t of the SCSI block device
and a flag to indicate whether the client was fenced.

When the server hands out the client registration key, it creates
a record with the fence flag set to False and inserts this record
into the hash table.
 
When a client needs to be fenced, the server looks up the client's
registration record and checks the fenced flag to see if the
fencing op needs to be issued.
 
When the client sends the GETDEVINFO for a new layout, the server
resets the fenced flag back to False.

When the client unmounts the share, all records belong to this
client are removed by __destroy_client.

All client records and the hash table are freed when the net
namespace is shutdown.

Dai Ngo (3):
NFSD: Move clientid_hashval and same_clid to header files
NFSD: Add infrastructure for tracking persistent SCSI registration keys
NFSD: Prevent redundant SCSI fencing operations

 fs/nfsd/blocklayout.c | 145 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/netns.h       |   2 +
 fs/nfsd/nfs4state.c   |  16 +----
 fs/nfsd/nfsd.h        |  19 ++++++
 fs/nfsd/nfssvc.c      |   9 ++-
 fs/nfsd/pnfs.h        |  11 ++++
 fs/nfsd/state.h       |   5 ++
 7 files changed, 189 insertions(+), 18 deletions(-)


