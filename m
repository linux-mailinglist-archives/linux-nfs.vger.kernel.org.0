Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984174F6DF6
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Apr 2022 00:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbiDFWrq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Apr 2022 18:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237341AbiDFWrm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Apr 2022 18:47:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C82F177D2A
        for <linux-nfs@vger.kernel.org>; Wed,  6 Apr 2022 15:45:43 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236Jihh5014690;
        Wed, 6 Apr 2022 22:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=9zXBUnXiKF+VqRq8fk8LNIdhG+VXmNB6K4p7mldr7g4=;
 b=VaQx0Z/rZHfsinfUMmsK/qj/EUNrjsskmhWeQS/iwcTFJTVtNgrEWbuxqisll1vLzfsM
 qrxhWnnKwVxopdx6W0YbqCwSSwvzlFH3A/FFUWcW8VNEwIdSLJCmonD99XAYFj3duX/P
 iGWBpFi/ptaDN0EVKYtfzU4K1Rie5RGBaoO8qltaPXq3qHvBkwFeVj5E3MBLI57epFvF
 uNsdFMGrCh7ZBannvQR5qWi7KrZd6LMaR2+t1DOJgz8JxJO12Q6xDr+XbnOK9s+8dl7r
 9gXs1BV6ry/S6LITlFkEX08yDlEFQiaG1Oo63FX3i5x/4YjFD9EoMi6CnOX2HXTMtGgm fw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9t3rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 22:45:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 236MeZJI011641;
        Wed, 6 Apr 2022 22:45:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f9803d5ne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 22:45:40 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 236Mjcba021908;
        Wed, 6 Apr 2022 22:45:40 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f9803d5mk-3;
        Wed, 06 Apr 2022 22:45:40 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH RFC v20 02/10] NFSD: Add lm_lock_expired call out
Date:   Wed,  6 Apr 2022 15:45:25 -0700
Message-Id: <1649285133-16765-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1649285133-16765-1-git-send-email-dai.ngo@oracle.com>
References: <1649285133-16765-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: 1KDKDFYP5YzGBw_FeHcv5PPQ8akpaiCe
X-Proofpoint-ORIG-GUID: 1KDKDFYP5YzGBw_FeHcv5PPQ8akpaiCe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add callout function nfsd4_lm_lock_expired for lm_lock_expired.
If lock request has conflict with courtesy client then expire the
courtesy client and return no conflict to caller.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 22 ++++++++++++++++++++++
 fs/nfsd/state.h     | 14 ++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a65d59510681..80772662236b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6578,10 +6578,32 @@ nfsd4_lm_notify(struct file_lock *fl)
 	}
 }
 
+/**
+ * nfsd4_lm_lock_expired - check if lock conflict can be resolved.
+ *
+ * @fl: pointer to file_lock with a potential conflict
+ * Return values:
+ *   %false: real conflict, lock conflict can not be resolved.
+ *   %true: no conflict, lock conflict was resolved.
+ *
+ * Note that this function is called while the flc_lock is held.
+ */
+static bool
+nfsd4_lm_lock_expired(struct file_lock *fl)
+{
+	struct nfs4_lockowner *lo;
+
+	if (!fl)
+		return false;
+	lo = (struct nfs4_lockowner *)fl->fl_owner;
+	return nfsd4_expire_courtesy_clnt(lo->lo_owner.so_client);
+}
+
 static const struct lock_manager_operations nfsd_posix_mng_ops  = {
 	.lm_notify = nfsd4_lm_notify,
 	.lm_get_owner = nfsd4_lm_get_owner,
 	.lm_put_owner = nfsd4_lm_put_owner,
+	.lm_lock_expired = nfsd4_lm_lock_expired,
 };
 
 static inline void
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 7f78da5d1408..8b81493ee48a 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -735,4 +735,18 @@ extern void nfsd4_client_record_remove(struct nfs4_client *clp);
 extern int nfsd4_client_record_check(struct nfs4_client *clp);
 extern void nfsd4_record_grace_done(struct nfsd_net *nn);
 
+static inline bool
+nfsd4_expire_courtesy_clnt(struct nfs4_client *clp)
+{
+	bool rc = false;
+
+	spin_lock(&clp->cl_cs_lock);
+	if (clp->cl_cs_client_state == NFSD4_CLIENT_COURTESY)
+		clp->cl_cs_client_state = NFSD4_CLIENT_EXPIRED;
+	if (clp->cl_cs_client_state == NFSD4_CLIENT_EXPIRED)
+		rc = true;
+	spin_unlock(&clp->cl_cs_lock);
+	return rc;
+}
+
 #endif   /* NFSD4_STATE_H */
-- 
2.9.5

