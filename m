Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B877BEC15
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Oct 2023 22:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377469AbjJIUzo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Oct 2023 16:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378165AbjJIUzi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Oct 2023 16:55:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B301A3
        for <linux-nfs@vger.kernel.org>; Mon,  9 Oct 2023 13:55:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD73FC433C7;
        Mon,  9 Oct 2023 20:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696884936;
        bh=xjfquAUJIciV16Iyd6+3JPXTUw8VRN7e2IyanpF+O2Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bU4Ib5cq0/FMZAUXTJ5AkdZMkPhcS17fPb8aOAjKtj0UXSb3pkQL0GqAdsG03jE3L
         1ttuDhio25CGYM90j6bdx0fqUKSxIVPi9OEZS3+BBf3/eBqBK+Kr6bsNlrOjWl0phr
         qqsmEgRuHhr3fRTCFML1BxoNGl5NPRjRG2ft/UEBnWbqe9/mmxjZcWkN5CWOIuEaFs
         iTC4XG0YoNJiwxVfaWVYbZjvejCguCEzdrepO4OePh3n8PHKNz/W+X2AFSCRGlq+M5
         EtBoQWFqEA6F+hD/LJ2EBoE6BTt62HKUeItutLkWZizQmOndWy36K4BGYGJR0hL0cQ
         XBp7nM+IObX3Q==
Message-ID: <74a6bbeab84689e02e2c77b11b4f99ad720c743a.camel@kernel.org>
Subject: Re: lockd KASAN pop in svc_exit_thread with nfsd-next branch
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck.Lever@oracle.com, neilb@suse.de
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 09 Oct 2023 16:55:34 -0400
In-Reply-To: <c5b2b3c914dc03b8a8017a27513dc9ab033e80c6.camel@kernel.org>
References: <c5b2b3c914dc03b8a8017a27513dc9ab033e80c6.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.module_f38+17164+63eeee4a) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-10-09 at 16:30 -0400, Jeff Layton wrote:
> I hit this KASAN pop today while rebooting a machine. This kernel
> contains the contents of Chuck's nfsd-next branch, so it should have
> all of Neil's latest thread handling patches.
>=20
> I was able to reproduce this by just running "systemctl stop nfs-
> server". This does not occur on stock v6.6-rc5:
>=20
> Oct 09 15:26:08 f38-nfsd kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> Oct 09 15:26:08 f38-nfsd kernel: BUG: KASAN: slab-use-after-free in svc_e=
xit_thread+0x10c/0x150 [sunrpc]
> Oct 09 15:26:08 f38-nfsd kernel: Write of size 8 at addr ffff888112147bb8=
 by task lockd/973
> Oct 09 15:26:08 f38-nfsd kernel:=20
> Oct 09 15:26:08 f38-nfsd kernel: CPU: 5 PID: 973 Comm: lockd Not tainted =
6.6.0-rc4-g2615e14a89be #8
> Oct 09 15:26:08 f38-nfsd kernel: Hardware name: QEMU Standard PC (Q35 + I=
CH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
> Oct 09 15:26:08 f38-nfsd kernel: Call Trace:
> Oct 09 15:26:08 f38-nfsd kernel:  <TASK>
> Oct 09 15:26:08 f38-nfsd kernel:  dump_stack_lvl+0x43/0x60
> Oct 09 15:26:08 f38-nfsd kernel:  print_report+0xc5/0x620
> Oct 09 15:26:08 f38-nfsd kernel:  ? __pfx__raw_spin_lock_irqsave+0x10/0x1=
0
> Oct 09 15:26:08 f38-nfsd kernel:  ? __virt_addr_valid+0xbe/0x130
> Oct 09 15:26:08 f38-nfsd kernel:  ? svc_exit_thread+0x10c/0x150 [sunrpc]
> Oct 09 15:26:08 f38-nfsd kernel:  kasan_report+0xac/0xe0
> Oct 09 15:26:08 f38-nfsd kernel:  ? svc_exit_thread+0x10c/0x150 [sunrpc]
> Oct 09 15:26:08 f38-nfsd kernel:  kasan_check_range+0xf0/0x1a0
> Oct 09 15:26:08 f38-nfsd kernel:  svc_exit_thread+0x10c/0x150 [sunrpc]
> Oct 09 15:26:08 f38-nfsd kernel:  lockd+0x15d/0x1a0 [lockd]
> Oct 09 15:26:08 f38-nfsd kernel:  ? __pfx_lockd+0x10/0x10 [lockd]
> Oct 09 15:26:08 f38-nfsd kernel:  kthread+0x181/0x1c0
> Oct 09 15:26:08 f38-nfsd kernel:  ? __pfx_kthread+0x10/0x10
> Oct 09 15:26:08 f38-nfsd kernel:  ret_from_fork+0x2d/0x50
> Oct 09 15:26:08 f38-nfsd kernel:  ? __pfx_kthread+0x10/0x10
> Oct 09 15:26:08 f38-nfsd kernel:  ret_from_fork_asm+0x1b/0x30
> Oct 09 15:26:08 f38-nfsd kernel:  </TASK>
> Oct 09 15:26:08 f38-nfsd kernel:=20
> Oct 09 15:26:08 f38-nfsd kernel: Allocated by task 835:
> Oct 09 15:26:08 f38-nfsd kernel:  kasan_save_stack+0x1c/0x40
> Oct 09 15:26:08 f38-nfsd kernel:  kasan_set_track+0x21/0x30
> Oct 09 15:26:08 f38-nfsd kernel:  __kasan_kmalloc+0xa6/0xb0
> Oct 09 15:26:08 f38-nfsd kernel:  __kmalloc+0x5d/0x160
> Oct 09 15:26:08 f38-nfsd kernel:  __svc_create+0x2b0/0x470 [sunrpc]
> Oct 09 15:26:08 f38-nfsd kernel:  lockd_up+0x111/0x3b0 [lockd]
> Oct 09 15:26:08 f38-nfsd kernel:  nfsd_svc+0x54a/0x580 [nfsd]
> Oct 09 15:26:08 f38-nfsd kernel:  write_threads+0x148/0x260 [nfsd]
> Oct 09 15:26:08 f38-nfsd kernel:  nfsctl_transaction_write+0x76/0xa0 [nfs=
d]
> Oct 09 15:26:08 f38-nfsd kernel:  vfs_write+0x1b4/0x670
> Oct 09 15:26:08 f38-nfsd kernel:  ksys_write+0xbd/0x160
> Oct 09 15:26:08 f38-nfsd kernel:  do_syscall_64+0x38/0x90
> Oct 09 15:26:08 f38-nfsd kernel:  entry_SYSCALL_64_after_hwframe+0x6e/0xd=
8
> Oct 09 15:26:08 f38-nfsd kernel:=20
> Oct 09 15:26:08 f38-nfsd kernel: Freed by task 973:
> Oct 09 15:26:08 f38-nfsd kernel:  kasan_save_stack+0x1c/0x40
> Oct 09 15:26:08 f38-nfsd kernel:  kasan_set_track+0x21/0x30
> Oct 09 15:26:08 f38-nfsd kernel:  kasan_save_free_info+0x27/0x40
> Oct 09 15:26:08 f38-nfsd kernel:  ____kasan_slab_free+0x166/0x1c0
> Oct 09 15:26:08 f38-nfsd kernel:  slab_free_freelist_hook+0x9f/0x1e0
> Oct 09 15:26:08 f38-nfsd kernel:  __kmem_cache_free+0x187/0x2d0
> Oct 09 15:26:08 f38-nfsd kernel:  svc_destroy+0x105/0x1d0 [sunrpc]
> Oct 09 15:26:08 f38-nfsd kernel:  svc_exit_thread+0x135/0x150 [sunrpc]
> Oct 09 15:26:08 f38-nfsd kernel:  lockd+0x15d/0x1a0 [lockd]
> Oct 09 15:26:08 f38-nfsd kernel:  kthread+0x181/0x1c0
> Oct 09 15:26:08 f38-nfsd kernel:  ret_from_fork+0x2d/0x50
> Oct 09 15:26:08 f38-nfsd kernel:  ret_from_fork_asm+0x1b/0x30
> Oct 09 15:26:08 f38-nfsd kernel:=20
> Oct 09 15:26:08 f38-nfsd kernel: The buggy address belongs to the object =
at ffff888112147b00
>                                   which belongs to the cache kmalloc-192 =
of size 192
> Oct 09 15:26:08 f38-nfsd kernel: The buggy address is located 184 bytes i=
nside of
>                                   freed 192-byte region [ffff888112147b00=
, ffff888112147bc0)
> Oct 09 15:26:08 f38-nfsd kernel:=20
> Oct 09 15:26:08 f38-nfsd kernel: The buggy address belongs to the physica=
l page:
> Oct 09 15:26:08 f38-nfsd kernel: page:00000000b3fc2355 refcount:1 mapcoun=
t:0 mapping:0000000000000000 index:0xffff888112147d00 pfn:0x112146
> Oct 09 15:26:08 f38-nfsd kernel: head:00000000b3fc2355 order:1 entire_map=
count:0 nr_pages_mapped:0 pincount:0
> Oct 09 15:26:08 f38-nfsd kernel: flags: 0x17fffc000000840(slab|head|node=
=3D0|zone=3D2|lastcpupid=3D0x1ffff)
> Oct 09 15:26:08 f38-nfsd kernel: page_type: 0xffffffff()
> Oct 09 15:26:08 f38-nfsd kernel: raw: 017fffc000000840 ffff888100042a00 f=
fffea0004098790 ffffea00043e1b10
> Oct 09 15:26:08 f38-nfsd kernel: raw: ffff888112147d00 000000000020000f 0=
0000001ffffffff 0000000000000000
> Oct 09 15:26:08 f38-nfsd kernel: page dumped because: kasan: bad access d=
etected
> Oct 09 15:26:08 f38-nfsd kernel:=20
> Oct 09 15:26:08 f38-nfsd kernel: Memory state around the buggy address:
> Oct 09 15:26:08 f38-nfsd kernel:  ffff888112147a80: 00 00 00 00 00 00 00 =
fc fc fc fc fc fc fc fc fc
> Oct 09 15:26:08 f38-nfsd kernel:  ffff888112147b00: fa fb fb fb fb fb fb =
fb fb fb fb fb fb fb fb fb
> Oct 09 15:26:08 f38-nfsd kernel: >ffff888112147b80: fb fb fb fb fb fb fb =
fb fc fc fc fc fc fc fc fc
> Oct 09 15:26:08 f38-nfsd kernel:                                         =
^
> Oct 09 15:26:08 f38-nfsd kernel:  ffff888112147c00: 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00
> Oct 09 15:26:08 f38-nfsd kernel:  ffff888112147c80: 00 00 00 00 00 00 fc =
fc fc fc fc fc fc fc fc fc
> Oct 09 15:26:08 f38-nfsd kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>=20

Some follow up info. It looks like the comment in svc_exit_thread about
it not being the last reference may no longer be true for lockd?

$ ./scripts/faddr2line --list net/sunrpc/sunrpc.ko svc_exit_thread+0x10c/0x=
150
(inlined by) svc_exit_thread at /home/jlayton/git/linux/net/sunrpc/svc.c:94=
3
 938 		svc_put(serv);
 939 		/* That svc_put() cannot be the last, because the thread
 940 		 * waiting for SP_VICTIM_REMAINS to clear must hold
 941 		 * a reference. So it is still safe to access pool.
 942 		 */
>943<		clear_and_wake_up_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
 944 	}
 945 	EXPORT_SYMBOL_GPL(svc_exit_thread);
 946 =09
 947 	/*
 948 	 * Register an "inet" protocol family netid with the local

$ ./scripts/faddr2line --list net/sunrpc/sunrpc.ko svc_exit_thread+0x135/0x=
150
(inlined by) svc_exit_thread at /home/jlayton/git/linux/net/sunrpc/svc.c:93=
8
 933 		spin_unlock_bh(&serv->sv_lock);
 934 		svc_sock_update_bufs(serv);
 935 =09
 936 		svc_rqst_free(rqstp);
 937 =09
>938<		svc_put(serv);
 939 		/* That svc_put() cannot be the last, because the thread
 940 		 * waiting for SP_VICTIM_REMAINS to clear must hold
 941 		 * a reference. So it is still safe to access pool.
 942 		 */
 943 		clear_and_wake_up_bit(SP_VICTIM_REMAINS, &pool->sp_flags);

--=20
Jeff Layton <jlayton@kernel.org>
