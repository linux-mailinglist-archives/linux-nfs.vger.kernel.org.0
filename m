Return-Path: <linux-nfs+bounces-3331-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E601D8CBD14
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2024 10:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB4928171B
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2024 08:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CC67D096;
	Wed, 22 May 2024 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="D9k6Nsvl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABC97710B
	for <linux-nfs@vger.kernel.org>; Wed, 22 May 2024 08:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716367047; cv=none; b=ZWvaUMgZb+3oghQlIgEZA9evKESCzlVTo+L3EoPAqa52TND5xRm2Y7thA9UdKzBrXy+ovXaMX4fxbhoqg3ZXdcpwEvUT2Fclq8Rw6db317LNdiRr1K/Q75mLOyv1samtHD5iBl+XdzZ/tlo69BLSAS4ZvJ+avV2qxS/5wmF8rBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716367047; c=relaxed/simple;
	bh=E/2HdCTFrFOk8y29cKKNTz/NziOYuWFr2yNH19RxudQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=V0/TyXmAKsDoi39mER3Rvvd210SPu1n129G7YZynWW0fTdphZL+Mtngt6mLew3j23fVmt8Ov+uwP/wG1es0nNn32juD+oUG94DUvaHjUqMkGnV4iGu/LO98KFUBM1ixXj5UwgZzsJ6DN55+2VOPESUmlYVaMxW3U4U/xY1cz0Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=D9k6Nsvl; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59cf8140d0so780291066b.3
        for <linux-nfs@vger.kernel.org>; Wed, 22 May 2024 01:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1716367044; x=1716971844; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AQTwZL4zzpKjMtTu0GIdfSybSPl2kQ5x4Pn4GT8jPk8=;
        b=D9k6NsvlphQ/rJRddDxRWxyPFWCmXIbl59Qnsal6C8lu5OeawFB98s0Jb9a3UaWkPs
         QZELBZa4zPKeOzfyy3eV2MT8pWRDdA+59hbLh02rvuzgWw8TomXRx630plcLYRA9gWxy
         D5U2SkQ5s8DKOgGBCJ0wVuuaB/sZ/013SGiNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716367044; x=1716971844;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AQTwZL4zzpKjMtTu0GIdfSybSPl2kQ5x4Pn4GT8jPk8=;
        b=k9PvbZlXJnMwb9Ng/9oD0UhMuQ8cZ61MxDhs0jvddR5ME+krWuTWHY0FlRnbucLwe3
         GIOYeXjwQgqWoGTwT2xgtdIxILGLsve33xtMQGAjO6v+m0qV+Zu1K2wi8i1AiatpJDdA
         GMrANxvhmP7TJaJoAuDvRP8qNL7/xqrp3B72VeOArDYcCFy1UMfoFoYIFnGRUzP3/aBM
         UTXC9Z5ldOKweOExwRxItd0TEUXdh12sR76d2zjBqZJjGqJykxy7JgvdIYbjzMy5C3EE
         khCnZXcH2ECn4eCXwiNrnXq+D7EyZR8es5vVzeFCGZeXKeWnkfrY0sFTMkWfQKGAhXe3
         rjeg==
X-Gm-Message-State: AOJu0Ywd+1LNxv4dx14dOlD1fUIohZK7pIvrS4IgTIkUYVaFPsaJVEXM
	qpLkM5CNT+ew2GQHM8Vs44WurjxNJpm/9DNyqpz1ruG+TdATvcYk6xJqBMMvMIUky89EplXlIDa
	eScS2WkFyBrQu5yqAtAzYeaYhh9dfg70wUMK7W4Zq3rCCR38=
X-Google-Smtp-Source: AGHT+IEuCfv6knS7PzRwjS5Davs1hGfqn3THliv1wwkxkWBeR9WFnO8yFZ5NHyojDhyYp6C4Gu3QIXKfadmPXzDvfjM=
X-Received: by 2002:a17:907:10d1:b0:a59:c52b:9933 with SMTP id
 a640c23a62f3a-a62280b1d35mr86955066b.30.1716367043712; Wed, 22 May 2024
 01:37:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Wed, 22 May 2024 10:36:57 +0200
Message-ID: <CAK8fFZ7rbh5o9XG1D5KAPSRyES-8W8AphxsLJXOWUFZK49i8fA@mail.gmail.com>
Subject: [regression] nfsstat/nfsd crash system "general protection fault,
 probably for non-canonical address ..." after 6.8.9->6.8.10 update
To: linux-nfs@vger.kernel.org
Cc: Igor Raits <igor@gooddata.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

I would like to report some issue causing a "general protection fault"
crash (constantly) after we updated the kernel from 6.8.9 to 6.8.10.
This is triggered when monitoring is using nfsstat on a server where
nfsd is running.

[ 3049.260633] general protection fault, probably for non-canonical
address 0x66fb103e19e9cc89: 0000 [#1] PREEMPT SMP NOPTI
[ 3049.261628] CPU: 22 PID: 74991 Comm: nfsstat Tainted: G
E      6.8.10-1.gdc.el9.x86_64 #1
[ 3049.262336] Hardware name: RDO OpenStack Compute/RHEL, BIOS
edk2-20240214-2.el9 02/14/2024
[ 3049.263003] RIP: 0010:_raw_spin_lock_irqsave+0x19/0x40
[ 3049.263487] Code: cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
90 0f 1f 44 00 00 41 54 9c 41 5c fa 65 ff 05 a6 92 f5 42 31 c0 ba 01
00 00 00 <f0> 0f b1 17 75 0a 4c 89 e0 41 5c c3 cc cc cc cc 89 c6 e8 d0
07 00
[ 3049.264882] RSP: 0018:ffffb1bca6b9bd00 EFLAGS: 00010046
[ 3049.265365] RAX: 0000000000000000 RBX: 66fb103e19e9c989 RCX: 0000000000000001
[ 3049.265953] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 66fb103e19e9cc89
[ 3049.266542] RBP: ffffffffc15df280 R08: 0000000000000001 R09: ffffa049a1785cb8
[ 3049.267112] R10: ffffb1bca6b9bd70 R11: ffffa04964e49000 R12: 0000000000000246
[ 3049.267702] R13: 66fb103e19e9cc89 R14: ffffa048445590a0 R15: 0000000000000001
[ 3049.268278] FS:  00007fa3ddf03740(0000) GS:ffffa05703d00000(0000)
knlGS:0000000000000000
[ 3049.268928] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3049.269443] CR2: 00007fa3dddfca50 CR3: 0000000342d1e004 CR4: 0000000000770ef0
[ 3049.270025] PKRU: 55555554
[ 3049.270371] Call Trace:
[ 3049.270723]  <TASK>
[ 3049.271035]  ? die_addr+0x33/0x90
[ 3049.271423]  ? exc_general_protection+0x1ea/0x450
[ 3049.271879]  ? asm_exc_general_protection+0x22/0x30
[ 3049.272344]  ? _raw_spin_lock_irqsave+0x19/0x40
[ 3049.272803]  __percpu_counter_sum+0xd/0x70
[ 3049.273219]  nfsd_show+0x4f/0x1d0 [nfsd]
[ 3049.273666]  seq_read_iter+0x11d/0x4d0
[ 3049.274073]  ? avc_has_perm+0x42/0xc0
[ 3049.274489]  seq_read+0xfe/0x140
[ 3049.274866]  proc_reg_read+0x56/0xa0
[ 3049.275257]  vfs_read+0xa7/0x340
[ 3049.275647]  ? __do_sys_newfstat+0x57/0x60
[ 3049.276059]  ksys_read+0x5f/0xe0
[ 3049.276439]  do_syscall_64+0x5e/0x170
[ 3049.276836]  entry_SYSCALL_64_after_hwframe+0x78/0x80
[ 3049.277296] RIP: 0033:0x7fa3ddcfd9b2
[ 3049.277719] Code: c0 e9 b2 fe ff ff 50 48 8d 3d ea 1d 0c 00 e8 c5
fd 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75
10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89
54 24
[ 3049.279139] RSP: 002b:00007ffd930672e8 EFLAGS: 00000246 ORIG_RAX:
0000000000000000
[ 3049.279788] RAX: ffffffffffffffda RBX: 0000555ded47c2a0 RCX: 00007fa3ddcfd9b2
[ 3049.280402] RDX: 0000000000000400 RSI: 0000555ded47c480 RDI: 0000000000000003
[ 3049.281046] RBP: 00007fa3dddf75e0 R08: 0000000000000003 R09: 0000000000000077
[ 3049.281673] R10: 000000000000005d R11: 0000000000000246 R12: 0000555ded47c2a0
[ 3049.282307] R13: 0000000000000d68 R14: 00007fa3dddf69e0 R15: 0000000000000d68
[ 3049.282928]  </TASK>
[ 3049.283310] Modules linked in: mptcp_diag(E) xsk_diag(E)
raw_diag(E) unix_diag(E) af_packet_diag(E) netlink_diag(E) udp_diag(E)
tcp_diag(E) inet_diag(E) tun(E) br_netfilter(E) bridge(E) stp(E)
llc(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E) sunrpc(E)
nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) binfmt_misc(E)
zram(E) tls(E) isofs(E) vfat(E) fat(E) intel_rapl_msr(E)
intel_rapl_common(E) kvm_amd(E) ccp(E) kvm(E) irqbypass(E)
virtio_net(E) i2c_i801(E) virtio_gpu(E) i2c_smbus(E) net_failover(E)
virtio_balloon(E) failover(E) virtio_dma_buf(E) fuse(E) ext4(E)
mbcache(E) jbd2(E) sr_mod(E) cdrom(E) sg(E) ahci(E) libahci(E)
crct10dif_pclmul(E) crc32_pclmul(Ea) polyval_clmulni(E)
polyval_generic(E) libata(E) ghash_clmulni_intel(E) sha512_ssse3(E)
virtio_blk(E) serio_raw(E) btrfs(E) xor(E) zstd_compress(E)
raid6_pq(E) libcrc32c(E) crc32c_intel(E) dm_mirror(E)
dm_region_hash(E) dm_log(E) dm_mod(E)
[ 3049.283345] Unloaded tainted modules: edac_mce_amd(E):1 padlock_aes(E)

Any suggestion on how to fix it is appreciated.

Jaroslav Pulchart

