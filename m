Return-Path: <linux-nfs+bounces-9346-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BA7A1552B
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2025 18:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67041884E5A
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2025 17:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FE11A23A4;
	Fri, 17 Jan 2025 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ar5EJYsy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D02D1A23A1
	for <linux-nfs@vger.kernel.org>; Fri, 17 Jan 2025 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737133242; cv=none; b=gA98e7Z6onBDmLUkN3mJLf4TNFik6nLkP9byxCY+bcdO7LPBNiOXvu+/BlAtzhazoOEDkuefbMN931CCOUhcRU5/ZlzYx0JmIdrzdNom8P4VyNBj9GbOw+eTfbq9vFy91hUCuTCuAPNwagikwjk7zrU4iqXr7FUXmRqasOBNg0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737133242; c=relaxed/simple;
	bh=sEFoIcrG4/DQ66Ym6asvcQXVAQmzMx2beLbCG/cahB0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RjJ9R2vCUPzusTx/OOwgcckCY+iVE3rqWwNqxV5HT9ytLQbYuPl5AQjQcZNCEircL/fli7XDk/6yhMtn4lWW+PgzBjCcWO78rrtJyE+DfhmspO2AmrFEoV5nCnXD4PrRroDD+LXkiq2AmhepdAGaKb5nrnVArOfEhhJzMrS4lmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ar5EJYsy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22ECEC4CEF5;
	Fri, 17 Jan 2025 17:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737133241;
	bh=sEFoIcrG4/DQ66Ym6asvcQXVAQmzMx2beLbCG/cahB0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Ar5EJYsyfq8qxvEa/s+BvwqiUe3bxZU0+ewrgC1Ifo450wtzi6LF0OOCH9i7Ux7ez
	 gR2JY/yz2MWXgND9GXkyPTr+CdGjoTgUQWKkAHycr084sZYI+sAveS+hRp77sUzJ/B
	 di4w8EkxCaMoH/K40RNgPcM9du2vlDWhmd0BAURqAidyrF6FqB1HL1z87q1j43gVI0
	 4myhL/CPNEuopeLAiOPUBUfmc8bi/31OhyI2YGfg4+6aZ7bq0Af78GLDAwUgZvz2I8
	 Kmbz9gY54npztV0Qighs+kfEgFAlOk3f8ifFn/ZmyGWcNW3rQq9yhk4viJX8dfimSa
	 srzJaFBlx5gLA==
Message-ID: <30b5be80cf169f0321caa3f9698946204a363c63.camel@kernel.org>
Subject: Re: [PATCH 1/1] nfsd: fix management of listener transports
From: Jeff Layton <jlayton@kernel.org>
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, 
	linux-nfs@vger.kernel.org, neilb@suse.de, Dai.Ngo@oracle.com, tom@talpey.com
Date: Fri, 17 Jan 2025 12:00:39 -0500
In-Reply-To: <CAN-5tyGC2KCdoxwDtDhmWaX-50OneCg7xzBUDdocsAC0aC6mnA@mail.gmail.com>
References: <20250117163258.52885-1-okorniev@redhat.com>
	 <09fadc29312736c46951d61f42a33f30485bf562.camel@kernel.org>
	 <CAN-5tyGC2KCdoxwDtDhmWaX-50OneCg7xzBUDdocsAC0aC6mnA@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-17 at 11:56 -0500, Olga Kornievskaia wrote:
> On Fri, Jan 17, 2025 at 11:43=E2=80=AFAM Jeff Layton <jlayton@kernel.org>=
 wrote:
> >=20
> > On Fri, 2025-01-17 at 11:32 -0500, Olga Kornievskaia wrote:
> > > Currently, when no active threads are running, a root user using nfsd=
ctl
> > > command can try to remove a particular listener from the list of prev=
iously
> > > added ones, then start the server by increasing the number of threads=
,
> > > it leads to the following problem:
> > >=20
> > > [  158.835354] refcount_t: addition on 0; use-after-free.
> > > [  158.835603] WARNING: CPU: 2 PID: 9145 at lib/refcount.c:25 refcoun=
t_warn_saturate+0x160/0x1a0
> > > [  158.836017] Modules linked in: rpcrdma rdma_cm iw_cm ib_cm ib_core=
 nfsd auth_rpcgss nfs_acl lockd grace overlay isofs uinput snd_seq_dummy sn=
d_hrtimer nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf=
_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_connt=
rack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables qrtr sunrpc vfat=
 fat uvcvideo videobuf2_vmalloc videobuf2_memops uvc videobuf2_v4l2 videode=
v videobuf2_common snd_hda_codec_generic mc e1000e snd_hda_intel snd_intel_=
dspcfg snd_hda_codec snd_hda_core snd_hwdep snd_seq snd_seq_device snd_pcm =
snd_timer snd soundcore sg loop dm_multipath dm_mod nfnetlink vsock_loopbac=
k vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vmw_vmci vsock=
 xfs libcrc32c crct10dif_ce ghash_ce vmwgfx sha2_ce sha256_arm64 sr_mod sha=
1_ce cdrom nvme drm_client_lib drm_ttm_helper ttm nvme_core drm_kms_helper =
nvme_auth drm fuse
> > > [  158.840093] CPU: 2 UID: 0 PID: 9145 Comm: nfsd Kdump: loaded Taint=
ed: G    B   W          6.13.0-rc6+ #7
> > > [  158.840624] Tainted: [B]=3DBAD_PAGE, [W]=3DWARN
> > > [  158.840802] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW2=
01.00V.24006586.BA64.2406042154 06/04/2024
> > > [  158.841220] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS =
BTYPE=3D--)
> > > [  158.841563] pc : refcount_warn_saturate+0x160/0x1a0
> > > [  158.841780] lr : refcount_warn_saturate+0x160/0x1a0
> > > [  158.842000] sp : ffff800089be7d80
> > > [  158.842147] x29: ffff800089be7d80 x28: ffff00008e68c148 x27: ffff0=
0008e68c148
> > > [  158.842492] x26: ffff0002e3b5c000 x25: ffff600011cd1829 x24: ffff0=
0008653c010
> > > [  158.842832] x23: ffff00008653c000 x22: 1fffe00011cd1829 x21: ffff0=
0008653c028
> > > [  158.843175] x20: 0000000000000002 x19: ffff00008653c010 x18: 00000=
00000000000
> > > [  158.843505] x17: 0000000000000000 x16: 0000000000000000 x15: 00000=
00000000000
> > > [  158.843836] x14: 0000000000000000 x13: 0000000000000001 x12: ffff6=
00050a26493
> > > [  158.844143] x11: 1fffe00050a26492 x10: ffff600050a26492 x9 : dfff8=
00000000000
> > > [  158.844475] x8 : 00009fffaf5d9b6e x7 : ffff000285132493 x6 : 00000=
00000000001
> > > [  158.844823] x5 : ffff000285132490 x4 : ffff600050a26493 x3 : ffff8=
000805e72bc
> > > [  158.845174] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0=
00098588000
> > > [  158.845528] Call trace:
> > > [  158.845658]  refcount_warn_saturate+0x160/0x1a0 (P)
> > > [  158.845894]  svc_recv+0x58c/0x680 [sunrpc]
> > > [  158.846183]  nfsd+0x1fc/0x348 [nfsd]
> > > [  158.846390]  kthread+0x274/0x2f8
> > > [  158.846546]  ret_from_fork+0x10/0x20
> > > [  158.846714] ---[ end trace 0000000000000000 ]---
> > >=20
> > > nfsd_nl_listener_set_doit() would manipulate the list of transports o=
f
> > > server's sv_permsocks and close the specified listener but the other
> > > list of transports (server's sp_xprts list) would not be changed lead=
ing
> > > to the problem above.
> > >=20
> > > Instead, determined if the nfsdctl is trying to remove a listener, in
> > > which case, delete all the existing listener transports and re-create
> > > all-but-the-removed ones.
> > >=20
> > > Fixes: 16a471177496 ("NFSD: add listener-{set,get} netlink command")
> > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > ---
> > >  fs/nfsd/nfsctl.c | 41 ++++++++++++++++++-----------------------
> > >  1 file changed, 18 insertions(+), 23 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > index 95ea4393305b..079c1fe2eee7 100644
> > > --- a/fs/nfsd/nfsctl.c
> > > +++ b/fs/nfsd/nfsctl.c
> > > @@ -1918,6 +1918,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *s=
kb, struct genl_info *info)
> > >       LIST_HEAD(permsocks);
> > >       struct nfsd_net *nn;
> > >       int err, rem;
> > > +     bool delete =3D false;
> > >=20
> > >       mutex_lock(&nfsd_mutex);
> > >=20
> > > @@ -1977,35 +1978,26 @@ int nfsd_nl_listener_set_doit(struct sk_buff =
*skb, struct genl_info *info)
> > >               }
> > >       }
> > >=20
> > > -     /* For now, no removing old sockets while server is running */
> > > -     if (serv->sv_nrthreads && !list_empty(&permsocks)) {
> > > +     /* If we have listener transports left on permsocks list, it me=
ans
> > > +      * we are asked to remove a listener
> > > +      */
> > > +     if (!list_empty(&permsocks)) {
> > >               list_splice_init(&permsocks, &serv->sv_permsocks);
> > > -             spin_unlock_bh(&serv->sv_lock);
> > > -             err =3D -EBUSY;
> > > -             goto out_unlock_mtx;
> > > +             delete =3D true;
> > >       }
> > > +     spin_unlock_bh(&serv->sv_lock);
> > >=20
> > > -     /* Close the remaining sockets on the permsocks list */
> > > -     while (!list_empty(&permsocks)) {
> > > -             xprt =3D list_first_entry(&permsocks, struct svc_xprt, =
xpt_list);
> > > -             list_move(&xprt->xpt_list, &serv->sv_permsocks);
> > > -
> > > -             /*
> > > -              * Newly-created sockets are born with the BUSY bit set=
. Clear
> > > -              * it if there are no threads, since nothing can pick i=
t up
> > > -              * in that case.
> > > +     /* Not removing old listener transports while server is running=
 */
> > > +     if (serv->sv_nrthreads) {
> > > +             err =3D -EBUSY;
> > > +             goto out_unlock_mtx;
> > > +     } else if (delete) {
> > > +             /* since we can't delete a single entry, we will destro=
y
> > > +              * all remaining listeners and recreate the list
> > >                */
> > > -             if (!serv->sv_nrthreads)
> > > -                     clear_bit(XPT_BUSY, &xprt->xpt_flags);
> > > -
> > > -             set_bit(XPT_CLOSE, &xprt->xpt_flags);
> > > -             spin_unlock_bh(&serv->sv_lock);
> > > -             svc_xprt_close(xprt);
> > > -             spin_lock_bh(&serv->sv_lock);
> > > +             svc_xprt_destroy_all(serv, net);
> > >       }
> > >=20
> > > -     spin_unlock_bh(&serv->sv_lock);
> > > -
> > >       /* walk list of addrs again, open any that still don't exist */
> > >       nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
> > >               struct nlattr *tb[NFSD_A_SOCK_MAX + 1];
> > > @@ -2031,6 +2023,9 @@ int nfsd_nl_listener_set_doit(struct sk_buff *s=
kb, struct genl_info *info)
> > >=20
> > >               xprt =3D svc_find_listener(serv, xcl_name, net, sa);
> > >               if (xprt) {
> > > +                     if (delete)
> > > +                             WARN_ONCE("Transport type=3D%s already =
exists\n",
> > > +                                       xcl_name);
> > >                       svc_xprt_put(xprt);
> > >                       continue;
> > >               }
> >=20
> > This does seem a bit safer than trying to dequeue a since entry from
> > the lwq.
>=20
> To be honest I don't understand the value in being able to remove a
> listener. There has to be no active threads. Then somebody has to do
> nfsdctl listener +<protocol>... but then decide oh wait I dont need it
> and do listener -<protocol>... then increase the thread count. They
> can (-) listener by running "nfsdctl threads 0" again and that clears
> all the listeners anyway.
>=20
> Is the ultimate goal to remove a listener on an active server? If
> there isn't such a goal, it seems better to remove the ability
> altogether.
>=20
>=20

Mostly I added that because you could end up making a mistake when
adding a listener, so I thought that being able to remove one would be
helpful.

If the consensus is that it's not helpful, then I'm fine with dropping
that functionality. If you do that though, then I think you need some
mechanism that is more intuitive to clear the list of listeners than
"threads 0".

--=20
Jeff Layton <jlayton@kernel.org>

