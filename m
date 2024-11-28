Return-Path: <linux-nfs+bounces-8242-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BB49DB1F4
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Nov 2024 04:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C29C0167528
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Nov 2024 03:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD3F76034;
	Thu, 28 Nov 2024 03:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1gAMPhm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207582CAB;
	Thu, 28 Nov 2024 03:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732765077; cv=none; b=AFl6yfUgf5cBfduZMf5mlEbK5gzpz55Wsxs0NlrWa/VeKl4BFrPQpTI1lOSkkOBCqcAqoKbfkbhJz0ArvJNeSgbFmz16AvzinZVsQ4/pTio3bv0Pvu7zTAvwfnRxbXxJnwL41mIpq4sc+YPcnWP6ChxX3wlVo5MPSAymPVlosyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732765077; c=relaxed/simple;
	bh=ZoTTmS+0Dz+LOreH5cIdPbuenDJMkIESoEIdHWGD5rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9zZsL10HVPCiCaiUel8bFQ70C4gd8k9kLLfYZPLTHYpavUdfWfxivklpUrGuvJOTFemTKUbAoLTv/6Q+gxKdFrULDQ8hP4V5oYon+zIOB/VT5wEqpPxHYxxIUwqok98QWfhBjSImTqtltO49iE9VDMCXpaidIiEE33lk3y/us0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1gAMPhm; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5ceca0ec4e7so454404a12.0;
        Wed, 27 Nov 2024 19:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732765073; x=1733369873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArKmNB6GQoCPadD72K5pJh2y/FpAgOrPYob8gU60vM8=;
        b=Y1gAMPhm4q0hINYZGE+YXbo59gPjCY4T1a34LPLSx7v3WTcJsPFlfvpknf4OmJGwYE
         0cSiTwA7UKKxCouCCDfFNIYX8AqYIIHRSwFzezWNueuCjh9O4V7ToVnRu9UgVdJp4NoK
         /Kh6ImsnzyhHcSnfHOBInDIN6Lrtroe+4ebubeHbNEfvsNR0X0iX8f6PC4jIfrEDPl4+
         iHkunGzNU4GDU1BW3j6ibLpisc9TGN5eQG+FdBNTVf/0moabVYEU/VQoxyOCPDZ8VMAk
         +n93WEoPJGSBjjI+yMwBkPPFWvXjl1Sz7BsdSfZuVn9BNsjqhTdKDL8II2ZFi+CkQoIt
         E6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732765073; x=1733369873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ArKmNB6GQoCPadD72K5pJh2y/FpAgOrPYob8gU60vM8=;
        b=WvZt+Cu2vKf9WOB3GzibQGaobKuPBkDeRiEp+CWqVcxrRzUm6V24/bHPFo+NBXzXLR
         P9opYeIH2fj3A0WKjbCnMyCwrvZ6CPB+IxEmJ0Z6z/pQqZmDH+zUHRdEiOY85YRxR3FQ
         H9uOtg8BZJZvm8Mh2CHqxlySwXb5Q0osQ4r458smSzIbEKmYTT/Bjd7ZbZvjzMddp/EB
         bShk/kwamPhH+3VsvyvzUveDWQaMnpXIp+NcQOWvl7LFzNALFCF3Ydt9VxrZTc+z4Kcn
         3fqfxY76d8Ykj1QRDd96WKqODvMfsgBPPdSkxt1nkPnMzWRrRE4CgnxcK5uITOarXF6b
         5oLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxkGWqmib8zmkTwv3ZAxA95DsygKKobHclThqJWcspdkb7RqBy/b2muVYnvNfB/65j0Sqi7eoyc9km2VA=@vger.kernel.org, AJvYcCWqbZ6YhgzJXWpkaMfc6+0+LI38PLlMgc/LuuyyYS1rwtbde3jmMDQo+dMcnc8jaikBk+ck5Y1S1uXm@vger.kernel.org
X-Gm-Message-State: AOJu0YwWxMM3kpqFTfLnCqwfG/+WFs97hpyRwXt5090ED0dPByRYulLd
	h8fBHH3D7kH/ZxpLhQdSkiuYHY1tQZS+KLSU9HUvcK7XBotAv7MIidyO12CkinLI3hKd4lCeJAg
	aI466yB+6bR7ryH7z5iQfAsQ8Hg==
X-Gm-Gg: ASbGncscOynBtMSkDuXrYNZFbScAHbTlbG7S8C5VksJ3ooeWZ35tJzQWNb81hcmUArb
	FdlAgNoqwmS3ZaTZkrERHmIPvQCnkbh172KJ8K5zqW1A3xUX4RYSYnOmtZNCnkfQ=
X-Google-Smtp-Source: AGHT+IHDpM3i2FWv48PeXOkXWnXts4mzDDPM7xQpxX5PEnZ8KllEN4kbuTNktNn8GozWPa6cB0ioHh9LKIRfhsUaL5M=
X-Received: by 2002:a05:6402:2807:b0:5cf:dcd4:1277 with SMTP id
 4fb4d7f45d1cf-5d080b7fb27mr5952569a12.7.1732765073248; Wed, 27 Nov 2024
 19:37:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107014705.2509463-1-lilingfeng@huaweicloud.com>
 <93fd0f1c-812f-4393-ad73-4d07ecebf979@huawei.com> <CAM5tNy4rYLWSuO_KrgXJrHV+DPhOoZGZAdWLZsW35u3qWuMSvg@mail.gmail.com>
In-Reply-To: <CAM5tNy4rYLWSuO_KrgXJrHV+DPhOoZGZAdWLZsW35u3qWuMSvg@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Wed, 27 Nov 2024 19:37:42 -0800
Message-ID: <CAM5tNy4QXM8bhcfTtrKt+ogWPPOKe5g06j1sgFm5z8=BKP-4vw@mail.gmail.com>
Subject: Re: [PATCH] nfsd: set acl_access/acl_default after getting successful
To: "zhangjian (CG)" <zhangjian496@huawei.com>
Cc: Li Lingfeng <lilingfeng@huaweicloud.com>, chuck.lever@oracle.com, jlayton@kernel.org, 
	neilb@suse.de, okorniev@redhat.com, kolga@netapp.com, Dai.Ngo@oracle.com, 
	tom@talpey.com, Trond.Myklebust@netapp.com, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com, houtao1@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com, lilingfeng3@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 7:14=E2=80=AFPM Rick Macklem <rick.macklem@gmail.co=
m> wrote:
>
> On Wed, Nov 27, 2024 at 5:18=E2=80=AFPM zhangjian (CG) <zhangjian496@huaw=
ei.com> wrote:
> >
> > there is one case when disk error cause get_inode_acl(inode,
> > ACL_TYPE_DEFAULT) return EIO,
> > resp->acl_access will not be null. posix_acl_release(resp->acl_default)
> > will trigger this warning.
> >
> >
> > > If getting acl_default fails, acl_access and acl_default will be rele=
ased
> > > simultaneously. However, acl_access will still retain a pointer point=
ing
> > > to the released posix_acl, which will trigger a WARNING in
> > > nfs3svc_release_getacl like this:
> > >
> > > ------------[ cut here ]------------
> > > refcount_t: underflow; use-after-free.
> > > WARNING: CPU: 26 PID: 3199 at lib/refcount.c:28
> > > refcount_warn_saturate+0xb5/0x170
> > > Modules linked in:
> > > CPU: 26 UID: 0 PID: 3199 Comm: nfsd Not tainted
> > > 6.12.0-rc6-00079-g04ae226af01f-dirty #8
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > > 1.16.1-2.fc37 04/01/2014
> > > RIP: 0010:refcount_warn_saturate+0xb5/0x170
> > > Code: cc cc 0f b6 1d b3 20 a5 03 80 fb 01 0f 87 65 48 d8 00 83 e3 01 =
75
> > > e4 48 c7 c7 c0 3b 9b 85 c6 05 97 20 a5 03 01 e8 fb 3e 30 ff <0f> 0b e=
b
> > > cd 0f b6 1d 8a3
> > > RSP: 0018:ffffc90008637cd8 EFLAGS: 00010282
> > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff83904fde
> > > RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffff88871ed36380
> > > RBP: ffff888158beeb40 R08: 0000000000000001 R09: fffff520010c6f56
> > > R10: ffffc90008637ab7 R11: 0000000000000001 R12: 0000000000000001
> > > R13: ffff888140e77400 R14: ffff888140e77408 R15: ffffffff858b42c0
> > > FS:  0000000000000000(0000) GS:ffff88871ed00000(0000)
> > > knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 0000562384d32158 CR3: 000000055cc6a000 CR4: 00000000000006f0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >   <TASK>
> > >   ? refcount_warn_saturate+0xb5/0x170
> > >   ? __warn+0xa5/0x140
> > >   ? refcount_warn_saturate+0xb5/0x170
> > >   ? report_bug+0x1b1/0x1e0
> > >   ? handle_bug+0x53/0xa0
> > >   ? exc_invalid_op+0x17/0x40
> > >   ? asm_exc_invalid_op+0x1a/0x20
> > >   ? tick_nohz_tick_stopped+0x1e/0x40
> > >   ? refcount_warn_saturate+0xb5/0x170
> > >   ? refcount_warn_saturate+0xb5/0x170
> > >   nfs3svc_release_getacl+0xc9/0xe0
> > >   svc_process_common+0x5db/0xb60
> > >   ? __pfx_svc_process_common+0x10/0x10
> > >   ? __rcu_read_unlock+0x69/0xa0
> > >   ? __pfx_nfsd_dispatch+0x10/0x10
> > >   ? svc_xprt_received+0xa1/0x120
> > >   ? xdr_init_decode+0x11d/0x190
> > >   svc_process+0x2a7/0x330
> > >   svc_handle_xprt+0x69d/0x940
> > >   svc_recv+0x180/0x2d0
> > >   nfsd+0x168/0x200
> > >   ? __pfx_nfsd+0x10/0x10
> > >   kthread+0x1a2/0x1e0
> > >   ? kthread+0xf4/0x1e0
> > >   ? __pfx_kthread+0x10/0x10
> > >   ret_from_fork+0x34/0x60
> > >   ? __pfx_kthread+0x10/0x10
> > >   ret_from_fork_asm+0x1a/0x30
> > >   </TASK>
> > > Kernel panic - not syncing: kernel: panic_on_warn set ...
> > >
> > > Clear acl_access/acl_default first and set both of them only when bot=
h
> > > ACLs are successfully obtained.
> > >
> > > Fixes: a257cdd0e217 ("[PATCH] NFSD: Add server support for NFSv3 ACLs=
.")
> > > Signed-off-by: Li Lingfeng <lilingfeng@huaweicloud.com>
> > > ---
> > >   fs/nfsd/nfs3acl.c | 14 ++++++++------
> > >   1 file changed, 8 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
> > > index 5e34e98db969..17579a032a5b 100644
> > > --- a/fs/nfsd/nfs3acl.c
> > > +++ b/fs/nfsd/nfs3acl.c
> > > @@ -29,10 +29,12 @@ static __be32 nfsd3_proc_getacl(struct svc_rqst *=
rqstp)
> > >   {
> > >       struct nfsd3_getaclargs *argp =3D rqstp->rq_argp;
> > >       struct nfsd3_getaclres *resp =3D rqstp->rq_resp;
> > > -     struct posix_acl *acl;
> > > +     struct posix_acl *acl =3D NULL, *dacl =3D NULL;
> > >       struct inode *inode;
> > >       svc_fh *fh;
> > >
> > > +     resp->acl_access =3D NULL;
> > > +     resp->acl_default =3D NULL;
> (A) These two lines fix the bug, without other changes needed, I think...
Oops, I was wrong w.r.t. this. These two lines need to be repeated after th=
e
posix_acl_relase() calls under "fail:".
> > >       fh =3D fh_copy(&resp->fh, &argp->fh);
> > >       resp->status =3D fh_verify(rqstp, &resp->fh, 0, NFSD_MAY_NOP);
> > >       if (resp->status !=3D nfs_ok)
> > > @@ -56,19 +58,19 @@ static __be32 nfsd3_proc_getacl(struct svc_rqst *=
rqstp)
> > >                       resp->status =3D nfserrno(PTR_ERR(acl));
> > >                       goto fail;
> > >               }
> > > -             resp->acl_access =3D acl;
> Because you deleted this line...
> > >       }
> > >       if (resp->mask & (NFS_DFACL|NFS_DFACLCNT)) {
> > >               /* Check how Solaris handles requests for the Default A=
CL
> > >                  of a non-directory! */
> > > -             acl =3D get_inode_acl(inode, ACL_TYPE_DEFAULT);
> > > -             if (IS_ERR(acl)) {
> > > -                     resp->status =3D nfserrno(PTR_ERR(acl));
> > > +             dacl =3D get_inode_acl(inode, ACL_TYPE_DEFAULT);
> > > +             if (IS_ERR(dacl)) {
> > > +                     resp->status =3D nfserrno(PTR_ERR(dacl));
> > >                       goto fail;
> The goto fail here will not release the access acl, if I read the code
> correctly.
> > >               }
> > > -             resp->acl_default =3D acl;
> > >       }
> > >
> > > +     resp->acl_access =3D acl;
> > > +     resp->acl_default =3D dacl;
> > >       /* resp->acl_{access,default} are released in nfs3svc_release_g=
etacl. */
> > >   out:
> > >       return rpc_success;
> >
> Actually, all that is needed to fix the bug is adding the two lines
> that initialize
> them both NUL, I think.. I marked that change (A) above.
Nope, I was wrong w.r.t. this part. You either need to set
     resp->acl_access =3D acl;
     resp->acl_default =3D dacl;
after the posix_acl_relase() calls or switch to using the local
acl and dacl variables for these posix_acl_release calls and stick
with what you did above w.r.t. resp->acl_access and resp->acl_default.

Anyhow, I think the case I noted above where get_inode_acl(inode,
ACL_TYPE_DEFAULT)
fails will not release acl with your patch.

rick

>
> rick

