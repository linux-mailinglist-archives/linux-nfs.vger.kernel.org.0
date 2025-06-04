Return-Path: <linux-nfs+bounces-12091-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3228EACE095
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 16:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04283A6D8A
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 14:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B480290BCC;
	Wed,  4 Jun 2025 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIH0tRjd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451D328DB78
	for <linux-nfs@vger.kernel.org>; Wed,  4 Jun 2025 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749048142; cv=none; b=DohCoqlMX0bOTn7rz+KFRQvZKDuEQsnDq38rJ7tOUN2QmIN89O0YuQjpGHK2G5LOC7GtJ7Ea68NwCIqGp1kQVhD6AIRu3vinOLy1IO+izG5iQAwK0hpozvIWDaz0Zk+SMrJ7uZurLYKQKVQ27AQN/k7p5B6vBz0iLCEOlsDwMyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749048142; c=relaxed/simple;
	bh=Ari2qyH7q9UIq1WSTeomYxaU/IwQD1IeuyyfLh/KUpQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=eqKszOEpVOlTTjoWwzEFboy/EtCbprR6Mh2Hea7+dZEEV17pAmYgVL8dE2jcakuu+pq9gsVbCtsrRvRQNO/brpwVr3OMkL3BYbqDBmIFkXppOBa/fC1nEGdEb225Er5saHcVyXnBcoq528iADKcSjJSQBQS1szcJIN/QkWJmirk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIH0tRjd; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a585dc5f4aso52090971cf.2
        for <linux-nfs@vger.kernel.org>; Wed, 04 Jun 2025 07:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749048138; x=1749652938; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PPSH0c9/rKyG15VSMGVUYB0GVJzBKmpWidj/ozAzYSc=;
        b=jIH0tRjdsJ3hhoVZ9PIOfCfm3p8liZFsgO8iYeqtU5C/o4dTPSZciSDtF73R2IWbZ7
         9yOhWs+4IQIz6nDV290uKkZ1Qn1lV4WzuU1BkJupCyWIORtbhMfghUDNjqF1ItYBYyQa
         U89eGIYqdqxgOxv+j2ejW4j5I6KH7eEXWoPu5JzhkqpU6SlOb7+tWvQkh0VyY50dax1r
         R7FOrAhAXumlDJA3Chk3bUZ+0Ltwqprmk+wMkue0Fsnwi7NAxCKibULHa5xdNC4ho5Kr
         kcgnbH0NkGn6Kk8RVCiLkiU8LY1KqvpRAjnMT6fa1pjGTG8YuQcxASYmNQyb4riFyvBW
         fMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749048138; x=1749652938;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PPSH0c9/rKyG15VSMGVUYB0GVJzBKmpWidj/ozAzYSc=;
        b=Up8dOvOBXgtM+WcRQETb6jzThH41lJx4POYil0hIQrpMsHpF/ysCXWuuM6Z+0RfUrg
         ZTgz7ZxdfT65P8KkKdw5uuXUew9F2Mq4rdQCiSR0Xp+vYcQbvh4ShPbg7Ynoxhhcunjp
         tyLz2OdkVQDYoc/achS3oVybpPGVAUrcqfQoznX2vxIaKw2WqMi5hcrODEWXt9T1mUIL
         9SXbcO/Hrg3QdmujSxTbrSnZedhJck74eOi7bqiDEA99VhJI+O8DP2PGrTSX590Ab4WS
         cPd1HHfdNzyil/1PWLIUi0fYnGxYmCqUYReoHHfmmRtrvojNztato6BCInbejTo/TRou
         9DhQ==
X-Gm-Message-State: AOJu0Yygsh4+H1dL/3Rnbky6EodNA+ayYAQM+XAUjTUYjvv5SLaXlG7u
	gkCsXLWVXPVerm8g5XTBvoAxzEEs8DbwhunMTqcHFZ1KWwg9KFD7xOLv97vxpHr5kNz0fYpzyK6
	sK1SK7EituffiS36xRljBRWPk32j+YrHOMjsDfEk=
X-Gm-Gg: ASbGnctLhMU7r5qgqxqnc5Q/ivOGDZ96H75GPbfm1uW3obwZ87cHcDjrdGuNsr5CQ+R
	BYfW6XBMvWjG7iwTUuRiqY49gAXroQaXFQAgrhzx/SIb5bHp389wy+zhCGKAO5Kr+3ppNFKobGU
	0gv4RnDIiWJF4gnOYQRiipvH1HelyxpT0A+prdtvsTLqU=
X-Google-Smtp-Source: AGHT+IFZnCAamhgd7QnsvBhanqO4hvX8vft35DREzrryWjlLLGcqmRuGXiPURhhagXCGNqXQ8IebjV1Fb0ma+tR7brA=
X-Received: by 2002:a05:622a:90a:b0:494:a16d:bd24 with SMTP id
 d75a77b69052e-4a5a57c0b36mr52122481cf.11.1749048136825; Wed, 04 Jun 2025
 07:42:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: lei lu <llfamsec@gmail.com>
Date: Wed, 4 Jun 2025 22:42:05 +0800
X-Gm-Features: AX0GCFtllJ-yzjIHORxaqa01P-qW_VEMNNDyw0l1n-PZR-kk-RBPrR9LgQ7uyJQ
Message-ID: <CAEBF3_awnZBTOuHvTaxzRaEO552vPgSdTL1ygGkUbenYDDS5Tg@mail.gmail.com>
Subject: [BUG] An UAF in NFSD
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Content-Type: text/plain; charset="UTF-8"

Hi all,

I found an UAF in NFSD.

- Root cause
In nfsd4_setclientid_confirm(), it calls get_client_locked() without
checking the return code. But if is_client_expired() returns true
get_client_locked() do not Increment the "cl_rpc_users" and return
"nfserr_expired". We can just decrement the "cl_rpc_users" as follow:

nfsd4_setclientid_confirm
  get_client_locked(conf)
    if (is_client_expired(clp)) return nfserr_expired --> Return
    atomic_inc(&clp->cl_rpc_users) --> Failed to increment
  ...
  put_client_renew_locked(conf)
    if (!atomic_dec_and_test(&clp->cl_rpc_users)) --> Decrement

- Case
Here is a race case, which need to interact with /proc/fs, so the impact
is limited:

compound_request[renew, time_consuming_op, ...]
Thread1
nfsd4_renew
  set_client
    cstate->clp = lookup_clientid()
      atomic_inc(cl_rpc_users) --> cl_rpc_users++
Handle time_consuming_op
  ...

        Thread2
        echo "expire" > /proc/fs/nfsd/clients/xx/ctl
        client_ctl_write
          clp = get_nfsdfs_client(file_inode(file)) --> cl_ref++
          force_expire_client
            spin_lock(&nn->client_lock)
            clp->cl_time = 0 --> Client expired
            spin_unlock(&nn->client_lock)
            wait_event(&clp->cl_rpc_users == 0) --> Wait here

        Thread2
        nfsd4_setclientid_confirm
          conf = find_confirmed_client(clid, false, nn)
          ...
          get_client_locked(conf) --> Expired, do nothing
          ...
          put_client_renew_locked(conf) --> cl_rpc_users--

        Thread2
        echo "expire" > /proc/fs/nfsd/clients/xx/ctl
        client_ctl_write
          force_expire_client
            wait_event(&clp->cl_rpc_users == 0) --> Continue
            ...
            if (!already_expired) expire_client(clp)
          drop_client(clp) --> cl_ref--
            __free_client --> Free client
Thread1
nfs4_renew
  ...
time_consuming_op
  ...
nfs4svc_encode_compoundres
  nfsd4_sequence_done
    put_client_renew(cs->clp) --> UAF

- KASAN report:
root@syzkaller:~# ./poc
Call cb_null_proc
Call cb_null_proc
[  107.019508] ------------[ cut here ]------------
[  107.020726] WARNING: CPU: 1 PID: 214 at fs/nfsd/nfs4state.c:196
find_client_in_id_table.isra.0+0x3cd/0x5e0
[  107.022966] Modules linked in:
[  107.024142] CPU: 1 UID: 0 PID: 214 Comm: nfsd Not tainted 6.14.2 #13
[  107.024877] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.15.0-1 04/01/2014
[  107.025860] RIP: 0010:find_client_in_id_table.isra.0+0x3cd/0x5e0
[  107.026379] Code: df 48 89 ea 48 c1 ea 03 0f b6 04 02 84 c0 74 08
3c 03 0f 8e 33 01 00 00 41 c7 84 24 08 05 00 00 00 00 00 00 e9 48 fd
ff ff 90 <0f> 0b 90 48 b8 00 00 00 06
[  107.027613] RSP: 0018:ffff88800e647b18 EFLAGS: 00000246
[  107.028458] RAX: dffffc0000000000 RBX: 000000000000000a RCX: 1ffffffff0cfaf78
[  107.029431] RDX: 1ffff1100106f014 RSI: 00000000683fd4f9 RDI: ffff88800b74eec0
[  107.030132] RBP: ffff888008378168 R08: ffff88800837816c R09: ffffed1001cc8f61
[  107.030497] R10: 0000000000000003 R11: 0000000000032b9d R12: ffff888008378000
[  107.030825] R13: ffff8880081b0000 R14: ffff8880083780a0 R15: 000000009881379c
[  107.031334] FS:  0000000000000000(0000) GS:ffff88806d300000(0000)
knlGS:0000000000000000
[  107.032249] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  107.032604] CR2: 00005636322587c8 CR3: 000000000d57c000 CR4: 00000000000006f0
[  107.033437] Call Trace:
[  107.034226]  <TASK>
[  107.037033]  nfsd4_setclientid_confirm+0x305/0xc00
[  107.038036]  nfsd4_proc_compound+0xccc/0x2550
[  107.038641]  nfsd_dispatch+0x240/0x680
[  107.039041]  ? __pfx_nfsd_dispatch+0x10/0x10
[  107.039476]  ? __pfx_try_to_wake_up+0x10/0x10
[  107.039810]  ? svc_generic_init_request+0x2e7/0x530
[  107.040598]  svc_process+0x102c/0x2130
[  107.041020]  ? svc_xprt_received+0xa8/0x130
[  107.041354]  ? __pfx_svc_process+0x10/0x10
[  107.041751]  ? __pfx_nfsd_dispatch+0x10/0x10
[  107.041979]  ? __pfx_read_tsc+0x10/0x10
[  107.042193]  svc_recv+0x157a/0x1ed0
[  107.042413]  nfsd+0x247/0x360
[  107.042598]  ? __pfx_nfsd+0x10/0x10
[  107.042770]  kthread+0x319/0x620
[  107.043150]  ? __pfx_kthread+0x10/0x10
[  107.043970]  ? __pfx__raw_spin_lock_irq+0x10/0x10
[  107.044573]  ? finish_task_switch.isra.0+0x142/0x610
[  107.045028]  ? __pfx_kthread+0x10/0x10
[  107.045627]  ret_from_fork+0x2f/0x70
[  107.046238]  ? __pfx_kthread+0x10/0x10
[  107.046599]  ret_from_fork_asm+0x1a/0x30
[  107.047342]  </TASK>
[  107.047682] ---[ end trace 0000000000000000 ]---
[  107.048415] renew_client_locked: client (clientid
683fd4f9/9881379c) already expired
sh: 1: cannot create /proc/fs/nfsd/clients/3/ctl: Directory nonexistent
[  109.115204] ==================================================================
[  109.115977] BUG: KASAN: slab-use-after-free in put_client_renew+0x48a/0x5a0
[  109.116491] Read of size 8 at addr ffff8880083784e8 by task nfsd/213
[  109.116976]
[  109.117787] CPU: 0 UID: 0 PID: 213 Comm: nfsd Tainted: G        W
       6.14.2 #13
[  109.117973] Tainted: [W]=WARN
[  109.118026] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.15.0-1 04/01/2014
[  109.118112] Call Trace:
[  109.118206]  <TASK>
[  109.118238]  dump_stack_lvl+0x55/0x70
[  109.118297]  print_report+0xcb/0x630
[  109.118337]  ? put_client_renew+0x48a/0x5a0
[  109.118365]  kasan_report+0xaf/0xe0
[  109.118396]  ? put_client_renew+0x48a/0x5a0
[  109.118426]  put_client_renew+0x48a/0x5a0
[  109.118461]  nfs4svc_encode_compoundres+0x1c1/0x240
[  109.118497]  nfsd_dispatch+0x2e9/0x680
[  109.118528]  ? __pfx_nfsd_dispatch+0x10/0x10
[  109.118560]  ? __pfx_try_to_wake_up+0x10/0x10
[  109.118598]  ? svc_generic_init_request+0x2e7/0x530
[  109.118640]  svc_process+0x102c/0x2130
[  109.118676]  ? svc_xprt_received+0xa8/0x130
[  109.118742]  ? __pfx_svc_process+0x10/0x10
[  109.118788]  ? __pfx_nfsd_dispatch+0x10/0x10
[  109.118825]  ? __pfx_read_tsc+0x10/0x10
[  109.118860]  svc_recv+0x157a/0x1ed0
[  109.118926]  nfsd+0x247/0x360
[  109.118953]  ? __pfx_nfsd+0x10/0x10
[  109.118981]  kthread+0x319/0x620
[  109.119015]  ? __pfx_kthread+0x10/0x10
[  109.119071]  ? __pfx__raw_spin_lock_irq+0x10/0x10
[  109.119098]  ? finish_task_switch.isra.0+0x142/0x610
[  109.119177]  ? __pfx_kthread+0x10/0x10
[  109.119210]  ret_from_fork+0x2f/0x70
[  109.119248]  ? __pfx_kthread+0x10/0x10
[  109.119278]  ret_from_fork_asm+0x1a/0x30
[  109.119322]  </TASK>
[  109.119441]
[  109.125204] Allocated by task 213:
[  109.125615]  kasan_save_stack+0x24/0x50
[  109.126008]  kasan_save_track+0x14/0x30
[  109.126259]  __kasan_slab_alloc+0x59/0x70
[  109.126544]  kmem_cache_alloc_noprof+0xf5/0x340
[  109.126848]  create_client+0x258/0x1320
[  109.127075]  nfsd4_setclientid+0x1cd/0x1380
[  109.127354]  nfsd4_proc_compound+0xccc/0x2550
[  109.127610]  nfsd_dispatch+0x240/0x680
[  109.127845]  svc_process+0x102c/0x2130
[  109.128061]  svc_recv+0x157a/0x1ed0
[  109.128274]  nfsd+0x247/0x360
[  109.128513]  kthread+0x319/0x620
[  109.128692]  ret_from_fork+0x2f/0x70
[  109.128883]  ret_from_fork_asm+0x1a/0x30
[  109.129228]
[  109.129375] Freed by task 252:
[  109.129538]  kasan_save_stack+0x24/0x50
[  109.129770]  kasan_save_track+0x14/0x30
[  109.130064]  kasan_save_free_info+0x3b/0x60
[  109.130428]  __kasan_slab_free+0x38/0x50
[  109.130665]  kmem_cache_free+0x163/0x3b0
[  109.130847]  client_ctl_write+0x3ce/0x5a0
[  109.131074]  vfs_write+0x21d/0xcc0
[  109.131291]  ksys_write+0xef/0x1c0
[  109.131521]  do_syscall_64+0xa6/0x1a0
[  109.131744]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  109.131967]
[  109.132241] Last potentially related work creation:
[  109.132604]  kasan_save_stack+0x24/0x50
[  109.132847]  kasan_record_aux_stack+0x8c/0xa0
[  109.133038]  __queue_work+0x5cc/0xe30
[  109.133295]  queue_work_on+0x59/0x60
[  109.133502]  nfsd4_run_cb+0x45/0x90
[  109.133683]  nfsd4_setclientid_confirm+0x432/0xc00
[  109.133956]  nfsd4_proc_compound+0xccc/0x2550
[  109.134203]  nfsd_dispatch+0x240/0x680
[  109.134535]  svc_process+0x102c/0x2130
[  109.134793]  svc_recv+0x157a/0x1ed0
[  109.135043]  nfsd+0x247/0x360
[  109.135300]  kthread+0x319/0x620
[  109.135610]  ret_from_fork+0x2f/0x70
[  109.135941]  ret_from_fork_asm+0x1a/0x30
[  109.136317]
[  109.136501] Second to last potentially related work creation:
[  109.136877]  kasan_save_stack+0x24/0x50
[  109.137224]  kasan_record_aux_stack+0x8c/0xa0
[  109.137564]  __queue_work+0x5cc/0xe30
[  109.137851]  queue_work_on+0x59/0x60
[  109.138125]  nfsd4_run_cb+0x45/0x90
[  109.138392]  nfsd4_setclientid_confirm+0x8cb/0xc00
[  109.138643]  nfsd4_proc_compound+0xccc/0x2550
[  109.138852]  nfsd_dispatch+0x240/0x680
[  109.139101]  svc_process+0x102c/0x2130
[  109.139320]  svc_recv+0x157a/0x1ed0
[  109.139453]  nfsd+0x247/0x360
[  109.139617]  kthread+0x319/0x620
[  109.139851]  ret_from_fork+0x2f/0x70
[  109.139999]  ret_from_fork_asm+0x1a/0x30
[  109.140291]
[  109.140411] The buggy address belongs to the object at ffff888008378000
[  109.140411]  which belongs to the cache nfs4_client of size 1328
[  109.141009] The buggy address is located 1256 bytes inside of
[  109.141009]  freed 1328-byte region [ffff888008378000, ffff888008378530)
[  109.141662]
[  109.141894] The buggy address belongs to the physical page:
[  109.142498] page: refcount:0 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x8378
[  109.143447] head: order:3 mapcount:0 entire_mapcount:0
nr_pages_mapped:0 pincount:0
[  109.143874] flags: 0x100000000000040(head|node=0|zone=1)
[  109.145116] page_type: f5(slab)
[  109.146022] raw: 0100000000000040 ffff888007747c80 dead000000000122
0000000000000000
[  109.146509] raw: 0000000000000000 0000000080160016 00000000f5000000
0000000000000000
[  109.146886] head: 0100000000000040 ffff888007747c80
dead000000000122 0000000000000000
[  109.147217] head: 0000000000000000 0000000080160016
00000000f5000000 0000000000000000
[  109.147563] head: 0100000000000003 ffffea000020de01
ffffffffffffffff 0000000000000000
[  109.147998] head: ffff888000000008 0000000000000000
00000000ffffffff 0000000000000000
[  109.148445] page dumped because: kasan: bad access detected
[  109.148734]
[  109.148848] Memory state around the buggy address:
[  109.149493]  ffff888008378380: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[  109.149925]  ffff888008378400: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[  109.150298] >ffff888008378480: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[  109.150675]                                                           ^
[  109.151224]  ffff888008378500: fb fb fb fb fb fb fc fc fc fc fc fc
fc fc fc fc
[  109.151543]  ffff888008378580: fc fc fc fc fc fc fa fb fb fb fb fb
fb fb fb fb
[  109.151915] ==================================================================
[  109.152592] Disabling lock debugging due to kernel taint
rpc_service() failed for server

