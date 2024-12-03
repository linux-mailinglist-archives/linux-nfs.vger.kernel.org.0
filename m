Return-Path: <linux-nfs+bounces-8314-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C509E113F
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 03:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 281982808FC
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 02:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BA238DDB;
	Tue,  3 Dec 2024 02:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVakdDqy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61108460
	for <linux-nfs@vger.kernel.org>; Tue,  3 Dec 2024 02:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733192996; cv=none; b=FlZOLevlgCAJt1PVE/3WYYQipjXnEmIpS+PM2A+cQV8fejc+wc1yiV2HCqszXsSC4hrLr5Xtq7tgiOCOIVIaSBK2C28ps9jG3EAinTSzngJrHaZXvl1d9oF1lIopobYMJQB5I4aHiCfNe8YFDW6dHMqECtQcNLVe3bc5le7ZpuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733192996; c=relaxed/simple;
	bh=D5HzB3ogk9OrdCC1mvimoBl2y5cPAgygbuOAJiGAjH4=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:Subject; b=XMVFmgj4q3IWWLtQRgRlHiSp98inM6SPwztjV8C057NQ0/cb4V1wdFKeob2FBb1hmXg6HsYwaQYME5oSpBugZvtCCCNljvkPlSRWEjtoiVRfmYSsN+gGsDlJV9dCriALczb4KSP7gxBurazTt/e9Ap77EtqJw14o1l4u70S6Bg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVakdDqy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F57CC4CED1;
	Tue,  3 Dec 2024 02:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733192996;
	bh=D5HzB3ogk9OrdCC1mvimoBl2y5cPAgygbuOAJiGAjH4=;
	h=From:Date:To:Subject:From;
	b=VVakdDqyytKm5Q5Zp/DGdQNHNaQm45vO+3X6s1A2gdBZAhtB7LxTnaOqWiaGl09QZ
	 6ptzikHUHDRpZNg+msML2u96LTpS0ndLIxxjjzVWchr1ohEnxrkWY5en7mk2g6z2uZ
	 wyWvi+PCKcN7R7WTw1CMLCMkqw5JbDAWwKVjcpvjxAspkHrDGP6y9tzJT1r/gFgNJ/
	 dThDt/LavuSaG2NX8anq6Rpne6/pYXJfovmANbr/0zJouEYsMPKtpwUcnPpOsitZ05
	 UcfrHyGyCbN+hdhR75n548TzpOK9WCWm8P8qNvQtYOd4qAE/ExvrSCJRK6fguuNGie
	 pPJod2AydYx5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7A1063806656;
	Tue,  3 Dec 2024 02:30:11 +0000 (UTC)
From: Li Lingfeng via Bugspray Bot <bugbot@kernel.org>
Date: Tue, 03 Dec 2024 02:30:08 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: jlayton@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org, 
 trondmy@kernel.org, cel@kernel.org
Message-ID: <20241203-b219550c0-abf5589a5df5@bugzilla.kernel.org>
Subject: deploying both NFS client and server on the same machine triggle
 hungtask
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Li Lingfeng writes via Kernel.org Bugzilla:

We deployed the client and server on the same machine for some testing, which caused some processes to trigger hungtask.
Among them, processes 1/234577 are waiting for shrinker_rwsem, and processes 234303/234377/234550/234560/234574/234575/234576/234578 are waiting for nfsd_mutex.
According to the information in the vmcore, process 234291 holds shrinker_rwsem, causing process 1/234577 to trigger hungtask, and process 234577 is holding nfsd_mutex while waiting for shrinker_rwsem, causing other processes to trigger hungtask.

crash> p nfsd_mutex.owner
$4 = {
  counter = -131387141472191
}
crash> task_struct.comm ffff88810c1ac040
  comm = "bash\000d\000ter\000\000\000\000\000",
crash> task_struct.pid ffff88810c1ac040
  pid = 234577,
crash>
crash> p shrinker_rwsem.owner
$2 = {
  counter = -131387117846463
}
crash> task_struct.comm ffff88810d834040
  comm = "bash\000d\000ter\000\000\000\000\000",
crash> task_struct.pid ffff88810d834040
  pid = 234291,
crash> bt 234291
PID: 234291  TASK: ffff88810d834040  CPU: 2   COMMAND: "bash"
 #0 [ffffc90003f673e8] __schedule at ffffffff92a42326
 #1 [ffffc90003f674e8] schedule at ffffffff92a42c98
 #2 [ffffc90003f67510] rpc_wait_bit_killable at ffffffff928a24cc
 #3 [ffffc90003f67530] __wait_on_bit at ffffffff92a434a8
 #4 [ffffc90003f67588] out_of_line_wait_on_bit at ffffffff92a4366a
 #5 [ffffc90003f67638] _nfs4_proc_delegreturn at ffffffff91b037c5
 #6 [ffffc90003f677b8] nfs4_proc_delegreturn at ffffffff91b1af73
 #7 [ffffc90003f678a0] nfs_do_return_delegation at ffffffff91b43aeb
 #8 [ffffc90003f678d0] nfs_inode_evict_delegation at ffffffff91b45a5e
 #9 [ffffc90003f678f0] nfs4_evict_inode at ffffffff91b40676
#10 [ffffc90003f67908] evict at ffffffff918b19e1
#11 [ffffc90003f67950] dispose_list at ffffffff918b1c2e
#12 [ffffc90003f67988] prune_icache_sb at ffffffff918b4442
#13 [ffffc90003f67a18] super_cache_scan at ffffffff9187e854
#14 [ffffc90003f67a80] do_shrink_slab at ffffffff916d5a0e
#15 [ffffc90003f67b10] shrink_slab at ffffffff916db1f6
#16 [ffffc90003f67bd8] drop_slab_node at ffffffff916db30f
#17 [ffffc90003f67c10] drop_slab at ffffffff916db3b8
#18 [ffffc90003f67c28] drop_caches_sysctl_handler at ffffffff91962da6
#19 [ffffc90003f67c48] proc_sys_call_handler at ffffffff919a595a
#20 [ffffc90003f67d18] new_sync_write at ffffffff918738ed
#21 [ffffc90003f67e60] vfs_write at ffffffff91878d0e
#22 [ffffc90003f67ea8] ksys_write at ffffffff918793c9
#23 [ffffc90003f67f40] do_syscall_64 at ffffffff92a2e190
#24 [ffffc90003f67f50] entry_SYSCALL_64_after_hwframe at ffffffff92c0011f
    RIP: 00007fe96d5fef07  RSP: 00007fff59407f28  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 0000000000000002  RCX: 00007fe96d5fef07
    RDX: 0000000000000002  RSI: 000055bad3d218b0  RDI: 0000000000000001
    RBP: 000055bad3d218b0   R8: 00007fe96d6b3000   R9: 00007fe96d6b3080
    R10: 00007fe96d6b2f80  R11: 0000000000000246  R12: 0000000000000002
    R13: 00007fe96d6f45a0  R14: 0000000000000002  R15: 00007fe96d6f47a0
    ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b
crash>

This is our analysis of the cause:
https://lore.kernel.org/all/887cd8f6-3e49-410c-8b36-9e617c34ca6f@huawei.com/

The log is as follows:

[ 6340.366469] bash (158426): drop_caches: 3
[ 6342.199660] NFSD: Using nfsdcld client tracking operations.
[ 6342.201199] NFSD: starting 20-second grace period (net f0000098)
[ 6343.714137] NFSD: all clients done reclaiming, ending NFSv4 grace period (net f0000098)
[ 6383.434249] EXT4-fs (sdb): unmounting filesystem 8ec30df4-38d5-4310-88db-b7f543dd479e.
[ 6385.878329] EXT4-fs (sdb): mounted filesystem 8ec30df4-38d5-4310-88db-b7f543dd479e r/w with ordered data mode.
 Opts: (null)
[ 6388.163185] NFSD: Using nfsdcld client tracking operations.
[ 6388.165153] NFSD: no clients to reclaim, skipping NFSv4 grace period (net f0000098)
[ 6395.863853] bash (234291): drop_caches: 3
[ 6404.878651] [start] do_inject: net_random_error
[ 6404.881067] [start] do_inject: net_delay lo 128.0.0.1/8
[ 8624.939535] INFO: task systemd:1 blocked for more than 1212 seconds.
[ 8624.941432]       Not tainted 5.10.0-00574-gc310db27923f-dirty #159
[ 8624.943087] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 8624.945068] task:systemd         state:D stack:    0 pid:    1 ppid:     0 flags:0x00000000
[ 8624.947201] Call Trace:
[ 8624.948011]  __schedule+0x726/0x1010
[ 8624.949065]  ? io_schedule_timeout+0xb0/0xb0
[ 8624.950261]  ? mark_held_locks+0x65/0x90
[ 8624.951345]  schedule+0x88/0x1a0
[ 8624.952326]  rwsem_down_write_slowpath+0x460/0xa60
[ 8624.953662]  ? rwsem_optimistic_spin+0x400/0x400
[ 8624.954944]  ? lock_acquire+0x15a/0x3a0
[ 8624.956325]  ? alloc_shrinker_info+0x23/0x150
[ 8624.958516]  ? lock_release+0x150/0x150
[ 8624.960230]  down_write+0x135/0x140
[ 8624.961843]  ? down_write_killable_nested+0x170/0x170
[ 8624.963790]  ? __lock_release+0x12f/0x290
[ 8624.964935]  ? mark_lock+0x8f/0x6a0
[ 8624.965937]  alloc_shrinker_info+0x23/0x150
[ 8624.967073]  mem_cgroup_css_online+0x15/0x2e0
[ 8624.968299]  online_css+0x4c/0x120
[ 8624.969301]  css_create+0x2e7/0x3d0
[ 8624.970339]  cgroup_apply_control_enable+0x219/0x290
[ 8624.971693]  cgroup_mkdir+0x163/0x2b0
[ 8624.972750]  ? cgroup_destroy_locked+0x3c0/0x3c0
[ 8624.974022]  kernfs_iop_mkdir+0x9e/0xd0
[ 8624.975078]  vfs_mkdir+0x269/0x370
[ 8624.976061]  do_mkdirat+0x1b5/0x1f0
[ 8624.977073]  ? __ia32_sys_mknod+0x50/0x50
[ 8624.978204]  ? lockdep_hardirqs_on_prepare.part.0+0xf9/0x1c0
[ 8624.979674]  ? syscall_enter_from_user_mode+0x27/0x80
[ 8624.981038]  do_syscall_64+0x30/0x40
[ 8624.982055]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
[ 8624.983392] RIP: 0033:0x7f8c9732badb
[ 8624.984374] RSP: 002b:00007fff39f84bb8 EFLAGS: 00000206 ORIG_RAX: 0000000000000053
[ 8624.986229] RAX: ffffffffffffffda RBX: 000055a78a1a50a0 RCX: 00007f8c9732badb
[ 8624.988015] RDX: 0000000000000000 RSI: 00000000000001ed RDI: 000055a78a0fe1d0
[ 8624.989816] RBP: 00007f8c977797aa R08: 0000000000000022 R09: 0000000000000000
[ 8624.991614] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
[ 8624.993417] R13: 00000000000000e0 R14: 000055a78a1a50a0 R15: 0000000000000001
[ 8624.995555] INFO: task bash:234303 blocked for more than 1212 seconds.
[ 8624.997233]       Not tainted 5.10.0-00574-gc310db27923f-dirty #159
[ 8624.998851] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 8625.000815] task:bash            state:D stack:    0 pid:234303 ppid:   531 flags:0x00000084
[ 8625.002930] Call Trace:
[ 8625.003728]  __schedule+0x726/0x1010
[ 8625.004777]  ? io_schedule_timeout+0xb0/0xb0
[ 8625.006001]  schedule+0x88/0x1a0
[ 8625.006962]  schedule_preempt_disabled+0x11/0x20
[ 8625.008200]  __mutex_lock+0x3d4/0xc50
[ 8625.009250]  ? write_versions+0x21/0x60
[ 8625.010348]  ? mutex_trylock+0x180/0x180
[ 8625.011462]  ? lock_downgrade+0x90/0x90
[ 8625.012583]  ? should_fail_ex+0x7f/0x2c0
[ 8625.013709]  write_versions+0x21/0x60
[ 8625.014770]  ? __write_versions.isra.0+0x620/0x620
[ 8625.016077]  nfsctl_transaction_write+0x70/0xa0
[ 8625.017326]  vfs_write+0x141/0x520
[ 8625.018332]  ksys_write+0xc9/0x170
[ 8625.019330]  ? __ia32_sys_read+0x50/0x50
[ 8625.020444]  ? ktime_get_coarse_real_ts64+0xfe/0x110
[ 8625.021778]  ? ktime_get_coarse_real_ts64+0xa2/0x110
[ 8625.023172]  do_syscall_64+0x30/0x40
[ 8625.024196]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
[ 8625.025544] RIP: 0033:0x7fe96d5fef07
[ 8625.026549] RSP: 002b:00007fff59407c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[ 8625.028438] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fe96d5fef07
[ 8625.030238] RDX: 0000000000000003 RSI: 000055bad3d218b0 RDI: 0000000000000001
[ 8625.032046] RBP: 000055bad3d218b0 R08: 00007fe96d6b3000 R09: 00007fe96d6b3080
[ 8625.033887] R10: 00007fe96d6b2f80 R11: 0000000000000246 R12: 0000000000000003
[ 8625.035685] R13: 00007fe96d6f45a0 R14: 0000000000000003 R15: 00007fe96d6f47a0
[ 8625.037542] INFO: task bash:234377 blocked for more than 1212 seconds.
[ 8625.039217]       Not tainted 5.10.0-00574-gc310db27923f-dirty #159
[ 8625.040817] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 8625.042777] task:bash            state:D stack:    0 pid:234377 ppid:   531 flags:0x00000084
[ 8625.044876] Call Trace:
[ 8625.045683]  __schedule+0x726/0x1010
[ 8625.046733]  ? io_schedule_timeout+0xb0/0xb0
[ 8625.047965]  schedule+0x88/0x1a0
[ 8625.048920]  schedule_preempt_disabled+0x11/0x20
[ 8625.050168]  __mutex_lock+0x3d4/0xc50
[ 8625.051221]  ? write_versions+0x21/0x60
[ 8625.052313]  ? mutex_trylock+0x180/0x180
[ 8625.053414]  ? lock_downgrade+0x90/0x90
[ 8625.054536]  ? should_fail_ex+0x7f/0x2c0
[ 8625.055675]  write_versions+0x21/0x60
[ 8625.056738]  ? __write_versions.isra.0+0x620/0x620
[ 8625.058025]  nfsctl_transaction_write+0x70/0xa0
[ 8625.059270]  vfs_write+0x141/0x520
[ 8625.060276]  ksys_write+0xc9/0x170
[ 8625.061287]  ? __ia32_sys_read+0x50/0x50
[ 8625.062399]  ? ktime_get_coarse_real_ts64+0xfe/0x110
[ 8625.063728]  ? ktime_get_coarse_real_ts64+0xa2/0x110
[ 8625.065106]  do_syscall_64+0x30/0x40
[ 8625.066169]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
[ 8625.067533] RIP: 0033:0x7fe96d5fef07
[ 8625.068577] RSP: 002b:00007fff59407c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[ 8625.070535] RAX: ffffffffffffffda RBX: 0000000000000013 RCX: 00007fe96d5fef07
[ 8625.072365] RDX: 0000000000000013 RSI: 000055bad3d218b0 RDI: 0000000000000001
[ 8625.074190] RBP: 000055bad3d218b0 R08: 00007fe96d6b3000 R09: 00007fe96d6b3080
[ 8625.076022] R10: 00007fe96d6b2f80 R11: 0000000000000246 R12: 0000000000000013
[ 8625.077851] R13: 00007fe96d6f45a0 R14: 0000000000000013 R15: 00007fe96d6f47a0
[ 8625.079730] INFO: task bash:234550 blocked for more than 1212 seconds.
[ 8625.081437]       Not tainted 5.10.0-00574-gc310db27923f-dirty #159
[ 8625.083279] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 8625.085276] task:bash            state:D stack:    0 pid:234550 ppid:   531 flags:0x00000080
[ 8625.087399] Call Trace:
[ 8625.088201]  __schedule+0x726/0x1010
[ 8625.089255]  ? io_schedule_timeout+0xb0/0xb0
[ 8625.090438]  schedule+0x88/0x1a0
[ 8625.091395]  schedule_preempt_disabled+0x11/0x20
[ 8625.092648]  __mutex_lock+0x3d4/0xc50
[ 8625.093656]  ? nfsd_svc+0xc6/0x3c0
[ 8625.094665]  ? mutex_trylock+0x180/0x180
[ 8625.095767]  ? __lock_release+0x12f/0x290
[ 8625.096912]  ? lock_downgrade+0x90/0x90
[ 8625.098013]  ? _parse_integer_limit+0xb1/0xd0
[ 8625.099229]  ? simple_strtol+0xb0/0x140
[ 8625.100332]  ? nfsd_svc+0x99/0x3c0
[ 8625.101328]  nfsd_svc+0xc6/0x3c0
[ 8625.102311]  write_threads+0x134/0x1d0
[ 8625.103379]  ? write_pool_threads+0x340/0x340
[ 8625.104601]  ? should_fail_ex+0x7f/0x2c0
[ 8625.105715]  ? _copy_from_user+0xa0/0xf0
[ 8625.106819]  ? write_pool_threads+0x340/0x340
[ 8625.108025]  nfsctl_transaction_write+0x70/0xa0
[ 8625.109257]  vfs_write+0x141/0x520
[ 8625.110252]  ksys_write+0xc9/0x170
[ 8625.111239]  ? __ia32_sys_read+0x50/0x50
[ 8625.112344]  ? ktime_get_coarse_real_ts64+0xfe/0x110
[ 8625.113673]  ? ktime_get_coarse_real_ts64+0xa2/0x110
[ 8625.115035]  do_syscall_64+0x30/0x40
[ 8625.116056]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
[ 8625.117402] RIP: 0033:0x7fe96d5fef07
[ 8625.118421] RSP: 002b:00007fff594080b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[ 8625.120334] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fe96d5fef07
[ 8625.122149] RDX: 0000000000000002 RSI: 000055bad3d218b0 RDI: 0000000000000001
[ 8625.123941] RBP: 000055bad3d218b0 R08: 00007fe96d6b3000 R09: 00007fe96d6b3080
[ 8625.125672] R10: 00007fe96d6b2f80 R11: 0000000000000246 R12: 0000000000000002
[ 8625.127465] R13: 00007fe96d6f45a0 R14: 0000000000000002 R15: 00007fe96d6f47a0
[ 8625.129282] INFO: task cat:234560 blocked for more than 1212 seconds.
[ 8625.130946]       Not tainted 5.10.0-00574-gc310db27923f-dirty #159
[ 8625.132572] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 8625.134518] task:cat             state:D stack:    0 pid:234560 ppid:234557 flags:0x00000080
[ 8625.136570] Call Trace:
[ 8625.137367]  __schedule+0x726/0x1010
[ 8625.138430]  ? io_schedule_timeout+0xb0/0xb0
[ 8625.139661]  schedule+0x88/0x1a0
[ 8625.140671]  schedule_preempt_disabled+0x11/0x20
[ 8625.141950]  __mutex_lock+0x3d4/0xc50
[ 8625.143026]  ? write_versions+0x21/0x60
[ 8625.144177]  ? mutex_trylock+0x180/0x180
[ 8625.145264]  ? lock_downgrade+0x90/0x90
[ 8625.146399]  ? should_fail_ex+0x7f/0x2c0
[ 8625.147546]  write_versions+0x21/0x60
[ 8625.148605]  ? __write_versions.isra.0+0x620/0x620
[ 8625.149911]  nfsctl_transaction_write+0x70/0xa0
[ 8625.151182]  nfsctl_transaction_read+0x56/0x70
[ 8625.152431]  vfs_read+0x111/0x2c0
[ 8625.153433]  ksys_read+0xc9/0x170
[ 8625.154409]  ? __ia32_sys_pwrite64+0x140/0x140
[ 8625.155630]  ? ktime_get_coarse_real_ts64+0xfe/0x110
[ 8625.156970]  ? ktime_get_coarse_real_ts64+0xa2/0x110
[ 8625.158340]  do_syscall_64+0x30/0x40
[ 8625.159364]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
[ 8625.160719] RIP: 0033:0x7fa1f7b1be62
[ 8625.161750] RSP: 002b:00007ffda25a6298 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[ 8625.163670] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007fa1f7b1be62
[ 8625.165479] RDX: 0000000000020000 RSI: 00007fa1f79fb000 RDI: 0000000000000003
[ 8625.167290] RBP: 00007fa1f79fb000 R08: 00000000ffffffff R09: 0000000000000000
[ 8625.169089] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000020000
[ 8625.170895] R13: 0000000000000003 R14: 0000000000000000 R15: 000055567631ea58
[ 8625.172768] INFO: task cat:234574 blocked for more than 1212 seconds.
[ 8625.174450]       Not tainted 5.10.0-00574-gc310db27923f-dirty #159
[ 8625.176061] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 8625.178026] task:cat             state:D stack:    0 pid:234574 ppid:234564 flags:0x00000080
[ 8625.180103] Call Trace:
[ 8625.180909]  __schedule+0x726/0x1010
[ 8625.181984]  ? io_schedule_timeout+0xb0/0xb0
[ 8625.183219]  schedule+0x88/0x1a0
[ 8625.184186]  schedule_preempt_disabled+0x11/0x20
[ 8625.185429]  __mutex_lock+0x3d4/0xc50
[ 8625.186477]  ? write_versions+0x21/0x60
[ 8625.187578]  ? mutex_trylock+0x180/0x180
[ 8625.188689]  ? lock_downgrade+0x90/0x90
[ 8625.189811]  ? should_fail_ex+0x7f/0x2c0
[ 8625.190938]  write_versions+0x21/0x60
[ 8625.191987]  ? __write_versions.isra.0+0x620/0x620
[ 8625.193260]  nfsctl_transaction_write+0x70/0xa0
[ 8625.194488]  nfsctl_transaction_read+0x56/0x70
[ 8625.195700]  vfs_read+0x111/0x2c0
[ 8625.196685]  ksys_read+0xc9/0x170
[ 8625.197649]  ? __ia32_sys_pwrite64+0x140/0x140
[ 8625.198852]  ? ktime_get_coarse_real_ts64+0xfe/0x110
[ 8625.200168]  ? ktime_get_coarse_real_ts64+0xa2/0x110
[ 8625.201502]  do_syscall_64+0x30/0x40
[ 8625.202530]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
[ 8625.203880] RIP: 0033:0x7f8e1a01de62
[ 8625.204887] RSP: 002b:00007ffd2027f508 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[ 8625.206784] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f8e1a01de62
[ 8625.208576] RDX: 0000000000020000 RSI: 00007f8e19efd000 RDI: 0000000000000003
[ 8625.210361] RBP: 00007f8e19efd000 R08: 00000000ffffffff R09: 0000000000000000
[ 8625.212156] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000020000
[ 8625.213952] R13: 0000000000000003 R14: 0000000000000000 R15: 000055c46bacaa58
[ 8625.215931] INFO: task cat:234575 blocked for more than 1212 seconds.
[ 8625.217722]       Not tainted 5.10.0-00574-gc310db27923f-dirty #159
[ 8625.219420] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 8625.221498] task:cat             state:D stack:    0 pid:234575 ppid:234570 flags:0x00000080
[ 8625.223710] Call Trace:
[ 8625.224559]  __schedule+0x726/0x1010
[ 8625.225668]  ? io_schedule_timeout+0xb0/0xb0
[ 8625.226968]  schedule+0x88/0x1a0
[ 8625.227981]  schedule_preempt_disabled+0x11/0x20
[ 8625.229320]  __mutex_lock+0x3d4/0xc50
[ 8625.230449]  ? nfsd_pool_stats_open+0xea/0x2b0
[ 8625.231752]  ? mutex_trylock+0x180/0x180
[ 8625.232921]  ? __lock_release+0x12f/0x290
[ 8625.234109]  ? lock_downgrade+0x90/0x90
[ 8625.235256]  ? apparmor_file_alloc_security+0x530/0x530
[ 8625.236748]  ? do_raw_spin_lock+0x11a/0x1b0
[ 8625.238006]  ? nfsd_pool_stats_open+0xb6/0x2b0
[ 8625.239287]  nfsd_pool_stats_open+0xea/0x2b0
[ 8625.240556]  do_dentry_open+0x2cc/0x760
[ 8625.241720]  ? nfssvc_encode_voidres+0x10/0x10
[ 8625.243044]  do_open+0x2bb/0x4b0
[ 8625.244070]  path_openat+0x1c8/0x2d0
[ 8625.245179]  ? do_tmpfile+0x1e0/0x1e0
[ 8625.246290]  ? __lock_acquire+0x537/0x940
[ 8625.247508]  do_filp_open+0x125/0x240
[ 8625.248617]  ? may_open_dev+0x50/0x50
[ 8625.249764]  ? page_counter_try_charge+0x4e/0x110
[ 8625.251160]  ? files_cgroup_alloc_fd+0xdb/0xf0
[ 8625.252431]  ? files_cgroup_unalloc_fd+0x60/0x60
[ 8625.253774]  ? do_raw_spin_unlock+0x99/0x100
[ 8625.255058]  ? _raw_spin_unlock+0x1f/0x30
[ 8625.256242]  ? alloc_fd+0x1b1/0x330
[ 8625.257331]  do_sys_openat2+0x2ca/0x470
[ 8625.258496]  ? file_open_root+0x210/0x210
[ 8625.259680]  ? syscall_trace_enter.constprop.0+0x158/0x1e0
[ 8625.261211]  ? lock_downgrade+0x90/0x90
[ 8625.262364]  ? __ia32_compat_sys_newfstatat+0x60/0x60
[ 8625.263790]  ? up_read+0x18c/0x500
[ 8625.264862]  __x64_sys_openat+0xce/0x140
[ 8625.266035]  ? __x64_sys_open+0x130/0x130
[ 8625.267222]  ? ktime_get_coarse_real_ts64+0xfe/0x110
[ 8625.268638]  ? ktime_get_coarse_real_ts64+0xfe/0x110
[ 8625.270081]  ? ktime_get_coarse_real_ts64+0xa2/0x110
[ 8625.271509]  do_syscall_64+0x30/0x40
[ 8625.272597]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
[ 8625.274022] RIP: 0033:0x7faa0f5dfbbb
[ 8625.275108] RSP: 002b:00007fff5377ece0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[ 8625.277183] RAX: ffffffffffffffda RBX: 0000562156c4863c RCX: 00007faa0f5dfbbb
[ 8625.279086] RDX: 0000000000000000 RSI: 00007fff53780d14 RDI: 00000000ffffff9c
[ 8625.281010] RBP: 00007fff53780d14 R08: 0000000000000000 R09: 0000000000000000
[ 8625.282912] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[ 8625.284804] R13: 0000000000020000 R14: 00007faa0f71fa80 R15: 0000562156c4ba58
[ 8625.286783] INFO: task cat:234576 blocked for more than 1212 seconds.
[ 8625.288532]       Not tainted 5.10.0-00574-gc310db27923f-dirty #159
[ 8625.290232] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 8625.292311] task:cat             state:D stack:    0 pid:234576 ppid:234561 flags:0x00000080
[ 8625.294542] Call Trace:
[ 8625.295378]  __schedule+0x726/0x1010
[ 8625.296500]  ? io_schedule_timeout+0xb0/0xb0
[ 8625.297792]  schedule+0x88/0x1a0
[ 8625.298810]  schedule_preempt_disabled+0x11/0x20
[ 8625.300161]  __mutex_lock+0x3d4/0xc50
[ 8625.301272]  ? nfsd_nrthreads+0xbf/0x210
[ 8625.302453]  ? mutex_trylock+0x180/0x180
[ 8625.303626]  ? __lock_release+0x12f/0x290
[ 8625.304813]  ? lock_downgrade+0x90/0x90
[ 8625.305997]  ? nfsd_nrthreads+0x8f/0x210
[ 8625.307191]  nfsd_nrthreads+0xbf/0x210
[ 8625.308269]  write_threads+0x146/0x1d0
[ 8625.309391]  ? write_pool_threads+0x340/0x340
[ 8625.310620]  ? should_fail_ex+0x7f/0x2c0
[ 8625.311777]  ? _copy_from_user+0xa0/0xf0
[ 8625.312955]  ? write_pool_threads+0x340/0x340
[ 8625.314223]  nfsctl_transaction_write+0x70/0xa0
[ 8625.315534]  nfsctl_transaction_read+0x56/0x70
[ 8625.316837]  vfs_read+0x111/0x2c0
[ 8625.317889]  ksys_read+0xc9/0x170
[ 8625.318921]  ? __ia32_sys_pwrite64+0x140/0x140
[ 8625.320216]  ? ktime_get_coarse_real_ts64+0xfe/0x110
[ 8625.321624]  ? ktime_get_coarse_real_ts64+0xa2/0x110
[ 8625.323076]  do_syscall_64+0x30/0x40
[ 8625.324175]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
[ 8625.325590] RIP: 0033:0x7f3d2aa48e62
[ 8625.326667] RSP: 002b:00007ffcc44e5228 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[ 8625.328700] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f3d2aa48e62
[ 8625.330592] RDX: 0000000000020000 RSI: 00007f3d2a928000 RDI: 0000000000000003
[ 8625.332491] RBP: 00007f3d2a928000 R08: 00000000ffffffff R09: 0000000000000000
[ 8625.334404] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000020000
[ 8625.336301] R13: 0000000000000003 R14: 0000000000000000 R15: 00005633deffda58
[ 8625.338267] INFO: task bash:234577 blocked for more than 1212 seconds.
[ 8625.340034]       Not tainted 5.10.0-00574-gc310db27923f-dirty #159
[ 8625.341716] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 8625.343756] task:bash            state:D stack:    0 pid:234577 ppid:234550 flags:0x00004082
[ 8625.345963] Call Trace:
[ 8625.346789]  __schedule+0x726/0x1010
[ 8625.347888]  ? io_schedule_timeout+0xb0/0xb0
[ 8625.349163]  ? mark_held_locks+0x65/0x90
[ 8625.350340]  schedule+0x88/0x1a0
[ 8625.351354]  rwsem_down_write_slowpath+0x460/0xa60
[ 8625.352740]  ? rwsem_optimistic_spin+0x400/0x400
[ 8625.354097]  ? lock_acquire+0x15a/0x3a0
[ 8625.355255]  ? unregister_shrinker+0x47/0x120
[ 8625.356538]  ? lock_release+0x150/0x150
[ 8625.357748]  down_write+0x135/0x140
[ 8625.358828]  ? down_write_killable_nested+0x170/0x170
[ 8625.360266]  ? find_held_lock+0x85/0xa0
[ 8625.361430]  unregister_shrinker+0x47/0x120
[ 8625.362666]  nfs4_state_shutdown_net+0x128/0x410
[ 8625.364001]  ? rpc_shutdown_client+0x108/0x270
[ 8625.365269]  ? nfs4_state_start+0x70/0x70
[ 8625.366443]  ? rpcb_put_local+0x13e/0x2a0
[ 8625.367613]  ? nfsd_shutdown_net+0x8f/0x250
[ 8625.368842]  nfsd_shutdown_net+0xbd/0x250
[ 8625.370019]  nfsd_last_thread+0x160/0x2a0
[ 8625.371192]  nfsd_svc+0x393/0x3c0
[ 8625.372209]  write_threads+0x134/0x1d0
[ 8625.373315]  ? write_pool_threads+0x340/0x340
[ 8625.374590]  ? should_fail_ex+0x7f/0x2c0
[ 8625.375749]  ? _copy_from_user+0xa0/0xf0
[ 8625.376911]  ? write_pool_threads+0x340/0x340
[ 8625.378163]  nfsctl_transaction_write+0x70/0xa0
[ 8625.379447]  vfs_write+0x141/0x520
[ 8625.380495]  ksys_write+0xc9/0x170
[ 8625.381521]  ? __ia32_sys_read+0x50/0x50
[ 8625.382670]  ? ktime_get_coarse_real_ts64+0xfe/0x110
[ 8625.384058]  ? ktime_get_coarse_real_ts64+0xa2/0x110
[ 8625.385502]  do_syscall_64+0x30/0x40
[ 8625.386588]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
[ 8625.388003] RIP: 0033:0x7fe96d5fef07
[ 8625.389065] RSP: 002b:00007fff59408048 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[ 8625.391099] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fe96d5fef07
[ 8625.393014] RDX: 0000000000000002 RSI: 000055bad3d218b0 RDI: 0000000000000001
[ 8625.394923] RBP: 000055bad3d218b0 R08: 00007fe96d6b3000 R09: 00007fe96d6b3080
[ 8625.396833] R10: 00007fe96d6b2f80 R11: 0000000000000246 R12: 0000000000000002
[ 8625.398737] R13: 00007fe96d6f45a0 R14: 0000000000000002 R15: 00007fe96d6f47a0
[ 8625.400743] INFO: task cat:234578 blocked for more than 1212 seconds.
[ 8625.402472]       Not tainted 5.10.0-00574-gc310db27923f-dirty #159
[ 8625.404213] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 8625.406275] task:cat             state:D stack:    0 pid:234578 ppid:234556 flags:0x00000080
[ 8625.408493] Call Trace:
[ 8625.409341]  __schedule+0x726/0x1010
[ 8625.410447]  ? io_schedule_timeout+0xb0/0xb0
[ 8625.411726]  schedule+0x88/0x1a0
[ 8625.412739]  schedule_preempt_disabled+0x11/0x20
[ 8625.414076]  __mutex_lock+0x3d4/0xc50
[ 8625.415181]  ? nfsd_pool_stats_open+0xea/0x2b0
[ 8625.416469]  ? mutex_trylock+0x180/0x180
[ 8625.417662]  ? __lock_release+0x12f/0x290
[ 8625.418857]  ? lock_downgrade+0x90/0x90
[ 8625.420020]  ? apparmor_file_alloc_security+0x530/0x530
[ 8625.421497]  ? do_raw_spin_lock+0x11a/0x1b0
[ 8625.422732]  ? nfsd_pool_stats_open+0xb6/0x2b0
[ 8625.424036]  nfsd_pool_stats_open+0xea/0x2b0
[ 8625.425288]  do_dentry_open+0x2cc/0x760
[ 8625.426437]  ? nfssvc_encode_voidres+0x10/0x10
[ 8625.427747]  do_open+0x2bb/0x4b0
[ 8625.428773]  path_openat+0x1c8/0x2d0
[ 8625.429877]  ? do_tmpfile+0x1e0/0x1e0
[ 8625.431003]  ? __lock_acquire+0x537/0x940
[ 8625.432228]  do_filp_open+0x125/0x240
[ 8625.433348]  ? may_open_dev+0x50/0x50
[ 8625.434506]  ? page_counter_try_charge+0x4e/0x110
[ 8625.435881]  ? files_cgroup_alloc_fd+0xdb/0xf0
[ 8625.437183]  ? files_cgroup_unalloc_fd+0x60/0x60
[ 8625.438543]  ? do_raw_spin_unlock+0x99/0x100
[ 8625.439807]  ? _raw_spin_unlock+0x1f/0x30
[ 8625.440996]  ? alloc_fd+0x1b1/0x330
[ 8625.442091]  do_sys_openat2+0x2ca/0x470
[ 8625.443254]  ? file_open_root+0x210/0x210
[ 8625.444463]  ? syscall_trace_enter.constprop.0+0x158/0x1e0
[ 8625.445994]  ? lock_downgrade+0x90/0x90
[ 8625.447156]  ? __ia32_compat_sys_newfstatat+0x60/0x60
[ 8625.448590]  ? up_read+0x18c/0x500
[ 8625.449661]  __x64_sys_openat+0xce/0x140
[ 8625.450839]  ? __x64_sys_open+0x130/0x130
[ 8625.452030]  ? ktime_get_coarse_real_ts64+0xfe/0x110
[ 8625.453438]  ? ktime_get_coarse_real_ts64+0xfe/0x110
[ 8625.454834]  ? ktime_get_coarse_real_ts64+0xa2/0x110
[ 8625.456262]  do_syscall_64+0x30/0x40
[ 8625.457350]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
[ 8625.458771] RIP: 0033:0x7f8928fdebbb
[ 8625.459860] RSP: 002b:00007ffe1206d900 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[ 8625.461864] RAX: ffffffffffffffda RBX: 0000562cbd47263c RCX: 00007f8928fdebbb
[ 8625.463784] RDX: 0000000000000000 RSI: 00007ffe1206fd14 RDI: 00000000ffffff9c
[ 8625.465681] RBP: 00007ffe1206fd14 R08: 0000000000000000 R09: 0000000000000000
[ 8625.467577] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[ 8625.469443] R13: 0000000000020000 R14: 00007f892911ea80 R15: 0000562cbd475a58
[ 8625.471499]
               Showing all locks held in the system:
[ 8625.473315] 4 locks held by systemd/1:
[ 8625.474375]  #0: ffff888114161438 (sb_writers#8){.+.+}-{0:0}, at: filename_create+0xbf/0x260
[ 8625.476573]  #1: ffff8881145253d8 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: filename_create+0xf7/0x260
[ 8625.479010]  #2: ffffffff946870e8 (cgroup_mutex){+.+.}-{3:3}, at: cgroup_kn_lock_live+0x85/0x280
[ 8625.481258]  #3: ffffffff94788f10 (shrinker_rwsem){++++}-{3:3}, at: alloc_shrinker_info+0x23/0x150
[ 8625.483525] 1 lock held by khungtaskd/37:
[ 8625.484635]  #0: ffffffff945890a0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x28/0x20a
[ 8625.486948] 2 locks held by fsstress/234266:
[ 8625.488148]  #0: ffff88810b329438 (sb_writers#13){.+.+}-{0:0}, at: __se_sys_copy_file_range+0x127/0x2f0
[ 8625.490569]  #1: ffff88800c8c5300 (&sb->s_type->i_mutex_key#16){++++}-{3:3}, at: nfs_start_io_read+0x25/0x90
[ 8625.493059] 2 locks held by fsstress/234268:
[ 8625.494229]  #0: ffff88810b329438 (sb_writers#13){.+.+}-{0:0}, at: __se_sys_copy_file_range+0x127/0x2f0
[ 8625.496557]  #1: ffff888114ccdbb8 (&sb->s_type->i_mutex_key#16){++++}-{3:3}, at: nfs_start_io_read+0x25/0x90
[ 8625.499025] 2 locks held by fsstress/234271:
[ 8625.500191]  #0: ffff88810b329438 (sb_writers#13){.+.+}-{0:0}, at: open_last_lookups+0x670/0x690
[ 8625.502667]  #1: ffff88810ae6dbb8 (&type->i_mutex_dir_key#7){++++}-{3:3}, at: open_last_lookups+0x63b/0x690
[ 8625.505150] 2 locks held by fsstress/234283:
[ 8625.506341]  #0: ffff888111e53268 (&pipe->mutex/1){+.+.}-{3:3}, at: do_splice+0x3a3/0x800
[ 8625.508438]  #1: ffff8881144eed28 (&sb->s_type->i_mutex_key#16){++++}-{3:3}, at: nfs_start_io_read+0x25/0x90
[ 8625.510917] 3 locks held by bash/234291:
[ 8625.512026]  #0: ffff888102fe1438 (sb_writers#3){.+.+}-{0:0}, at: ksys_write+0xc9/0x170
[ 8625.514093]  #1: ffffffff94788f10 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab+0xa9/0x1d0
[ 8625.516246]  #2: ffff88810b3290e0 (&type->s_umount_key#51){++++}-{3:3}, at: super_cache_scan+0x41/0x2c0
[ 8625.518631] 2 locks held by bash/234303:
[ 8625.519758]  #0: ffff888107df1438 (sb_writers#11){.+.+}-{0:0}, at: ksys_write+0xc9/0x170
[ 8625.521829]  #1: ffffffff94a4bbe8 (nfsd_mutex){+.+.}-{3:3}, at: write_versions+0x21/0x60
[ 8625.523922] 2 locks held by bash/234377:
[ 8625.525016]  #0: ffff888107df1438 (sb_writers#11){.+.+}-{0:0}, at: ksys_write+0xc9/0x170
[ 8625.527097]  #1: ffffffff94a4bbe8 (nfsd_mutex){+.+.}-{3:3}, at: write_versions+0x21/0x60
[ 8625.529207] 2 locks held by bash/234550:
[ 8625.530310]  #0: ffff888107df1438 (sb_writers#11){.+.+}-{0:0}, at: ksys_write+0xc9/0x170
[ 8625.532393]  #1: ffffffff94a4bbe8 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_svc+0xc6/0x3c0
[ 8625.534409] 1 lock held by cat/234560:
[ 8625.535482]  #0: ffffffff94a4bbe8 (nfsd_mutex){+.+.}-{3:3}, at: write_versions+0x21/0x60
[ 8625.537599] 1 lock held by cat/234574:
[ 8625.538663]  #0: ffffffff94a4bbe8 (nfsd_mutex){+.+.}-{3:3}, at: write_versions+0x21/0x60
[ 8625.540736] 1 lock held by cat/234575:
[ 8625.541785]  #0: ffffffff94a4bbe8 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_pool_stats_open+0xea/0x2b0
[ 8625.543998] 1 lock held by cat/234576:
[ 8625.545064]  #0: ffffffff94a4bbe8 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nrthreads+0xbf/0x210
[ 8625.547185] 3 locks held by bash/234577:
[ 8625.548285]  #0: ffff888107df1438 (sb_writers#11){.+.+}-{0:0}, at: ksys_write+0xc9/0x170
[ 8625.550368]  #1: ffffffff94a4bbe8 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_svc+0xc6/0x3c0
[ 8625.552346]  #2: ffffffff94788f10 (shrinker_rwsem){++++}-{3:3}, at: unregister_shrinker+0x47/0x120
[ 8625.554653] 1 lock held by cat/234578:
[ 8625.555698]  #0: ffffffff94a4bbe8 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_pool_stats_open+0xea/0x2b0
[ 8625.557931] 1 lock held by cat/234579:
[ 8625.558999]  #0: ffffffff94a4bbe8 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_pool_stats_open+0xea/0x2b0
[ 8625.561223] 2 locks held by bash/234581:
[ 8625.562312]  #0: ffff888107df1438 (sb_writers#11){.+.+}-{0:0}, at: ksys_write+0xc9/0x170
[ 8625.564375]  #1: ffffffff94a4bbe8 (nfsd_mutex){+.+.}-{3:3}, at: write_versions+0x21/0x60
[ 8625.566443] 1 lock held by cat/234582:
[ 8625.567499]  #0: ffffffff94a4bbe8 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_pool_stats_open+0xea/0x2b0
[ 8625.569738] 1 lock held by cat/234583:
[ 8625.570796]  #0: ffffffff94a4bbe8 (nfsd_mutex){+.+.}-{3:3}, at: write_versions+0x21/0x60
[ 8625.572877] 1 lock held by cat/234584:
[ 8625.573936]  #0: ffffffff94a4bbe8 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nrthreads+0xbf/0x210
[ 8625.576035] 1 lock held by cat/234588:
[ 8625.577100]  #0: ffffffff94a4bbe8 (nfsd_mutex){+.+.}-{3:3}, at: write_versions+0x21/0x60
[ 8625.579200] 1 lock held by cat/234590:
[ 8625.580268]  #0: ffffffff94a4bbe8 (nfsd_mutex){+.+.}-{3:3}, at: write_versions+0x21/0x60
[ 8625.582306] 1 lock held by cat/234596:
[ 8625.583342]  #0: ffffffff94a4bbe8 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_pool_stats_open+0xea/0x2b0
[ 8625.585518] 1 lock held by cat/234597:
[ 8625.586567]  #0: ffffffff94a4bbe8 (nfsd_mutex){+.+.}-{3:3}, at: write_versions+0x21/0x60
[ 8625.588611] 2 locks held by bash/234600:
[ 8625.589671]  #0: ffff888107df1438 (sb_writers#11){.+.+}-{0:0}, at: ksys_write+0xc9/0x170
[ 8625.591708]  #1: ffffffff94a4bbe8 (nfsd_mutex){+.+.}-{3:3}, at: write_versions+0x21/0x60
[ 8625.593764] 1 lock held by cat/234602:
[ 8625.594839]  #0: ffffffff94a4bbe8 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nrthreads+0xbf/0x210
[ 8625.596969] 1 lock held by cat/234604:
[ 8625.598031]  #0: ffffffff94a4bbe8 (nfsd_mutex){+.+.}-{3:3}, at: write_versions+0x21/0x60
[ 8625.600053] 1 lock held by cat/234605:
[ 8625.601150]  #0: ffffffff94a4bbe8 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nrthreads+0xbf/0x210

[ 8625.603802] =============================================

[ 8625.605721] Kernel panic - not syncing: hung_task: blocked tasks
[ 8625.607247] CPU: 1 PID: 37 Comm: khungtaskd Not tainted 5.10.0-00574-gc310db27923f-dirty #159
[ 8625.609294] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qe
mu.org 04/01/2014
[ 8625.611997] Call Trace:
[ 8625.612744]  dump_stack+0x9a/0xd0
[ 8625.613696]  panic+0x219/0x3e5
[ 8625.614562]  ? __warn_printk+0xf7/0xf7
[ 8625.615601]  ? debug_show_all_locks+0x1cb/0x20a
[ 8625.616822]  check_hung_uninterruptible_tasks.cold+0x4d/0x75
[ 8625.618267]  ? check_hung_uninterruptible_tasks+0x330/0x330
[ 8625.619673]  watchdog+0xe3/0xf0
[ 8625.620568]  kthread+0x1c4/0x210
[ 8625.621479]  ? kthread_parkme+0x40/0x40
[ 8625.622524]  ret_from_fork+0x1f/0x30
[ 8625.623556] Kernel Offset: 0x10200000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffff
bfffffff)
[ 8625.626030] ---[ end Kernel panic - not syncing: hung_task: blocked tasks ]---

View: https://bugzilla.kernel.org/show_bug.cgi?id=219550#c0
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


