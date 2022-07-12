Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6CD5726F6
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Jul 2022 22:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbiGLUJT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Jul 2022 16:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiGLUJS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Jul 2022 16:09:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D356B8E87
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 13:09:17 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CJXvBZ016693
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 20:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=wTnO+vGs+evI9bG/16zycQE4sc6jO6zqko/lPb6PI88=;
 b=ZDVJtXOAUD+gsA67nNnGLryb2WlMmNFYLRRVlr1YlQrbgReTDH70d159Dn6GNUz6sR+Z
 ZKYA2MAVSSCv3W2CWDSshsG5vkK8oc0RZKIScJA+kvsFl3hCRQugcLTGgbb7nHE2Qyd+
 qy5DaOCDUNoA7uv4ZXTfxCKxHEooyGOH/ZFFGGyTyS9aeVUy4H/1G9SD1CXfpNpETIe/
 K8l98WiBuWMC6ALeNcvNIR/hvDVEmazWpfYzeCYxBEDJStMxZj4uGN6M8/UNhcucWypK
 ws5SNhVk0RhQBzt1mtSwx++GqfA456WMIOcWIymDKUk+FScgyq3bKClv4mmgXgA9173K sg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sc88qe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 20:09:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CK1Lmm019918
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 20:09:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70449spy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 20:09:16 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 26CK9EDd003044
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 20:09:15 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70449snp-2;
        Tue, 12 Jul 2022 20:09:15 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFSD: keep track of the number of v4 clients in the system
Date:   Tue, 12 Jul 2022 13:09:12 -0700
Message-Id: <1657656553-16493-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1657656553-16493-1-git-send-email-dai.ngo@oracle.com>
References: <1657656553-16493-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: X6HzNC4KqmZdzOKobUMvLI9qspXIQJQ5
X-Proofpoint-ORIG-GUID: X6HzNC4KqmZdzOKobUMvLI9qspXIQJQ5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add counter nfs4_client_count to keep track of the total number
of v4 clients, including courtesy clients, in the system.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/netns.h     | 2 ++
 fs/nfsd/nfs4state.c | 8 ++++++--
 fs/nfsd/nfsctl.c    | 2 ++
 3 files changed, 10 insertions(+), 2 deletions(-)

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
index 9409a0dc1b76..30e16d9e8657 100644
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
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 0621c2faf242..547f4c4b9668 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1487,6 +1487,8 @@ static __net_init int nfsd_init_net(struct net *net)
 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
 	seqlock_init(&nn->writeverf_lock);
 
+	atomic_set(&nn->nfs4_client_count, 0);
+
 	return 0;
 
 out_drc_error:
-- 
2.9.5

