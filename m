Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9ED4C1ABD
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 19:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243800AbiBWSRP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 13:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241817AbiBWSRN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 13:17:13 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE5A3ED0A
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 10:16:45 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21NIDlCw029459;
        Wed, 23 Feb 2022 18:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=B7qqXJZj8d1n11UsihJzgskiFJcdarMdYoIty2E3O4s=;
 b=nogTBwUriw/au9/UzGR90eoxxiLkxQYxLs2zLU+ByGJWBzyYg3sk8GjzPo1luou0wsFC
 m79lumE8WkQFMNH0iU6a6DquirSOE8HC9Kc8tCWkFp3obCY1FUY9vHp2tkDWjg/jzsV6
 UHJQyDf1QznLPuxcX4d3NoMBJ2p8QaunlafsiQ4L2ALQKTjvWpoXQ01qclqzssuKQYm1
 3Pk7/UqrlYKJatLxdNKAL5TNCcEWHAQWTNUytta2zL7KfaKvZCpHf5sHg5v0gZFIBFdT
 I2XHAAzCR96rPTg/LSBzkuAK6HKzMrArZsGZg/03taG1vED7d4pIDirKt7BfGi/kdJ2t wg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ectsx54ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 18:16:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21NIAuvl156041;
        Wed, 23 Feb 2022 18:16:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3eapkj17r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 18:16:43 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 21NICxfY162308;
        Wed, 23 Feb 2022 18:16:42 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by aserp3030.oracle.com with ESMTP id 3eapkj17pe-5;
        Wed, 23 Feb 2022 18:16:42 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH RFC v14 04/10] NFSD: Update nfs4_get_vfs_file() to handle courtesy clients
Date:   Wed, 23 Feb 2022 10:16:31 -0800
Message-Id: <1645640197-1725-5-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1645640197-1725-1-git-send-email-dai.ngo@oracle.com>
References: <1645640197-1725-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: xTbmhQ0UxCNlojC6XXzNTAv3GlU4lW7h
X-Proofpoint-GUID: xTbmhQ0UxCNlojC6XXzNTAv3GlU4lW7h
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Update nfs4_get_vfs_file() to handle share reservation conflict
with courtesy client. If share/access check fails with share
denied then check if the conflict was caused by courtesy clients.
If that's the case then set CLIENT_EXPIRED flag to expire the
courtesy clients and allow nfs4_get_vfs_file to continue.
Client with CLIENT_EXPIRED is expired by the laundromat.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 99 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 542a13676c91..1ffe7bafe90b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4965,9 +4965,87 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
 	return nfsd_setattr(rqstp, fh, &iattr, 0, (time64_t)0);
 }
 
+static bool
+nfs4_check_access_deny_bmap(struct nfs4_ol_stateid *stp, u32 access,
+			bool share_access)
+{
+	if (share_access) {
+		if (!stp->st_deny_bmap)
+			return false;
+
+		if ((stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_BOTH)) ||
+			(access & NFS4_SHARE_ACCESS_READ &&
+				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_READ)) ||
+			(access & NFS4_SHARE_ACCESS_WRITE &&
+				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_WRITE))) {
+			return true;
+		}
+		return false;
+	}
+	if ((access & NFS4_SHARE_DENY_BOTH) ||
+		(access & NFS4_SHARE_DENY_READ &&
+			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_READ)) ||
+		(access & NFS4_SHARE_DENY_WRITE &&
+			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_WRITE))) {
+		return true;
+	}
+	return false;
+}
+
+/*
+ * Check whether nfserr_share_denied should be returned.
+ *
+ * access:  is op_share_access if share_access is true.
+ *	    Check if access mode, op_share_access, would conflict with
+ *	    the current deny mode of the file 'fp'.
+ * access:  is op_share_deny if share_access is false.
+ *	    Check if the deny mode, op_share_deny, would conflict with
+ *	    current access of the file 'fp'.
+ * stp:     skip checking this entry.
+ * new_stp: normal open, not open upgrade.
+ *
+ * Function returns:
+ *	true   - access/deny mode conflict with normal client.
+ *	false  - no conflict or conflict with courtesy client(s) is resolved.
+ */
+static bool
+nfs4_conflict_clients(struct nfs4_file *fp, bool new_stp,
+		struct nfs4_ol_stateid *stp, u32 access, bool share_access)
+{
+	struct nfs4_ol_stateid *st;
+	struct nfs4_client *cl;
+	bool conflict = false;
+
+	lockdep_assert_held(&fp->fi_lock);
+	list_for_each_entry(st, &fp->fi_stateids, st_perfile) {
+		if (st->st_openstp || (st == stp && new_stp) ||
+			(!nfs4_check_access_deny_bmap(st,
+					access, share_access)))
+			continue;
+
+		/* need to sync with courtesy client trying to reconnect */
+		cl = st->st_stid.sc_client;
+		spin_lock(&cl->cl_cs_lock);
+		if (test_bit(NFSD4_CLIENT_EXPIRED, &cl->cl_flags)) {
+			spin_unlock(&cl->cl_cs_lock);
+			continue;
+		}
+		if (test_bit(NFSD4_CLIENT_COURTESY, &cl->cl_flags)) {
+			set_bit(NFSD4_CLIENT_EXPIRED, &cl->cl_flags);
+			spin_unlock(&cl->cl_cs_lock);
+			continue;
+		}
+		/* conflict not caused by courtesy client */
+		spin_unlock(&cl->cl_cs_lock);
+		conflict = true;
+		break;
+	}
+	return conflict;
+}
+
 static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
-		struct nfsd4_open *open)
+		struct nfsd4_open *open, bool new_stp)
 {
 	struct nfsd_file *nf = NULL;
 	__be32 status;
@@ -4983,15 +5061,29 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 	 */
 	status = nfs4_file_check_deny(fp, open->op_share_deny);
 	if (status != nfs_ok) {
-		spin_unlock(&fp->fi_lock);
-		goto out;
+		if (status != nfserr_share_denied) {
+			spin_unlock(&fp->fi_lock);
+			goto out;
+		}
+		if (nfs4_conflict_clients(fp, new_stp, stp,
+				open->op_share_deny, false)) {
+			spin_unlock(&fp->fi_lock);
+			goto out;
+		}
 	}
 
 	/* set access to the file */
 	status = nfs4_file_get_access(fp, open->op_share_access);
 	if (status != nfs_ok) {
-		spin_unlock(&fp->fi_lock);
-		goto out;
+		if (status != nfserr_share_denied) {
+			spin_unlock(&fp->fi_lock);
+			goto out;
+		}
+		if (nfs4_conflict_clients(fp, new_stp, stp,
+				open->op_share_access, true)) {
+			spin_unlock(&fp->fi_lock);
+			goto out;
+		}
 	}
 
 	/* Set access bits in stateid */
@@ -5042,7 +5134,7 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp, struct svc_fh *c
 	unsigned char old_deny_bmap = stp->st_deny_bmap;
 
 	if (!test_access(open->op_share_access, stp))
-		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open);
+		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open, false);
 
 	/* test and set deny mode */
 	spin_lock(&fp->fi_lock);
@@ -5391,7 +5483,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 			goto out;
 		}
 	} else {
-		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
+		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
 		if (status) {
 			stp->st_stid.sc_type = NFS4_CLOSED_STID;
 			release_open_stateid(stp);
-- 
2.9.5

