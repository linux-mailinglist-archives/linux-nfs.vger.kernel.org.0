Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FE9565DC4
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Jul 2022 21:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbiGDTFy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Jul 2022 15:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbiGDTFw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Jul 2022 15:05:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EA494
        for <linux-nfs@vger.kernel.org>; Mon,  4 Jul 2022 12:05:51 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 264HH26W001698
        for <linux-nfs@vger.kernel.org>; Mon, 4 Jul 2022 19:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=rDqLVu/DAZO43tXxrzlgoKxWzQiNO4hrUOqroNXLULA=;
 b=ur9Q0zDCWlsxXsgKMRV+WLh8KR6rWl0yXamEpcXzSfLFuy/2XKRdLrMSqCM8DyeIg/S/
 3mSUjTTMMD9kr3Hg4UdnmI8tPdBT2CISTIT7czTditWFzj+XY4gRGBKvv7lnXNpLLNQp
 ps2HEgBJXt0SSh3axx5bzqx8pkpFz9dl+ji1i6qDRBE2pSJxA3eUJtv5+2dQ0jo7giJd
 Z//hrMZlWknd5a31eTfMrHgBDlXLDWTD00RtscrNYxiHHB/jLU6yh3xgSYf7uGdxM/tN
 yhMcEgc5iRHFXi8QFQLTbW6Pkied2lo9jMSmVBJVUDJOPIL3VgNXr3QzG4kyONYYTpa/ 5g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h2eju40sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Mon, 04 Jul 2022 19:05:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 264J1PWf022085
        for <linux-nfs@vger.kernel.org>; Mon, 4 Jul 2022 19:05:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h2cf7vt95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Mon, 04 Jul 2022 19:05:50 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 264J5mhu029031
        for <linux-nfs@vger.kernel.org>; Mon, 4 Jul 2022 19:05:49 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h2cf7vt8d-3;
        Mon, 04 Jul 2022 19:05:49 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/2] NFSD: handling memory shortage condition with Courteous server.
Date:   Mon,  4 Jul 2022 12:05:43 -0700
Message-Id: <1656961543-25210-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1656961543-25210-1-git-send-email-dai.ngo@oracle.com>
References: <1656961543-25210-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: ct_g5yP_xzIOpcUuWI9u2PUSTnr_eDxd
X-Proofpoint-ORIG-GUID: ct_g5yP_xzIOpcUuWI9u2PUSTnr_eDxd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently the idle timeout for courtesy client is fixed at 1 day. If
there are lots of courtesy clients remain in the system it can cause
memory resource shortage that effects the operations of other modules
in the kernel. This problem can be observed by running pynfs nfs4.0
CID5 test in a loop. Eventually system runs out of memory and rpc.gssd
fails to add new watch:

rpc.gssd[3851]: ERROR: inotify_add_watch failed for nfsd4_cb/clnt6c2e:
                No space left on device

and alloc_inode also fails with out of memory:

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

This patch addresses this problem by:

   . removing the fixed 1-day idle time limit for courtesy client.
     Courtesy client is now allowed to remain valid as long as the
     available system memory is above 80%.

   . when available system memory drops below 80%, laundromat starts
     trimming older courtesy clients. The number of courtesy clients
     to trim is a percentage of the total number of courtesy clients
     exist in the system.  This percentage is computed based on
     the current percentage of available system memory.

   . the percentage of number of courtesy clients to be trimmed
     is based on this table:

     ----------------------------------
     |  % memory | % courtesy clients |
     | available |    to trim         |
     ----------------------------------
     |  > 80     |      0             |
     |  > 70     |     10             |
     |  > 60     |     20             |
     |  > 50     |     40             |
     |  > 40     |     60             |
     |  > 30     |     80             |
     |  < 30     |    100             |
     ----------------------------------

   . due to the overhead associated with removing client record,
     there is a limit of 128 clients to be trimmed for each
     laundromat run. This is done to prevent the laundromat from
     spending too long destroying the clients and misses performing
     its other tasks in a timely manner.

   . the laundromat is scheduled to run sooner if there are more
     courtesy clients need to be destroyed.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a34ffb0d8c77..c9d3955976b9 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5794,14 +5794,50 @@ nfs4_anylock_blockers(struct nfs4_client *clp)
 	return false;
 }
 
+/*
+ * percentage of the number of courtesy clients to
+ * trim for a given percentage of available memory.
+ */
+static unsigned char avail_mem_to_trim_perc[11] = {
+	/*  0% */		100,
+	/* 10% */		100,
+	/* 20% */		100,
+	/* 30% */		80,
+	/* 40% */		60,
+	/* 50% */		40,
+	/* 60% */		20,
+	/* 70% */		10,
+	/* 80%, 90%, 100% */	0, 0, 0
+};
+#define	NFSD_COURTESY_CLIENT_MAX_TRIM_PER_RUN	128
+
+static unsigned int
+nfs4_get_maxreap(struct nfsd_net *nn)
+{
+	unsigned int clnts, avail;
+	struct sysinfo si;
+
+	si_meminfo(&si);
+	avail = ((si.freeram * 100) / (si.totalram - si.totalhigh) / 10);
+	if (!avail_mem_to_trim_perc[avail])
+		return 0;
+	clnts = atomic_read(&courtesy_client_count);
+	return min_t(unsigned int,
+		((clnts * avail_mem_to_trim_perc[avail]) / 100),
+		NFSD_COURTESY_CLIENT_MAX_TRIM_PER_RUN);
+}
+
 static void
 nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
 				struct laundry_time *lt)
 {
+	unsigned int maxreap, oldstate;
+	int reapcnt = 0;
 	struct list_head *pos, *next;
 	struct nfs4_client *clp;
 
 	INIT_LIST_HEAD(reaplist);
+	maxreap = nfs4_get_maxreap(nn);
 	spin_lock(&nn->client_lock);
 	list_for_each_safe(pos, next, &nn->client_lru) {
 		clp = list_entry(pos, struct nfs4_client, cl_lru);
@@ -5810,21 +5846,31 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
 		if (!state_expired(lt, clp->cl_time))
 			break;
 		if (!atomic_read(&clp->cl_rpc_users)) {
-			if (xchg(&clp->cl_state, NFSD4_COURTESY) ==
-							NFSD4_ACTIVE)
+			oldstate = xchg(&clp->cl_state, NFSD4_COURTESY);
+			if (oldstate == NFSD4_ACTIVE)
 				atomic_inc(&courtesy_client_count);
 		}
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
+			/* expired client has state with no blocker */
+			if (oldstate != NFSD4_ACTIVE &&
+					(maxreap && reapcnt < maxreap))
+				goto exp_client;
 		}
 	}
 	spin_unlock(&nn->client_lock);
+
+	if (reapcnt == NFSD_COURTESY_CLIENT_MAX_TRIM_PER_RUN &&
+		atomic_read(&courtesy_client_count) >
+			NFSD_COURTESY_CLIENT_MAX_TRIM_PER_RUN)
+		lt->new_timeo = NFSD_LAUNDROMAT_MINTIMEOUT;
 }
 
 static time64_t
-- 
2.9.5

