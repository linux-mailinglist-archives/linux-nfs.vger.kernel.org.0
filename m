Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE207F951A
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2019 17:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfKLQHC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Nov 2019 11:07:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26879 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725954AbfKLQHB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Nov 2019 11:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573574820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xuAg3OFPzXAlbLI/jeUY6+qGuF0hH25vcKaiI2ZO8C8=;
        b=O5hPDkBtNi5hs4hCd1ZK0XC7ikgDsdILI+AIYy6zk4SXig/1zAxczl2OTriDWIP27k7sTw
        IjIcodW2Qu1s/gTaAs/YuCcLK8VMy695n2/oxkiYd9H7+4C3baxnsxX/CaObDhGJeERQ5m
        valE1bCcBBNPXC+FBb1liFOb9gqC59Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283--t8ePJb3MhWM3p6M0h6lqQ-1; Tue, 12 Nov 2019 11:06:57 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B0A1107ACFA;
        Tue, 12 Nov 2019 16:06:56 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-122-210.rdu2.redhat.com [10.10.122.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B9C663BA9;
        Tue, 12 Nov 2019 16:06:56 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id EBBB1208EC; Tue, 12 Nov 2019 11:06:55 -0500 (EST)
Date:   Tue, 12 Nov 2019 11:06:55 -0500
From:   Scott Mayhew <smayhew@redhat.com>
To:     "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: NULL pointer dereference; nfsd4_remove_cld_pipe
Message-ID: <20191112160655.GE4276@coeurl.usersys.redhat.com>
References: <20191112101343.GA2806@audible.transient.net>
MIME-Version: 1.0
In-Reply-To: <20191112101343.GA2806@audible.transient.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: -t8ePJb3MhWM3p6M0h6lqQ-1
X-Mimecast-Spam-Score: 0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jamie,

On Tue, 12 Nov 2019, Jamie Heilman wrote:

> Giving 5.4.0-rc7 a spin I hit a NULL pointer dereference and bisected
> it to:
>=20
> commit 6ee95d1c899186c0798cafd25998d436bcdb9618
> Author: Scott Mayhew <smayhew@redhat.com>
> Date:   Mon Sep 9 16:10:31 2019 -0400
>=20
>     nfsd: add support for upcall version 2
>=20
>=20
> The splat against 5.3.0-rc2-00034-g6ee95d1c8991:
>=20
> BUG: kernel NULL pointer dereference, address: 0000000000000036
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0=20
> Oops: 0000 [#1] PREEMPT SMP PTI
> CPU: 0 PID: 2936 Comm: rpc.nfsd Not tainted 5.3.0-rc2-00034-g6ee95d1c8991=
 #1
> Hardware name: Dell Inc. Precision WorkStation T3400  /0TP412, BIOS A14 0=
4/30/2012
> RIP: 0010:crypto_destroy_tfm+0x5/0x4d
> Code: 78 01 00 00 48 85 c0 74 05 e9 05 05 66 00 c3 55 48 8b af 80 01 00 0=
0 e8 d5 ff ff ff 48 89 ef 5d e9 12 f9 ef ff 48 85 ff 74 47 <48> 83 7e 30 00=
 41 55 4c 8b 6e 38 41 54 49 89 fc 55 48 89 f5 75 14
> RSP: 0018:ffffc90000b7bd68 EFLAGS: 00010282
> RAX: ffffffffa0402841 RBX: ffff888230484400 RCX: 0000000000002cd0
> RDX: 0000000000002cce RSI: 0000000000000006 RDI: fffffffffffffffe
> RBP: ffffffff81e68440 R08: ffff888232801800 R09: ffffffffa0402841
> R10: 0000000000000200 R11: ffff88823048ae40 R12: ffff888231585100
> R13: ffff88823048ae40 R14: 000000000000000b R15: ffff888230484400
> FS:  00007f02102c3740(0000) GS:ffff888233a00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000036 CR3: 0000000230f94000 CR4: 00000000000406f0
> Call Trace:
>  nfsd4_remove_cld_pipe+0x6d/0x83 [nfsd]
>  nfsd4_cld_tracking_init+0x1cf/0x295 [nfsd]
>  nfsd4_client_tracking_init+0x72/0x13e [nfsd]
>  nfs4_state_start_net+0x22a/0x2cf [nfsd]
>  nfsd_svc+0x1c6/0x292 [nfsd]
>  write_threads+0x68/0xb0 [nfsd]
>  ? write_versions+0x333/0x333 [nfsd]
>  nfsctl_transaction_write+0x4a/0x62 [nfsd]
>  vfs_write+0xa0/0xdd
>  ksys_write+0x71/0xba
>  do_syscall_64+0x48/0x55
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7f021056c904
> Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 4=
8 8d 05 d9 3a 0d 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 54 c3 0f 1f 00 48 83 ec 28 48 89 54 24 18 48
> RSP: 002b:00007ffdc76ec618 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 000055b534955560 RCX: 00007f021056c904
> RDX: 0000000000000002 RSI: 000055b534955560 RDI: 0000000000000003
> RBP: 0000000000000003 R08: 0000000000000000 R09: 00007ffdc76ec4b0
> R10: 00007ffdc76ec367 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000008 R14: 0000000000000000 R15: 000055b534b8a2a0
> Modules linked in: cpufreq_userspace cpufreq_powersave cpufreq_ondemand c=
pufreq_conservative autofs4 fan nfsd auth_rpcgss nfs lockd grace fscache su=
nrpc bridge stp llc nhpoly1305_sse2 nhpoly1305 aes_generic chacha_x86_64 ch=
acha_generic adiantum poly1305_generic vhost_net tun vhost tap dm_crypt snd=
_hda_codec_analog snd_hda_codec_generic usb_storage snd_hda_intel kvm_intel=
 snd_hda_codec kvm snd_hwdep snd_hda_core snd_pcm dcdbas snd_timer irqbypas=
s snd soundcore sr_mod cdrom tg3 sg floppy evdev xfs dm_mod raid1 md_mod ps=
mouse
> CR2: 0000000000000036
> ---[ end trace bc12bbe4cdd6319f ]---
> ...
> NFS: Registering the id_resolver key type
> Key type id_resolver registered
> Key type id_legacy registered
>=20
>=20
> My kernel config is at
> http://audible.transient.net/~jamie/k/upcallv2.config-5.3.0-rc2-00034-g6e=
e95d1c8991
>=20
> I don't think there's anything terribly interesting about my nfs
> server setup, this happens reliably on boot up, idle network, no
> active clients; let me know what else you need, happy to debug.
>=20
> --=20
> Jamie Heilman                     http://audible.transient.net/~jamie/
>=20
Does this patch help?

-Scott

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-nfsd-Fix-cld_net-cn_tfm-initialization.patch"
Content-Transfer-Encoding: quoted-printable

From e46430ef6ee045ec447a0796b419b8cdeee4f25f Mon Sep 17 00:00:00 2001
From: Scott Mayhew <smayhew@redhat.com>
Date: Tue, 12 Nov 2019 10:10:00 -0500
Subject: [PATCH] nfsd: Fix cld_net->cn_tfm initialization

Don't assign an error pointer to cn->cn_tfm, otherwise
an oops will occur in nfsd4_remove_cld_pipe().

Fixes: 6ee95d1c8991 ("nfsd: add support for upcall version 2")
Reported-by: Jamie Heilman <jamie@audible.transient.net>
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfsd/nfs4recover.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index cdc75ad4438b..af07d0f55fe3 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -1578,6 +1578,7 @@ nfsd4_cld_tracking_init(struct net *net)
 =09struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
 =09bool running;
 =09int retries =3D 10;
+=09struct crypto_shash *tfm;
=20
 =09status =3D nfs4_cld_state_init(net);
 =09if (status)
@@ -1586,11 +1587,13 @@ nfsd4_cld_tracking_init(struct net *net)
 =09status =3D __nfsd4_init_cld_pipe(net);
 =09if (status)
 =09=09goto err_shutdown;
+=09tfm =3D crypto_alloc_shash("sha256", 0, 0);
 =09nn->cld_net->cn_tfm =3D crypto_alloc_shash("sha256", 0, 0);
-=09if (IS_ERR(nn->cld_net->cn_tfm)) {
-=09=09status =3D PTR_ERR(nn->cld_net->cn_tfm);
+=09if (IS_ERR(tfm)) {
+=09=09status =3D PTR_ERR(tfm);
 =09=09goto err_remove;
 =09}
+=09nn->cld_net->cn_tfm =3D tfm;
=20
 =09/*
 =09 * rpc pipe upcalls take 30 seconds to time out, so we don't want to
--=20
2.17.2


--nFreZHaLTZJo0R7j--

