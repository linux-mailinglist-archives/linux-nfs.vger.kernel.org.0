Return-Path: <linux-nfs+bounces-2451-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE79887EBF
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Mar 2024 20:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 491BBB20C13
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Mar 2024 19:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39219DDD8;
	Sun, 24 Mar 2024 19:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=scpcom@gmx.de header.b="iZkVLJPt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A25DDBC;
	Sun, 24 Mar 2024 19:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711310258; cv=none; b=uigjcX5w0YrwQRbX2KYdgIt+ZY8ulwoIWR1Qq5MytDDnx0ic3hyaH3xAiDFhN0C6qJZTIgsJwuYkmZ7jW983bMrm+lazxFqOuznoDDJGhykH4tXHfZZD7PR7KX7Xbvd6aZk4+Hxsrhzn4Nhc5tacgdKjQVkc1wt5KWPDj4sNJqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711310258; c=relaxed/simple;
	bh=cCvnzHyaJ1zVwOtF1/g8QmAMt/PG2t+ZmZi0IZG+D1g=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date; b=XW6e0RKwM237rl7xZpIHordQRDjIGzfny1arrSI5BdwUme3bgVtmeTg5m9UB098r/VgiA07xWVOVC/7Wb/NmIbUN9MI6liBwLhjtgVQfaEdLIqSwgfFSUwNDj8D9J4BK5qJFeIhkgkdwbnTcBWcH3Md+s2zw4pdcUTSh63EeIJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=scpcom@gmx.de header.b=iZkVLJPt; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711310238; x=1711915038; i=scpcom@gmx.de;
	bh=zSfCflL2IwXMpzsos5LiR4aSrcSnEeM4VlhbqvFgwlU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=iZkVLJPtR/9zfBIidfXxH4kcyvaPVigH4nWQgh+pROX2UZ5Q5SnK3C+wXqdFFfIw
	 BrY5QcSpNiNJ0WUWT7DAFWCJQjzDQ82n6/2z4AMcP0FJgl7pKgATN2lAIIYM+TLgV
	 /ECWW2V4LThPXWAZyvsWzEdvbMZwOuLPG1eW0M6fQUD7iPp9bFLiF18qN4ujcf1fy
	 WSOElYJC0jFj3pqQFg5gg3ALjeuW5m7j+jwBSXVwwQd40NxkOsFxFjMS//2MloTuG
	 8QMR3Z9yoM/aR4r2TgS+ERDCIEq9xhPy9nlE2b5xRy9Ig4SQrw6EHXCZMRwCY6uH9
	 82pLR62a24apmSACHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.236.202.8] ([10.236.202.8]) by msvc-mesg-gmx120 (via
 HTTP); Sun, 24 Mar 2024 20:57:17 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-068f55c9-6088-418d-bf3a-c2778a871e98-1711310237802@msvc-mesg-gmx120>
From: Jan Schunk <scpcom@gmx.de>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, Olga
 Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: nfsd: memory leak when client does many file operations
Content-Type: text/plain; charset=UTF-8
Importance: normal
Sensitivity: Normal
Date: Sun, 24 Mar 2024 20:57:17 +0100
X-Priority: 3
X-Provags-ID: V03:K1:CBlESzqiu7pfT8A5yLx4CnbXl95pYo+uJNqLDyFDdCqhDL6iTeXKAsjju30LqVWOuygdX
 R+Ri31B8adxDuIlTODV0t4cMYsAyWELSJu7/OSR46RgKzGtzdkPUC5c1RhTfOkvz+tWK9KCG2NGK
 T1jBaCrQFCc5J+bcO+T/GXT8lU/NDcd7xgfSi8WKc4Sgl0ZrGpXWxFpXjwVHxGlhG/gAwzcFn9bV
 voNjxB8jB8T217Plfu72mREblqoQ+1bUrnBFPkhTUMRTgOv9fFVfdNpjopeRO21P2krJhY2rhA6K
 Fk=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SWTgSyCrhuU=;f0ZX9M46YJkNbwboV5rJX/Uo/yi
 qat9ydQVshmABB+bOkL0RxuVGQQ3wahMrMd5PZsJ+OoeWoUmcLBKAg4XNUeERQArZETHAtETq
 gS1fgiUoQecujGgY05qYWzzhD62TBHjDbNxw0xOIPKBn2tBXEUty42RVPDpxEEspXmSAgH1Yi
 VIo0bhlXC7xuVV7qEci5d5b4wUEdRNLTOx5DPuwRSkLWsSMnAvjO6a2Cjsx1xrdgow54RR80O
 E7IBagqE2yz31fmLGGcUQCRKrAIGZKiYjryrCuYqJpv8MHO8bMRm/nCBUyyUKkAU3AktsICJI
 RJELLJNABpfqnIxQsev0SR0jaJexi8ZDIZ9VQZ8eey93MOmme/djuBPvxmHN+KU6n0xN1vdVb
 CY9ZAMf7YEvJe+gHAH5aPTITu5XdgooKwt0vZayeGvTzvBjjJ2EVXgdJQwhGOsny+FpuIcq2l
 jHltqaSpmJc47tySNKP2sgqawjvDU6YY3Kg3RNjwdLSpW9sC88Ik6LYUPqi5T4asatXl90997
 YXNX5SH+D/+Q3WTksJr97Bo1XtVzAH/ky+m+UTD3AFbRP4OxJ4Lr5l02u/6e2K04/ss11fcJA
 e5/2uHyhO3HFvd1imyNe9bjNLk0PyjtgCdFpV3vMoLxq3/MSuxNOGPFKsUCf5uG5VqMSDDx3s
 6qB97loJz8wNXoqZeRdQhE2jD1YMzc05To4dDyum6BBSN02YLXq+/fIoNxgUuZE=

Issue found on: v6.5.13 v6.6.13, v6.6.14, v6.6.20 and v6.8.1
Not found on: v6.4, v6.1.82 and below
Architectures: amd64 and arm(hf)

Steps to reproduce:
- Create a VM with 1GB RAM
- Install Debian 12
- Install linux-image-6.6.13+bpo-amd64-unsigned and nfs-kernel-server
- Export some folder
On the client:
- Mount the share
- Run a script that does produce heavy usage on the share (like unpacking large tar archives that cointain many small files into a git and commiting them)

On my setup it takes 20-40 hours until the memory is full and oom-kill gets hired by nfsd to kill other processes. the memory stays full and the system reboots:

[121969.590000] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0,task=dbus-daemon,pid=454,uid=101
[121969.600000] Out of memory: Killed process 454 (dbus-daemon) total-vm:6196kB, anon-rss:128kB, file-rss:1408kB, shmem-rss:0kB, UID:101 pgtables:12kB oom_score_adj:-900
[121971.700000] oom_reaper: reaped process 454 (dbus-daemon), now anon-rss:0kB, file-rss:64kB, shmem-rss:0kB
[121971.920000] nfsd invoked oom-killer: gfp_mask=0xcc0(GFP_KERNEL), order=0, oom_score_adj=0
[121971.930000] CPU: 1 PID: 537 Comm: nfsd Not tainted 6.8.1+nas5xx #nas5xx
[121971.930000] Hardware name: Freescale LS1024A
[121971.940000]  unwind_backtrace from show_stack+0xb/0xc
[121971.940000]  show_stack from dump_stack_lvl+0x2b/0x34
[121971.950000]  dump_stack_lvl from dump_header+0x35/0x212
[121971.950000]  dump_header from out_of_memory+0x317/0x34c
[121971.960000]  out_of_memory from __alloc_pages+0x8e7/0xbb0
[121971.970000]  __alloc_pages from __alloc_pages_bulk+0x26d/0x3d8
[121971.970000]  __alloc_pages_bulk from svc_recv+0x9d/0x7d4
[121971.980000]  svc_recv from nfsd+0x7d/0xd4
[121971.980000]  nfsd from kthread+0xb9/0xcc
[121971.990000]  kthread from ret_from_fork+0x11/0x1c
[121971.990000] Exception stack(0xc2cadfb0 to 0xc2cadff8)
[121971.990000] dfa0:                                     00000000 00000000 00000000 00000000
[121972.000000] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[121972.010000] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[121972.020000] Mem-Info:
[121972.020000] active_anon:101 inactive_anon:127 isolated_anon:29
[121972.020000]  active_file:1200 inactive_file:1204 isolated_file:98
[121972.020000]  unevictable:394 dirty:296 writeback:17
[121972.020000]  slab_reclaimable:13680 slab_unreclaimable:4350
[121972.020000]  mapped:637 shmem:4 pagetables:414
[121972.020000]  sec_pagetables:0 bounce:0
[121972.020000]  kernel_misc_reclaimable:0
[121972.020000]  free:7279 free_pcp:184 free_cma:1094
[121972.060000] Node 0 active_anon:404kB inactive_anon:508kB active_file:4736kB inactive_file:4884kB unevictable:1576kB isolated(anon):116kB isolated(file):388kB mapped:2548kB dirty:1184kB writeback:68kB shmem:16kB writeback_tmp:0kB kernel_stack:1088kB pagetables:1656kB sec_pagetables:0kB all_unreclaimable? no
[121972.090000] Normal free:29116kB boost:18432kB min:26624kB low:28672kB high:30720kB reserved_highatomic:0KB active_anon:404kB inactive_anon:712kB active_file:4788kB inactive_file:4752kB unevictable:1576kB writepending:1252kB present:1048576kB managed:1011988kB mlocked:1576kB bounce:0kB free_pcp:736kB local_pcp:236kB free_cma:4376kB
[121972.120000] lowmem_reserve[]: 0 0
[121972.120000] Normal: 2137*4kB (UEC) 1173*8kB (UEC) 529*16kB (UEC) 19*32kB (UC) 7*64kB (C) 5*128kB (C) 2*256kB (C) 1*512kB (C) 0*1024kB 0*2048kB 0*4096kB = 29116kB
[121972.140000] 2991 total pagecache pages
[121972.140000] 166 pages in swap cache
[121972.140000] Free swap  = 93424kB
[121972.150000] Total swap = 102396kB
[121972.150000] 262144 pages RAM
[121972.150000] 0 pages HighMem/MovableOnly
[121972.160000] 9147 pages reserved
[121972.160000] 4096 pages cma reserved
[121972.160000] Unreclaimable slab info:
[121972.170000] Name                      Used          Total
[121972.170000] bio-88                    64KB         64KB
[121972.180000] TCPv6                     61KB         61KB
[121972.180000] bio-76                    16KB         16KB
[121972.190000] bio-188                   11KB         11KB
[121972.190000] nfs_read_data             22KB         22KB
[121972.200000] kioctx                    15KB         15KB
[121972.200000] posix_timers_cache          7KB          7KB
[121972.210000] UDP                       63KB         63KB
[121972.220000] tw_sock_TCP                3KB          3KB
[121972.220000] request_sock_TCP           3KB          3KB
[121972.230000] TCP                       62KB         62KB
[121972.230000] bio-168                    7KB          7KB
[121972.240000] ep_head                    8KB          8KB
[121972.240000] request_queue             15KB         15KB
[121972.250000] bio-124                   18KB         40KB
[121972.250000] biovec-max               264KB        264KB
[121972.260000] biovec-128                63KB         63KB
[121972.260000] biovec-64                157KB        157KB
[121972.270000] skbuff_small_head         94KB         94KB
[121972.270000] skbuff_fclone_cache         55KB         63KB
[121972.280000] skbuff_head_cache         59KB         59KB
[121972.280000] fsnotify_mark_connector         16KB         28KB
[121972.290000] sigqueue                  19KB         31KB
[121972.300000] shmem_inode_cache       1622KB       1662KB
[121972.300000] kernfs_iattrs_cache         15KB         15KB
[121972.310000] kernfs_node_cache       2107KB       2138KB
[121972.310000] filp                     259KB        315KB
[121972.320000] net_namespace             30KB         30KB
[121972.320000] uts_namespace             15KB         15KB
[121972.330000] vma_lock                 143KB        179KB
[121972.330000] vm_area_struct           459KB        553KB
[121972.340000] sighand_cache            191KB        220KB
[121972.340000] task_struct              378KB        446KB
[121972.350000] anon_vma_chain           753KB        804KB
[121972.360000] anon_vma                 170KB        207KB
[121972.360000] trace_event_file          83KB         83KB
[121972.370000] mm_struct                157KB        173KB
[121972.370000] vmap_area                217KB        354KB
[121972.380000] kmalloc-8k               224KB        224KB
[121972.380000] kmalloc-4k               860KB        992KB
[121972.390000] kmalloc-2k               352KB        352KB
[121972.390000] kmalloc-1k               563KB        576KB
[121972.400000] kmalloc-512              936KB        936KB
[121972.400000] kmalloc-256              196KB        240KB
[121972.410000] kmalloc-192              160KB        169KB
[121972.410000] kmalloc-128              546KB        764KB
[121972.420000] kmalloc-64              1213KB       1288KB
[121972.420000] kmem_cache_node           12KB         12KB
[121972.430000] kmem_cache                16KB         16KB
[121972.440000] Tasks state (memory values in pages):
[121972.440000] [  pid  ]   uid  tgid total_vm      rss rss_anon rss_file rss_shmem pgtables_bytes swapents oom_score_adj name
[121972.450000] [    209]     0   209     5140      320        0      320         0    16384      480         -1000 systemd-udevd
[121972.460000] [    230]   998   230     2887       55       32       23         0    18432        0             0 systemd-network
[121972.470000] [    420]     0   420      596        0        0        0         0     6144       22             0 mdadm
[121972.490000] [    421]   102   421     1393       56       32       24         0    10240        0             0 rpcbind
[121972.500000] [    429]   996   429     3695       17        0       17         0    20480        0             0 systemd-resolve
[121972.510000] [    433]     0   433      494       51        0       51         0     8192        0             0 rpc.idmapd
[121972.520000] [    434]     0   434      743       92       33       59         0     8192        7             0 nfsdcld
[121972.530000] [    451]     0   451      390        0        0        0         0     6144        0             0 acpid
[121972.540000] [    453]   105   453     1380       50       32       18         0    10240       18             0 avahi-daemon
[121972.550000] [    454]   101   454     1549       16        0       16         0    12288       32          -900 dbus-daemon
[121972.560000] [    466]     0   466     3771       60        0       60         0    14336        0             0 irqbalance
[121972.570000] [    475]     0   475     6269       32       32        0         0    18432        0             0 rsyslogd
[121972.590000] [    487]   105   487     1347       68       38       30         0    10240        0             0 avahi-daemon
[121972.600000] [    492]     0   492     1765        0        0        0         0    12288        0             0 cron
[121972.610000] [    493]     0   493     2593        0        0        0         0    16384        0             0 wpa_supplicant
[121972.620000] [    494]     0   494      607        0        0        0         0     8192       32             0 atd
[121972.630000] [    506]     0   506     1065       25        0       25         0    10240        0             0 rpc.mountd
[121972.640000] [    514]   103   514      809       25        0       25         0     8192        0             0 rpc.statd
[121972.650000] [    522]     0   522      999       31        0       31         0    10240        0             0 agetty
[121972.660000] [    524]     0   524     1540       28        0       28         0    12288        0             0 agetty
[121972.670000] [    525]     0   525     9098       56       32       24         0    34816        0             0 unattended-upgr
[121972.690000] [    526]     0   526     2621      320        0      320         0    14336      192         -1000 sshd
[121972.700000] [    539]     0   539      849       32       32        0         0     8192        0             0 in.tftpd
[121972.710000] [    544]   113   544     4361        6        6        0         0    16384       25             0 chronyd
[121972.720000] [    546]     0   546    16816       62       32       30         0    45056        0             0 winbindd
[121972.730000] [    552]     0   552    16905       59       32       27         0    45056        3             0 winbindd
[121972.740000] [    559]     0   559    17849       94       32       30        32    49152        4             0 smbd
[121972.750000] [    572]     0   572    17409       40       16       24         0    43008       11             0 smbd-notifyd
[121972.760000] [    573]     0   573    17412       16       16        0         0    43008       24             0 cleanupd
[121972.770000] [    584]     0   584     3036       20        0       20         0    16384        4             0 sshd
[121972.780000] [    589]     0   589    16816       32        2       30         0    40960       21             0 winbindd
[121972.790000] [    590]     0   590    27009       47       23       24         0    65536       21             0 smbd
[121972.810000] [    597]   501   597     3344       91       32       59         0    20480        0           100 systemd
[121972.820000] [    653]   501   653     3036        0        0        0         0    16384       33             0 sshd
[121972.830000] [    656]   501   656     1938       93       32       61         0    12288        9             0 bash
[121972.840000] [    704]     0   704      395      352       64      288         0     6144        0         -1000 watchdog
[121972.850000] [    738]   501   738     2834       12        0       12         0    16384        6             0 top
[121972.860000] [   4750]     0  4750     4218       44       26       18         0    18432       11             0 proftpd
[121972.870000] [   4768]     0  4768      401       31        0       31         0     6144        0             0 apt.systemd.dai
[121972.880000] [   4772]     0  4772      401       31        0       31         0     6144        0             0 apt.systemd.dai
[121972.890000] [   4778]     0  4778    13556       54        0       54         0    59392       26             0 apt-get
[121972.900000] Out of memory and no killable processes...
[121972.910000] Kernel panic - not syncing: System is deadlocked on memory
[121972.920000] CPU: 1 PID: 537 Comm: nfsd Not tainted 6.8.1+nas5xx #nas5xx
[121972.920000] Hardware name: Freescale LS1024A
[121972.930000]  unwind_backtrace from show_stack+0xb/0xc
[121972.930000]  show_stack from dump_stack_lvl+0x2b/0x34
[121972.940000]  dump_stack_lvl from panic+0xbf/0x264
[121972.940000]  panic from out_of_memory+0x33f/0x34c
[121972.950000]  out_of_memory from __alloc_pages+0x8e7/0xbb0
[121972.950000]  __alloc_pages from __alloc_pages_bulk+0x26d/0x3d8
[121972.960000]  __alloc_pages_bulk from svc_recv+0x9d/0x7d4
[121972.960000]  svc_recv from nfsd+0x7d/0xd4
[121972.970000]  nfsd from kthread+0xb9/0xcc
[121972.970000]  kthread from ret_from_fork+0x11/0x1c
[121972.980000] Exception stack(0xc2cadfb0 to 0xc2cadff8)
[121972.980000] dfa0:                                     00000000 00000000 00000000 00000000
[121972.990000] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[121973.000000] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[121973.010000] CPU0: stopping
[121973.010000] CPU: 0 PID: 540 Comm: nfsd Not tainted 6.8.1+nas5xx #nas5xx
[121973.010000] Hardware name: Freescale LS1024A
[121973.010000]  unwind_backtrace from show_stack+0xb/0xc
[121973.010000]  show_stack from dump_stack_lvl+0x2b/0x34
[121973.010000]  dump_stack_lvl from do_handle_IPI+0x151/0x178
[121973.010000]  do_handle_IPI from ipi_handler+0x13/0x18
[121973.010000]  ipi_handler from handle_percpu_devid_irq+0x55/0x144
[121973.010000]  handle_percpu_devid_irq from generic_handle_domain_irq+0x17/0x20
[121973.010000]  generic_handle_domain_irq from gic_handle_irq+0x5f/0x70
[121973.010000]  gic_handle_irq from generic_handle_arch_irq+0x27/0x34
[121973.010000]  generic_handle_arch_irq from call_with_stack+0xd/0x10
[121973.010000] Rebooting in 90 seconds..

