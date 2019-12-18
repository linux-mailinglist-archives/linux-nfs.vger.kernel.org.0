Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21F6F1254AA
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2019 22:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfLRVbP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Dec 2019 16:31:15 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45767 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfLRVbP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Dec 2019 16:31:15 -0500
Received: by mail-vs1-f68.google.com with SMTP id b4so1938464vsa.12
        for <linux-nfs@vger.kernel.org>; Wed, 18 Dec 2019 13:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GjygTSniHBQr3/HgOSYLqlZH584cF88Vl7qjpgZFbcc=;
        b=R9TX56Qc6C0G1HPGO7W+AsxF7SoIRPb5YAZaFFxXbhYFvAjJiz8kfTZAHPwdU5lsTx
         mlzzjOKkaVBQzHwypS6VZLZZ+9cbciMPsRUSgrjLLtLTaKZiMr2T28UC8ipxlgJeQ4o2
         mKyA8fsDp5ihMhVflHNaxmdGtlSyY5PP4IqL7iRZG2gJUChmnx7Cl5aIjpfkTYa2DJwy
         FO7OHYVUGJrtVbF9gXZg4bjF34aigq/g8JCLT0wv1zpn37xMvR839rz1RBDcBXMfD1ie
         jssYc03zjXk/7mdvfr67WJtZ8694p58rPVSF5asXB7Pjsmbrev8nKnnE6sfHZLnl1sd/
         TvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GjygTSniHBQr3/HgOSYLqlZH584cF88Vl7qjpgZFbcc=;
        b=n89d+DrKstd7EEOBD7Rd5g22aG2vqRdMnrvdGYge7rui1D1KeWiUctk8XEls3mdfWk
         CI4mtX1xh9Sb/HnNlzbyWTvGruJBT5uDBpkeoEQLRlX/r1UlITU1jm+B1Ba8UBYStDzD
         GeM5nVoFufdW6hNCDjCdBDLAy+i2PIUXB8GgITkX/OJyT4fvqpYjufNW5vCFVRlL6rhB
         5OVgjlUOH5Bfo/aGeVHV1J9Ln1doR7MfBHO5rZpSxyGlzU+QGhLYqfAo148y3mctr57J
         5vqkTE6WWfUyfM0Q1WDiESbwYG3IIuycalQiVeothD9t2Gtsot9ZCEptHaW1ANu9MOeJ
         1Ptg==
X-Gm-Message-State: APjAAAV8mGYX/ksbr8eCZlWqv5ItYqDrnv8b9qkcs+BDio07mF7KPYaB
        wm7chNmwrfy+l3H1gzy4nftYpbu5h5e0YD2TB2s=
X-Google-Smtp-Source: APXvYqwinesHiJxbwk0nyJHVaC/Ag+syL1tMZFPp3RJ4ml/hGY5VCV9QckZNgoj5my9tqvQ47dAmkvWhZ06739hINKI=
X-Received: by 2002:a05:6102:7a4:: with SMTP id x4mr2936898vsg.85.1576704674228;
 Wed, 18 Dec 2019 13:31:14 -0800 (PST)
MIME-Version: 1.0
References: <20191218211327.30362-1-olga.kornievskaia@gmail.com> <e7a2973e-f4bc-a0b4-537d-49857c8b9e03@oracle.com>
In-Reply-To: <e7a2973e-f4bc-a0b4-537d-49857c8b9e03@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 18 Dec 2019 16:31:03 -0500
Message-ID: <CAN-5tyFkVHzQ4EYzrE8hvFiBegP8gzWyfc1icxtVuUBu8OVOiA@mail.gmail.com>
Subject: Re: [PATCH v2] NFSv4.x recover from pre-mature loss of openstateid
To:     Calum Mackay <calum.mackay@oracle.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Dec 18, 2019 at 4:25 PM Calum Mackay <calum.mackay@oracle.com> wrot=
e:
>
> hi Olga=E2=80=A6
>
> On 18/12/2019 9:13 pm, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > Ever since the commit 0e0cb35b417f, it's possible to lose an open state=
id
> > while retrying a CLOSE due to ERR_OLD_STATEID. Once that happens,
> > operations that require openstateid fail with EAGAIN which is propagate=
d
> > to the application then tests like generic/446 and generic/168 fail wit=
h
> > "Resource temporarily unavailable".
> >
> > Instead of returning this error, initiate state recovery when possible =
to
> > recover the open stateid and then try calling nfs4_select_rw_stateid()
> > again.
> >
> > Fixes: 0e0cb35b417f ("NFSv4: Handle NFS4ERR_OLD_STATEID in CLOSE/OPEN_D=
OWNGRADE")
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >   fs/nfs/nfs42proc.c | 36 ++++++++++++++++++++++++++++--------
> >   fs/nfs/nfs4proc.c  |  2 ++
> >   fs/nfs/pnfs.c      |  2 +-
> >   3 files changed, 31 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > index 1fe83e0f663e..9637aad36bdc 100644
> > --- a/fs/nfs/nfs42proc.c
> > +++ b/fs/nfs/nfs42proc.c
> > @@ -61,8 +61,11 @@ static int _nfs42_proc_fallocate(struct rpc_message =
*msg, struct file *filep,
> >
> >       status =3D nfs4_set_rw_stateid(&args.falloc_stateid, lock->open_c=
ontext,
> >                       lock, FMODE_WRITE);
> > -     if (status)
> > +     if (status) {
> > +             if (status =3D=3D -EAGAIN)
> > +                     status =3D -NFS4ERR_BAD_STATEID;
> >               return status;
> > +     }
> >
> >       res.falloc_fattr =3D nfs_alloc_fattr();
> >       if (!res.falloc_fattr)
> > @@ -287,8 +290,11 @@ static ssize_t _nfs42_proc_copy(struct file *src,
> >       } else {
> >               status =3D nfs4_set_rw_stateid(&args->src_stateid,
> >                               src_lock->open_context, src_lock, FMODE_R=
EAD);
> > -             if (status)
> > +             if (status) {
> > +                     if (status =3D=3D -EAGAIN)
> > +                             status =3D -NFS4ERR_BAD_STATEID;
> >                       return status;
> > +             }
> >       }
> >       status =3D nfs_filemap_write_and_wait_range(file_inode(src)->i_ma=
pping,
> >                       pos_src, pos_src + (loff_t)count - 1);
> > @@ -297,8 +303,11 @@ static ssize_t _nfs42_proc_copy(struct file *src,
> >
> >       status =3D nfs4_set_rw_stateid(&args->dst_stateid, dst_lock->open=
_context,
> >                                    dst_lock, FMODE_WRITE);
> > -     if (status)
> > +     if (status) {
> > +             if (status =3D=3D -EAGAIN)
> > +                     status =3D -NFS4ERR_BAD_STATEID;
> >               return status;
> > +     }
> >
> >       status =3D nfs_sync_inode(dst_inode);
> >       if (status)
> > @@ -546,8 +555,11 @@ static int _nfs42_proc_copy_notify(struct file *sr=
c, struct file *dst,
> >       status =3D nfs4_set_rw_stateid(&args->cna_src_stateid, ctx, l_ctx=
,
> >                                    FMODE_READ);
> >       nfs_put_lock_context(l_ctx);
> > -     if (status)
> > +     if (status) {
> > +             if (status =3D=3D -EAGAIN)
> > +                     status =3D -NFS4ERR_BAD_STATEID;
> >               return status;
> > +     }
> >
> >       status =3D nfs4_call_sync(src_server->client, src_server, &msg,
> >                               &args->cna_seq_args, &res->cnr_seq_res, 0=
);
> > @@ -618,8 +630,11 @@ static loff_t _nfs42_proc_llseek(struct file *file=
p,
> >
> >       status =3D nfs4_set_rw_stateid(&args.sa_stateid, lock->open_conte=
xt,
> >                       lock, FMODE_READ);
> > -     if (status)
> > +     if (status) {
> > +             if (status =3D=3D -EAGAIN)
> > +                     status =3D -NFS4ERR_BAD_STATEID;
> >               return status;
> > +     }
> >
> >       status =3D nfs_filemap_write_and_wait_range(inode->i_mapping,
> >                       offset, LLONG_MAX);
> > @@ -994,13 +1009,18 @@ static int _nfs42_proc_clone(struct rpc_message =
*msg, struct file *src_f,
> >
> >       status =3D nfs4_set_rw_stateid(&args.src_stateid, src_lock->open_=
context,
> >                       src_lock, FMODE_READ);
> > -     if (status)
> > +     if (status) {
> > +             if (status =3D=3D -EAGAIN)
> > +                     status =3D -NFS4ERR_BAD_STATEID;
> >               return status;
> > -
> > +     }
> >       status =3D nfs4_set_rw_stateid(&args.dst_stateid, dst_lock->open_=
context,
> >                       dst_lock, FMODE_WRITE);
> > -     if (status)
> > +     if (status) {
> > +             if (status =3D=3D -EAGAIN)
> > +                     status =3D -NFS4ERR_BAD_STATEID;
> >               return status;
> > +     }
> >
> >       res.dst_fattr =3D nfs_alloc_fattr();
> >       if (!res.dst_fattr)
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index 76d37161409a..f9bb4b43a519 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -3239,6 +3239,8 @@ static int _nfs4_do_setattr(struct inode *inode,
> >               nfs_put_lock_context(l_ctx);
> >               if (status =3D=3D -EIO)
> >                       return -EBADF;
> > +             else if (status =3D=3D -EAGAIN)
> > +                     goto zero_stateid;
> >       } else {
> >   zero_stateid:
> >               nfs4_stateid_copy(&arg->stateid, &zero_stateid);
> > diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
> > index cec3070ab577..fc36a60bf4ec 100644
> > --- a/fs/nfs/pnfs.c
> > +++ b/fs/nfs/pnfs.c
> > @@ -1998,7 +1998,7 @@ pnfs_update_layout(struct inode *ino,
> >                       trace_pnfs_update_layout(ino, pos, count,
> >                                       iomode, lo, lseg,
> >                                       PNFS_UPDATE_LAYOUT_INVALID_OPEN);
> > -                     if (status !=3D -EAGAIN)
> > +                     if (status !=3D -EAGAIN && status !=3D -EAGAIN)
>
> that doesn't look quite right?

*face palm* thanks. Will fix that.

>
> >                               goto out_unlock;
> >                       spin_unlock(&ino->i_lock);
> >                       nfs4_schedule_stateid_recovery(server, ctx->state=
);
> >
>
>
