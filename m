Return-Path: <linux-nfs+bounces-14123-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 587CBB48370
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Sep 2025 06:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133EC3AA107
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Sep 2025 04:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E5E1D7995;
	Mon,  8 Sep 2025 04:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhKG8L88"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ACE1386C9
	for <linux-nfs@vger.kernel.org>; Mon,  8 Sep 2025 04:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757307169; cv=none; b=Jgg6E3yCiVxODIXvMy99vNLgLG8taNvqDzzLG7wv7359r8YM2Ys4hu9pyIQTp86nRixUZWZmejH5J1okJBehlW8SiC7A8MD+yz57foT+xhwd29j3antP38pvUG41xPwC9oqNnJMA5v2tAY8MeV3NqUpUmhp+7ACOkMCbSsu/m8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757307169; c=relaxed/simple;
	bh=KqLThtR5K87PbpDqSmKhEF7l3CgcnTr1JeSwrHsUay4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+/EW8JVtgGh4EMIPIvbWOvftOpt2/cVzTRfCrkDHwihJENIhpl6eyV874vtlHbRwHRJO9GBl0aPiTZlhBdG4mYgF6iqKJZoGYJ13xdcnG/2FU8wysWykSRb16f61eqm0xXQv+ecysSHy7kzgJ8JDMZ5QCA14xv5f5FMBb6E5GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhKG8L88; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-80bdff6d1e4so425940485a.3
        for <linux-nfs@vger.kernel.org>; Sun, 07 Sep 2025 21:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757307166; x=1757911966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hBej4Xt4yqcJj9sb+wgQ1uFYSQlBXRBe628vKDOb4A=;
        b=LhKG8L88rlUUHLGr7KVnEHL+l/KxQdCEW3+ojdg23qPUC/4r/zYqw///ILPJh4ZsBy
         tjwTQBzYIEaYkZz01UjvLIOH2EEvfY7c7VMrTbmVWFvz0UdlCZPjPmaOQ9iG9RDjqjqd
         yQwp8+uaDGt+4Yff5i0dt2eFanbrbvKsMuljREyED5I42XiV6Ss6ywxdobydThv4aJK2
         zatH94MGnLkPTyldcZIjrOgqEjscL3AeIMRMGGaNfUt5qbRL1q3/ebTl3dd/9idlUQHL
         eteH9/+ZBuxkCtcOT62U9Qc1Cskq2HzzmHIGXTcBZ0+Yfgl0nR9I2IBmT4blgLRVg8p3
         LXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757307166; x=1757911966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hBej4Xt4yqcJj9sb+wgQ1uFYSQlBXRBe628vKDOb4A=;
        b=fc7rT//79XdM1hjxzLh86YrEfPyMT4hNxmEzGJ0VbwV0nKPWHAI9C304U7tWG/Wf02
         96nSAunxguoQ0B1Eykb9lHz++ChFx2DmQAASd2PvOnPTpoAASnjyEEzI8ZiATB1hqjL2
         TUVrVGHvfRBzTrZyMXwC/xH0DpeZ9yVHVM9EX0vAtMhNQb6spYzWhVMo6KKJI0ONyyKV
         BInCAVn8w259MbeSBqCZMKFhEILiqD9ngsnq5RqpQs371B/TUXAqi8loF0BS6pYSn76O
         zAk1dSQ06D+B1u7zDZwZ2SLhXmLepthvJ+U0yjXzGcfYC3/H8al35ry0+xH54qFOnTC/
         nDCA==
X-Gm-Message-State: AOJu0YyP0ODCIQfNILOZlr8qxzxSln/rLldToikDFGl0onVS7mxCmUNx
	z+X3x4UgUY8cua9N7sqDb7Ejuxp0m64Mli+5T6sWU5ac1FvH9ZSpenS1X6OmG+7a4GS5luLO1Uz
	hz1I3RAdQ8jUpWlorL8LFy5P7lUOeIvc=
X-Gm-Gg: ASbGnct/PqXMVCmXmlfRdpoBFbDByZBgnZov94UKPm/SWHk91/Mc2F72dg9v4wxpRjJ
	NCxaJr7RqD9wAOmZS9yMQOPfRJkoHnuGzhQic43Fq0IaGdCLPPLL6xkT6R/uGoOLTy1qle5JbMl
	VhgTKoXBiQZ56UOnOSeLoY1MPp7rAqNN93qLoq1bHr1pUm8tyikELQNTqcSO+7pbbhdNx3APieZ
	DG7T9Fc4yJieXZgPsI=
X-Google-Smtp-Source: AGHT+IHqpk8RQY2PNDmnOh6ckN3l+O7FkYcI8rorX51HlhPbCnjGqgQ/SqpQAktJu0p8/BcH92kjt6vvK/fUm9orRUc=
X-Received: by 2002:a05:620a:7089:b0:816:3bf9:69ec with SMTP id
 af79cd13be357-8163bf96be6mr385758985a.24.1757307165819; Sun, 07 Sep 2025
 21:52:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902183035.2059893-1-yanghh@gmail.com> <536a67e83ef5b89217c9eaf315e5f24eb6a8b59e.camel@kernel.org>
In-Reply-To: <536a67e83ef5b89217c9eaf315e5f24eb6a8b59e.camel@kernel.org>
From: Haihua Yang <yanghh@gmail.com>
Date: Sun, 7 Sep 2025 21:52:36 -0700
X-Gm-Features: Ac12FXzfBN7YcQBffmDkmmlv51t5IMYh1CbVEnCFjrbeqsbcEWXrKPNusLW7cE8
Message-ID: <CALzt5PnTbKcrCpVG4r4=1TUV6EqCWio4ndCFhi9C04W1-yhUZA@mail.gmail.com>
Subject: Re: [PATCH] draft patches to fixes LAYOUTCOMMIT related issues
To: Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Trond,
Thanks for your comments. In this change, I also tried to make
LAYOUTCOMMIT call nfs4_layout_refresh_old_stateid to update the
stateid when receiving NFS4ERR_OLD_STATEID. However, the update is
skipped because pnfs_mark_matching_lsegs_return returns -EBUSY. I=E2=80=99m
wondering why the stateid update is skipped in this case, and what the
impact would be if we ignored the -EBUSY error and proceeded with the
update.
Thanks,

On Tue, Sep 2, 2025 at 2:09=E2=80=AFPM Trond Myklebust <trondmy@kernel.org>=
 wrote:
>
> On Tue, 2025-09-02 at 18:30 +0000, Haihua Yang wrote:
> > [You don't often get email from yanghh@gmail.com. Learn why this is
> > important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > 1, fix an issue that client may send LAYOUTRETURN before LAYOUTCOMMIT
> > 2, update layout stateid when layoutcommit receiving
> > NFS4ERR_OLD_STATEID
>
> Please read Documentation/process/submitting-patches.rst
> Specifically, please read the section "Describe your changes"
> carefully.
>
> > ---
> >  fs/nfs/callback_proc.c |  2 +-
> >  fs/nfs/nfs4proc.c      | 10 +++++++++-
> >  fs/nfs/pnfs.c          | 28 +++++++++++++++++-----------
> >  fs/nfs/pnfs.h          |  2 +-
> >  4 files changed, 28 insertions(+), 14 deletions(-)
> >
> > diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
> > index 8397c43358bd..1e6e4a7a3f15 100644
> > --- a/fs/nfs/callback_proc.c
> > +++ b/fs/nfs/callback_proc.c
> > @@ -287,7 +287,7 @@ static u32 initiate_file_draining(struct
> > nfs_client *clp,
> >         pnfs_set_layout_stateid(lo, &args->cbl_stateid, NULL, true);
> >         switch (pnfs_mark_matching_lsegs_return(lo, &free_me_list,
> >                                 &args->cbl_range,
> > -                               be32_to_cpu(args-
> > >cbl_stateid.seqid))) {
> > +                               be32_to_cpu(args->cbl_stateid.seqid),
> > true)) {
> >         case 0:
> >         case -EBUSY:
> >                 /* There are layout segments that need to be returned
> > */
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index 7d2b67e06cc3..46a1bc1f31ee 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -10255,6 +10255,7 @@ nfs4_layoutcommit_done(struct rpc_task *task,
> > void *calldata)
> >  {
> >         struct nfs4_layoutcommit_data *data =3D calldata;
> >         struct nfs_server *server =3D NFS_SERVER(data->args.inode);
> > +       struct pnfs_layout_range dst_range;
> >
> >         if (!nfs41_sequence_done(task, &data->res.seq_res))
> >                 return;
> > @@ -10268,6 +10269,13 @@ nfs4_layoutcommit_done(struct rpc_task
> > *task, void *calldata)
> >                 break;
> >         case 0:
> >                 break;
> > +       case -NFS4ERR_OLD_STATEID:
> > +               if (data->inode) {
> > +                       nfs4_layout_refresh_old_stateid(&data-
> > >args.stateid,
> > +                                       &dst_range,
> > +                                       data->inode);
> > +               }
> > +               fallthrough;
> >         default:
> >                 if (nfs4_async_handle_error(task, server, NULL, NULL)
> > =3D=3D -EAGAIN) {
> >                         rpc_restart_call_prepare(task);
> > @@ -10319,8 +10327,8 @@ nfs4_proc_layoutcommit(struct
> > nfs4_layoutcommit_data *data, bool sync)
> >                 data->args.lastbytewritten,
> >                 data->args.inode->i_ino);
> >
> > +       data->inode =3D nfs_igrab_and_active(data->args.inode);
> >         if (!sync) {
> > -               data->inode =3D nfs_igrab_and_active(data->args.inode);
> >                 if (data->inode =3D=3D NULL) {
> >                         nfs4_layoutcommit_release(data);
> >                         return -EAGAIN;
> > diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
> > index a3135b5af7ee..aaa3719b1957 100644
> > --- a/fs/nfs/pnfs.c
> > +++ b/fs/nfs/pnfs.c
> > @@ -432,7 +432,7 @@ bool nfs4_layout_refresh_old_stateid(nfs4_stateid
> > *dst,
> >                         goto out;
> >                 }
> >                 /* Try to update the seqid to the most recent */
> > -               err =3D pnfs_mark_matching_lsegs_return(lo, &head,
> > &range, 0);
> > +               err =3D pnfs_mark_matching_lsegs_return(lo, &head,
> > &range, 0, true);
> >                 if (err !=3D -EBUSY) {
> >                         dst->seqid =3D lo->plh_stateid.seqid;
> >                         *dst_range =3D range;
> > @@ -484,7 +484,7 @@ static int pnfs_mark_layout_stateid_return(struct
> > pnfs_layout_hdr *lo,
> >                 .length =3D NFS4_MAX_UINT64,
> >         };
> >
> > -       return pnfs_mark_matching_lsegs_return(lo, lseg_list, &range,
> > seq);
> > +       return pnfs_mark_matching_lsegs_return(lo, lseg_list, &range,
> > seq, false);
> >  }
> >
> >  static int
> > @@ -522,7 +522,7 @@ pnfs_layout_io_set_failed(struct pnfs_layout_hdr
> > *lo, u32 iomode)
> >
> >         spin_lock(&inode->i_lock);
> >         pnfs_layout_set_fail_bit(lo,
> > pnfs_iomode_to_fail_bit(iomode));
> > -       pnfs_mark_matching_lsegs_return(lo, &head, &range, 0);
> > +       pnfs_mark_matching_lsegs_return(lo, &head, &range, 0, false);
> >         spin_unlock(&inode->i_lock);
> >         pnfs_free_lseg_list(&head);
> >         dprintk("%s Setting layout IOMODE_%s fail bit\n", __func__,
> > @@ -1459,7 +1459,7 @@ _pnfs_return_layout(struct inode *ino)
> >         }
> >         valid_layout =3D pnfs_layout_is_valid(lo);
> >         pnfs_clear_layoutcommit(ino, &tmp_list);
> > -       pnfs_mark_matching_lsegs_return(lo, &tmp_list, &range, 0);
> > +       pnfs_mark_matching_lsegs_return(lo, &tmp_list, &range, 0,
> > false);
> >
> >         if (NFS_SERVER(ino)->pnfs_curr_ld->return_range)
> >                 NFS_SERVER(ino)->pnfs_curr_ld->return_range(lo,
> > &range);
> > @@ -2583,7 +2583,7 @@ pnfs_layout_process(struct nfs4_layoutget *lgp)
> >                         .iomode =3D IOMODE_ANY,
> >                         .length =3D NFS4_MAX_UINT64,
> >                 };
> > -               pnfs_mark_matching_lsegs_return(lo, &free_me, &range,
> > 0);
> > +               pnfs_mark_matching_lsegs_return(lo, &free_me, &range,
> > 0, false);
> >                 goto out_forget;
> >         } else {
> >                 /* We have a completely new layout */
> > @@ -2628,7 +2628,7 @@ int
> >  pnfs_mark_matching_lsegs_return(struct pnfs_layout_hdr *lo,
> >                                 struct list_head *tmp_list,
> >                                 const struct pnfs_layout_range
> > *return_range,
> > -                               u32 seq)
> > +                               u32 seq, bool committing)
> >  {
> >         struct pnfs_layout_segment *lseg, *next;
> >         struct nfs_server *server =3D NFS_SERVER(lo->plh_inode);
> > @@ -2658,12 +2658,18 @@ pnfs_mark_matching_lsegs_return(struct
> > pnfs_layout_hdr *lo,
> >                 }
> >
> >         if (remaining) {
> > -               pnfs_set_plh_return_info(lo, return_range->iomode,
> > seq);
> > -               return -EBUSY;
> > +               if (!committing) {
> > +                       pnfs_set_plh_return_info(lo, return_range-
> > >iomode, seq);
> > +                       return -EBUSY;
> > +               } else {
> > +                       return 0;
> > +               }
>
> NACK.
>
> This change would mean that we can have layout segments on the list lo-
> >plh_return_segs without even the NFS_LAYOUT_RETURN_REQUESTED flag
> being set.
>
> It also badly breaks pnfs_layout_need_return().
>
> I see no reason why we should need to add this 'committing' flag
> argument to pnfs_mark_matching_lsegs_return(). I suggest rather
> modifying pnfs_prepare_layoutreturn() to check for
> pnfs_layoutcommit_outstanding().
>
> >         }
> >
> >         if (!list_empty(&lo->plh_return_segs)) {
> > -               pnfs_set_plh_return_info(lo, return_range->iomode,
> > seq);
> > +               if (!committing) {
> > +                       pnfs_set_plh_return_info(lo, return_range-
> > >iomode, seq);
> > +               }
> >                 return 0;
> >         }
> >
> > @@ -2689,7 +2695,7 @@ pnfs_mark_layout_for_return(struct inode
> > *inode,
> >          * segments at hand when sending layoutreturn. See
> > pnfs_put_lseg()
> >          * for how it works.
> >          */
> > -       if (pnfs_mark_matching_lsegs_return(lo, &lo->plh_return_segs,
> > range, 0) !=3D -EBUSY) {
> > +       if (pnfs_mark_matching_lsegs_return(lo, &lo->plh_return_segs,
> > range, 0, false) !=3D -EBUSY) {
> >                 const struct cred *cred;
> >                 nfs4_stateid stateid;
> >                 enum pnfs_iomode iomode;
> > @@ -2804,7 +2810,7 @@ static int
> > pnfs_layout_return_unused_byserver(struct nfs_server *server,
> >                 pnfs_get_layout_hdr(lo);
> >                 pnfs_set_plh_return_info(lo, range->iomode, 0);
> >                 if (pnfs_mark_matching_lsegs_return(lo, &lo-
> > >plh_return_segs,
> > -                                                   range, 0) !=3D 0 ||
> > +                                                   range, 0, false)
> > !=3D 0 ||
> >                     !pnfs_prepare_layoutreturn(lo, &stateid, &cred,
> > &iomode)) {
> >                         spin_unlock(&inode->i_lock);
> >                         rcu_read_unlock();
> > diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
> > index 91ff877185c8..33a7a09477b2 100644
> > --- a/fs/nfs/pnfs.h
> > +++ b/fs/nfs/pnfs.h
> > @@ -300,7 +300,7 @@ int pnfs_mark_matching_lsegs_invalid(struct
> > pnfs_layout_hdr *lo,
> >  int pnfs_mark_matching_lsegs_return(struct pnfs_layout_hdr *lo,
> >                                 struct list_head *tmp_list,
> >                                 const struct pnfs_layout_range
> > *recall_range,
> > -                               u32 seq);
> > +                               u32 seq, bool committing);
> >  int pnfs_mark_layout_stateid_invalid(struct pnfs_layout_hdr *lo,
> >                 struct list_head *lseg_list);
> >  bool pnfs_roc(struct inode *ino,
> > --
> > 2.51.0.87.g1fa68948c3.dirty
> >
>    A.
> --
> Trond Myklebust Linux NFS client maintainer, Hammerspace
> trondmy@kernel.org, trond.myklebust@hammerspace.com

