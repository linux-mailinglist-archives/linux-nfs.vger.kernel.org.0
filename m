Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F06555316
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jun 2022 20:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377505AbiFVSPa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jun 2022 14:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346019AbiFVSPZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jun 2022 14:15:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3213DA65
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 11:15:24 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25MFREBX021455
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 18:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2021-07-09;
 bh=cCEBblcPZqJ/Wo9J5sKdqu4FUwU7HLwQ7kPfqW2M2xY=;
 b=F7lVc+wf4MKuWnkRncIGSq8mnMRAw8DQmxUK1BuLBIce5308abeIQh7jT3M+Tik/vLKb
 wbZ20PE8/lkhCSdH9CEjuYOLUxXoAOt26XYHdEkts4oLcUa7e43BsrSxI3gf2ZPsLuFm
 +8gAr/txENcRDK9XKkqjrz1vNAFFKIoCGyBjGrQ6D087W7u08GNhIf41QQi/9n1t73It
 Py+C0ZId9lWJmSY/UDc/4Ig9GhGJYTHcFYMu2kSiffPpQdh1pMoxV0ywNGZ5Mb94VuIC
 Id0GLEu40x6ebA3z2kNbch9w4eYz96E4XAi5es2ddkj++qu9DKuQjaCXkTO+RVCtfVfl gQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6at18nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 18:15:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25MIApD6003558
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 18:15:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtf5dvcd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 18:15:22 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 25MIFMNw016596
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 18:15:22 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtf5dvccx-1;
        Wed, 22 Jun 2022 18:15:22 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSD: Fix memory shortage problem with Courteous server.
Date:   Wed, 22 Jun 2022 11:15:18 -0700
Message-Id: <1655921718-28842-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-ORIG-GUID: Cq5LSvR8gDwtoL01onSEv6kflvCXdeRD
X-Proofpoint-GUID: Cq5LSvR8gDwtoL01onSEv6kflvCXdeRD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently the idle timeout for courtesy client is fixed at 1 day.
If there are lots of courtesy clients remain in the system it can
cause memory resource shortage that effects the operations of other
modules in the kernel. This problem can be observed by running pynfs
nfs4.0 CID5 test in a loop. Eventually system runs out of memory
and rpc.gssd fails to add new watch:

rpc.gssd[3851]: ERROR: inotify_add_watch failed for nfsd4_cb/clnt6c2e:
		No space left on device

and also alloc_inode fails with out of memory:

Call Trace:
<TASK>
        dump_stack_lvl+0x33/0x42
        dump_header+0x4a/0x1ed
        oom_kill_process+0x80/0x10d
        out_of_memory+0x237/0x25f
        __alloc_pages_slowpath.constprop.0+0x617/0x7b6
        __alloc_pages+0x132/0x1e3
        alloc_slab_page+0x15/0x33
        allocate_slab+0x78/0x1ab
        ? alloc_inode+0x38/0x8d
        ___slab_alloc+0x2af/0x373
        ? alloc_inode+0x38/0x8d
        ? slab_pre_alloc_hook.constprop.0+0x9f/0x158
        ? alloc_inode+0x38/0x8d
        __slab_alloc.constprop.0+0x1c/0x24
        kmem_cache_alloc_lru+0x8c/0x142
        alloc_inode+0x38/0x8d
        iget_locked+0x60/0x126
        kernfs_get_inode+0x18/0x105
        kernfs_iop_lookup+0x6d/0xbc
        __lookup_slow+0xb7/0xf9
        lookup_slow+0x3a/0x52
        walk_component+0x90/0x100
        ? inode_permission+0x87/0x128
        link_path_walk.part.0.constprop.0+0x266/0x2ea
        ? path_init+0x101/0x2f2
        path_lookupat+0x4c/0xfa
        filename_lookup+0x63/0xd7
        ? getname_flags+0x32/0x17a
        ? kmem_cache_alloc+0x11f/0x144
        ? getname_flags+0x16c/0x17a
        user_path_at_empty+0x37/0x4b
        do_readlinkat+0x61/0x102
        __x64_sys_readlinkat+0x18/0x1b
        do_syscall_64+0x57/0x72
        entry_SYSCALL_64_after_hwframe+0x46/0xb0
        RIP: 0033:0x7fce5410340e

This patch adds a simple policy to dynamically adjust the idle
timeout based on the percentage of available memory in the system
as follow:

. > 70%    : unlimited. Courtesy clients are allowed to remain valid
             as long as memory availability is above 70%
. 60% - 70%:  1 day.
. 50% - 60%:  1hr
. 40% - 50%:  30mins
. 30% - 40%:  15mins
. < 30%:      disable. Expire all existing courtesy clients and donot
              allow new courtesey client

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 41 +++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/nfsd.h      |  5 ++++-
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 9409a0dc1b76..a7feea9d07cf 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5788,12 +5788,47 @@ nfs4_anylock_blockers(struct nfs4_client *clp)
 	return false;
 }
 
+static bool
+nfs4_allow_courtesy_client(struct nfsd_net *nn, unsigned int *idle_timeout)
+{
+	unsigned long avail;
+	bool ret = true;
+	unsigned int courtesy_expire = 0;
+	struct sysinfo si;
+
+	si_meminfo(&si);
+	avail = (si.freeram * 10) / (si.totalram - si.totalhigh);
+	switch (avail) {
+	case 7: case 8: case 9: case 10:
+		courtesy_expire = 0;		/* unlimit */
+		break;
+	case 6:
+		courtesy_expire = NFSD_COURTESY_CLIENT_TO_1DAY;
+		break;
+	case 5:
+		courtesy_expire = NFSD_COURTESY_CLIENT_TO_1HR;
+		break;
+	case 4:
+		courtesy_expire = NFSD_COURTESY_CLIENT_TO_30MINS;
+		break;
+	case 3:
+		courtesy_expire = NFSD_COURTESY_CLIENT_TO_15MINS;
+		break;
+	default:
+		ret = false;			/* disallow CC */
+	}
+	*idle_timeout = courtesy_expire;
+	return ret;
+}
+
 static void
 nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
 				struct laundry_time *lt)
 {
 	struct list_head *pos, *next;
 	struct nfs4_client *clp;
+	unsigned int exptime;
+	bool allow_cc = nfs4_allow_courtesy_client(nn, &exptime);
 
 	INIT_LIST_HEAD(reaplist);
 	spin_lock(&nn->client_lock);
@@ -5803,11 +5838,13 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
 			goto exp_client;
 		if (!state_expired(lt, clp->cl_time))
 			break;
+		if (!allow_cc)
+			goto exp_client;
 		if (!atomic_read(&clp->cl_rpc_users))
 			clp->cl_state = NFSD4_COURTESY;
 		if (!client_has_state(clp) ||
-				ktime_get_boottime_seconds() >=
-				(clp->cl_time + NFSD_COURTESY_CLIENT_TIMEOUT))
+				(exptime && ktime_get_boottime_seconds() >=
+				(clp->cl_time + exptime)))
 			goto exp_client;
 		if (nfs4_anylock_blockers(clp)) {
 exp_client:
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 847b482155ae..9d4a5708f852 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -340,7 +340,10 @@ void		nfsd_lockd_shutdown(void);
 #define COMPOUND_ERR_SLACK_SPACE	16     /* OP_SETATTR */
 
 #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
-#define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
+#define	NFSD_COURTESY_CLIENT_TO_1DAY	(24 * 60 * 60)	/* seconds */
+#define	NFSD_COURTESY_CLIENT_TO_1HR	(60 * 60)
+#define	NFSD_COURTESY_CLIENT_TO_30MINS	(30 * 60)
+#define	NFSD_COURTESY_CLIENT_TO_15MINS	(15 * 60)
 
 /*
  * The following attributes are currently not supported by the NFSv4 server:
-- 
2.9.5

