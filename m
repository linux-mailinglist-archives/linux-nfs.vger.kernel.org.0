Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCF35ABFA3
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Sep 2022 17:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiICPzv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 3 Sep 2022 11:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiICPzu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 3 Sep 2022 11:55:50 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852074D16F;
        Sat,  3 Sep 2022 08:55:46 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id B9E971F78; Sat,  3 Sep 2022 11:55:45 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org B9E971F78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1662220545;
        bh=CAHr9FXybDI9D83EsxFVciDYPTWhcw38wy5/kY9oEnM=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=v8oABrr2JRAcZ1e2y31Q5rZdY6k9iFO7Q3Z6N7R7YbxYg6jtazN4ocVC0PVBpwkLc
         szQWonCOClWl5mNsJW+fDIS4LOyFssB9mX0EEEMR2bhdPmrnRT/CHQse4tfyN1jLji
         Atl1LB2KjSbCdRWtuE3a9RrLFG+XJ0M0KnC8z1Dg=
Date:   Sat, 3 Sep 2022 11:55:45 -0400
To:     Dave Chinner <david@fromorbit.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: all cel/for-rc (1197eb59 lockd: fix nlm_close_files) results
Message-ID: <20220903155545.GB22990@fieldses.org>
References: <FFC9022A-B2AB-4455-870B-6801B327C5B7@oracle.com>
 <20220724163401.GA17655@fieldses.org>
 <20220724163702.GB17655@fieldses.org>
 <0CFBAAC2-1ECF-48E1-A687-75176C2F1A17@oracle.com>
 <20220725021029.GA789@fieldses.org>
 <20220725121600.GA17056@fieldses.org>
 <608CA2C9-464C-464E-B4AD-CF1B8C494A5A@oracle.com>
 <20220725132252.GB17056@fieldses.org>
 <20220725220320.GX3861211@dread.disaster.area>
 <20220725220659.GY3861211@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725220659.GY3861211@dread.disaster.area>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Sorry for being slow to get back to this.  Here's dmesg from the first "blocked" message, this time including a sysrq-w dump at the end.

This is Chuck's for-next (bb49f295d682, which is based on 6.0-rc3).

The client is hung in generic/590 with "server not responding, still trying"
messages.

For what it's worth, the server is a VM, and the exported xfs filesystem
is on a virtio disk (which in turn is backed by a file on an xfs
filesystem on an ssd).  The host seems to be behaving normally.

--b.

[ 5438.560575] INFO: task nfsd:23105 blocked for more than 120 seconds.
[ 5438.562574]       Not tainted 6.0.0-rc3-00008-gbb49f295d682 #3631
[ 5438.563612] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 5438.564823] task:nfsd            state:D stack:24336 pid:23105 ppid:     2 flags:0x00004000
[ 5438.566358] Call Trace:
[ 5438.566682]  <TASK>
[ 5438.566874]  __schedule+0xb73/0x2260
[ 5438.567335]  ? io_schedule_timeout+0x160/0x160
[ 5438.567897]  ? reacquire_held_locks+0x4e0/0x4e0
[ 5438.568587]  ? do_raw_spin_lock+0x11e/0x250
[ 5438.569239]  schedule+0x133/0x230
[ 5438.569624]  io_schedule+0xc3/0x140
[ 5438.570040]  folio_wait_bit_common+0x2e4/0x610
[ 5438.570618]  ? perf_trace_mm_filemap_op_page_cache+0x780/0x780
[ 5438.571742]  ? folio_unlock+0x70/0x70
[ 5438.572480]  ? lock_is_held_type+0xd8/0x130
[ 5438.573034]  folio_wait_writeback+0x40/0x230
[ 5438.573580]  __filemap_fdatawait_range+0x10a/0x2a0
[ 5438.574161]  ? filemap_fdatawrite+0x170/0x170
[ 5438.574632]  ? lock_is_held_type+0xd8/0x130
[ 5438.575040]  file_write_and_wait_range+0xbc/0xf0
[ 5438.575295]  xfs_file_fsync+0x146/0x830
[ 5438.575572]  ? xfs_dio_write_end_io+0x760/0x760
[ 5438.575802]  ? lock_is_held_type+0xd8/0x130
[ 5438.576166]  nfsd_commit+0x304/0x560 [nfsd]
[ 5438.576578]  ? nfsd_write+0x4f0/0x4f0 [nfsd]
[ 5438.576823]  ? percpu_counter_add_batch+0x77/0x130
[ 5438.577312]  nfsd4_proc_compound+0xd6f/0x26d0 [nfsd]
[ 5438.577832]  nfsd_dispatch+0x4b9/0xba0 [nfsd]
[ 5438.578332]  svc_process_common+0xc14/0x1aa0 [sunrpc]
[ 5438.578838]  ? svc_create_pooled+0x5c0/0x5c0 [sunrpc]
[ 5438.579273]  ? nfsd_svc+0xc70/0xc70 [nfsd]
[ 5438.579574]  ? svc_sock_secure_port+0x2a/0x50 [sunrpc]
[ 5438.580039]  ? svc_recv+0xc6b/0x28c0 [sunrpc]
[ 5438.580482]  svc_process+0x32d/0x4a0 [sunrpc]
[ 5438.581265]  nfsd+0x2d6/0x570 [nfsd]
[ 5438.581936]  ? nfsd_shutdown_threads+0x290/0x290 [nfsd]
[ 5438.582530]  kthread+0x298/0x340
[ 5438.582817]  ? kthread_complete_and_exit+0x20/0x20
[ 5438.583090]  ret_from_fork+0x22/0x30
[ 5438.583334]  </TASK>
[ 5438.583453] INFO: task nfsd:23106 blocked for more than 120 seconds.
[ 5438.583957]       Not tainted 6.0.0-rc3-00008-gbb49f295d682 #3631
[ 5438.584552] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 5438.585390] task:nfsd            state:D stack:24448 pid:23106 ppid:     2 flags:0x00004000
[ 5438.586255] Call Trace:
[ 5438.586484]  <TASK>
[ 5438.586582]  __schedule+0xb73/0x2260
[ 5438.586911]  ? io_schedule_timeout+0x160/0x160
[ 5438.587320]  ? sbitmap_get_shallow+0x189/0x5f0
[ 5438.587656]  schedule+0x133/0x230
[ 5438.587855]  io_schedule+0xc3/0x140
[ 5438.588131]  blk_mq_get_tag+0x38c/0xa80
[ 5438.588374]  ? blk_mq_get_tags+0x240/0x240
[ 5438.588591]  ? lock_is_held_type+0xd8/0x130
[ 5438.588817]  ? sched_debug_start+0x180/0x180
[ 5438.589153]  ? __bio_split_to_limits+0x712/0x1080
[ 5438.589421]  __blk_mq_alloc_requests+0x492/0xc50
[ 5438.589687]  ? reacquire_held_locks+0x4e0/0x4e0
[ 5438.589984]  ? blk_mq_timeout_work+0x380/0x380
[ 5438.590265]  blk_mq_submit_bio+0x73c/0x17d0
[ 5438.590565]  ? blk_mq_try_issue_list_directly+0x9a0/0x9a0
[ 5438.590914]  submit_bio_noacct_nocheck+0x5b1/0x820
[ 5438.591289]  ? should_fail_request+0x70/0x70
[ 5438.591558]  ? submit_bio_noacct+0xa50/0x1140
[ 5438.591826]  ? iomap_page_create+0x8b/0x3d0
[ 5438.592122]  iomap_do_writepage+0x1210/0x2450
[ 5438.592409]  ? iomap_write_end+0x9c0/0x9c0
[ 5438.592671]  write_cache_pages+0x3d8/0xed0
[ 5438.592971]  ? iomap_write_end+0x9c0/0x9c0
[ 5438.593196]  ? folio_wait_stable+0xc0/0xc0
[ 5438.593413]  ? lock_is_held_type+0xd8/0x130
[ 5438.593649]  ? do_raw_spin_lock+0x11e/0x250
[ 5438.593879]  iomap_writepages+0x42/0xb0
[ 5438.594085]  xfs_vm_writepages+0x109/0x160
[ 5438.594303]  ? xfs_vm_read_folio+0x20/0x20
[ 5438.594529]  ? nfsd_setuser+0x5fb/0x9c0 [nfsd]
[ 5438.594805]  do_writepages+0x15c/0x590
[ 5438.595002]  ? lock_is_held_type+0xd8/0x130
[ 5438.595230]  ? page_writeback_cpu_online+0x20/0x20
[ 5438.595494]  ? lock_release+0x380/0x760
[ 5438.595696]  ? __lock_acquire+0xc67/0x69f0
[ 5438.595920]  ? lock_is_held_type+0xd8/0x130
[ 5438.596170]  __filemap_fdatawrite_range+0x13e/0x170
[ 5438.596471]  ? rcu_read_lock_sched_held+0x3f/0x70
[ 5438.596734]  ? delete_from_page_cache_batch+0xa30/0xa30
[ 5438.597042]  ? lock_is_held_type+0xd8/0x130
[ 5438.597316]  file_write_and_wait_range+0x8e/0xf0
[ 5438.597587]  xfs_file_fsync+0x146/0x830
[ 5438.597790]  ? xfs_dio_write_end_io+0x760/0x760
[ 5438.598045]  ? lock_is_held_type+0xd8/0x130
[ 5438.598273]  nfsd_commit+0x304/0x560 [nfsd]
[ 5438.598527]  ? nfsd_write+0x4f0/0x4f0 [nfsd]
[ 5438.598783]  ? percpu_counter_add_batch+0x77/0x130
[ 5438.599058]  nfsd4_proc_compound+0xd6f/0x26d0 [nfsd]
[ 5438.599375]  nfsd_dispatch+0x4b9/0xba0 [nfsd]
[ 5438.599640]  svc_process_common+0xc14/0x1aa0 [sunrpc]
[ 5438.599980]  ? svc_create_pooled+0x5c0/0x5c0 [sunrpc]
[ 5438.600370]  ? nfsd_svc+0xc70/0xc70 [nfsd]
[ 5438.600656]  ? svc_sock_secure_port+0x2a/0x50 [sunrpc]
[ 5438.601049]  ? svc_recv+0xc6b/0x28c0 [sunrpc]
[ 5438.601382]  svc_process+0x32d/0x4a0 [sunrpc]
[ 5438.601713]  nfsd+0x2d6/0x570 [nfsd]
[ 5438.601974]  ? nfsd_shutdown_threads+0x290/0x290 [nfsd]
[ 5438.602284]  kthread+0x298/0x340
[ 5438.602437]  ? kthread_complete_and_exit+0x20/0x20
[ 5438.602698]  ret_from_fork+0x22/0x30
[ 5438.602879]  </TASK>
[ 5438.602960] INFO: task nfsd:23107 blocked for more than 120 seconds.
[ 5438.603304]       Not tainted 6.0.0-rc3-00008-gbb49f295d682 #3631
[ 5438.603631] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 5438.604119] task:nfsd            state:D stack:24608 pid:23107 ppid:     2 flags:0x00004000
[ 5438.604644] Call Trace:
[ 5438.604737]  <TASK>
[ 5438.604812]  __schedule+0xb73/0x2260
[ 5438.605013]  ? io_schedule_timeout+0x160/0x160
[ 5438.605237]  ? reacquire_held_locks+0x4e0/0x4e0
[ 5438.605485]  ? do_raw_spin_lock+0x11e/0x250
[ 5438.605718]  schedule+0x133/0x230
[ 5438.605870]  io_schedule+0xc3/0x140
[ 5438.606036]  folio_wait_bit_common+0x2e4/0x610
[ 5438.606268]  ? perf_trace_mm_filemap_op_page_cache+0x780/0x780
[ 5438.606583]  ? folio_unlock+0x70/0x70
[ 5438.606756]  ? lock_is_held_type+0xd8/0x130
[ 5438.607031]  folio_wait_writeback+0x40/0x230
[ 5438.607248]  __filemap_fdatawait_range+0x10a/0x2a0
[ 5438.607497]  ? filemap_fdatawrite+0x170/0x170
[ 5438.607716]  ? lock_is_held_type+0xd8/0x130
[ 5438.607942]  file_write_and_wait_range+0xbc/0xf0
[ 5438.608261]  xfs_file_fsync+0x146/0x830
[ 5438.608462]  ? xfs_dio_write_end_io+0x760/0x760
[ 5438.608692]  ? lock_is_held_type+0xd8/0x130
[ 5438.608903]  nfsd_commit+0x304/0x560 [nfsd]
[ 5438.609142]  ? nfsd_write+0x4f0/0x4f0 [nfsd]
[ 5438.609380]  ? percpu_counter_add_batch+0x77/0x130
[ 5438.609649]  nfsd4_proc_compound+0xd6f/0x26d0 [nfsd]
[ 5438.609942]  nfsd_dispatch+0x4b9/0xba0 [nfsd]
[ 5438.610191]  svc_process_common+0xc14/0x1aa0 [sunrpc]
[ 5438.610493]  ? svc_create_pooled+0x5c0/0x5c0 [sunrpc]
[ 5438.610788]  ? nfsd_svc+0xc70/0xc70 [nfsd]
[ 5438.611010]  ? svc_sock_secure_port+0x2a/0x50 [sunrpc]
[ 5438.611310]  ? svc_recv+0xc6b/0x28c0 [sunrpc]
[ 5438.611567]  svc_process+0x32d/0x4a0 [sunrpc]
[ 5438.611823]  nfsd+0x2d6/0x570 [nfsd]
[ 5438.612018]  ? nfsd_shutdown_threads+0x290/0x290 [nfsd]
[ 5438.612412]  kthread+0x298/0x340
[ 5438.612559]  ? kthread_complete_and_exit+0x20/0x20
[ 5438.612807]  ret_from_fork+0x22/0x30
[ 5438.612994]  </TASK>
[ 5438.613070] INFO: task nfsd:23108 blocked for more than 120 seconds.
[ 5438.613423]       Not tainted 6.0.0-rc3-00008-gbb49f295d682 #3631
[ 5438.613759] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 5438.614198] task:nfsd            state:D stack:24432 pid:23108 ppid:     2 flags:0x00004000
[ 5438.614675] Call Trace:
[ 5438.614767]  <TASK>
[ 5438.614841]  __schedule+0xb73/0x2260
[ 5438.615019]  ? io_schedule_timeout+0x160/0x160
[ 5438.615242]  ? reacquire_held_locks+0x4e0/0x4e0
[ 5438.615472]  ? do_raw_spin_lock+0x11e/0x250
[ 5438.615683]  schedule+0x133/0x230
[ 5438.615835]  io_schedule+0xc3/0x140
[ 5438.616001]  folio_wait_bit_common+0x2e4/0x610
[ 5438.616325]  ? perf_trace_mm_filemap_op_page_cache+0x780/0x780
[ 5438.616642]  ? folio_unlock+0x70/0x70
[ 5438.616838]  ? lock_is_held_type+0xd8/0x130
[ 5438.617077]  folio_wait_writeback+0x40/0x230
[ 5438.617313]  __filemap_fdatawait_range+0x10a/0x2a0
[ 5438.617679]  ? filemap_fdatawrite+0x170/0x170
[ 5438.617929]  ? lock_is_held_type+0xd8/0x130
[ 5438.618173]  file_write_and_wait_range+0xbc/0xf0
[ 5438.618412]  xfs_file_fsync+0x146/0x830
[ 5438.618598]  ? xfs_dio_write_end_io+0x760/0x760
[ 5438.618827]  ? lock_is_held_type+0xd8/0x130
[ 5438.619043]  nfsd_commit+0x304/0x560 [nfsd]
[ 5438.619278]  ? nfsd_write+0x4f0/0x4f0 [nfsd]
[ 5438.619515]  ? percpu_counter_add_batch+0x77/0x130
[ 5438.619764]  nfsd4_proc_compound+0xd6f/0x26d0 [nfsd]
[ 5438.620108]  nfsd_dispatch+0x4b9/0xba0 [nfsd]
[ 5438.620404]  svc_process_common+0xc14/0x1aa0 [sunrpc]
[ 5438.620708]  ? svc_create_pooled+0x5c0/0x5c0 [sunrpc]
[ 5438.621007]  ? nfsd_svc+0xc70/0xc70 [nfsd]
[ 5438.621227]  ? svc_sock_secure_port+0x2a/0x50 [sunrpc]
[ 5438.621547]  ? svc_recv+0xc6b/0x28c0 [sunrpc]
[ 5438.621804]  svc_process+0x32d/0x4a0 [sunrpc]
[ 5438.622063]  nfsd+0x2d6/0x570 [nfsd]
[ 5438.622257]  ? nfsd_shutdown_threads+0x290/0x290 [nfsd]
[ 5438.622550]  kthread+0x298/0x340
[ 5438.622695]  ? kthread_complete_and_exit+0x20/0x20
[ 5438.622943]  ret_from_fork+0x22/0x30
[ 5438.623150]  </TASK>
[ 5438.623227] INFO: task nfsd:23109 blocked for more than 120 seconds.
[ 5438.623569]       Not tainted 6.0.0-rc3-00008-gbb49f295d682 #3631
[ 5438.623896] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 5438.624438] task:nfsd            state:D stack:24000 pid:23109 ppid:     2 flags:0x00004000
[ 5438.624917] Call Trace:
[ 5438.625013]  <TASK>
[ 5438.625088]  __schedule+0xb73/0x2260
[ 5438.625264]  ? io_schedule_timeout+0x160/0x160
[ 5438.625507]  ? reacquire_held_locks+0x4e0/0x4e0
[ 5438.625736]  ? do_raw_spin_lock+0x11e/0x250
[ 5438.625947]  schedule+0x133/0x230
[ 5438.626103]  io_schedule+0xc3/0x140
[ 5438.626265]  folio_wait_bit_common+0x2e4/0x610
[ 5438.626496]  ? perf_trace_mm_filemap_op_page_cache+0x780/0x780
[ 5438.626811]  ? folio_unlock+0x70/0x70
[ 5438.626987]  ? lock_is_held_type+0xd8/0x130
[ 5438.627199]  folio_wait_writeback+0x40/0x230
[ 5438.627416]  __filemap_fdatawait_range+0x10a/0x2a0
[ 5438.627665]  ? filemap_fdatawrite+0x170/0x170
[ 5438.627884]  ? lock_is_held_type+0xd8/0x130
[ 5438.628164]  file_write_and_wait_range+0xbc/0xf0
[ 5438.628451]  xfs_file_fsync+0x146/0x830
[ 5438.628639]  ? xfs_dio_write_end_io+0x760/0x760
[ 5438.628869]  ? lock_is_held_type+0xd8/0x130
[ 5438.629084]  nfsd_commit+0x304/0x560 [nfsd]
[ 5438.629318]  ? nfsd_write+0x4f0/0x4f0 [nfsd]
[ 5438.629576]  ? percpu_counter_add_batch+0x77/0x130
[ 5438.629825]  nfsd4_proc_compound+0xd6f/0x26d0 [nfsd]
[ 5438.630121]  nfsd_dispatch+0x4b9/0xba0 [nfsd]
[ 5438.630367]  svc_process_common+0xc14/0x1aa0 [sunrpc]
[ 5438.630668]  ? svc_create_pooled+0x5c0/0x5c0 [sunrpc]
[ 5438.630966]  ? nfsd_svc+0xc70/0xc70 [nfsd]
[ 5438.631185]  ? svc_sock_secure_port+0x2a/0x50 [sunrpc]
[ 5438.631484]  ? svc_recv+0xc6b/0x28c0 [sunrpc]
[ 5438.631742]  svc_process+0x32d/0x4a0 [sunrpc]
[ 5438.632001]  nfsd+0x2d6/0x570 [nfsd]
[ 5438.632288]  ? nfsd_shutdown_threads+0x290/0x290 [nfsd]
[ 5438.632585]  kthread+0x298/0x340
[ 5438.632730]  ? kthread_complete_and_exit+0x20/0x20
[ 5438.632983]  ret_from_fork+0x22/0x30
[ 5438.633165]  </TASK>
[ 5438.633240] INFO: task nfsd:23110 blocked for more than 120 seconds.
[ 5438.633604]       Not tainted 6.0.0-rc3-00008-gbb49f295d682 #3631
[ 5438.633930] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 5438.634368] task:nfsd            state:D stack:23952 pid:23110 ppid:     2 flags:0x00004000
[ 5438.634846] Call Trace:
[ 5438.634937]  <TASK>
[ 5438.635014]  __schedule+0xb73/0x2260
[ 5438.635190]  ? io_schedule_timeout+0x160/0x160
[ 5438.635413]  ? reacquire_held_locks+0x4e0/0x4e0
[ 5438.635642]  ? do_raw_spin_lock+0x11e/0x250
[ 5438.635853]  schedule+0x133/0x230
[ 5438.636008]  io_schedule+0xc3/0x140
[ 5438.636220]  folio_wait_bit_common+0x2e4/0x610
[ 5438.636500]  ? perf_trace_mm_filemap_op_page_cache+0x780/0x780
[ 5438.636817]  ? folio_unlock+0x70/0x70
[ 5438.637047]  ? lock_is_held_type+0xd8/0x130
[ 5438.637260]  folio_wait_writeback+0x40/0x230
[ 5438.637497]  __filemap_fdatawait_range+0x10a/0x2a0
[ 5438.637837]  ? filemap_fdatawrite+0x170/0x170
[ 5438.638071]  ? lock_is_held_type+0xd8/0x130
[ 5438.638297]  file_write_and_wait_range+0xbc/0xf0
[ 5438.638533]  xfs_file_fsync+0x146/0x830
[ 5438.638719]  ? xfs_dio_write_end_io+0x760/0x760
[ 5438.638948]  ? lock_is_held_type+0xd8/0x130
[ 5438.639164]  nfsd_commit+0x304/0x560 [nfsd]
[ 5438.639398]  ? nfsd_write+0x4f0/0x4f0 [nfsd]
[ 5438.639634]  ? percpu_counter_add_batch+0x77/0x130
[ 5438.639883]  nfsd4_proc_compound+0xd6f/0x26d0 [nfsd]
[ 5438.640260]  nfsd_dispatch+0x4b9/0xba0 [nfsd]
[ 5438.640523]  svc_process_common+0xc14/0x1aa0 [sunrpc]
[ 5438.640825]  ? svc_create_pooled+0x5c0/0x5c0 [sunrpc]
[ 5438.641123]  ? nfsd_svc+0xc70/0xc70 [nfsd]
[ 5438.641343]  ? svc_sock_secure_port+0x2a/0x50 [sunrpc]
[ 5438.641664]  ? svc_recv+0xc6b/0x28c0 [sunrpc]
[ 5438.641922]  svc_process+0x32d/0x4a0 [sunrpc]
[ 5438.642181]  nfsd+0x2d6/0x570 [nfsd]
[ 5438.642374]  ? nfsd_shutdown_threads+0x290/0x290 [nfsd]
[ 5438.642667]  kthread+0x298/0x340
[ 5438.642812]  ? kthread_complete_and_exit+0x20/0x20
[ 5438.643063]  ret_from_fork+0x22/0x30
[ 5438.643245]  </TASK>
[ 5438.643321] INFO: task nfsd:23111 blocked for more than 120 seconds.
[ 5438.643663]       Not tainted 6.0.0-rc3-00008-gbb49f295d682 #3631
[ 5438.643991] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 5438.644520] task:nfsd            state:D stack:23808 pid:23111 ppid:     2 flags:0x00004000
[ 5438.645004] Call Trace:
[ 5438.645096]  <TASK>
[ 5438.645171]  __schedule+0xb73/0x2260
[ 5438.645346]  ? io_schedule_timeout+0x160/0x160
[ 5438.645590]  ? reacquire_held_locks+0x4e0/0x4e0
[ 5438.645819]  ? do_raw_spin_lock+0x11e/0x250
[ 5438.646033]  schedule+0x133/0x230
[ 5438.646186]  io_schedule+0xc3/0x140
[ 5438.646348]  folio_wait_bit_common+0x2e4/0x610
[ 5438.646578]  ? perf_trace_mm_filemap_op_page_cache+0x780/0x780
[ 5438.646893]  ? folio_unlock+0x70/0x70
[ 5438.647087]  ? lock_is_held_type+0xd8/0x130
[ 5438.647302]  folio_wait_writeback+0x40/0x230
[ 5438.647519]  __filemap_fdatawait_range+0x10a/0x2a0
[ 5438.647767]  ? filemap_fdatawrite+0x170/0x170
[ 5438.648048]  ? lock_is_held_type+0xd8/0x130
[ 5438.648348]  file_write_and_wait_range+0xbc/0xf0
[ 5438.648587]  xfs_file_fsync+0x146/0x830
[ 5438.648773]  ? xfs_dio_write_end_io+0x760/0x760
[ 5438.649007]  ? lock_is_held_type+0xd8/0x130
[ 5438.649218]  nfsd_commit+0x304/0x560 [nfsd]
[ 5438.649464]  ? nfsd_write+0x4f0/0x4f0 [nfsd]
[ 5438.649710]  ? percpu_counter_add_batch+0x77/0x130
[ 5438.649961]  nfsd4_proc_compound+0xd6f/0x26d0 [nfsd]
[ 5438.650254]  nfsd_dispatch+0x4b9/0xba0 [nfsd]
[ 5438.650499]  svc_process_common+0xc14/0x1aa0 [sunrpc]
[ 5438.650799]  ? svc_create_pooled+0x5c0/0x5c0 [sunrpc]
[ 5438.651096]  ? nfsd_svc+0xc70/0xc70 [nfsd]
[ 5438.651316]  ? svc_sock_secure_port+0x2a/0x50 [sunrpc]
[ 5438.651615]  ? svc_recv+0xc6b/0x28c0 [sunrpc]
[ 5438.651873]  svc_process+0x32d/0x4a0 [sunrpc]
[ 5438.652181]  nfsd+0x2d6/0x570 [nfsd]
[ 5438.652423]  ? nfsd_shutdown_threads+0x290/0x290 [nfsd]
[ 5438.652719]  kthread+0x298/0x340
[ 5438.652865]  ? kthread_complete_and_exit+0x20/0x20
[ 5438.653117]  ret_from_fork+0x22/0x30
[ 5438.653299]  </TASK>
[ 5438.653375] INFO: task nfsd:23112 blocked for more than 120 seconds.
[ 5438.653738]       Not tainted 6.0.0-rc3-00008-gbb49f295d682 #3631
[ 5438.654067] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 5438.654502] task:nfsd            state:D stack:21968 pid:23112 ppid:     2 flags:0x00004000
[ 5438.654982] Call Trace:
[ 5438.655073]  <TASK>
[ 5438.655148]  __schedule+0xb73/0x2260
[ 5438.655323]  ? io_schedule_timeout+0x160/0x160
[ 5438.655546]  ? reacquire_held_locks+0x4e0/0x4e0
[ 5438.655776]  ? do_raw_spin_lock+0x11e/0x250
[ 5438.655989]  schedule+0x133/0x230
[ 5438.656190]  io_schedule+0xc3/0x140
[ 5438.656404]  folio_wait_bit_common+0x2e4/0x610
[ 5438.656637]  ? perf_trace_mm_filemap_op_page_cache+0x780/0x780
[ 5438.656956]  ? folio_unlock+0x70/0x70
[ 5438.657130]  ? lock_is_held_type+0xd8/0x130
[ 5438.657342]  folio_wait_writeback+0x40/0x230
[ 5438.657580]  __filemap_fdatawait_range+0x10a/0x2a0
[ 5438.657828]  ? filemap_fdatawrite+0x170/0x170
[ 5438.658157]  ? lock_is_held_type+0xd8/0x130
[ 5438.658505]  file_write_and_wait_range+0xbc/0xf0
[ 5438.658771]  xfs_file_fsync+0x146/0x830
[ 5438.659083]  ? xfs_dio_write_end_io+0x760/0x760
[ 5438.659527]  ? lock_is_held_type+0xd8/0x130
[ 5438.659851]  nfsd_commit+0x304/0x560 [nfsd]
[ 5438.660339]  ? nfsd_write+0x4f0/0x4f0 [nfsd]
[ 5438.660686]  ? percpu_counter_add_batch+0x77/0x130
[ 5438.661067]  nfsd4_proc_compound+0xd6f/0x26d0 [nfsd]
[ 5438.661360]  nfsd_dispatch+0x4b9/0xba0 [nfsd]
[ 5438.661770]  svc_process_common+0xc14/0x1aa0 [sunrpc]
[ 5438.662440]  ? svc_create_pooled+0x5c0/0x5c0 [sunrpc]
[ 5438.662807]  ? nfsd_svc+0xc70/0xc70 [nfsd]
[ 5438.663154]  ? svc_sock_secure_port+0x2a/0x50 [sunrpc]
[ 5438.663467]  ? svc_recv+0xc6b/0x28c0 [sunrpc]
[ 5438.663908]  svc_process+0x32d/0x4a0 [sunrpc]
[ 5438.664250]  nfsd+0x2d6/0x570 [nfsd]
[ 5438.664453]  ? nfsd_shutdown_threads+0x290/0x290 [nfsd]
[ 5438.664852]  kthread+0x298/0x340
[ 5438.665093]  ? kthread_complete_and_exit+0x20/0x20
[ 5438.665370]  ret_from_fork+0x22/0x30
[ 5438.665695]  </TASK>
[ 5438.665785] 
               Showing all locks held in the system:
[ 5438.666128] 1 lock held by rcu_tasks_kthre/10:
[ 5438.666346]  #0: ffffffff850cd970 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2e/0xd70
[ 5438.667112] 1 lock held by rcu_tasks_rude_/11:
[ 5438.667454]  #0: ffffffff850cd6d0 (rcu_tasks_rude.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2e/0xd70
[ 5438.668212] 1 lock held by rcu_tasks_trace/12:
[ 5438.668583]  #0: ffffffff850cd3d0 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2e/0xd70
[ 5438.669222] 1 lock held by khungtaskd/38:
[ 5438.669413]  #0: ffffffff850ce440 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260
[ 5438.669969] 1 lock held by systemd-journal/2571:
[ 5438.670207]  #0: ffff888016f6e548 (mapping.invalidate_lock#2){++++}-{3:3}, at: filemap_fault+0x336/0x1f60
[ 5438.670770] 3 locks held by kworker/u8:1/24268:
[ 5438.671041]  #0: ffff88800869b138 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x70a/0x12e0
[ 5438.671791]  #1: ffff88801db27dd0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x738/0x12e0
[ 5438.672638]  #2: ffff8880125f80e0 (&type->s_umount_key#48){++++}-{3:3}, at: trylock_super+0x16/0xc0
[ 5438.673237] 2 locks held by kworker/2:0/24284:
[ 5438.673480]  #0: ffff88800d5b9938 ((wq_completion)xfs-sync/vdf){+.+.}-{0:0}, at: process_one_work+0x70a/0x12e0
[ 5438.674077]  #1: ffff888047297dd0 ((work_completion)(&(&log->l_work)->work)){+.+.}-{0:0}, at: process_one_work+0x738/0x12e0

[ 5438.674759] =============================================

[ 5559.392647] INFO: task nfsd:23105 blocked for more than 241 seconds.
[ 5559.394498]       Not tainted 6.0.0-rc3-00008-gbb49f295d682 #3631
[ 5559.399159] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 5559.403011] task:nfsd            state:D stack:24336 pid:23105 ppid:     2 flags:0x00004000
[ 5559.403552] Call Trace:
[ 5559.403655]  <TASK>
[ 5559.403738]  __schedule+0xb73/0x2260
[ 5559.403956]  ? io_schedule_timeout+0x160/0x160
[ 5559.404780]  ? reacquire_held_locks+0x4e0/0x4e0
[ 5559.405026]  ? do_raw_spin_lock+0x11e/0x250
[ 5559.405239]  schedule+0x133/0x230
[ 5559.405393]  io_schedule+0xc3/0x140
[ 5559.405567]  folio_wait_bit_common+0x2e4/0x610
[ 5559.405808]  ? perf_trace_mm_filemap_op_page_cache+0x780/0x780
[ 5559.406126]  ? folio_unlock+0x70/0x70
[ 5559.406299]  ? lock_is_held_type+0xd8/0x130
[ 5559.406512]  folio_wait_writeback+0x40/0x230
[ 5559.406729]  __filemap_fdatawait_range+0x10a/0x2a0
[ 5559.406979]  ? filemap_fdatawrite+0x170/0x170
[ 5559.407199]  ? lock_is_held_type+0xd8/0x130
[ 5559.407424]  file_write_and_wait_range+0xbc/0xf0
[ 5559.407660]  xfs_file_fsync+0x146/0x830
[ 5559.407847]  ? xfs_dio_write_end_io+0x760/0x760
[ 5559.408377]  ? lock_is_held_type+0xd8/0x130
[ 5559.408957]  nfsd_commit+0x304/0x560 [nfsd]
[ 5559.409826]  ? nfsd_write+0x4f0/0x4f0 [nfsd]
[ 5559.410890]  ? percpu_counter_add_batch+0x77/0x130
[ 5559.411417]  nfsd4_proc_compound+0xd6f/0x26d0 [nfsd]
[ 5559.412568]  nfsd_dispatch+0x4b9/0xba0 [nfsd]
[ 5559.413689]  svc_process_common+0xc14/0x1aa0 [sunrpc]
[ 5559.414040]  ? svc_create_pooled+0x5c0/0x5c0 [sunrpc]
[ 5559.414336]  ? nfsd_svc+0xc70/0xc70 [nfsd]
[ 5559.414556]  ? svc_sock_secure_port+0x2a/0x50 [sunrpc]
[ 5559.414856]  ? svc_recv+0xc6b/0x28c0 [sunrpc]
[ 5559.415138]  svc_process+0x32d/0x4a0 [sunrpc]
[ 5559.415395]  nfsd+0x2d6/0x570 [nfsd]
[ 5559.415588]  ? nfsd_shutdown_threads+0x290/0x290 [nfsd]
[ 5559.415881]  kthread+0x298/0x340
[ 5559.416085]  ? kthread_complete_and_exit+0x20/0x20
[ 5559.416645]  ret_from_fork+0x22/0x30
[ 5559.417928]  </TASK>
[ 5559.418011] INFO: task nfsd:23106 blocked for more than 241 seconds.
[ 5559.418355]       Not tainted 6.0.0-rc3-00008-gbb49f295d682 #3631
[ 5559.418684] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 5559.419126] task:nfsd            state:D stack:24448 pid:23106 ppid:     2 flags:0x00004000
[ 5559.419606] Call Trace:
[ 5559.419698]  <TASK>
[ 5559.419774]  __schedule+0xb73/0x2260
[ 5559.419991]  ? io_schedule_timeout+0x160/0x160
[ 5559.420682]  ? sbitmap_get_shallow+0x189/0x5f0
[ 5559.421926]  schedule+0x133/0x230
[ 5559.422088]  io_schedule+0xc3/0x140
[ 5559.422251]  blk_mq_get_tag+0x38c/0xa80
[ 5559.422443]  ? blk_mq_get_tags+0x240/0x240
[ 5559.422643]  ? lock_is_held_type+0xd8/0x130
[ 5559.422854]  ? sched_debug_start+0x180/0x180
[ 5559.423075]  ? __bio_split_to_limits+0x712/0x1080
[ 5559.423322]  __blk_mq_alloc_requests+0x492/0xc50
[ 5559.423568]  ? reacquire_held_locks+0x4e0/0x4e0
[ 5559.423799]  ? blk_mq_timeout_work+0x380/0x380
[ 5559.424081]  blk_mq_submit_bio+0x73c/0x17d0
[ 5559.424704]  ? blk_mq_try_issue_list_directly+0x9a0/0x9a0
[ 5559.425763]  submit_bio_noacct_nocheck+0x5b1/0x820
[ 5559.426942]  ? should_fail_request+0x70/0x70
[ 5559.427220]  ? submit_bio_noacct+0xa50/0x1140
[ 5559.427444]  ? iomap_page_create+0x8b/0x3d0
[ 5559.427655]  iomap_do_writepage+0x1210/0x2450
[ 5559.427889]  ? iomap_write_end+0x9c0/0x9c0
[ 5559.428190]  write_cache_pages+0x3d8/0xed0
[ 5559.428396]  ? iomap_write_end+0x9c0/0x9c0
[ 5559.428603]  ? folio_wait_stable+0xc0/0xc0
[ 5559.428803]  ? lock_is_held_type+0xd8/0x130
[ 5559.429026]  ? do_raw_spin_lock+0x11e/0x250
[ 5559.429239]  iomap_writepages+0x42/0xb0
[ 5559.429425]  xfs_vm_writepages+0x109/0x160
[ 5559.429645]  ? xfs_vm_read_folio+0x20/0x20
[ 5559.430036]  ? nfsd_setuser+0x5fb/0x9c0 [nfsd]
[ 5559.430609]  do_writepages+0x15c/0x590
[ 5559.431891]  ? lock_is_held_type+0xd8/0x130
[ 5559.433503]  ? page_writeback_cpu_online+0x20/0x20
[ 5559.434063]  ? lock_release+0x380/0x760
[ 5559.434264]  ? __lock_acquire+0xc67/0x69f0
[ 5559.434479]  ? lock_is_held_type+0xd8/0x130
[ 5559.434696]  __filemap_fdatawrite_range+0x13e/0x170
[ 5559.434966]  ? rcu_read_lock_sched_held+0x3f/0x70
[ 5559.435207]  ? delete_from_page_cache_batch+0xa30/0xa30
[ 5559.435486]  ? lock_is_held_type+0xd8/0x130
[ 5559.435694]  file_write_and_wait_range+0x8e/0xf0
[ 5559.435963]  xfs_file_fsync+0x146/0x830
[ 5559.436917]  ? xfs_dio_write_end_io+0x760/0x760
[ 5559.438010]  ? lock_is_held_type+0xd8/0x130
[ 5559.438482]  nfsd_commit+0x304/0x560 [nfsd]
[ 5559.438731]  ? nfsd_write+0x4f0/0x4f0 [nfsd]
[ 5559.438989]  ? percpu_counter_add_batch+0x77/0x130
[ 5559.439239]  nfsd4_proc_compound+0xd6f/0x26d0 [nfsd]
[ 5559.439532]  nfsd_dispatch+0x4b9/0xba0 [nfsd]
[ 5559.439778]  svc_process_common+0xc14/0x1aa0 [sunrpc]
[ 5559.440184]  ? svc_create_pooled+0x5c0/0x5c0 [sunrpc]
[ 5559.440491]  ? nfsd_svc+0xc70/0xc70 [nfsd]
[ 5559.440711]  ? svc_sock_secure_port+0x2a/0x50 [sunrpc]
[ 5559.441160]  ? svc_recv+0xc6b/0x28c0 [sunrpc]
[ 5559.441428]  svc_process+0x32d/0x4a0 [sunrpc]
[ 5559.441729]  nfsd+0x2d6/0x570 [nfsd]
[ 5559.441952]  ? nfsd_shutdown_threads+0x290/0x290 [nfsd]
[ 5559.442247]  kthread+0x298/0x340
[ 5559.442392]  ? kthread_complete_and_exit+0x20/0x20
[ 5559.442641]  ret_from_fork+0x22/0x30
[ 5559.442823]  </TASK>
[ 5559.442927] 
               Showing all locks held in the system:
[ 5559.443180] 1 lock held by rcu_tasks_kthre/10:
[ 5559.443402]  #0: ffffffff850cd970 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2e/0xd70
[ 5559.444017] 1 lock held by rcu_tasks_rude_/11:
[ 5559.444332]  #0: ffffffff850cd6d0 (rcu_tasks_rude.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2e/0xd70
[ 5559.444965] 1 lock held by rcu_tasks_trace/12:
[ 5559.445186]  #0: ffffffff850cd3d0 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2e/0xd70
[ 5559.446062] 1 lock held by khungtaskd/38:
[ 5559.446298]  #0: ffffffff850ce440 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260
[ 5559.446875] 2 locks held by kswapd0/74:
[ 5559.447109] 3 locks held by kworker/u8:1/24268:
[ 5559.447347]  #0: ffff88800869b138 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x70a/0x12e0
[ 5559.447940]  #1: ffff88801db27dd0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x738/0x12e0
[ 5559.448672]  #2: ffff8880125f80e0 (&type->s_umount_key#48){++++}-{3:3}, at: trylock_super+0x16/0xc0
[ 5559.449242] 2 locks held by kworker/2:0/24284:
[ 5559.449463]  #0: ffff88800d5b9938 ((wq_completion)xfs-sync/vdf){+.+.}-{0:0}, at: process_one_work+0x70a/0x12e0
[ 5559.450078]  #1: ffff888047297dd0 ((work_completion)(&(&log->l_work)->work)){+.+.}-{0:0}, at: process_one_work+0x738/0x12e0

[ 5559.450768] =============================================

[ 8795.664246] clocksource: timekeeping watchdog on CPU2: acpi_pm wd-wd read-back delay of 70679ns
[ 8795.666604] clocksource: wd-tsc-wd read-back delay of 232431ns, clock-skew test skipped!
[ 8797.644284] clocksource: timekeeping watchdog on CPU2: acpi_pm wd-wd read-back delay of 62857ns
[ 8797.646577] clocksource: wd-tsc-wd read-back delay of 241930ns, clock-skew test skipped!
[21025.695599] clocksource: timekeeping watchdog on CPU2: acpi_pm wd-wd read-back delay of 240533ns
[21025.698830] clocksource: wd-tsc-wd read-back delay of 170692ns, clock-skew test skipped!
[26373.720180] clocksource: timekeeping watchdog on CPU2: acpi_pm wd-wd read-back delay of 50844ns
[26373.722764] clocksource: wd-tsc-wd read-back delay of 119568ns, clock-skew test skipped!
[35820.390214] sysrq: Show Blocked State
[35820.390588] task:nfsd            state:D stack:24336 pid:23105 ppid:     2 flags:0x00004000
[35820.391159] Call Trace:
[35820.391268]  <TASK>
[35820.391352]  __schedule+0xb73/0x2260
[35820.391552]  ? io_schedule_timeout+0x160/0x160
[35820.391801]  ? reacquire_held_locks+0x4e0/0x4e0
[35820.392032]  ? do_raw_spin_lock+0x11e/0x250
[35820.392247]  schedule+0x133/0x230
[35820.392401]  io_schedule+0xc3/0x140
[35820.392563]  folio_wait_bit_common+0x2e4/0x610
[35820.392796]  ? perf_trace_mm_filemap_op_page_cache+0x780/0x780
[35820.393154]  ? folio_unlock+0x70/0x70
[35820.394717]  ? lock_is_held_type+0xd8/0x130
[35820.394940]  folio_wait_writeback+0x40/0x230
[35820.395159]  __filemap_fdatawait_range+0x10a/0x2a0
[35820.395413]  ? filemap_fdatawrite+0x170/0x170
[35820.395634]  ? lock_is_held_type+0xd8/0x130
[35820.395861]  file_write_and_wait_range+0xbc/0xf0
[35820.396099]  xfs_file_fsync+0x146/0x830
[35820.396290]  ? xfs_dio_write_end_io+0x760/0x760
[35820.396521]  ? lock_is_held_type+0xd8/0x130
[35820.396734]  nfsd_commit+0x304/0x560 [nfsd]
[35820.397027]  ? nfsd_write+0x4f0/0x4f0 [nfsd]
[35820.397318]  ? percpu_counter_add_batch+0x77/0x130
[35820.397580]  nfsd4_proc_compound+0xd6f/0x26d0 [nfsd]
[35820.397876]  nfsd_dispatch+0x4b9/0xba0 [nfsd]
[35820.398122]  svc_process_common+0xc14/0x1aa0 [sunrpc]
[35820.398457]  ? svc_create_pooled+0x5c0/0x5c0 [sunrpc]
[35820.398752]  ? nfsd_svc+0xc70/0xc70 [nfsd]
[35820.398971]  ? svc_sock_secure_port+0x2a/0x50 [sunrpc]
[35820.399276]  ? svc_recv+0xc6b/0x28c0 [sunrpc]
[35820.399535]  svc_process+0x32d/0x4a0 [sunrpc]
[35820.399792]  nfsd+0x2d6/0x570 [nfsd]
[35820.399985]  ? nfsd_shutdown_threads+0x290/0x290 [nfsd]
[35820.400282]  kthread+0x298/0x340
[35820.400429]  ? kthread_complete_and_exit+0x20/0x20
[35820.400677]  ret_from_fork+0x22/0x30
[35820.400901]  </TASK>
[35820.400980] task:nfsd            state:D stack:24448 pid:23106 ppid:     2 flags:0x00004000
[35820.401543] Call Trace:
[35820.401637]  <TASK>
[35820.401712]  __schedule+0xb73/0x2260
[35820.401889]  ? io_schedule_timeout+0x160/0x160
[35820.402112]  ? sbitmap_get_shallow+0x189/0x5f0
[35820.402581]  schedule+0x133/0x230
[35820.402738]  io_schedule+0xc3/0x140
[35820.402901]  blk_mq_get_tag+0x38c/0xa80
[35820.403093]  ? blk_mq_get_tags+0x240/0x240
[35820.403319]  ? lock_is_held_type+0xd8/0x130
[35820.403529]  ? sched_debug_start+0x180/0x180
[35820.403744]  ? __bio_split_to_limits+0x712/0x1080
[35820.403989]  __blk_mq_alloc_requests+0x492/0xc50
[35820.404249]  ? reacquire_held_locks+0x4e0/0x4e0
[35820.404489]  ? blk_mq_timeout_work+0x380/0x380
[35820.404721]  blk_mq_submit_bio+0x73c/0x17d0
[35820.404981]  ? blk_mq_try_issue_list_directly+0x9a0/0x9a0
[35820.405409]  submit_bio_noacct_nocheck+0x5b1/0x820
[35820.405663]  ? should_fail_request+0x70/0x70
[35820.405876]  ? submit_bio_noacct+0xa50/0x1140
[35820.406100]  ? iomap_page_create+0x8b/0x3d0
[35820.406357]  iomap_do_writepage+0x1210/0x2450
[35820.406592]  ? iomap_write_end+0x9c0/0x9c0
[35820.406799]  write_cache_pages+0x3d8/0xed0
[35820.407002]  ? iomap_write_end+0x9c0/0x9c0
[35820.407209]  ? folio_wait_stable+0xc0/0xc0
[35820.407412]  ? lock_is_held_type+0xd8/0x130
[35820.407632]  ? do_raw_spin_lock+0x11e/0x250
[35820.407845]  iomap_writepages+0x42/0xb0
[35820.408031]  xfs_vm_writepages+0x109/0x160
[35820.408233]  ? xfs_vm_read_folio+0x20/0x20
[35820.408444]  ? nfsd_setuser+0x5fb/0x9c0 [nfsd]
[35820.408695]  do_writepages+0x15c/0x590
[35820.408924]  ? lock_is_held_type+0xd8/0x130
[35820.409148]  ? page_writeback_cpu_online+0x20/0x20
[35820.409451]  ? lock_release+0x380/0x760
[35820.409640]  ? __lock_acquire+0xc67/0x69f0
[35820.409849]  ? lock_is_held_type+0xd8/0x130
[35820.410060]  __filemap_fdatawrite_range+0x13e/0x170
[35820.410377]  ? rcu_read_lock_sched_held+0x3f/0x70
[35820.410617]  ? delete_from_page_cache_batch+0xa30/0xa30
[35820.410896]  ? lock_is_held_type+0xd8/0x130
[35820.411104]  file_write_and_wait_range+0x8e/0xf0
[35820.411345]  xfs_file_fsync+0x146/0x830
[35820.411531]  ? xfs_dio_write_end_io+0x760/0x760
[35820.411760]  ? lock_is_held_type+0xd8/0x130
[35820.411972]  nfsd_commit+0x304/0x560 [nfsd]
[35820.412206]  ? nfsd_write+0x4f0/0x4f0 [nfsd]
[35820.412447]  ? percpu_counter_add_batch+0x77/0x130
[35820.412696]  nfsd4_proc_compound+0xd6f/0x26d0 [nfsd]
[35820.413035]  nfsd_dispatch+0x4b9/0xba0 [nfsd]
[35820.413349]  svc_process_common+0xc14/0x1aa0 [sunrpc]
[35820.413653]  ? svc_create_pooled+0x5c0/0x5c0 [sunrpc]
[35820.413947]  ? nfsd_svc+0xc70/0xc70 [nfsd]
[35820.414166]  ? svc_sock_secure_port+0x2a/0x50 [sunrpc]
[35820.414489]  ? svc_recv+0xc6b/0x28c0 [sunrpc]
[35820.414747]  svc_process+0x32d/0x4a0 [sunrpc]
[35820.415003]  nfsd+0x2d6/0x570 [nfsd]
[35820.415197]  ? nfsd_shutdown_threads+0x290/0x290 [nfsd]
[35820.415494]  kthread+0x298/0x340
[35820.415639]  ? kthread_complete_and_exit+0x20/0x20
[35820.415887]  ret_from_fork+0x22/0x30
[35820.416070]  </TASK>
[35820.416146] task:nfsd            state:D stack:24608 pid:23107 ppid:     2 flags:0x00004000
[35820.416628] Call Trace:
[35820.416720]  <TASK>
[35820.416795]  __schedule+0xb73/0x2260
[35820.417017]  ? io_schedule_timeout+0x160/0x160
[35820.417303]  ? reacquire_held_locks+0x4e0/0x4e0
[35820.417567]  ? do_raw_spin_lock+0x11e/0x250
[35820.417778]  schedule+0x133/0x230
[35820.417931]  io_schedule+0xc3/0x140
[35820.418093]  folio_wait_bit_common+0x2e4/0x610
[35820.418347]  ? perf_trace_mm_filemap_op_page_cache+0x780/0x780
[35820.418661]  ? folio_unlock+0x70/0x70
[35820.418834]  ? lock_is_held_type+0xd8/0x130
[35820.419047]  folio_wait_writeback+0x40/0x230
[35820.419267]  __filemap_fdatawait_range+0x10a/0x2a0
[35820.419515]  ? filemap_fdatawrite+0x170/0x170
[35820.419735]  ? lock_is_held_type+0xd8/0x130
[35820.419961]  file_write_and_wait_range+0xbc/0xf0
[35820.420198]  xfs_file_fsync+0x146/0x830
[35820.420387]  ? xfs_dio_write_end_io+0x760/0x760
[35820.420616]  ? lock_is_held_type+0xd8/0x130
[35820.420829]  nfsd_commit+0x304/0x560 [nfsd]
[35820.421123]  ? nfsd_write+0x4f0/0x4f0 [nfsd]
[35820.421419]  ? percpu_counter_add_batch+0x77/0x130
[35820.421671]  nfsd4_proc_compound+0xd6f/0x26d0 [nfsd]
[35820.421966]  nfsd_dispatch+0x4b9/0xba0 [nfsd]
[35820.422212]  svc_process_common+0xc14/0x1aa0 [sunrpc]
[35820.422538]  ? svc_create_pooled+0x5c0/0x5c0 [sunrpc]
[35820.422832]  ? nfsd_svc+0xc70/0xc70 [nfsd]
[35820.423051]  ? svc_sock_secure_port+0x2a/0x50 [sunrpc]
[35820.423353]  ? svc_recv+0xc6b/0x28c0 [sunrpc]
[35820.423611]  svc_process+0x32d/0x4a0 [sunrpc]
[35820.423891]  nfsd+0x2d6/0x570 [nfsd]
[35820.424084]  ? nfsd_shutdown_threads+0x290/0x290 [nfsd]
[35820.424400]  kthread+0x298/0x340
[35820.424545]  ? kthread_complete_and_exit+0x20/0x20
[35820.424793]  ret_from_fork+0x22/0x30
[35820.425012]  </TASK>
[35820.425089] task:nfsd            state:D stack:24432 pid:23108 ppid:     2 flags:0x00004000
[35820.425658] Call Trace:
[35820.425753]  <TASK>
[35820.425829]  __schedule+0xb73/0x2260
[35820.426006]  ? io_schedule_timeout+0x160/0x160
[35820.426250]  ? reacquire_held_locks+0x4e0/0x4e0
[35820.426489]  ? do_raw_spin_lock+0x11e/0x250
[35820.426700]  schedule+0x133/0x230
[35820.426853]  io_schedule+0xc3/0x140
[35820.427015]  folio_wait_bit_common+0x2e4/0x610
[35820.427310]  ? perf_trace_mm_filemap_op_page_cache+0x780/0x780
[35820.427705]  ? folio_unlock+0x70/0x70
[35820.427879]  ? lock_is_held_type+0xd8/0x130
[35820.428092]  folio_wait_writeback+0x40/0x230
[35820.428335]  __filemap_fdatawait_range+0x10a/0x2a0
[35820.428584]  ? filemap_fdatawrite+0x170/0x170
[35820.428803]  ? lock_is_held_type+0xd8/0x130
[35820.429075]  file_write_and_wait_range+0xbc/0xf0
[35820.429393]  xfs_file_fsync+0x146/0x830
[35820.429582]  ? xfs_dio_write_end_io+0x760/0x760
[35820.429811]  ? lock_is_held_type+0xd8/0x130
[35820.430023]  nfsd_commit+0x304/0x560 [nfsd]
[35820.430300]  ? nfsd_write+0x4f0/0x4f0 [nfsd]
[35820.430538]  ? percpu_counter_add_batch+0x77/0x130
[35820.430787]  nfsd4_proc_compound+0xd6f/0x26d0 [nfsd]
[35820.431080]  nfsd_dispatch+0x4b9/0xba0 [nfsd]
[35820.431345]  svc_process_common+0xc14/0x1aa0 [sunrpc]
[35820.431647]  ? svc_create_pooled+0x5c0/0x5c0 [sunrpc]
[35820.431941]  ? nfsd_svc+0xc70/0xc70 [nfsd]
[35820.432160]  ? svc_sock_secure_port+0x2a/0x50 [sunrpc]
[35820.432463]  ? svc_recv+0xc6b/0x28c0 [sunrpc]
[35820.432721]  svc_process+0x32d/0x4a0 [sunrpc]
[35820.433025]  nfsd+0x2d6/0x570 [nfsd]
[35820.433254]  ? nfsd_shutdown_threads+0x290/0x290 [nfsd]
[35820.433582]  kthread+0x298/0x340
[35820.433727]  ? kthread_complete_and_exit+0x20/0x20
[35820.433975]  ret_from_fork+0x22/0x30
[35820.434158]  </TASK>
[35820.434248] task:nfsd            state:D stack:24000 pid:23109 ppid:     2 flags:0x00004000
[35820.434735] Call Trace:
[35820.434826]  <TASK>
[35820.434901]  __schedule+0xb73/0x2260
[35820.435077]  ? io_schedule_timeout+0x160/0x160
[35820.435343]  ? reacquire_held_locks+0x4e0/0x4e0
[35820.435573]  ? do_raw_spin_lock+0x11e/0x250
[35820.435784]  schedule+0x133/0x230
[35820.435937]  io_schedule+0xc3/0x140
[35820.436099]  folio_wait_bit_common+0x2e4/0x610
[35820.436334]  ? perf_trace_mm_filemap_op_page_cache+0x780/0x780
[35820.436649]  ? folio_unlock+0x70/0x70
[35820.436821]  ? lock_is_held_type+0xd8/0x130
[35820.437074]  folio_wait_writeback+0x40/0x230
[35820.437373]  __filemap_fdatawait_range+0x10a/0x2a0
[35820.437630]  ? filemap_fdatawrite+0x170/0x170
[35820.437856]  ? lock_is_held_type+0xd8/0x130
[35820.438088]  file_write_and_wait_range+0xbc/0xf0
[35820.438341]  xfs_file_fsync+0x146/0x830
[35820.438527]  ? xfs_dio_write_end_io+0x760/0x760
[35820.438757]  ? lock_is_held_type+0xd8/0x130
[35820.438968]  nfsd_commit+0x304/0x560 [nfsd]
[35820.439202]  ? nfsd_write+0x4f0/0x4f0 [nfsd]
[35820.439443]  ? percpu_counter_add_batch+0x77/0x130
[35820.439692]  nfsd4_proc_compound+0xd6f/0x26d0 [nfsd]
[35820.439985]  nfsd_dispatch+0x4b9/0xba0 [nfsd]
[35820.440267]  svc_process_common+0xc14/0x1aa0 [sunrpc]
[35820.440569]  ? svc_create_pooled+0x5c0/0x5c0 [sunrpc]
[35820.440899]  ? nfsd_svc+0xc70/0xc70 [nfsd]
[35820.441140]  ? svc_sock_secure_port+0x2a/0x50 [sunrpc]
[35820.441497]  ? svc_recv+0xc6b/0x28c0 [sunrpc]
[35820.441757]  svc_process+0x32d/0x4a0 [sunrpc]
[35820.442015]  nfsd+0x2d6/0x570 [nfsd]
[35820.442209]  ? nfsd_shutdown_threads+0x290/0x290 [nfsd]
[35820.442527]  kthread+0x298/0x340
[35820.442672]  ? kthread_complete_and_exit+0x20/0x20
[35820.443203]  ret_from_fork+0x22/0x30
[35820.443430]  </TASK>
[35820.443510] task:nfsd            state:D stack:23952 pid:23110 ppid:     2 flags:0x00004000
[35820.444272] Call Trace:
[35820.444376]  <TASK>
[35820.444455]  __schedule+0xb73/0x2260
[35820.444641]  ? io_schedule_timeout+0x160/0x160
[35820.444895]  ? reacquire_held_locks+0x4e0/0x4e0
[35820.445395]  ? do_raw_spin_lock+0x11e/0x250
[35820.445620]  schedule+0x133/0x230
[35820.445782]  io_schedule+0xc3/0x140
[35820.445952]  folio_wait_bit_common+0x2e4/0x610
[35820.446421]  ? perf_trace_mm_filemap_op_page_cache+0x780/0x780
[35820.446767]  ? folio_unlock+0x70/0x70
[35820.446965]  ? lock_is_held_type+0xd8/0x130
[35820.447190]  folio_wait_writeback+0x40/0x230
[35820.447426]  __filemap_fdatawait_range+0x10a/0x2a0
[35820.447688]  ? filemap_fdatawrite+0x170/0x170
[35820.448152]  ? lock_is_held_type+0xd8/0x130
[35820.448416]  file_write_and_wait_range+0xbc/0xf0
[35820.448660]  xfs_file_fsync+0x146/0x830
[35820.448879]  ? xfs_dio_write_end_io+0x760/0x760
[35820.449142]  ? lock_is_held_type+0xd8/0x130
[35820.449422]  nfsd_commit+0x304/0x560 [nfsd]
[35820.450015]  ? nfsd_write+0x4f0/0x4f0 [nfsd]
[35820.450416]  ? percpu_counter_add_batch+0x77/0x130
[35820.450893]  nfsd4_proc_compound+0xd6f/0x26d0 [nfsd]
[35820.451261]  nfsd_dispatch+0x4b9/0xba0 [nfsd]
[35820.451518]  svc_process_common+0xc14/0x1aa0 [sunrpc]
[35820.451826]  ? svc_create_pooled+0x5c0/0x5c0 [sunrpc]
[35820.452121]  ? nfsd_svc+0xc70/0xc70 [nfsd]
[35820.452367]  ? svc_sock_secure_port+0x2a/0x50 [sunrpc]
[35820.452667]  ? svc_recv+0xc6b/0x28c0 [sunrpc]
[35820.452963]  svc_process+0x32d/0x4a0 [sunrpc]
[35820.453248]  nfsd+0x2d6/0x570 [nfsd]
[35820.453504]  ? nfsd_shutdown_threads+0x290/0x290 [nfsd]
[35820.453798]  kthread+0x298/0x340
[35820.453943]  ? kthread_complete_and_exit+0x20/0x20
[35820.454191]  ret_from_fork+0x22/0x30
[35820.454398]  </TASK>
[35820.454475] task:nfsd            state:D stack:23808 pid:23111 ppid:     2 flags:0x00004000
[35820.454952] Call Trace:
[35820.455043]  <TASK>
[35820.455118]  __schedule+0xb73/0x2260
[35820.455297]  ? io_schedule_timeout+0x160/0x160
[35820.455520]  ? reacquire_held_locks+0x4e0/0x4e0
[35820.455749]  ? do_raw_spin_lock+0x11e/0x250
[35820.455959]  schedule+0x133/0x230
[35820.456112]  io_schedule+0xc3/0x140
[35820.456277]  folio_wait_bit_common+0x2e4/0x610
[35820.456508]  ? perf_trace_mm_filemap_op_page_cache+0x780/0x780
[35820.456823]  ? folio_unlock+0x70/0x70
[35820.457036]  ? lock_is_held_type+0xd8/0x130
[35820.457338]  folio_wait_writeback+0x40/0x230
[35820.457565]  __filemap_fdatawait_range+0x10a/0x2a0
[35820.457814]  ? filemap_fdatawrite+0x170/0x170
[35820.458033]  ? lock_is_held_type+0xd8/0x130
[35820.458284]  file_write_and_wait_range+0xbc/0xf0
[35820.458522]  xfs_file_fsync+0x146/0x830
[35820.458708]  ? xfs_dio_write_end_io+0x760/0x760
[35820.458938]  ? lock_is_held_type+0xd8/0x130
[35820.459150]  nfsd_commit+0x304/0x560 [nfsd]
[35820.459387]  ? nfsd_write+0x4f0/0x4f0 [nfsd]
[35820.459624]  ? percpu_counter_add_batch+0x77/0x130
[35820.459872]  nfsd4_proc_compound+0xd6f/0x26d0 [nfsd]
[35820.460166]  nfsd_dispatch+0x4b9/0xba0 [nfsd]
[35820.460415]  svc_process_common+0xc14/0x1aa0 [sunrpc]
[35820.460718]  ? svc_create_pooled+0x5c0/0x5c0 [sunrpc]
[35820.461054]  ? nfsd_svc+0xc70/0xc70 [nfsd]
[35820.461391]  ? svc_sock_secure_port+0x2a/0x50 [sunrpc]
[35820.461696]  ? svc_recv+0xc6b/0x28c0 [sunrpc]
[35820.461955]  svc_process+0x32d/0x4a0 [sunrpc]
[35820.462214]  nfsd+0x2d6/0x570 [nfsd]
[35820.462434]  ? nfsd_shutdown_threads+0x290/0x290 [nfsd]
[35820.462727]  kthread+0x298/0x340
[35820.462872]  ? kthread_complete_and_exit+0x20/0x20
[35820.463120]  ret_from_fork+0x22/0x30
[35820.463306]  </TASK>
[35820.463382] task:nfsd            state:D stack:21968 pid:23112 ppid:     2 flags:0x00004000
[35820.463860] Call Trace:
[35820.463951]  <TASK>
[35820.464026]  __schedule+0xb73/0x2260
[35820.464202]  ? io_schedule_timeout+0x160/0x160
[35820.464429]  ? reacquire_held_locks+0x4e0/0x4e0
[35820.464658]  ? do_raw_spin_lock+0x11e/0x250
[35820.464909]  schedule+0x133/0x230
[35820.465064]  io_schedule+0xc3/0x140
[35820.465370]  folio_wait_bit_common+0x2e4/0x610
[35820.465604]  ? perf_trace_mm_filemap_op_page_cache+0x780/0x780
[35820.465919]  ? folio_unlock+0x70/0x70
[35820.466093]  ? lock_is_held_type+0xd8/0x130
[35820.466330]  folio_wait_writeback+0x40/0x230
[35820.466548]  __filemap_fdatawait_range+0x10a/0x2a0
[35820.466796]  ? filemap_fdatawrite+0x170/0x170
[35820.467015]  ? lock_is_held_type+0xd8/0x130
[35820.467246]  file_write_and_wait_range+0xbc/0xf0
[35820.467483]  xfs_file_fsync+0x146/0x830
[35820.467669]  ? xfs_dio_write_end_io+0x760/0x760
[35820.467899]  ? lock_is_held_type+0xd8/0x130
[35820.468110]  nfsd_commit+0x304/0x560 [nfsd]
[35820.468347]  ? nfsd_write+0x4f0/0x4f0 [nfsd]
[35820.468584]  ? percpu_counter_add_batch+0x77/0x130
[35820.468854]  nfsd4_proc_compound+0xd6f/0x26d0 [nfsd]
[35820.469196]  nfsd_dispatch+0x4b9/0xba0 [nfsd]
[35820.469540]  svc_process_common+0xc14/0x1aa0 [sunrpc]
[35820.469845]  ? svc_create_pooled+0x5c0/0x5c0 [sunrpc]
[35820.470140]  ? nfsd_svc+0xc70/0xc70 [nfsd]
[35820.470404]  ? svc_sock_secure_port+0x2a/0x50 [sunrpc]
[35820.470703]  ? svc_recv+0xc6b/0x28c0 [sunrpc]
[35820.470962]  svc_process+0x32d/0x4a0 [sunrpc]
[35820.471223]  nfsd+0x2d6/0x570 [nfsd]
[35820.471417]  ? nfsd_shutdown_threads+0x290/0x290 [nfsd]
[35820.471710]  kthread+0x298/0x340
[35820.471856]  ? kthread_complete_and_exit+0x20/0x20
[35820.472104]  ret_from_fork+0x22/0x30
[35820.472291]  </TASK>
[35820.472368] task:kworker/u8:1    state:D stack:25008 pid:24268 ppid:     2 flags:0x00004000
[35820.472877] Workqueue: writeback wb_workfn (flush-253:80)
[35820.473197] Call Trace:
[35820.473357]  <TASK>
[35820.473435]  __schedule+0xb73/0x2260
[35820.473612]  ? io_schedule_timeout+0x160/0x160
[35820.473838]  ? blk_start_plug_nr_ios+0x280/0x280
[35820.474078]  schedule+0x133/0x230
[35820.474364]  io_schedule+0xc3/0x140
[35820.474551]  folio_wait_bit_common+0x2e4/0x610
[35820.474790]  ? perf_trace_mm_filemap_op_page_cache+0x780/0x780
[35820.475114]  ? folio_unlock+0x70/0x70
[35820.475305]  write_cache_pages+0x71c/0xed0
[35820.475515]  ? iomap_write_end+0x9c0/0x9c0
[35820.475736]  ? folio_wait_stable+0xc0/0xc0
[35820.475938]  ? lock_is_held_type+0xd8/0x130
[35820.476157]  ? do_raw_spin_lock+0x11e/0x250
[35820.476393]  iomap_writepages+0x42/0xb0
[35820.476579]  xfs_vm_writepages+0x109/0x160
[35820.476779]  ? xfs_vm_read_folio+0x20/0x20
[35820.477040]  do_writepages+0x15c/0x590
[35820.477329]  ? page_writeback_cpu_online+0x20/0x20
[35820.477583]  ? reacquire_held_locks+0x201/0x4e0
[35820.477817]  ? writeback_sb_inodes+0x2dc/0xf90
[35820.478049]  ? lock_is_held_type+0xd8/0x130
[35820.478288]  ? find_held_lock+0x2d/0x110
[35820.478487]  ? lock_is_held_type+0xd8/0x130
[35820.478713]  __writeback_single_inode+0xd9/0xbb0
[35820.478954]  writeback_sb_inodes+0x4b1/0xf90
[35820.479183]  ? sync_inode_metadata+0x90/0x90
[35820.479418]  ? down_read_trylock+0x1b0/0x360
[35820.479629]  ? trylock_super+0x16/0xc0
[35820.479820]  __writeback_inodes_wb+0xb4/0x200
[35820.480046]  wb_writeback+0x4e9/0x870
[35820.480240]  ? __writeback_inodes_wb+0x200/0x200
[35820.480490]  ? get_nr_dirty_inodes+0x18/0x1b0
[35820.480708]  ? lockdep_hardirqs_on_prepare+0x17b/0x410
[35820.481014]  ? _raw_spin_unlock_irq+0x24/0x50
[35820.481378]  wb_workfn+0x782/0xc60
[35820.481552]  ? inode_wait_for_writeback+0x30/0x30
[35820.481798]  ? lock_acquire+0x1b1/0x520
[35820.481986]  ? lock_acquire+0x1c1/0x520
[35820.482176]  ? lock_downgrade+0x6a0/0x6a0
[35820.482415]  ? lock_is_held_type+0xd8/0x130
[35820.482629]  process_one_work+0x7f2/0x12e0
[35820.482836]  ? lock_downgrade+0x6a0/0x6a0
[35820.483030]  ? pwq_dec_nr_in_flight+0x230/0x230
[35820.483289]  ? rwlock_bug.part.0+0x90/0x90
[35820.483495]  worker_thread+0xfc/0x1270
[35820.483683]  ? __kthread_parkme+0xc1/0x1f0
[35820.483886]  ? process_one_work+0x12e0/0x12e0
[35820.484104]  kthread+0x298/0x340
[35820.484252]  ? kthread_complete_and_exit+0x20/0x20
[35820.484501]  ret_from_fork+0x22/0x30
[35820.484684]  </TASK>
[35820.484760] task:kworker/2:0     state:D stack:26528 pid:24284 ppid:     2 flags:0x00004000
[35820.485363] Workqueue: xfs-sync/vdf xfs_log_worker
[35820.485611] Call Trace:
[35820.485703]  <TASK>
[35820.485778]  __schedule+0xb73/0x2260
[35820.485954]  ? io_schedule_timeout+0x160/0x160
[35820.486180]  ? _raw_spin_unlock_irq+0x24/0x50
[35820.486425]  schedule+0x133/0x230
[35820.486579]  io_schedule+0xc3/0x140
[35820.486741]  blk_mq_get_tag+0x38c/0xa80
[35820.486932]  ? blk_mq_get_tags+0x240/0x240
[35820.487134]  ? sched_debug_start+0x180/0x180
[35820.487359]  __blk_mq_alloc_requests+0x492/0xc50
[35820.487605]  ? reacquire_held_locks+0x4e0/0x4e0
[35820.487832]  ? lockdep_hardirqs_on_prepare+0x410/0x410
[35820.488098]  ? blk_mq_timeout_work+0x380/0x380
[35820.488332]  blk_mq_submit_bio+0x73c/0x17d0
[35820.488546]  ? blk_mq_try_issue_list_directly+0x9a0/0x9a0
[35820.488829]  ? find_held_lock+0x2d/0x110
[35820.489071]  submit_bio_noacct_nocheck+0x5b1/0x820
[35820.489411]  ? should_fail_request+0x70/0x70
[35820.489625]  ? submit_bio_noacct+0xa50/0x1140
[35820.489854]  xlog_state_release_iclog+0x39e/0x770
[35820.490092]  ? xlog_state_switch_iclogs+0x43e/0x630
[35820.490371]  xfs_log_force+0x522/0xb30
[35820.490554]  xfs_log_worker+0x86/0x2b0
[35820.490735]  process_one_work+0x7f2/0x12e0
[35820.490941]  ? lock_downgrade+0x6a0/0x6a0
[35820.491145]  ? pwq_dec_nr_in_flight+0x230/0x230
[35820.491429]  ? rwlock_bug.part.0+0x90/0x90
[35820.491636]  worker_thread+0xfc/0x1270
[35820.491824]  ? __kthread_parkme+0xc1/0x1f0
[35820.492027]  ? process_one_work+0x12e0/0x12e0
[35820.492249]  kthread+0x298/0x340
[35820.492394]  ? kthread_complete_and_exit+0x20/0x20
[35820.492642]  ret_from_fork+0x22/0x30
[35820.492824]  </TASK>

