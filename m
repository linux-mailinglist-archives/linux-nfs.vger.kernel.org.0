Return-Path: <linux-nfs+bounces-12255-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C865AD399A
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 15:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E53316112B
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 13:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB8323ABA1;
	Tue, 10 Jun 2025 13:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XiaE2qbZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25D523ABAC
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749562904; cv=none; b=HjSEtHiel86Em639ztdeh5YzPH8JMOxGzSXzBWVGOSHAphP4eveFADJQQH3U0NjZtybEM4joPV/uLtp2BE1EH8yGywk5vRnO0+XK9OJAUAqvgwtDr9r71iqMQcrR4iqKBZyJiewEKRLnAcYifKz32zqorSJXmeK0yHqgEmSWCK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749562904; c=relaxed/simple;
	bh=tY6XSyW7rse1rgQKlexc1id7nBy6YEUBUbde+MFNquE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=hV622769X9NHT7Vh1kiXq9cHNiqds6Ghb9DY5ogttnlK4/RE+skMUBiWjptJs0XfV7aCzPFncpGX9z1/IhJ2Iq99rjlmBfoNyP0RmwE9UajqPjHV4SdUlfq9U34QeAaOgXf1JwEoheNp2ePL6vWFFah1suqnPx086+6zjZjN4GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XiaE2qbZ; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ADBd1H004552;
	Tue, 10 Jun 2025 13:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:message-id:subject:to; s=corp-2025-04-25; bh=WJIOds2o
	WDGMpjp7KxeoGmqn70X1rV6+JuCssbBE2/I=; b=XiaE2qbZjXq5Ek4ewemJ2gmf
	EEbFFoMxQXpnBN7JoqOzOmMMCiDbs7JFn2aliqCmtoSephZdyA7xBwZxYl4G1tA1
	pBR1UT15tlIpWxtb+hOM0f8qh8nEkM/OdkHR0tYA6HoDrF9IjILOsrfcwnIWbdmN
	Z0qWlclAPPYUiAIgDkTZ0dEaD2cXAf0VemEYSN6cHaUxyyAgSAdTwkmtY9pu6Viy
	HkOlmM17ZsxNWCv+FhypvGPkzw7ibHcwGcWI6mS4q5tDcu1XBA+FUboaKUjaIqCn
	1KursL5zR74fWNQG21r6/QoqSScczrRr0xMczHqfCPCSM14ypca0f2yECM1LOQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c14c8fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 13:41:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55ADKD3B031381;
	Tue, 10 Jun 2025 13:41:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv8rfdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 13:41:34 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55ADfYnm031051;
	Tue, 10 Jun 2025 13:41:34 GMT
Received: from ca-common-sca.us.oracle.com (ca-common-sca.us.oracle.com [10.132.20.202])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 474bv8rfd5-1;
	Tue, 10 Jun 2025 13:41:34 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSD: detect mismatch of file handle and delegation stateid in OPEN op
Date: Tue, 10 Jun 2025 06:41:15 -0700
Message-Id: <1749562875-28701-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100107
X-Proofpoint-GUID: 7IP7rDwvrq9bqoSZeX2rNxo_Hkvos_U5
X-Authority-Analysis: v=2.4 cv=GcEXnRXL c=1 sm=1 tr=0 ts=6848360f cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=dv7yLmii4J__HpRdnGMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEwNyBTYWx0ZWRfX6hzLjjZ9LKWe gy7fMcGofAq9WGzfHSrH1MiFGZnF17cLioS0PLzHuEoVQQ5IR8pLChDlm9HWAsakomTJKehWpN9 kaqVsVVMlifIt41Zu2u6BnXVJTEI9ji/jKOSjzTiyS4OsuvQqGzhnUHrb396OjHjwCjcoGS7Qrz
 gyJT1CV7QPdJHWMU0k2qSdm+dBuR84WgKy+Fos87arzFDXBYT4s0ZqvsNN7KgCt+GJsxZUlTEIz jKc75EQJ2bgYyLhNZ1UGwsz7BLlN6QGXSoZI0bEBRhPc+oYImQ90U0yeXJCqCSaM0CrcfMZHxov /pKnaf08jBHV59zKqxHPRIkq7jFpqwQEL5N1hQydWAo7HdAs4OzK7hi+7wdb7GNh70Mi4NoBSFG
 osvvrCLhxLpg9cx+ydJTU81rCLGEN3xE7d85C8Orm67HrO9o4VQvDd4x8/dIJoFpXKmpywei
X-Proofpoint-ORIG-GUID: 7IP7rDwvrq9bqoSZeX2rNxo_Hkvos_U5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

When the client sends an OPEN with claim type CLAIM_DELEG_CUR_FH or
CLAIM_DELEGATION_CUR, the delegation stateid and the file handle
must belongs to the same file, otherwise return NFS4ERR_BAD_STATEID.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 59a693f22452..be2ee641a22d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6318,6 +6318,11 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 		status = nfs4_check_deleg(cl, open, &dp);
 		if (status)
 			goto out;
+		if (dp && nfsd4_is_deleg_cur(open) &&
+				(dp->dl_stid.sc_file != fp)) {
+			status = nfserr_bad_stateid;
+			goto out;
+		}
 		stp = nfsd4_find_and_lock_existing_open(fp, open);
 	} else {
 		open->op_file = NULL;
-- 
2.43.5


