Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794A0576ADC
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Jul 2022 01:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiGOXy7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Jul 2022 19:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGOXy6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Jul 2022 19:54:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32E0904DC
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 16:54:57 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FKYjeW018720
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 23:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=8FV5XgxumWG/0uOW/TB2DmOAIy/+yWqpXWvvOXDz6pQ=;
 b=QPmanXeCck7RKtvQDI4uKcDkBUVx0/OG0z2acEIdtAqC4cAUBdkOpewQHa4hWUKXrnuv
 lsR+GT4zR6rfUpvUwDIRyElxJk7RvUGJ7kMhIyKNZyiLEWTxxqhHYaiBRcCv3SdQSkyv
 NhjwjSdSdm7DDPWzMG/H9dBkbc6w44ia5KYx3KpzeXpDqa4a5rMOtiSEFNXYYZnO0Ng8
 9bYeEBTjN9E8mVNjVYYEN03nqkFoq/ePTy+V7G1w/By0DXZQu+xj6CIa+rBsWfqXoBG0
 B5Npz4KD/tx5tumy3EcKh17Ry8xJeiEvmoL8L+CV92rfeJjNsBZOFXOuURYcVKdqRjER Hw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h727ssrdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 23:54:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26FNp0cf016436
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 23:54:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7047j676-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 23:54:55 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 26FNssHw021132
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 23:54:55 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7047j66y-2;
        Fri, 15 Jul 2022 23:54:55 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/3] NFSD: refactoring v4 specific code to a helper in nfs4state.c
Date:   Fri, 15 Jul 2022 16:54:51 -0700
Message-Id: <1657929293-30442-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1657929293-30442-1-git-send-email-dai.ngo@oracle.com>
References: <1657929293-30442-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: AxMHkjPSqpPCfyN5IX34z0QK_ooosb_x
X-Proofpoint-GUID: AxMHkjPSqpPCfyN5IX34z0QK_ooosb_x
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch moves the v4 specific code from nfsd_init_net() to
nfsd4_init_leases_net() helper in nfs4state.c

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 12 ++++++++++++
 fs/nfsd/nfsctl.c    |  9 +--------
 fs/nfsd/nfsd.h      |  4 ++++
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 9409a0dc1b76..dd00c6ae7501 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4330,6 +4330,18 @@ nfsd4_init_slabs(void)
 	return -ENOMEM;
 }
 
+void nfsd4_init_leases_net(struct nfsd_net *nn)
+{
+	nn->nfsd4_lease = 90;	/* default lease time */
+	nn->nfsd4_grace = 90;
+	nn->somebody_reclaimed = false;
+	nn->track_reclaim_completes = false;
+	nn->clverifier_counter = prandom_u32();
+	nn->clientid_base = prandom_u32();
+	nn->clientid_counter = nn->clientid_base + 1;
+	nn->s2s_cp_cl_id = nn->clientid_counter++;
+}
+
 static void init_nfs4_replay(struct nfs4_replay *rp)
 {
 	rp->rp_status = nfserr_serverfault;
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 0621c2faf242..879b9e4f723b 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1475,14 +1475,7 @@ static __net_init int nfsd_init_net(struct net *net)
 	retval = nfsd_reply_cache_init(nn);
 	if (retval)
 		goto out_drc_error;
-	nn->nfsd4_lease = 90;	/* default lease time */
-	nn->nfsd4_grace = 90;
-	nn->somebody_reclaimed = false;
-	nn->track_reclaim_completes = false;
-	nn->clverifier_counter = prandom_u32();
-	nn->clientid_base = prandom_u32();
-	nn->clientid_counter = nn->clientid_base + 1;
-	nn->s2s_cp_cl_id = nn->clientid_counter++;
+	nfsd4_init_leases_net(nn);
 
 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
 	seqlock_init(&nn->writeverf_lock);
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 847b482155ae..036015b2dd50 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -495,12 +495,16 @@ extern void unregister_cld_notifier(void);
 extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
 #endif
 
+extern void nfsd4_init_leases_net(struct nfsd_net *nn);
+
 #else /* CONFIG_NFSD_V4 */
 static inline int nfsd4_is_junction(struct dentry *dentry)
 {
 	return 0;
 }
 
+static inline void nfsd4_init_leases_net(struct nfsd_net *nn) {};
+
 #define register_cld_notifier() 0
 #define unregister_cld_notifier() do { } while(0)
 
-- 
2.9.5

