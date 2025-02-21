Return-Path: <linux-nfs+bounces-10285-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F722A4039A
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Feb 2025 00:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1E9189F9DA
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 23:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3D324C67A;
	Fri, 21 Feb 2025 23:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F81OJrVk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CA12528E5
	for <linux-nfs@vger.kernel.org>; Fri, 21 Feb 2025 23:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740181377; cv=none; b=nJ/fyoAXIIQ5AenIK/UZZMpV4iIU7alQ6Qb3btqRnxR+EIe+4e5snvnjSmkHQO9vFugjNOG1JUf5P+4qnwQskD8bW/m64ng1SmnxUQZgO43GUbh0AT41phQqh01tDCJBfeScKpBW5bF9BO7DM0KUsB7nfT8oGmLs8DH5QpET8qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740181377; c=relaxed/simple;
	bh=/BxnPa9qIjrMBQA7ovc7mawj+dNdH4+F4a94y/KB55s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BO6tnGgJDw1re4jFp3wVnG8aLIVpcnE/H4VRriO1u3PSC0bc6IhODo5mBNFLHDYID1IiYm3MQOEYvXvBGRTZvjz7R3YAzihGBbbrmc3iARv96KZ8q/48sfVeVVXuuk0gbuYr2YP3BKlNWWIip3sdrZFx+sh7GFC+T3pZgOrqhCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F81OJrVk; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LMBeDl030244;
	Fri, 21 Feb 2025 23:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=zj3OAyIoG9zZ9+Id1lzgoNr+b0P5wbygbm2WJ5irbJQ=; b=
	F81OJrVkDTwZZdsZiVJj7cWSNFZWnLsYH+W0/usoSkzymBUBpeFr64mBl+xGk+kY
	PtKaiaUTM+tnFbfieCkbpobnzbP5THJQy1FGEOqtIMATVzKL+RwmVExmvix3We8t
	0K6KQI1Nst+mX2FyjwwPssx9+0kcPuBHYOJkZz7FjPdHe6wsbtavygI+WN3q+ue/
	m3A2KHJ/zc0t1ukxiI9JSgG6b/4sZ18B1rBUYJMe/A9N5tj1r4jCFL+s0qF0sbx0
	aQ+Hw4bGyGLwGYPnoF9915LnCxfM1ezJLtaQffUE9q1aEhgzzsxFnkbfNBFxNolT
	UIvWIor9EGhNMkd5/bjsiQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w02yqafj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 23:42:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51LLx7fs026262;
	Fri, 21 Feb 2025 23:42:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0ssumdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 23:42:44 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51LNbkJN037041;
	Fri, 21 Feb 2025 23:42:43 GMT
Received: from ca-common-sca.us.oracle.com (ca-common-sca.us.oracle.com [10.132.20.202])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 44w0ssumcp-3;
	Fri, 21 Feb 2025 23:42:43 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
Subject: [PATCH V2 2/2] NFSD: allow client to use write delegation stateid for READ
Date: Fri, 21 Feb 2025 15:42:20 -0800
Message-Id: <1740181340-14562-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740181340-14562-1-git-send-email-dai.ngo@oracle.com>
References: <1740181340-14562-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=841 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502210162
X-Proofpoint-ORIG-GUID: aHT5LpQ5xY7eCKRAzl9l5XTEKVnLpQ2o
X-Proofpoint-GUID: aHT5LpQ5xY7eCKRAzl9l5XTEKVnLpQ2o
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

Allow READ using write delegation stateid granted on OPENs with
OPEN4_SHARE_ACCESS_WRITE only, to accommodate clients whose WRITE
implementation may unavoidably do (e.g., due to buffer cache
constraints).

When the server offers a write delegation for an OPEN with
OPEN4_SHARE_ACCESS_WRITE, the file access mode, the nfs4_file
and nfs4_ol_stateid are upgraded as if the OPEN was sent with
OPEN4_SHARE_ACCESS_BOTH.

When this delegation is returned or revoked, the corresponding open
stateid is looked up and if it's found then the file access mode,
the nfs4_file and nfs4_ol_stateid are downgraded to remove the read
access.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 62 +++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/state.h     |  2 ++
 2 files changed, 64 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b533225e57cf..0c14f902c54c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6126,6 +6126,51 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
 	return rc == 0;
 }
 
+/*
+ * Upgrade file access mode to include FMODE_READ. This is called only when
+ * a write delegation is granted for an OPEN with OPEN4_SHARE_ACCESS_WRITE.
+ */
+static void
+nfs4_upgrade_rdwr_file_access(struct nfs4_ol_stateid *stp)
+{
+	struct nfs4_file *fp = stp->st_stid.sc_file;
+	struct nfsd_file *nflp;
+	struct file *file;
+
+	spin_lock(&fp->fi_lock);
+	nflp = fp->fi_fds[O_WRONLY];
+	file = nflp->nf_file;
+	file->f_mode |= FMODE_READ;
+	swap(fp->fi_fds[O_RDWR], fp->fi_fds[O_WRONLY]);
+	clear_access(NFS4_SHARE_ACCESS_WRITE, stp);
+	set_access(NFS4_SHARE_ACCESS_BOTH, stp);
+	__nfs4_file_get_access(fp, NFS4_SHARE_ACCESS_READ);	/* incr fi_access[O_RDONLY] */
+	spin_unlock(&fp->fi_lock);
+}
+
+/*
+ * Downgrade file access mode to remove FMODE_READ. This is called when
+ * a write delegation, granted for an OPEN with OPEN4_SHARE_ACCESS_WRITE,
+ * is returned.
+ */
+static void
+nfs4_downgrade_wronly_file_access(struct nfs4_ol_stateid *stp)
+{
+	struct nfs4_file *fp = stp->st_stid.sc_file;
+	struct nfsd_file *nflp;
+	struct file *file;
+
+	spin_lock(&fp->fi_lock);
+	nflp = fp->fi_fds[O_RDWR];
+	file = nflp->nf_file;
+	file->f_mode &= ~FMODE_READ;
+	swap(fp->fi_fds[O_WRONLY], fp->fi_fds[O_RDWR]);
+	clear_access(NFS4_SHARE_ACCESS_BOTH, stp);
+	set_access(NFS4_SHARE_ACCESS_WRITE, stp);
+	spin_unlock(&fp->fi_lock);
+	nfs4_file_put_access(fp, NFS4_SHARE_ACCESS_READ);	/* decr. fi_access[O_RDONLY] */
+}
+
 /*
  * The Linux NFS server does not offer write delegations to NFSv4.0
  * clients in order to avoid conflicts between write delegations and
@@ -6207,6 +6252,11 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
 		dp->dl_cb_fattr.ncf_initial_cinfo = nfsd4_change_attribute(&stat);
 		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
+
+		if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_WRITE) {
+			dp->dl_stateid = stp->st_stid.sc_stateid;
+			nfs4_upgrade_rdwr_file_access(stp);
+		}
 	} else {
 		open->op_delegate_type = deleg_ts ? OPEN_DELEGATE_READ_ATTRS_DELEG :
 						    OPEN_DELEGATE_READ;
@@ -7710,6 +7760,8 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfs4_stid *s;
 	__be32 status;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+	struct nfs4_ol_stateid *stp;
+	struct nfs4_stid *stid;
 
 	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
 		return status;
@@ -7724,6 +7776,16 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	trace_nfsd_deleg_return(stateid);
 	destroy_delegation(dp);
+
+	if (dp->dl_stateid.si_generation && dp->dl_stateid.si_opaque.so_id) {
+		if (!nfsd4_lookup_stateid(cstate, &dp->dl_stateid,
+				SC_TYPE_OPEN, 0, &stid, nn)) {
+			stp = openlockstateid(stid);
+			nfs4_downgrade_wronly_file_access(stp);
+			nfs4_put_stid(stid);
+		}
+	}
+
 	smp_mb__after_atomic();
 	wake_up_var(d_inode(cstate->current_fh.fh_dentry));
 put_stateid:
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 74d2d7b42676..3f2f1b92db66 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -207,6 +207,8 @@ struct nfs4_delegation {
 
 	/* for CB_GETATTR */
 	struct nfs4_cb_fattr    dl_cb_fattr;
+
+	stateid_t		dl_stateid;  /* open stateid */
 };
 
 static inline bool deleg_is_read(u32 dl_type)
-- 
2.43.5


