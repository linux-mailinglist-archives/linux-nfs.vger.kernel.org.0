Return-Path: <linux-nfs+bounces-11696-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E65AB5969
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 18:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957133A60F8
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 16:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295212BE114;
	Tue, 13 May 2025 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iEIEHJMT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7870319CC39
	for <linux-nfs@vger.kernel.org>; Tue, 13 May 2025 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747152683; cv=none; b=Hql8cPUvIu72ZFQW+4dAlUTlBfDwuV9ZjrxYFlKPxJB+P1CXAJp8Pg63qcvCk+i6TCMstohic2vsBKaFjBO4siiiZ3LeftmBMSTk6D8pVOD93PVew2cI0X/r13pxVq13w9qs89Obz6UqjkdgUHe5yQqY2vi0Ut8mCiEcGoeFXOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747152683; c=relaxed/simple;
	bh=vOhvuDSiwFDqlwX89gwELQ2P/Eha1MbR8PniULTaeyo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=uAiSAkIihYKttMo8GnGWXz8iO7e2BCyNWYeewB/w8f+DZHt1dBR27IeYNB6RwXDFStZC4ipaRD5FoqIUVp33LEa3SakYMlFWIlwWmScTAXzOkjj9Yq7PbNtz0lqbe1MOvMhpxE5ZoadgO3GXVoL+8Ym4KkFf17yFANw3NAS3va8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iEIEHJMT; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DCHfNr030624;
	Tue, 13 May 2025 16:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:message-id:subject:to; s=corp-2025-04-25; bh=8iiUdiyQ
	dEqBry7gFUdXdo9Cc8M+HK4g0LMmP/K5aOk=; b=iEIEHJMT7hdibiakFfQZykeP
	oUoy0Mi2HIPOE9K9GmNx0HNGJyPB/o9n0NgnzXRyo2JjvTn61vFgYO7fDQjG5raY
	bXcaYVDYLgweMdHzfubu0nmMflTGUv1pogWFXRiuax0xijP6nIA3OCS+paADsile
	zbcH6e1U2KIKpMk8VosfNiSkMjkZ6vxvCnoWlIMfDdkWPPvix0r9h/ZJ52A6yVDr
	iZ7W0SM+6eB7bwxjEADu5EtJjKlPw4NGvlRsGpp2fdNsyUt+D32Nxe4yMuvPwWqX
	+oX1yNdZYodMV+ndO3R1RqKTAUzqL2FeaAfN324zwKdD4lqrk/wgIXcqoF3sAg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1d2d4s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 16:11:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54DFt1jD002457;
	Tue, 13 May 2025 16:11:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46jwx4j4pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 16:11:05 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54DGB5Ms008322;
	Tue, 13 May 2025 16:11:05 GMT
Received: from ca-common-sca.us.oracle.com (ca-common-sca.us.oracle.com [10.132.20.202])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 46jwx4j4nx-1;
	Tue, 13 May 2025 16:11:05 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
Subject: [PATCH 1/1] NFSD: release read access of nfs4_file when a write delegation is returned
Date: Tue, 13 May 2025 09:10:51 -0700
Message-Id: <1747152651-23087-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505130153
X-Proofpoint-ORIG-GUID: xyWhB2zYfVsX0-KsWH2VKqrlJsVeEazK
X-Proofpoint-GUID: xyWhB2zYfVsX0-KsWH2VKqrlJsVeEazK
X-Authority-Analysis: v=2.4 cv=XNcwSRhE c=1 sm=1 tr=0 ts=68236f1a b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=COxw9Bi5ev4emWpEBN8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDE1MyBTYWx0ZWRfX54ZG4nieGFal vO8ZJ9d8QPY7bmYWLZe4CmkJLncE6g0Bybk42O7yKWC9v2yLRJDga71YgJvYVB1PIh3A1y733EG cjJdGBP208cXjNV2dS4g3cOBakyQjMAxpvdNk6F2JkKMSe1NQud/0HtL+AWn3cP2Oa2J6jW4pcs
 uTzINCpEbwkCts9Ws0aiCveiHbg8A5orKXJDYqFUfWDgYhzrPV+8kI3lA3l1KyJt84KC8gLHJen qcNJ2lUYrY4ZZgTGFuc/9MDXf00PeI8PJx8beDAYF1lxhfIBybHu0cw+fJ2y5WQTDF34WF9Anvk jWfw9lKJTVwm9bzqeJJ/+Yw41CsAbk6bklL9nd98w35aaHFJkfWZ1kwbQUSQ3YUx8JslfdG0vkd
 TxYhFwUG9qq7gHMCOjS26s/S9or9QcByd538pC8QsdXyz52XIvDdpotIhJgW2TmFJAB5xj/w
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

When a write delegation is returned, check if read access was added
to nfs4_file when client opens file with WRONLY, and release it.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 9 ++++++++-
 fs/nfsd/state.h     | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2bd63594d8da..5e47d9f85ab5 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1207,14 +1207,19 @@ nfs4_inc_and_copy_stateid(stateid_t *dst, struct nfs4_stid *stid)
 static void put_deleg_file(struct nfs4_file *fp)
 {
 	struct nfsd_file *nf = NULL;
+	struct nfsd_file *rnf = NULL;
 
 	spin_lock(&fp->fi_lock);
-	if (--fp->fi_delegees == 0)
+	if (--fp->fi_delegees == 0) {
 		swap(nf, fp->fi_deleg_file);
+		swap(rnf, fp->fi_rdeleg_file);
+	}
 	spin_unlock(&fp->fi_lock);
 
 	if (nf)
 		nfsd_file_put(nf);
+	if (rnf)
+		nfs4_file_put_access(fp, NFS4_SHARE_ACCESS_READ);
 }
 
 static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
@@ -4738,6 +4743,7 @@ static void nfsd4_file_init(const struct svc_fh *fh, struct nfs4_file *fp)
 	INIT_LIST_HEAD(&fp->fi_clnt_odstate);
 	fh_copy_shallow(&fp->fi_fhandle, &fh->fh_handle);
 	fp->fi_deleg_file = NULL;
+	fp->fi_rdeleg_file = NULL;
 	fp->fi_had_conflict = false;
 	fp->fi_share_deny = 0;
 	memset(fp->fi_fds, 0, sizeof(fp->fi_fds));
@@ -6171,6 +6177,7 @@ nfsd4_add_rdaccess_to_wrdeleg(struct svc_rqst *rqstp, struct nfsd4_open *open,
 		__nfs4_file_get_access(fp, NFS4_SHARE_ACCESS_READ);
 		fp = stp->st_stid.sc_file;
 		fp->fi_fds[O_RDONLY] = nf;
+		fp->fi_rdeleg_file = nf;
 		spin_unlock(&fp->fi_lock);
 	}
 	return true;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 1995bca158b8..8adc2550129e 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -665,6 +665,7 @@ struct nfs4_file {
 	atomic_t		fi_access[2];
 	u32			fi_share_deny;
 	struct nfsd_file	*fi_deleg_file;
+	struct nfsd_file	*fi_rdeleg_file;
 	int			fi_delegees;
 	struct knfsd_fh		fi_fhandle;
 	bool			fi_had_conflict;
-- 
2.43.5


