Return-Path: <linux-nfs+bounces-896-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCBD823501
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jan 2024 19:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 945B71C20C15
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jan 2024 18:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBAA1CA86;
	Wed,  3 Jan 2024 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSlRJU7n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FDD1CA85
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jan 2024 18:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3782AC433C7;
	Wed,  3 Jan 2024 18:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704307937;
	bh=zQtkISfMPzMxQNs9A7sul2tZAsLZplvtD4QPHsv++Y4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=JSlRJU7nAb4LovYz7r+ndE131IBuo1hSbB0gBIsORwiqaTIt95mM9+GG2U3sbRsjH
	 QwH4Q+bghLyoH2HSMrY2ao/VL+SGu0BUHOEQGoMHAgyv4nDYiutfc/YmbgelnhQAFe
	 vBfKhnsfaEMzcgJGTGM4kTQJKXzH+cexiMtigZzj8amGdD9C4cBsAZvfSy9nw5+Wf3
	 PeEqxKL1DsJTTsxDb+Y6fBIqbjap7LyU5/UCJQNPDMASan9OOD/FS9fMptsXZOGOaQ
	 vUqN6Acz7Jwiu5BG1zBtQ4zA3pCiwN9UfjR07Zq7DwoM3KUJFVAGhrfP98bFpnSGiv
	 z8BbkVgoG4ukQ==
Message-ID: <b902a02e2ee4758da67537981ab5fae52cf0e300.camel@kernel.org>
Subject: Re: hangs during fstests testing with TLS
From: Jeff Layton <jlayton@kernel.org>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: linux-nfs <linux-nfs@vger.kernel.org>, Chuck Lever
 <chuck.lever@oracle.com>
Date: Wed, 03 Jan 2024 13:52:15 -0500
In-Reply-To: <ABBA5E37-2E13-4603-A79C-F9B9B8488AE3@redhat.com>
References: <117352d5dc94d8f31bc6770e4bbb93a357982a93.camel@kernel.org>
	 <ABBA5E37-2E13-4603-A79C-F9B9B8488AE3@redhat.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-03 at 13:47 -0500, Benjamin Coddington wrote:
> On 3 Jan 2024, at 13:03, Jeff Layton wrote:
>=20
> > I'm seeing some hangs when testing with TLS in v6.7-rc8. This kernel ha=
s
> > the patch I sent this morning to get rid of nfsd_put, but otherwise is
> > stock v6.7-rc8:
> >=20
> > [ 2125.174937] run fstests generic/126 at 2024-01-03 09:46:39
> > [ 2129.793577] run fstests generic/127 at 2024-01-03 09:46:44
> > [ 3199.661565] run fstests generic/128 at 2024-01-03 10:04:33
> > [ 3204.502354] run fstests generic/129 at 2024-01-03 10:04:38
> > [ 3208.111189] RPC: Could not send backchannel reply error: -110
> > [ 3384.487762] INFO: task looptest:92512 blocked for more than 120 seco=
nds.
> > [ 3384.491396]       Not tainted 6.7.0-rc8-g6c5361baaf84 #74
> > [ 3384.494103] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disab=
les this message.
> > [ 3384.497215] task:looptest        state:D stack:0     pid:92512 tgid:=
92512 ppid:92333  flags:0x00004002
> > [ 3384.499471] Call Trace:
> > [ 3384.500129]  <TASK>
> > [ 3384.500717]  __schedule+0x3c4/0xad0
> > [ 3384.501652]  schedule+0x31/0xd0
> > [ 3384.502455]  io_schedule+0x42/0x70
> > [ 3384.503344]  folio_wait_bit_common+0x121/0x330
> > [ 3384.504442]  ? __pfx_wake_page_function+0x10/0x10
> > [ 3384.505624]  folio_wait_writeback+0x27/0x80
> > [ 3384.506639]  __filemap_fdatawait_range+0x79/0xe0
> > [ 3384.507343]  filemap_write_and_wait_range+0x81/0xb0
> > [ 3384.508043]  nfs_wb_all+0x21/0x120 [nfs]
> > [ 3384.508739]  nfs4_file_flush+0x6e/0xb0 [nfsv4]
> > [ 3384.509499]  filp_flush+0x30/0x70
> > [ 3384.510045]  filp_close+0xf/0x30
> > [ 3384.510639]  put_files_struct+0x78/0xd0
> > [ 3384.511222]  do_exit+0x345/0xb10
> > [ 3384.511764]  ? handle_mm_fault+0x9e/0x360
> > [ 3384.512364]  ? preempt_count_add+0x47/0xa0
> > [ 3384.513012]  do_group_exit+0x2d/0x80
> > [ 3384.513592]  __x64_sys_exit_group+0x14/0x20
> > [ 3384.514252]  do_syscall_64+0x3f/0xf0
> > [ 3384.514809]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> > [ 3384.515581] RIP: 0033:0x7f564911595d
> > [ 3384.516186] RSP: 002b:00007ffecd703338 EFLAGS: 00000202 ORIG_RAX: 00=
000000000000e7
> > [ 3384.517306] RAX: ffffffffffffffda RBX: 00007f5649211fa8 RCX: 00007f5=
64911595d
> > [ 3384.518368] RDX: 00000000000000e7 RSI: ffffffffffffff28 RDI: 0000000=
000000000
> > [ 3384.519473] RBP: 00007ffecd703390 R08: 00007ffecd7032d8 R09: 00007ff=
ecd70323f
> > [ 3384.520543] R10: 00007ffecd703190 R11: 0000000000000202 R12: 0000000=
000000001
> > [ 3384.521597] R13: 0000000000000000 R14: 0000000000000000 R15: 00007f5=
649211fc0
> > [ 3384.522647]  </TASK>
> >=20
> > [root@kdevops-nfs-tls ~]# cat /sys/kernel/debug/sunrpc/rpc_clnt/*/tasks
> >     6 5285      0 0x0 0x0        0 nfs41_sequence_ops [nfsv4] nfsv4 SEQ=
UENCE a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1460 c805    -11 0x5 0x2a2113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
> >  1461 c805    -11 0x5 0x2b2113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
> >  1462 c805    -11 0x5 0x2c2113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
> >  1463 c805    -11 0x5 0x2d2113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
> >  1464 c805    -11 0x5 0x302113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
> >  1465 c805    -11 0x5 0x2e2113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
> >  1466 c805    -11 0x5 0x2f2113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
> >  1467 c805    -11 0x5 0x312113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
> >  1468 c805    -11 0x5 0x322113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
> >  1469 c805    -11 0x5 0x332113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
> >  1470 c805    -11 0x5 0x342113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
> >  1471 c805    -11 0x5 0x352113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
> >  1472 c805    -11 0x5 0x362113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
> >  1473 c805    -11 0x5 0x372113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
> >  1474 c805    -11 0x5 0x382113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
> >  1475 c805    -11 0x5 0x392113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
> >  1476 c805    -11 0x5 0x3a2113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
> >  1477 c805    -11 0x5 0x3b2113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
> >  1478 c805    -11 0x5 0x3c2113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
> >  1479 c805    -11 0x5 0x3d2113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
> >  1480 c805    -11 0x5 0x3e2113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
> >  1481 c805    -11 0x5 0x3f2113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
> >  1482 c805    -11 0x5 0x402113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
> >  1483 c805    -11 0x5 0x412113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
> >  1484 c805    -11 0x5 0x422113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_connect_status [sunrpc] q:xprt_sending
> >  1485 c005    -11 0x5 0x432113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_transmit_status [sunrpc] q:xprt_sending
> >  1486 c005    -11 0x5 0x442113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_transmit_status [sunrpc] q:xprt_sending
> >  1487 c005    -11 0x5 0x452113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_transmit_status [sunrpc] q:xprt_sending
> >  1488 c005    -11 0x5 0x462113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_transmit_status [sunrpc] q:xprt_sending
> >  1489 c005    -11 0x5 0x472113be        0 nfs_pgio_common_ops [nfs] nfs=
v4 WRITE a:call_transmit_status [sunrpc] q:xprt_sending
> >  1490 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1491 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1492 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1493 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1494 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1495 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1496 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1497 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1498 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1499 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1500 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1501 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1502 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1503 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1504 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1505 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1506 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1507 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1508 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1509 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1510 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1511 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1512 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1513 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1514 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1515 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1516 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1517 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1518 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1519 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1520 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1521 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1522 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1523 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1524 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1525 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1526 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1527 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1528 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1529 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1530 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1531 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1532 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1533 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1534 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1535 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1536 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1537 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1538 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1539 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1540 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1541 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1542 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1543 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1544 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1545 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1546 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1547 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1548 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1549 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1550 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1551 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1552 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1553 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1554 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1555 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1556 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1557 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1558 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1559 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1560 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1561 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1562 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1563 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1564 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1565 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1566 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1567 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1568 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1569 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1570 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1571 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1572 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1573 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1574 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1575 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1576 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1577 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1578 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1579 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1580 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1581 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1582 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1583 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1584 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1585 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1586 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1587 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1588 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1589 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1590 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1591 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1592 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1593 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1594 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1595 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1596 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1597 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >  1598 c005      0 0x5 0x0        0 nfs_pgio_common_ops [nfs] nfsv4 WRIT=
E a:rpc_prepare_task [sunrpc] q:ForeChannel Slot table
> >=20
> > In the server, I see this in the log around the same time:
> >=20
> > [ 2344.590202] rpc-srv/tcp: nfsd: got error -90 when sending 112 bytes =
- shutting down socket
> > [ 2349.182087] rpc-srv/tcp: nfsd: got error -74 when sending 112 bytes =
- shutting down socket
> > [ 2352.685424] rpc-srv/tcp: nfsd: got error -90 when sending 112 bytes =
- shutting down socket
> > [ 3583.897575] rpc-srv/tcp: nfsd: got error -104 when sending 112 bytes=
 - shutting down socket
>=20
> This looks like it started out as the problem I've been sending patches t=
o
> fix on 6.7, latest here:
> https://lore.kernel.org/linux-nfs/e28038fba1243f00b0dd66b7c5296a1e181645e=
a.1702496910.git.bcodding@redhat.com/
>=20
> .. however whenever I encounter the issue, the client reconnects the
> transport again - so I think there might be an additional problem here.  =
It
> would be interesting to turn up some tracepoints to see what the sunrpc
> scheduler is doing once the problem occurs.  The -EAGAIN tasks should be
> timing out and reconnecting the transport, I think.
>=20

I did turn up all of the sunrpc and NFS client tracepoints, but saw no
output whatsoever. I also tried turning up all of the dprintk's but that
also showed nothing.

So far, this seems to be pretty reproducible by running fstests with TLS
enabled. I'm going to try testing a kernel with your v3 patchset. Stay
tuned...

--=20
Jeff Layton <jlayton@kernel.org>

