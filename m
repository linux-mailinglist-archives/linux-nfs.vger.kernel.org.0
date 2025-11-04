Return-Path: <linux-nfs+bounces-16019-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E52DC325B3
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 18:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5400C3A5CF9
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 17:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB01338592;
	Tue,  4 Nov 2025 17:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kGztvYXE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94B5321F5F
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 17:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277492; cv=none; b=Y5AJ0mgBg2zVPgo7FZVFjsPO6HrsABglxLdSHThYNFW3ZBfpKQr0CbRkpxtgQSeBDZu3HW1KhtIVPkgbhH9Zr2d9XX4ZlJIh7XpvE07zNgH0wHZbUrifU9t1cKs32ulfL3FgXzM0mDWkQitHGrK4NpQNSxPtcbN6hRGZvnzzXXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277492; c=relaxed/simple;
	bh=kenGf9PaSZG5ns5nvxhqW0ZCX32+spz3LtYZEfdS3L8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TUT4gwX5v+Yo9EKt8MA2ClaQ/CgH8AGsqsnzFh1RW6t34rODl6c2cXgngq2ZcUpZmVlURSmO/NW22PWfVPAsC09ZHD09ercS4fwHr69NF5nfw53nmSYcDBEDr8S2EOI8VsezD9MV/NJ4EZkfxxl8OO/iEn+DJI+sk8YyLT6ADwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kGztvYXE; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4HNKOU020118;
	Tue, 4 Nov 2025 17:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=ViTDY/7Stlj+WbRWP7LCbPqnatrf5
	BNe9FAVxhGWDhg=; b=kGztvYXEwhdos82/LmdrJUup+mTSozplF54tzvV9/i5uA
	etMXyDg6KBRfnkTvTCWPgVe6Yn/zT2Q1fqMmrBPpYS14TYIhThdp7H5MeU65kihU
	eIHR8yKuxowBhsCpbRTPGkee6rGiNkbMkQ8vvrS4jqDia1ZCQbStaecOUTCTpRLQ
	/n0Dh7kFWI24y0hFVwQdjFldCMPvOhM+4eOIiaLXg6gU7binTNPA+gaAyXC3XEZF
	QYP5D4ZDv02pHLzBm1/p2/N0NxM1NnwTD0xDWby9TkbfySEG5boOBBMmTuinw0Xv
	jAR2+C8m37fdqKcwx3p8yjjJo5RBkUKPniuvZd49w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a7nmw8255-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 17:31:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4GiRlI010082;
	Tue, 4 Nov 2025 17:31:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nddwn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 17:31:16 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A4HVFvk033666;
	Tue, 4 Nov 2025 17:31:15 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4a58nddwmf-1;
	Tue, 04 Nov 2025 17:31:15 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/2] NFSD: Fix problem with nfsd4_scsi_fence_client
Date: Tue,  4 Nov 2025 09:27:24 -0800
Message-ID: <20251104173103.2893787-1-dai.ngo@oracle.com>
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
 definitions=2025-11-04_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=988 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511040146
X-Proofpoint-GUID: jqb48KVolmx8z-i5mcgqGDx-mrm_XBac
X-Authority-Analysis: v=2.4 cv=cPftc1eN c=1 sm=1 tr=0 ts=690a3865 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Oy427_yKbc5DmoRKTR8A:9 cc=ntf
 awl=host:12123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE0NCBTYWx0ZWRfX36DGo0qhCJyw
 diS0nud0+77cOjuITfcFBjA3mrEfBMvth8sSsn16pgm5NRHYARfRGTiy/79w5a63zcsVTvvjhDG
 X5b5U25Wqm6n0+FdxuJVKeejG8/WftSd8LTstXq730PFS+4nhZ72yRPWhTKWPoPQ/uNw888gm/3
 oevbY1fvhyE0cbjHUbmpH13EiwNlNXvFDnsJD7sGlbLmKNpSs6LlEC0/GwZWVqZmxOsyk9AkWUU
 AVPYDE+0oAIYsMDs0LPg8NzVGzUgABgSN5wXQmQN3QN90ytR+++uh0Qmpu0qqeYgTNk+ninDXP1
 15KDYUZil0jquLmnCWPSw4c8uPAaoAKQp5cd3qx7U+dSNAVxooKkVBu8HdlFOlvLBSTzfT7OG2O
 6IY8qcgHvh1cQUCyWrHWTUTxrhpxh1O3ecf+kUNgDeZvaAkPkO4=
X-Proofpoint-ORIG-GUID: jqb48KVolmx8z-i5mcgqGDx-mrm_XBac

This patchset includes the following:

. Fix problem with nfsd4_scsi_fence_client using the wrong reservation
type.
. Add trace point to track SCSI preempt operation.

v2:
. fix overly long line in nfsd4_scsi_fence_client
. drop patch that skips fencing on NFS4ERR_RETRY_UNCACHED_REP
. add net namespace number in output of fencing trace point

 fs/nfsd/blocklayout.c |  8 ++++++--
 fs/nfsd/trace.h       | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 2 deletions(-)



