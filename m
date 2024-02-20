Return-Path: <linux-nfs+bounces-2037-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1C985C3F5
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Feb 2024 19:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F40A286C6E
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Feb 2024 18:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B947867A;
	Tue, 20 Feb 2024 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3YlRuZ9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CAA76052
	for <linux-nfs@vger.kernel.org>; Tue, 20 Feb 2024 18:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708455040; cv=none; b=IL5sl1zzqFyuSf7ihQRK4/tutdZ7LEtubgI4a1sBsutWFWX96uxvUsOd3LPlf6/uDIvK0t2fF/AZk1A4xmid9gZfAmURxSDx15TymEMaWGeFERzenZvAZATg7WCq3R3X5iOJB7H0rypTwRq9+K8Ig/NCxGyCyUjOVzhF/IMkDxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708455040; c=relaxed/simple;
	bh=ylacf43UY9C/JWa3PBjpEJclHzkTec9Tz6egmqLQu4k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Ub0s6QujghG5b+iXuJiRGZ9rQPlMVAcMj9SJUOrsamsDDlka7qqGrD8rLJXlhXpi/tCk/d7ymSrClHaM+3YjPMOl4IcFs6YyANCwsRcVHizjZwG9PyTyGzXb4m59LSYdFbsdRUzJ5zHHb1DXvZkSY2eYWNWhNrIIGPnTZKo25c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3YlRuZ9; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-564a05ab3efso2979698a12.0
        for <linux-nfs@vger.kernel.org>; Tue, 20 Feb 2024 10:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708455036; x=1709059836; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mmVPGxDQj2WLkxeXq+E71L/WOSbOjobujpEEvi7bE30=;
        b=A3YlRuZ9bVRYNqsP+fI1aX6AfEInvKEGbP8DFGTKLN5xqkIhJ+3LbT4ZpmapzMv4fJ
         jBrEE1uXOSC4SCAp/dfSOcoO/IZMYFc0w7/keAXjysaAi9nsr26xba5T8N9GCXV4djQt
         RkE9ACfxkpS0q5QIfNvKwbyHBTuWHsUS2tLHPBTXXr7JTImrVrcNiykZlCgVh7vN8xNl
         Vzl8xWgr/rYQExSUSFuaiVYPT6slPLvXQLDSTah3/YXvcEYl1WxThZNreobOqLW3oS4p
         zejGEDiF1LqpLdp1sbK/7RVN43ESPuzHJdXxpDmK+Xj4Lr+zhxvjphAZdIMb/dZMNqSw
         oVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708455036; x=1709059836;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mmVPGxDQj2WLkxeXq+E71L/WOSbOjobujpEEvi7bE30=;
        b=DU/aYE7XPH4RZkpFPB7vJzo2gCHxPYHhhyQWdUZjaB9d4q8NYL7NaQY8MhQzGch4F+
         /zBcuu0WP+kpxD9NO8oojPlhXXI1MhKW3GCTRkfWSZFYxidn0JaSKvpZRd0O6by1ZjaB
         heKgdBByY4GFfznKYplQpmauqV1+L1ySEbpnWa1zT6OULzC6DrdoYzd6TDLlMNHPkDmk
         E9BWi5YqTU8dRMJT08uPU9xey8qrD7jZb3M9tDAfKYjR9sGpEqKYI5eRzTasK6J6B1ox
         N3lqby6GJZ92RdidXdt9WMCoheAay+Kv2eY4okqcYhhiZ21wMJnaFnroiAP4nq4g5dvI
         pbIQ==
X-Gm-Message-State: AOJu0YzozIRKZGhw+ReVeHSDz9lia2EtJE1FJ1sRFeo0UTgp7MPYBd2O
	tgC01ybZ6cMYJ92BOH5t0gJEb5vI4q2pL4BlhCS/irMAH+77IlA9UrnjI4tZx0Ou+0DJdX3zO4K
	JkUjOqTj9xeZQ6EX5h3Mz9bNeR3TOpOLlZg/U0Q==
X-Google-Smtp-Source: AGHT+IF+PNX6VJl3dOUkFVHaYFOyL0yfbYCRltmLH40vPGWr3MvUikYBCGFBUM7TvyDZExQzBKuSdIXITEU8pdQaRhg=
X-Received: by 2002:a17:906:3d41:b0:a3d:b7e1:2670 with SMTP id
 q1-20020a1709063d4100b00a3db7e12670mr9278607ejf.14.1708455035863; Tue, 20 Feb
 2024 10:50:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hari <hhsubra@gmail.com>
Date: Tue, 20 Feb 2024 10:50:23 -0800
Message-ID: <CAHrBo4v_arroQ5pC2xS9PK2xsAm4O-X75zinDgKSBDSitbWuYw@mail.gmail.com>
Subject: NFS4ERR_MOVED causing crash/stuck operations at source
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I am working on a  prototype server implementation of
Referral/Migration.  i have the following questions based on my issues
listed below:

1. How the Linux client will handle more than one NFS4ERR_MOVED error
code. During the first error exchange between the client and server
the connection to the destination is established. but on subsequent
exchanges  these are the following issues

- Client crash after migration to destination
- Error with regards to state migration in DMESG logs
- Stuck operations at the source

2. Is it mandatory to have a state shared between source and
destination in a migration scenario using NFS4ERR_MOVED. Because i
don't see code in linux client which does reclaim opens/locks after
migrating to destination.


Issue 1:
Crash if more than one NFS4ERR_MOVED is reported

Step 1: On going traffic in source server

step 2: Detect migration in server and return NFS4ERR_MOVED to client

step 3: The client requests either a GETATTR or LOOKUP to query FS_LOCATION

step 4: The server returns the FS_LOCATION

step 5: The client connects to the server mentioned in FS_LOCATION

step 6: Traffic is established with destination


I am seeing there is a crash in between step 4 and 5 if there is more
than one NFS4ERR_MOVED error returned from the server because the
traffic from the application does not stop because there are more than
one mounts.  I am seeing the following error message in DMESG logs and
there is also an observable client crash with the stack below


[ 2357.266551] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[ 2357.266558] <-- nfs4_try_migration: migration succeeded
[ 2357.266561] --> nfs4_alloc_slot used_slots=0000
highest_used=4294967295 max_slots=16
[ 2357.266562] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
[ 2357.266828] nfs4_handle_migration: migration reported on "xxx.test.net"
[ 2357.266836] RPC:       xs_tcp_send_request(208) = 0
[ 2357.266836] --> nfs41_call_sync_prepare data->seq_server 000000000004335e
[ 2357.266839] --> nfs4_alloc_slot used_slots=1ffff highest_used=16 max_slots=64
[ 2357.266937] BUG: kernel NULL pointer dereference, address: 00000000000004c8

[ 2357.266938] encode_sequence: sessionid=5:0:532:824967168 seqid=1
slotid=24 max_slotid=24 cache_this=0
[ 2357.266942] --> nfs41_call_sync_prepare data->seq_server 000000000004335e
[ 2357.266944] RPC:       xs_tcp_send_request(208) = 0
[ 2357.266950] --> nfs41_call_sync_prepare data->seq_server 000000000004335e
[ 2357.271491] RPC:       xs_tcp_state_change client 000000002c9924cf...
[ 2357.271492] RPC:       state 8 conn 1 dead 0 zapped 1 sk_shutdown 1
[ 2357.271494] RPC:       xs_data_ready...
[ 2357.619199] nfs4_close_prepare: begin!
[ 2357.619203] BUG: kernel NULL pointer dereference, address: 00000000000004c8
[ 2357.619204] #PF: supervisor read access in kernel mode
[ 2357.619205] #PF: error_code(0x0000) - not-present page
[ 2357.619207] PGD 11b74f067 P4D 12876b067 PUD 128771067 PMD 0
[ 2357.619210] Oops: 0000 [#2] SMP NOPTI
[ 2357.619212] CPU: 3 PID: 101 Comm: kworker/u8:1 Kdump: loaded
Tainted: G      D           5.15.0-1052-azure #60~20.04.1-Ubuntu
[ 2357.619215] Hardware name: Microsoft Corporation Virtual
Machine/Virtual Machine, BIOS 090008  12/07/2018
[ 2357.619216] Workqueue: rpciod rpc_async_schedule [sunrpc]
[ 2357.619254] RIP: 0010:xprt_release+0x115/0x140 [sunrpc]
[ 2357.619276] Code: 89 f7 48 8b 40 20 e8 7a c5 9e d1 41 5c 41 5d 41
5e 41 5f 5d c3 cc cc cc cc 48 83 bf a8 00 00 00 00 74 e8 48 8b bf b0
00 00 00 <4c> 3b af c8 04 00 00 75 d8 4c 89 ee e8 1a e4 ff ff eb ce 4c
89 e7
[ 2357.619278] RSP: 0018:ff5867500034bdb0 EFLAGS: 00010286
[ 2357.619280] RAX: 0000000000000005 RBX: ff20d0a84de34630 RCX: 0000000000000000
[ 2357.619281] RDX: 0000000000000000 RSI: ff20d0a8585ef070 RDI: 0000000000000000
[ 2357.619282] RBP: ff5867500034bdd0 R08: 0000000001000000 R09: 0000000000000012
[ 2357.619283] R10: ffffffff93e0a0ec R11: 0000000093e0a0cf R12: 0000000000000000
[ 2357.619284] R13: ff20d0a84de34600 R14: 0000000000000001 R15: ff20d0a84003d000
[ 2357.619285] FS:  0000000000000000(0000) GS:ff20d0abefd80000(0000)
knlGS:0000000000000000
[ 2357.619286] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2357.619287] CR2: 00000000000004c8 CR3: 00000001186de005 CR4: 0000000000371ee0
[ 2357.619289] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2357.619290] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[ 2357.619291] Call Trace:
[ 2357.619293]  <TASK>
[ 2357.619295]  ? show_regs.cold+0x1a/0x1f
[ 2357.619299]  ? __die_body+0x20/0x70
[ 2357.619302]  ? __die+0x2b/0x37
[ 2357.619304]  ? page_fault_oops+0x136/0x2b0
[ 2357.619309]  ? do_user_addr_fault+0x2f2/0x640
[ 2357.619311]  ? _raw_spin_unlock_irqrestore+0xe/0x20
[ 2357.619314]  ? down_trylock+0x2e/0x40
[ 2357.619316]  ? irq_work_queue+0xe/0x30
[ 2357.619320]  ? exc_page_fault+0x71/0x160
[ 2357.619322]  ? asm_exc_page_fault+0x27/0x30
[ 2357.619324]  ? xprt_release+0x115/0x140 [sunrpc]
[ 2357.619346]  rpc_release_resources_task+0x13/0x60 [sunrpc]
[ 2357.619368]  __rpc_execute+0x22d/0x420 [sunrpc]
[ 2357.619390]  rpc_async_schedule+0x30/0x50 [sunrpc]
[ 2357.619409]  process_one_work+0x225/0x3d0
[ 2357.619412]  worker_thread+0x4d/0x3e0
[ 2357.619414]  ? process_one_work+0x3d0/0x3d0
[ 2357.619415]  kthread+0x12a/0x150
[ 2357.619417]  ? set_kthread_struct+0x50/0x50
[ 2357.619418]  ret_from_fork+0x22/0x30
[ 2357.619422]  </TASK>
[ 2357.619422] Modules linked in: nfnetlink rpcsec_gss_krb5
auth_rpcgss nfsv4 nfs lockd grace fscache netfs nls_iso8859_1
dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua mlx5_ib ib_uverbs
ib_core kvm_intel mlx5_core kvm binfmt_misc tls crct10dif_pclmul
joydev mlxfw crc32_pclmul psample hid_generic ghash_clmulni_intel
xt_conntrack aesni_intel crypto_simd nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 hyperv_drm cryptd drm_kms_helper libcrc32c xt_owner
iptable_security xt_tcpudp syscopyarea bpfilter sysfillrect sysimgblt
fb_sys_fops cec hyperv_keyboard hid_hyperv rc_core serio_raw hv_netvsc
pata_acpi hid sch_fq_codel msr drm efi_pstore i2c_core sunrpc
ip_tables x_tables autofs4
[ 2357.619458] CR2: 00000000000004c8
[ 2357.619459] ---[ end trace 8bb4378aaa5cb3ed ]---
[ 2357.619460] RIP: 0010:xprt_release+0x115/0x140 [sunrpc]
[ 2357.619483] Code: 89 f7 48 8b 40 20 e8 7a c5 9e d1 41 5c 41 5d 41
5e 41 5f 5d c3 cc cc cc cc 48 83 bf a8 00 00 00 00 74 e8 48 8b bf b0
00 00 00 <4c> 3b af c8 04 00 00 75 d8 4c 89 ee e8 1a e4 ff ff eb ce 4c
89 e7
[ 2357.619484] RSP: 0018:ff5867500836fdb0 EFLAGS: 00010286
[ 2357.619485] RAX: 0000000000000005 RBX: ff20d0a85b0a2030 RCX: 0000000000000000
[ 2357.619486] RDX: 0000000000000000 RSI: ff20d0a8585cdc70 RDI: 0000000000000000
[ 2357.619487] RBP: ff5867500836fdd0 R08: 0000000001000000 R09: 0000000000000001
[ 2357.619488] R10: ffffffff93e06d5c R11: 0000000093e06d3f R12: 0000000000000000
[ 2357.619488] R13: ff20d0a85b0a2000 R14: 0000000000000001 R15: ff20d0a84003d000
[ 2357.619489] FS:  0000000000000000(0000) GS:ff20d0abefd80000(0000)
knlGS:0000000000000000
[ 2357.619490] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2357.619491] CR2: 00000000000004c8 CR3: 00000001186de005 CR4: 0000000000371ee0
[ 2357.619492] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2357.619492] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[ 2357.619494] Kernel panic - not syncing: Fatal exception
[ 2357.640366] Kernel Offset: 0xfc00000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)


Issue 2:

In my implementation we don't share the state between the source and
destination. the destination returns a different scope. The client
does not seem to reopen the files or regain the locks. you can see
that XID (0x9658e553) that a write which had the lock id from source
was retried in destination, since we did not share the state we
returned BAD_STATEID.



No. Time                                  XID
         SessionId Info
3 2023-03-16 11:04:27.833041 0x62ddeac9 (1658710729)
0200000000000000fd6c00000000d0b2 V4 Call (Reply In 4) GETATTR FH:
0x1b6911b1
4 2023-03-16 11:04:27.924840 0x62ddeac9 (1658710729)
0200000000000000fd6c00000000d0b2 V4 Reply (Call In 3) GETATTR
6 2023-03-16 11:04:27.925211 0x63ddeac9 (1675487945)
0200000000000000fd6c00000000d0b2 V4 Call (Reply In 7) OPEN DH:
0xa27a003d/
7 2023-03-16 11:04:28.015350 0x63ddeac9 (1675487945)
0200000000000000fd6c00000000d0b2 V4 Reply (Call In 6) OPEN StateID:
0xb4d2
9 2023-03-16 11:04:28.015722 0x64ddeac9 (1692265161)
0200000000000000fd6c00000000d0b2 V4 Call (Reply In 10) READ StateID:
0xb17f Offset: 0 Len: 13336
10 2023-03-16 11:04:28.113724 0x64ddeac9 (1692265161)
0200000000000000fd6c00000000d0b2 V4 Reply (Call In 9) READ
12 2023-03-16 11:04:28.114343 0x65ddeac9 (1709042377)
0200000000000000fd6c00000000d0b2 V4 Call (Reply In 13) ACCESS FH:
0xa27a003d, [Check: RD MD XT XE]
13 2023-03-16 11:04:28.198397 0x65ddeac9 (1709042377)
0200000000000000fd6c00000000d0b2 V4 Reply (Call In 12) ACCESS,
[Allowed: RD MD XT XE]
14 2023-03-16 11:04:28.199844 0x66ddeac9 (1725819593)
0200000000000000fd6c00000000d0b2 V4 Call (Reply In 15) OPEN DH:
0x1b6911b1/test
15 2023-03-16 11:04:28.292948 0x66ddeac9 (1725819593)
0200000000000000fd6c00000000d0b2 V4 Reply (Call In 14) OPEN StateID:
0x0560
16 2023-03-16 11:04:28.294161 0x67ddeac9 (1742596809)
0200000000000000fd6c00000000d0b2 V4 Call (Reply In 17) LOCK FH:
0x256514d0 Offset: 0 Length: 512
17 2023-03-16 11:04:28.384516 0x67ddeac9 (1742596809)
0200000000000000fd6c00000000d0b2 V4 Reply (Call In 16) LOCK
18 2023-03-16 11:04:28.385153 0x68ddeac9 (1759374025)
0200000000000000fd6c00000000d0b2 V4 Call (Reply In 19) WRITE StateID:
0x0427 Offset: 0 Len: 512
19 2023-03-16 11:04:28.483614 0x68ddeac9 (1759374025)
0200000000000000fd6c00000000d0b2 V4 Reply (Call In 18) WRITE
25 2023-03-16 11:05:50.021966 0x69ddeac9 (1776151241)
0200000000000000fd6c00000000d0b2 V4 Call (Reply In 26) SEQUENCE
26 2023-03-16 11:05:50.103301 0x69ddeac9 (1776151241)
0200000000000000fd6c00000000d0b2 V4 Reply (Call In 25) SEQUENCE
152 2023-03-16 11:30:24.662815 0x7bddeac9 (2078141129)
0200000000000000fd6c00000000d0b2 V4 Reply (Call In 151) SEQUENCE
158 2023-03-16 11:31:44.082416 0x7cddeac9 (2094918345)
0200000000000000fd6c00000000d0b2 V4 Call (Reply In 160) WRITE StateID:
0x0427 Offset: 0 Len: 512
160 2023-03-16 11:31:46.247001 0x7cddeac9 (2094918345)
0200000000000000fd6c00000000d0b2 V4 Reply (Call In 158) WRITE Status:
NFS4ERR_MOVED
162 2023-03-16 11:31:46.247767 0x7dddeac9 (2111695561)
0200000000000000fd6c00000000d0b2 V4 Call (Reply In 164) GETATTR FH:
0x1b6911b1
164 2023-03-16 11:31:48.380479 0x7dddeac9 (2111695561)
0200000000000000fd6c00000000d0b2 V4 Reply (Call In 162) GETATTR
169 2023-03-16 11:31:48.492833 0x888e97f8 (2291046392) V4 NULL Call
(Reply In 170)
170 2023-03-16 11:31:48.573895 0x888e97f8 (2291046392) V4 NULL Reply
(Call In 169)
172 2023-03-16 11:31:48.574337 0x898e97f8 (2307823608) V4 Call (Reply
In 174) EXCHANGE_ID
174 2023-03-16 11:31:48.728966 0x898e97f8 (2307823608) V4 Reply (Call
In 172) EXCHANGE_ID
176 2023-03-16 11:31:48.729335 0x8a8e97f8 (2324600824) V4 Call (Reply
In 177) EXCHANGE_ID
177 2023-03-16 11:31:48.825899 0x8a8e97f8 (2324600824) V4 Reply (Call
In 176) EXCHANGE_ID
179 2023-03-16 11:31:48.826418 0x8b8e97f8 (2341378040) V4 Call (Reply
In 180) CREATE_SESSION
180 2023-03-16 11:31:48.915687 0x8b8e97f8 (2341378040)
02000000000000007c0800000000d0b2 V4 Reply (Call In 179) CREATE_SESSION
181 2023-03-16 11:31:48.916179 0x8c8e97f8 (2358155256)
02000000000000007c0800000000d0b2 V4 Call (Reply In 182)
RECLAIM_COMPLETE
182 2023-03-16 11:31:49.004744 0x8c8e97f8 (2358155256)
02000000000000007c0800000000d0b2 V4 Reply (Call In 181)
RECLAIM_COMPLETE
187 2023-03-16 11:31:49.088286 0x9458e553 (2488853843)
02000000000000007c0800000000d0b2 V4 Call (Reply In 189) GETATTR FH:
0x1b6911b1
189 2023-03-16 11:31:50.184343 0x9458e553 (2488853843)
02000000000000007c0800000000d0b2 V4 Reply (Call In 187) GETATTR
191 2023-03-16 11:31:50.184800 0x9558e553 (2505631059)
02000000000000007c0800000000d0b2 V4 Call (Reply In 192) GETATTR FH:
0x1b6911b1
192 2023-03-16 11:31:50.277471 0x9558e553 (2505631059)
02000000000000007c0800000000d0b2 V4 Reply (Call In 191) GETATTR
194 2023-03-16 11:31:50.277744 0x7eddeac9 (2128472777)
0200000000000000fd6c00000000d0b2 V4 Call (Reply In 196)
DESTROY_SESSION
195 2023-03-16 11:31:50.278013 0x9658e553 (2522408275)
02000000000000007c0800000000d0b2 V4 Call (Reply In 199) WRITE StateID:
0x0427 Offset: 0 Len: 512
196 2023-03-16 11:31:50.360818 0x7eddeac9 (2128472777) V4 Reply (Call
In 194) DESTROY_SESSION
198 2023-03-16 11:31:50.361088 0x7fddeac9 (2145249993) V4 Call (Reply
In 204) DESTROY_CLIENTID
199 2023-03-16 11:31:50.362113 0x9658e553 (2522408275)
02000000000000007c0800000000d0b2 V4 Reply (Call In 195) WRITE Status:
NFS4ERR_BAD_STATEID
201 2023-03-16 11:31:50.362740 0x9758e553 (2539185491)
02000000000000007c0800000000d0b2 V4 Call (Reply In 202) TEST_STATEID
202 2023-03-16 11:31:50.445104 0x9758e553 (2539185491)
02000000000000007c0800000000d0b2 V4 Reply (Call In 201) TEST_STATEID
203 2023-03-16 11:31:50.445737 0x9858e553 (2555962707)
02000000000000007c0800000000d0b2 V4 Call (Reply In 207) TEST_STATEID
204 2023-03-16 11:31:50.450554 0x7fddeac9 (2145249993) V4 Reply (Call
In 198) DESTROY_CLIENTID
207 2023-03-16 11:31:50.528249 0x9858e553 (2555962707)
02000000000000007c0800000000d0b2 V4 Reply (Call In 203) TEST_STATEID
208 2023-03-16 11:31:50.528565 0x9958e553 (2572739923)
02000000000000007c0800000000d0b2 V4 Call (Reply In 212) OPEN DH:
0x256514d0/
212 2023-03-16 11:31:50.702049 0x9958e553 (2572739923)
02000000000000007c0800000000d0b2 V4 Reply (Call In 208) OPEN StateID:
0x47d1
213 2023-03-16 11:31:50.702551 0x9a58e553 (2589517139)
02000000000000007c0800000000d0b2 V4 Call (Reply In 214) GETATTR FH:
0x256514d0
214 2023-03-16 11:31:50.791465 0x9a58e553 (2589517139)
02000000000000007c0800000000d0b2 V4 Reply (Call In 213) GETATTR
218 2023-03-16 11:32:10.792955 0x9b58e553 (2606294355)
02000000000000007c0800000000d0b2 V4 Call (Reply In 219) GETATTR FH:
0x256514d0
219 2023-03-16 11:32:10.878344 0x9b58e553 (2606294355)
02000000000000007c0800000000d0b2 V4 Reply (Call In 218) GETATTR

Any kind of pointers would be greatly appreciated. Thanks for your help.

--
-> hari
Success and defeat add beauty to a warrior

