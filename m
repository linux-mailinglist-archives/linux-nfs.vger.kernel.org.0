Return-Path: <linux-nfs+bounces-7921-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37519C6807
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 05:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41194B22B6A
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 04:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186B7433CE;
	Wed, 13 Nov 2024 04:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AXSTBP6P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C5F230984;
	Wed, 13 Nov 2024 04:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731471612; cv=none; b=XL59MSDfrak6lm24vgi3uv28DAYiTyMME7jnYxfsxcaTRpk4pyoT+vWhYkZ/DF+wqg5VVUyD0wWfqfeaDrfwfScNssZQOeSfx9jdht6JgyeZP4p8pvV/jCotOf7CaGOQEgFfp4bGseDO0RjajRTEu0MpsVzuVGKltXHGOGAXjrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731471612; c=relaxed/simple;
	bh=jhWwP/O8JhvbiiG5pI0v3W7Vre4PvvpIYErYutz+W1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IRrol2pbmci0rQVnRduYj0awdvmy00CI1epCJvNjGCc2Nu1Hh20JNGNE00cIPcQgj3LIotcoMo/liPhqBc7yJEleLo74YyihpotC20g+NfdAuzRfkDD+WBIn1qJNeXiNalW1W17q7uIH8jJ5dO6fDqX2nF7gsSyvrghjGOqndBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=AXSTBP6P; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731471610; x=1763007610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pg9mM9J6Dxw/+7gv+bmmeu5fOzsl43yYd8X2FRBzK08=;
  b=AXSTBP6POrNgJZfzqEPaEacI5lFHcrX/3JG40N186rlt7W7CmYjW0pNH
   IOrz6Uq/Es3V1/jOSwcl8wTkkav99d0/BECBL8JdBt5sYbNoigm1ZXs0E
   MvxSUpvdnFAT65pugU3unMVL/8QQfBPjG6MLeqbHfFrGZ4JNmZKEo3sMq
   0=;
X-IronPort-AV: E=Sophos;i="6.12,150,1728950400"; 
   d="scan'208";a="351877170"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 04:20:08 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:27141]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.214:2525] with esmtp (Farcaster)
 id fdf33349-ad14-4138-a6ff-216e54c47000; Wed, 13 Nov 2024 04:20:08 +0000 (UTC)
X-Farcaster-Flow-ID: fdf33349-ad14-4138-a6ff-216e54c47000
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 13 Nov 2024 04:20:06 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 13 Nov 2024 04:20:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <liujian56@huawei.com>
CC: <Dai.Ngo@oracle.com>, <anna@kernel.org>, <chuck.lever@oracle.com>,
	<davem@davemloft.net>, <ebiederm@xmission.com>, <edumazet@google.com>,
	<horms@kernel.org>, <jlayton@kernel.org>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-nfs@vger.kernel.org>, <neilb@suse.de>,
	<netdev@vger.kernel.org>, <okorniev@redhat.com>, <pabeni@redhat.com>,
	<tom@talpey.com>, <trondmy@kernel.org>
Subject: Re: [PATCH net v4] sunrpc: fix one UAF issue caused by sunrpc kernel tcp socket
Date: Tue, 12 Nov 2024 20:19:58 -0800
Message-ID: <20241113041958.56568-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241112135434.803890-1-liujian56@huawei.com>
References: <20241112135434.803890-1-liujian56@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Liu Jian <liujian56@huawei.com>
Date: Tue, 12 Nov 2024 21:54:34 +0800
> BUG: KASAN: slab-use-after-free in tcp_write_timer_handler+0x156/0x3e0
> Read of size 1 at addr ffff888111f322cd by task swapper/0/0
> 
> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-rc4-dirty #7
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1
> Call Trace:
>  <IRQ>
>  dump_stack_lvl+0x68/0xa0
>  print_address_description.constprop.0+0x2c/0x3d0
>  print_report+0xb4/0x270
>  kasan_report+0xbd/0xf0
>  tcp_write_timer_handler+0x156/0x3e0
>  tcp_write_timer+0x66/0x170
>  call_timer_fn+0xfb/0x1d0
>  __run_timers+0x3f8/0x480
>  run_timer_softirq+0x9b/0x100
>  handle_softirqs+0x153/0x390
>  __irq_exit_rcu+0x103/0x120
>  irq_exit_rcu+0xe/0x20
>  sysvec_apic_timer_interrupt+0x76/0x90
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> RIP: 0010:default_idle+0xf/0x20
> Code: 4c 01 c7 4c 29 c2 e9 72 ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90
>  90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 33 f8 25 00 fb f4 <fa> c3 cc cc cc
>  cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
> RSP: 0018:ffffffffa2007e28 EFLAGS: 00000242
> RAX: 00000000000f3b31 RBX: 1ffffffff4400fc7 RCX: ffffffffa09c3196
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff9f00590f
> RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed102360835d
> R10: ffff88811b041aeb R11: 0000000000000001 R12: 0000000000000000
> R13: ffffffffa202d7c0 R14: 0000000000000000 R15: 00000000000147d0
>  default_idle_call+0x6b/0xa0
>  cpuidle_idle_call+0x1af/0x1f0
>  do_idle+0xbc/0x130
>  cpu_startup_entry+0x33/0x40
>  rest_init+0x11f/0x210
>  start_kernel+0x39a/0x420
>  x86_64_start_reservations+0x18/0x30
>  x86_64_start_kernel+0x97/0xa0
>  common_startup_64+0x13e/0x141
>  </TASK>
> 
> Allocated by task 595:
>  kasan_save_stack+0x24/0x50
>  kasan_save_track+0x14/0x30
>  __kasan_slab_alloc+0x87/0x90
>  kmem_cache_alloc_noprof+0x12b/0x3f0
>  copy_net_ns+0x94/0x380
>  create_new_namespaces+0x24c/0x500
>  unshare_nsproxy_namespaces+0x75/0xf0
>  ksys_unshare+0x24e/0x4f0
>  __x64_sys_unshare+0x1f/0x30
>  do_syscall_64+0x70/0x180
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Freed by task 100:
>  kasan_save_stack+0x24/0x50
>  kasan_save_track+0x14/0x30
>  kasan_save_free_info+0x3b/0x60
>  __kasan_slab_free+0x54/0x70
>  kmem_cache_free+0x156/0x5d0
>  cleanup_net+0x5d3/0x670
>  process_one_work+0x776/0xa90
>  worker_thread+0x2e2/0x560
>  kthread+0x1a8/0x1f0
>  ret_from_fork+0x34/0x60
>  ret_from_fork_asm+0x1a/0x30
> 
> Reproduction script:
> 
> mkdir -p /mnt/nfsshare
> mkdir -p /mnt/nfs/netns_1
> mkfs.ext4 /dev/sdb
> mount /dev/sdb /mnt/nfsshare
> systemctl restart nfs-server
> chmod 777 /mnt/nfsshare
> exportfs -i -o rw,no_root_squash *:/mnt/nfsshare
> 
> ip netns add netns_1
> ip link add name veth_1_peer type veth peer veth_1
> ifconfig veth_1_peer 11.11.0.254 up
> ip link set veth_1 netns netns_1
> ip netns exec netns_1 ifconfig veth_1 11.11.0.1
> 
> ip netns exec netns_1 /root/iptables -A OUTPUT -d 11.11.0.254 -p tcp \
> 	--tcp-flags FIN FIN  -j DROP
> 
> (note: In my environment, a DESTROY_CLIENTID operation is always sent
>  immediately, breaking the nfs tcp connection.)
> ip netns exec netns_1 timeout -s 9 300 mount -t nfs -o proto=tcp,vers=4.1 \
> 	11.11.0.254:/mnt/nfsshare /mnt/nfs/netns_1
> 
> ip netns del netns_1
> 
> The reason here is that the tcp socket in netns_1 (nfs side) has been
> shutdown and closed (done in xs_destroy), but the FIN message (with ack)
> is discarded, and the nfsd side keeps sending retransmission messages.
> As a result, when the tcp sock in netns_1 processes the received message,
> it sends the message (FIN message) in the sending queue, and the tcp timer
> is re-established. When the network namespace is deleted, the net structure
> accessed by tcp's timer handler function causes problems.
> 
> To fix this problem, let's hold netns refcnt for the tcp kernel socket as
> done in other modules. This is an ugly hack which can easily be backported
> to earlier kernels. A proper fix which cleans up the interfaces will
> follow, but may not be so easy to backport.
> 
> Fixes: 26abe14379f8 ("net: Modify sk_alloc to not reference count the netns of kernel sockets.")
> Signed-off-by: Liu Jian <liujian56@huawei.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

