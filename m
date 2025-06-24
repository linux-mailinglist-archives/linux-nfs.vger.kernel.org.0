Return-Path: <linux-nfs+bounces-12682-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4833CAE5A79
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jun 2025 05:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E8A3BFFCA
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jun 2025 03:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5B26136;
	Tue, 24 Jun 2025 03:27:18 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678DE202983
	for <linux-nfs@vger.kernel.org>; Tue, 24 Jun 2025 03:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750735638; cv=none; b=FcSNlCy9yMu4cOc570rPG6ltvpilvOykvO6qpObLCOGvc9t+HHVnCnVmr8y3g8D/mQK0mvIHuGWGZ3f6rIItg7ttR6gM81C4+TqFrimXBCS43SjoVdcM7RxR57BxNI7dvDrG1/z8h2c1R0qAV7EavG7+aMVRq4JWw90aSyL1JSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750735638; c=relaxed/simple;
	bh=yag7TOKEZ1KaCgZmGiTtc/2zQgEWJOSuFv1bvpUfAVA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=fmm1lTke3rzjIfbi5B2uRo7oMgyCHsBu4rksQaaBbXZIaXzemB6Rf8y6QnSQDCsCyfDs4I0EmBpQdgli+WMg51BjkcmgXnhaAOBoQM075ITGFXwiG4YqSa6CQ6q8BwIOfj02ppowbVZ3xhdGZTjh30YUL/mtYnM6OjRIaXX0mt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uTuJJ-003aYp-SO;
	Tue, 24 Jun 2025 03:27:01 +0000
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
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 linux-nfs@vger.kernel.org, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "yangerkun" <yangerkun@huawei.com>, "zhangyi (F)" <yi.zhang@huawei.com>,
 "Hou Tao" <houtao1@huawei.com>, "yukuai (C)" <yukuai3@huawei.com>,
 libaokun1@huawei.com
Subject: Re: [PATCH 1/4] nfsd: provide proper locking for all write_ function
In-reply-to: <87302f1a-8313-4dd7-919e-849291efece2@huawei.com>
References: <>, <87302f1a-8313-4dd7-919e-849291efece2@huawei.com>
Date: Tue, 24 Jun 2025 13:27:00 +1000
Message-id: <175073562007.2280845.7399854714861301361@noble.neil.brown.name>

On Tue, 24 Jun 2025, Li Lingfeng wrote:
> Hi,
>=20
> During my validation of this fix patch, I encountered a deadlock issue
> that wasn't present during last Saturday's verification.
> Process 2761 holds the nfsd_mutex while sending an upcall request,
> triggering process 2776.

Thanks for testing!  Holding a mutex while sending an upcall is
definitely bad.  We might have to drop and retake the mutex and add more
checks after the retake.  I'll have a look.

> This process must complete writing to end_grace before responding to the
> upcall, but it gets blocked while attempting to acquire the nfsd_mutex,
> causing a deadlock.
> I revalidated the previous solution and found the same issue.
> I'm unsure what changed between validations.
> Additionally, why was the locking mechanism changed from guard(mutex) in
> the previous version to explicit mutex_lock/mutex_unlock in this version?

I thought the mutex_lock/unlock version would be easier to backport.  We
haven't had guard() for all that long.  The behaviour should be the
same.

Thanks,
NeilBrown



>=20
> Thanks.
>=20
> Base:
> commit 86731a2a651e58953fc949573895f2fa6d456841 (tag: v6.16-rc3,=20
> origin/master, origin/HEAD)
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:=C2=A0 =C2=A0Sun Jun 22 13:30:08 2025 -0700
>=20
>  =C2=A0 =C2=A0 Linux 6.16-rc3
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
>=20
> CLIENT A:
> [root@nfs_test3 ~]# mount /dev/sdb /mnt/sdb
> [root@nfs_test3 ~]# echo "/mnt *(rw,no_root_squash,fsid=3D0)" > /etc/exports
> [root@nfs_test3 ~]# echo "/mnt/sdb *(rw,no_root_squash,fsid=3D1)" >>=20
> /etc/exports
> [root@nfs_test3 ~]# systemctl restart nfs-server
> [=C2=A0 229.107168][ T2761] nfs4_cld_state_init get nn->reclaim_str_hashtbl=
=20
> ffff88810e20ba00
> [=C2=A0 229.108175][ T2761] __nfsd4_init_cld_pipe force err inject
> [=C2=A0 229.108819][ T2761] NFSD: unable to create nfsdcld upcall pipe (-12)
> [=C2=A0 229.109568][ T2761] nfs4_cld_state_shutdown free=20
> nn->reclaim_str_hashtbl ffff88810e20ba00
> [=C2=A0 229.110601][ T2761] nfs4_cld_state_shutdown free=20
> nn->reclaim_str_hashtbl ffff88810e20ba00 done
> [=C2=A0 229.111599][ T2761] nfs4_cld_state_shutdown sleep after free...
> [=C2=A0 239.282399][ T2761] nfs4_cld_state_shutdown sleep done
> [=C2=A0 239.283083][ T2761] __nfsd4_init_cld_pipe force err inject
> [=C2=A0 239.283734][ T2761] NFSD: unable to create nfsdcld upcall pipe (-12)
> [=C2=A0 453.554502][=C2=A0 T101] INFO: task bash:2644 blocked for more than=
 147=20
> seconds.
> [=C2=A0 453.555494][=C2=A0 T101]=C2=A0 =C2=A0 =C2=A0 =C2=A0Not tainted=20
> 6.16.0-rc3-00001-g4e8c356736df-dirty #84
> [=C2=A0 453.556408][=C2=A0 T101] "echo 0 >=20
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [=C2=A0 453.558022][=C2=A0 T101] INFO: task bash:2644 is blocked on a mutex=
 likely=20
> owned by task rpc.nfsd:2761.
> [=C2=A0 453.559949][=C2=A0 T101] INFO: task rpc.nfsd:2761 blocked for more =
than=20
> 147 seconds.
> [=C2=A0 453.560868][=C2=A0 T101]=C2=A0 =C2=A0 =C2=A0 =C2=A0Not tainted=20
> 6.16.0-rc3-00001-g4e8c356736df-dirty #84
> [=C2=A0 453.561770][=C2=A0 T101] "echo 0 >=20
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [=C2=A0 453.563573][=C2=A0 T101] INFO: task nfsdcltrack:2776 blocked for mo=
re than=20
> 147 seconds.
> [=C2=A0 453.564516][=C2=A0 T101]=C2=A0 =C2=A0 =C2=A0 =C2=A0Not tainted=20
> 6.16.0-rc3-00001-g4e8c356736df-dirty #84
> [=C2=A0 453.565431][=C2=A0 T101] "echo 0 >=20
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [=C2=A0 453.566945][=C2=A0 T101] INFO: task nfsdcltrack:2776 is blocked on =
a mutex=20
> likely owned by task rpc.nfsd:2761.
> [=C2=A0 453.568860][=C2=A0 T101]
> [=C2=A0 453.568860][=C2=A0 T101] Showing all locks held in the system:
> [=C2=A0 453.569816][=C2=A0 T101] 1 lock held by khungtaskd/101:
> [=C2=A0 453.570469][=C2=A0 T101]=C2=A0 #0: ffffffffa6f66120=20
> (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire.constprop.0+0x7/0x30
> [=C2=A0 453.571753][=C2=A0 T101] 2 locks held by kworker/u64:4/149:
> [=C2=A0 453.572402][=C2=A0 T101]=C2=A0 #0: ffff8881001a5948=20
> ((wq_completion)events_unbound){+.+.}-{0:0}, at:=20
> process_one_work+0x72b/0x8a0
> [=C2=A0 453.573758][=C2=A0 T101]=C2=A0 #1: ffffc90000bcfd60=20
> ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at:=20
> process_one_work+0x72b/0x8a0
> [=C2=A0 453.575172][=C2=A0 T101] 2 locks held by bash/2644:
> [=C2=A0 453.575742][=C2=A0 T101]=C2=A0 #0: ffff88810e204400=20
> (sb_writers#12){.+.+}-{0:0}, at: ksys_write+0xc9/0x160
> [=C2=A0 453.576856][=C2=A0 T101]=C2=A0 #1: ffffffffa738e508 (nfsd_mutex){+.=
+.}-{4:4},=20
> at: write_v4_end_grace+0x94/0x160
> [=C2=A0 453.578005][=C2=A0 T101] 2 locks held by rpc.nfsd/2761:
> [=C2=A0 453.578644][=C2=A0 T101]=C2=A0 #0: ffff88810e204400=20
> (sb_writers#12){.+.+}-{0:0}, at: ksys_write+0xc9/0x160
> [=C2=A0 453.579750][=C2=A0 T101]=C2=A0 #1: ffffffffa738e508 (nfsd_mutex){+.=
+.}-{4:4},=20
> at: write_threads+0x14e/0x210
> [=C2=A0 453.580871][=C2=A0 T101] 2 locks held by nfsdcltrack/2776:
> [=C2=A0 453.581511][=C2=A0 T101]=C2=A0 #0: ffff88810e204400=20
> (sb_writers#12){.+.+}-{0:0}, at: ksys_write+0xc9/0x160
> [=C2=A0 453.582644][=C2=A0 T101]=C2=A0 #1: ffffffffa738e508 (nfsd_mutex){+.=
+.}-{4:4},=20
> at: write_v4_end_grace+0x94/0x160
> [=C2=A0 453.583793][=C2=A0 T101]
> [=C2=A0 453.584085][=C2=A0 T101] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> [=C2=A0 453.584085][=C2=A0 T101]
>=20
> CLIENT B:
> write /proc/fs/nfsd/v4_end_grace between "nfs4_cld_state_shutdown sleep=20
> after free..." and "nfs4_cld_state_shutdown sleep done"
> [root@nfs_test3 ~]# echo 1 > /proc/fs/nfsd/v4_end_grace
>=20
> Processes:
> [root@nfs_test3 ~]# ps aux | grep D
> USER=C2=A0 =C2=A0 =C2=A0 =C2=A0PID %CPU %MEM=C2=A0 =C2=A0 VSZ=C2=A0 =C2=A0R=
SS TTY=C2=A0 =C2=A0 =C2=A0 STAT START=C2=A0 =C2=A0TIME COMMAND
> root=C2=A0 =C2=A0 =C2=A0 =C2=A0378=C2=A0 0.1=C2=A0 0.0=C2=A0 97948=C2=A0 70=
08 ?=C2=A0 =C2=A0 =C2=A0 =C2=A0 Ss=C2=A0 =C2=A010:04=C2=A0 =C2=A00:00=20
> /usr/sbin/sshd -D
> root=C2=A0 =C2=A0 =C2=A0 2644=C2=A0 1.3=C2=A0 0.0 127676=C2=A0 8656 pts/0=
=C2=A0 =C2=A0 Ds+=C2=A0 10:06=C2=A0 =C2=A00:00 -bash
> root=C2=A0 =C2=A0 =C2=A0 2745=C2=A0 0.5=C2=A0 0.0 270324=C2=A0 3356 ?=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 Ssl=C2=A0 10:06=C2=A0 =C2=A00:00=20
> /usr/sbin/gssproxy -D
> root=C2=A0 =C2=A0 =C2=A0 2761=C2=A0 0.9=C2=A0 0.0=C2=A0 33740=C2=A0 2808 ?=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Ds=C2=A0 =C2=A010:06=C2=A0 =C2=A00:00=20
> /usr/sbin/rpc.nfsd -V 2 8
> root=C2=A0 =C2=A0 =C2=A0 2776=C2=A0 0.0=C2=A0 0.0=C2=A0 19272=C2=A0 3076 ?=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 D=C2=A0 =C2=A0 10:06=C2=A0 =C2=A00:00=20
> /sbin/nfsdcltrack init
> root=C2=A0 =C2=A0 =C2=A0 2885=C2=A0 0.0=C2=A0 0.0 119476=C2=A0 2320 pts/1=
=C2=A0 =C2=A0 S+=C2=A0 =C2=A010:07=C2=A0 =C2=A00:00 grep=20
> --color=3Dauto D
> [root@nfs_test3 ~]# cat /proc/2644/stack
> [<0>] write_v4_end_grace+0x94/0x160
> [<0>] nfsctl_transaction_write+0x8b/0xf0
> [<0>] vfs_write+0x160/0x7f0
> [<0>] ksys_write+0xc9/0x160
> [<0>] do_syscall_64+0x72/0x390
> [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [root@nfs_test3 ~]# cat /proc/2761/stack
> [<0>] call_usermodehelper_exec+0x283/0x2d0
> [<0>] nfsd4_umh_cltrack_upcall+0xfc/0x1a0
> [<0>] nfsd4_umh_cltrack_init+0x60/0x80
> [<0>] nfsd4_client_tracking_init+0x1a7/0x260
> [<0>] nfs4_state_start_net+0x63/0x90
> [<0>] nfsd_startup_net+0x261/0x320
> [<0>] nfsd_svc+0x103/0x1a0
> [<0>] write_threads+0x170/0x210
> [<0>] nfsctl_transaction_write+0x8b/0xf0
> [<0>] vfs_write+0x160/0x7f0
> [<0>] ksys_write+0xc9/0x160
> [<0>] do_syscall_64+0x72/0x390
> [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [root@nfs_test3 ~]# cat /proc/2776/stack
> [<0>] write_v4_end_grace+0x94/0x160
> [<0>] nfsctl_transaction_write+0x8b/0xf0
> [<0>] vfs_write+0x160/0x7f0
> [<0>] ksys_write+0xc9/0x160
> [<0>] do_syscall_64+0x72/0x390
> [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [root@nfs_test3 ~]#
>=20
>=20
> =E5=9C=A8 2025/6/23 10:47, NeilBrown =E5=86=99=E9=81=93:
> > write_foo functions are called to handle IO to files in /proc/fs/nfsd/.
> > They can be called at any time and so generally need locking to ensure
> > they don't happen at an awkward time.
> >
> > Many already take nfsd_mutex and check if nfsd_serv has been set.  This
> > ensures they only run when the server is fully configured.
> >
> > write_filehandle() does *not* need locking.  It interacts with the
> > export table which is set up when the netns is set up, so it is always
> > valid and it has its own locking.  write_filehandle() is needed before
> > the nfs server is started so checking nfsd_serv would be wrong.
> >
> > The remaining files which do not have any locking are
> > write_v4_end_grace(), write_unlock_ip(), and write_unlock_fs().
> > None of these make sense when the nfs server is not running and there is
> > evidence that write_v4_end_grace() can race with ->client_tracking_op
> > setup/shutdown and cause problems.
> >
> > This patch adds locking to these three and ensures the "unlock"
> > functions abort if ->nfsd_serv is not set.
> >
> > Reported-and-tested-by: Li Lingfeng <lilingfeng3@huawei.com>
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >   fs/nfsd/nfsctl.c | 40 +++++++++++++++++++++++++++++++++++++---
> >   1 file changed, 37 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 3f3e9f6c4250..6b0cad81b5fa 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -214,13 +214,18 @@ static inline struct net *netns(struct file *file)
> >    *			returns one if one or more locks were not released
> >    *	On error:	return code is negative errno value
> >    */
> > -static ssize_t write_unlock_ip(struct file *file, char *buf, size_t size)
> > +static ssize_t __write_unlock_ip(struct file *file, char *buf, size_t si=
ze)
> >   {
> >   	struct sockaddr_storage address;
> >   	struct sockaddr *sap =3D (struct sockaddr *)&address;
> >   	size_t salen =3D sizeof(address);
> >   	char *fo_path;
> >   	struct net *net =3D netns(file);
> > +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > +
> > +	if (!nn->nfsd_serv)
> > +		/* There cannot be any files to unlock */
> > +		return -EINVAL;
> >  =20
> >   	/* sanity check */
> >   	if (size =3D=3D 0)
> > @@ -240,6 +245,16 @@ static ssize_t write_unlock_ip(struct file *file, ch=
ar *buf, size_t size)
> >   	return nlmsvc_unlock_all_by_ip(sap);
> >   }
> >  =20
> > +static ssize_t write_unlock_ip(struct file *file, char *buf, size_t size)
> > +{
> > +	ssize_t ret;
> > +
> > +	mutex_lock(&nfsd_mutex);
> > +	ret =3D __write_unlock_ip(file, buf, size);
> > +	mutex_unlock(&nfsd_mutex);
> > +	return ret;
> > +}
> > +
> >   /*
> >    * write_unlock_fs - Release all locks on a local file system
> >    *
> > @@ -254,11 +269,16 @@ static ssize_t write_unlock_ip(struct file *file, c=
har *buf, size_t size)
> >    *			returns one if one or more locks were not released
> >    *	On error:	return code is negative errno value
> >    */
> > -static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
> > +static ssize_t __write_unlock_fs(struct file *file, char *buf, size_t si=
ze)
> >   {
> >   	struct path path;
> >   	char *fo_path;
> >   	int error;
> > +	struct nfsd_net *nn =3D net_generic(netns(file), nfsd_net_id);
> > +
> > +	if (!nn->nfsd_serv)
> > +		/* There cannot be any files to unlock */
> > +		return -EINVAL;
> >  =20
> >   	/* sanity check */
> >   	if (size =3D=3D 0)
> > @@ -291,6 +311,16 @@ static ssize_t write_unlock_fs(struct file *file, ch=
ar *buf, size_t size)
> >   	return error;
> >   }
> >  =20
> > +static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
> > +{
> > +	ssize_t ret;
> > +
> > +	mutex_lock(&nfsd_mutex);
> > +	ret =3D __write_unlock_fs(file, buf, size);
> > +	mutex_unlock(&nfsd_mutex);
> > +	return ret;
> > +}
> > +
> >   /*
> >    * write_filehandle - Get a variable-length NFS file handle by path
> >    *
> > @@ -1082,10 +1112,14 @@ static ssize_t write_v4_end_grace(struct file *fi=
le, char *buf, size_t size)
> >   		case 'Y':
> >   		case 'y':
> >   		case '1':
> > -			if (!nn->nfsd_serv)
> > +			mutex_lock(&nfsd_mutex);
> > +			if (!nn->nfsd_serv) {
> > +				mutex_unlock(&nfsd_mutex);
> >   				return -EBUSY;
> > +			}
> >   			trace_nfsd_end_grace(netns(file));
> >   			nfsd4_end_grace(nn);
> > +			mutex_unlock(&nfsd_mutex);
> >   			break;
> >   		default:
> >   			return -EINVAL;
>=20


