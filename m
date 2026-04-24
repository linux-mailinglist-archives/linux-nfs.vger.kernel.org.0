Return-Path: <linux-nfs+bounces-21075-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SC48JeIX62n2IQAAu9opvQ
	(envelope-from <linux-nfs+bounces-21075-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Apr 2026 09:12:34 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3259A45A940
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Apr 2026 09:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E4E130058FA
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Apr 2026 07:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78B6370D41;
	Fri, 24 Apr 2026 07:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b="Tnt3Fmbe";
	dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b="ztH2gnks"
X-Original-To: linux-nfs@vger.kernel.org
Received: from icts-p-cavspool-1.kulnet.kuleuven.be (icts-p-cavspool-1.kulnet.kuleuven.be [134.58.240.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDA436DA0D
	for <linux-nfs@vger.kernel.org>; Fri, 24 Apr 2026 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.58.240.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777014741; cv=none; b=c38uJYPx5Ss7ZIiL4kfnUodQx8SOlK1NPivT1stpXZNey6FVyle9WEGYuHJXZeTNPUlCnNraN17BE+V0KujYNcvVCwEx7APGh/EqL/QBJz39HwD/LN6dkTUygeYnfHeXmPNkJgiex5uu7VZLOYtbAt2lMQHgKKHt9YQDZSCgGA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777014741; c=relaxed/simple;
	bh=9BJ7qFJwCvw78rYSOp4AxcpgubWfMUVQQWvKwmc8OSA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=nmNusj4BnRX7ighL6MGOTHQzr6bh2saDVWWgJeR9GuTfW5qxJfCAyllw8NtOVQRpzmkGi5DLk0rK22bt03Zi91uaFNBVv32kfGX5VaImx3YjW3/4js+OJi0gU1WRZHplqhWEQcPX2hsy9hY8Xvh0a0a7+KmWMxt/HM+Pc1VP5cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be; spf=pass smtp.mailfrom=esat.kuleuven.be; dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b=Tnt3Fmbe; dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b=ztH2gnks; arc=none smtp.client-ip=134.58.240.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esat.kuleuven.be
Received: from icts-p-cavuit-3.kulnet.kuleuven.be (icts-p-cavuit-3.kulnet.kuleuven.be [134.58.240.133])
	by icts-p-cavspool-1.kulnet.kuleuven.be (Postfix) with ESMTP id 8A7485DCA
	for <linux-nfs@vger.kernel.org>; Fri, 24 Apr 2026 09:12:13 +0200 (CEST)
X-KULeuven-Envelope-From: rik.theys@esat.kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 30048200AC.A649A
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:140::23])
	by icts-p-cavuit-3.kulnet.kuleuven.be (Postfix) with ESMTP id 30048200AC
	for <linux-nfs@vger.kernel.org>; Fri, 24 Apr 2026 09:12:04 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#OURIPS#-35.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
	s=kuleuven-cav-1; t=1777014723;
	bh=lrZXWZChisso77PMvhF/KLFeEW3k+0jWdx3f5GtbyaU=;
	h=Date:From:Subject:To;
	b=Tnt3FmbeFDw9Y1DMEBE/WFZa9y0TcIt+Ub42MMtdUGi/Ed8jA6shXHkLm10+rNAAb
	 1PXwg9spzvX4CsVgk5iYN2bDpz0GEVW9aBLo7hYbgDERjX9k0cjQoEzqp+dAolXIp0
	 wAzM7CWRIsjI2rtcEhrjWtw+3iC0SjWu3ewv+h4/K7SKEZww+MfPnqvAfmq4pP9oz+
	 4uFZKCT5V9SCls/dGo+4EBaMU+fKiv1EujMtVTi/Vl4ZIXUMuFE9lX/yvAAeQLcAHx
	 hm/LCH4/tnfZ+6C+w919GxUKqJBgvA4xAHJPfDyrgnFxDQ3yF6OwAxQFlW1ShyK0Jn
	 6Ns77Lyp51aDw==
Received: from hydrogen.esat.kuleuven.be (hydrogen.esat.kuleuven.be [134.58.56.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPS id E8D2AD4CE188B
	for <linux-nfs@vger.kernel.org>; Fri, 24 Apr 2026 09:12:03 +0200 (CEST)
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=esat.kuleuven.be;
	s=esat20220324; t=1777014723;
	bh=lrZXWZChisso77PMvhF/KLFeEW3k+0jWdx3f5GtbyaU=;
	h=Date:From:Subject:To:From;
	b=ztH2gnksZ48OjUXsSZY/7vO5+3k0+v/ZIIqe1N0Xl/xkN14StgOmYl/4zVzqYRPE6
	 sN8QSB191uqJ8ggV75C3O6fqdrTSGNjbjCkkM+6n3wAGZoWMEwkkqX3oi1eawrabCA
	 IXPyJvUZ0GHXR2dUO9QsHs9akEqwcctmgqwUbf+nsdyAtWoIuCDW9R38aw8eHftX8Y
	 QSdOiV+o+SPsH0XmeXI0tLlEttzOLtgtPkz2J7DPpFnQUn1vxqCG7Ak7zkYl4rAWsP
	 U5XtbKQfpVYpnoXCfXFp3ZDq2X0+KxtOACYq+QFWUehcJkY0urRSFp/B4279vsz2UY
	 7xEX6tcv68pLg==
Received: from [192.168.1.113] (d54C377C4.access.telenet.be [84.195.119.196])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by hydrogen.esat.kuleuven.be (Postfix) with ESMTPSA id D58932000B
	for <linux-nfs@vger.kernel.org>; Fri, 24 Apr 2026 09:12:03 +0200 (CEST)
Message-ID: <f32822c8-9910-43a1-8d7f-72df6b79a1e8@esat.kuleuven.be>
Date: Fri, 24 Apr 2026 09:12:03 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Rik Theys <Rik.Theys@esat.kuleuven.be>
Subject: processes in D state / blocked tasks
To: Linux Nfs <linux-nfs@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3259A45A940
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[esat.kuleuven.be,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kuleuven.be:s=kuleuven-cav-1,esat.kuleuven.be:s=esat20220324];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21075-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[kuleuven.be:+,esat.kuleuven.be:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,esat.kuleuven.be:dkim,esat.kuleuven.be:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Rik.Theys@esat.kuleuven.be,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Hi,

Since a few weeks some of our numbercrunchers are periodically logging 
blocked tasks and the NFS client seems to (at least partially) hang. The 
client is currently running upstream 6.18.20 on a Rocky 9 userland. The 
server is a RHEL10 running 6.12.0-124.45.1.el10_1.x86_64.

Most likely the reason we are seeing this come up now is that more users 
are starting to use the shared server and it frequently comes under high 
memory pressure.

We are seeing similar issues on Rocky 8 servers running 
4.18.0-553.117.1.el8_10.x86_64.

On one of the Rocky 9 servers running 6.18.20, the following blocked 
tasks are logged:

INFO: task node:1646922 blocked for more than 122 seconds.
      Tainted: G            E       6.18.20-1.el9.esat.x86_64 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:node            state:D stack:0     pid:1646922 tgid:1646922 
ppid:1646730 task_flags:0x400000 flags:0x00080001
Call Trace:
<TASK>
__schedule+0x282/0x600
? select_idle_sibling+0x27/0x4c0
? terminate_walk+0xef/0x100
schedule+0x26/0x90
io_schedule+0x42/0x70
folio_wait_bit_common+0x127/0x360
? _raw_spin_unlock_irqrestore+0x23/0x40
? __pfx_wake_page_function+0x10/0x10
folio_wait_writeback+0x27/0x80
__filemap_get_folio+0x250/0x330
nfs_write_begin+0xa1/0x3e0 [nfs]
generic_perform_write+0x89/0x290
? nfs_ctx_key_to_expire+0xd3/0x120 [nfs]
nfs_file_write+0x1e7/0x2f0 [nfs]
vfs_write+0x31f/0x430
ksys_write+0x61/0xe0
do_syscall_64+0x61/0x12d0
entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7fbe608ff15f
RSP: 002b:00007ffda1c8f410 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000034979e10 RCX: 00007fbe608ff15f
RDX: 00000000000002e3 RSI: 000000002c7b5b50 RDI: 000000000000002c
RBP: 00000000000002e3 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000010 R11: 0000000000000293 R12: 00000000000002e3
R13: 000000002c7b5b50 R14: 00000000000002e3 R15: 00007fbe609f69e0
</TASK>

The taint seems to come from the fuse module.

INFO: task libuv-worker:474227 blocked for more than 122 seconds.
      Tainted: G            E       6.18.20-1.el9.esat.x86_64 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:libuv-worker    state:D stack:0     pid:474227 tgid:474198 
ppid:474192 task_flags:0x400040 flags:0x00080001
Call Trace:
<TASK>
__schedule+0x282/0x600
schedule+0x26/0x90
__wait_on_freeing_inode+0xb9/0x110
? __pfx_var_wake_function+0x10/0x10
? __pfx_nfs_find_actor+0x10/0x10 [nfs]
find_inode+0xa3/0xf0
? __pfx_nfs_find_actor+0x10/0x10 [nfs]
ilookup5_nowait+0x74/0xa0
? __pfx_nfs_find_actor+0x10/0x10 [nfs]
ilookup5+0x44/0x110
? _kstrtoull+0x3a/0x90
? nfs_map_string_to_numeric+0x7f/0xa0 [nfsv4]
? __pfx_nfs_find_actor+0x10/0x10 [nfs]
? __pfx_nfs_init_locked+0x10/0x10 [nfs]
iget5_locked+0x26/0x80
nfs_fhget+0xe6/0x7e0 [nfs]
_nfs4_opendata_to_nfs4_state+0x16b/0x220 [nfsv4]
_nfs4_open_and_get_state+0xc3/0x2c0 [nfsv4]
? __pfx_nfs_alloc_no_seqid+0x10/0x10 [nfsv4]
? nfs4_opendata_alloc+0x26d/0x400 [nfsv4]
_nfs4_do_open.isra.0+0x167/0x470 [nfsv4]
? obj_cgroup_charge_account+0x9f/0x2a0
nfs4_do_open+0xcc/0x210 [nfsv4]
nfs4_atomic_open+0x11b/0x130 [nfsv4]
? alloc_nfs_open_context+0x2a/0x150 [nfs]
nfs_atomic_open+0x227/0x6a0 [nfs]
lookup_open.isra.0+0x241/0x6d0
? __d_lookup+0x72/0xb0
open_last_lookups+0x1f6/0x470
path_openat+0x83/0x270
do_filp_open+0xbd/0x170
? __virt_addr_valid+0xf9/0x170
? check_heap_object+0x33/0x190
? preempt_count_add+0x69/0xa0
? path_get+0x11/0x30
? _raw_spin_unlock+0x15/0x30
? audit_alloc_name+0x12f/0x140
? alloc_fd+0xae/0x110
do_sys_openat2+0x71/0xd0
__x64_sys_openat+0x52/0xa0
do_syscall_64+0x61/0x12d0
entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f84d0efee54
RSP: 002b:00007f84a97bdb60 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f84a97be470 RCX: 00007f84d0efee54
RDX: 0000000000080000 RSI: 000000001a1d3210 RDI: 00000000ffffff9c
RBP: 000000001a1d3210 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000080000
R13: 0000000000000019 R14: 000000001a95a4c0 R15: 000000001a95a4c0
</TASK>

The system starts to build up a lot of processes in uninterruptable 
sleep (D). When I look at the output of

ps -e -o state,pid,user,cmd,wchan | grep ^D

it seems most of these blocked processes are waiting in 
rpc_wait_bit_killable, some in folio_wait_bit_common and a few in 
autofs_wait.

# cat /proc/3806883/stack

[<0>] __rpc_execute+0x148/0x2e0 [sunrpc]
[<0>] rpc_execute+0x12b/0x150 [sunrpc]
[<0>] rpc_run_task+0x110/0x180 [sunrpc]
[<0>] nfs4_call_sync_sequence+0x75/0xb0 [nfsv4]
[<0>] _nfs4_proc_access+0x108/0x1a0 [nfsv4]
[<0>] nfs4_proc_access+0x66/0xf0 [nfsv4]
[<0>] nfs_do_access+0xb4/0x270 [nfs]
[<0>] nfs_permission+0x91/0x1f0 [nfs]
[<0>] inode_permission+0xe6/0x190
[<0>] link_path_walk+0x1f1/0x2a0
[<0>] path_lookupat+0x6f/0x1a0
[<0>] filename_lookup+0xdf/0x1e0
[<0>] vfs_statx+0x65/0x150
[<0>] vfs_fstatat+0x64/0xa0
[<0>] __do_sys_newfstatat+0x25/0x60
[<0>] do_syscall_64+0x61/0x12d0
[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

# cat /proc/2949346/stack

[<0>] filemap_fault+0x4b8/0xc50
[<0>] __do_fault+0x34/0x180
[<0>] do_read_fault+0x129/0x220
[<0>] do_fault+0x123/0x270
[<0>] __handle_mm_fault+0x56f/0x6b0
[<0>] handle_mm_fault+0xef/0x310
[<0>] do_user_addr_fault+0x216/0x6d0
[<0>] exc_page_fault+0x66/0x170
[<0>] asm_exc_page_fault+0x22/0x30

# cat /proc/577956/stack

[<0>] autofs_mount_wait+0x46/0xf0
[<0>] autofs_d_automount+0xd3/0x200
[<0>] __traverse_mounts+0x9c/0x260
[<0>] step_into+0x170/0x370
[<0>] link_path_walk+0x139/0x2a0
[<0>] path_openat+0x93/0x270
[<0>] do_filp_open+0xbd/0x170
[<0>] do_sys_openat2+0x71/0xd0
[<0>] __x64_sys_openat+0x52/0xa0
[<0>] do_syscall_64+0x61/0x12d0
[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e


What could cause these processes to end up in this state? Is there some 
deadlock due to memory pressure? Which information could be more useful 
to further debug this and/or make the system recover?

The server seems to be fine: there's no high load, no indications of a 
network issue and the disks are not saturated.

On the Rocky 8 system the following blocked tasks are logged:

INFO: task git:4512 blocked for more than 120 seconds.
       Not tainted 4.18.0-553.117.1.el8_10.x86_64 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:git             state:D stack:0    pid:4512  ppid:4226  
  flags:0x80000082
Call Trace:
  __schedule+0x2d1/0x870
  schedule+0x55/0xf0
  io_schedule+0x12/0x40
  wait_on_page_bit+0xfd/0x220
  ? find_get_pages_range_tag+0xd2/0x350
  ? filemap_fdatawait_keep_errors+0x50/0x50
  wait_on_page_writeback+0x2b/0x90
  __filemap_fdatawait_range+0x81/0xf0
  ? memcg_slab_free_hook+0x141/0x1b0
  filemap_write_and_wait+0x55/0x90
  nfs_wb_all+0x1a/0x120 [nfs]
  nfs4_file_flush+0x6f/0xa0 [nfsv4]
  filp_close+0x31/0x70
  put_files_struct+0x70/0xc0
  do_exit+0x32f/0xb10
  ? syscall_trace_enter+0x1ff/0x2d0
  do_group_exit+0x3a/0xa0
  __x64_sys_exit_group+0x14/0x20
  do_syscall_64+0x5b/0x1d0
  entry_SYSCALL_64_after_hwframe+0x66/0xcb
RIP: 0033:0x7fa49031a346
Code: Unable to access opcode bytes at RIP 0x7fa49031a31c.
RSP: 002b:00007ffe099b4f78 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fa4905de860 RCX: 00007fa49031a346
RDX: 0000000000000001 RSI: 000000000000003c RDI: 0000000000000001
RBP: 0000000000000001 R08: 00000000000000e7 R09: ffffffffffffff90
R10: 00007ffe099b4e7f R11: 0000000000000246 R12: 00007fa4905de860
R13: 0000000000000001 R14: 00007fa4905e7548 R15: 0000000000000000
INFO: task git:4513 blocked for more than 120 seconds.
       Not tainted 4.18.0-553.117.1.el8_10.x86_64 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:git             state:D stack:0    pid:4513  ppid:4226  
  flags:0x80000082
Call Trace:
  __schedule+0x2d1/0x870
  schedule+0x55/0xf0
  io_schedule+0x12/0x40
  wait_on_page_bit+0xfd/0x220
  ? find_get_pages_range_tag+0xd2/0x350
  ? filemap_fdatawait_keep_errors+0x50/0x50
  wait_on_page_writeback+0x2b/0x90
  __filemap_fdatawait_range+0x81/0xf0
  ? memcg_slab_free_hook+0x141/0x1b0
  filemap_write_and_wait+0x55/0x90
  nfs_wb_all+0x1a/0x120 [nfs]
  nfs4_file_flush+0x6f/0xa0 [nfsv4]
  filp_close+0x31/0x70
  put_files_struct+0x70/0xc0
  do_exit+0x32f/0xb10
  ? syscall_trace_enter+0x1ff/0x2d0
  do_group_exit+0x3a/0xa0
  __x64_sys_exit_group+0x14/0x20
  do_syscall_64+0x5b/0x1d0
  entry_SYSCALL_64_after_hwframe+0x66/0xcb
RIP: 0033:0x7fcc80c5d346
Code: Unable to access opcode bytes at RIP 0x7fcc80c5d31c.
RSP: 002b:00007ffe25bb62d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fcc80f21860 RCX: 00007fcc80c5d346
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 0000000000000000 R08: 00000000000000e7 R09: ffffffffffffff90
R10: 00007ffe25bb61df R11: 0000000000000246 R12: 00007fcc80f21860
R13: 0000000000000001 R14: 00007fcc80f2a548 R15: 0000000000000000


Regards,

Rik

-- 
Rik Theys
System Engineer
KU Leuven - Dept. Elektrotechniek (ESAT)
Kasteelpark Arenberg 10 bus 2440  - B-3001 Leuven-Heverlee
+32(0)16/32.11.07
----------------------------------------------------------------
<<Any errors in spelling, tact or fact are transmission errors>>


