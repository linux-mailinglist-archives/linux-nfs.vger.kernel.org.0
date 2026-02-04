Return-Path: <linux-nfs+bounces-18730-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPF9HXO1g2nItAMAu9opvQ
	(envelope-from <linux-nfs+bounces-18730-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 22:09:07 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF26ECA74
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 22:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6BDB301F991
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 21:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E970394460;
	Wed,  4 Feb 2026 21:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VQEuKXPS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B27831814F
	for <linux-nfs@vger.kernel.org>; Wed,  4 Feb 2026 21:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770239323; cv=none; b=SA+dyHFTvvVnEzNnFSUmcRJ7yWliHDxvq03gkhmYutbOLdfL7e0gSjJeDz2cezrv7oMD+Nu9dApQ7Sfm3abEYnJ5H2BDm3NPFaeMXhWcDjYBhTB8Ik4n3DGKVEFV1b3mcMn7FtCo4nS0ElTeNHk5CLNBE9vBXsefnuFXRXH2mjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770239323; c=relaxed/simple;
	bh=r954+8kvwm8qAPiOuq+MOZVsNXJ519kbhiau5Q9ekbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dKlJkrb1I7BAfOHtwDlNlIrU+D2CIzW5eCeQVsJZEqK6+LqcnlX98uqYazXykX3Mj4qbDN+pjJXGP9kj3Ko7h0j3SDzPqYs4vBA9JLE43GSInRKIx6iuNZOXC7ZjsX19XYynCgq+ajRRKfmCorsPUTK1DAUZDov1JOxgWPFyvb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VQEuKXPS; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614DOFXG1716183;
	Wed, 4 Feb 2026 21:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=pmCfWTEldGsgRI6c+/3wodGOTKgiJ
	lw+bz/b8iRq0MY=; b=VQEuKXPSlr2+Y47uOUJ4pXqIj9E0+aJdYdG38kb4Jt5JS
	SXVPtSfjMIHRCVC6clmViRbxm6fHHNIb5D7Ab9WVzgVBp9SyOy4hGxLM0HzlslwX
	LWJunbnU/9SdgTAlD3MXQVJzcWJvq20IxTnAGIsIBv8OoPUq4sdOYbYI2u9rCFj8
	dsMr5OKNW+ScGg+InGasLESm35oMflrXrl2dENxqN4Ze11DcrQadO/quDpej/yf8
	R6Npt8VML6zvM57WlPoywGeoPIXtsp9RLhsb0NwBknUxNmeCGiD18N+uwwcdrfcQ
	ni+pbio7opNFfh8NGTyrWYcP6ciK6mkbyRlu6IE/g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3jhb2qd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 21:08:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 614KrGm7018820;
	Wed, 4 Feb 2026 21:08:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c186phyj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 21:08:31 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 614L8Uk9023239;
	Wed, 4 Feb 2026 21:08:30 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4c186phyaq-1;
	Wed, 04 Feb 2026 21:08:30 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neil@brown.name,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSD: fix nfs4_file access extra count in nfsd4_add_rdaccess_to_wrdeleg
Date: Wed,  4 Feb 2026 13:07:43 -0800
Message-ID: <20260204210807.4134644-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_07,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602040162
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDE2MSBTYWx0ZWRfX9zlEcJyN4X2l
 yzhSP8Qe3UbRLHDUheF+c6SBDozbIvQKj/rqv9XrW88mCNXSJqSIDMskl7jaJKcAmpKa2uOc9gl
 dNooHoUgjEa7e98jjFDVr291KG8jpwSr5A5lViC1I/Swli2j2yzmtcPM2/xROGnotxbVz/qJ/U6
 kYnFi8wGqJM0uATdp4pbokt/wav5MuVJ83cjWDTqZeIav3EfAqt+mSzLO4APMJmrk6WQ7rjCwzV
 s8/QI/aI+mkk8C4usdjOZ8UU6Ba7fax+tDInPNHRnC7dtIE6pN4p2hL8RPFGkg6zQE+PGAeDM80
 0VGMY7NymgJNdqxvHCySk2af5aq+VNPPgH0dVSa1KfrveVeB5fLxcWylEIE5Cq7IFhh2xE3uxmx
 Zg66EQU8xxtYKEKNrDnt89GR/CZMPCmW0nNgbFcHSeB1m58YWC98PEYDTIgVzJwjKv7n+Yq374r
 DCfdHqhlOcF7kWpPr5kUmONqaxr4AKOG0o1zJxBg=
X-Proofpoint-ORIG-GUID: 3KXc0A69xGxKQ6WsuAExKavyRk6DqJm_
X-Proofpoint-GUID: 3KXc0A69xGxKQ6WsuAExKavyRk6DqJm_
X-Authority-Analysis: v=2.4 cv=CaYFJbrl c=1 sm=1 tr=0 ts=6983b550 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=Sh_E-nMN5rk4CSTRxpwA:9 cc=ntf awl=host:12103
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_SEVEN(0.00)[9];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-18730-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:dkim,oracle.com:mid]
X-Rspamd-Queue-Id: CBF26ECA74
X-Rspamd-Action: no action

In nfsd4_add_rdaccess_to_wrdeleg, when there is a race condition where
fp->fi_fds[O_RDONLY] is not NULL, __nfs4_file_get_access should not be
called to increment the access count nfs4_file since that was already
done by the thread that adds READ access to the file. The extra fi_access
count in nfs4_file can prevent the corresponding nfsd_file to be freed.

When stopping nfs-server service, these extra access counts trigger a
BUG in kmem_cache_destroy() that shows nfsd_file object remaining on
__kmem_cache_shutdown.

This problem can be reproduced by running the git test.

Fixes: 8072e34e1387 ("nfsd: fix nfsd_file reference leak in nfsd4_add_rdaccess_to_wrdeleg()")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d5e0f3a52d4f..66babf8fadcb 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6252,12 +6252,12 @@ nfsd4_add_rdaccess_to_wrdeleg(struct svc_rqst *rqstp, struct nfsd4_open *open,
 			return (false);
 		fp = stp->st_stid.sc_file;
 		spin_lock(&fp->fi_lock);
-		__nfs4_file_get_access(fp, NFS4_SHARE_ACCESS_READ);
 		if (!fp->fi_fds[O_RDONLY]) {
+			__nfs4_file_get_access(fp, NFS4_SHARE_ACCESS_READ);
 			fp->fi_fds[O_RDONLY] = nf;
+			fp->fi_rdeleg_file = nfsd_file_get(fp->fi_fds[O_RDONLY]);
 			nf = NULL;
 		}
-		fp->fi_rdeleg_file = nfsd_file_get(fp->fi_fds[O_RDONLY]);
 		spin_unlock(&fp->fi_lock);
 		if (nf)
 			nfsd_file_put(nf);
-- 
2.47.3


