Return-Path: <linux-nfs+bounces-2753-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F7A8A0CBA
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 11:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D651283E2C
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 09:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027D9144D30;
	Thu, 11 Apr 2024 09:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ouVUj3/l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B319D13E405;
	Thu, 11 Apr 2024 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712828811; cv=none; b=eB2Z7OoJqECONWpZOAzoVsmN8zKCmWczxzPvsOC5qdTILNlU29tIyZfkZ4Rr5cbG32Sa6GPH4xdlcYKGSLfspnA9+kLAV7dtAMmPyTR7elfQ4Bk++k8iSG553cS8lwyGCy9ErOqqYOM0vIRcvUaFVU5Esv9ClmQl9JvXeC8Htl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712828811; c=relaxed/simple;
	bh=g8idMwU+bikSSQ+8Sb+oNKJ9igMRbSIEC0UaqUT1VjA=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=g6RYwqX6m/FvGA6PmvDpog24r0c2cCg4Bw0FcZKsKvwz8j9Ge1PHw6Ef/8oN5qoAg4b1dZPvCYTY7wZ08dyCFPxEfln5IozawOre5E/2Sl7CBg1V2EPYmM2b5hbqT6FzSaHrAfCqPyx90K5WrcGLJ1QBlob7JrQ6/o3LvkQhzvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ouVUj3/l; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43B9a6sE025186;
	Thu, 11 Apr 2024 09:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=zDLe+8MCuJwjfJvLO1q2HOAfja3n9iFENYvdQqRhjAw=;
 b=ouVUj3/l1qKy51HDZk1HtvKRgZJGw7XxIBt6uHcQsFXwQ6rfQ9UH7vPHStYBQAHHnxJg
 4+aB+tXO0/gZt7B1+iw17ti41nxuqyvBheEvIP0XhLH/myAOkG8YybA0SzPYxyTKEcZq
 +eOh8QnNo7Wr6AgTQJj2vgYJ6+Srib6F2gGLW+dUJHPpeACCJgrqGhB2+xNZMNsPwbOR
 7csmBlaOGDwal4NmJtr5hecdtkFjcipDSeNLkKHsPxZBzz99gmH2yz8y5shav/hJB/Qo
 LwaVT5Yawm/ereqrD66HdMXLv1jMy5wC7lWq+t+yy+qQ4E+W8ZfcpIZRBiP1p4c6si1b Fw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xeb1vgbha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 09:46:37 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43B9TWM1022560;
	Thu, 11 Apr 2024 09:46:03 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbhqpad69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 09:46:03 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43B9jxMk51184056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 09:46:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E4A120043;
	Thu, 11 Apr 2024 09:45:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B37B520040;
	Thu, 11 Apr 2024 09:45:58 +0000 (GMT)
Received: from localhost (unknown [9.179.0.57])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 11 Apr 2024 09:45:58 +0000 (GMT)
Date: Thu, 11 Apr 2024 11:45:57 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] NFSD: fix endianness issue in nfsd4_encode_fattr4
Message-ID: <patch.git-0ff58649313e.your-ad-here.call-01712828617-ext-4049@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6QE8mGXdW6XUzHshanK2S3zhZ4ZF8obi
X-Proofpoint-GUID: 6QE8mGXdW6XUzHshanK2S3zhZ4ZF8obi
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404110070

The nfs4 mount fails with EIO on 64-bit big endian architectures since
v6.7. The issue arises from employing a union in the nfsd4_encode_fattr4()
function to overlay a 32-bit array with a 64-bit values based bitmap,
which does not function as intended. Address the endianness issue by
utilizing bitmap_from_arr32() to copy 32-bit attribute masks into a
bitmap in an endianness-agnostic manner.

Cc: <stable@vger.kernel.org>
Fixes: fce7913b13d0 ("NFSD: Use a bitmask loop to encode FATTR4 results")
Link: https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/2060217
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 fs/nfsd/nfs4xdr.c | 47 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 10439d569d9c..85d43b3249f9 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3519,11 +3519,13 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		    struct dentry *dentry, const u32 *bmval,
 		    int ignore_crossmnt)
 {
+	DECLARE_BITMAP(attr_bitmap, ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops));
 	struct nfsd4_fattr_args args;
 	struct svc_fh *tempfh = NULL;
 	int starting_len = xdr->buf->len;
 	__be32 *attrlen_p, status;
 	int attrlen_offset;
+	u32 attrmask[3];
 	int err;
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
 	u32 minorversion = resp->cstate.minorversion;
@@ -3531,10 +3533,6 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		.mnt	= exp->ex_path.mnt,
 		.dentry	= dentry,
 	};
-	union {
-		u32		attrmask[3];
-		unsigned long	mask[2];
-	} u;
 	unsigned long bit;
 	bool file_modified = false;
 	u64 size = 0;
@@ -3550,20 +3548,19 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	/*
 	 * Make a local copy of the attribute bitmap that can be modified.
 	 */
-	memset(&u, 0, sizeof(u));
-	u.attrmask[0] = bmval[0];
-	u.attrmask[1] = bmval[1];
-	u.attrmask[2] = bmval[2];
+	attrmask[0] = bmval[0];
+	attrmask[1] = bmval[1];
+	attrmask[2] = bmval[2];
 
 	args.rdattr_err = 0;
 	if (exp->ex_fslocs.migrated) {
-		status = fattr_handle_absent_fs(&u.attrmask[0], &u.attrmask[1],
-						&u.attrmask[2], &args.rdattr_err);
+		status = fattr_handle_absent_fs(&attrmask[0], &attrmask[1],
+						&attrmask[2], &args.rdattr_err);
 		if (status)
 			goto out;
 	}
 	args.size = 0;
-	if (u.attrmask[0] & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
+	if (attrmask[0] & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
 		status = nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry),
 					&file_modified, &size);
 		if (status)
@@ -3582,16 +3579,16 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 
 	if (!(args.stat.result_mask & STATX_BTIME))
 		/* underlying FS does not offer btime so we can't share it */
-		u.attrmask[1] &= ~FATTR4_WORD1_TIME_CREATE;
-	if ((u.attrmask[0] & (FATTR4_WORD0_FILES_AVAIL | FATTR4_WORD0_FILES_FREE |
+		attrmask[1] &= ~FATTR4_WORD1_TIME_CREATE;
+	if ((attrmask[0] & (FATTR4_WORD0_FILES_AVAIL | FATTR4_WORD0_FILES_FREE |
 			FATTR4_WORD0_FILES_TOTAL | FATTR4_WORD0_MAXNAME)) ||
-	    (u.attrmask[1] & (FATTR4_WORD1_SPACE_AVAIL | FATTR4_WORD1_SPACE_FREE |
+	    (attrmask[1] & (FATTR4_WORD1_SPACE_AVAIL | FATTR4_WORD1_SPACE_FREE |
 		       FATTR4_WORD1_SPACE_TOTAL))) {
 		err = vfs_statfs(&path, &args.statfs);
 		if (err)
 			goto out_nfserr;
 	}
-	if ((u.attrmask[0] & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID)) &&
+	if ((attrmask[0] & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID)) &&
 	    !fhp) {
 		tempfh = kmalloc(sizeof(struct svc_fh), GFP_KERNEL);
 		status = nfserr_jukebox;
@@ -3606,10 +3603,10 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		args.fhp = fhp;
 
 	args.acl = NULL;
-	if (u.attrmask[0] & FATTR4_WORD0_ACL) {
+	if (attrmask[0] & FATTR4_WORD0_ACL) {
 		err = nfsd4_get_nfs4_acl(rqstp, dentry, &args.acl);
 		if (err == -EOPNOTSUPP)
-			u.attrmask[0] &= ~FATTR4_WORD0_ACL;
+			attrmask[0] &= ~FATTR4_WORD0_ACL;
 		else if (err == -EINVAL) {
 			status = nfserr_attrnotsupp;
 			goto out;
@@ -3621,17 +3618,17 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	args.context = NULL;
-	if ((u.attrmask[2] & FATTR4_WORD2_SECURITY_LABEL) ||
-	     u.attrmask[0] & FATTR4_WORD0_SUPPORTED_ATTRS) {
+	if ((attrmask[2] & FATTR4_WORD2_SECURITY_LABEL) ||
+	     attrmask[0] & FATTR4_WORD0_SUPPORTED_ATTRS) {
 		if (exp->ex_flags & NFSEXP_SECURITY_LABEL)
 			err = security_inode_getsecctx(d_inode(dentry),
 						&args.context, &args.contextlen);
 		else
 			err = -EOPNOTSUPP;
 		args.contextsupport = (err == 0);
-		if (u.attrmask[2] & FATTR4_WORD2_SECURITY_LABEL) {
+		if (attrmask[2] & FATTR4_WORD2_SECURITY_LABEL) {
 			if (err == -EOPNOTSUPP)
-				u.attrmask[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
+				attrmask[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
 			else if (err)
 				goto out_nfserr;
 		}
@@ -3639,8 +3636,8 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
 
 	/* attrmask */
-	status = nfsd4_encode_bitmap4(xdr, u.attrmask[0],
-				      u.attrmask[1], u.attrmask[2]);
+	status = nfsd4_encode_bitmap4(xdr, attrmask[0], attrmask[1],
+				      attrmask[2]);
 	if (status)
 		goto out;
 
@@ -3649,7 +3646,9 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	attrlen_p = xdr_reserve_space(xdr, XDR_UNIT);
 	if (!attrlen_p)
 		goto out_resource;
-	for_each_set_bit(bit, (const unsigned long *)&u.mask,
+	bitmap_from_arr32(attr_bitmap, attrmask,
+			  ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops));
+	for_each_set_bit(bit, attr_bitmap,
 			 ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops)) {
 		status = nfsd4_enc_fattr4_encode_ops[bit](xdr, &args);
 		if (status != nfs_ok)
-- 
2.41.0

