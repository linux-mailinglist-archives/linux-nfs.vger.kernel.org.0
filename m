Return-Path: <linux-nfs+bounces-17238-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 403B2CD0DF4
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Dec 2025 17:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04A86300AB0E
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Dec 2025 16:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA77C37A3DC;
	Fri, 19 Dec 2025 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M37SawWp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FD937A3E0
	for <linux-nfs@vger.kernel.org>; Fri, 19 Dec 2025 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766159975; cv=none; b=HiT4noyqWHx/Je+PNU2uPSz9ElJkXUWTu7zSONpdtNuPJoW7UNKQXIyd8ZBmrb/1ASdVcpRoE2rM0V1873WEBpbQb/u7FitrYUduM/oXj5C76HDYk5XI1Gy2lhVKsxYurmRjYqab13qFYqpAkC8rs4eKy+CfbS5NA640dgK5Ipg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766159975; c=relaxed/simple;
	bh=f+xKqI5TOB1sbL4B88Y6ego+jy2mfRCBdXj/LH/7g60=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=HaSp4tNV+7u/IEhlLheJFuyESKxInt8e70RjSCyMN2P3kfYAj5tG8vUn4v6Js2fGmv/ANIx/tQ7lM0/1u1TaHEatbduk6wEXeeu4t0jLpWIZGrZttPxEv0BOUErM8qnE8DbqjZjmO1mMtNwdpQe+21q8iNnL/5nj8qcBuS2Tthk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M37SawWp; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8887f43b224so26345566d6.1
        for <linux-nfs@vger.kernel.org>; Fri, 19 Dec 2025 07:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766159972; x=1766764772; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3KYWsPrID3ZhW/qP7RERV0M1MqNhnIYODUaqb12wkA=;
        b=M37SawWpvEKNPVBb8FbwZynfEF7wKJLIJvMM49dAb30U9Mz/QyydOZFP5vW/LgKNqs
         kIDdkkjL0KmjXknPOjUUH7YBbxqz9FfWoNb+UOCPd3t4Vh9cnIJiaIoenFmghDt/5WKk
         QRQt/yrGjEws6H9yvuVi2vX/b7pRRqr+mW0keZv6n7L1Pyz3Hn4uiaUZR6qSi04OnYA3
         HWGnfDByEVf+jS1F36aJA35NWCUzt35u2lQlhcTNbFbB1q+PdjgrsUv7U6RpzASbFFMU
         9OdE86Zseazz9LEcMG8x5Z/rOXkUQKKAQ9kbYHuv8BNFHabS7zDh/2ABdNVYQCGbwjyj
         GP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766159972; x=1766764772;
        h=to:subject:message-id:date:from:reply-to:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h3KYWsPrID3ZhW/qP7RERV0M1MqNhnIYODUaqb12wkA=;
        b=GIbW9I2kQRLA5K+xaxyaqyFuXl21P8zn58debIPJPJqoGFg3Dd3Yzl7DUN3SmXasRJ
         yATTU/P2gAxH8hyCJA1Yn1ge++DiYZeqFCMhs5P9ptKiQz0ZXU76LmfwADtHoadP6zBb
         INehGhko42OXk095COs/liG1sakOW/67YJSkMNoYCZoZiL0Ez/v0EZ5V2HaXfGgEyhxA
         V0B3yOUJuTur1wEMNjjlw4JA/kPmM2EU34phZTi08RQQ1Jb+fpxjpl/Fgkfw8usc8gwZ
         VHdCEQMMk/TUwodkh8G+Z/3ZR2praiChaymGTuBY5bG6ttm/rAnUOTW0UY/zIy9U9KaS
         XAsQ==
X-Gm-Message-State: AOJu0YytzDZFXrUpU+M2MPzZ9Gc17hVM37SeFmmxrLUiS/OIbUnkg+zi
	UOMEUlIVlKy8Z0T0diPWzB4a5zKwL/78+YJZ90YSe4rd8U1PfQArQxmkixfVFCJxSZ6CSzO3jw/
	Sio/YycfoVAeWrY4aNL2Y9ZiGAgtAYmjmOP+k
X-Gm-Gg: AY/fxX4DCwHojgsLnG5TusIR5XJW5E3bIfj00iXWjYRuQ3p3uP5XHTxkXDVCoNJqyMr
	Yl6Fw0d/6tLgNVUhcpyc56Ko7WcRXYrkVBcEh5nU3pIk1E5FgjsyalmhpE/QWj+1fZtheMDRSCq
	Fgq+Ogd3HErDyYCw2Zo/j69VDb11t/WDkCRi5u0YZlU7HeVEapQBZpvSkda0PQpajVci9nxkBEJ
	yRxxjfhvLiC2OUDEH6zVfdzfui2n+p/Kwu7syivDcb56JvslMJHhK91QFh+Y/SA1Omr4e0cmeHQ
	sidz/fbchpiD49KEieHziuoeVg==
X-Google-Smtp-Source: AGHT+IEKPcySe6wZalyLgA5xsOaaS/CeCkkfm921swXgEXC3XokFwdWb5LIJ6v+x7NSHIOpSfW7AlrQROdD7Pl9Eqqc=
X-Received: by 2002:ad4:4210:0:b0:88a:22fb:38f5 with SMTP id
 6a1803df08f44-88d8166a2demr36792866d6.13.1766159971973; Fri, 19 Dec 2025
 07:59:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: mjnowen@gmail.com
From: Mike Owen <mjnowen@gmail.com>
Date: Fri, 19 Dec 2025 15:59:20 +0000
X-Gm-Features: AQt7F2pTsqeN4lcOzZiV73oPXmtrRKIPhHJD3R-o1wwOuKb98ken02H0Lx4pgyE
Message-ID: <CADFF-zeNJUPLaVcogSBt=s4+o2Lty45-DueSYKJmCgZw6hraEg@mail.gmail.com>
Subject: fscache/NFS re-export server lockup
To: linux-nfs@vger.kernel.org, netfs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

We are using NFS re-exporting with fscache but have had a number of
lockups with re-export servers.

The NFS re-export servers are running Ubuntu 24.04 with a
6.14.0-36-generic kernel mounting Isilon and NetApp filers over NFSv3.

The NFS clients are mounting the re-exported shares over NFSv4 and
running AlmaLinux 9.6.

When the re-export server locks up, it is not possible to access the
/var/cache/fscache directory (separate file system) on the server and
all clients are hanging on their mounts from the re-export.

When the server is rebooted, most of the contents of the
/var/cache/fscache directory is missing e.g. the file system contents
before the lockup may have been a few TBs, but after a reboot only a
few hundred GBs.

The kern.log (below) from the re-export server reports the following
when the lockup happens.

We have tried using a more recent 6.17.11 kernel on the re-export
server and changing the fscache file system from ext4 to xfs, but
still have the same lockups.

Any ideas on what is happening here - and how it may be fixed?

2025-12-03T15:54:24.189530+00:00 ip-172-23-113-43 kernel: netfs:
fscache_begin_operation: cookie state change wait timed out:
cookie->state=1 state=1
2025-12-03T15:54:24.189546+00:00 ip-172-23-113-43 kernel: netfs:
fscache_begin_operation: cookie state change wait timed out:
cookie->state=1 state=1
2025-12-03T15:54:24.189549+00:00 ip-172-23-113-43 kernel: netfs:
O-cookie c=00049c53 [fl=6124 na=1 nA=2 s=L]
2025-12-03T15:54:24.189550+00:00 ip-172-23-113-43 kernel: netfs:
O-cookie c=0004ddfe [fl=4124 na=1 nA=2 s=L]
2025-12-03T15:54:24.189551+00:00 ip-172-23-113-43 kernel: netfs:
O-cookie V=0000000a
[Enfs,4.2,2,108,887517ac,2,,,50,100000,100000,927c0,927c0,927c0,927c0,1]
2025-12-03T15:54:24.189552+00:00 ip-172-23-113-43 kernel: netfs:
O-cookie V=0000000f
[Enfs,4.2,2,108,887517ac,3,,,50,100000,100000,927c0,927c0,927c0,927c0,1]
2025-12-03T15:54:24.189553+00:00 ip-172-23-113-43 kernel: netfs:
O-key=[56] '0100010c0200000008000000e7ba9075008000002000f360d67b09000000e7ba907508000000ffffffff000000000b00700b010000000000'
2025-12-03T15:54:24.190876+00:00 ip-172-23-113-43 kernel: netfs:
O-key=[56] '0100010c03000000070000002fbb9934008000002000f360d67b060000002fbb993407000000ffffffff000000000200c109010000000000'
2025-12-03T15:54:24.702103+00:00 ip-172-23-113-43 kernel: netfs:
fscache_begin_operation: cookie state change wait timed out:
cookie->state=1 state=1
2025-12-03T15:54:24.702112+00:00 ip-172-23-113-43 kernel: netfs:
O-cookie c=000404b3 [fl=6124 na=1 nA=2 s=L]
2025-12-03T15:54:24.702113+00:00 ip-172-23-113-43 kernel: netfs:
O-cookie V=0000000f
[Enfs,4.2,2,108,887517ac,3,,,50,100000,100000,927c0,927c0,927c0,927c0,1]
2025-12-03T15:54:24.703856+00:00 ip-172-23-113-43 kernel: netfs:
O-key=[56] '0100010c03000000070000007ece2438008000002000f360d67b060000007ece243807000000ffffffff000000000200c109010000000000'
2025-12-03T15:57:25.438905+00:00 ip-172-23-113-43 kernel: INFO: task
kcompactd0:171 blocked for more than 122 seconds.
2025-12-03T15:57:25.438921+00:00 ip-172-23-113-43 kernel:
Tainted: G           OE      6.14.0-36-generic #36~24.04.1-Ubuntu
2025-12-03T15:57:25.438928+00:00 ip-172-23-113-43 kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
2025-12-03T15:57:25.439 is bellow995+00:00 ip-172-23-113-43 kernel:
task:kcompactd0      state:D stack:0     pid:171   tgid:171   ppid:2
   task_flags:0x210040 flags:0x00004000
2025-12-03T15:57:25.440000+00:00 ip-172-23-113-43 kernel: Call Trace:
2025-12-03T15:57:25.440000+00:00 ip-172-23-113-43 kernel:  <TASK>
2025-12-03T15:57:25.440003+00:00 ip-172-23-113-43 kernel:
__schedule+0x2cf/0x640
2025-12-03T15:57:25.441017+00:00 ip-172-23-113-43 kernel:  schedule+0x29/0xd0
2025-12-03T15:57:25.441022+00:00 ip-172-23-113-43 kernel:  io_schedule+0x4c/0x80
2025-12-03T15:57:25.441023+00:00 ip-172-23-113-43 kernel:
folio_wait_bit_common+0x138/0x310
2025-12-03T15:57:25.441023+00:00 ip-172-23-113-43 kernel:  ?
__pfx_wake_page_function+0x10/0x10
2025-12-03T15:57:25.441024+00:00 ip-172-23-113-43 kernel:
folio_wait_private_2+0x2c/0x60
2025-12-03T15:57:25.441025+00:00 ip-172-23-113-43 kernel:
nfs_release_folio+0xa0/0x120 [nfs]
2025-12-03T15:57:25.441032+00:00 ip-172-23-113-43 kernel:
filemap_release_folio+0x68/0xa0
2025-12-03T15:57:25.441033+00:00 ip-172-23-113-43 kernel:
split_huge_page_to_list_to_order+0x401/0x970
2025-12-03T15:57:25.441033+00:00 ip-172-23-113-43 kernel:  ?
compaction_alloc_noprof+0x1c5/0x2f0
2025-12-03T15:57:25.441034+00:00 ip-172-23-113-43 kernel:
split_folio_to_list+0x22/0x70
2025-12-03T15:57:25.441035+00:00 ip-172-23-113-43 kernel:
migrate_pages_batch+0x2f2/0xa70
2025-12-03T15:57:25.441035+00:00 ip-172-23-113-43 kernel:  ?
__pfx_compaction_free+0x10/0x10
2025-12-03T15:57:25.441038+00:00 ip-172-23-113-43 kernel:  ?
__pfx_compaction_alloc+0x10/0x10
2025-12-03T15:57:25.441039+00:00 ip-172-23-113-43 kernel:  ?
__mod_memcg_lruvec_state+0xf4/0x250
2025-12-03T15:57:25.441039+00:00 ip-172-23-113-43 kernel:  ?
migrate_pages_batch+0x5e8/0xa70
2025-12-03T15:57:25.441040+00:00 ip-172-23-113-43 kernel:
migrate_pages_sync+0x84/0x1e0
2025-12-03T15:57:25.441040+00:00 ip-172-23-113-43 kernel:  ?
__pfx_compaction_free+0x10/0x10
2025-12-03T15:57:25.441041+00:00 ip-172-23-113-43 kernel:  ?
__pfx_compaction_alloc+0x10/0x10
2025-12-03T15:57:25.441044+00:00 ip-172-23-113-43 kernel:
migrate_pages+0x38f/0x4c0
2025-12-03T15:57:25.441047+00:00 ip-172-23-113-43 kernel:  ?
__pfx_compaction_free+0x10/0x10
2025-12-03T15:57:25.441048+00:00 ip-172-23-113-43 kernel:  ?
__pfx_compaction_alloc+0x10/0x10
2025-12-03T15:57:25.441048+00:00 ip-172-23-113-43 kernel:
compact_zone+0x385/0x700
2025-12-03T15:57:25.441049+00:00 ip-172-23-113-43 kernel:  ?
isolate_migratepages_range+0xc1/0xf0
2025-12-03T15:57:25.441049+00:00 ip-172-23-113-43 kernel:
kcompactd_do_work+0xfc/0x240
2025-12-03T15:57:25.441050+00:00 ip-172-23-113-43 kernel:  kcompactd+0x43f/0x4a0
2025-12-03T15:57:25.441052+00:00 ip-172-23-113-43 kernel:  ?
__pfx_autoremove_wake_function+0x10/0x10
2025-12-03T15:57:25.441053+00:00 ip-172-23-113-43 kernel:  ?
__pfx_kcompactd+0x10/0x10
2025-12-03T15:57:25.441053+00:00 ip-172-23-113-43 kernel:  kthread+0xfe/0x230
2025-12-03T15:57:25.441054+00:00 ip-172-23-113-43 kernel:  ?
__pfx_kthread+0x10/0x10
2025-12-03T15:57:25.441054+00:00 ip-172-23-113-43 kernel:
ret_from_fork+0x47/0x70
2025-12-03T15:57:25.441055+00:00 ip-172-23-113-43 kernel:  ?
__pfx_kthread+0x10/0x10
2025-12-03T15:57:25.441057+00:00 ip-172-23-113-43 kernel:
ret_from_fork_asm+0x1a/0x30
2025-12-03T15:57:25.441058+00:00 ip-172-23-113-43 kernel:  </TASK>
2025-12-03T15:57:25.441059+00:00 ip-172-23-113-43 kernel: INFO: task
jbd2/md127-8:6401 blocked for more than 122 seconds.
2025-12-03T15:57:25.441059+00:00 ip-172-23-113-43 kernel:
Tainted: G           OE      6.14.0-36-generic #36~24.04.1-Ubuntu
2025-12-03T15:57:25.443097+00:00 ip-172-23-113-43 kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
2025-12-03T15:57:25.445001+00:00 ip-172-23-113-43 kernel:
task:jbd2/md127-8    state:D stack:0     pid:6401  tgid:6401  ppid:2
   task_flags:0x240040 flags:0x00004000
2025-12-03T15:57:25.445005+00:00 ip-172-23-113-43 kernel: Call Trace:
2025-12-03T15:57:25.445006+00:00 ip-172-23-113-43 kernel:  <TASK>
2025-12-03T15:57:25.445006+00:00 ip-172-23-113-43 kernel:
__schedule+0x2cf/0x640
2025-12-03T15:57:25.445007+00:00 ip-172-23-113-43 kernel:  schedule+0x29/0xd0
2025-12-03T15:57:25.445007+00:00 ip-172-23-113-43 kernel:
jbd2_journal_wait_updates+0x71/0xf0
2025-12-03T15:57:25.445008+00:00 ip-172-23-113-43 kernel:  ?
__pfx_autoremove_wake_function+0x10/0x10
2025-12-03T15:57:25.445008+00:00 ip-172-23-113-43 kernel:
jbd2_journal_commit_transaction+0x26e/0x1800
2025-12-03T15:57:25.445009+00:00 ip-172-23-113-43 kernel:  ?
__update_idle_core+0x58/0x130
2025-12-03T15:57:25.445010+00:00 ip-172-23-113-43 kernel:  ?
psi_group_change+0x201/0x4e0
2025-12-03T15:57:25.445010+00:00 ip-172-23-113-43 kernel:  ?
psi_task_switch+0x130/0x3a0
2025-12-03T15:57:25.445011+00:00 ip-172-23-113-43 kernel:  kjournald2+0xaa/0x250
2025-12-03T15:57:25.445011+00:00 ip-172-23-113-43 kernel:  ?
__pfx_autoremove_wake_function+0x10/0x10
2025-12-03T15:57:25.445012+00:00 ip-172-23-113-43 kernel:  ?
__pfx_kjournald2+0x10/0x10
2025-12-03T15:57:25.445012+00:00 ip-172-23-113-43 kernel:  kthread+0xfe/0x230
2025-12-03T15:57:25.445015+00:00 ip-172-23-113-43 kernel:  ?
__pfx_kthread+0x10/0x10
2025-12-03T15:57:25.445016+00:00 ip-172-23-113-43 kernel:
ret_from_fork+0x47/0x70
2025-12-03T15:57:25.445017+00:00 ip-172-23-113-43 kernel:  ?
__pfx_kthread+0x10/0x10
2025-12-03T15:57:25.445018+00:00 ip-172-23-113-43 kernel:
ret_from_fork_asm+0x1a/0x30
2025-12-03T15:57:25.445018+00:00 ip-172-23-113-43 kernel:  </TASK>
2025-12-03T15:57:25.445019+00:00 ip-172-23-113-43 kernel: INFO: task
nfsd:6783 blocked for more than 122 seconds.
2025-12-03T15:57:25.445020+00:00 ip-172-23-113-43 kernel:
Tainted: G           OE      6.14.0-36-generic #36~24.04.1-Ubuntu
2025-12-03T15:57:25.445023+00:00 ip-172-23-113-43 kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
2025-12-03T15:57:25.447708+00:00 ip-172-23-113-43 kernel: task:nfsd
        state:D stack:0     pid:6783  tgid:6783  ppid:2
task_flags:0x240040 flags:0x00004000
2025-12-03T15:57:25.447713+00:00 ip-172-23-113-43 kernel: Call Trace:
2025-12-03T15:57:25.447714+00:00 ip-172-23-113-43 kernel:  <TASK>
2025-12-03T15:57:25.447714+00:00 ip-172-23-113-43 kernel:
__schedule+0x2cf/0x640
2025-12-03T15:57:25.447715+00:00 ip-172-23-113-43 kernel:  schedule+0x29/0xd0
2025-12-03T15:57:25.447716+00:00 ip-172-23-113-43 kernel:
schedule_preempt_disabled+0x15/0x30
2025-12-03T15:57:25.447716+00:00 ip-172-23-113-43 kernel:
rwsem_down_read_slowpath+0x261/0x490
2025-12-03T15:57:25.447717+00:00 ip-172-23-113-43 kernel:  ?
mempool_alloc_slab+0x15/0x20
2025-12-03T15:57:25.447717+00:00 ip-172-23-113-43 kernel:  down_read+0x48/0xd0
2025-12-03T15:57:25.447718+00:00 ip-172-23-113-43 kernel:
ext4_llseek+0xfc/0x120
2025-12-03T15:57:25.447719+00:00 ip-172-23-113-43 kernel:  vfs_llseek+0x1c/0x40
2025-12-03T15:57:25.447719+00:00 ip-172-23-113-43 kernel:
cachefiles_do_prepare_read+0xc1/0x3d0 [cachefiles]
2025-12-03T15:57:25.447720+00:00 ip-172-23-113-43 kernel:
cachefiles_prepare_read+0x32/0x50 [cachefiles]
2025-12-03T15:57:25.447720+00:00 ip-172-23-113-43 kernel:
netfs_read_to_pagecache+0xc1/0x530 [netfs]
2025-12-03T15:57:25.447721+00:00 ip-172-23-113-43 kernel:
netfs_readahead+0x169/0x270 [netfs]
2025-12-03T15:57:25.447735+00:00 ip-172-23-113-43 kernel:
nfs_netfs_readahead+0x1f/0x40 [nfs]
2025-12-03T15:57:25.447736+00:00 ip-172-23-113-43 kernel:
nfs_readahead+0x184/0x2b0 [nfs]
2025-12-03T15:57:25.447737+00:00 ip-172-23-113-43 kernel:  read_pages+0x85/0x220
2025-12-03T15:57:25.447737+00:00 ip-172-23-113-43 kernel:  ?
__pfx_workingset_update_node+0x10/0x10
2025-12-03T15:57:25.447738+00:00 ip-172-23-113-43 kernel:
page_cache_ra_unbounded+0x18e/0x240
2025-12-03T15:57:25.447738+00:00 ip-172-23-113-43 kernel:
page_cache_sync_ra+0x228/0x230
2025-12-03T15:57:25.447739+00:00 ip-172-23-113-43 kernel:
filemap_get_pages+0x133/0x4a0
2025-12-03T15:57:25.447740+00:00 ip-172-23-113-43 kernel:
filemap_splice_read+0x155/0x380
2025-12-03T15:57:25.447740+00:00 ip-172-23-113-43 kernel:  ?
find_inode+0xd9/0x100
2025-12-03T15:57:25.447741+00:00 ip-172-23-113-43 kernel:
nfs_file_splice_read+0xba/0xf0 [nfs]
2025-12-03T15:57:25.447741+00:00 ip-172-23-113-43 kernel:
do_splice_read+0x63/0xe0
2025-12-03T15:57:25.447742+00:00 ip-172-23-113-43 kernel:
splice_direct_to_actor+0xb1/0x260
2025-12-03T15:57:25.447743+00:00 ip-172-23-113-43 kernel:  ?
__pfx_nfsd_direct_splice_actor+0x10/0x10 [nfsd]
2025-12-03T15:57:25.447743+00:00 ip-172-23-113-43 kernel:
nfsd_splice_read+0x11b/0x130 [nfsd]
2025-12-03T15:57:25.447744+00:00 ip-172-23-113-43 kernel:
nfsd4_encode_splice_read+0x65/0x120 [nfsd]
2025-12-03T15:57:25.447744+00:00 ip-172-23-113-43 kernel:
nfsd4_encode_read+0x132/0x170 [nfsd]
2025-12-03T15:57:25.447745+00:00 ip-172-23-113-43 kernel:
nfsd4_encode_operation+0xd4/0x350 [nfsd]
2025-12-03T15:57:25.447745+00:00 ip-172-23-113-43 kernel:
nfsd4_proc_compound+0x1da/0x7d0 [nfsd]
2025-12-03T15:57:25.447746+00:00 ip-172-23-113-43 kernel:
nfsd_dispatch+0xd7/0x220 [nfsd]
2025-12-03T15:57:25.447746+00:00 ip-172-23-113-43 kernel:
svc_process_common+0x4c6/0x740 [sunrpc]
2025-12-03T15:57:25.447747+00:00 ip-172-23-113-43 kernel:  ?
__pfx_nfsd_dispatch+0x10/0x10 [nfsd]
2025-12-03T15:57:25.447747+00:00 ip-172-23-113-43 kernel:
svc_process+0x136/0x1f0 [sunrpc]
2025-12-03T15:57:25.447748+00:00 ip-172-23-113-43 kernel:
svc_handle_xprt+0x46e/0x570 [sunrpc]
2025-12-03T15:57:25.447751+00:00 ip-172-23-113-43 kernel:
svc_recv+0x184/0x2e0 [sunrpc]
2025-12-03T15:57:25.447752+00:00 ip-172-23-113-43 kernel:  ?
__pfx_nfsd+0x10/0x10 [nfsd]
2025-12-03T15:57:25.447752+00:00 ip-172-23-113-43 kernel:  nfsd+0x90/0xf0 [nfsd]
2025-12-03T15:57:25.447753+00:00 ip-172-23-113-43 kernel:  kthread+0xfe/0x230
2025-12-03T15:57:25.447753+00:00 ip-172-23-113-43 kernel:  ?
__pfx_kthread+0x10/0x10
2025-12-03T15:57:25.447754+00:00 ip-172-23-113-43 kernel:
ret_from_fork+0x47/0x70
2025-12-03T15:57:25.447756+00:00 ip-172-23-113-43 kernel:  ?
__pfx_kthread+0x10/0x10
2025-12-03T15:57:25.447757+00:00 ip-172-23-113-43 kernel:
ret_from_fork_asm+0x1a/0x30
2025-12-03T15:57:25.447757+00:00 ip-172-23-113-43 kernel:  </TASK>

