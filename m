Return-Path: <linux-nfs+bounces-19885-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLGYKlXermm/JQIAu9opvQ
	(envelope-from <linux-nfs+bounces-19885-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Mar 2026 15:51:01 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D33FC23AE7F
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Mar 2026 15:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 53FF5301429A
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Mar 2026 14:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6962737EE;
	Mon,  9 Mar 2026 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cawZ6xUu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0520627A462;
	Mon,  9 Mar 2026 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067543; cv=none; b=QjQoxxPgIp7sjhbJprMycLgnO467KhlTWCxNglbANMteicrt8q+wjmxT1p5NVmTwRo0q16/vmspqDfyYFDy6AngAwzCb78acVPsaHpPVkViZZjjzFddfc37WbFfKwugoM7AXOYKqiLd1teZjxZOeOe4LaXcdMXXKEo0zS/xzzps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067543; c=relaxed/simple;
	bh=2wqsGTFQwUSQyWgwJu0JYBDsIA/zrexRXS0BfoNFkFo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iECG9/vBfqJArSge86gZZvZA0MN/A58S+ESD3uMQQPRYqU3oGtsCGInTPMfISUFgD02txPg1grLHb92sHcBskMMNqEgXtgYgKNlaYq2JMEiHZl/6lUY8ag0g8n+1PhJ8Y0M1hdXzstfiT2c4R6DtCNvXQlNxo5E4VdUWQ1S3UAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cawZ6xUu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36F1C4CEF7;
	Mon,  9 Mar 2026 14:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773067542;
	bh=2wqsGTFQwUSQyWgwJu0JYBDsIA/zrexRXS0BfoNFkFo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cawZ6xUu8ZqmzRLsciYfSU0vL07nvcbwarLlpK8RIGl4iel/TZzusAyax8EsiG5LT
	 MA6+Qz34gxy4wVhCwaYFZAcVT7Mzn5PmwTzQnPeuQyLqLAmKNX3C5w0GaRtJn8Bo7D
	 PwrXqJaAbVeud9lL1/pHpKG+6AFi1dRDhtr46m28ejYauXHdPT1/gok4hIE9HzEgjZ
	 gEDuLtcItJj/exko9lXcIzFkstSjbR9sfwfPfWuL8W+VSl1zP2a4l/QtKv8vrAdzN6
	 TWmuoo/Wq5iX95hDIWF/h/A9zlOgleiEHWIJJhadH8mO0DTPe9LWPs0833Q8ga65LC
	 bVLaDoAXGzD2Q==
Message-ID: <938915c4cf4575960db8e2c57633dc16884bc010.camel@kernel.org>
Subject: Re: [PATCH] sunrpc: fix TLS connect_worker rpc_clnt lifetime UAF
From: Jeff Layton <jlayton@kernel.org>
To: bsdhenrymartin@gmail.com, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker <anna@kernel.org>, "David S. Miller"	 <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski	 <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman	 <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Mon, 09 Mar 2026 10:45:38 -0400
In-Reply-To: <20260309112041.1336519-1-bsdhenrymartin@gmail.com>
References: <20260309112041.1336519-1-bsdhenrymartin@gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: D33FC23AE7F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19885-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.920];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, 2026-03-09 at 19:19 +0800, bsdhenrymartin@gmail.com wrote:
> From: Henry Martin <bsdhenrymartin@gmail.com>
>=20
> In xs_connect(), transport->clnt is assigned from task->tk_client
> without taking a reference when a TLS connect worker is queued.
>=20
> If the RPC task finishes before connect_worker runs, tk_client can be
> released and its cl_cred can be freed. Later, xs_tcp_tls_setup_socket()
> dereferences upper_clnt->cl_cred and passes it to rpc_create(), where
> rpc_new_client() calls get_cred() and triggers a slab-use-after-free.
>=20
> [   93.358371] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   93.359597] BUG: KASAN: slab-use-after-free in rpc_new_client+0x387/0x=
dcc
> [   93.360748] Write of size 4 at addr ffff88810d67bfa8 by task kworker/u=
4:4/44
> [   93.361919]=20
> [   93.362225] CPU: 0 UID: 0 PID: 44 Comm: kworker/u4:4 Tainted: G       =
          N  7.0.0-rc3 #2 PREEMPT(full)=20
> [   93.362297] Tainted: [N]=3DTEST
> [   93.362313] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996),=
 BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   93.362348] Workqueue: xprtiod xs_tcp_tls_setup_socket
> [   93.362433] Call Trace:
> [   93.362447]  <TASK>
> [   93.362462]  dump_stack_lvl+0xad/0xf9
> [   93.362513]  ? rpc_new_client+0x387/0xdcc
> [   93.362574]  print_report+0x171/0x4d6
> [   93.362653]  ? __virt_addr_valid+0x353/0x364
> [   93.362719]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   93.362784]  ? kmem_cache_debug_flags+0x11/0x26
> [   93.362839]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   93.362913]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   93.362978]  ? kasan_complete_mode_report_info+0x1c2/0x1d1
> [   93.363057]  ? rpc_new_client+0x387/0xdcc
> [   93.363122]  kasan_report+0xb3/0xe2
> [   93.363202]  ? rpc_new_client+0x387/0xdcc
> [   93.363266]  __asan_report_store4_noabort+0x1b/0x21
> [   93.363339]  rpc_new_client+0x387/0xdcc
> [   93.363399]  ? __sanitizer_cov_trace_pc+0x24/0x5a
> [   93.363451]  rpc_create_xprt+0x1ac/0x3b4
> [   93.363519]  rpc_create+0x5f9/0x703
> [   93.363588]  ? __pfx_rpc_create+0x10/0x10
> [   93.363654]  ? __sanitizer_cov_trace_pc+0x24/0x5a
> [   93.363706]  ? __pfx_default_wake_function+0x10/0x10
> [   93.363808]  ? __dequeue_entity+0x5d2/0x6c3
> [   93.363887]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   93.363952]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   93.364016]  ? write_comp_data+0x2e/0x8e
> [   93.364063]  xs_tcp_tls_setup_socket+0x476/0xff0
> [   93.364151]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   93.364217]  ? __pfx_xs_tcp_tls_setup_socket+0x10/0x10
> [   93.364315]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   93.364386]  ? __kasan_check_write+0x18/0x1e
> [   93.364468]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   93.364540]  ? set_work_data+0x70/0x9c
> [   93.364603]  process_scheduled_works+0x66c/0xa15
> [   93.364699]  ? __sanitizer_cov_trace_pc+0x24/0x5a
> [   93.364763]  worker_thread+0x440/0x547
> [   93.364867]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   93.364937]  ? __pfx_worker_thread+0x10/0x10
> [   93.365024]  kthread+0x375/0x38a
> [   93.365097]  ? __pfx_kthread+0x10/0x10
> [   93.365185]  ret_from_fork+0xa8/0x872
> [   93.365247]  ? __pfx_ret_from_fork+0x10/0x10
> [   93.365309]  ? __sanitizer_cov_trace_pc+0x24/0x5a
> [   93.365364]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   93.365428]  ? __switch_to+0xc44/0xc5a
> [   93.365509]  ? __pfx_kthread+0x10/0x10
> [   93.365593]  ret_from_fork_asm+0x1a/0x30
> [   93.365684]  </TASK>
> [   93.365701]=20
> [   93.405276] Allocated by task 392:
> [   93.405852]  kasan_save_stack+0x3c/0x5e
> [   93.406581]  kasan_save_track+0x18/0x32
> [   93.407230]  kasan_save_alloc_info+0x3b/0x49
> [   93.407932]  __kasan_slab_alloc+0x52/0x62
> [   93.408606]  kmem_cache_alloc_noprof+0x266/0x304
> [   93.409359]  prepare_creds+0x32/0x338
> [   93.409965]  copy_creds+0x188/0x425
> [   93.410545]  copy_process+0x1022/0x5320
> [   93.411208]  kernel_clone+0x23d/0x61a
> [   93.411870]  __do_sys_clone+0xf8/0x139
> [   93.412530]  __x64_sys_clone+0xde/0xed
> [   93.413192]  x64_sys_call+0x33f/0x2105
> [   93.413883]  do_syscall_64+0x1b3/0x420
> [   93.414588]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   93.416895]=20
> [   93.417169] Freed by task 396:
> [   93.417673]  kasan_save_stack+0x3c/0x5e
> [   93.418321]  kasan_save_track+0x18/0x32
> [   93.418972]  kasan_save_free_info+0x43/0x52
> [   93.419652]  poison_slab_object+0x33/0x3c
> [   93.420315]  __kasan_slab_free+0x25/0x4a
> [   93.420973]  kmem_cache_free+0x1e5/0x2e4
> [   93.421616]  put_cred_rcu+0x2e7/0x2f4
> [   93.422219]  rcu_do_batch+0x5b6/0xa82
> [   93.422833]  rcu_core+0x264/0x298
> [   93.423475]  rcu_core_si+0x12/0x18
> [   93.424086]  handle_softirqs+0x21c/0x488
> [   93.424750]  __do_softirq+0x14/0x1a
> [   93.425346]=20
> [   93.425612] Last potentially related work creation:
> [   93.426358]  kasan_save_stack+0x3c/0x5e
> [   93.427024]  kasan_record_aux_stack+0x92/0x9e
> [   93.427739]  call_rcu+0xe4/0xb2b
> [   93.428337]  __put_cred+0x13e/0x14c
> [   93.428937]  put_cred_many+0x50/0x5e
> [   93.429530]  exit_creds+0x95/0xbc
> [   93.430099]  __put_task_struct+0x173/0x26a
> [   93.430770]  __put_task_struct_rcu_cb+0x22/0x29
> [   93.431513]  rcu_do_batch+0x5b6/0xa82
> [   93.432144]  rcu_core+0x264/0x298
> [   93.432737]  rcu_core_si+0x12/0x18
> [   93.433345]  handle_softirqs+0x21c/0x488
> [   93.434030]  __do_softirq+0x14/0x1a
> [   93.434632]=20
> [   93.434910] The buggy address belongs to the object at ffff88810d67bf0=
0
> [   93.434910]  which belongs to the cache cred of size 184
> [   93.436720] The buggy address is located 168 bytes inside of
> [   93.436720]  freed 184-byte region [ffff88810d67bf00, ffff88810d67bfb8=
)
> [   93.438582]=20
> [   93.438868] The buggy address belongs to the physical page:
> [   93.439734] page: refcount:0 mapcount:0 mapping:0000000000000000 index=
:0x0 pfn:0x10d67b
> [   93.440982] memcg:ffff88810d67b0c9
> [   93.441546] flags: 0x200000000000000(node=3D0|zone=3D2)
> [   93.442327] page_type: f5(slab)
> [   93.442878] raw: 0200000000000000 ffff88810088d140 dead000000000122 00=
00000000000000
> [   93.444091] raw: 0000000000000000 0000010000100010 00000000f5000000 ff=
ff88810d67b0c9
> [   93.445365] page dumped because: kasan: bad access detected
> [   93.446334]=20
> [   93.446638] Memory state around the buggy address:
> [   93.447505]  ffff88810d67be80: 00 00 00 00 00 00 00 fc fc fc fc fc fc =
fc fc fc
> [   93.448748]  ffff88810d67bf00: fa fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb
> [   93.449973] >ffff88810d67bf80: fb fb fb fb fb fb fb fc fc fc fc fc fc =
fc fc fc
> [   93.451147]                                   ^
> [   93.452039]  ffff88810d67c000: fa fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb
> [   93.453227]  ffff88810d67c080: fb fb fb fb fb fb fb fb fb fb fb fb fb =
fc fc fc
> [   93.454455] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   93.577640] Disabling lock debugging due to kernel taint
> [ 1206.114037] kworker/u4:1 (26) used greatest stack depth: 24168 bytes l=
eft
>=20
> Fix this by taking a client reference when queuing a TLS connect worker
> and dropping that reference when the worker exits. Also release any
> still-pinned client in xs_destroy() after cancel_delayed_work_sync() to
> cover the case where queued work is canceled before execution.
>=20
> Fixes: 75eb6af7acdf ("SUNRPC: Add a TCP-with-TLS RPC transport class")
> Cc: stable@vger.kernel.org # 6.5+
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
>  net/sunrpc/xprtsock.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index 2e1fe6013361..6bf1cf20a86e 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -1362,6 +1362,10 @@ static void xs_destroy(struct rpc_xprt *xprt)
>  	dprintk("RPC:       xs_destroy xprt %p\n", xprt);
> =20
>  	cancel_delayed_work_sync(&transport->connect_worker);
> +	if (transport->clnt !=3D NULL) {
> +		rpc_release_client(transport->clnt);
> +		transport->clnt =3D NULL;
> +	}
>  	xs_close(xprt);
>  	cancel_work_sync(&transport->recv_worker);
>  	cancel_work_sync(&transport->error_worker);
> @@ -2758,6 +2762,8 @@ static void xs_tcp_tls_setup_socket(struct work_str=
uct *work)
>  out_unlock:
>  	current_restore_flags(pflags, PF_MEMALLOC);
>  	upper_transport->clnt =3D NULL;
> +	if (upper_clnt !=3D NULL)
> +		rpc_release_client(upper_clnt);
>  	xprt_unlock_connect(upper_xprt, upper_transport);
>  	return;
> =20
> @@ -2805,7 +2811,11 @@ static void xs_connect(struct rpc_xprt *xprt, stru=
ct rpc_task *task)
>  	} else
>  		dprintk("RPC:       xs_connect scheduled xprt %p\n", xprt);
> =20
> -	transport->clnt =3D task->tk_client;
> +	if (transport->connect_worker.work.func =3D=3D xs_tcp_tls_setup_socket)=
 {
> +		WARN_ON_ONCE(transport->clnt !=3D NULL);
> +		refcount_inc(&task->tk_client->cl_count);
> +		transport->clnt =3D task->tk_client;
> +	}
>  	queue_delayed_work(xprtiod_workqueue,
>  			&transport->connect_worker,
>  			delay);

Reviewed-by: Jeff Layton <jlayton@kernel.org>

