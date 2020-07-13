Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077A021D5F9
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2020 14:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgGMMaC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Jul 2020 08:30:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22687 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726586AbgGMMaC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Jul 2020 08:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594643399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ssINCTP2Aii2BDE+0w2ljhH4IjAsm2C1m8ffIeWuoHo=;
        b=E8vjbbJPHBcXiHTOGZbAi8CXFRErsN38A3wmXg8iOUjkhdTNY4HAkX0aGVNbD7CEwRC8NX
        9rpvzna2x9IUaOhc5kp3Fl5oO9XH6U56i/bTvvzdYUHphoRiUDfDGaGBaBJhRTjuTNwEh1
        K/kaAsooeJ1o9NXoD8PKgCYMigTYqoo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-yKHNRccHMomUvsnFwOMA3g-1; Mon, 13 Jul 2020 08:29:57 -0400
X-MC-Unique: yKHNRccHMomUvsnFwOMA3g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DED71080;
        Mon, 13 Jul 2020 12:29:56 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-115-80.rdu2.redhat.com [10.10.115.80])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 37F0A5FC2C;
        Mon, 13 Jul 2020 12:29:56 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 36BB41A0006; Mon, 13 Jul 2020 08:29:55 -0400 (EDT)
Date:   Mon, 13 Jul 2020 08:29:55 -0400
From:   Scott Mayhew <smayhew@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: avoid a NULL dereference in __cld_pipe_upcall()
Message-ID: <20200713122955.GY4452@aion.usersys.redhat.com>
References: <20200710203307.2545412-1-smayhew@redhat.com>
 <B6722AC5-A7DD-4EAF-B08A-45C12160D5DF@oracle.com>
MIME-Version: 1.0
In-Reply-To: <B6722AC5-A7DD-4EAF-B08A-45C12160D5DF@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aion.usersys.redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 12 Jul 2020, Chuck Lever wrote:

> Hi Scott-
>=20
> > On Jul 10, 2020, at 4:33 PM, Scott Mayhew <smayhew@redhat.com> wrote:
> >=20
> > If the rpc_pipefs is unmounted, then the rpc_pipe->dentry becomes NULL
> > and dereferencing the dentry->d_sb will trigger an oops.  The only
> > reason we're doing that is to determine the nfsd_net, which could
> > instead be passed in by the caller.  So do that instead.
> >=20
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
>=20
> Looks straightforward. Applied to the nfsd-5.9 testing tree.
>=20
> I'm wondering about automatic backports to stable. This fix does not
> apply to kernels before v5.6, but IIUC addresses a crash introduced
> in f3f8014862d8 ("nfsd: add the infrastructure to handle the cld upcall")
> [2012] ?
>=20
> Is "Cc: <stable@kernel.org> # v5.6+" appropriate?
>
I think it would be 11a60d159259 ("nfsd: add a "GetVersion" upcall for
nfsdcld"), so it would only need to go back to v5.4... and to get the
patch to apply, in the hunk that modifies nfsd4_cld_grace_done_v0()
you would need to add a cast of nn->boot_time to int64_t (which
9cc7680149b2 "nfsd: make 'boot_time' 64-bit wide" removed).
=20
> Also, is there a bug report that documents the crash?

Our QE hit the crash internally while running xfstests on a pNFS SCSI
setup.  I don't think either of those is relevant aside from the fact
that several nfsd threads where stuck on xfs while calling
nfsd4_scsi_proc_layoutcommit().  I think what happened is that the job
timed out and the system was in the process of being shut down when the
oops occurred, and the rpc_pipefs was unmounted out from under nfsd:

crash> bt
PID: 39572  TASK: ffff8a78f67fddc0  CPU: 1   COMMAND: "kworker/u4:0"
 #0 [ffffa39a026b3ae0] machine_kexec at ffffffffae65b55e
 #1 [ffffa39a026b3b38] __crash_kexec at ffffffffae75ea5d
 #2 [ffffa39a026b3c00] crash_kexec at ffffffffae75f93d
 #3 [ffffa39a026b3c18] oops_end at ffffffffae622c4d
 #4 [ffffa39a026b3c38] no_context at ffffffffae66aa2e
 #5 [ffffa39a026b3c90] do_page_fault at ffffffffae66b552
 #6 [ffffa39a026b3cc0] async_page_fault at ffffffffaf00123e
    [exception RIP: __cld_pipe_upcall+0x3d]
    RIP: ffffffffc06b5ded  RSP: ffffa39a026b3d70  RFLAGS: 00010246
    RAX: 0000000000000000  RBX: ffff8a78ceaf7000  RCX: 000000000000000b
    RDX: ffff8a78ceaf7000  RSI: ffffa39a026b3d70  RDI: ffffa39a026b3d70
    RBP: ffffa39a026b3dc0   R8: ffff8a78f37aac50   R9: ffff8a78c7c02800
    R10: 8080808080808080  R11: 0000ec193f7575c0  R12: ffff8a78c8ef3038
    R13: ffff8a78d3156220  R14: ffffa39a026b3e50  R15: ffff8a78d3156220
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #7 [ffffa39a026b3dc8] nfsd4_cld_remove at ffffffffc06b7b70 [nfsd]
 #8 [ffffa39a026b3df8] expire_client at ffffffffc06aa4d6 [nfsd]
 #9 [ffffa39a026b3e08] laundromat_main at ffffffffc06aa799 [nfsd]
#10 [ffffa39a026b3e98] process_one_work at ffffffffae6d1cf7
#11 [ffffa39a026b3ed8] worker_thread at ffffffffae6d23c0
#12 [ffffa39a026b3f10] kthread at ffffffffae6d7d02
#13 [ffffa39a026b3f50] ret_from_fork at ffffffffaf000255

crash> dis -lr __cld_pipe_upcall+0x3d
...
/usr/src/debug/kernel-4.18.0-211.el8/linux-4.18.0-211.el8.x86_64/fs/nfsd/nf=
s4recover.c: 764
0xffffffffc06b5de0 <__cld_pipe_upcall+0x30>:    mov    0x108(%rdi),%rax
0xffffffffc06b5de7 <__cld_pipe_upcall+0x37>:    mov    %rsp,%rsi
0xffffffffc06b5dea <__cld_pipe_upcall+0x3a>:    mov    %rsi,%rdi
0xffffffffc06b5ded <__cld_pipe_upcall+0x3d>:    mov    0x68(%rax),%rax

That puts us here:

static int
__cld_pipe_upcall(struct rpc_pipe *pipe, void *cmsg)
{
        int ret;
        struct rpc_pipe_msg msg;
        struct cld_upcall *cup =3D container_of(cmsg, struct cld_upcall, cu=
_u);
        struct nfsd_net *nn =3D net_generic(pipe->dentry->d_sb->s_fs_info,
                                          nfsd_net_id);
...
crash> rpc_pipe.dentry -o
struct rpc_pipe {
  [0x108] struct dentry *dentry;
}
crash> dentry.d_sb -o
struct dentry {
  [0x68] struct super_block *d_sb;
}

If the rpc_pipe->dentry was NULL, that would explain the NULL pointer deref=
erence at 0000000000000068.  Let's confirm.

crash> dis -lr ffffffffc06b7b70
...
/usr/src/debug/kernel-4.18.0-211.el8/linux-4.18.0-211.el8.x86_64/fs/nfsd/nf=
s4recover.c: 794
0xffffffffc06b7b65 <nfsd4_cld_remove+0x85>:     mov    %rbp,%rsi
0xffffffffc06b7b68 <nfsd4_cld_remove+0x88>:     mov    %rbx,%rdi <---------=
---------------------rpc_pipe
0xffffffffc06b7b6b <nfsd4_cld_remove+0x8b>:     callq  0xffffffffc06b5db0 <=
__cld_pipe_upcall>
/usr/src/debug/kernel-4.18.0-211.el8/linux-4.18.0-211.el8.x86_64/fs/nfsd/nf=
s4recover.c: 795
0xffffffffc06b7b70 <nfsd4_cld_remove+0x90>:     cmp    $0xfffffff5,%eax

crash> rpc_pipe.dentry ffff8a78ceaf7000
  dentry =3D 0x0

We can also see that the rpc_pipefs isn't mounted:

crash> mount|grep pipefs
(nothing)

And none of the daemons that require the rpc_pipefs are running:

crash> ps|grep nfsdcld
crash> ps|grep idmapd
crash> ps|grep gssd
crash> ps|grep blkmapd
(nothing)

I think part of the problem is that the nfsdcld.service unit file has
"Requires=3Drpc_pipefs.target", but the nfs-server.service unit file only
has "Wants=3Dnfsdcld.service".  It can't be "Requires" because using the
nfsdcld daemon for client tracking is optional.
=20
-Scott

>=20
>=20
> > ---
> > fs/nfsd/nfs4recover.c | 24 +++++++++++-------------
> > 1 file changed, 11 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> > index 9e40dfecf1b1..186fa2c2c6ba 100644
> > --- a/fs/nfsd/nfs4recover.c
> > +++ b/fs/nfsd/nfs4recover.c
> > @@ -747,13 +747,11 @@ struct cld_upcall {
> > };
> >=20
> > static int
> > -__cld_pipe_upcall(struct rpc_pipe *pipe, void *cmsg)
> > +__cld_pipe_upcall(struct rpc_pipe *pipe, void *cmsg, struct nfsd_net *=
nn)
> > {
> > =09int ret;
> > =09struct rpc_pipe_msg msg;
> > =09struct cld_upcall *cup =3D container_of(cmsg, struct cld_upcall, cu_=
u);
> > -=09struct nfsd_net *nn =3D net_generic(pipe->dentry->d_sb->s_fs_info,
> > -=09=09=09=09=09  nfsd_net_id);
> >=20
> > =09memset(&msg, 0, sizeof(msg));
> > =09msg.data =3D cmsg;
> > @@ -773,7 +771,7 @@ __cld_pipe_upcall(struct rpc_pipe *pipe, void *cmsg=
)
> > }
> >=20
> > static int
> > -cld_pipe_upcall(struct rpc_pipe *pipe, void *cmsg)
> > +cld_pipe_upcall(struct rpc_pipe *pipe, void *cmsg, struct nfsd_net *nn=
)
> > {
> > =09int ret;
> >=20
> > @@ -782,7 +780,7 @@ cld_pipe_upcall(struct rpc_pipe *pipe, void *cmsg)
> > =09 *  upcalls queued.
> > =09 */
> > =09do {
> > -=09=09ret =3D __cld_pipe_upcall(pipe, cmsg);
> > +=09=09ret =3D __cld_pipe_upcall(pipe, cmsg, nn);
> > =09} while (ret =3D=3D -EAGAIN);
> >=20
> > =09return ret;
> > @@ -1115,7 +1113,7 @@ nfsd4_cld_create(struct nfs4_client *clp)
> > =09memcpy(cup->cu_u.cu_msg.cm_u.cm_name.cn_id, clp->cl_name.data,
> > =09=09=09clp->cl_name.len);
> >=20
> > -=09ret =3D cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg);
> > +=09ret =3D cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg, nn);
> > =09if (!ret) {
> > =09=09ret =3D cup->cu_u.cu_msg.cm_status;
> > =09=09set_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags);
> > @@ -1180,7 +1178,7 @@ nfsd4_cld_create_v2(struct nfs4_client *clp)
> > =09} else
> > =09=09cmsg->cm_u.cm_clntinfo.cc_princhash.cp_len =3D 0;
> >=20
> > -=09ret =3D cld_pipe_upcall(cn->cn_pipe, cmsg);
> > +=09ret =3D cld_pipe_upcall(cn->cn_pipe, cmsg, nn);
> > =09if (!ret) {
> > =09=09ret =3D cmsg->cm_status;
> > =09=09set_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags);
> > @@ -1218,7 +1216,7 @@ nfsd4_cld_remove(struct nfs4_client *clp)
> > =09memcpy(cup->cu_u.cu_msg.cm_u.cm_name.cn_id, clp->cl_name.data,
> > =09=09=09clp->cl_name.len);
> >=20
> > -=09ret =3D cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg);
> > +=09ret =3D cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg, nn);
> > =09if (!ret) {
> > =09=09ret =3D cup->cu_u.cu_msg.cm_status;
> > =09=09clear_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags);
> > @@ -1261,7 +1259,7 @@ nfsd4_cld_check_v0(struct nfs4_client *clp)
> > =09memcpy(cup->cu_u.cu_msg.cm_u.cm_name.cn_id, clp->cl_name.data,
> > =09=09=09clp->cl_name.len);
> >=20
> > -=09ret =3D cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg);
> > +=09ret =3D cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg, nn);
> > =09if (!ret) {
> > =09=09ret =3D cup->cu_u.cu_msg.cm_status;
> > =09=09set_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags);
> > @@ -1404,7 +1402,7 @@ nfsd4_cld_grace_start(struct nfsd_net *nn)
> > =09}
> >=20
> > =09cup->cu_u.cu_msg.cm_cmd =3D Cld_GraceStart;
> > -=09ret =3D cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg);
> > +=09ret =3D cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg, nn);
> > =09if (!ret)
> > =09=09ret =3D cup->cu_u.cu_msg.cm_status;
> >=20
> > @@ -1432,7 +1430,7 @@ nfsd4_cld_grace_done_v0(struct nfsd_net *nn)
> >=20
> > =09cup->cu_u.cu_msg.cm_cmd =3D Cld_GraceDone;
> > =09cup->cu_u.cu_msg.cm_u.cm_gracetime =3D nn->boot_time;
> > -=09ret =3D cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg);
> > +=09ret =3D cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg, nn);
> > =09if (!ret)
> > =09=09ret =3D cup->cu_u.cu_msg.cm_status;
> >=20
> > @@ -1460,7 +1458,7 @@ nfsd4_cld_grace_done(struct nfsd_net *nn)
> > =09}
> >=20
> > =09cup->cu_u.cu_msg.cm_cmd =3D Cld_GraceDone;
> > -=09ret =3D cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg);
> > +=09ret =3D cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg, nn);
> > =09if (!ret)
> > =09=09ret =3D cup->cu_u.cu_msg.cm_status;
> >=20
> > @@ -1524,7 +1522,7 @@ nfsd4_cld_get_version(struct nfsd_net *nn)
> > =09=09goto out_err;
> > =09}
> > =09cup->cu_u.cu_msg.cm_cmd =3D Cld_GetVersion;
> > -=09ret =3D cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg);
> > +=09ret =3D cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg, nn);
> > =09if (!ret) {
> > =09=09ret =3D cup->cu_u.cu_msg.cm_status;
> > =09=09if (ret)
> > --=20
> > 2.25.4
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

