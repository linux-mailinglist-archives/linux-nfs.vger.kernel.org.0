Return-Path: <linux-nfs+bounces-13997-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322EEB411FD
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 03:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B1B560B26
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 01:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688271A76DA;
	Wed,  3 Sep 2025 01:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZyLvBkV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A91FE555
	for <linux-nfs@vger.kernel.org>; Wed,  3 Sep 2025 01:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756863481; cv=none; b=nmrN28qsqyKKZsFoVITYiZCB/k74shwodtMpOBgu8qypSc1enzjJJn3zc7X3pQubAZTT9khFLGI3t3mhAMr218qrsrlUFpbSO/VlNeChl7BrnH+h/9kKVJtrQ8zRZh+/Dv7oQUUolmJD3eXOptTGg/sSuJ5hc8a+NBhWyixj5rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756863481; c=relaxed/simple;
	bh=UbsxYs5VmKpZJw9NWAvdlhyJx3Vzw3jySiRG8Ysmyec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tV9FHUKo0/K0Cgyoc5Ykv2HI9zO9khZR4wStHIochYP5BPdkr/pNAP33iH0F9J2WJ/qSq5LK0Hnkn/sKkX6JtVA2EHMv10qFxLX3rEUA2bX8zL+CkHJHBoXneBPjUcoHTjXrRi6UyRjq8yBF+UtMbaO++/ekfHkBn5MhmHve7P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZyLvBkV; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61d143aa4acso5882886a12.2
        for <linux-nfs@vger.kernel.org>; Tue, 02 Sep 2025 18:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756863478; x=1757468278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3rK0VX2pn4r7QCCuvuJZ3ZX3tPwzrUk4mIDH1gHFGE=;
        b=TZyLvBkVuYDXPbUuRjUx9DcnKQLqkncJ6O0+N56j3TlIAgChiSWNXHq/V90QAzVSkp
         UgCKAHYzD8vsHrP67dSWlCGqHkxv2dq6baQLqXsw4MYkKLqPEHlr8ynoMyiP6PKAjh+h
         jRIpDTYbhZAJPh6DKrSe3SX4JfcdcBVe0bKs5/t9YusWr5l1GTz0GBzDA1QtQ/WzM/Ak
         OtSfrBv3J5/qFELdEAJ6JIhbMc004k+B4x85ZrpIn73GIPxxuCvIBZu59OBOGXFD0lcq
         paANSeP5dw6qnw2Q8MByiLrlBH4c51F3BHfWRP7SmFYd2dyUeFitl1/MgdAuQrJjbZx/
         Rlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756863478; x=1757468278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3rK0VX2pn4r7QCCuvuJZ3ZX3tPwzrUk4mIDH1gHFGE=;
        b=nqdQRbgZH8d/d4qEw9FvwYFYyl43SlBH6QpMNJcuwrMUx48nNyTMELWZmL8D5XHvhB
         PjbQ5CEMM2+NgBKtT6Y6jb65zBDZswic4Nc9RJaAQPXE/vubkvMDK4Gu683kLJy6TEX3
         WwNe7HMAzSBUZxAyFmr2S74sxRzBW7Quicfq2eMRNyUiJhl/Da9N0o2aearzz9coTpg+
         cN8pzmDIwzNucWN/8EwVgXdjmDxhmWbTae/ksxR/9pEgWOflVroXfGmghA0/0/YSfHGi
         tgDUckX8lUPJZF4V2KI13MqMLwBHwaStpfuoePjpD5ZFUzxoeZWpvMuV2Pp1StpvMcp8
         kGLw==
X-Forwarded-Encrypted: i=1; AJvYcCX7qNwM+N6MuHnRzfifHesJfwDyG+sWV55wZFR156xuXeMnsBkzbNOzJ9PMgc5A0cHLc1reLMoTUYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx/oQVzdCIKDZZCOwCX5hoxWj8ZtD1xGmSTb1oR+w+vmxhuytc
	yIW7QL/j0/q/0lwRJ0yarQeaDfm/OpOvC8asGXhMt44R0jc3VB/e6kixQVTV1np9tlLgkzGOJYA
	fov4mlH65LNedOw0LnxT8dA6cfovo/g==
X-Gm-Gg: ASbGncvgVpi4v8zHVmI5ZcxJyMDMKh3Ow+5Z1Ez4krGuurXBlKCoJu313W/53KJOR5X
	ZLsYDx/iwgwicaRIdkwqHMI2Q9ftGQVasIxVrajP6u79Ynonf423DylJ3rLfBgjpki5ChUCmPak
	jTRGG5bUZB6OyyiePEVRTHGFQPE/mJAB4q0iNyKPPKMYOgfoKKohOXWZ32dGI345b6ruEpQDdCF
	g9m/lDfZiHZuThxI4qdRHF5HHVRk8cnyPDvBgLrkozE6tTdZchUoRLxgmYf
X-Google-Smtp-Source: AGHT+IHZ6VgrtBzh7xG/+0M7bo2NLUsMG2SmBkEqhSGOk7JacWFSrFQPkCwNhD+4AockB0ItW8e6EVKpV/B4h6QGjG4=
X-Received: by 2002:a05:6402:44c2:b0:61c:c034:ba0 with SMTP id
 4fb4d7f45d1cf-61d26fe5e5fmr11153881a12.26.1756863477576; Tue, 02 Sep 2025
 18:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902181950.2057363-1-yanghh@gmail.com> <535288ce066121be20b7c76842eb3e84d25b9d16.camel@hammerspace.com>
 <CALzt5P=QYq9W3HOjsNvHONuqm0z63kUK_EvvkfhUEcOne8zokw@mail.gmail.com>
In-Reply-To: <CALzt5P=QYq9W3HOjsNvHONuqm0z63kUK_EvvkfhUEcOne8zokw@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Tue, 2 Sep 2025 18:37:46 -0700
X-Gm-Features: Ac12FXxDZUoToK63k1-YXzPO5OSxkEE3rdtAxM60Ux80NgjTiIWUx830-og8msI
Message-ID: <CAM5tNy4wG5k2=sgZQ0MgJTpJ6g-ycQcv04A88zi9F6i8AKoJ1A@mail.gmail.com>
Subject: Re: [PATCH] add force_layoutcommit param
To: Haihua Yang <yanghh@gmail.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 3:58=E2=80=AFPM Haihua Yang <yanghh@gmail.com> wrote=
:
>
> Trond,
> Thanks for reviewing the change. I understand that, logically, if a
> WRITE is FILE_SYNC, a LAYOUTCOMMIT isn=E2=80=99t necessary. I=E2=80=99m w=
orking on
> enabling file_layout on some legacy POSIX filesystems, where
> synchronizing metadata between the MDS and DS during client writes to
> the DS incurs significant overhead. To address this, I=E2=80=99m suggesti=
ng an
> option that allows the MDS to update the metadata. From my reading,
> RFC8881 doesn=E2=80=99t seem to prohibit LAYOUTCOMMIT in this scenario, c=
ould
> you share more detail about how it would break the FILE_SYNC case?
If you look at this email thread that was on nfsv4@ietf.org in 2019, you'll
see some discussion of this. I do not believe there was an agreement that
the client do a LAYOUTCOMMIT for this case. (You'll see I discovered what
I believe you have discovered.)

https://mailarchive.ietf.org/arch/msg/nfsv4/eQNilayKCMA43RbzjjuttjdBZ7Q/

rick

> Thanks
> Haihua
>
> On Tue, Sep 2, 2025 at 2:18=E2=80=AFPM Trond Myklebust <trondmy@hammerspa=
ce.com> wrote:
> >
> > On Tue, 2025-09-02 at 18:19 +0000, Haihua Yang wrote:
> > > [You don't often get email from yanghh@gmail.com. Learn why this is
> > > important at https://aka.ms/LearnAboutSenderIdentification ]
> > >
> > > ---
> > >  fs/nfs/filelayout/filelayout.c | 12 +++++++++---
> > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/fs/nfs/filelayout/filelayout.c
> > > b/fs/nfs/filelayout/filelayout.c
> > > index d39a1f58e18d..1cb8f413a665 100644
> > > --- a/fs/nfs/filelayout/filelayout.c
> > > +++ b/fs/nfs/filelayout/filelayout.c
> > > @@ -48,6 +48,8 @@ MODULE_LICENSE("GPL");
> > >  MODULE_AUTHOR("Dean Hildebrand <dhildebz@umich.edu>");
> > >  MODULE_DESCRIPTION("The NFSv4 file layout driver");
> > >
> > > +static bool force_layoutcommit =3D false;
> > > +
> > >  #define FILELAYOUT_POLL_RETRY_MAX     (15*HZ)
> > >  static const struct pnfs_commit_ops filelayout_commit_ops;
> > >
> > > @@ -233,10 +235,11 @@ filelayout_set_layoutcommit(struct
> > > nfs_pgio_header *hdr)
> > >  {
> > >         loff_t end_offs =3D 0;
> > >
> > > -       if (FILELAYOUT_LSEG(hdr->lseg)->commit_through_mds ||
> > > -           hdr->res.verf->committed =3D=3D NFS_FILE_SYNC)
> > > +       if (!force_layoutcommit && (FILELAYOUT_LSEG(hdr->lseg)-
> > > >commit_through_mds ||
> > > +           hdr->res.verf->committed =3D=3D NFS_FILE_SYNC))
> > >                 return;
> > > -       if (hdr->res.verf->committed =3D=3D NFS_DATA_SYNC)
> > > +       if (hdr->res.verf->committed =3D=3D NFS_DATA_SYNC ||
> > > +           (force_layoutcommit && hdr->res.verf->committed =3D=3D
> > > NFS_FILE_SYNC))
> > >                 end_offs =3D hdr->mds_offset + (loff_t)hdr->res.count=
;
> > >
> > >         /* Note: if the write is unstable, don't set end_offs until
> > > commit */
> > > @@ -1149,5 +1152,8 @@ static void __exit nfs4filelayout_exit(void)
> > >
> > >  MODULE_ALIAS("nfs-layouttype4-1");
> > >
> > > +module_param(force_layoutcommit, bool, 0644);
> > > +MODULE_PARM_DESC(force_layoutcommit, "Force LAYOUTCOMMIT after data
> > > was written (default: false)");
> > > +
> > >  module_init(nfs4filelayout_init);
> > >  module_exit(nfs4filelayout_exit);
> > > --
> > > 2.51.0.87.g1fa68948c3.dirty
> > >
> >
> > NACK.
> >
> > Firstly, there is no documentation that tells either me or any
> > pnfs/files user when it would be desirable to set this flag. There
> > isn't even a reference to what problem in RFC8881 it addresses.
> >
> > Secondly, it breaks the NFS_FILE_SYNC case.
> >
> > --
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trondmy@kernel.org, trond.myklebust@hammerspace.com
>

