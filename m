Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649AE576ADE
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Jul 2022 01:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiGOXzA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Jul 2022 19:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiGOXy7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Jul 2022 19:54:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE31904DC
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 16:54:58 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FKYidf012263
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 23:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=w6BHvQY99rI6qtInOV/Hxnce7kuP0oj5RdWw8pOf37g=;
 b=la2gyhgzNbm1Id7X0Kq+zC9gtJRliao1obgl3JM25zXZM5kuMpceNGVxuCdkdpA7GWef
 JpMov5NZGn8d+iNybX6U4x1wCgdUx+PuLq4qlHGWBUlYS5dNSn0fIWXZAuLL7nundr7N
 Q9vbaz9ImOx0nhbQE0ybCB9XjcPXXeMtyU8VgYrk6d50lpGxQaIiaQQBqmoTwfLNIVBs
 5jpvlTnm9WYHswBX10FNA827iIxR/bINh3xuuUxY46wwshvr+5BJvlsrrdc3rwgjrxBN
 O8zKJhgauzVgcb1mgnGKl+svHTh8pvN/EbuRqfDiNOusEMljOxgIOo8xGOamhWA6QdvO fA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sh0cuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 23:54:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26FNp08d016425
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 23:54:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7047j67e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 23:54:57 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 26FNssI2021132
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 23:54:56 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7047j66y-4;
        Fri, 15 Jul 2022 23:54:56 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 3/3] NFSD: limit the number of v4 clients to 1024 per 1GB of system memory
Date:   Fri, 15 Jul 2022 16:54:53 -0700
Message-Id: <1657929293-30442-4-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1657929293-30442-1-git-send-email-dai.ngo@oracle.com>
References: <1657929293-30442-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: E-rRasgKQXdp_QXDCJGMxMbX28isQeRT
X-Proofpoint-ORIG-GUID: E-rRasgKQXdp_QXDCJGMxMbX28isQeRT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently there is no limit on how many v4 clients are supported
by the system. This can be a problem in systems with small memory
configuration to function properly when a very large number of
clients exist that creates memory shortage conditions.

This patch enforces a limit of 1024 NFSv4 clients, including courtesy
clients, per 1GB of system memory.  When the number of the clients
reaches the limit, requests that create new clients are returned
with NFS4ERR_DELAY and the laundromat is kicked start to trim old
clients. Due to the overhead of the upcall to remove the client
record, the maximun number of clients the laundromat removes on
each run is limited to 128. This is done to ensure the laundromat
can still process the other tasks in a timely manner.

Since there is now a limit of the number of clients, the 24-hr
idle time limit of courtesy client is no longer needed and was
removed.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/netns.h     |  1 +
 fs/nfsd/nfs4state.c | 27 +++++++++++++++++++++------
 fs/nfsd/nfsd.h      |  2 ++
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index ce864f001a3e..ffe17743cc74 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -191,6 +191,7 @@ struct nfsd_net {
 	siphash_key_t		siphash_key;
 
 	atomic_t		nfs4_client_count;
+	int			nfs4_max_clients;
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 8f2b086bf4da..28e98ee23d8c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2059,6 +2059,10 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name,
 	struct nfs4_client *clp;
 	int i;
 
+	if (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients) {
+		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
+		return NULL;
+	}
 	clp = kmem_cache_zalloc(client_slab, GFP_KERNEL);
 	if (clp == NULL)
 		return NULL;
@@ -4336,6 +4340,9 @@ nfsd4_init_slabs(void)
 
 void nfsd4_init_leases_net(struct nfsd_net *nn)
 {
+	u64 max_clients;
+	struct sysinfo si;
+
 	nn->nfsd4_lease = 90;	/* default lease time */
 	nn->nfsd4_grace = 90;
 	nn->somebody_reclaimed = false;
@@ -4346,6 +4353,10 @@ void nfsd4_init_leases_net(struct nfsd_net *nn)
 	nn->s2s_cp_cl_id = nn->clientid_counter++;
 
 	atomic_set(&nn->nfs4_client_count, 0);
+	si_meminfo(&si);
+	max_clients = (u64)si.totalram * si.mem_unit / (1024 * 1024 * 1024);
+	max_clients *= NFS4_CLIENTS_PER_GB;
+	nn->nfs4_max_clients = max_t(int, max_clients, NFS4_CLIENTS_PER_GB);
 }
 
 static void init_nfs4_replay(struct nfs4_replay *rp)
@@ -5812,7 +5823,10 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
 {
 	struct list_head *pos, *next;
 	struct nfs4_client *clp;
+	unsigned int maxreap, reapcnt = 0;
 
+	maxreap = (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients) ?
+			NFSD_CLIENT_MAX_TRIM_PER_RUN : 0;
 	INIT_LIST_HEAD(reaplist);
 	spin_lock(&nn->client_lock);
 	list_for_each_safe(pos, next, &nn->client_lru) {
@@ -5823,14 +5837,15 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
 			break;
 		if (!atomic_read(&clp->cl_rpc_users))
 			clp->cl_state = NFSD4_COURTESY;
-		if (!client_has_state(clp) ||
-				ktime_get_boottime_seconds() >=
-				(clp->cl_time + NFSD_COURTESY_CLIENT_TIMEOUT))
+		if (!client_has_state(clp))
 			goto exp_client;
-		if (nfs4_anylock_blockers(clp)) {
+		if (!nfs4_anylock_blockers(clp))
+			if (reapcnt >= maxreap)
+				continue;
 exp_client:
-			if (!mark_client_expired_locked(clp))
-				list_add(&clp->cl_lru, reaplist);
+		if (!mark_client_expired_locked(clp)) {
+			list_add(&clp->cl_lru, reaplist);
+			reapcnt++;
 		}
 	}
 	spin_unlock(&nn->client_lock);
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 036015b2dd50..a6bfb1b88296 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -341,6 +341,8 @@ void		nfsd_lockd_shutdown(void);
 
 #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
 #define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
+#define	NFSD_CLIENT_MAX_TRIM_PER_RUN	128
+#define	NFS4_CLIENTS_PER_GB		1024
 
 /*
  * The following attributes are currently not supported by the NFSv4 server:
-- 
2.9.5

