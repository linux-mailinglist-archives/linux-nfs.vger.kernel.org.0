Return-Path: <linux-nfs+bounces-5196-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C659412A5
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jul 2024 14:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2635A280CDA
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jul 2024 12:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4CF1A0AEF;
	Tue, 30 Jul 2024 12:54:37 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28EA1A0AF8
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jul 2024 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722344077; cv=none; b=WirsQZI6jTufJ+i5dmpbSMEPp+Dnex+asdbaqw4y3gp+BpGlpIofFh4Ok9ByJ0o/kgynK0bFKT0jTdfPg5nZgnJIqJBSNb5RrRzb5/wfHzU5Gm/TaIceiNviqDs2GYj0J3s8CRvttuvBL8MuTJzJqQX6+Aq9arf3nSa5W5iOgn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722344077; c=relaxed/simple;
	bh=LXTUZcQoLwZY7Qlazg0EqvQ+IN8mQCLrSo5nrnCz2hI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AgLFYyCIegqq+6371IaLhJWZXyQXCTnTRkrcW+fjf/o/xCAbm4VSh/p5BfIjqFZOHGRpvyEc2440QKmFyrGJ3whgka5zNPLRGgzkJIiiSnb7j3gNUgJ6/0+Y204/YZPnII1J8k9iUAtRAUu5hw2+XWH4zn5nu02XPFZiry+LCvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id F20DC61E5FE06;
	Tue, 30 Jul 2024 14:52:47 +0200 (CEST)
Message-ID: <7ccb2a39-bb32-47f8-8366-b4d09895593f@molgen.mpg.de>
Date: Tue, 30 Jul 2024 14:52:47 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: `rcu: INFO: rcu_sched self-detected stall on CPU` and spinning
 kworker `rpciod`
To: Salvatore Bonaccorso <carnil@debian.org>,
 Chuck Lever III <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 it+linux-nfs@molgen.mpg.de
References: <76a841e5-4e3d-4942-9a4b-24f87d6b79a5@molgen.mpg.de>
 <ZqVjVEV5IF_vz4Eq@eldamar.lan>
 <47222A7B-6B89-4260-AA16-EA7E7EAFBD68@oracle.com>
 <ZqjaX_uJqsJiCpam@eldamar.lan>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <ZqjaX_uJqsJiCpam@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Salvatore, dear Chuck,


Thank you for your messages.


Am 30.07.24 um 14:19 schrieb Salvatore Bonaccorso:

> On Sat, Jul 27, 2024 at 09:19:24PM +0000, Chuck Lever III wrote:
>>
>>> On Jul 27, 2024, at 5:15 PM, Salvatore Bonaccorso <carnil@debian.org> wrote:

>>> On Wed, Jul 17, 2024 at 07:33:24AM +0200, Paul Menzel wrote:

>>>> Using Linux 5.15.160 on a Dell PowerEdge T440/021KCD, BIOS 2.11.2
>>>> 04/22/2021, a mount from another server hung. Linux logs:
>>>>
>>>> ```
>>>> $ dmesg -T
>>>> [Wed Jul  3 16:39:34 2024] Linux version 5.15.160.mx64.476(root@theinternet.molgen.mpg.de) (gcc (GCC) 12.3.0, GNU ld (GNU Binutils) 2.41) #1 SMP Wed Jun 5 12:24:15 CEST 2024
>>>> [Wed Jul  3 16:39:34 2024] Command line: root=LABEL=root ro crashkernel=64G-:256M console=ttyS0,115200n8 console=tty0 init=/bin/systemd audit=0 random.trust_cpu=on systemd.unified_cgroup_hierarchy
>>>> […]
>>>> [Wed Jul  3 16:39:34 2024] DMI: Dell Inc. PowerEdge T440/021KCD, BIOS 2.11.2 04/22/2021
>>>> […]
>>>> [Tue Jul 16 06:00:10 2024] md: md3: data-check interrupted.
>>>> [Tue Jul 16 11:06:01 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000ee580afa xid 6890a3d2
>>>> [Tue Jul 16 11:06:01 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000d4d84570 xid 3ca4017a

[…]

>>>> [Tue Jul 16 11:35:59 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 0000000028481e8f xid b682b676
>>>> [Tue Jul 16 11:35:59 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000c384ff38 xid b5d5dbf5
>>>> [Tue Jul 16 11:36:40 2024] rcu: INFO: rcu_sched self-detected stall on CPU
>>>> [Tue Jul 16 11:36:40 2024] rcu:  13-....: (20997 ticks this GP) idle=54f/1/0x4000000000000000 softirq=31904928/31904928 fqs=4433
>>>> [Tue Jul 16 11:36:40 2024]  (t=21017 jiffies g=194958993 q=5715)
>>>> [Tue Jul 16 11:36:40 2024] Task dump for CPU 13:
>>>> [Tue Jul 16 11:36:40 2024] task:kworker/u34:2   state:R  running task stack:    0 pid:30413 ppid:     2 flags:0x00004008
>>>> [Tue Jul 16 11:36:40 2024] Workqueue: rpciod rpc_async_schedule [sunrpc]
>>>> [Tue Jul 16 11:36:40 2024] Call Trace:
>>>> [Tue Jul 16 11:36:40 2024]  <IRQ>
>>>> [Tue Jul 16 11:36:40 2024]  sched_show_task.cold+0xc2/0xda
>>>> [Tue Jul 16 11:36:40 2024]  rcu_dump_cpu_stacks+0xa1/0xd3
>>>> [Tue Jul 16 11:36:40 2024]  rcu_sched_clock_irq.cold+0xc7/0x1e7
>>>> [Tue Jul 16 11:36:40 2024]  ? trigger_load_balance+0x6d/0x300
>>>> [Tue Jul 16 11:36:40 2024]  ? scheduler_tick+0xda/0x260
>>>> [Tue Jul 16 11:36:40 2024]  update_process_times+0xa1/0xe0
>>>> [Tue Jul 16 11:36:40 2024]  tick_sched_timer+0x8e/0xa0
>>>> [Tue Jul 16 11:36:40 2024]  ? tick_sched_do_timer+0x90/0x90
>>>> [Tue Jul 16 11:36:40 2024]  __hrtimer_run_queues+0x139/0x2a0
>>>> [Tue Jul 16 11:36:40 2024]  hrtimer_interrupt+0xf4/0x210
>>>> [Tue Jul 16 11:36:40 2024]  __sysvec_apic_timer_interrupt+0x5f/0xe0
>>>> [Tue Jul 16 11:36:40 2024]  sysvec_apic_timer_interrupt+0x69/0x90
>>>> [Tue Jul 16 11:36:40 2024]  </IRQ>
>>>> [Tue Jul 16 11:36:40 2024]  <TASK>
>>>> [Tue Jul 16 11:36:40 2024]  asm_sysvec_apic_timer_interrupt+0x16/0x20
>>>> [Tue Jul 16 11:36:40 2024] RIP: 0010:read_tsc+0x3/0x20
>>>> [Tue Jul 16 11:36:40 2024] Code: cc cc cc cc cc cc cc 8b 05 56 ab 72 01 c3 cc cc cc cc 0f 1f 44 00 00 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 01 f9 <66> 90 48 c1 e2 20 48 09 d0 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00
>>>> [Tue Jul 16 11:36:40 2024] RSP: 0018:ffffc900087cfe00 EFLAGS: 00000246
>>>> [Tue Jul 16 11:36:40 2024] RAX: 00000000226dc8b8 RBX: 000000003f3c079e RCX: 000000000000100d
>>>> [Tue Jul 16 11:36:40 2024] RDX: 00000000004535c4 RSI: 0000000000000046 RDI: ffffffff82435600
>>>> [Tue Jul 16 11:36:40 2024] RBP: 0003ed08d3641da3 R08: ffffffffa012c770 R09: ffffffffa012c788
>>>> [Tue Jul 16 11:36:40 2024] R10: 0000000000000003 R11: 0000000000000283 R12: 0000000000000000
>>>> [Tue Jul 16 11:36:40 2024] R13: 0000000000000001 R14: ffff88909311c000 R15: ffff88909311c005
>>>> [Tue Jul 16 11:36:40 2024]  ktime_get+0x38/0xa0
>>>> [Tue Jul 16 11:36:40 2024]  ? rpc_sleep_on_priority+0x70/0x70 [sunrpc]
>>>> [Tue Jul 16 11:36:40 2024]  rpc_exit_task+0x9a/0x100 [sunrpc]
>>>> [Tue Jul 16 11:36:40 2024]  __rpc_execute+0x6e/0x410 [sunrpc]
>>>> [Tue Jul 16 11:36:40 2024]  rpc_async_schedule+0x29/0x40 [sunrpc]
>>>> [Tue Jul 16 11:36:40 2024]  process_one_work+0x1d7/0x3a0
>>>> [Tue Jul 16 11:36:40 2024]  worker_thread+0x4a/0x3c0
>>>> [Tue Jul 16 11:36:40 2024]  ? process_one_work+0x3a0/0x3a0
>>>> [Tue Jul 16 11:36:40 2024]  kthread+0x115/0x140
>>>> [Tue Jul 16 11:36:40 2024]  ? set_kthread_struct+0x50/0x50
>>>> [Tue Jul 16 11:36:40 2024]  ret_from_fork+0x1f/0x30
>>>> [Tue Jul 16 11:36:40 2024]  </TASK>
>>>> [Tue Jul 16 11:37:19 2024] rcu: INFO: rcu_sched self-detected stall on CPU
>>>> [Tue Jul 16 11:37:19 2024] rcu:  7-....: (21000 ticks this GP) idle=5b1/1/0x4000000000000000 softirq=29984492/29984492 fqs=5159
>>>> [Tue Jul 16 11:37:19 2024]  (t=21017 jiffies g=194959001 q=2008)
>>>> [Tue Jul 16 11:37:19 2024] Task dump for CPU 7:
>>>> [Tue Jul 16 11:37:19 2024] task:kworker/u34:2   state:R  running task stack:    0 pid:30413 ppid:     2 flags:0x00004008
>>>> [Tue Jul 16 11:37:19 2024] Workqueue: rpciod rpc_async_schedule [sunrpc]
>>>> [Tue Jul 16 11:37:19 2024] Call Trace:
>>>> [Tue Jul 16 11:37:19 2024]  <IRQ>
>>>> [Tue Jul 16 11:37:19 2024]  sched_show_task.cold+0xc2/0xda
>>>> [Tue Jul 16 11:37:19 2024]  rcu_dump_cpu_stacks+0xa1/0xd3
>>>> [Tue Jul 16 11:37:19 2024]  rcu_sched_clock_irq.cold+0xc7/0x1e7
>>>> [Tue Jul 16 11:37:19 2024]  ? trigger_load_balance+0x6d/0x300
>>>> [Tue Jul 16 11:37:19 2024]  ? scheduler_tick+0xda/0x260
>>>> [Tue Jul 16 11:37:19 2024]  update_process_times+0xa1/0xe0
>>>> [Tue Jul 16 11:37:19 2024]  tick_sched_timer+0x8e/0xa0
>>>> [Tue Jul 16 11:37:19 2024]  ? tick_sched_do_timer+0x90/0x90
>>>> [Tue Jul 16 11:37:19 2024]  __hrtimer_run_queues+0x139/0x2a0
>>>> [Tue Jul 16 11:37:19 2024]  hrtimer_interrupt+0xf4/0x210
>>>> [Tue Jul 16 11:37:19 2024]  __sysvec_apic_timer_interrupt+0x5f/0xe0
>>>> [Tue Jul 16 11:37:19 2024]  sysvec_apic_timer_interrupt+0x69/0x90
>>>> [Tue Jul 16 11:37:19 2024]  </IRQ>
>>>> [Tue Jul 16 11:37:19 2024]  <TASK>
>>>> [Tue Jul 16 11:37:19 2024]  asm_sysvec_apic_timer_interrupt+0x16/0x20
>>>> [Tue Jul 16 11:37:19 2024] RIP: 0010:_raw_spin_lock+0x10/0x20
>>>> [Tue Jul 16 11:37:19 2024] Code: b8 00 02 00 00 f0 0f c1 07 a9 ff 01 00 00 75 05 c3 cc cc cc cc e9 f0 05 59 ff 0f 1f 44 00 00 31 c0 ba 01 00 00 00 f0 0f b1 17 <75> 05 c3 cc cc cc cc 89 c6 e9 62 02 59 ff 66 90 0f 1f 44 00 00 fa
>>>> [Tue Jul 16 11:37:19 2024] RSP: 0018:ffffc900087cfe30 EFLAGS: 00000246
>>>> [Tue Jul 16 11:37:19 2024] RAX: 0000000000000000 RBX: ffff88997131a500 RCX: 0000000000000001
>>>> [Tue Jul 16 11:37:19 2024] RDX: 0000000000000001 RSI: ffff88997131a500 RDI: ffffffffa012c700
>>>> [Tue Jul 16 11:37:19 2024] RBP: ffffffffa012c700 R08: ffffffffa012c770 R09: ffffffffa012c788
>>>> [Tue Jul 16 11:37:19 2024] R10: 0000000000000003 R11: 0000000000000283 R12: ffff88997131a530
>>>> [Tue Jul 16 11:37:19 2024] R13: 0000000000000001 R14: ffff88909311c000 R15: ffff88909311c005
>>>> [Tue Jul 16 11:37:19 2024]  __rpc_execute+0x95/0x410 [sunrpc]
>>>> [Tue Jul 16 11:37:19 2024]  rpc_async_schedule+0x29/0x40 [sunrpc]
>>>> [Tue Jul 16 11:37:19 2024]  process_one_work+0x1d7/0x3a0
>>>> [Tue Jul 16 11:37:19 2024]  worker_thread+0x4a/0x3c0
>>>> [Tue Jul 16 11:37:19 2024]  ? process_one_work+0x3a0/0x3a0
>>>> [Tue Jul 16 11:37:19 2024]  kthread+0x115/0x140
>>>> [Tue Jul 16 11:37:19 2024]  ? set_kthread_struct+0x50/0x50
>>>> [Tue Jul 16 11:37:19 2024]  ret_from_fork+0x1f/0x30
>>>> [Tue Jul 16 11:37:19 2024]  </TASK>
>>>> [Tue Jul 16 11:37:57 2024] rcu: INFO: rcu_sched self-detected stall on CPU
>>>> […]
>>>> ```
>>>
>>> FWIW, on one NFS server occurence we are seeing something very close
>>> to the above but in the 5.10.y case for the Debian kernel after
>>> updating to 5.10.218-1 to 5.10.221-1, so kernel after which had the
>>> big NFS related stack backported.
>>>
>>> One backtrace we were able to catch was
>>>
>>> [...]
>>> Jul 27 15:24:52 nfsserver kernel: receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 000000003d26f7ec xid b172e1c6
>>> Jul 27 15:24:52 nfsserver kernel: receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 0000000017f1552a xid a90d7751
>>> Jul 27 15:24:52 nfsserver kernel: receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 000000006337c521 xid 8e5e58bd
>>> Jul 27 15:24:54 nfsserver kernel: receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000cbf89319 xid c2da3c73
>>> Jul 27 15:24:54 nfsserver kernel: receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000e2588a21 xid a01bfec6
>>> Jul 27 15:24:54 nfsserver kernel: receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 000000005fda63ca xid c2eeeaa6
>>> [...]
>>> Jul 27 15:25:15 nfsserver kernel: rcu: INFO: rcu_sched self-detected stall on CPU
>>> Jul 27 15:25:15 nfsserver kernel: rcu:         15-....: (5250 ticks this GP) idle=74e/1/0x4000000000000000 softirq=3160997/3161006 fqs=2233
>>> Jul 27 15:25:15 nfsserver kernel:         (t=5255 jiffies g=8381377 q=106333)
>>> Jul 27 15:25:15 nfsserver kernel: NMI backtrace for cpu 15
>>> Jul 27 15:25:15 nfsserver kernel: CPU: 15 PID: 3725556 Comm: kworker/u42:4 Not tainted 5.10.0-31-amd64 #1 Debian 5.10.221-1
>>> Jul 27 15:25:15 nfsserver kernel: Hardware name: DALCO AG S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
>>> Jul 27 15:25:15 nfsserver kernel: Workqueue: rpciod rpc_async_schedule [sunrpc]
>>> Jul 27 15:25:15 nfsserver kernel: Call Trace:
>>> Jul 27 15:25:15 nfsserver kernel:  <IRQ>
>>> Jul 27 15:25:15 nfsserver kernel:  dump_stack+0x6b/0x83
>>> Jul 27 15:25:15 nfsserver kernel:  nmi_cpu_backtrace.cold+0x32/0x69
>>> Jul 27 15:25:15 nfsserver kernel:  ? lapic_can_unplug_cpu+0x80/0x80
>>> Jul 27 15:25:15 nfsserver kernel:  nmi_trigger_cpumask_backtrace+0xdf/0xf0
>>> Jul 27 15:25:15 nfsserver kernel:  rcu_dump_cpu_stacks+0xa5/0xd7
>>> Jul 27 15:25:15 nfsserver kernel:  rcu_sched_clock_irq.cold+0x202/0x3d9
>>> Jul 27 15:25:15 nfsserver kernel:  ? trigger_load_balance+0x5a/0x220
>>> Jul 27 15:25:15 nfsserver kernel:  update_process_times+0x8c/0xc0
>>> Jul 27 15:25:15 nfsserver kernel:  tick_sched_handle+0x22/0x60
>>> Jul 27 15:25:15 nfsserver kernel:  tick_sched_timer+0x65/0x80
>>> Jul 27 15:25:15 nfsserver kernel:  ? tick_sched_do_timer+0x90/0x90
>>> Jul 27 15:25:15 nfsserver kernel:  __hrtimer_run_queues+0x127/0x280
>>> Jul 27 15:25:15 nfsserver kernel:  hrtimer_interrupt+0x110/0x2c0
>>> Jul 27 15:25:15 nfsserver kernel:  __sysvec_apic_timer_interrupt+0x5c/0xe0
>>> Jul 27 15:25:15 nfsserver kernel:  asm_call_irq_on_stack+0xf/0x20
>>> Jul 27 15:25:15 nfsserver kernel:  </IRQ>
>>> Jul 27 15:25:15 nfsserver kernel:  sysvec_apic_timer_interrupt+0x72/0x80
>>> Jul 27 15:25:15 nfsserver kernel:  asm_sysvec_apic_timer_interrupt+0x12/0x20
>>> Jul 27 15:25:15 nfsserver kernel: RIP: 0010:mod_delayed_work_on+0x5d/0x90
>>> Jul 27 15:25:15 nfsserver kernel: Code: 00 4c 89 e7 e8 34 fe ff ff 89 c3 83 f8 f5 74 e9 85 c0 78 1b 89 ef 4c 89 f1 4c 89 e2 4c 89 ee e8 f9 fc ff ff 48 8b 3c 24 57 9d <0f> 1f 44 >
>>> Jul 27 15:25:15 nfsserver kernel: RSP: 0018:ffffb5efe356fd90 EFLAGS: 00000246
>>> Jul 27 15:25:15 nfsserver kernel: RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000003820000f
>>> Jul 27 15:25:15 nfsserver kernel: RDX: 0000000038000000 RSI: 0000000000000046 RDI: 0000000000000246
>>> Jul 27 15:25:15 nfsserver kernel: RBP: 0000000000002000 R08: ffffffffc0884430 R09: ffffffffc0884448
>>> Jul 27 15:25:15 nfsserver kernel: R10: 0000000000000003 R11: 0000000000000003 R12: ffffffffc0884428
>>> Jul 27 15:25:15 nfsserver kernel: R13: ffff8c89d0f6b800 R14: 00000000000001f4 R15: 0000000000000000
>>> Jul 27 15:25:15 nfsserver kernel:  __rpc_sleep_on_priority_timeout+0x111/0x120 [sunrpc]
>>> Jul 27 15:25:15 nfsserver kernel:  rpc_delay+0x56/0x90 [sunrpc]
>>> Jul 27 15:25:15 nfsserver kernel:  rpc_exit_task+0x5a/0x140 [sunrpc]
>>> Jul 27 15:25:15 nfsserver kernel:  ? __rpc_do_wake_up_task_on_wq+0x1e0/0x1e0 [sunrpc]
>>> Jul 27 15:25:15 nfsserver kernel:  __rpc_execute+0x6d/0x410 [sunrpc]
>>> Jul 27 15:25:15 nfsserver kernel:  rpc_async_schedule+0x29/0x40 [sunrpc]
>>> Jul 27 15:25:15 nfsserver kernel:  process_one_work+0x1b3/0x350
>>> Jul 27 15:25:15 nfsserver kernel:  worker_thread+0x53/0x3e0
>>> Jul 27 15:25:15 nfsserver kernel:  ? process_one_work+0x350/0x350
>>> Jul 27 15:25:15 nfsserver kernel:  kthread+0x118/0x140
>>> Jul 27 15:25:15 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
>>> Jul 27 15:25:15 nfsserver kernel:  ret_from_fork+0x1f/0x30
>>> [...]
>>>
>>> Is there anything which could help debug this issue?
>>
>> The backtrace suggests an issue in the RPC client code; the
>> server's NFSv4.1 backchannel would use that to send callbacks.
>>
>> Since 5.10.218 and 5.10.221 are only about a thousand commits
>> apart, a bisect should be quick and narrow down the issue to
>> one or two commits.
> 
> Yes indeed. Unfortunately was yet unable to reproduce the issue in
> more syntentic way on test environment, and the affected server in
> particular is a production system.
> 
> Paul, is your case in some way reproducible in a testing environment
> so that a bisection might be give enough hints on the problem?
We hit this issue once more on the same server with Linux 5.15.160, and 
had to hard reboot it.

Unfortunately we did not have time yet to set up a test system to find a 
reproducer. In our cases a lot of compute servers seem to have accessed 
the NFS server. A lot of the many processes were `zstd` on a first glance.


Kind regards,

Paul

