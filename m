Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A834F396F07
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Jun 2021 10:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbhFAIh3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Jun 2021 04:37:29 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2819 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhFAIh2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Jun 2021 04:37:28 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FvQNS5F1LzWmdD;
        Tue,  1 Jun 2021 16:31:04 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 16:35:46 +0800
Received: from [10.174.176.83] (10.174.176.83) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 16:35:45 +0800
From:   "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
To:     <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        <zhangxiaoxu@huawei.com>, "zhangyi (F)" <yi.zhang@huawei.com>
Subject: nfsv4.1 deadlock between evict and nfs_fhget when drain session
Message-ID: <ad39cacf-577f-a9f3-07d3-c5bd5acfc9df@huawei.com>
Date:   Tue, 1 Jun 2021 16:35:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

We're seeing a deadlock on NFSv4.1.

The process of the deadlock maybe as below:
  - task 1: prune icache, and mark inode_A & inode_B on freeing, then evict inode_A first, but waiting for inode_A's delegation return to server
  - task 2: open file, already got the fh from server, waiting for the inode_B which has the same file handle was freed complete
  - task 3: state manager is on draining session, but there is a slot is hold by task2
  - task 4: run the delegreturn rpc_task, but the session is on draining, so the delegreturn is sleeping on rpc. Then task 1 blocked.
then deadlocked.

Commit 244fcd2f9a90 ("NFS: Ensure we time out if a delegreturn does not complete") already ensure the delegreturn
task can timeout if get slot from session. But can't timeout if task sleep on rpc when session is on draining.

I think commit 5fcdfacc01f3 ("NFSv4: Return delegations synchronously in evict_inode") introduce this problem.
But if revert it, there maybe another deadlock because task 1 maybe waiting inode_A writeback complete.
If make delegreturn privileged in rpc, as the same above.

I think the task 2 should free the slot as soon as possible when it's rpc task complete.
But ae55e59da0e4 ("pnfs: Don't release the sequence slot until we've processed layoutget on open") made slot freed more late.

Any idea about this problem is welcome.

Stacks of the problem:

# task1:
__wait_on_freeing_inode
find_inode
ilookup5_nowait
ilookup5
iget5_locked
nfs_fhget
_nfs4_opendata_to_nfs4_state
nfs4_do_open
nfs4_atomic_open
nfs_atomic_open
path_openat
do_filp_open
do_sys_open
__x64_sys_open
do_syscall_64
entry_SYSCALL_64_after_hwframe

# task2:
rpc_wait_bit_killable
__rpc_wait_for_completion_task
_nfs4_proc_delegreturn
nfs4_proc_delegreturn
nfs_do_return_delegation
nfs_inode_return_delegation_noreclaim
nfs4_evict_inode
evict
dispose_list
prune_icache_sb
super_cache_scan
do_shrink_slab
shrink_slab
shrink_node
kswapd
kthread
ret_from_fork

# task3:
nfs4_drain_slot_tbl
nfs4_begin_drain_session
nfs4_run_state_manager
kthread
ret_from_fork
