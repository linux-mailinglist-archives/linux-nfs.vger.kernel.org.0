Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3EC4F6DFF
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Apr 2022 00:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237234AbiDFWrw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Apr 2022 18:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237371AbiDFWrp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Apr 2022 18:47:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262EF22BDD
        for <linux-nfs@vger.kernel.org>; Wed,  6 Apr 2022 15:45:48 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236JcKTZ014702;
        Wed, 6 Apr 2022 22:45:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=HofPZyCFo+qPkdAczK9qbnAgpGLeIysK1cm+H9cmhx4=;
 b=yimjvfm2fet4dO1z+zETasrClzy9BsfE9LuXncchYV+BAmrHL/KCQSwV4HmDnb2uTs9W
 upMwoRQzbVp+7HYE38ayjUqcuMcBQVKshrNIkQbfh0fSm/IOtU72kyUwLXvP5UxKHX7P
 XymVa44Shj0aPmhZfj6t6+ve+DTrIfl72ATpAKSv7YywdaZ3JOxSXKSrjlGDGPLAw9LS
 iTSPMXMD2YKVtg3rbJ+2jnLWUVlJmtRf7KFPO9UbLFZpnxncW7DLBMzsQ9+rxQ7s/JfK
 5/RAJlcJjOzImUwucR5xLjfn5giuNyIa69DUJx1MDYo6bYbU94Cz3/EHZE84Ek+ORAEb jQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9t3rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 22:45:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 236MeZHf011681;
        Wed, 6 Apr 2022 22:45:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f9803d5qj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 22:45:45 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 236Mjcbm021908;
        Wed, 6 Apr 2022 22:45:45 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f9803d5mk-9;
        Wed, 06 Apr 2022 22:45:44 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH RFC v20 08/10] NFSD: Refactor nfsd4_laundromat()
Date:   Wed,  6 Apr 2022 15:45:31 -0700
Message-Id: <1649285133-16765-9-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1649285133-16765-1-git-send-email-dai.ngo@oracle.com>
References: <1649285133-16765-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: D8_RDIOW5QQSykP68jAbZxuWorry-eLp
X-Proofpoint-ORIG-GUID: D8_RDIOW5QQSykP68jAbZxuWorry-eLp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Extract a bit of logic that is about to be expanded to handle
courtesy clients.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 241d6a509994..4278b2078606 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5731,6 +5731,26 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
 }
 #endif
 
+static void
+nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
+				struct laundry_time *lt)
+{
+	struct list_head *pos, *next;
+	struct nfs4_client *clp;
+
+	INIT_LIST_HEAD(reaplist);
+	spin_lock(&nn->client_lock);
+	list_for_each_safe(pos, next, &nn->client_lru) {
+		clp = list_entry(pos, struct nfs4_client, cl_lru);
+		if (!state_expired(lt, clp->cl_time))
+			break;
+		if (mark_client_expired_locked(clp))
+			continue;
+		list_add(&clp->cl_lru, reaplist);
+	}
+	spin_unlock(&nn->client_lock);
+}
+
 static time64_t
 nfs4_laundromat(struct nfsd_net *nn)
 {
@@ -5753,7 +5773,6 @@ nfs4_laundromat(struct nfsd_net *nn)
 		goto out;
 	}
 	nfsd4_end_grace(nn);
-	INIT_LIST_HEAD(&reaplist);
 
 	spin_lock(&nn->s2s_cp_lock);
 	idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
@@ -5763,17 +5782,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 			_free_cpntf_state_locked(nn, cps);
 	}
 	spin_unlock(&nn->s2s_cp_lock);
-
-	spin_lock(&nn->client_lock);
-	list_for_each_safe(pos, next, &nn->client_lru) {
-		clp = list_entry(pos, struct nfs4_client, cl_lru);
-		if (!state_expired(&lt, clp->cl_time))
-			break;
-		if (mark_client_expired_locked(clp))
-			continue;
-		list_add(&clp->cl_lru, &reaplist);
-	}
-	spin_unlock(&nn->client_lock);
+	nfs4_get_client_reaplist(nn, &reaplist, &lt);
 	list_for_each_safe(pos, next, &reaplist) {
 		clp = list_entry(pos, struct nfs4_client, cl_lru);
 		trace_nfsd_clid_purged(&clp->cl_clientid);
-- 
2.9.5

