Return-Path: <linux-nfs+bounces-10578-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E51AA5E7CD
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 00:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51BAB189A0CE
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 23:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504621D5CC6;
	Wed, 12 Mar 2025 23:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="obB9JKJt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B141A1B0406
	for <linux-nfs@vger.kernel.org>; Wed, 12 Mar 2025 23:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741820412; cv=none; b=n/k3p9GZoA80Z+602FF3Zw0jChmd8xnaDsX2AqIP1Y6vUegXUkSEZJRWjo2ncAcEjy+eQoSSoyRvUocpCRRUDYNRiwcdODu7iD4Ppy+uOYd8SW+4u8a/AoaoewCRq5xbXZA45s1I9hE9mHRyWQiC9PgUbGXEnI/la9wbz7u4J6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741820412; c=relaxed/simple;
	bh=XYYIhJiY8QNEjwIlfWs8lJRAI0ERJAAPLnl5RKxPREU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7Xf29l1DOD2UaarJ9A5Wnx/xGYPYciveZRrOVyImPoIJ/VvmAa5+K86pi8rTCH+yk7amqiSGgju8drrrbZP86G8F9frdVLYDTuV02vUMp2njuIVrdh3Ged/7oZcLXETMDVIdTnfxY0VF3xfyvpx1ocjCGlughcJjcMyG81kWEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=obB9JKJt; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30bfca745c7so3556601fa.0
        for <linux-nfs@vger.kernel.org>; Wed, 12 Mar 2025 16:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1741820407; x=1742425207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wm1hwTxj7B4xvN7ARYSBafa4j+4+AEaU6JdehWW9A20=;
        b=obB9JKJtYA564MCRJS9fS/9Ub/Tsnaf2odwRTRBgVSFpMG+Ghq/RXjh+IyVCfHgTLu
         +DMcWs2rPEjmKSsW4Wm6u6cFXemQqEBCEzSPPSt1esoBuGHAS//GPJBg9PEXVw8tYc78
         /33W7zWO4PpOUVyUHD9Kem4sh0EKeUG8X28aP6fyqxdPL6eirnOjF2G4c3oPkuvfT4OY
         HeixYOU33/K7l6wpyIi/ke9bEnt7XrS+/uJnKT3G7CukEekjrgsqOHPGmj3pG/LFIemn
         J4H6N++qO0edq3RASMJ/xZ1XGfXO4TE8bfPSQ/2l7Vclb0MB34idAg/nTYziPJZ4UtZ4
         bkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741820407; x=1742425207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wm1hwTxj7B4xvN7ARYSBafa4j+4+AEaU6JdehWW9A20=;
        b=BVZ+Mx6UMhTNhBxVxsZGnp05XH9N2hHTMNez8twITtlIINiqtUZeD8ZmW+p7PIV8Kj
         ynMemXc0mWRegmct+ASb4nTiHoKdUkhQ+zYjdUtzNf328EELog/LaBy6v8kkcB0Ro6Fg
         amtfS4TVjdZ1A1Vqvt4xRVZQjAOpNs7iIyAPYQCZruv4xMMviLGzJSqM8NDs7V2QzEQf
         8WzGMl8wwzFG5Vm22mkZADaKmbuQulGuUjo7RY5gkoF1kOgIaG7+1kW4znrlYQdsdpb7
         t45C69NERnZpfNSJnsbIitQQJ0Gpbg3VMvE//0fXfdHwbH/cPmG1vqeol4BPEWMOnFed
         dVmA==
X-Forwarded-Encrypted: i=1; AJvYcCWNYQAJvJ7BLPNDscgqWKSCEz68b0oEgHBXsS3vu5lTPrLesKukdPRZ/tcdTUG3uwcaaVPN9x0S3nI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr7+g/WPKjcG3vG0Iy3owQWkhTCISYTrfrM2QvIAlOJDnO99uL
	+peODqgp44l5SBgtL176SumlUchOzh7IjoS59wSpGkVjpIZWq6DpDEwjqx15I53Qe88/1KGgOFQ
	8EnGkPJrBAuVWD1Wsu02nG8xIMFfcneRJ
X-Gm-Gg: ASbGncvgWwheELNBvjEKd3l8JbdPA3TMfVBR6+6+eZWRenVZr/5fFxqOLmDVLzqU8Is
	Ugq+jxh2xoIpRrV4DNNQj/rld4/z0Cwgxbb9GejIKzmb8yE7ppGHfk5jma3Ho1jPUf19dA6eW2h
	Uxi1178R1XC/+urwliikfA6Q/kG3ArcmjZ7Qu5Gyenalww3+eOowJXoymugfFt
X-Google-Smtp-Source: AGHT+IHpl/10fnTYR3+HS8pNxr2tGdWEp3mtWSScY0KfE6b52EzbcXMHpJxs6sTUl8rW0hG3r4oZ22kJ7JKNpVlzWEE=
X-Received: by 2002:a2e:4e09:0:b0:30b:f924:3565 with SMTP id
 38308e7fff4ca-30bf9243d5dmr70776541fa.37.1741820407158; Wed, 12 Mar 2025
 16:00:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN-5tyH4E-qaK0TEtUMn3QpB0rYsDjm_erqRwVko7bAgYdmQBg@mail.gmail.com>
 <174172935674.33508.779551385082016505@noble.neil.brown.name>
 <CAN-5tyH0kqsm0pdcdaf=HRfm607OC6vmp4pa0Q07sAOEoHabBA@mail.gmail.com> <CAN-5tyHTpHE6QEtZkU74Y__XwaNLW5U-5hRNQLe4J18TyvcC3A@mail.gmail.com>
In-Reply-To: <CAN-5tyHTpHE6QEtZkU74Y__XwaNLW5U-5hRNQLe4J18TyvcC3A@mail.gmail.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 12 Mar 2025 18:59:55 -0400
X-Gm-Features: AQ5f1JrRw43f0dav0sBLdDnyIfQ0jN9V-SiclTUMN2cnhFRS7qp9hUZd71E5mr0
Message-ID: <CAN-5tyFeBnS04MMkr-bM5juWxszdpdRGJ2wnjq4y2_QNngQ-rw@mail.gmail.com>
Subject: Re: [PATCH v2] nfsd: refine and rename NFSD_MAY_LOCK
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 6:51=E2=80=AFPM Olga Kornievskaia <aglo@umich.edu> =
wrote:
>
> On Wed, Mar 12, 2025 at 9:22=E2=80=AFAM Olga Kornievskaia <aglo@umich.edu=
> wrote:
> >
> > On Tue, Mar 11, 2025 at 5:42=E2=80=AFPM NeilBrown <neilb@suse.de> wrote=
:
> > >
> > > On Wed, 12 Mar 2025, Olga Kornievskaia wrote:
> > > > On Tue, Mar 11, 2025 at 11:28=E2=80=AFAM Olga Kornievskaia <aglo@um=
ich.edu> wrote:
> > > > >
> > > > > On Thu, Oct 17, 2024 at 5:42=E2=80=AFPM NeilBrown <neilb@suse.de>=
 wrote:
> > > > > >
> > > > > >
> > > > > > NFSD_MAY_LOCK means a few different things.
> > > > > > - it means that GSS is not required.
> > > > > > - it means that with NFSEXP_NOAUTHNLM, authentication is not re=
quired
> > > > > > - it means that OWNER_OVERRIDE is allowed.
> > > > > >
> > > > > > None of these are specific to locking, they are specific to the=
 NLM
> > > > > > protocol.
> > > > > > So:
> > > > > >  - rename to NFSD_MAY_NLM
> > > > > >  - set NFSD_MAY_OWNER_OVERRIDE and NFSD_MAY_BYPASS_GSS in nlm_f=
open()
> > > > > >    so that NFSD_MAY_NLM doesn't need to imply these.
> > > > > >  - move the test on NFSEXP_NOAUTHNLM out of nfsd_permission() a=
nd
> > > > > >    into fh_verify where other special-case tests on the MAY fla=
gs
> > > > > >    happen.  nfsd_permission() can be called from other places t=
han
> > > > > >    fh_verify(), but none of these will have NFSD_MAY_NLM.
> > > > >
> > > > > This patch breaks NLM when used in combination with TLS.
> > > >
> > > > I was too quick to link this to TLS. It's presence of security poli=
cy
> > > > so sec=3Dkrb* causes the same problems.
> > > >
> > > > >  If exports
> > > > > have xprtsec=3Dtls:mtls and mount is done with tls/mtls, the serv=
er
> > > > > won't give any locks and client will get "no locks available" err=
or.
> > > > >
> > > > > >
> > > > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > > > ---
> > > > > >
> > > > > > No change from previous patch - the corruption in the email has=
 been
> > > > > > avoided (I hope).
> > > > > >
> > > > > >
> > > > > >  fs/nfsd/lockd.c | 13 +++++++++++--
> > > > > >  fs/nfsd/nfsfh.c | 12 ++++--------
> > > > > >  fs/nfsd/trace.h |  2 +-
> > > > > >  fs/nfsd/vfs.c   | 12 +-----------
> > > > > >  fs/nfsd/vfs.h   |  2 +-
> > > > > >  5 files changed, 18 insertions(+), 23 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
> > > > > > index 46a7f9b813e5..edc9f75dc75c 100644
> > > > > > --- a/fs/nfsd/lockd.c
> > > > > > +++ b/fs/nfsd/lockd.c
> > > > > > @@ -38,11 +38,20 @@ nlm_fopen(struct svc_rqst *rqstp, struct nf=
s_fh *f, struct file **filp,
> > > > > >         memcpy(&fh.fh_handle.fh_raw, f->data, f->size);
> > > > > >         fh.fh_export =3D NULL;
> > > > > >
> > > > > > +       /*
> > > > > > +        * Allow BYPASS_GSS as some client implementations use =
AUTH_SYS
> > > > > > +        * for NLM even when GSS is used for NFS.
> > > > > > +        * Allow OWNER_OVERRIDE as permission might have been c=
hanged
> > > > > > +        * after the file was opened.
> > > > > > +        * Pass MAY_NLM so that authentication can be completel=
y bypassed
> > > > > > +        * if NFSEXP_NOAUTHNLM is set.  Some older clients use =
AUTH_NULL
> > > > > > +        * for NLM requests.
> > > > > > +        */
> > > > > >         access =3D (mode =3D=3D O_WRONLY) ? NFSD_MAY_WRITE : NF=
SD_MAY_READ;
> > > > > > -       access |=3D NFSD_MAY_LOCK;
> > > > > > +       access |=3D NFSD_MAY_NLM | NFSD_MAY_OWNER_OVERRIDE | NF=
SD_MAY_BYPASS_GSS;
> > > > > >         nfserr =3D nfsd_open(rqstp, &fh, S_IFREG, access, filp)=
;
> > > > > >         fh_put(&fh);
> > > > > > -       /* We return nlm error codes as nlm doesn't know
> > > > > > +       /* We return nlm error codes as nlm doesn't know
> > > > > >          * about nfsd, but nfsd does know about nlm..
> > > > > >          */
> > > > > >         switch (nfserr) {
> > > > > > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > > > > > index 40533f7c7297..6a831cb242df 100644
> > > > > > --- a/fs/nfsd/nfsfh.c
> > > > > > +++ b/fs/nfsd/nfsfh.c
> > > > > > @@ -363,13 +363,10 @@ __fh_verify(struct svc_rqst *rqstp,
> > > > > >         if (error)
> > > > > >                 goto out;
> > > > > >
> > > > > > -       /*
> > > > > > -        * pseudoflavor restrictions are not enforced on NLM,
> > > > > > -        * which clients virtually always use auth_sys for,
> > > > > > -        * even while using RPCSEC_GSS for NFS.
> > > > > > -        */
> > > > > > -       if (access & NFSD_MAY_LOCK)
> > > > > > -               goto skip_pseudoflavor_check;
> > > > > > +       if ((access & NFSD_MAY_NLM) && (exp->ex_flags & NFSEXP_=
NOAUTHNLM))
> > > >
> > > > I think this should either be an OR or the fact that "nlm but only
> > > > with insecurelock export option and not other" is the only way to
> > > > bypass checking is wrong. I think it's just a check for NLM that
> > > > stays.
> > >
> > > I don't think that NLM gets a complete bypass unless no_auth_nlm is s=
et.
> > > For the case you are describing, I think NFSD_MAY_BYPASS_GSS is suppo=
sed
> > > to make it work.
> > >
> > > I assume the NLM request is arriving with AUTH_SYS authentication?
> >
> > It does.
> >
> > Just to give you a practical example. exports have
> > (rw,...,sec=3Dkrb5:krb5i:krb5p). Client does mount with sec=3Dkrb5. The=
n
> > does an flock() on the file. What's more I have just now hit Kasan's
> > out-of-bounds warning on that. I'll have to see if that exists on 6.14
> > (as I'm debugging the matter on the commit of the patch itself and
> > thus on 6.12-rc now).
> >
> > I will layout more reasoning but what allowed NLM to work was this
> > -       /*
> > -        * pseudoflavor restrictions are not enforced on NLM,
> > -        * which clients virtually always use auth_sys for,
> > -        * even while using RPCSEC_GSS for NFS.
> > -        */
> > -       if (access & NFSD_MAY_LOCK)
> > -               goto skip_pseudoflavor_check;
> >
> > but I don't know why the replacement doesn't work.
>
> As I mentioned the patch removed the skip_pseudoflavor check (that for
> NLM) would have bypassed calling check_nfsd_access(). Instead, the
> problem is that even though may_bypass_gss is set to true it call into
> nfsd4_spo_must_allow(rqstp) which now wrongly assumes there is
> compound state (struct nfsd4_compound_state *cstate =3D &resp->cstate;)
> ... (but this is NLM). So it proceed to deference it if
> (!cstate->minorversion) causing the KASAN to do the out-of-bound error
> that I mentioned. It most of the time now cause a crash. But on the
> off non-deterministic times when it completes it fails.

/export *(rw,no_root_squash,sec=3Dkrb5:krb5i:krb5p)
sudo mount -o vers=3D3,sec=3Dkrb5 192.168.1.184:/export /mnt
then do flock -x /mnt/foobar .... results in...


[   60.809906] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   60.810393] BUG: KASAN: slab-out-of-bounds in
nfsd4_spo_must_allow+0x2f0/0x370 [nfsd]
[   60.810990] Read of size 4 at addr ffff0000aa307f88 by task lockd/5339
[   60.811461]
[   60.811576] CPU: 2 UID: 0 PID: 5339 Comm: lockd Kdump: loaded Not
tainted 6.14.0-rc1+ #38
[   60.811580] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS
VMW201.00V.24006586.BA64.2406042154 06/04/2024
[   60.811582] Call trace:
[   60.811584]  show_stack+0x34/0x98 (C)
[   60.811592]  dump_stack_lvl+0x80/0xa8
[   60.811594]  print_address_description.constprop.0+0x90/0x330
[   60.811597]  print_report+0x108/0x1f8
[   60.811599]  kasan_report+0xc8/0x120
[   60.811603]  __asan_report_load4_noabort+0x20/0x30
[   60.811606]  nfsd4_spo_must_allow+0x2f0/0x370 [nfsd]
[   60.811630]  check_nfsd_access+0x22c/0x3a8 [nfsd]
[   60.811655]  __fh_verify+0x81c/0x980 [nfsd]
[   60.811679]  fh_verify+0xb0/0x198 [nfsd]
[   60.811702]  nfsd_open+0x7c/0xd8 [nfsd]
[   60.811726]  nlm_fopen+0x14c/0x240 [nfsd]
[   60.811749]  nlm_do_fopen+0xb0/0x160 [lockd]
[   60.811759]  nlm_lookup_file+0x388/0x5e0 [lockd]
[   60.811766]  nlm4svc_retrieve_args+0x1fc/0x530 [lockd]
[   60.811773]  __nlm4svc_proc_lock+0x18c/0x328 [lockd]
[   60.811780]  nlm4svc_proc_lock+0x48/0x60 [lockd]
[   60.811787]  nlmsvc_dispatch+0xb4/0x200 [lockd]
[   60.811794]  svc_process_common+0xa24/0x18d8 [sunrpc]
[   60.811831]  svc_process+0x3d8/0x7f8 [sunrpc]
[   60.811859]  svc_handle_xprt+0x5d4/0xd70 [sunrpc]
[   60.811888]  svc_recv+0x2b8/0x690 [sunrpc]
[   60.811916]  lockd+0x154/0x298 [lockd]
[   60.811923]  kthread+0x2e8/0x388
[   60.811929]  ret_from_fork+0x10/0x20
[   60.811931]
[   60.819753] Allocated by task 5325:
[   60.819963]  kasan_save_stack+0x3c/0x70
[   60.820194]  kasan_save_track+0x20/0x40
[   60.820423]  kasan_save_alloc_info+0x40/0x58
[   60.820672]  __kasan_kmalloc+0xd4/0xd8
[   60.820891]  __kmalloc_node_noprof+0x17c/0x560
[   60.821153]  svc_prepare_thread+0x1cc/0x5c0 [sunrpc]
[   60.821477]  svc_start_kthreads+0x4f0/0x5c8 [sunrpc]
[   60.821794]  svc_set_num_threads+0xa8/0x100 [sunrpc]
[   60.822113]  lockd_up+0x1b8/0x5c8 [lockd]
[   60.822361]  nfsd_startup_net+0x364/0x508 [nfsd]
[   60.822662]  nfsd_svc+0x178/0x310 [nfsd]
[   60.822919]  nfsd_nl_threads_set_doit+0x3ac/0x900 [nfsd]
[   60.823256]  genl_family_rcv_msg_doit+0x1c8/0x2a0
[   60.823535]  genl_family_rcv_msg+0x360/0x4b8
[   60.823790]  genl_rcv_msg+0xb8/0x168
[   60.824000]  netlink_rcv_skb+0x1bc/0x370
[   60.824233]  genl_rcv+0x40/0x60
[   60.824423]  netlink_unicast+0x5a8/0x820
[   60.824656]  netlink_sendmsg+0x644/0xa60
[   60.824892]  __sock_sendmsg+0xd0/0x180
[   60.825120]  ____sys_sendmsg+0x4b4/0x650
[   60.825348]  ___sys_sendmsg+0x128/0x1b0
[   60.825562]  __sys_sendmsg+0x110/0x198
[   60.825773]  __arm64_sys_sendmsg+0x78/0xb0
[   60.826003]  invoke_syscall.constprop.0+0xdc/0x1e8
[   60.826276]  do_el0_svc+0x154/0x1d0
[   60.826481]  el0_svc+0x40/0xe8
[   60.826651]  el0t_64_sync_handler+0x10c/0x138
[   60.826884]  el0t_64_sync+0x1ac/0x1b0
[   60.827082]
[   60.827164] The buggy address belongs to the object at ffff0000aa307c00
[   60.827164]  which belongs to the cache kmalloc-512 of size 512
[   60.827840] The buggy address is located 464 bytes to the right of
[   60.827840]  allocated 440-byte region [ffff0000aa307c00, ffff0000aa307d=
b8)
[   60.828549]
[   60.828641] The buggy address belongs to the physical page:
[   60.828964] page: refcount:0 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x12a304
[   60.829414] head: order:2 mapcount:0 entire_mapcount:0
nr_pages_mapped:0 pincount:0
[   60.829841] flags: 0x2fffff00000040(head|node=3D0|zone=3D2|lastcpupid=3D=
0xfffff)
[   60.830248] page_type: f5(slab)
[   60.830426] raw: 002fffff00000040 ffff000080002c80 dead000000000100
dead000000000122
[   60.830860] raw: 0000000000000000 0000000000100010 00000000f5000000
0000000000000000
[   60.831287] head: 002fffff00000040 ffff000080002c80
dead000000000100 dead000000000122
[   60.831725] head: 0000000000000000 0000000000100010
00000000f5000000 0000000000000000
[   60.832158] head: 002fffff00000002 fffffdffc2a8c101
ffffffffffffffff 0000000000000000
[   60.832589] head: 0000000000000004 0000000000000000
00000000ffffffff 0000000000000000
[   60.833023] page dumped because: kasan: bad access detected
[   60.833325]
[   60.833410] Memory state around the buggy address:
[   60.833667]  ffff0000aa307e80: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[   60.834063]  ffff0000aa307f00: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[   60.834452] >ffff0000aa307f80: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[   60.834818]                       ^
[   60.834996]  ffff0000aa308000: fa fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[   60.835398]  ffff0000aa308080: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[   60.835805] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   60.836388] Disabling lock debugging due to kernel taint
[   60.836709] Unable to handle kernel paging request at virtual
address dfff80a081b0d020
[   60.837066] KASAN: probably user-memory-access in range
[0x000005040d868100-0x000005040d868107]
[   60.837469] Mem abort info:
[   60.837583]   ESR =3D 0x0000000096000004
[   60.837760]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[   60.838007]   SET =3D 0, FnV =3D 0
[   60.838146]   EA =3D 0, S1PTW =3D 0
[   60.838289]   FSC =3D 0x04: level 0 translation fault
[   60.838503] Data abort info:
[   60.838628]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
[   60.838865]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[   60.839074]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[   60.839296] [dfff80a081b0d020] address between user and kernel address r=
anges
[   60.839609] Internal error: Oops: 0000000096000004 [#1] SMP
[   60.839858] Modules linked in: rpcsec_gss_krb5 nfsv3 nfs netfs
rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd nfs_acl lockd grace
nfs_localio overlay isofs uinput snd_seq_dummy snd_hrtimer qrtr rfkill
vfat fat snd_hda_codec_generic uvcvideo videobuf2_vmalloc
videobuf2_memops uvc snd_hda_intel videobuf2_v4l2 videobuf2_common
videodev snd_intel_dspcfg snd_hda_codec e1000e snd_hda_core mc
snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd soundcore sg
auth_rpcgss sunrpc dm_multipath dm_mod loop nfnetlink vsock_loopback
vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vmw_vmci
vsock xfs ghash_ce nvme sha2_ce vmwgfx nvme_core sha256_arm64 sha1_ce
nvme_auth sr_mod cdrom drm_ttm_helper ttm fuse
[   60.842700] CPU: 2 UID: 0 PID: 5339 Comm: lockd Kdump: loaded
Tainted: G    B              6.14.0-rc1+ #38
[   60.843266] Tainted: [B]=3DBAD_PAGE
[   60.843427] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS
VMW201.00V.24006586.BA64.2406042154 06/04/2024
[   60.844156] pstate: 41400005 (nZcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=
=3D--)
[   60.844511] pc : nfsd4_spo_must_allow+0x1a4/0x370 [nfsd]
[   60.844825] lr : nfsd4_spo_must_allow+0x334/0x370 [nfsd]
[   60.845129] sp : ffff80008b2e7410
[   60.845291] x29: ffff80008b2e7410 x28: 0000000000000003 x27: 00000000000=
0a534
[   60.845641] x26: ffff00009b7e3c00 x25: dfff800000000000 x24: 00000000000=
00000
[   60.845988] x23: ffff0000aa307c28 x22: ffff0000aa307f7c x21: 00000000000=
00000
[   60.846304] x20: 0000000000000001 x19: 000005040d868107 x18: 1fffe00011f=
1183c
[   60.846612] x17: 0000000000000000 x16: 0000000000000000 x15: 00000000000=
00000
[   60.846932] x14: 0000000000000000 x13: 0000000000000001 x12: ffff700010b=
4c349
[   60.847244] x11: 1ffff00010b4c348 x10: ffff700010b4c348 x9 : dfff8000000=
00000
[   60.847551] x8 : ffff80008b2e7400 x7 : 0000000000000000 x6 : 00000000000=
00001
[   60.847907] x5 : ffff6000136fc787 x4 : ffff0000a1452c80 x3 : 00000000000=
00020
[   60.848241] x2 : 000000a081b0d020 x1 : ffff0000a1624000 x0 : 00000000000=
00000
[   60.848579] Call trace:
[   60.848699]  nfsd4_spo_must_allow+0x1a4/0x370 [nfsd] (P)
[   60.849081]  check_nfsd_access+0x22c/0x3a8 [nfsd]
[   60.849340]  __fh_verify+0x81c/0x980 [nfsd]
[   60.849610]  fh_verify+0xb0/0x198 [nfsd]
[   60.849826]  nfsd_open+0x7c/0xd8 [nfsd]
[   60.850057]  nlm_fopen+0x14c/0x240 [nfsd]
[   60.850323]  nlm_do_fopen+0xb0/0x160 [lockd]
[   60.850546]  nlm_lookup_file+0x388/0x5e0 [lockd]
[   60.850776]  nlm4svc_retrieve_args+0x1fc/0x530 [lockd]
[   60.851031]  __nlm4svc_proc_lock+0x18c/0x328 [lockd]
[   60.851290]  nlm4svc_proc_lock+0x48/0x60 [lockd]
[   60.851534]  nlmsvc_dispatch+0xb4/0x200 [lockd]
[   60.851816]  svc_process_common+0xa24/0x18d8 [sunrpc]
[   60.852108]  svc_process+0x3d8/0x7f8 [sunrpc]
[   60.852349]  svc_handle_xprt+0x5d4/0xd70 [sunrpc]
[   60.852614]  svc_recv+0x2b8/0x690 [sunrpc]
[   60.852846]  lockd+0x154/0x298 [lockd]
[   60.853037]  kthread+0x2e8/0x388
[   60.853209]  ret_from_fork+0x10/0x20
[   60.853397] Code: f9401f53 11000694 8b180273 d343fe62 (38f96842)
[   60.853700] SMP: stopping secondary CPUs
[   60.854775] Starting crashdump kernel...
[   60.854968] Bye!

>
> I really don't think calling into check_nfsd_access() is appropriate for =
NLM.
>
> >
> > > So check_nfsd_access() is being called with may_bypass_gss and this:
> > >
> > >         if (may_bypass_gss && (
> > >              rqstp->rq_cred.cr_flavor =3D=3D RPC_AUTH_NULL ||
> > >              rqstp->rq_cred.cr_flavor =3D=3D RPC_AUTH_UNIX)) {
> > >                 for (f =3D exp->ex_flavors; f < end; f++) {
> > >                         if (f->pseudoflavor >=3D RPC_AUTH_DES)
> > >                                 return 0;
> > >                 }
> > >         }
> > >
> > > in check_nfsd_access() should succeed.
> > > Can you add some tracing and see what is happening in here?
> > > Maybe the "goto denied" earlier in the function is being reached.  I
> > > don't fully understand the TLS code yet - maybe it needs some test on
> > > may_bypass_gss.
> > >
> > > Thanks,
> > > NeilBrown
> > >
> > >
> > > >
> > > > > > +               /* NLM is allowed to fully bypass authenticatio=
n */
> > > > > > +               goto out;
> > > > > > +
> > > > > >         if (access & NFSD_MAY_BYPASS_GSS)
> > > > > >                 may_bypass_gss =3D true;
> > > > > >         /*
> > > > > > @@ -385,7 +382,6 @@ __fh_verify(struct svc_rqst *rqstp,
> > > > > >         if (error)
> > > > > >                 goto out;
> > > > > >
> > > > > > -skip_pseudoflavor_check:
> > > > > >         /* Finally, check access permissions. */
> > > > > >         error =3D nfsd_permission(cred, exp, dentry, access);
> > > > > >  out:
> > > > > > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > > > > > index b8470d4cbe99..3448e444d410 100644
> > > > > > --- a/fs/nfsd/trace.h
> > > > > > +++ b/fs/nfsd/trace.h
> > > > > > @@ -79,7 +79,7 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
> > > > > >                 { NFSD_MAY_READ,                "READ" },      =
         \
> > > > > >                 { NFSD_MAY_SATTR,               "SATTR" },     =
         \
> > > > > >                 { NFSD_MAY_TRUNC,               "TRUNC" },     =
         \
> > > > > > -               { NFSD_MAY_LOCK,                "LOCK" },      =
         \
> > > > > > +               { NFSD_MAY_NLM,                 "NLM" },       =
         \
> > > > > >                 { NFSD_MAY_OWNER_OVERRIDE,      "OWNER_OVERRIDE=
" },     \
> > > > > >                 { NFSD_MAY_LOCAL_ACCESS,        "LOCAL_ACCESS" =
},       \
> > > > > >                 { NFSD_MAY_BYPASS_GSS_ON_ROOT,  "BYPASS_GSS_ON_=
ROOT" }, \
> > > > > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > > > > index 51f5a0b181f9..2610638f4301 100644
> > > > > > --- a/fs/nfsd/vfs.c
> > > > > > +++ b/fs/nfsd/vfs.c
> > > > > > @@ -2509,7 +2509,7 @@ nfsd_permission(struct svc_cred *cred, st=
ruct svc_export *exp,
> > > > > >                 (acc & NFSD_MAY_EXEC)?  " exec"  : "",
> > > > > >                 (acc & NFSD_MAY_SATTR)? " sattr" : "",
> > > > > >                 (acc & NFSD_MAY_TRUNC)? " trunc" : "",
> > > > > > -               (acc & NFSD_MAY_LOCK)?  " lock"  : "",
> > > > > > +               (acc & NFSD_MAY_NLM)?   " nlm"  : "",
> > > > > >                 (acc & NFSD_MAY_OWNER_OVERRIDE)? " owneroverrid=
e" : "",
> > > > > >                 inode->i_mode,
> > > > > >                 IS_IMMUTABLE(inode)?    " immut" : "",
> > > > > > @@ -2534,16 +2534,6 @@ nfsd_permission(struct svc_cred *cred, s=
truct svc_export *exp,
> > > > > >         if ((acc & NFSD_MAY_TRUNC) && IS_APPEND(inode))
> > > > > >                 return nfserr_perm;
> > > > > >
> > > > > > -       if (acc & NFSD_MAY_LOCK) {
> > > > > > -               /* If we cannot rely on authentication in NLM r=
equests,
> > > > > > -                * just allow locks, otherwise require read per=
mission, or
> > > > > > -                * ownership
> > > > > > -                */
> > > > > > -               if (exp->ex_flags & NFSEXP_NOAUTHNLM)
> > > > > > -                       return 0;
> > > > > > -               else
> > > > > > -                       acc =3D NFSD_MAY_READ | NFSD_MAY_OWNER_=
OVERRIDE;
> > > > > > -       }
> > > > > >         /*
> > > > > >          * The file owner always gets access permission for acc=
esses that
> > > > > >          * would normally be checked at open time. This is to m=
ake
> > > > > > diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> > > > > > index 854fb95dfdca..f9b09b842856 100644
> > > > > > --- a/fs/nfsd/vfs.h
> > > > > > +++ b/fs/nfsd/vfs.h
> > > > > > @@ -20,7 +20,7 @@
> > > > > >  #define NFSD_MAY_READ                  0x004 /* =3D=3D MAY_REA=
D */
> > > > > >  #define NFSD_MAY_SATTR                 0x008
> > > > > >  #define NFSD_MAY_TRUNC                 0x010
> > > > > > -#define NFSD_MAY_LOCK                  0x020
> > > > > > +#define NFSD_MAY_NLM                   0x020 /* request is fro=
m lockd */
> > > > > >  #define NFSD_MAY_MASK                  0x03f
> > > > > >
> > > > > >  /* extra hints to permission and open routines: */
> > > > > >
> > > > > > base-commit: c4e418a53fe30d8e1da68f5aabca352b682fd331
> > > > > > --
> > > > > > 2.46.0
> > > > > >
> > > > > >
> > > >

