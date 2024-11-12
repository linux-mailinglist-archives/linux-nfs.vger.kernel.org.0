Return-Path: <linux-nfs+bounces-7902-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ACB9C5C8F
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 16:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FEF4B6358C
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 14:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9801FEFCE;
	Tue, 12 Nov 2024 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+bZgpfO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C342D1FCC4F;
	Tue, 12 Nov 2024 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421730; cv=none; b=rkTT17jMvbmfrCmJ7sL3TYiSAkXcK31RdbJJzbySdAEECLUVw4Mp5djZ+2sd0M6nx5q/GWoIdhy8VMB8wfeZvG0sLKxBpD/JcMRtZ/GZhk42GlYVVGaMRjk9FgXXeaLMfypF/wbdvRYyrhnjsYwcPG/bxnc0lv9rAnznOcVPXz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421730; c=relaxed/simple;
	bh=aY2dxDsPuP50iVEi3u3ZhEjBcdNU6WvYDf/OYbXvKnI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tzlriUPtOPV4G7IwVMtHTlvZRvR85A/gb8Jq5Kj6+N+GvsNyB/tPXKUoRkkBuU+JxvZvlDu2XgVNmnfhDd69g9aLx+sQnindCjI+IiWhgEhsl52ScLUChN104VJSIbSQ8EhRpVOazObAvAv015yAm3lZDRzLpCRo77LN8ayWQAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+bZgpfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E125DC4CECD;
	Tue, 12 Nov 2024 14:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731421730;
	bh=aY2dxDsPuP50iVEi3u3ZhEjBcdNU6WvYDf/OYbXvKnI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=o+bZgpfO5IQm69zVqOTdjxGZOXkGQXlZtF/3ejaUdPHtuUCU005oahvGwAZV7iCNy
	 T9JucdtY4KIbn6nUL6CIc94OFU2bb/e3wJc4awV+RENqBwUoNzi4FxLrDw2NRP0Nqf
	 xuL6GgPa+z5Ig3zkDkFdMROykz/JJYpur6BoFm7UcOSozuetb9rghrlbUAoZFIdxcD
	 93FgVCqyDo1g1LITQOBgcwNyfGi/mTZ8tGokfNU5eyIO5Nf1+TQnVS2KSk3JzyiM6+
	 0LbTE7wjH3BH5o2hzFVJoIvRX0+V10WnoTEpbJKxPjN+gr7Ne1njmO//GlCYe9bbM9
	 oCIwlX2XpL/ow==
Message-ID: <b8947e4ef24c00cd9757b408bece1b8c25f7002c.camel@kernel.org>
Subject: Re: [PATCH net v4] sunrpc: fix one UAF issue caused by sunrpc
 kernel tcp socket
From: Jeff Layton <jlayton@kernel.org>
To: Liu Jian <liujian56@huawei.com>, chuck.lever@oracle.com, neilb@suse.de, 
 okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
 trondmy@kernel.org,  anna@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org,  pabeni@redhat.com, horms@kernel.org,
 ebiederm@xmission.com, kuniyu@amazon.com
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Date: Tue, 12 Nov 2024 09:28:47 -0500
In-Reply-To: <20241112135434.803890-1-liujian56@huawei.com>
References: <20241112135434.803890-1-liujian56@huawei.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-11-12 at 21:54 +0800, Liu Jian wrote:
> BUG: KASAN: slab-use-after-free in tcp_write_timer_handler+0x156/0x3e0
> Read of size 1 at addr ffff888111f322cd by task swapper/0/0
>=20
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
> Code: 4c 01 c7 4c 29 c2 e9 72 ff ff ff 90 90 90 90 90 90 90 90 90 90 90 9=
0
>  90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 33 f8 25 00 fb f4 <fa> c3 cc cc c=
c
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
>=20
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
>=20
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
>=20
> Reproduction script:
>=20
> mkdir -p /mnt/nfsshare
> mkdir -p /mnt/nfs/netns_1
> mkfs.ext4 /dev/sdb
> mount /dev/sdb /mnt/nfsshare
> systemctl restart nfs-server
> chmod 777 /mnt/nfsshare
> exportfs -i -o rw,no_root_squash *:/mnt/nfsshare
>=20
> ip netns add netns_1
> ip link add name veth_1_peer type veth peer veth_1
> ifconfig veth_1_peer 11.11.0.254 up
> ip link set veth_1 netns netns_1
> ip netns exec netns_1 ifconfig veth_1 11.11.0.1
>=20
> ip netns exec netns_1 /root/iptables -A OUTPUT -d 11.11.0.254 -p tcp \
> 	--tcp-flags FIN FIN  -j DROP
>=20
> (note: In my environment, a DESTROY_CLIENTID operation is always sent
>  immediately, breaking the nfs tcp connection.)
> ip netns exec netns_1 timeout -s 9 300 mount -t nfs -o proto=3Dtcp,vers=
=3D4.1 \
> 	11.11.0.254:/mnt/nfsshare /mnt/nfs/netns_1
>=20
> ip netns del netns_1
>=20
> The reason here is that the tcp socket in netns_1 (nfs side) has been
> shutdown and closed (done in xs_destroy), but the FIN message (with ack)
> is discarded, and the nfsd side keeps sending retransmission messages.
> As a result, when the tcp sock in netns_1 processes the received message,
> it sends the message (FIN message) in the sending queue, and the tcp time=
r
> is re-established. When the network namespace is deleted, the net structu=
re
> accessed by tcp's timer handler function causes problems.
>=20
> To fix this problem, let's hold netns refcnt for the tcp kernel socket as
> done in other modules. This is an ugly hack which can easily be backporte=
d
> to earlier kernels. A proper fix which cleans up the interfaces will
> follow, but may not be so easy to backport.
>=20
> Fixes: 26abe14379f8 ("net: Modify sk_alloc to not reference count the net=
ns of kernel sockets.")
> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---
> v3->v4: Add the commit message suggested by NeilBrown.
>  net/sunrpc/svcsock.c  | 4 ++++
>  net/sunrpc/xprtsock.c | 7 +++++++
>  2 files changed, 11 insertions(+)
>=20
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 6f272013fd9b..d4330aaadc23 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -1551,6 +1551,10 @@ static struct svc_xprt *svc_create_socket(struct s=
vc_serv *serv,
>  	newlen =3D error;
> =20
>  	if (protocol =3D=3D IPPROTO_TCP) {
> +		__netns_tracker_free(net, &sock->sk->ns_tracker, false);
> +		sock->sk->sk_net_refcnt =3D 1;
> +		get_net_track(net, &sock->sk->ns_tracker, GFP_KERNEL);
> +		sock_inuse_add(net, 1);
>  		if ((error =3D kernel_listen(sock, 64)) < 0)
>  			goto bummer;
>  	}

Given that this is an ugly hack, some comments over these new blocks
that explains exactly what is going on would be welcome. That might
make it simpler to review the eventual change to a cleaner interface
later too.

> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index d2f31b59457b..906a1b563aee 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -1942,6 +1942,13 @@ static struct socket *xs_create_sock(struct rpc_xp=
rt *xprt,
>  		goto out;
>  	}
> =20
> +	if (protocol =3D=3D IPPROTO_TCP) {
> +		__netns_tracker_free(xprt->xprt_net, &sock->sk->ns_tracker, false);
> +		sock->sk->sk_net_refcnt =3D 1;
> +		get_net_track(xprt->xprt_net, &sock->sk->ns_tracker, GFP_KERNEL);
> +		sock_inuse_add(xprt->xprt_net, 1);
> +	}
> +
>  	filp =3D sock_alloc_file(sock, O_NONBLOCK, NULL);
>  	if (IS_ERR(filp))
>  		return ERR_CAST(filp);


Acked-by: Jeff Layton <jlayton@kernel.org>

