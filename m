Return-Path: <linux-nfs+bounces-12832-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AA9AEF547
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Jul 2025 12:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5D5C3AD2D9
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Jul 2025 10:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F06239E6A;
	Tue,  1 Jul 2025 10:40:01 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DFA22F76F
	for <linux-nfs@vger.kernel.org>; Tue,  1 Jul 2025 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751366401; cv=none; b=mWWq7lvtFIMipVxrsJPW4v7aGbqthugCNmxS5ocUl5AnTLplyu1gKXIUF4HfDjAASWVr5tu0EpNoPxvfrTm0ejXm5NsI0s/azl22rC+CydYjI6x2TJT+uwNg6t+AZF7XOEBhv6+x5Pnen34SbjhvRIbMvhTPclpB+OAGcL5Oqn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751366401; c=relaxed/simple;
	bh=bR6bqsHQDIRbiRA20wQmDI5nLvhjbRWTGXhSUwBos3o=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=oOFtSHsHNaTDBYGRkP7l/Q/LFKbpSfokBieTu5lrlUyULAyPKl/qAkk/Y4lMsTlVkrVX+pws3p1V4cSk3bVIiQtbYiMjO1mdclxuFk6ILqu+hBB0V796FUa6xJYzBQ6i7AHbn5gPZxaGOGqn8/bTJT3GrEC8qX0GUCbNhFkQdG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uWYOs-00Flyf-S4;
	Tue, 01 Jul 2025 10:39:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Li Lingfeng" <lilingfeng3@huawei.com>
Cc: linux-nfs@vger.kernel.org, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "yangerkun" <yangerkun@huawei.com>, "zhangyi (F)" <yi.zhang@huawei.com>,
 "Hou Tao" <houtao1@huawei.com>, "yukuai (C)" <yukuai3@huawei.com>,
 "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH RFT] nfsd: provide locking for v4_end_grace
In-reply-to: <e7ccd4fc-484d-4402-a245-7019e08b90fc@huawei.com>
References: <175133604142.565058.11913456377522907637@noble.neil.brown.name>,
 <e7ccd4fc-484d-4402-a245-7019e08b90fc@huawei.com>
Date: Tue, 01 Jul 2025 20:39:41 +1000
Message-id: <175136638166.565058.13966519692554283188@noble.neil.brown.name>

On Tue, 01 Jul 2025, Li Lingfeng wrote:
> Hi, Neil
> I tested this patch, but unfortunately it did not resolve the issue.

Thanks a lot for testing.  I see now that the test on ->nfsd_serv
doesn't do anything useful and that the laundromat_work needs to be
disabled until _init is finished the same as it is disabled before _exit
is started.

I'll send a new patch.

Thanks,
NeilBrown


>=20
> I think the concurrency situation should be like this:
> nfsd_svc
>  =C2=A0nfsd_startup_net
>  =C2=A0 nfs4_state_start_net
>  =C2=A0 =C2=A0nfs4_state_create_net
>  =C2=A0 =C2=A0 INIT_DELAYED_WORK
>  =C2=A0 =C2=A0 // nn->laundromat_work has been initialized
>  =C2=A0 =C2=A0nfsd4_client_tracking_init
>  =C2=A0 =C2=A0 nfsd4_cld_tracking_init
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 write_v4_end_grace
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0nfsd4_end_grace
> nfsd4_record_grace_done
>  =C2=A0nfsd4_cld_grace_done
> alloc_cld_upcall
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cn =3D nn->cld_net
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock //=20
> cn->cn_lock
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// null-ptr-deref
>  =C2=A0 =C2=A0 =C2=A0__nfsd4_init_cld_pipe
>  =C2=A0 =C2=A0 =C2=A0 cn =3D kzalloc
>  =C2=A0 =C2=A0 =C2=A0 nn->cld_net =3D cn
>=20
> The problem I encountered is writing v4_end_grace and service startup=20
> concurrency.
> This patch moves the immediate tasks of write_v4_end_grace to=20
> laundromat_work.
> I believe it can prevent deadlock issues, but it does not actually=20
> address the
> null pointer dereferences caused by concurrency.
>=20
> Thanks,
> Lingfeng.
>=20
> Base:
> commit 86731a2a651e58953fc949573895f2fa6d456841 (tag: v6.16-rc3,
> origin/master, origin/HEAD)
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:=C2=A0 =C2=A0Sun Jun 22 13:30:08 2025 -0700
>=20
>  =C2=A0 =C2=A0 =C2=A0Linux 6.16-rc3
>=20
> Diff:
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index 82785db730d9..0c6f0fbecc02 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -1008,7 +1008,8 @@ __nfsd4_init_cld_pipe(struct net *net)
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (nn->cld_net)
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>=20
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0cn =3D kzalloc(sizeof(*cn), GFP_KERNEL);
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0cn =3D NULL;//kzalloc(sizeof(*cn), GFP_KERNEL);
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0printk("%s force err inject\n", __func__);
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cn) {
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;
> @@ -1478,6 +1479,7 @@ nfs4_cld_state_init(struct net *net)
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 nn->reclaim_str_hashtbl =3D kmalloc_array(CLIE=
NT_HASH_SIZE,
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 sizeof(struct list_head),
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 GFP_KERNEL);
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0printk("%s get nn->reclaim_str_hashtbl %px\n", =
__func__,=20
> nn->reclaim_str_hashtbl);
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!nn->reclaim_str_hashtbl)
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
>=20
> @@ -1496,7 +1498,12 @@ nfs4_cld_state_shutdown(struct net *net)
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct nfsd_net *nn =3D net_generic(net, nfsd_=
net_id);
>=20
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 nn->track_reclaim_completes =3D false;
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0printk("%s free nn->reclaim_str_hashtbl %px\n",=
 __func__,=20
> nn->reclaim_str_hashtbl);
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(nn->reclaim_str_hashtbl);
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0printk("%s free nn->reclaim_str_hashtbl %px don=
e\n", __func__,=20
> nn->reclaim_str_hashtbl);
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0printk("%s sleep after free...\n", __func__);
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0msleep(10 * 1000);
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0printk("%s sleep done\n", __func__);
>  =C2=A0}
>=20
>  =C2=A0static bool
>=20
> CLIENT A:
> [root@nfs_test3 ~]# mount /dev/sdb /mnt/sdb
> [root@nfs_test3 ~]# echo "/mnt *(rw,no_root_squash,fsid=3D0)" > /etc/exports
> [root@nfs_test3 ~]# echo "/mnt/sdb *(rw,no_root_squash,fsid=3D1)" >>=20
> /etc/exports
> [root@nfs_test3 ~]# systemctl restart nfs-server
> [=C2=A0 142.103887][ T2762] nfs4_cld_state_init get nn->reclaim_str_hashtbl=
=20
> ffff88819366f000
> [=C2=A0 142.104971][ T2762] __nfsd4_init_cld_pipe force err inject
> [=C2=A0 142.105631][ T2762] NFSD: unable to create nfsdcld upcall pipe (-12)
> [=C2=A0 142.106384][ T2762] nfs4_cld_state_shutdown free=20
> nn->reclaim_str_hashtbl ffff88819366f000
> [=C2=A0 142.107366][ T2762] nfs4_cld_state_shutdown free=20
> nn->reclaim_str_hashtbl ffff88819366f000 done
> [=C2=A0 142.108373][ T2762] nfs4_cld_state_shutdown sleep after free...
> [=C2=A0 142.872490][=C2=A0 T149] Oops: general protection fault, probably f=
or=20
> non-canonical address 0xdffffc0000000004: 0000 [#1] SMP KASAN PTI
> [=C2=A0 142.874022][=C2=A0 T149] KASAN: null-ptr-deref in range=20
> [0x0000000000000020-0x0000000000000027]
> [=C2=A0 142.875066][=C2=A0 T149] CPU: 10 UID: 0 PID: 149 Comm: kworker/u64:=
4 Not=20
> tainted 6.16.0-rc3-00001-g4c30cab673ec-dirty #87 PREEMPT(undef)
> [=C2=A0 142.876545][=C2=A0 T149] Hardware name: QEMU Standard PC (i440FX + =
PIIX,=20
> 1996), BIOS 1.16.3-2.fc40 04/01/2014
> [=C2=A0 142.877725][=C2=A0 T149] Workqueue: nfsd4 laundromat_main
> [=C2=A0 142.878381][=C2=A0 T149] RIP: 0010:kasan_byte_accessible+0x15/0x30
> [=C2=A0 142.879112][=C2=A0 T149] Code: 00 00 0f 1f 00 90 90 90 90 90 90 90 =
90 90=20
> 90 90 90 90 90 90 90 66 0f 1f 00 48 b8 00 00 00 00 00 fc ff df 48 c1 ef=20
> 03 48 01 c7 <0f> b6 07 3c 07 0f 96 c00
> [=C2=A0 142.881501][=C2=A0 T149] RSP: 0018:ffffc900015d7968 EFLAGS: 00010282
> [=C2=A0 142.882251][=C2=A0 T149] RAX: dffffc0000000000 RBX: 000000000000002=
0 RCX:=20
> 0000000000000000
> [=C2=A0 142.883229][=C2=A0 T149] RDX: 0000000000000000 RSI: ffffffffa27a462=
0 RDI:=20
> dffffc0000000004
> [=C2=A0 142.884216][=C2=A0 T149] RBP: 0000000000000020 R08: 000000000000000=
1 R09:=20
> 0000000000000000
> [=C2=A0 142.885195][=C2=A0 T149] R10: ffffffffa17ffd3a R11: ffffffffa0d66db=
e R12:=20
> ffffffffa27a4620
> [=C2=A0 142.886176][=C2=A0 T149] R13: 0000000000000001 R14: 000000000000000=
0 R15:=20
> 0000000000000000
> [=C2=A0 142.887150][=C2=A0 T149] FS:=C2=A0 0000000000000000(0000)=20
> GS:ffff888e52e1b000(0000) knlGS:0000000000000000
> [=C2=A0 142.888246][=C2=A0 T149] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000=
000080050033
> [=C2=A0 142.889059][=C2=A0 T149] CR2: 0000557d474b9308 CR3: 0000000f2408e00=
0 CR4:=20
> 00000000000006f0
> [=C2=A0 142.890029][=C2=A0 T149] DR0: 0000000000000000 DR1: 000000000000000=
0 DR2:=20
> 0000000000000000
> [=C2=A0 142.891008][=C2=A0 T149] DR3: 0000000000000000 DR6: 00000000fffe0ff=
0 DR7:=20
> 0000000000000400
> [=C2=A0 142.891977][=C2=A0 T149] Call Trace:
> [=C2=A0 142.892390][=C2=A0 T149]=C2=A0 <TASK>
> [=C2=A0 142.892753][=C2=A0 T149]=C2=A0 __kasan_check_byte+0x13/0x50
> [=C2=A0 142.893363][=C2=A0 T149]=C2=A0 lock_acquire.part.0+0x36/0x220
> [=C2=A0 142.893990][=C2=A0 T149]=C2=A0 ? rcu_is_watching+0x20/0x50
> [=C2=A0 142.894592][=C2=A0 T149]=C2=A0 ? lock_acquire+0xf2/0x140
> [=C2=A0 142.895162][=C2=A0 T149]=C2=A0 ? alloc_cld_upcall+0x6a/0x1e0
> [=C2=A0 142.895776][=C2=A0 T149]=C2=A0 _raw_spin_lock+0x30/0x40
> [=C2=A0 142.896339][=C2=A0 T149]=C2=A0 ? alloc_cld_upcall+0x6a/0x1e0
> [=C2=A0 142.896948][=C2=A0 T149]=C2=A0 alloc_cld_upcall+0x6a/0x1e0
> [=C2=A0 142.897543][=C2=A0 T149]=C2=A0 nfsd4_cld_grace_done+0x93/0x270
> [=C2=A0 142.898174][=C2=A0 T149]=C2=A0 ? __pfx_nfsd4_cld_grace_done+0x10/0x=
10
> [=C2=A0 142.898889][=C2=A0 T149]=C2=A0 ? find_held_lock+0x2b/0x80
> [=C2=A0 142.899473][=C2=A0 T149]=C2=A0 ? nfs4_laundromat+0x8e/0xc30
> [=C2=A0 142.900071][=C2=A0 T149]=C2=A0 ? nfs4_laundromat+0x8e/0xc30
> [=C2=A0 142.900660][=C2=A0 T149]=C2=A0 ? mark_held_locks+0x40/0x70
> [=C2=A0 142.901259][=C2=A0 T149]=C2=A0 nfsd4_end_grace.part.0+0x51/0x120
> [=C2=A0 142.901913][=C2=A0 T149]=C2=A0 nfs4_laundromat+0x29a/0xc30
> [=C2=A0 142.902519][=C2=A0 T149]=C2=A0 ? __pfx_nfs4_laundromat+0x10/0x10
> [=C2=A0 142.903173][=C2=A0 T149]=C2=A0 ? __lock_release.isra.0+0x5f/0x180
> [=C2=A0 142.903850][=C2=A0 T149]=C2=A0 ? lock_acquire.part.0+0xac/0x220
> [=C2=A0 142.904493][=C2=A0 T149]=C2=A0 ? process_one_work+0x72b/0x8a0
> [=C2=A0 142.905112][=C2=A0 T149]=C2=A0 ? rcu_is_watching+0x20/0x50
> [=C2=A0 142.905708][=C2=A0 T149]=C2=A0 ? process_one_work+0x72b/0x8a0
> [=C2=A0 142.906336][=C2=A0 T149]=C2=A0 laundromat_main+0x19/0x40
> [=C2=A0 142.906903][=C2=A0 T149]=C2=A0 process_one_work+0x7ab/0x8a0
> [=C2=A0 142.907509][=C2=A0 T149]=C2=A0 ? process_one_work+0x72b/0x8a0
> [=C2=A0 142.908130][=C2=A0 T149]=C2=A0 ? process_one_work+0x72b/0x8a0
> [=C2=A0 142.908764][=C2=A0 T149]=C2=A0 ? __pfx_process_one_work+0x10/0x10
> [=C2=A0 142.909433][=C2=A0 T149]=C2=A0 ? __list_add_valid_or_report+0x37/0x=
100
> [=C2=A0 142.910160][=C2=A0 T149]=C2=A0 worker_thread+0x390/0x690
> [=C2=A0 142.910738][=C2=A0 T149]=C2=A0 ? __kthread_parkme+0xe8/0x110
> [=C2=A0 142.911355][=C2=A0 T149]=C2=A0 ? __pfx_worker_thread+0x10/0x10
> [=C2=A0 142.911990][=C2=A0 T149]=C2=A0 kthread+0x23c/0x3d0
> [=C2=A0 142.912499][=C2=A0 T149]=C2=A0 ? kthread+0x12d/0x3d0
> [=C2=A0 142.913024][=C2=A0 T149]=C2=A0 ? __pfx_kthread+0x10/0x10
> [=C2=A0 142.913601][=C2=A0 T149]=C2=A0 ? ret_from_fork+0x1d/0x2b0
> [=C2=A0 142.914180][=C2=A0 T149]=C2=A0 ? __lock_release.isra.0+0x5f/0x180
> [=C2=A0 142.914853][=C2=A0 T149]=C2=A0 ? rcu_is_watching+0x20/0x50
> [=C2=A0 142.915450][=C2=A0 T149]=C2=A0 ? __pfx_kthread+0x10/0x10
> [=C2=A0 142.916018][=C2=A0 T149]=C2=A0 ret_from_fork+0x21e/0x2b0
> [=C2=A0 142.916588][=C2=A0 T149]=C2=A0 ? __pfx_kthread+0x10/0x10
> [=C2=A0 142.917167][=C2=A0 T149]=C2=A0 ret_from_fork_asm+0x1a/0x30
> [=C2=A0 142.917766][=C2=A0 T149]=C2=A0 </TASK>
> [=C2=A0 142.918146][=C2=A0 T149] Modules linked in:
> [=C2=A0 142.918674][=C2=A0 T149] ---[ end trace 0000000000000000 ]---
> [=C2=A0 142.919360][=C2=A0 T149] RIP: 0010:kasan_byte_accessible+0x15/0x30
> [=C2=A0 142.920099][=C2=A0 T149] Code: 00 00 0f 1f 00 90 90 90 90 90 90 90 =
90 90=20
> 90 90 90 90 90 90 90 66 0f 1f 00 48 b8 00 00 00 00 00 fc ff df 48 c1 ef=20
> 03 48 01 c7 <0f> b6 07 3c 07 0f 96 c00
> [=C2=A0 142.922522][=C2=A0 T149] RSP: 0018:ffffc900015d7968 EFLAGS: 00010282
> [=C2=A0 142.923276][=C2=A0 T149] RAX: dffffc0000000000 RBX: 000000000000002=
0 RCX:=20
> 0000000000000000
> [=C2=A0 142.924271][=C2=A0 T149] RDX: 0000000000000000 RSI: ffffffffa27a462=
0 RDI:=20
> dffffc0000000004
> [=C2=A0 142.925297][=C2=A0 T149] RBP: 0000000000000020 R08: 000000000000000=
1 R09:=20
> 0000000000000000
> [=C2=A0 142.926282][=C2=A0 T149] R10: ffffffffa17ffd3a R11: ffffffffa0d66db=
e R12:=20
> ffffffffa27a4620
> [=C2=A0 142.927280][=C2=A0 T149] R13: 0000000000000001 R14: 000000000000000=
0 R15:=20
> 0000000000000000
> [=C2=A0 142.928259][=C2=A0 T149] FS:=C2=A0 0000000000000000(0000)=20
> GS:ffff888e52e1b000(0000) knlGS:0000000000000000
> [=C2=A0 142.929382][=C2=A0 T149] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000=
000080050033
> [=C2=A0 142.930198][=C2=A0 T149] CR2: 0000557d474b9308 CR3: 0000000f2408e00=
0 CR4:=20
> 00000000000006f0
> [=C2=A0 142.931185][=C2=A0 T149] DR0: 0000000000000000 DR1: 000000000000000=
0 DR2:=20
> 0000000000000000
> [=C2=A0 142.932173][=C2=A0 T149] DR3: 0000000000000000 DR6: 00000000fffe0ff=
0 DR7:=20
> 0000000000000400
> [=C2=A0 142.933175][=C2=A0 T149] Kernel panic - not syncing: Fatal exception
> [=C2=A0 142.934551][=C2=A0 T149] Kernel Offset: 0x1fa00000 from 0xffffffff8=
1000000=20
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [=C2=A0 142.935979][=C2=A0 T149] ---[ end Kernel panic - not syncing: Fatal=
=20
> exception ]---
>=20
> CLIENT B:
> write /proc/fs/nfsd/v4_end_grace between "nfs4_cld_state_shutdown sleep
> after free..." and "nfs4_cld_state_shutdown sleep done"
> [root@nfs_test3 ~]# echo 1 > /proc/fs/nfsd/v4_end_grace
>=20
> =E5=9C=A8 2025/7/1 10:14, NeilBrown =E5=86=99=E9=81=93:
> > Writing to v4_end_grace can race with server shutdown and result in
> > memory being accessed after it was freed - reclaim_str_hashtbl in
> > particular.
> >
> > We cannot hold nfsd_mutex across the nfsd4_end_grace() call as that is
> > held while client_tracking_op->init() is called and that can wait for
> > an upcall to nfsdcltrack which can write to v4_end_grace, resulting in a
> > deadlock.
> >
> > nfsd4_end_grace() is also called by the landromat work queue and this
> > doesn't require locking as server shutdown will stop the work and wait
> > for it before freeing anything that nfsd4_end_grace() might access.
> >
> > However, we must be sure that writing to v4_end_grace doesn't restart
> > the work item after shutdown has already waited for it.  For this we can
> > use disable_delayed_work_sync() instead of cancel_delayed_work_sync().
> >
> > So this patch adds a nfsd_net field "grace_end_forced", sets that when
> > v4_end_grace is written, and schedules the laundromat (providing it
> > hasn't been disabled).  This field bypasses other checks for whether the
> > grace period has finished.  The delayed work is disabled before
> > nfsd4_client_tracking_exit() is call to shutdown client tracking.
> >
> > This resolves a race which can result in use-after-free.
> >
> > Note that disable_delayed_work_sync() was added in v6.10.  To backport
> > to an earlier kernel without that interface the exclusion could be
> > provided by some spinlock that was released in the shutdown path
> > after ->nfsd_serv is set to NULL.  It would need to be taken before
> > the test on nfsd_serv in write_v4_end_grace() and released after
> > nfsd4_force_end_grace() is called.
> >
> > Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >   fs/nfsd/netns.h     |  1 +
> >   fs/nfsd/nfs4state.c | 19 ++++++++++++++++---
> >   fs/nfsd/nfsctl.c    |  7 ++++++-
> >   fs/nfsd/state.h     |  2 +-
> >   4 files changed, 24 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > index 3e2d0fde80a7..d83c68872c4c 100644
> > --- a/fs/nfsd/netns.h
> > +++ b/fs/nfsd/netns.h
> > @@ -66,6 +66,7 @@ struct nfsd_net {
> >  =20
> >   	struct lock_manager nfsd4_manager;
> >   	bool grace_ended;
> > +	bool grace_end_forced;
> >   	time64_t boot_time;
> >  =20
> >   	struct dentry *nfsd_client_dir;
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index d5694987f86f..b34f157334e6 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -84,7 +84,7 @@ static u64 current_sessionid =3D 1;
> >   /* forward declarations */
> >   static bool check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner=
 *lowner);
> >   static void nfs4_free_ol_stateid(struct nfs4_stid *stid);
> > -void nfsd4_end_grace(struct nfsd_net *nn);
> > +static void nfsd4_end_grace(struct nfsd_net *nn);
> >   static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_c=
pntf_state *cps);
> >   static void nfsd4_file_hash_remove(struct nfs4_file *fi);
> >   static void deleg_reaper(struct nfsd_net *nn);
> > @@ -6458,7 +6458,7 @@ nfsd4_renew(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
> >   	return nfs_ok;
> >   }
> >  =20
> > -void
> > +static void
> >   nfsd4_end_grace(struct nfsd_net *nn)
> >   {
> >   	/* do nothing if grace period already ended */
> > @@ -6491,6 +6491,16 @@ nfsd4_end_grace(struct nfsd_net *nn)
> >   	 */
> >   }
> >  =20
> > +void
> > +nfsd4_force_end_grace(struct nfsd_net *nn)
> > +{
> > +	nn->grace_end_forced =3D true;
> > +	/* This is a no-op after nfs4_state_shutdown_net() has called
> > +	 * disable_delayed_work_sync()
> > +	 */
> > +	mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> > +}
> > +
> >   /*
> >    * If we've waited a lease period but there are still clients trying to
> >    * reclaim, wait a little longer to give them a chance to finish.
> > @@ -6500,6 +6510,8 @@ static bool clients_still_reclaiming(struct nfsd_ne=
t *nn)
> >   	time64_t double_grace_period_end =3D nn->boot_time +
> >   					   2 * nn->nfsd4_lease;
> >  =20
> > +	if (nn->grace_end_forced)
> > +		return false;
> >   	if (nn->track_reclaim_completes &&
> >   			atomic_read(&nn->nr_reclaim_complete) =3D=3D
> >   			nn->reclaim_str_hashtbl_size)
> > @@ -8807,6 +8819,7 @@ static int nfs4_state_create_net(struct net *net)
> >   	nn->unconf_name_tree =3D RB_ROOT;
> >   	nn->boot_time =3D ktime_get_real_seconds();
> >   	nn->grace_ended =3D false;
> > +	nn->grace_end_forced =3D false;
> >   	nn->nfsd4_manager.block_opens =3D true;
> >   	INIT_LIST_HEAD(&nn->nfsd4_manager.list);
> >   	INIT_LIST_HEAD(&nn->client_lru);
> > @@ -8935,7 +8948,7 @@ nfs4_state_shutdown_net(struct net *net)
> >  =20
> >   	shrinker_free(nn->nfsd_client_shrinker);
> >   	cancel_work_sync(&nn->nfsd_shrinker_work);
> > -	cancel_delayed_work_sync(&nn->laundromat_work);
> > +	disable_delayed_work_sync(&nn->laundromat_work);
> >   	locks_end_grace(&nn->nfsd4_manager);
> >  =20
> >   	INIT_LIST_HEAD(&reaplist);
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 3f3e9f6c4250..a9e6c2a155da 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -1082,10 +1082,15 @@ static ssize_t write_v4_end_grace(struct file *fi=
le, char *buf, size_t size)
> >   		case 'Y':
> >   		case 'y':
> >   		case '1':
> > +			/* This test ensures we don't try to
> > +			 * end grace before the server has been started,
> > +			 * but doesn't guarantee we don't end grace
> > +			 * while the server is being shut down.
> > +			 */
> >   			if (!nn->nfsd_serv)
> >   				return -EBUSY;
> >   			trace_nfsd_end_grace(netns(file));
> > -			nfsd4_end_grace(nn);
> > +			nfsd4_force_end_grace(nn);
> >   			break;
> >   		default:
> >   			return -EINVAL;
> > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > index 1995bca158b8..e2bea9908fa8 100644
> > --- a/fs/nfsd/state.h
> > +++ b/fs/nfsd/state.h
> > @@ -836,7 +836,7 @@ static inline void nfsd4_revoke_states(struct net *ne=
t, struct super_block *sb)
> >   #endif
> >  =20
> >   /* grace period management */
> > -void nfsd4_end_grace(struct nfsd_net *nn);
> > +void nfsd4_force_end_grace(struct nfsd_net *nn);
> >  =20
> >   /* nfs4recover operations */
> >   extern int nfsd4_client_tracking_init(struct net *net);
>=20


