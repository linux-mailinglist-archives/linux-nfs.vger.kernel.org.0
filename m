Return-Path: <linux-nfs+bounces-8241-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBB19DB1C1
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Nov 2024 04:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4784B20B9F
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Nov 2024 03:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D273B19A;
	Thu, 28 Nov 2024 03:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWXHJPd/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9106635280;
	Thu, 28 Nov 2024 03:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732763712; cv=none; b=WA2/nZgznbWNEobo5sAByKoI7wJbtucLb2z2ECC9AvUvXpz34ZiDFZJi6pNa8m3iluR/jhICgM/Lc84P8fru0meemOH0eAkhGsYa0k9KtEk7cvX65Orjx/UgwRNPXFQVDXQXQS0Tyl8ssNVsMxb/OfD+RnI1wZdbOPUIPjlPkaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732763712; c=relaxed/simple;
	bh=1jQIM2nXWs3BdtTmsas8bahiSBQPrUTQ4/M/3eGJBGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPDnOK9PkNdbaUXu+Jg/kR/xLZuTSgaw0EDzQ0dnqMZWoAEg0n1uTcobb82YDhLopl3F3J7EmOFjq9mmoYVtZ9oIQ0lLvhBrjiluDnD5vVSxlPNjzDaJgEyWTOHiNREpieMSA61qZcXPJn40afA8d+723UF7qDLs7R3ySfkwtHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWXHJPd/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434aa472617so2806155e9.3;
        Wed, 27 Nov 2024 19:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732763709; x=1733368509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/ahOUOuNw5MtYxYC/XX69Rc01WOSSe2BQA0kFM8RjI=;
        b=YWXHJPd/zve6B7qa55AhazQeuCmD+DI4oljL5xKMpd02JwgVXLm2xGqlDpBqdwuwNp
         thTsXYmIPhjHjBZze2QC5RR2MEOHHAZ6EqYD7k9yEffUVqYRciDkatC8UiC5FBCAKdhF
         5R0ZR4LymvterN902WHG1QZC/PpoTxRug+EWoRfT/tHMmBffmufrGqB1RRMD6JI3Huy4
         Ralj7WC62ni6zaudS6ib4pKnryk68XSg+miEIxhsQb+RLrvaEjiMuGZuptY5k+WJDZPE
         CVKYXTv7cD6BCajRQGZQ/b4YCnFmMHLRkVuzYaQTEl7E4Q4maXriYlQWn43zT8l/bQ6Z
         xjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732763709; x=1733368509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/ahOUOuNw5MtYxYC/XX69Rc01WOSSe2BQA0kFM8RjI=;
        b=VLms+m42N92UP5l4/+DXCfini861RR6oY0gxDZ7zNfcOjCpNstjDTn+S6IKLV3KnnS
         7RngsUKZtLCWkoVT97MNP5oT5U7Fa3V4PMlxObjDozWwT5nucj7mcR8p4l7F45sigjDv
         G4UesjRTw/4+ZERqM7rFf+6jmpW/DEDGQeXYcbVpjKoFFRZO45jl9Ua7EBGlb/K7hXxk
         LVFddJNsManlLdtCLuycSPkQL0LKDJGrdesCA87fq2yDKu7/xX9EN8pyv/VCvGyQ73HK
         kt+aYFoT2WSeCcoWjo6VZ4FBqguo2vS2bbmnChfvh55+Wky8LJ15Y+jQY+xogkv9Hi/7
         DYkA==
X-Forwarded-Encrypted: i=1; AJvYcCX3sk9cczi0qpx/eIG+FnmD3wy9vuO4alzC/nSzPyIlvun/KtPg0RCsbfFa0y5iGeSRCZE5LepszAQA@vger.kernel.org, AJvYcCXi3pPXhMOdqVH+j+c3E+ji9jNS2eNpKoEB/zJVelfjORMi5lpIp2Ix0YNp5ew5ojpbuGLfPDjyTFBE1R0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWUxxWXXH5G683PJXZQlxV+KM2oRWU3l/eWTO1+Q4u8bJ1INLD
	iDWYSUEkIvUrburTVyycBahcVbgMOOBBi+MT/Az9IYhWSkmNUWKU3ViI0QQYMb/sT+WS0TEr3IT
	CsWIydggrMexStbcTRKw6Ck+dqw==
X-Gm-Gg: ASbGncuIxmzdsP/mOGfeTATI66+zn/Zc9rpeQoMCT2S9dWgZjLKlLKMNx/mtWMXiMj9
	UqN2uPZMkZb+1l0FlmZRe9m4ufJ/4eIO3WKU5z8PvX02cw6S1p7c32r9doNYy9n4=
X-Google-Smtp-Source: AGHT+IFuuGVEotf1Ti7bkQfT04nI/43gkqh1Cn8N/AaWO/pXxQA2en+Z5vVLGxX98pbyxDMe8KTdFx6rKx4+gVpP3pE=
X-Received: by 2002:a5d:6c69:0:b0:37d:5282:1339 with SMTP id
 ffacd0b85a97d-385c6ebd7b1mr4060678f8f.22.1732763708544; Wed, 27 Nov 2024
 19:15:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107014705.2509463-1-lilingfeng@huaweicloud.com> <93fd0f1c-812f-4393-ad73-4d07ecebf979@huawei.com>
In-Reply-To: <93fd0f1c-812f-4393-ad73-4d07ecebf979@huawei.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Wed, 27 Nov 2024 19:14:57 -0800
Message-ID: <CAM5tNy4rYLWSuO_KrgXJrHV+DPhOoZGZAdWLZsW35u3qWuMSvg@mail.gmail.com>
Subject: Re: [PATCH] nfsd: set acl_access/acl_default after getting successful
To: "zhangjian (CG)" <zhangjian496@huawei.com>
Cc: Li Lingfeng <lilingfeng@huaweicloud.com>, chuck.lever@oracle.com, jlayton@kernel.org, 
	neilb@suse.de, okorniev@redhat.com, kolga@netapp.com, Dai.Ngo@oracle.com, 
	tom@talpey.com, Trond.Myklebust@netapp.com, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com, houtao1@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com, lilingfeng3@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 5:18=E2=80=AFPM zhangjian (CG) <zhangjian496@huawei=
.com> wrote:
>
> there is one case when disk error cause get_inode_acl(inode,
> ACL_TYPE_DEFAULT) return EIO,
> resp->acl_access will not be null. posix_acl_release(resp->acl_default)
> will trigger this warning.
>
>
> > If getting acl_default fails, acl_access and acl_default will be releas=
ed
> > simultaneously. However, acl_access will still retain a pointer pointin=
g
> > to the released posix_acl, which will trigger a WARNING in
> > nfs3svc_release_getacl like this:
> >
> > ------------[ cut here ]------------
> > refcount_t: underflow; use-after-free.
> > WARNING: CPU: 26 PID: 3199 at lib/refcount.c:28
> > refcount_warn_saturate+0xb5/0x170
> > Modules linked in:
> > CPU: 26 UID: 0 PID: 3199 Comm: nfsd Not tainted
> > 6.12.0-rc6-00079-g04ae226af01f-dirty #8
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > 1.16.1-2.fc37 04/01/2014
> > RIP: 0010:refcount_warn_saturate+0xb5/0x170
> > Code: cc cc 0f b6 1d b3 20 a5 03 80 fb 01 0f 87 65 48 d8 00 83 e3 01 75
> > e4 48 c7 c7 c0 3b 9b 85 c6 05 97 20 a5 03 01 e8 fb 3e 30 ff <0f> 0b eb
> > cd 0f b6 1d 8a3
> > RSP: 0018:ffffc90008637cd8 EFLAGS: 00010282
> > RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff83904fde
> > RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffff88871ed36380
> > RBP: ffff888158beeb40 R08: 0000000000000001 R09: fffff520010c6f56
> > R10: ffffc90008637ab7 R11: 0000000000000001 R12: 0000000000000001
> > R13: ffff888140e77400 R14: ffff888140e77408 R15: ffffffff858b42c0
> > FS:  0000000000000000(0000) GS:ffff88871ed00000(0000)
> > knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000562384d32158 CR3: 000000055cc6a000 CR4: 00000000000006f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >   <TASK>
> >   ? refcount_warn_saturate+0xb5/0x170
> >   ? __warn+0xa5/0x140
> >   ? refcount_warn_saturate+0xb5/0x170
> >   ? report_bug+0x1b1/0x1e0
> >   ? handle_bug+0x53/0xa0
> >   ? exc_invalid_op+0x17/0x40
> >   ? asm_exc_invalid_op+0x1a/0x20
> >   ? tick_nohz_tick_stopped+0x1e/0x40
> >   ? refcount_warn_saturate+0xb5/0x170
> >   ? refcount_warn_saturate+0xb5/0x170
> >   nfs3svc_release_getacl+0xc9/0xe0
> >   svc_process_common+0x5db/0xb60
> >   ? __pfx_svc_process_common+0x10/0x10
> >   ? __rcu_read_unlock+0x69/0xa0
> >   ? __pfx_nfsd_dispatch+0x10/0x10
> >   ? svc_xprt_received+0xa1/0x120
> >   ? xdr_init_decode+0x11d/0x190
> >   svc_process+0x2a7/0x330
> >   svc_handle_xprt+0x69d/0x940
> >   svc_recv+0x180/0x2d0
> >   nfsd+0x168/0x200
> >   ? __pfx_nfsd+0x10/0x10
> >   kthread+0x1a2/0x1e0
> >   ? kthread+0xf4/0x1e0
> >   ? __pfx_kthread+0x10/0x10
> >   ret_from_fork+0x34/0x60
> >   ? __pfx_kthread+0x10/0x10
> >   ret_from_fork_asm+0x1a/0x30
> >   </TASK>
> > Kernel panic - not syncing: kernel: panic_on_warn set ...
> >
> > Clear acl_access/acl_default first and set both of them only when both
> > ACLs are successfully obtained.
> >
> > Fixes: a257cdd0e217 ("[PATCH] NFSD: Add server support for NFSv3 ACLs."=
)
> > Signed-off-by: Li Lingfeng <lilingfeng@huaweicloud.com>
> > ---
> >   fs/nfsd/nfs3acl.c | 14 ++++++++------
> >   1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
> > index 5e34e98db969..17579a032a5b 100644
> > --- a/fs/nfsd/nfs3acl.c
> > +++ b/fs/nfsd/nfs3acl.c
> > @@ -29,10 +29,12 @@ static __be32 nfsd3_proc_getacl(struct svc_rqst *rq=
stp)
> >   {
> >       struct nfsd3_getaclargs *argp =3D rqstp->rq_argp;
> >       struct nfsd3_getaclres *resp =3D rqstp->rq_resp;
> > -     struct posix_acl *acl;
> > +     struct posix_acl *acl =3D NULL, *dacl =3D NULL;
> >       struct inode *inode;
> >       svc_fh *fh;
> >
> > +     resp->acl_access =3D NULL;
> > +     resp->acl_default =3D NULL;
(A) These two lines fix the bug, without other changes needed, I think...
> >       fh =3D fh_copy(&resp->fh, &argp->fh);
> >       resp->status =3D fh_verify(rqstp, &resp->fh, 0, NFSD_MAY_NOP);
> >       if (resp->status !=3D nfs_ok)
> > @@ -56,19 +58,19 @@ static __be32 nfsd3_proc_getacl(struct svc_rqst *rq=
stp)
> >                       resp->status =3D nfserrno(PTR_ERR(acl));
> >                       goto fail;
> >               }
> > -             resp->acl_access =3D acl;
Because you deleted this line...
> >       }
> >       if (resp->mask & (NFS_DFACL|NFS_DFACLCNT)) {
> >               /* Check how Solaris handles requests for the Default ACL
> >                  of a non-directory! */
> > -             acl =3D get_inode_acl(inode, ACL_TYPE_DEFAULT);
> > -             if (IS_ERR(acl)) {
> > -                     resp->status =3D nfserrno(PTR_ERR(acl));
> > +             dacl =3D get_inode_acl(inode, ACL_TYPE_DEFAULT);
> > +             if (IS_ERR(dacl)) {
> > +                     resp->status =3D nfserrno(PTR_ERR(dacl));
> >                       goto fail;
The goto fail here will not release the access acl, if I read the code
correctly.
> >               }
> > -             resp->acl_default =3D acl;
> >       }
> >
> > +     resp->acl_access =3D acl;
> > +     resp->acl_default =3D dacl;
> >       /* resp->acl_{access,default} are released in nfs3svc_release_get=
acl. */
> >   out:
> >       return rpc_success;
>
Actually, all that is needed to fix the bug is adding the two lines
that initialize
them both NUL, I think.. I marked that change (A) above.

rick

