Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D58C741E57
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 04:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjF2Cgk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Jun 2023 22:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjF2Cgj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Jun 2023 22:36:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984882682
        for <linux-nfs@vger.kernel.org>; Wed, 28 Jun 2023 19:36:38 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T1iTv9011054;
        Thu, 29 Jun 2023 02:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=P5Rx6FswrcLFxzYrE6QcjZ+zaoLFTPMWMfNaYRuGoYo=;
 b=AnR3QH1vV3nUPf5e3Z+ESYF3vGI52s0ciScC0DBfksB/cjUPBLr+fpMgNwAs8EHSGZD3
 eti4JwKtMCoZ5m/+U5VDQBW9lc0tpCmUP/RV6bPsMd0DSwAK+AnQDrBvCPzNFqyzBMAh
 whdreokIUFSMic9dlOuIMunDIo5Y1WBchmmshjsezgKLJKskBgdK3cXa//bHNWADGH+B
 p9J2wd255W5xz/SnGg9Hq0b0msT7NEupK1PrCDpD0H1Gj8ChEwNyw42pntt2Hshfz/O4
 WTjgJVBz9Jz4bJEh0J9WnNicFFiUukj/u1lbZo/zmza7qHhB2whsNi3d+N+lf8lzUqri zA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdqdtt4ud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 02:36:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35T0m60A038208;
        Thu, 29 Jun 2023 02:36:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxdc88g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 02:36:35 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35T2Zt7i011587;
        Thu, 29 Jun 2023 02:36:34 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3rdpxdc87d-5;
        Thu, 29 Jun 2023 02:36:34 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 4/5] NFSD: allow client to use write delegation stateid for READ
Date:   Wed, 28 Jun 2023 19:36:15 -0700
Message-Id: <1688006176-32597-5-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1688006176-32597-1-git-send-email-dai.ngo@oracle.com>
References: <1688006176-32597-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290021
X-Proofpoint-GUID: bA-b-c2EF6xCN5FD77qzsJATAqE-GJh_
X-Proofpoint-ORIG-GUID: bA-b-c2EF6xCN5FD77qzsJATAqE-GJh_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Allow NFSv4 client to use write delegation stateid for READ operation.
Per RFC 8881 section 9.1.2. Use of the Stateid and Locking.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4proc.c | 16 ++++++++++++++--
 fs/nfsd/nfs4xdr.c  |  9 +++++++++
 fs/nfsd/xdr4.h     |  2 ++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 5ae670807449..3fa66cb38780 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -942,8 +942,18 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	/* check stateid */
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
 					&read->rd_stateid, RD_STATE,
-					&read->rd_nf, NULL);
-
+					&read->rd_nf, &read->rd_wd_stid);
+	/*
+	 * rd_wd_stid is needed for nfsd4_encode_read to allow write
+	 * delegation stateid used for read. Its refcount is decremented
+	 * by nfsd4_read_release when read is done.
+	 */
+	if (!status && (read->rd_wd_stid->sc_type != NFS4_DELEG_STID ||
+			delegstateid(read->rd_wd_stid)->dl_type !=
+			NFS4_OPEN_DELEGATE_WRITE)) {
+		nfs4_put_stid(read->rd_wd_stid);
+		read->rd_wd_stid = NULL;
+	}
 	read->rd_rqstp = rqstp;
 	read->rd_fhp = &cstate->current_fh;
 	return status;
@@ -953,6 +963,8 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 static void
 nfsd4_read_release(union nfsd4_op_u *u)
 {
+	if (u->read.rd_wd_stid)
+		nfs4_put_stid(u->read.rd_wd_stid);
 	if (u->read.rd_nf)
 		nfsd_file_put(u->read.rd_nf);
 	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index b35855c8beb6..833634cdc761 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4125,6 +4125,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 	struct file *file;
 	int starting_len = xdr->buf->len;
 	__be32 *p;
+	fmode_t o_fmode = 0;
 
 	if (nfserr)
 		return nfserr;
@@ -4144,10 +4145,18 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 	maxcount = min_t(unsigned long, read->rd_length,
 			 (xdr->buf->buflen - xdr->buf->len));
 
+	if (read->rd_wd_stid) {
+		/* allow READ using write delegation stateid */
+		o_fmode = file->f_mode;
+		file->f_mode |= FMODE_READ;
+	}
 	if (file->f_op->splice_read && splice_ok)
 		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
 	else
 		nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
+	if (o_fmode)
+		file->f_mode = o_fmode;
+
 	if (nfserr) {
 		xdr_truncate_encode(xdr, starting_len);
 		return nfserr;
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 510978e602da..3ccc40f9274a 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -307,6 +307,8 @@ struct nfsd4_read {
 	struct svc_rqst		*rd_rqstp;          /* response */
 	struct svc_fh		*rd_fhp;            /* response */
 	u32			rd_eof;             /* response */
+
+	struct nfs4_stid	*rd_wd_stid;		/* internal */
 };
 
 struct nfsd4_readdir {
-- 
2.39.3

