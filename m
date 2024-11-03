Return-Path: <linux-nfs+bounces-7631-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 581BA9BA3DE
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Nov 2024 05:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B253C1F217DB
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Nov 2024 04:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B2A70818;
	Sun,  3 Nov 2024 04:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="k6EnXy05"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71990B658;
	Sun,  3 Nov 2024 04:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730606988; cv=none; b=bUjaOg0PwtHDNqwLSd3HCqdZc9l7Ca72VpRLca/2QPk0CIlgouNpMO6QSub9Gr8INY8Dytita4gZ9ZbuJTGTYvQ7bMhL1yPgQxJl7xshu90Z2KNXC5Xq4p6UbrIFYjF0hsDixt/2nFPL09RL4pv2HwNJHNsgGl3N31WNYApinDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730606988; c=relaxed/simple;
	bh=hj4aR2fI7wIiGSSTCS7+S+YO0S6MXTJVZHsyp90aiiI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i9ElRY7J6/Y6VR6oIQBDYZv0zJvJzulKVwZkZ+lgY7oudO9xeQi6l6U7d8uAlTMC9IQgwqUW3+Z3hpo5hqIFkjQpV4j8HWH9hUBuOasxaQtcaR+QOXOvS8tO4ZEo7x9vnO2bWn4kjOMUsQ51XxVLiRgkSnJt4Kh+foYkprDApgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=k6EnXy05; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730606987; x=1762142987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HAYZhxyF+7Y8mdCHyjFpHaaYt3qThfOehzVO99sYLpQ=;
  b=k6EnXy05B/ITKDh/LsiTf1bug7hNgMQjRGyA9y2+KDLrwHrF6M4uFwtO
   hph+ETDgCKT0gS7gNjwBBCf6yNEoKlV+Y0Y++xdnqIIXXzg2ILte3GpUL
   qzJ6fFDBb45NfAoqUEQvgs7TvGvDis0jGcFEv129MO4XgSW22t67/poSb
   k=;
X-IronPort-AV: E=Sophos;i="6.11,254,1725321600"; 
   d="scan'208";a="436730724"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 04:09:42 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:30669]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.16:2525] with esmtp (Farcaster)
 id 0f74d6db-0dcd-47a4-83c4-fa8824a0254b; Sun, 3 Nov 2024 04:09:41 +0000 (UTC)
X-Farcaster-Flow-ID: 0f74d6db-0dcd-47a4-83c4-fa8824a0254b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sun, 3 Nov 2024 04:09:40 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.63) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Sun, 3 Nov 2024 04:09:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <liujian56@huawei.com>
CC: <Dai.Ngo@oracle.com>, <anna@kernel.org>, <chuck.lever@oracle.com>,
	<davem@davemloft.net>, <ebiederm@xmission.com>, <edumazet@google.com>,
	<geert+renesas@glider.be>, <jlayton@kernel.org>, <kuba@kernel.org>,
	<linux-nfs@vger.kernel.org>, <neilb@suse.de>, <netdev@vger.kernel.org>,
	<ofir.gal@volumez.com>, <okorniev@redhat.com>, <pabeni@redhat.com>,
	<tom@talpey.com>, <trondmy@kernel.org>, <kuniyu@amazon.com>
Subject: Re: [PATCH net v2] sunrpc: fix one UAF issue caused by sunrpc kernel tcp socket
Date: Sat, 2 Nov 2024 21:09:34 -0700
Message-ID: <20241103040934.13958-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241030094953.1921574-1-liujian56@huawei.com>
References: <20241030094953.1921574-1-liujian56@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC004.ant.amazon.com (10.13.139.229) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Liu Jian <liujian56@huawei.com>
Date: Wed, 30 Oct 2024 17:49:53 +0800
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
> To fix this problem:
> Add the sock_create_kern_getnet() helper function, add the get_net()
>  operation for the kernel socket.
> 
> Fixes: 26abe14379f8 ("net: Modify sk_alloc to not reference count the netns of kernel sockets.")
> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---
> v1: https://lore.kernel.org/all/20241024015543.568476-1-liujian56@huawei.com/
> v1->v2: change to get netns reference count.
>  include/linux/net.h   |  1 +
>  net/socket.c          | 28 ++++++++++++++++++++++++++++
>  net/sunrpc/svcsock.c  |  2 +-
>  net/sunrpc/xprtsock.c |  2 +-
>  4 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/net.h b/include/linux/net.h
> index b75bc534c1b3..58216da3b62c 100644
> --- a/include/linux/net.h
> +++ b/include/linux/net.h
> @@ -255,6 +255,7 @@ int __sock_create(struct net *net, int family, int type, int proto,
>  		  struct socket **res, int kern);
>  int sock_create(int family, int type, int proto, struct socket **res);
>  int sock_create_kern(struct net *net, int family, int type, int proto, struct socket **res);
> +int sock_create_kern_getnet(struct net *net, int family, int type, int proto, struct socket **res);
>  int sock_create_lite(int family, int type, int proto, struct socket **res);
>  struct socket *sock_alloc(void);
>  void sock_release(struct socket *sock);
> diff --git a/net/socket.c b/net/socket.c
> index 042451f01c65..e64a02445b1a 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -1651,6 +1651,34 @@ int sock_create_kern(struct net *net, int family, int type, int protocol, struct
>  }
>  EXPORT_SYMBOL(sock_create_kern);
>  
> +int sock_create_kern_getnet(struct net *net, int family, int type, int proto, struct socket **res)
> +{
> +	struct sock *sk;
> +	int ret;
> +
> +	if (!maybe_get_net(net))
> +		return -EINVAL;

Is this really safe ?

IIUC, maybe_get_net() is safe for a net only when it is fetched under
RCU, then rcu_read_lock() prevents cleanup_net() from reusing the net
by rcu_barrier().

Otherwise, there should be a small chance that the same slab object is
reused for another netns between fetching the net and reaching here.

svc_create_socket() is called much later after the netns is fetched,
and _svc_xprt_create() calls try_module_get() before ->xpo_create().
So, it seems the path is not under RCU and maybe_get_net() must be
called much earlier by each call site.

For this reason, when I write a patch for the same issue in CIFS,
I delayed put_net() to cifsd kthread so that the netns refcnt taken
for each CIFS server info lives until the last __sock_create() attempt
from cifsd.

https://lore.kernel.org/linux-cifs/20241102212438.76691-1-kuniyu@amazon.com/


> +
> +	ret = sock_create_kern(net, family, type, proto, res);
> +	if (ret < 0) {
> +		put_net(net);
> +		return ret;
> +	}
> +
> +	sk = (*res)->sk;
> +	lock_sock(sk);
> +	/* Update ns_tracker to current stack trace and refcounted tracker */
> +	__netns_tracker_free(net, &sk->ns_tracker, false);
> +
> +	sk->sk_net_refcnt = 1;
> +	netns_tracker_alloc(net, &sk->ns_tracker, GFP_KERNEL);
> +	sock_inuse_add(net, 1);
> +	release_sock(sk);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(sock_create_kern_getnet);
> +
>  static struct socket *__sys_socket_create(int family, int type, int protocol)
>  {
>  	struct socket *sock;
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 825ec5357691..6f272013fd9b 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -1526,7 +1526,7 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> -	error = __sock_create(net, family, type, protocol, &sock, 1);
> +	error = sock_create_kern_getnet(net, family, type, protocol, &sock);
>  	if (error < 0)
>  		return ERR_PTR(error);
>  
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index 110749b85040..f7734ce5eec9 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -1925,7 +1925,7 @@ static struct socket *xs_create_sock(struct rpc_xprt *xprt,
>  	struct socket *sock;
>  	int err;
>  
> -	err = __sock_create(xprt->xprt_net, family, type, protocol, &sock, 1);
> +	err = sock_create_kern_getnet(xprt->xprt_net, family, type, protocol, &sock);
>  	if (err < 0) {
>  		dprintk("RPC:       can't create %d transport socket (%d).\n",
>  				protocol, -err);
> -- 
> 2.34.1

