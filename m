Return-Path: <linux-nfs+bounces-7885-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0169C4A3A
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 00:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906011F22191
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 23:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE6C1C3F3B;
	Mon, 11 Nov 2024 23:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0lFOnrEm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cvxJLqQi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LadVx3rQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4Jrez/a5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD00F1C1AB3;
	Mon, 11 Nov 2024 23:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731369171; cv=none; b=t8wHZZ31mD1hu0UxrdRZRwIo6c1dvaZS12oZuvXjkWHV/xFU3oH0KVWsYTPw9FS4KRJEGNe3rRn+KFOhuY/isLLjr6svUYJ7jlnY9i4zPQ56Ve41AxX5OW4UwcTjpgRn6CCWWaQixLYcT3UMcBXu7iMCONZRp/wltbQ/oP4G1kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731369171; c=relaxed/simple;
	bh=wf3H3AZiqnd1FZifssDVJXriFhcaS3gMlszZkGcTj/8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=AGhwdF7+40WkbG/v4BBr9POOxc5EJ7AOP0PNWHmJsMFqBylh92omGVFcC26ucAHj6pk5YEOmTLTocQXpKBPr4tO2wSlXBwNc10EZMMBuFB/Xxbdy2103Y2irAfX+5/4X5zkIR5KhEM2XJvAHELED6xvupen7dmbjn+wm7WzClng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0lFOnrEm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cvxJLqQi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LadVx3rQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4Jrez/a5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B7443218F3;
	Mon, 11 Nov 2024 23:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731369168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=arm6/5otLCXFSC3XfaGbYtm7lxMpE0J/5xKdVAHe/tg=;
	b=0lFOnrEmgSCxevbKwauPzTfNHCqmXvv/kaR/SfZ+dMxcsD3ht0XndlLOqdR2GXQ1KBWF+c
	uCm3pxF9GOzfBrO+gx6BjkjKmukiYGkuUG/0bbFWON+Zn2ZrJjJELO4nvaslJ6RtOvlLl/
	uhwyPTu+OgCcUzkdeWhXyLHklP3/+K8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731369168;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=arm6/5otLCXFSC3XfaGbYtm7lxMpE0J/5xKdVAHe/tg=;
	b=cvxJLqQipx1H0teq7t5D4V0Y92ko1FgRPY7lnqbFPad9nFbTwcwjEECOZ6xrIrFNf0Jj4j
	r7hCS0n2qzW9cfBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731369166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=arm6/5otLCXFSC3XfaGbYtm7lxMpE0J/5xKdVAHe/tg=;
	b=LadVx3rQFB+XMzECDfT0iq9ot8WpyCzHLc4mvoe+oLPFFgDuaew2/f8GqO7M6M21SWZ/tm
	6+c2MTUnHQcCV9OYT7+a85EyWUSWG9e29Kl0YnRUvmyfgQHmjWP67UcuRf9GQiNOXDsl7b
	y3Bf1q68ad74HAeNii9Zb1U2ZXHNFAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731369166;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=arm6/5otLCXFSC3XfaGbYtm7lxMpE0J/5xKdVAHe/tg=;
	b=4Jrez/a5BNkV7FJO8TbT/PAmPJ/ojaUNfpazmWkexp6+rb3pZJGg5Xl5milAdBZSf94H81
	XBGQ26RgJtFhPVDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 767E1137FB;
	Mon, 11 Nov 2024 23:52:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xH9SC8mYMme0AQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 11 Nov 2024 23:52:41 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Liu Jian" <liujian56@huawei.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, okorniev@redhat.com,
 Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org, anna@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, ebiederm@xmission.com, kuniyu@amazon.com,
 liujian56@huawei.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v3] sunrpc: fix one UAF issue caused by sunrpc kernel
 tcp socket
In-reply-to: <20241111081736.526093-1-liujian56@huawei.com>
References: <20241111081736.526093-1-liujian56@huawei.com>
Date: Tue, 12 Nov 2024 10:52:34 +1100
Message-id: <173136915454.1734440.13584866019725922631@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.979];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,imap1.dmz-prg2.suse.org:helo,noble.neil.brown.name:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Mon, 11 Nov 2024, Liu Jian wrote:
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
> ip netns exec netns_1 timeout -s 9 300 mount -t nfs -o proto=3Dtcp,vers=3D4=
.1 \
> 	11.11.0.254:/mnt/nfsshare /mnt/nfs/netns_1
>=20
> ip netns del netns_1
>=20
> The reason here is that the tcp socket in netns_1 (nfs side) has been
> shutdown and closed (done in xs_destroy), but the FIN message (with ack)
> is discarded, and the nfsd side keeps sending retransmission messages.
> As a result, when the tcp sock in netns_1 processes the received message,
> it sends the message (FIN message) in the sending queue, and the tcp timer
> is re-established. When the network namespace is deleted, the net structure
> accessed by tcp's timer handler function causes problems.
>=20
> To fix this problem, let's hold netns refcnt for the tcp kernel socket as
>  done in other modules.
>=20
> Fixes: 26abe14379f8 ("net: Modify sk_alloc to not reference count the netns=
 of kernel sockets.")
> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---
>  net/sunrpc/svcsock.c  | 4 ++++
>  net/sunrpc/xprtsock.c | 6 ++++++
>  2 files changed, 10 insertions(+)
>=20
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 6f272013fd9b..d4330aaadc23 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -1551,6 +1551,10 @@ static struct svc_xprt *svc_create_socket(struct svc=
_serv *serv,
>  	newlen =3D error;
> =20
>  	if (protocol =3D=3D IPPROTO_TCP) {
> +		__netns_tracker_free(net, &sock->sk->ns_tracker, false);
> +		sock->sk->sk_net_refcnt =3D 1;
> +		get_net_track(net, &sock->sk->ns_tracker, GFP_KERNEL);
> +		sock_inuse_add(net, 1);

This is really ugly.  These internal details of the network layer have
no place in sunrpc code. There must be a better way.

Can we pass '0' for the kern arg to __sock_create()?  That should fix
the refcounting issues, but might mess up security labelling.

Can we wait for something before we call put_net() to release the net.

Maybe we want to split the "kern" arg t __sock_create() and have
"kern" which affects labeling and "refnet" with affects refcounting the
net.

I had a quick look and very nearly every caller of __sock_create()
outside of net/core really does want refcount.  Many callers of
sock_create_kern() possibly don't.

So I really think this needs to be cleaned up in net/core, not in all
the different network clients in the kernel.

Thanks,
NeilBrown


>  		if ((error =3D kernel_listen(sock, 64)) < 0)
>  			goto bummer;
>  	}
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index d2f31b59457b..0f0b9f9283d9 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -1942,6 +1942,12 @@ static struct socket *xs_create_sock(struct rpc_xprt=
 *xprt,
>  		goto out;
>  	}
> =20
> +	if (protocol =3D=3D IPPROTO_TCP) {
> +		__netns_tracker_free(xprt->xprt_net, &sock->sk->ns_tracker, false);
> +		sock->sk->sk_net_refcnt =3D 1;
> +		get_net_track(xprt->xprt_net, &sock->sk->ns_tracker, GFP_KERNEL);
> +		sock_inuse_add(xprt->xprt_net, 1);
> +	}
>  	filp =3D sock_alloc_file(sock, O_NONBLOCK, NULL);
>  	if (IS_ERR(filp))
>  		return ERR_CAST(filp);
> --=20
> 2.34.1
>=20
>=20


