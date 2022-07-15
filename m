Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42AB576ADD
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Jul 2022 01:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiGOXy7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Jul 2022 19:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiGOXy6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Jul 2022 19:54:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0FB904DA
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 16:54:58 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FKYide012263
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 23:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=u5vIflAX5xCTcHorCEjAZlIlUj3ySWo2RQQGPqUbRKA=;
 b=tOZP5fugn/8DnDYGKgtUv09iPFo0a6c8RzsZN+uLVpfYa1IkJcqcAjv6zV2XyFiYm2oW
 g5qMUmn3Y50Oyq9r+2QGSMeSAWFy0bA6gGbAjBT+xIXwYDHEUa8yuSYXz+T0Hhls9Vuu
 jQesKkBMo1ZHjDHXiortdLyFmwyLHNoEKScnAEfubYytlz8kx53JPqSzNw/AUQDve4PJ
 TTwy2PTTWru11Ieq8KCCOL489FMhrE9DlEd8DOocsWftocOA6LraBMnvdhtsi9C+coM6
 uIWST4BC7PMMSoqMaw5umvG4jWgNEbsHzosKESrdlDZ2ZS3DJN/pHpKGWZ3Fw9hdA7AQ LA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sh0cuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 23:54:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26FNp1Cq016538
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 23:54:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7047j679-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 23:54:56 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 26FNssI0021132
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 23:54:56 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7047j66y-3;
        Fri, 15 Jul 2022 23:54:56 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 2/3] NFSD: keep track of the number of v4 clients in the system
Date:   Fri, 15 Jul 2022 16:54:52 -0700
Message-Id: <1657929293-30442-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1657929293-30442-1-git-send-email-dai.ngo@oracle.com>
References: <1657929293-30442-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: LFupZy-h12c_CIV3mJivWsZlQgnkgCme
X-Proofpoint-ORIG-GUID: LFupZy-h12c_CIV3mJivWsZlQgnkgCme
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add counter nfs4_client_count to keep track of the total number
of v4 clients, including courtesy clients, in the system.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/netns.h     |  2 ++
 fs/nfsd/nfs4state.c | 10 ++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 1b1a962a1804..ce864f001a3e 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -189,6 +189,8 @@ struct nfsd_net {
 	struct nfsd_fcache_disposal *fcache_disposal;
 
 	siphash_key_t		siphash_key;
+
+	atomic_t		nfs4_client_count;
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index dd00c6ae7501..8f2b086bf4da 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2053,7 +2053,8 @@ STALE_CLIENTID(clientid_t *clid, struct nfsd_net *nn)
  * This type of memory management is somewhat inefficient, but we use it
  * anyway since SETCLIENTID is not a common operation.
  */
-static struct nfs4_client *alloc_client(struct xdr_netobj name)
+static struct nfs4_client *alloc_client(struct xdr_netobj name,
+				struct nfsd_net *nn)
 {
 	struct nfs4_client *clp;
 	int i;
@@ -2076,6 +2077,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
 	atomic_set(&clp->cl_rpc_users, 0);
 	clp->cl_cb_state = NFSD4_CB_UNKNOWN;
 	clp->cl_state = NFSD4_ACTIVE;
+	atomic_inc(&nn->nfs4_client_count);
 	atomic_set(&clp->cl_delegs_in_recall, 0);
 	INIT_LIST_HEAD(&clp->cl_idhash);
 	INIT_LIST_HEAD(&clp->cl_openowners);
@@ -2187,6 +2189,7 @@ __destroy_client(struct nfs4_client *clp)
 	struct nfs4_openowner *oo;
 	struct nfs4_delegation *dp;
 	struct list_head reaplist;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 
 	INIT_LIST_HEAD(&reaplist);
 	spin_lock(&state_lock);
@@ -2226,6 +2229,7 @@ __destroy_client(struct nfs4_client *clp)
 	nfsd4_shutdown_callback(clp);
 	if (clp->cl_cb_conn.cb_xprt)
 		svc_xprt_put(clp->cl_cb_conn.cb_xprt);
+	atomic_add_unless(&nn->nfs4_client_count, -1, 0);
 	free_client(clp);
 	wake_up_all(&expiry_wq);
 }
@@ -2848,7 +2852,7 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct dentry *dentries[ARRAY_SIZE(client_files)];
 
-	clp = alloc_client(name);
+	clp = alloc_client(name, nn);
 	if (clp == NULL)
 		return NULL;
 
@@ -4340,6 +4344,8 @@ void nfsd4_init_leases_net(struct nfsd_net *nn)
 	nn->clientid_base = prandom_u32();
 	nn->clientid_counter = nn->clientid_base + 1;
 	nn->s2s_cp_cl_id = nn->clientid_counter++;
+
+	atomic_set(&nn->nfs4_client_count, 0);
 }
 
 static void init_nfs4_replay(struct nfs4_replay *rp)
-- 
2.9.5

