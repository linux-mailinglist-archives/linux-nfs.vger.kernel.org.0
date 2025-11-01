Return-Path: <linux-nfs+bounces-15868-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8B1C285B4
	for <lists+linux-nfs@lfdr.de>; Sat, 01 Nov 2025 19:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9AFB64E623A
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Nov 2025 18:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F782FC870;
	Sat,  1 Nov 2025 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jYS1ofE0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECF62FC034
	for <linux-nfs@vger.kernel.org>; Sat,  1 Nov 2025 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762023164; cv=none; b=Y8EEYcRs7PoRn0bWjdKTaZjIv/S8gF7CobH2sYKT4OYme1kthrtGs/IHaPI4lZcsqPULw5CnP2mQerE3aUxq4TJ7MlGVx/Q93RDnURKpwF6X/J4a0VvyJvsQAw0u315v5zFcxGtMqXO3vQQd/xNnLznyiG721tibubBoF4psjH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762023164; c=relaxed/simple;
	bh=HxktpJVdVep5EwpI9wmyIFWKYxfsvKi2TY8vOxBBTB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iUOg1KZe2M/EAb0fQDSfmwy79L78gvXHiS5UnveATl4BQp+0260l/H1Hb+x05pjjKCufRhOQbDltbX7lzUQzqHWaYgPdtAveAErOILPMcP4a12St1enuOc7THBB9tGDzPU7pLnGkjPWSrrFMcQ/1QTMjGoIiGTQ+MgxBK11m1KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jYS1ofE0; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A1ImLKo032602;
	Sat, 1 Nov 2025 18:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=qy50OozYEmDubjffEGGEYvZbYrFcZ
	7ph2SrRUhwf74o=; b=jYS1ofE0yMRwl2zvp2kCaQadpOy3eIPnB0xxlWdn85ERK
	SZ2thn/PLqtXRit70QvW7pUFEsATKuIjJa2WIlpEncSIjvGBm1ETzbyaXpEiYZ+G
	JYYwjFj1CDU3bz00ookE/HSJr/jp005p0U3uug/MkC2k1FeKRbQZxZdKXvNryPQR
	HHc3UxmQMczizJb863qaMcsZDepMMiZC6twp38Vt2de4XE1IPLNOBRk8vZUjQCC6
	AgK4pIuyMNOOIUA/g7bltAqE9K7vp9FW3d9VSDE/qnxDUF+lkR8VaT60Z72vxbNy
	KTL2NN2z3fQt/MSSTM7Ui3npb+/Viia1aIkEYAhWA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a5qrer06c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Nov 2025 18:52:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A1Galfx016126;
	Sat, 1 Nov 2025 18:52:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58n6ggku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Nov 2025 18:52:29 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A1IqTSc011363;
	Sat, 1 Nov 2025 18:52:29 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a58n6ggks-1;
	Sat, 01 Nov 2025 18:52:29 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 0/3] NFSD: Fix problem with nfsd4_scsi_fence_client
Date: Sat,  1 Nov 2025 11:51:32 -0700
Message-ID: <20251101185220.663905-1-dai.ngo@oracle.com>
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
 definitions=2025-11-01_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=896 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511010162
X-Proofpoint-GUID: xtNYefCr4lLaD6p8nZAlFjGWSlCNsdir
X-Authority-Analysis: v=2.4 cv=PPACOPqC c=1 sm=1 tr=0 ts=690656ee cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RW3XJV8fc_BcVAEsi_wA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: xtNYefCr4lLaD6p8nZAlFjGWSlCNsdir
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDE2MSBTYWx0ZWRfX6xii2eXHrcYw
 Xal3zEUIqom1K4uKDncOS+e89SeVuiEbcLQqZDRqabc4imhFN2Ls2vqQkdUNM5b6aZwiMQdjbMh
 MNIBZtq9Jf0OQ1nq6zKTdfxn8g09A3ViJb7hdOIc/MHL6FCuu3iq50HWMW/37O6wKBC7bCOZeqW
 ujM8kYwtrvsgFtIKw50o/8EDTzu4N8SQgCNvu0lz35Psd3Mv6K/W5EugBTkWzoaz+Lv3WQaYQzX
 JsyKZLc6u5l7UZ8TMPEZfyuLTo3pD09qpbPMJK2m8ZB31/OohDFY8BN2zw9/BugMPAG12JE6XZ7
 nDJngxK9gACVsD+ibq9caw6hpgv5zQhnFetl4zrsyBt0QueROo3DguzJDiDfPxwWdV8ilsNEFLE
 xIqtF29e2lu1nS/+aK72EQ4Gpx8moQ==

[resend with subject line]

This patch series includes the following:

. Fix problem with nfsd4_scsi_fence_client using the wrong reservation
type.
. No need to fence the client when server receives
NFS4ERR_RETRY_UNCACHED_REP.
  This error means the client has seen and replied to the layout recall.
. Add trace point to track SCSI preempt operation.

 fs/nfsd/blocklayout.c |  7 +++++--
 fs/nfsd/nfs4layouts.c |  6 ++++++
 fs/nfsd/trace.h       | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 2 deletions(-)


