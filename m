Return-Path: <linux-nfs+bounces-8305-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C9A9E096D
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 18:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2AB280A08
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 17:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67181AC444;
	Mon,  2 Dec 2024 17:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSPY2QBy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52A11AB6EA;
	Mon,  2 Dec 2024 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159182; cv=none; b=jd8aED3RLdA7rxkQHjhtTXyOhYCvvy3yd1ndt/jubEnSIzeOrCNXOCo5AoiEPnambJBirhLExK4Jj80bqkPBV/6STBPWbu3xc7ArBaPLVzAuvnone1RUKVCiodtRPu7tq7QdDk4w4jmTn8CeI0dXSJENs9lCIfGYfIw9IJ9RYKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159182; c=relaxed/simple;
	bh=LscUGPlCVTMi9YLaUvZsUDyhHjb7Xt3ttcgJojJmxrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNLAwi+RyXoRTEHrB1c9CQEPb9hp+k4dSII+FKCdW+NtsQTBEOMgRBcKbfSuSvX5drnfjxcqSOlRX0yIn7twpBzQhNgRbUl+pi/A4aVcTmn+MD1YBiBPzhEBNjIkOJED1yXPeKozdpRyU4k0asY4qtl+cRgZ53GYqXXFu8C+f5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSPY2QBy; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cece886771so8046520a12.0;
        Mon, 02 Dec 2024 09:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733159179; x=1733763979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdKjqhPabAxyMct+P6vOhrz8S75Nq03r7c078zz220g=;
        b=gSPY2QByfGlC9CMCOzJicudwc49hSOgl/FI8GdbWxn3NJCs0quoeY6hBA048v4Tc9L
         bocQ95BK6M1VwTsvvWzuiuVfW971Y2Q+MgqIKAk07AqaQCAGEjIY7rMHdqxqzSa1W1+5
         jUI4R5ft+Z7yVJe2tqGd8EC1V/EO5Rnn+i/nmvLZPb2CvY4G0tl5/rZ2F8lYVC/Tf7Wn
         SVDFzpQQnROWz1pqXsqVvS8f5SqA7vg0AIsfpZ/wbM6+FmByib9VaaJQDg46E+WtaSC8
         K+v0DYlK2gEAc9JNb2ApbSzoJntCyeSkN1rNzUFF5ehZDTkNxNK3aYPPc15OejU42EGR
         PjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733159179; x=1733763979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdKjqhPabAxyMct+P6vOhrz8S75Nq03r7c078zz220g=;
        b=eHj21GZU5QEGXtjnu2Kc3rMM1+A4TM24k+8WowEveL4fem5bzSJFgva4xEaSPdo2dl
         eBx68njQoRNUAVNgA0MxZoKKZCmmOdibNY8nvNPE4CD73zHXyDmXmFimlba0YM0B9upE
         Gb822WAz4gdhJhpNYwKdmB1jccR0cHlT9vsqV7O1GBoN00N0dXVeR4xGrcEcfE1saZ/2
         foPV5cBFbh5Vbls/tMjv/m7OxYbtuvto6Z2KgW8xru8ndVQobYE6axufXIumSucOFUth
         QY4rNtDH56EgDZMn8yGkM9sqtkiRsjF75lZHInqtVNg4gS6JzZIKwe3DMXDsHx+NKFpQ
         hNQg==
X-Forwarded-Encrypted: i=1; AJvYcCU1xmA5mz/iKd84vjBMnV8u0w8qLsyO0VRvVcJDwr/S2xZT6j3041nSZzg2C69+vQhXNDtvnP228zJp@vger.kernel.org, AJvYcCVoqUETjRRWpdBtbgz3hpDlH4SFFUDSIynpKhSBq3PQqxUU+SxvxKvVs7F53lfGoj3sUGENAIWJU72ikpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYICddnba6UUGOU4Zh6uMkD5z4DbBvOEqPtSHDs8yBLakzx+Ll
	0yV9E9CBEoGKNu/WX0i3ca2z/pTDs9FkqBmssOdp2dEEinI/S4w4YPnOEsIX14yov0FxEdiECC1
	n755s6ZXlWZEs/VpnYx4BFNsLoQ==
X-Gm-Gg: ASbGnct2FaVjsAVIq5Zef9FcHT5xPHmVGo/uZdBX5V3bH8WJ6q/rYNPZmn9LsdOh4FC
	M2TfzlA+5bWWo1zCFmt6sCYXR0ceKGgX4D0CAJqiL7fsi4+lvDHmTCR5ojeJbi88=
X-Google-Smtp-Source: AGHT+IF1P8KO+fxewApr0nvqHXvhFT1mouSVP7JzMeBLjj19flWEIb7fwGWdzXrbZJCiPoI030KwWu3ccbOHsNKakmc=
X-Received: by 2002:a05:6402:13d3:b0:5d0:f6ed:4cd1 with SMTP id
 4fb4d7f45d1cf-5d0f6ed5069mr4647543a12.10.1733159178507; Mon, 02 Dec 2024
 09:06:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107014705.2509463-1-lilingfeng@huaweicloud.com>
 <93fd0f1c-812f-4393-ad73-4d07ecebf979@huawei.com> <CAM5tNy4rYLWSuO_KrgXJrHV+DPhOoZGZAdWLZsW35u3qWuMSvg@mail.gmail.com>
 <CAM5tNy4QXM8bhcfTtrKt+ogWPPOKe5g06j1sgFm5z8=BKP-4vw@mail.gmail.com> <Z03fpnNYHjuKox0E@tissot.1015granger.net>
In-Reply-To: <Z03fpnNYHjuKox0E@tissot.1015granger.net>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Mon, 2 Dec 2024 09:06:06 -0800
Message-ID: <CAM5tNy4AYfJ+AhX-UJ_orvuOkv=ctg=oCHrrOjTcfLz+rRrCsg@mail.gmail.com>
Subject: Re: [PATCH] nfsd: set acl_access/acl_default after getting successful
To: Chuck Lever <chuck.lever@oracle.com>
Cc: lilingfeng@huaweicloud.com, "zhangjian (CG)" <zhangjian496@huawei.com>, jlayton@kernel.org, 
	neilb@suse.de, okorniev@redhat.com, kolga@netapp.com, Dai.Ngo@oracle.com, 
	tom@talpey.com, Trond.Myklebust@netapp.com, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com, houtao1@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com, lilingfeng3@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 8:33=E2=80=AFAM Chuck Lever <chuck.lever@oracle.com>=
 wrote:
>
> CAUTION: This email originated from outside of the University of Guelph. =
Do not click links or open attachments unless you recognize the sender and =
know the content is safe. If in doubt, forward suspicious emails to IThelp@=
uoguelph.ca.
>
>
> On Wed, Nov 27, 2024 at 07:37:42PM -0800, Rick Macklem wrote:
> > On Wed, Nov 27, 2024 at 7:14=E2=80=AFPM Rick Macklem <rick.macklem@gmai=
l.com> wrote:
> > >
> > > On Wed, Nov 27, 2024 at 5:18=E2=80=AFPM zhangjian (CG) <zhangjian496@=
huawei.com> wrote:
> > > >
> > > > there is one case when disk error cause get_inode_acl(inode,
> > > > ACL_TYPE_DEFAULT) return EIO,
> > > > resp->acl_access will not be null. posix_acl_release(resp->acl_defa=
ult)
> > > > will trigger this warning.
> > > >
> > > >
> > > > > If getting acl_default fails, acl_access and acl_default will be =
released
> > > > > simultaneously. However, acl_access will still retain a pointer p=
ointing
> > > > > to the released posix_acl, which will trigger a WARNING in
> > > > > nfs3svc_release_getacl like this:
> > > > >
> > > > > ------------[ cut here ]------------
> > > > > refcount_t: underflow; use-after-free.
> > > > > WARNING: CPU: 26 PID: 3199 at lib/refcount.c:28
> > > > > refcount_warn_saturate+0xb5/0x170
> > > > > Modules linked in:
> > > > > CPU: 26 UID: 0 PID: 3199 Comm: nfsd Not tainted
> > > > > 6.12.0-rc6-00079-g04ae226af01f-dirty #8
> > > > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > > > > 1.16.1-2.fc37 04/01/2014
> > > > > RIP: 0010:refcount_warn_saturate+0xb5/0x170
> > > > > Code: cc cc 0f b6 1d b3 20 a5 03 80 fb 01 0f 87 65 48 d8 00 83 e3=
 01 75
> > > > > e4 48 c7 c7 c0 3b 9b 85 c6 05 97 20 a5 03 01 e8 fb 3e 30 ff <0f> =
0b eb
> > > > > cd 0f b6 1d 8a3
> > > > > RSP: 0018:ffffc90008637cd8 EFLAGS: 00010282
> > > > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff83904fde
> > > > > RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffff88871ed36380
> > > > > RBP: ffff888158beeb40 R08: 0000000000000001 R09: fffff520010c6f56
> > > > > R10: ffffc90008637ab7 R11: 0000000000000001 R12: 0000000000000001
> > > > > R13: ffff888140e77400 R14: ffff888140e77408 R15: ffffffff858b42c0
> > > > > FS:  0000000000000000(0000) GS:ffff88871ed00000(0000)
> > > > > knlGS:0000000000000000
> > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > CR2: 0000562384d32158 CR3: 000000055cc6a000 CR4: 00000000000006f0
> > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > > Call Trace:
> > > > >   <TASK>
> > > > >   ? refcount_warn_saturate+0xb5/0x170
> > > > >   ? __warn+0xa5/0x140
> > > > >   ? refcount_warn_saturate+0xb5/0x170
> > > > >   ? report_bug+0x1b1/0x1e0
> > > > >   ? handle_bug+0x53/0xa0
> > > > >   ? exc_invalid_op+0x17/0x40
> > > > >   ? asm_exc_invalid_op+0x1a/0x20
> > > > >   ? tick_nohz_tick_stopped+0x1e/0x40
> > > > >   ? refcount_warn_saturate+0xb5/0x170
> > > > >   ? refcount_warn_saturate+0xb5/0x170
> > > > >   nfs3svc_release_getacl+0xc9/0xe0
> > > > >   svc_process_common+0x5db/0xb60
> > > > >   ? __pfx_svc_process_common+0x10/0x10
> > > > >   ? __rcu_read_unlock+0x69/0xa0
> > > > >   ? __pfx_nfsd_dispatch+0x10/0x10
> > > > >   ? svc_xprt_received+0xa1/0x120
> > > > >   ? xdr_init_decode+0x11d/0x190
> > > > >   svc_process+0x2a7/0x330
> > > > >   svc_handle_xprt+0x69d/0x940
> > > > >   svc_recv+0x180/0x2d0
> > > > >   nfsd+0x168/0x200
> > > > >   ? __pfx_nfsd+0x10/0x10
> > > > >   kthread+0x1a2/0x1e0
> > > > >   ? kthread+0xf4/0x1e0
> > > > >   ? __pfx_kthread+0x10/0x10
> > > > >   ret_from_fork+0x34/0x60
> > > > >   ? __pfx_kthread+0x10/0x10
> > > > >   ret_from_fork_asm+0x1a/0x30
> > > > >   </TASK>
> > > > > Kernel panic - not syncing: kernel: panic_on_warn set ...
> > > > >
> > > > > Clear acl_access/acl_default first and set both of them only when=
 both
> > > > > ACLs are successfully obtained.
> > > > >
> > > > > Fixes: a257cdd0e217 ("[PATCH] NFSD: Add server support for NFSv3 =
ACLs.")
> > > > > Signed-off-by: Li Lingfeng <lilingfeng@huaweicloud.com>
> > > > > ---
> > > > >   fs/nfsd/nfs3acl.c | 14 ++++++++------
> > > > >   1 file changed, 8 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
> > > > > index 5e34e98db969..17579a032a5b 100644
> > > > > --- a/fs/nfsd/nfs3acl.c
> > > > > +++ b/fs/nfsd/nfs3acl.c
> > > > > @@ -29,10 +29,12 @@ static __be32 nfsd3_proc_getacl(struct svc_rq=
st *rqstp)
> > > > >   {
> > > > >       struct nfsd3_getaclargs *argp =3D rqstp->rq_argp;
> > > > >       struct nfsd3_getaclres *resp =3D rqstp->rq_resp;
> > > > > -     struct posix_acl *acl;
> > > > > +     struct posix_acl *acl =3D NULL, *dacl =3D NULL;
> > > > >       struct inode *inode;
> > > > >       svc_fh *fh;
> > > > >
> > > > > +     resp->acl_access =3D NULL;
> > > > > +     resp->acl_default =3D NULL;
> > > (A) These two lines fix the bug, without other changes needed, I thin=
k...
> > Oops, I was wrong w.r.t. this. These two lines need to be repeated afte=
r the
> > posix_acl_relase() calls under "fail:".
> > > > >       fh =3D fh_copy(&resp->fh, &argp->fh);
> > > > >       resp->status =3D fh_verify(rqstp, &resp->fh, 0, NFSD_MAY_NO=
P);
> > > > >       if (resp->status !=3D nfs_ok)
> > > > > @@ -56,19 +58,19 @@ static __be32 nfsd3_proc_getacl(struct svc_rq=
st *rqstp)
> > > > >                       resp->status =3D nfserrno(PTR_ERR(acl));
> > > > >                       goto fail;
> > > > >               }
> > > > > -             resp->acl_access =3D acl;
> > > Because you deleted this line...
> > > > >       }
> > > > >       if (resp->mask & (NFS_DFACL|NFS_DFACLCNT)) {
> > > > >               /* Check how Solaris handles requests for the Defau=
lt ACL
> > > > >                  of a non-directory! */
> > > > > -             acl =3D get_inode_acl(inode, ACL_TYPE_DEFAULT);
> > > > > -             if (IS_ERR(acl)) {
> > > > > -                     resp->status =3D nfserrno(PTR_ERR(acl));
> > > > > +             dacl =3D get_inode_acl(inode, ACL_TYPE_DEFAULT);
> > > > > +             if (IS_ERR(dacl)) {
> > > > > +                     resp->status =3D nfserrno(PTR_ERR(dacl));
> > > > >                       goto fail;
> > > The goto fail here will not release the access acl, if I read the cod=
e
> > > correctly.
> > > > >               }
> > > > > -             resp->acl_default =3D acl;
> > > > >       }
> > > > >
> > > > > +     resp->acl_access =3D acl;
> > > > > +     resp->acl_default =3D dacl;
> > > > >       /* resp->acl_{access,default} are released in nfs3svc_relea=
se_getacl. */
> > > > >   out:
> > > > >       return rpc_success;
> > > >
> > > Actually, all that is needed to fix the bug is adding the two lines
> > > that initialize
> > > them both NUL, I think.. I marked that change (A) above.
> > Nope, I was wrong w.r.t. this part. You either need to set
> >      resp->acl_access =3D acl;
> >      resp->acl_default =3D dacl;
> > after the posix_acl_relase() calls or switch to using the local
> > acl and dacl variables for these posix_acl_release calls and stick
> > with what you did above w.r.t. resp->acl_access and resp->acl_default.
> >
> > Anyhow, I think the case I noted above where get_inode_acl(inode,
> > ACL_TYPE_DEFAULT)
> > fails will not release acl with your patch.
> >
> > rick
>
> Howdy -
>
> This one didn't make it into v6.13 because there are some
> outstanding (and ambiguous, at least to me) review comments. Can you
> address the comments, update the patch, and post it again?
In an effort to disambiguate my comments, I'll try again.
(And, yes, I did not do a good job last time;-)

1 - I think your patch fails for the case where the acl_access is acquired,
     but the acl_default fails. For this case, I do not see how acl_access
     would be posix_acl_release()'d and would leak the acl structure.
     If you look at your patched version, resp->acl_access is not set when
     the "goto fail" is executed in the default acl if block.

2 - Instead of your patch, the bug can be fixed by simply adding the two
     lines:
     resp->acl_access =3D NULL;
     resp->acl_default =3D NULL;
     after the posix_acl_release() calls below the "fail" label.
     No other changes are required, from what I can see.

rick

>
> --
> Chuck Lever
>

