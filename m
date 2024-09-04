Return-Path: <linux-nfs+bounces-6195-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C729096C541
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Sep 2024 19:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E72091C20DCB
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Sep 2024 17:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905631E0B8C;
	Wed,  4 Sep 2024 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="rVvr6+oK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677ED1E630F
	for <linux-nfs@vger.kernel.org>; Wed,  4 Sep 2024 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470324; cv=none; b=HBpP67ELpll/I9utQr0+8pIPLJkmHQAd7jpIyFNJ4z2a9RMr7eRzuTj5fUAFfWZdXxx9lqDpRrS6OMhnjGEwybuuVe5oURqt+u+ACgAp15znqYAk6IADzdjw+Cm0A3Rb/Z7fPJV5UlqIYQ082zn4bWoPOYrARxGCGLIq0z+yKm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470324; c=relaxed/simple;
	bh=ahswB8hUbUlmpGTcIQh1XAV5qMRekOAulhC5yyJgcQQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=J8ZSThUaqTQMlddF4NzctQR5ZIqz6QHeEfhleaKQEHqwaIycrYc0DZ2oipipr0LwVEGm0MG7hXxnXxK6X2w8m6p37T85d2HjV6+CR8UcfHyPt0bAc3INCovi0UkHBZlkbFV8zPDq2oPABKoUVfLGgqIVoRqa5umzvlD1jTLD4wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=rVvr6+oK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20693995f68so8718455ad.1
        for <linux-nfs@vger.kernel.org>; Wed, 04 Sep 2024 10:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1725470321; x=1726075121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dSC2jveJ0jsYz0cGADBL5DJEPo+Pj20pwZgZvQBpJWQ=;
        b=rVvr6+oKZDgyureSdf1b8/QxeWAT6w9xd/PqCns3XQ8jBmRi4hsJuExl4UT32Nwq4R
         uJxWPIdwoKXIzVawoQW1a4HVGV2iw+n6Fp0JPK7wd82jaFpC+i8i5udNcXHMgjQeyUDe
         bYPLHBI83+ceJdE5tgTQHtLPLCyMk7ZubP3l11xskZS6ERaMlH5Ra8n2Fp8PvXOUpd3y
         ugw4vWnqhQxajgYbT/+Ue48MBj3XJlqBU5AOzJmnbfR/2ZDEnIm0f2uFMxnCvncIvwCy
         O+8ePRcvnrBk3Vg8r3pjIrMOWyBaInFwcH2iYyTYSO2osGAljxr6WSDutDDXLS3K4z3v
         Gj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725470321; x=1726075121;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSC2jveJ0jsYz0cGADBL5DJEPo+Pj20pwZgZvQBpJWQ=;
        b=nV0bUyJGn/Aqx9FMN7cfHBYOkx3zkFG6iz6QaG+jcf8U129cF8WYswasJyK6XCrSga
         PH7RUS12xIcylAJTLazR1F9Dv+heH5sVBWXIRk8MlBfmQmdBJ6W/B9lr7KTvvqCTmzaq
         TZlyInBttkRlf233R3qo8TyxYefCpy2Kel+IeyLNPv3uEpd7dIOISjSNvS6Vt6Wn4pbH
         Ea7S03mMNLmGsnv5hki/NVcXEcPtfQroUMYnA+vRTHQl2wHlbDKzkfAEmRJUqGom3uy8
         dKBpIkw96ZKdeBXKh/sc92eQ9iW31VX+5kwu1oE30JNcqDBEuyHGrHmVi4ObYGegkNBg
         MEKA==
X-Gm-Message-State: AOJu0Yzk4OtEvFkaWWeunskVyMpxMEmHYSPfKl6q5JKdU2O3CzZ1GRM2
	+hg4V6OO+nTXO4POJtoZTOu6Ysp2BltOpLZzr07RWt6NdxNNBO83MMtJww+NRUwFpSDiDaAgZu4
	lIxc=
X-Google-Smtp-Source: AGHT+IFRLkGrt4fH2qZpZ+U/B9NxgbLzIkv6MFc47LFnBdljduT0oakx5s0XFJih/PreH0Ussud68w==
X-Received: by 2002:a17:902:e54f:b0:205:83a3:b08 with SMTP id d9443c01a7336-20583a30bf0mr91591015ad.32.1725470321392;
        Wed, 04 Sep 2024 10:18:41 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae913df2sm15899555ad.41.2024.09.04.10.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 10:18:40 -0700 (PDT)
Date: Wed, 4 Sep 2024 10:18:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Subject: Fw: [Bug 219228] New: KVM guest boot up with call trace with
 mounted image due to NFS server connection is not stable
Message-ID: <20240904101837.1d825463@hermes.local>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Looks more like NFS bug than a networking bug per se.

Begin forwarded message:

Date: Wed, 04 Sep 2024 02:32:26 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 219228] New: KVM guest boot up with call trace with mounted i=
mage due to NFS server connection is not stable


https://bugzilla.kernel.org/show_bug.cgi?id=3D219228

            Bug ID: 219228
           Summary: KVM guest boot up with call trace with mounted image
                    due to NFS server connection is not stable
           Product: Networking
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: IPV4
          Assignee: stephen@networkplumber.org
          Reporter: xuelian.guo@intel.com
        Regression: No

Environment:
host kernel :=C2=A06.11.0-rc3=20
guest kernel :6.11.0-rc5
qemu version : QEMU emulator version 9.0.92 (v9.1.0-rc2-28-g2eefd4fcec)


Bug detail description:=C2=A0
try to boot KVM guest , there is call trace during kernel loading

Reproduce steps:=C2=A0
1. set up nfs-server, and put guest image "centos9.img" into NFS-server's
/images folder.

2. mount NFS-server folder to local:
   <NfS-server>:/images /share/guest_imgs nfs defaults,tcp,nolock 0 0

3. create qcow2 image based on remote NFS-server
    qemu-img created -b /share/guest_imgs/centos9.img -f qcow2 centos9.qcow=
2 -F
raw

4. boot KVM guest with :
qemu-system-x86_64 -accel kvm \
-m 4096 \
-smp 4 \
-cpu host \
-drive file=3Dcentos9.qcow2,if=3Dnone,id=3Dvirtio-disk0 \
-device virtio-blk-pci,drive=3Dvirtio-disk0,bootindex=3D0 \
-device virtio-net-pci,netdev=3Dnic0 \
-netdev user,id=3Dnic0,hostfwd=3Dtcp::10022-:22 \
-nographic

Error log:=C2=A0
During KVM guest booting, there are call trace and Guest could boot up in t=
he
end, but boot time is long.
 INFO: task kworker/u8:1:29 blocked for more than 122 seconds.
[  246.987403]       Not tainted 6.11.0-rc5 #2
[  246.989674] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this
message.
[  246.992986] task:kworker/u8:1    state:D stack:0     pid:29    tgid:29  =
=20
ppid:2      flags:0x00004000
[  246.996842] Workqueue: xfs-cil/dm-0 xlog_cil_push_work [xfs]
[  247.000029] Call Trace:
[  247.001707]  <TASK>
[  247.003263]  __schedule+0x276/0x710
[  247.005381]  schedule+0x27/0xa0
[  247.007300]  xlog_state_get_iclog_space+0x102/0x2a0 [xfs]
[  247.010298]  ? __pfx_default_wake_function+0x10/0x10
[  247.012800]  xlog_write+0x7b/0x260 [xfs]
[  247.015379]  ? _raw_spin_unlock+0xe/0x30
[  *** ] (5 of 5) A start job is running for=E2=80=A6ernel arming (3min 39s=
 / no limit)
[  247.023496]  xlog_cil_push_work+0x50e/0x6f0 [xfs]
[  247.026329]  process_one_work+0x158/0x360
[  247.028584]  worker_thread+0x235/0x340
[  247.030710]  ? __pfx_worker_thread+0x10/0x10
[  247.032997]  kthread+0xd0/0x100
[  247.034937]  ? __pfx_kthread+0x10/0x10
[  247.037063]  ret_from_fork+0x31/0x50
[  247.039161]  ? __pfx_kthread+0x10/0x10
[  247.041302]  ret_from_fork_asm+0x1a/0x30
[  247.043479]  </TASK>
[  247.045019] INFO: task kworker/0:3:255 blocked for more than 122 seconds.
[  247.047775]       Not tainted 6.11.0-rc5 #2
[  247.049802] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this
message.
[  247.052903] task:kworker/0:3     state:D stack:0     pid:255   tgid:255 =
=20
ppid:2      flags:0x00004000
[  247.056403] Workqueue: xfs-sync/dm-0 xfs_log_worker [xfs]
[  247.058880] Call Trace:
[  247.060293]  <TASK>
[  247.061638]  __schedule+0x276/0x710
[  247.063332]  schedule+0x27/0xa0
[  247.064964]  schedule_timeout+0x14e/0x160
[  247.066778]  __wait_for_common+0x8f/0x1d0
[  247.068569]  ? __pfx_schedule_timeout+0x10/0x10
[  247.070332]  __flush_workqueue+0x13e/0x3f0
[  247.072011]  xlog_cil_push_now.isra.0+0x25/0x90 [xfs]
[  247.074185]  xlog_cil_force_seq+0x79/0x240 [xfs]
[  247.076253]  ? rpm_suspend+0x1ad/0x5e0
[  247.077831]  ? _raw_spin_unlock+0xe/0x30
[  247.079442]  ? rpm_suspend+0x5b6/0x5e0
[  247.080987]  xfs_log_force+0x7a/0x230 [xfs]
[  247.082764]  xfs_log_worker+0x3d/0xc0 [xfs]
[  247.084564]  process_one_work+0x158/0x360
[  247.086075]  worker_thread+0x235/0x340
[  247.087462]  ? __pfx_worker_thread+0x10/0x10
[  247.088895]  kthread+0xd0/0x100
[  247.090108]  ? __pfx_kthread+0x10/0x10
[  247.091410]  ret_from_fork+0x31/0x50
[  247.092665]  ? __pfx_kthread+0x10/0x10
[  247.093932]  ret_from_fork_asm+0x1a/0x30
[  247.095251]  </TASK>
[  247.096232] INFO: task xfsaild/dm-0:543 blocked for more than 122 second=
s.
[  247.099379]       Not tainted 6.11.0-rc5 #2
[  247.101574] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this
message.
[  247.104908] task:xfsaild/dm-0    state:D stack:0     pid:543   tgid:543 =
=20
ppid:2      flags:0x00004000
[  247.108707] Call Trace:
[  247.110363]  <TASK>
[  247.111914]  __schedule+0x276/0x710
[  247.113892]  schedule+0x27/0xa0
[  247.115756]  schedule_timeout+0x14e/0x160
[  247.117899]  __wait_for_common+0x8f/0x1d0
[  247.119998]  ? __pfx_schedule_timeout+0x10/0x10
[  247.122276]  __flush_workqueue+0x13e/0x3f0
[  247.124457]  ? ttwu_queue_wakelist+0xd0/0xf0
[  247.126684]  xlog_cil_push_now.isra.0+0x25/0x90 [xfs]
[  247.129559]  xlog_cil_force_seq+0x79/0x240 [xfs]
[  247.132238]  ? _raw_spin_unlock+0xe/0x30
[  247.134300]  ? finish_task_switch.isra.0+0x97/0x2a0
[  247.136675]  xfs_log_force+0x7a/0x230 [xfs]
[  247.139251]  xfsaild_push+0x2d7/0x850 [xfs]
[  247.141753]  ? __timer_delete_sync+0x2b/0x40
[  247.143931]  ? schedule_timeout+0x99/0x160
[  247.146023]  ? __pfx_process_timeout+0x10/0x10
[  247.148238]  xfsaild+0xaf/0x140 [xfs]
[  247.150566]  ? __pfx_xfsaild+0x10/0x10 [xfs]
[  247.153062]  kthread+0xd0/0x100
[  247.154785]  ? __pfx_kthread+0x10/0x10
[  247.156715]  ret_from_fork+0x31/0x50
[  247.158404]  ? __pfx_kthread+0x10/0x10
[  247.160147]  ret_from_fork_asm+0x1a/0x30
[  247.161914]  </TASK>
[  247.163238] INFO: task in:imjournal:787 blocked for more than 123 second=
s.
[  247.165818]       Not tainted 6.11.0-rc5 #2
[  247.167697] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this
message.
[  247.170408] task:in:imjournal    state:D stack:0     pid:787   tgid:745 =
=20
ppid:1      flags:0x00000002
[  247.173404] Call Trace:
[  247.174673]  <TASK>
[  247.175844]  __schedule+0x276/0x710
[  247.177441]  schedule+0x27/0xa0
[  247.178888]  schedule_timeout+0x14e/0x160
[  247.180562]  ? update_sd_lb_stats.constprop.0+0x66/0x270
[  247.182469]  ___down_common+0x110/0x170
[  247.183983]  __down_common+0x1e/0xc0
[  247.185435]  down+0x47/0x60
[  247.186684]  xfs_buf_lock+0x31/0xe0 [xfs]
[  247.188553]  xfs_buf_find_lock+0x59/0x110 [xfs]
[  247.190532]  xfs_buf_lookup.constprop.0+0xb9/0x180 [xfs]
[  247.192666]  xfs_buf_get_map+0xea/0x5f0 [xfs]
[  247.194510]  xfs_buf_read_map+0x58/0x2a0 [xfs]
[  247.196315]  ? xfs_btree_read_buf_block+0xa2/0x120 [xfs]
[  247.198282]  ? xfs_trans_add_item+0x37/0xb0 [xfs]
[  247.200066]  xfs_trans_read_buf_map+0x119/0x300 [xfs]
[  247.201813]  ? xfs_btree_read_buf_block+0xa2/0x120 [xfs]
[  247.203618]  xfs_btree_read_buf_block+0xa2/0x120 [xfs]
[  247.205404]  xfs_btree_lookup_get_block.part.0+0x81/0x1b0 [xfs]
[  247.207331]  xfs_btree_lookup+0x102/0x550 [xfs]
[  247.208969]  ? kmem_cache_alloc_noprof+0xdc/0x2b0
[  247.210404]  xfs_dialloc_ag_update_inobt+0x47/0x170 [xfs]
[  247.212187]  ? xfs_inobt_init_cursor+0x67/0xa0 [xfs]
[  247.213808]  xfs_dialloc_ag+0x1ad/0x2e0 [xfs]
[  247.215343]  xfs_dialloc+0x24b/0x3b0 [xfs]
[  247.216798]  xfs_create+0x167/0x490 [xfs]
[  247.218193]  ? xfs_dir2_format+0x4a/0x130 [xfs]
[  247.219644]  xfs_generic_create+0x30d/0x360 [xfs]
[  247.221129]  lookup_open.isra.0+0x4e1/0x600
[  247.222312]  open_last_lookups+0x139/0x440
[  247.223461]  path_openat+0x88/0x290
[  247.224451]  do_filp_open+0xae/0x150
[  247.225454]  do_sys_openat2+0x96/0xd0
[  247.226472]  __x64_sys_openat+0x57/0xa0
[  247.227515]  do_syscall_64+0x64/0x170
[  247.228524]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  247.229778] RIP: 0033:0x7fbcacb3e8d4
[  247.230763] RSP: 002b:00007fbcab7fea40 EFLAGS: 00000293 ORIG_RAX:
0000000000000101
[  247.232427] RAX: ffffffffffffffda RBX: 00007fbc9c000c10 RCX:
00007fbcacb3e8d4
[  247.234030] RDX: 0000000000000241 RSI: 00007fbcab7feb80 RDI:
00000000ffffff9c
[  247.235626] RBP: 00007fbcab7feb80 R08: 0000000000000000 R09:
0000000000000001
[  247.237174] R10: 00000000000001b6 R11: 0000000000000293 R12:
0000000000000241
[  247.238682] R13: 00007fbc9c000c10 R14: 0000000000000001 R15:
00007fbc9c015c40
[  247.240204]  </TASK>
[  247.242323] INFO: task updatedb:769 blocked for more than 123 seconds.
[  247.243697]       Not tainted 6.11.0-rc5 #2
[  247.244694] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this
message.
[  247.246246] task:updatedb        state:D stack:0     pid:769   tgid:769 =
=20
ppid:756    flags:0x00000002
[  247.247995] Call Trace:
[  247.248689]  <TASK>
[  247.249342]  __schedule+0x276/0x710
[  247.250192]  ? vp_notify+0x16/0x20 [virtio_pci]
[  247.251208]  schedule+0x27/0xa0
[  247.252006]  schedule_timeout+0x14e/0x160
[  247.252926]  ? __blk_flush_plug+0xf5/0x150
[  247.253854]  __wait_for_common+0x8f/0x1d0
[  247.254726]  ? __pfx_schedule_timeout+0x10/0x10
[  247.255678]  xfs_buf_iowait+0x1c/0xc0 [xfs]
[  247.256797]  __xfs_buf_submit+0x131/0x1e0 [xfs]
[  247.257933]  xfs_buf_read_map+0x11e/0x2a0 [xfs]
[  247.259044]  ? xfs_da_read_buf+0xee/0x170 [xfs]
[  247.260178]  xfs_trans_read_buf_map+0x119/0x300 [xfs]
[  247.261306]  ? xfs_da_read_buf+0xee/0x170 [xfs]
[  247.262375]  xfs_da_read_buf+0xee/0x170 [xfs]
[  247.263430]  xfs_dir3_block_read+0x3c/0xf0 [xfs]
[  247.264506]  xfs_dir2_block_lookup_int+0x4c/0x1d0 [xfs]
[  247.265658]  ? xfs_bmap_last_offset+0x6b/0x110 [xfs]
[  247.266737]  xfs_dir2_block_lookup+0x3b/0x130 [xfs]
[  247.267795]  xfs_dir_lookup_args+0x3e/0x90 [xfs]
[  247.268810]  xfs_dir_lookup+0x139/0x160 [xfs]
[  247.269798]  xfs_lookup+0x94/0x160 [xfs]
[  247.270722]  ? avc_has_perm_noaudit+0x6b/0xf0
[  247.271570]  xfs_vn_lookup+0x78/0xb0 [xfs]
[  247.272504]  __lookup_slow+0x81/0x130
[  247.273242]  walk_component+0xe5/0x160
[  247.273969]  path_lookupat+0x6e/0x1c0
[  247.274685]  filename_lookup+0xcd/0x1c0
[  247.275428]  ? selinux_inode_getattr+0x9a/0xc0
[  247.276249]  ? terminate_walk+0x21/0x100
[  247.277002]  ? xfs_vn_getattr+0x66/0x340 [xfs]
[  247.277968]  ? cp_new_stat+0x14f/0x180
[  247.278682]  vfs_statx+0x75/0xe0
[  247.279332]  vfs_fstatat+0x6c/0xb0
[  247.279989]  __do_sys_newfstatat+0x26/0x60
[  247.280722]  ? __seccomp_filter+0x3d8/0x5b0
[  247.281473]  ? syscall_trace_enter+0xff/0x190
[  247.282270]  do_syscall_64+0x64/0x170
[  247.282958]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  247.283805] RIP: 0033:0x7f57f593e13e
[  247.284479] RSP: 002b:00007ffccb8f2bc8 EFLAGS: 00000246 ORIG_RAX:
0000000000000106
[  247.285541] RAX: ffffffffffffffda RBX: 0000564a28d7a9f0 RCX:
00007f57f593e13e
[  247.286569] RDX: 00007ffccb8f2c30 RSI: 0000564a28d88fb9 RDI:
00000000ffffff9c
[  247.287595] RBP: 0000564a28d88fb9 R08: 0000000000000000 R09:
00005649ecdb34e0
[  247.288601] R10: 0000000000000100 R11: 0000000000000246 R12:
0000000000000006
[  247.289599] R13: 00007ffccb8f2e00 R14: 0000000000000006 R15:
0000000000000006

Note :
it was verified this issue was not reproduced if host kernel returned to
6.10.0-rc7.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

