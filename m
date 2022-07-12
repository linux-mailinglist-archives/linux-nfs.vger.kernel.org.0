Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EF4572701
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Jul 2022 22:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiGLULK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Jul 2022 16:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiGLULJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Jul 2022 16:11:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C8CBEB40
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 13:11:08 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CJXoxf004669
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 20:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=NorEoZ7YcHJUo3tPOR/iLN5QIR8q5nMqggpd7EF22m0=;
 b=goKrMaCwl4Pxv6/dbW2BtlWAGDoXIEpdrf+iY7cfnk+Q0w2tzB8uqOFgxWf7Qa3Y4Enp
 yxVfHQMaZCHWaDT4hsdfHiGr/SXPq13wt1Gfu3t5nYq0oc2ae5sYo23JDBglEXyi6Vaq
 AIkn8iY0S3+duA2RPTy4bXzuuQbi6wJD1GciPJASlgyGuNnsFJGm0sY9p5pN8kIJlS82
 LH+apvuUiVvmTvUd+9UUHHrUJuOPmf6U/xzSnp5HlutvEWb1b2PQFrcCULsV4AEMq612
 phyqc2xhIn3mLfDfi02McDFK365AqyNtts6OjhoArD8L05EiG7Aj05GtZ5G8V2n6DKLY IQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xrg6sa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 20:11:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CK1KSH019903
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 20:11:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70449v4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 20:11:06 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 26CKB4eM009546
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 20:11:06 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70449v2t-3;
        Tue, 12 Jul 2022 20:11:06 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFSD: limit the number of v4 clients to 4096 per 4GB of system memory
Date:   Tue, 12 Jul 2022 13:11:00 -0700
Message-Id: <1657656660-16647-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1657656660-16647-1-git-send-email-dai.ngo@oracle.com>
References: <1657656660-16647-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: bdEP6hwaj_o6-8gRwkgZ3lx6UYyYXk2D
X-Proofpoint-ORIG-GUID: bdEP6hwaj_o6-8gRwkgZ3lx6UYyYXk2D
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

This patch enforces a limit of 4096 NFSv4 clients, including courtesy
clients, per 4GB of system memory.  When the number of the clients
reaches the limit, requests that create new clients are returned
with NFS4ERR_DELAY. The laundromat detects this condition and removes
older courtesy clients. Due to the overhead of the upcall to remove
the client record, the maximun number of clients the laundromat
removes on each run is limited to 128. This is done to ensure the
laundromat can still process other tasks in a timely manner.

Since there is now a limit of the number of clients, the 24-hr
idle time limit of courtesy client is no longer needed and was
removed.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/netns.h     |  1 +
 fs/nfsd/nfs4state.c | 17 +++++++++++++----
 fs/nfsd/nfsctl.c    |  8 ++++++++
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index ce864f001a3e..8d72b302a49c 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -191,6 +191,7 @@ struct nfsd_net {
 	siphash_key_t		siphash_key;
 
 	atomic_t		nfs4_client_count;
+	unsigned int		nfs4_max_clients;
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 30e16d9e8657..e54db346dc00 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -126,6 +126,7 @@ static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
 static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
 
 static struct workqueue_struct *laundry_wq;
+#define	NFSD_CLIENT_MAX_TRIM_PER_RUN	128
 
 int nfsd4_create_laundry_wq(void)
 {
@@ -2059,6 +2060,8 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name,
 	struct nfs4_client *clp;
 	int i;
 
+	if (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients)
+		return NULL;
 	clp = kmem_cache_zalloc(client_slab, GFP_KERNEL);
 	if (clp == NULL)
 		return NULL;
@@ -5796,9 +5799,12 @@ static void
 nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
 				struct laundry_time *lt)
 {
+	unsigned int maxreap = 0, reapcnt = 0;
 	struct list_head *pos, *next;
 	struct nfs4_client *clp;
 
+	if (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients)
+		maxreap = NFSD_CLIENT_MAX_TRIM_PER_RUN;
 	INIT_LIST_HEAD(reaplist);
 	spin_lock(&nn->client_lock);
 	list_for_each_safe(pos, next, &nn->client_lru) {
@@ -5809,14 +5815,17 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
 			break;
 		if (!atomic_read(&clp->cl_rpc_users))
 			clp->cl_state = NFSD4_COURTESY;
-		if (!client_has_state(clp) ||
-				ktime_get_boottime_seconds() >=
-				(clp->cl_time + NFSD_COURTESY_CLIENT_TIMEOUT))
+		if (!client_has_state(clp))
 			goto exp_client;
 		if (nfs4_anylock_blockers(clp)) {
 exp_client:
-			if (!mark_client_expired_locked(clp))
+			if (!mark_client_expired_locked(clp)) {
 				list_add(&clp->cl_lru, reaplist);
+				reapcnt++;
+			}
+		} else {
+			if (reapcnt < maxreap)
+				goto exp_client;
 		}
 	}
 	spin_unlock(&nn->client_lock);
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 547f4c4b9668..223659e15af3 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -96,6 +96,8 @@ static ssize_t (*const write_op[])(struct file *, char *, size_t) = {
 #endif
 };
 
+#define	NFS4_MAX_CLIENTS_PER_4GB	4096
+
 static ssize_t nfsctl_transaction_write(struct file *file, const char __user *buf, size_t size, loff_t *pos)
 {
 	ino_t ino =  file_inode(file)->i_ino;
@@ -1462,6 +1464,8 @@ unsigned int nfsd_net_id;
 static __net_init int nfsd_init_net(struct net *net)
 {
 	int retval;
+	unsigned long lowmem;
+	struct sysinfo si;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	retval = nfsd_export_init(net);
@@ -1488,6 +1492,10 @@ static __net_init int nfsd_init_net(struct net *net)
 	seqlock_init(&nn->writeverf_lock);
 
 	atomic_set(&nn->nfs4_client_count, 0);
+	si_meminfo(&si);
+	lowmem = (si.totalram - si.totalhigh) * si.mem_unit;
+	nn->nfs4_max_clients = (((lowmem * 100) >> 32) *
+				NFS4_MAX_CLIENTS_PER_4GB) / 100;
 
 	return 0;
 
-- 
2.9.5

