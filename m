Return-Path: <linux-nfs+bounces-13994-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E21B41066
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 00:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5FE1B61752
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 22:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB96279359;
	Tue,  2 Sep 2025 22:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFM79d1X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9688F221F17
	for <linux-nfs@vger.kernel.org>; Tue,  2 Sep 2025 22:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756853878; cv=none; b=aflfa2Y9BrkFqcNhuLrm61kPSx/Bg1sIW+vMy3tOcoNq6MP5d/qLg2eH/QFzTbVlz6vQvOxlVYz0+dHuN1UI1G7E4OY2+wJtg0I6EJk/bCz1faF8P7Irl+qLJSIzvOMOJjWSw8QPos67INHQIEVY4w3K7oNMrREByLRiDg702kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756853878; c=relaxed/simple;
	bh=Q75Ooy3HYRQiWCSUm1MLxqvTVsF5MHYrfm58WN5WyNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elenH+gS4onK048ZLHLgA0+j2NwKBIy5xQ7LxK/zXl1kvpGoDaYYl8f4DfJgENyMNF4vaNGZw3RX0ZU62rVHoegwpuPI1Pw4cP9H0YWBEG+APB/GdluiAATC+DHQU7JqbxSEFXmWYsXQLSbb9PYpiBW4wUIPtOPLcz75IfvuSQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFM79d1X; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b30d24f686so2507081cf.1
        for <linux-nfs@vger.kernel.org>; Tue, 02 Sep 2025 15:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756853875; x=1757458675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1WIbcjZ9yEZNHc76ZCxcWuz7aWynCGJ65aypfyi5N8=;
        b=XFM79d1XimPqPAWkjwKSo64GV4h7TAoOJK1JEkXKwPaBzlHLzLsjncYXYEdHMDtD7l
         kSKKyIVARMDcv8WzCjJOpVdNnowyHue8ELAIK4EtJq4DRfpXrhBRY61bERrBWxEbQL8b
         L7lo/oz583sqZ+m7hnFcqbZyq4ggoqYs+2v/VFXxAAivVC9RR3BMQqda1J608YpRM3Ul
         zCdaaq69WJwrrwYLJFLX93lmnZg5XlqsU0yaIJXRTBa5Wc0OtBmuRbuwvVsFO6DPDkcv
         GZxsMMACrBLoagIIGrVOJ99GcqV/LCoSDKaFUgR34H1O2xAK/eaK9cZkBmYAnacPBBK+
         R5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756853875; x=1757458675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1WIbcjZ9yEZNHc76ZCxcWuz7aWynCGJ65aypfyi5N8=;
        b=M8uKvNtp7sMG3bJn+tAbKk0f++BCj1LjJUeDzAwsx/ywUsnuRhcfKisZY60xN6OD63
         Uf/HkRFf+z8U6+D9w3+jdx/SUtcTyOR3G0KrC7xNiRdxVt4dTVtYJR8gKoIt0W0j3D97
         sDlqW5iBAeUoqmN9/WIBvyAvmqRlmeWqxXXnKiZ9HS32aC6zyBcX/sUYLYV50dWZwZDX
         sCd15MDKrbWv7yG/+VMhgXpSNQEC/PQ7MuW97DvkgIDTI+zUIlDAxbE1fKTOwC78+jbe
         Xbnf4EpNSEw5ZySjsQN4Fnmv9AXamRhI6RMN88ruF2ynl0vgZNhMspAm3XtYSMVx6uW0
         KeNA==
X-Gm-Message-State: AOJu0YzjEubreFo/MFbD2Lwp12oUgJSLnnvBrrx6hQBEI8J92wsBpRb0
	E2Jl7oiOxOwL8vuN/UnwM2iwzaw/muq5qDwUuWQA8BJpv/QExbZYnO90hhqUFrxPtRbWOlpaToD
	cc6OQSqumTJlzsKadBNrlDBW7SPkkV0EEstTE
X-Gm-Gg: ASbGncsCwhdFwIIGVtONOadn4lmDzpUhjOEcfNjY6kxot/x0AHErSqPcwnWI+Mury6B
	f/qMTmrxFt3jebZZNFZaHCxf6EqW916BZC3kkC/1JlyI1fP70OImX/yibQ2t9nejnIFbWEH2RS1
	AhFHEsFHYk5H3mD9xbBKyI0rT9PAdv3jC/2lErmu3he6gC5mcMHvBPr6vgyaGI6TH70Imc3tDKW
	mfcYsA9VJzrXLmUigM=
X-Google-Smtp-Source: AGHT+IHxV4ejI43lGgglTlk+DPzf+/XmxYIwKBS5SQVoB10gkJn3k18lUIHMpIXfSU4q9k5WQVjenDZhMrYx+5Jisa4=
X-Received: by 2002:a05:622a:2a13:b0:4b4:3dbf:985f with SMTP id
 d75a77b69052e-4b43dbf9be5mr26135141cf.65.1756853875378; Tue, 02 Sep 2025
 15:57:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902181950.2057363-1-yanghh@gmail.com> <535288ce066121be20b7c76842eb3e84d25b9d16.camel@hammerspace.com>
In-Reply-To: <535288ce066121be20b7c76842eb3e84d25b9d16.camel@hammerspace.com>
From: Haihua Yang <yanghh@gmail.com>
Date: Tue, 2 Sep 2025 15:57:45 -0700
X-Gm-Features: Ac12FXyfmc1uyigjew_it5gvc_5UEmVpgqbA-joPyogEplxZ5UKkdi_A9VnawY4
Message-ID: <CALzt5P=QYq9W3HOjsNvHONuqm0z63kUK_EvvkfhUEcOne8zokw@mail.gmail.com>
Subject: Re: [PATCH] add force_layoutcommit param
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Trond,
Thanks for reviewing the change. I understand that, logically, if a
WRITE is FILE_SYNC, a LAYOUTCOMMIT isn=E2=80=99t necessary. I=E2=80=99m wor=
king on
enabling file_layout on some legacy POSIX filesystems, where
synchronizing metadata between the MDS and DS during client writes to
the DS incurs significant overhead. To address this, I=E2=80=99m suggesting=
 an
option that allows the MDS to update the metadata. From my reading,
RFC8881 doesn=E2=80=99t seem to prohibit LAYOUTCOMMIT in this scenario, cou=
ld
you share more detail about how it would break the FILE_SYNC case?
Thanks
Haihua

On Tue, Sep 2, 2025 at 2:18=E2=80=AFPM Trond Myklebust <trondmy@hammerspace=
.com> wrote:
>
> On Tue, 2025-09-02 at 18:19 +0000, Haihua Yang wrote:
> > [You don't often get email from yanghh@gmail.com. Learn why this is
> > important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > ---
> >  fs/nfs/filelayout/filelayout.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/nfs/filelayout/filelayout.c
> > b/fs/nfs/filelayout/filelayout.c
> > index d39a1f58e18d..1cb8f413a665 100644
> > --- a/fs/nfs/filelayout/filelayout.c
> > +++ b/fs/nfs/filelayout/filelayout.c
> > @@ -48,6 +48,8 @@ MODULE_LICENSE("GPL");
> >  MODULE_AUTHOR("Dean Hildebrand <dhildebz@umich.edu>");
> >  MODULE_DESCRIPTION("The NFSv4 file layout driver");
> >
> > +static bool force_layoutcommit =3D false;
> > +
> >  #define FILELAYOUT_POLL_RETRY_MAX     (15*HZ)
> >  static const struct pnfs_commit_ops filelayout_commit_ops;
> >
> > @@ -233,10 +235,11 @@ filelayout_set_layoutcommit(struct
> > nfs_pgio_header *hdr)
> >  {
> >         loff_t end_offs =3D 0;
> >
> > -       if (FILELAYOUT_LSEG(hdr->lseg)->commit_through_mds ||
> > -           hdr->res.verf->committed =3D=3D NFS_FILE_SYNC)
> > +       if (!force_layoutcommit && (FILELAYOUT_LSEG(hdr->lseg)-
> > >commit_through_mds ||
> > +           hdr->res.verf->committed =3D=3D NFS_FILE_SYNC))
> >                 return;
> > -       if (hdr->res.verf->committed =3D=3D NFS_DATA_SYNC)
> > +       if (hdr->res.verf->committed =3D=3D NFS_DATA_SYNC ||
> > +           (force_layoutcommit && hdr->res.verf->committed =3D=3D
> > NFS_FILE_SYNC))
> >                 end_offs =3D hdr->mds_offset + (loff_t)hdr->res.count;
> >
> >         /* Note: if the write is unstable, don't set end_offs until
> > commit */
> > @@ -1149,5 +1152,8 @@ static void __exit nfs4filelayout_exit(void)
> >
> >  MODULE_ALIAS("nfs-layouttype4-1");
> >
> > +module_param(force_layoutcommit, bool, 0644);
> > +MODULE_PARM_DESC(force_layoutcommit, "Force LAYOUTCOMMIT after data
> > was written (default: false)");
> > +
> >  module_init(nfs4filelayout_init);
> >  module_exit(nfs4filelayout_exit);
> > --
> > 2.51.0.87.g1fa68948c3.dirty
> >
>
> NACK.
>
> Firstly, there is no documentation that tells either me or any
> pnfs/files user when it would be desirable to set this flag. There
> isn't even a reference to what problem in RFC8881 it addresses.
>
> Secondly, it breaks the NFS_FILE_SYNC case.
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trondmy@kernel.org, trond.myklebust@hammerspace.com

