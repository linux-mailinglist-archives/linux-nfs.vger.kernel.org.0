Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B81565DC3
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Jul 2022 21:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiGDTFx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Jul 2022 15:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbiGDTFv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Jul 2022 15:05:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F71FB5F
        for <linux-nfs@vger.kernel.org>; Mon,  4 Jul 2022 12:05:50 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 264HLoNa001743
        for <linux-nfs@vger.kernel.org>; Mon, 4 Jul 2022 19:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2021-07-09;
 bh=mm7HMX+Ha+Z0Nslan+0Wi0F4zVLZc6U9kOesHa3yt6o=;
 b=IiOdVpGgZs0BBMTESthUZUI7BsErNuYEfINjc0uN4uMYvtNH5EqRXWi3KHisgQzJmEmB
 GAgbo5ZeJiamcJgDzGT2fhnn6nzSCL+fdIGfSjTmSYGXBdzQpdWmQwfSphOGbamJTmKE
 dyZ1sFZzqPkow22Sn98NM1JidIrY3TXvYBmrevMO690fNFeLymyMmxIyOgjoTF/YBh5M
 1xEP0ZrweIixEnmZ/bSuvqNHR8jZmb7vT7eGqW7ddQ69RrbYMrGU65IhcNdDQz/0mZCB
 mnOm505H4/qZNHI6/2hGuKqVbIirBiVusa1F6qMaBcD+kzozAYNid2OHdfV5OCIhVMR8 HA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h2eju40sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Mon, 04 Jul 2022 19:05:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 264J1PP6022079
        for <linux-nfs@vger.kernel.org>; Mon, 4 Jul 2022 19:05:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h2cf7vt8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Mon, 04 Jul 2022 19:05:48 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 264J5mhq029031
        for <linux-nfs@vger.kernel.org>; Mon, 4 Jul 2022 19:05:48 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h2cf7vt8d-1;
        Mon, 04 Jul 2022 19:05:48 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/2] NFSD: handling memory shortage problem with Courteous server
Date:   Mon,  4 Jul 2022 12:05:41 -0700
Message-Id: <1656961543-25210-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-GUID: nrb4fnMphTJj2N3qKjP2lS6lM8nky1Bx
X-Proofpoint-ORIG-GUID: nrb4fnMphTJj2N3qKjP2lS6lM8nky1Bx
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

The shrinker method was evaluated and found it's not suitable
for this problem due to these reasons: 

. destroying the NFSv4 client on the shrinker context can cause
  deadlock since nfsd_file_put calls into the underlying FS
  code and we have no control what it will do as seen in this
  stack trace:

 ======================================================
 WARNING: possible circular locking dependency detected
 5.19.0-rc2_sk+ #1 Not tainted
 ------------------------------------------------------
 lck/31847 is trying to acquire lock:
 ffff88811d268850 (&sb->s_type->i_mutex_key#16){+.+.}-{3:3}, at: btrfs_inode_lock+0x38/0x70
 #012but task is already holding lock:
 ffffffffb41848c0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0x506/0x1db0
 #012which lock already depends on the new lock.
 #012the existing dependency chain (in reverse order) is:

 #012-> #1 (fs_reclaim){+.+.}-{0:0}:
       fs_reclaim_acquire+0xc0/0x100
       __kmalloc+0x51/0x320
       btrfs_buffered_write+0x2eb/0xd90
       btrfs_do_write_iter+0x6bf/0x11c0
       do_iter_readv_writev+0x2bb/0x5a0
       do_iter_write+0x131/0x630
       nfsd_vfs_write+0x4da/0x1900 [nfsd]
       nfsd4_write+0x2ac/0x760 [nfsd]
       nfsd4_proc_compound+0xce8/0x23e0 [nfsd]
       nfsd_dispatch+0x4ed/0xc10 [nfsd]
       svc_process_common+0xd3f/0x1b00 [sunrpc]
       svc_process+0x361/0x4f0 [sunrpc]
       nfsd+0x2d6/0x570 [nfsd]
       kthread+0x2a1/0x340
       ret_from_fork+0x22/0x30

 #012-> #0 (&sb->s_type->i_mutex_key#16){+.+.}-{3:3}:
       __lock_acquire+0x318d/0x7830
       lock_acquire+0x1bb/0x500
       down_write+0x82/0x130
       btrfs_inode_lock+0x38/0x70
       btrfs_sync_file+0x280/0x1010
       nfsd_file_flush.isra.0+0x1b/0x220 [nfsd]
       nfsd_file_put+0xd4/0x110 [nfsd]
       release_all_access+0x13a/0x220 [nfsd]
       nfs4_free_ol_stateid+0x40/0x90 [nfsd]
       free_ol_stateid_reaplist+0x131/0x210 [nfsd]
       release_openowner+0xf7/0x160 [nfsd]
       __destroy_client+0x3cc/0x740 [nfsd]
       nfsd_cc_lru_scan+0x271/0x410 [nfsd]
       shrink_slab.constprop.0+0x31e/0x7d0
       shrink_node+0x54b/0xe50
       try_to_free_pages+0x394/0xba0
       __alloc_pages_slowpath.constprop.0+0x5d2/0x1db0
       __alloc_pages+0x4d6/0x580
       __handle_mm_fault+0xc25/0x2810
       handle_mm_fault+0x136/0x480
       do_user_addr_fault+0x3d8/0xec0
       exc_page_fault+0x5d/0xc0
       asm_exc_page_fault+0x27/0x30
 #012other info that might help us debug this:
 Possible unsafe locking scenario:
       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&sb->s_type->i_mutex_key#16);
                               lock(fs_reclaim);
  lock(&sb->s_type->i_mutex_key#16);
 #012 *** DEADLOCK ***

. the shrinker kicks in only when memory drops really low, ~<5%.
  By this time, some other components in the system already run
  into issue with memory shortage. For example, rpc.gssd starts
  failing to add watches in /var/lib/nfs/rpc_pipefs/nfsd4_cb
  once the memory consumed by these watches reaches about 1% of
  available system memory.
        
. destroying the NFSv4 client has significant overhead due to
  the upcall to user space to remove the client records which
  might access storage device. There is potential deadlock
  if the storage subsystem needs to allocate memory.
