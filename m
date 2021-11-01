Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87429442164
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Nov 2021 21:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhKAUJI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Nov 2021 16:09:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47490 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231836AbhKAUJE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Nov 2021 16:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635797188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5hS14JrMIxDRXl/y61m81MFkK3srQhCTN7so6aJXY/M=;
        b=HEnM8+iBSuCyjJ2uLRKynRrITnEkD0DjMmuxZCAFkt1jLZQzfPgEXfT8/T9toTpCUxHdU5
        OVoB8E4sg0YZtuBuobqw/++iqOEXdLKsoKxfK304ExYW6kdIo71sofa9tGrqDzfTXKcO6R
        IlKxHzbAiwb9Qu2cXEWlf7bMv4UPz2M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-GJU94SDuPeqIoQwm1eH4GQ-1; Mon, 01 Nov 2021 16:06:26 -0400
X-MC-Unique: GJU94SDuPeqIoQwm1eH4GQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04B4E5074E;
        Mon,  1 Nov 2021 20:06:25 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.9.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A97805C1CF;
        Mon,  1 Nov 2021 20:06:24 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 82FD71A0024; Mon,  1 Nov 2021 16:06:23 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/1] Fix nfs4_slot use-after-free by FREE_STATEID
Date:   Mon,  1 Nov 2021 16:06:22 -0400
Message-Id: <20211101200623.2635785-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

My attempts at reproducing the nfsd soft-lockups during callback
processing have been hampered by frequent client panics while testing.

My reproducer is as follows:
1. Use netem to add some latency to the connection (without this, the
panics do not occur):
# tc qdisc add dev tun0 root netem delay 14ms
2. Run nfstest_delegation:
# ./nfstest_delegation --server smayhew-rhel8 --export /export/xfs/smayhew/nfstest --nfsversion 4.2 --sec=krb5 --nconnect 16

The client will typically panic before completing the test run.

This is from a vmcore without SLUB debugging enabled:

crash> bt
PID: 1623   TASK: ffff93fb40294a40  CPU: 0   COMMAND: "kworker/u4:2"
 #0 [ffffa39f80003d68] machine_kexec at ffffffffac45f898
 #1 [ffffa39f80003db8] __crash_kexec at ffffffffac59d02d
 #2 [ffffa39f80003e80] panic at ffffffffacddb718
 #3 [ffffa39f80003f00] watchdog_timer_fn.cold at ffffffffacde5645
 #4 [ffffa39f80003f28] __hrtimer_run_queues at ffffffffac57a53a
 #5 [ffffa39f80003f88] hrtimer_interrupt at ffffffffac57b1ec
 #6 [ffffa39f80003fd8] __sysvec_apic_timer_interrupt at ffffffffac45687c
 #7 [ffffa39f80003ff0] sysvec_apic_timer_interrupt at fffffffface24b7d
--- <IRQ stack> ---
 #8 [ffffa39f80663cb8] sysvec_apic_timer_interrupt at fffffffface24b7d
    [exception RIP: unknown or invalid address]
    RIP: ffff93fb46a0a974  RSP: ffff93fa46924540  RFLAGS: 00001000
    RAX: ffff93fb41cf5600  RBX: 0000000000000000  RCX: ffff93fb424c0cd0
    RDX: ffff93fb424c0cd8  RSI: ffffffffc0e3cde0  RDI: 00000000000001aa
    RBP: fffffffface24b1b   R8: ffff93fa46924540   R9: 0000000000000000
    R10: ffffffffad000cc2  R11: 0000000000000000  R12: fffffffface23394
    R13: 0000000000000000  R14: ffff93fb401c8200  R15: ffff93fb40067730
    ORIG_RAX: 0000000000000007  CS: a58cc9ea96350  SS: 0001
WARNING: possibly bogus exception frame
 #9 [ffffa39f80663d78] native_queued_spin_lock_slowpath at ffffffffac54664d
#10 [ffffa39f80663da0] _raw_spin_lock at fffffffface329da
#11 [ffffa39f80663da8] rpc_wake_up_first_on_wq at ffffffffc0467341 [sunrpc]
#12 [ffffa39f80663dd8] nfs41_wake_and_assign_slot at ffffffffc0e3d559 [nfsv4]
#13 [ffffa39f80663de0] nfs41_release_slot at ffffffffc0e13f77 [nfsv4]
#14 [ffffa39f80663e18] nfs41_free_stateid_done at ffffffffc0e1c018 [nfsv4]
#15 [ffffa39f80663e30] rpc_exit_task at ffffffffc045d3b8 [sunrpc]
#16 [ffffa39f80663e40] __rpc_execute at ffffffffc046708e [sunrpc]
#17 [ffffa39f80663e70] rpc_async_schedule at ffffffffc04672a9 [sunrpc]
#18 [ffffa39f80663e88] process_one_work at ffffffffac4fee8b
#19 [ffffa39f80663ed0] worker_thread at ffffffffac4ff083
#20 [ffffa39f80663f10] kthread at ffffffffac505dcf
#21 [ffffa39f80663f50] ret_from_fork at ffffffffac4034f2

Find the rpc_task so we can find the nfs4_slot:

crash> rpc_task.tk_calldata ffff93fb51899e00
  tk_calldata = 0xffff93fa472b24e0
crash> nfs_free_stateid_data.res 0xffff93fa472b24e0
  res = {
    seq_res = {
      sr_slot = 0xffff93fa46924540, 
      sr_timestamp = 0x10017679e, 
      sr_status = 0x1, 
      sr_status_flags = 0x0, 
      sr_highest_slotid = 0x41991000, 
      sr_target_highest_slotid = 0xffff93fa
    }, 
    status = 0x42de63c0
  }

Note the slab has been corrupted ("invalid freepionter" message):

crash> kmem 0xffff93fa46924540
CACHE             OBJSIZE  ALLOCATED     TOTAL  SLABS  SSIZE  NAME
ffff93fb40042500       64      13992     14848    232     4k  kmalloc-64
  SLAB              MEMORY            NODE  TOTAL  ALLOCATED  FREE
  fffff4adc01a4900  ffff93fa46924000     0     64         24    40
  FREE / [ALLOCATED]
kmem: kmalloc-64: slab: fffff4adc01a4900 invalid freepointer: 7a1b527446924a20

      PAGE       PHYSICAL      MAPPING       INDEX CNT FLAGS
fffff4adc01a4900  6924000 ffff93fb40042500 ffff93fa46924a40  1 fffffc0000200 slab


This is from a vmcore captured with "slub_debug=PU,kmalloc-64":

crash> bt
PID: 8      TASK: ffff8b7d80233180  CPU: 0   COMMAND: "kworker/u4:0"
 #0 [ffffa7208004bac0] machine_kexec at ffffffffac05f898
 #1 [ffffa7208004bb10] __crash_kexec at ffffffffac19d02d
 #2 [ffffa7208004bbd8] crash_kexec at ffffffffac19e234
 #3 [ffffa7208004bbe0] oops_end at ffffffffac022b47
 #4 [ffffa7208004bc00] exc_general_protection at ffffffffaca22d09
 #5 [ffffa7208004bca0] asm_exc_general_protection at ffffffffacc00a0e
    [exception RIP: nfs4_xdr_dec_free_stateid+0x54]
    RIP: ffffffffc0e93fb4  RSP: ffffa7208004bd50  RFLAGS: 00010282
    RAX: 6b6b6b6b6b6b6b6b  RBX: ffff8b7d8551cc90  RCX: 0000000000000000
    RDX: 0000000000000000  RSI: ffff8b7d89a99f18  RDI: ffff8b7d89a99ef0
    RBP: ffffa7208004bdd8   R8: 0000000000000000   R9: ffff8b7c84e5e900
    R10: ffff8b7c82bb8e20  R11: ffff8b7d8994d240  R12: 0000000000000000
    R13: ffff8b7d8551c300  R14: ffffa7208004bdd8  R15: ffff8b7cb2ea5a80
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #6 [ffffa7208004bd98] gss_unwrap_resp at ffffffffc0640965 [auth_rpcgss]
 #7 [ffffa7208004bdd0] call_decode at ffffffffc04c4336 [sunrpc]
 #8 [ffffa7208004be40] __rpc_execute at ffffffffc04dd08e [sunrpc]
 #9 [ffffa7208004be70] rpc_async_schedule at ffffffffc04dd2a9 [sunrpc]
#10 [ffffa7208004be88] process_one_work at ffffffffac0fee8b
#11 [ffffa7208004bed0] worker_thread at ffffffffac0ff083
#12 [ffffa7208004bf10] kthread at ffffffffac105dcf
#13 [ffffa7208004bf50] ret_from_fork at ffffffffac0034f2
crash> rpc_task.tk_calldata ffff8b7d813c1800
  tk_calldata = 0xffff8b7d8551cc60
crash> nfs_free_stateid_data.res 0xffff8b7d8551cc60
  res = {
    seq_res = {
      sr_slot = 0xffff8b7d89994d80, 
      sr_timestamp = 0xffff6ac6, 
      sr_status = 0x1, 
      sr_status_flags = 0x0, 
      sr_highest_slotid = 0x81986c00, 
      sr_target_highest_slotid = 0xffff8b7d
    }, 
    status = 0x8551c120
  }

Note the slot has been overwritten with POISON_FREE:

crash> nfs4_slot 0xffff8b7d89994d80
struct nfs4_slot {
  table = 0x6b6b6b6b6b6b6b6b, 
  next = 0x6b6b6b6b6b6b6b6b, 
  generation = 0x6b6b6b6b6b6b6b6b, 
  slot_nr = 0x6b6b6b6b, 
  seq_nr = 0x6b6b6b6b, 
  seq_nr_last_acked = 0x6b6b6b6b, 
  seq_nr_highest_sent = 0x6b6b6b6b, 
  privileged = 0x1, 
  seq_done = 0x1
}

Let's find the tracking info for who last freed the object:

crash> kmem 0xffff8b7d89994d80
CACHE             OBJSIZE  ALLOCATED     TOTAL  SLABS  SSIZE  NAME
ffff8b7d80042500       64      12444     12600    600     8k  kmalloc-64
  SLAB              MEMORY            NODE  TOTAL  ALLOCATED  FREE
  ffffceb8c4266500  ffff8b7d89994000     0     21         18     3
  FREE / [ALLOCATED]
   ffff8b7d89994d80  

      PAGE       PHYSICAL      MAPPING       INDEX CNT FLAGS
ffffceb8c4266500 109994000 ffff8b7d80042500 ffff8b7d89994c00  1 17ffffc0010200 slab,head

(See freepointer_outside_object() in mm/slub.c)
crash> struct kmem_cache.offset,inuse ffff8b7d80042500
  offset = 0x40
  inuse = 0x40

(object + s->inuse + sizeof(void *) + sizeof(struct track))
crash> px 0xffff8b7d89994d80+0x40+0x8+0x98
$5 = 0xffff8b7d89994e60
crash> struct track 0xffff8b7d89994e60
struct track {
  addr = 0xffffffffc0eadb6f, 
  addrs = {0xffffffffac3250b1, 0xffffffffc0eadb6f, 0xffffffffc0eabb94, 0xffffffffc0eabfc4, 0xffffffffc0e137e4, 0xffffffffc0e1f62d, 0xffffffffac35f776, 0xffffffffac384081, 0xffffffffac10320f, 0xffffffffac173c92, 0xffffffffac173d29, 0xffffffffaca25822, 0xffffffffaca222f8, 0xffffffffacc0007c, 0x0, 0xffffffffacc0007c}, 
  cpu = 0x0, 
  pid = 0x69e, 
  when = 0xffff6b23
}

crash> kmem 0xffffffffc0eadb6f
ffffffffc0eadb6f (T) nfs4_destroy_session+0x7f [nfsv4] /export/xfs/smayhew/linux/fs/nfs/nfs4session.c: 583

   VMAP_AREA         VM_STRUCT                 ADDRESS RANGE                SIZE
ffff8b7d8995a380  ffff8b7d83cf5500  ffffffffc0e7e000 - ffffffffc0f64000   942080

      PAGE       PHYSICAL      MAPPING       INDEX CNT FLAGS
ffffceb8c0ca7a80 329ea000                0        0  1 fffffc0000000
crash> bt 0x69e
PID: 1694   TASK: ffff8b7d88f4b180  CPU: 0   COMMAND: "umount.nfs4"
 #0 [ffffa72080657be0] __schedule at ffffffffaca2d730
 #1 [ffffa72080657c58] schedule at ffffffffaca2dab4
 #2 [ffffa72080657c70] rpc_wait_bit_killable at ffffffffc04d2fde [sunrpc]
 #3 [ffffa72080657c88] __wait_on_bit at ffffffffaca2deea
 #4 [ffffa72080657cc0] out_of_line_wait_on_bit at ffffffffaca2dfe2
 #5 [ffffa72080657d10] __rpc_execute at ffffffffc04dd0f2 [sunrpc]
 #6 [ffffa72080657d40] rpc_execute at ffffffffc04dd50f [sunrpc]
 #7 [ffffa72080657d60] rpc_run_task at ffffffffc04c47f6 [sunrpc]
 #8 [ffffa72080657da0] rpc_call_sync at ffffffffc04c4f01 [sunrpc]
 #9 [ffffa72080657e00] nfs4_destroy_clientid at ffffffffc0e8febf [nfsv4]
#10 [ffffa72080657e50] nfs4_free_client at ffffffffc0eabfc4 [nfsv4]
#11 [ffffa72080657e60] nfs_free_server at ffffffffc0e137e4 [nfs]
#12 [ffffa72080657e70] nfs_kill_super at ffffffffc0e1f62d [nfs]
#13 [ffffa72080657e90] deactivate_locked_super at ffffffffac35f776
#14 [ffffa72080657ea8] cleanup_mnt at ffffffffac384081
#15 [ffffa72080657ed0] task_work_run at ffffffffac10320f
#16 [ffffa72080657ef0] exit_to_user_mode_loop at ffffffffac173c92
#17 [ffffa72080657f10] exit_to_user_mode_prepare at ffffffffac173d29
#18 [ffffa72080657f28] syscall_exit_to_user_mode at ffffffffaca25822
#19 [ffffa72080657f38] do_syscall_64 at ffffffffaca222f8
#20 [ffffa72080657f50] entry_SYSCALL_64_after_hwframe at ffffffffacc0007c
    RIP: 00007f64910ef74b  RSP: 00007ffcc98b9088  RFLAGS: 00000202
    RAX: 0000000000000000  RBX: 000055801513abe0  RCX: 00007f64910ef74b
    RDX: 0000000000000000  RSI: 0000000000000001  RDI: 0000558015139640
    RBP: 00005580151382c0   R8: 0000000000000001   R9: 0000000000000000
    R10: 000055801513aad0  R11: 0000000000000202  R12: 0000000000000001
    R13: 0000558015139640  R14: 00005580151383d0  R15: 0000558015138410
    ORIG_RAX: 00000000000000a6  CS: 0033  SS: 002b

So... the application ran 'umount -f' which called

nfs_kill_super  
  nfs_free_server
    nfs_put_client
      nfs4_free_client
        nfs4_shutdown_client
          nfs41_shutdown_client
            nfs4_destroy_session
              nfs4_destroy_session_slot_tables
                nfs4_shutdown_slot_table
                  nfs4_release_slot_table
                    nfs4_shrink_slot_table <--- all slots freed
        nfs_free_client
          rpc_shutdown_client
            rpc_killall_tasks <--- tasks will call rpc_exit_task which will call rpc_call_done.  For v4.1+ this will call nfs41_sequence_done which will call nfs41_sequence_process and nfs41_sequence_free_slot.

Scott Mayhew (1):
  nfs4: take a reference on the nfs_client when running FREE_STATEID

 fs/nfs/nfs4proc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

-- 
2.31.1

