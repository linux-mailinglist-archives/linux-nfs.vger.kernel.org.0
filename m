Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCD557529F
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jul 2022 18:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbiGNQRu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jul 2022 12:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238921AbiGNQRt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jul 2022 12:17:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A916461D74
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 09:17:48 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26EFs7Ng000894
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 16:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=09zGNvtNF1jafOS6jzYUooKqtTgc2Z8D2gVr7pmQ1gQ=;
 b=fb1ZsjwXuqU7sbrTErNImVNQmwfT3dkxcY5B+deVEUAN5mC/Xg/G1EF4XJym5umG/4i7
 V+yM9BcZ4bEfg2ympR7pDtrbuRowKaLiz6ll6L+Q0EKWDPoxMiVOuc9mi4qC5slx9VFL
 xesPJyoLgAolI1kuJOl3CHULmRyyBFKBJ3q1FjL+z6V2Jfh2ZfHoOY6b9qNny9TuLZF2
 nf2BU0qFN+BF9GWQ6efGTp4B2He+pjAzabACtSS7WvJBf/aQriYK+BVtEJF7aUn947e4
 47kDrlw90iPHVuRZQHChJvD8UDA/nzcX0BUtKSen85pUlhicjtqcZwtdT/L1r7ntjlBp /A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xrnnjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 16:17:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26EGFfne018976
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 16:17:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h70467f6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 16:17:46 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 26EGHjDs024660
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 16:17:46 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h70467f5u-3;
        Thu, 14 Jul 2022 16:17:46 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/2] NFSD: limit the number of v4 clients to 1024 per 1GB of system memory
Date:   Thu, 14 Jul 2022 09:17:42 -0700
Message-Id: <1657815462-14069-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1657815462-14069-1-git-send-email-dai.ngo@oracle.com>
References: <1657815462-14069-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: sJm4fvku7PE2tgT58cEpynbw_hLxTRNM
X-Proofpoint-ORIG-GUID: sJm4fvku7PE2tgT58cEpynbw_hLxTRNM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 fs/nfsd/nfs4state.c | 20 ++++++++++++++------
 fs/nfsd/nfsctl.c    |  6 ++++++
 fs/nfsd/nfsd.h      |  2 ++
 4 files changed, 23 insertions(+), 6 deletions(-)

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
index 30e16d9e8657..19807f7f618d 100644
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
@@ -5796,9 +5800,12 @@ static void
 nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
 				struct laundry_time *lt)
 {
+	unsigned int maxreap, reapcnt = 0;
 	struct list_head *pos, *next;
 	struct nfs4_client *clp;
 
+	maxreap = (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients) ?
+			NFSD_CLIENT_MAX_TRIM_PER_RUN : 0;
 	INIT_LIST_HEAD(reaplist);
 	spin_lock(&nn->client_lock);
 	list_for_each_safe(pos, next, &nn->client_lru) {
@@ -5809,14 +5816,15 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
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
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 547f4c4b9668..bbd251da86e4 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1463,6 +1463,8 @@ static __net_init int nfsd_init_net(struct net *net)
 {
 	int retval;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	u64 max_clients;
+	struct sysinfo si;
 
 	retval = nfsd_export_init(net);
 	if (retval)
@@ -1488,6 +1490,10 @@ static __net_init int nfsd_init_net(struct net *net)
 	seqlock_init(&nn->writeverf_lock);
 
 	atomic_set(&nn->nfs4_client_count, 0);
+	si_meminfo(&si);
+	max_clients = (u64)si.totalram * si.mem_unit / (1024 * 1024 * 1024);
+	max_clients *= NFS4_CLIENTS_PER_GB;
+	nn->nfs4_max_clients = max_t(int, max_clients, NFS4_CLIENTS_PER_GB);
 
 	return 0;
 
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 847b482155ae..bbada18225b1 100644
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

