Return-Path: <linux-nfs+bounces-895-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6E98234DA
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jan 2024 19:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31971F24E73
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jan 2024 18:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AE11CA85;
	Wed,  3 Jan 2024 18:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2w9iF9L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835551C6BA
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jan 2024 18:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704307634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jMycmVNgkPVtSSHaRefRjY+2W5IYth4r5+jq6kEX81c=;
	b=S2w9iF9LLQfvl04z3ruLiNDfZTkEQpAFjl1/joWW5W8TqS37yIrfvAnOckyxOe0/DJYjvZ
	lPdoJKJXt+VrZquOEhDYrxeffkwG/cs6Ok8w0RrnDWi3byZpjJSYazDYkD0KcIYbQthbyP
	eBErz+gPSjEo0FAPApP/CW2UjS/ay2s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-4DSwFw7RNUGsez0jposwtQ-1; Wed, 03 Jan 2024 13:47:13 -0500
X-MC-Unique: 4DSwFw7RNUGsez0jposwtQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B9C39805840;
	Wed,  3 Jan 2024 18:47:12 +0000 (UTC)
Received: from [100.85.132.103] (ovpn-0-5.rdu2.redhat.com [10.22.0.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 072D4C15968;
	Wed,  3 Jan 2024 18:47:11 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs <linux-nfs@vger.kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>
Subject: Re: hangs during fstests testing with TLS
Date: Wed, 03 Jan 2024 13:47:10 -0500
Message-ID: <ABBA5E37-2E13-4603-A79C-F9B9B8488AE3@redhat.com>
In-Reply-To: <117352d5dc94d8f31bc6770e4bbb93a357982a93.camel@kernel.org>
References: <117352d5dc94d8f31bc6770e4bbb93a357982a93.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 3 Jan 2024, at 13:03, Jeff Layton wrote:

> I'm seeing some hangs when testing with TLS in v6.7-rc8. This kernel ha=
s
> the patch I sent this morning to get rid of nfsd_put, but otherwise is
> stock v6.7-rc8:
>
> [ 2125.174937] run fstests generic/126 at 2024-01-03 09:46:39
> [ 2129.793577] run fstests generic/127 at 2024-01-03 09:46:44
> [ 3199.661565] run fstests generic/128 at 2024-01-03 10:04:33
> [ 3204.502354] run fstests generic/129 at 2024-01-03 10:04:38
> [ 3208.111189] RPC: Could not send backchannel reply error: -110
> [ 3384.487762] INFO: task looptest:92512 blocked for more than 120 seco=
nds.
> [ 3384.491396]       Not tainted 6.7.0-rc8-g6c5361baaf84 #74
> [ 3384.494103] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disab=
les this message.
> [ 3384.497215] task:looptest        state:D stack:0     pid:92512 tgid:=
92512 ppid:92333  flags:0x00004002
> [ 3384.499471] Call Trace:
> [ 3384.500129]  <TASK>
> [ 3384.500717]  __schedule+0x3c4/0xad0
> [ 3384.501652]  schedule+0x31/0xd0
> [ 3384.502455]  io_schedule+0x42/0x70
> [ 3384.503344]  folio_wait_bit_common+0x121/0x330
> [ 3384.504442]  ? __pfx_wake_page_function+0x10/0x10
> [ 3384.505624]  folio_wait_writeback+0x27/0x80
> [ 3384.506639]  __filemap_fdatawait_range+0x79/0xe0
> [ 3384.507343]  filemap_write_and_wait_range+0x81/0xb0
> [ 3384.508043]  nfs_wb_all+0x21/0x120 [nfs]
> [ 3384.508739]  nfs4_file_flush+0x6e/0xb0 [nfsv4]
> [ 3384.509499]  filp_flush+0x30/0x70
> [ 3384.510045]  filp_close+0xf/0x30
> [ 3384.510639]  put_files_struct+0x78/0xd0
> [ 3384.511222]  do_exit+0x345/0xb10
> [ 3384.511764]  ? handle_mm_fault+0x9e/0x360
> [ 3384.512364]  ? preempt_count_add+0x47/0xa0
> [ 3384.513012]  do_group_exit+0x2d/0x80
> [ 3384.513592]  __x64_sys_exit_group+0x14/0x20
> [ 3384.514252]  do_syscall_64+0x3f/0xf0
> [ 3384.514809]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> [ 3384.515581] RIP: 0033:0x7f564911595d
> [ 3384.516186] RSP: 002b:00007ffecd703338 EFLAGS: 00000202 ORIG_RAX: 00=
000000000000e7
> [ 3384.517306] RAX: ffffffffffffffda RBX: 00007f5649211fa8 RCX: 00007f5=
64911595d
> [ 3384.518368] RDX: 00000000000000e7 RSI: ffffffffffffff28 RDI: 0000000=
000000000
> [ 3384.519473] RBP: 00007ffecd703390 R08: 00007ffecd7032d8 R09: 00007ff=
ecd70323f
> [ 3384.520543] R10: 00007ffecd703190 R11: 0000000000000202 R12: 0000000=
000000001
> [ 3384.521597] R13: 0000000000000000 R14: 0000000000000000 R15: 00007f5=
649211fc0
> [ 3384.522647]  </TASK>
>
> [root@kdevops-nfs-tls ~]# cat /sys/kernel/debug/sunrpc/rpc_clnt/*/tasks=

>     6 5285      0 0x0 0x0        0 nfs41_sequence_ops [nfsv4] nfsv4 SEQ=
UENCE a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1460 c805    -11 0x5 0x2a2113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
>  1461 c805    -11 0x5 0x2b2113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
>  1462 c805    -11 0x5 0x2c2113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
>  1463 c805    -11 0x5 0x2d2113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
>  1464 c805    -11 0x5 0x302113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
>  1465 c805    -11 0x5 0x2e2113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
>  1466 c805    -11 0x5 0x2f2113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
>  1467 c805    -11 0x5 0x312113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
>  1468 c805    -11 0x5 0x322113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
>  1469 c805    -11 0x5 0x332113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
>  1470 c805    -11 0x5 0x342113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
>  1471 c805    -11 0x5 0x352113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
>  1472 c805    -11 0x5 0x362113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
>  1473 c805    -11 0x5 0x372113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
>  1474 c805    -11 0x5 0x382113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
>  1475 c805    -11 0x5 0x392113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
>  1476 c805    -11 0x5 0x3a2113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
>  1477 c805    -11 0x5 0x3b2113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
>  1478 c805    -11 0x5 0x3c2113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
>  1479 c805    -11 0x5 0x3d2113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
>  1480 c805    -11 0x5 0x3e2113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
>  1481 c805    -11 0x5 0x3f2113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
>  1482 c805    -11 0x5 0x402113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
>  1483 c805    -11 0x5 0x412113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
>  1484 c805    -11 0x5 0x422113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
>  1485 c005    -11 0x5 0x432113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_transmit_status [sunrpc] q:xprt_sending
>  1486 c005    -11 0x5 0x442113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_transmit_status [sunrpc] q:xprt_sending
>  1487 c005    -11 0x5 0x452113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_transmit_status [sunrpc] q:xprt_sending
>  1488 c005    -11 0x5 0x462113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_transmit_status [sunrpc] q:xprt_sending
>  1489 c005    -11 0x5 0x472113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_transmit_status [sunrpc] q:xprt_sending
>  1490 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1491 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1492 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1493 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1494 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1495 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1496 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1497 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1498 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1499 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1500 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1501 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1502 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1503 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1504 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1505 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1506 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1507 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1508 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1509 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1510 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1511 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1512 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1513 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1514 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1515 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1516 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1517 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1518 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1519 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1520 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1521 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1522 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1523 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1524 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1525 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1526 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1527 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1528 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1529 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1530 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1531 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1532 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1533 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1534 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1535 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1536 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1537 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1538 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1539 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1540 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1541 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1542 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1543 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1544 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1545 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1546 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1547 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1548 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1549 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1550 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1551 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1552 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1553 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1554 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1555 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1556 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1557 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1558 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1559 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1560 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1561 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1562 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1563 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1564 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1565 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1566 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1567 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1568 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1569 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1570 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1571 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1572 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1573 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1574 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1575 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1576 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1577 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1578 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1579 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1580 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1581 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1582 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1583 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1584 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1585 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1586 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1587 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1588 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1589 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1590 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1591 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1592 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1593 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1594 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1595 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1596 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1597 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>  1598 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
>
> In the server, I see this in the log around the same time:
>
> [ 2344.590202] rpc-srv/tcp: nfsd: got error -90 when sending 112 bytes =
- shutting down socket
> [ 2349.182087] rpc-srv/tcp: nfsd: got error -74 when sending 112 bytes =
- shutting down socket
> [ 2352.685424] rpc-srv/tcp: nfsd: got error -90 when sending 112 bytes =
- shutting down socket
> [ 3583.897575] rpc-srv/tcp: nfsd: got error -104 when sending 112 bytes=
 - shutting down socket

This looks like it started out as the problem I've been sending patches t=
o
fix on 6.7, latest here:
https://lore.kernel.org/linux-nfs/e28038fba1243f00b0dd66b7c5296a1e181645e=
a.1702496910.git.bcodding@redhat.com/

=2E. however whenever I encounter the issue, the client reconnects the
transport again - so I think there might be an additional problem here.  =
It
would be interesting to turn up some tracepoints to see what the sunrpc
scheduler is doing once the problem occurs.  The -EAGAIN tasks should be
timing out and reconnecting the transport, I think.

Ben


