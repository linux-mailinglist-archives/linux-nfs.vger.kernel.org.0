Return-Path: <linux-nfs+bounces-4257-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEB29152B7
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 17:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F29282AFF
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 15:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2A719D063;
	Mon, 24 Jun 2024 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTqQz3Ti"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9808F19D896
	for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2024 15:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719243714; cv=none; b=ifenojsDxX2rKBzwywPj/YkyxqB/oniiqIIuawdbPWLgRxhnvkdQSf8x/u7T1uuetpZkEIa/HKP85A0uHKHnJxEHUgr+wryFNEgCTIzfJIyBAPA39owQszw0UOhJEP8rJKnHsWhAuE8SpeE4ekzaNmtlD/7z99KYTsSyL6DTZk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719243714; c=relaxed/simple;
	bh=ou2IYPd5H8oIxbYtS+lxtyCimVmTneL/zTys27sA4hI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FBADp0esl5GcZIlSWXyjHXT8daQfPxKl6d2+yNpyhuvcUJubrvLocYjUE70ivILOQCnmiu+FORNFg3KehG7VbUDMk57KXuJopysbC2p9Vm4BiNvVI3UTbsHiVPE0ZKkbDQBRrjIyLUb9ipPmHM/BFvt8VaVFOsMj9LIaKqSJ1uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTqQz3Ti; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ebc724e1fdso4558351fa.1
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2024 08:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719243711; x=1719848511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKl6joGBgm3Yyr5MlRLNs+CldhaTbvtmdB/d5MQfGSo=;
        b=YTqQz3TiOLzdKt0e9okKNvhozlQlU8sAJD1VwJpF31ET02cVoEXBNaOmbIj3loEcKD
         oqpwoi2FU6mODC8qD+6liAEoRfunNMKqeiGGTRZ8LHAdu9crHAfCbW7s0M3Q+DOL0sZ3
         WuPzkoxXDJjjyMjY+xzOgFxqSEm6xgt5H6fe87oh9BK3cx1Gf/Yn+lfbW+9rvc4HHSZ4
         IjSaLlYBMAw7J6Pu6Cj+Khyng8WgNxEPF9pQCgoI0GT49UyvI1YNY919NBG7WYJ5QcnT
         63hWfdygYx/N00yJYWLrgqns5esmZFqdZT3DrgOd+GDMNBd0Xd05aZ9QaW6JmFuJHaFH
         /DWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719243711; x=1719848511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKl6joGBgm3Yyr5MlRLNs+CldhaTbvtmdB/d5MQfGSo=;
        b=aKhjuybZnxqL+wANoIkaDjc55f1K4EwxJVbeYD5P4xax7IiUl6EuNf5g4L+QJ4dMWI
         7MTXY/Z3p8E/i2tWdofLWVO+SSOZ5vTonAxCYHzXxsJ0Bvs7aRHicX/tPw94mt1lPdY2
         0Vj0ZTAC7P1Tygs6WpfgTX4+KadIIE/XN53h/TgDg8L/cJiPpmN8FtMRWcKDUsn37zzJ
         WBvF/DvYAI/32gOSm9Qu9UmwheQf3QfN60gW4jIejio08syLA8oPwAxY5eHpj4znIbye
         iT7wec9DTzmVgrfCoPW9Gv7eQNoS2GhrIiHxFGFzjBK1H/2NzE71574jbOy80zr/JkDk
         5pAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHMv21BkSjPqbLKz0vudkUZygCZgFgciSKMnpOjEtQ2+qMlmxs+b53d15xFPHNbG7BGIOCNyz0dMRXkd1Jqp9bZS7a2uT2Z/3k
X-Gm-Message-State: AOJu0Yy480YklPYj7+b8sdOv1GgXP1JApvHN52wdDDjOgDa/wcrXGfqI
	UTmzEJHVqtmCJ3XlS3h3hh1BYeko8mYNboXqiXVlwORwSgRh/+9Ktz1RMt32uL+Qfile/UNlyWP
	qE3SaXBHEtVS+QeAj/O/tJ06B72P9ESA4
X-Google-Smtp-Source: AGHT+IEowdd7Oqi8+WVTIve4IFlj6dOlzN1b4vgtYMXCaLst+WBEe+bn/YcNZa4K/WgpIsFF1Qq+eRGtX9mBZGqZFsQ=
X-Received: by 2002:a2e:3c12:0:b0:2ec:5361:4e21 with SMTP id
 38308e7fff4ca-2ec54d0a940mr38277531fa.5.1719243710492; Mon, 24 Jun 2024
 08:41:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624132827.71808-1-olga.kornievskaia@gmail.com> <bb2d44bc4f10032ce1abdd7cbc576cc5ea5da5c5.camel@hammerspace.com>
In-Reply-To: <bb2d44bc4f10032ce1abdd7cbc576cc5ea5da5c5.camel@hammerspace.com>
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date: Mon, 24 Jun 2024 11:41:38 -0400
Message-ID: <CAN-5tyEPQMTLFP=r9s2wj3RqdV3DjU3wEeWAnmDfs+_NDBxp2Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.1 another fix for EXCHGID4_FLAG_USE_PNFS_DS for
 DS server
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 11:17=E2=80=AFAM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
> Hi Olga,
>
> On Mon, 2024-06-24 at 09:28 -0400, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > Previously in order to mark the communication with the DS server,
> > we tried to use NFS_CS_DS in cl_flags. However, this flag would
> > only be saved for the DS server and in case where DS equals MDS,
> > the client would not find a matching nfs_client in nfs_match_client
> > that represents the MDS (but is also a DS).
> >
> > Instead, don't rely on the NFS_CS_DS but instead use NFS_CS_PNFS.
> >
> > Fixes: 379e4adfddd6 ("NFSv4.1: fixup use EXCHGID4_FLAG_USE_PNFS_DS
> > for DS server")
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  fs/nfs/nfs4client.c | 6 ++----
> >  fs/nfs/nfs4proc.c   | 2 +-
> >  2 files changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> > index 11e3a285594c..ac80f87cb9d9 100644
> > --- a/fs/nfs/nfs4client.c
> > +++ b/fs/nfs/nfs4client.c
> > @@ -231,9 +231,8 @@ struct nfs_client *nfs4_alloc_client(const struct
> > nfs_client_initdata *cl_init)
> >               __set_bit(NFS_CS_INFINITE_SLOTS, &clp->cl_flags);
> >       __set_bit(NFS_CS_DISCRTRY, &clp->cl_flags);
> >       __set_bit(NFS_CS_NO_RETRANS_TIMEOUT, &clp->cl_flags);
> > -
> > -     if (test_bit(NFS_CS_DS, &cl_init->init_flags))
> > -             __set_bit(NFS_CS_DS, &clp->cl_flags);
> > +     if (test_bit(NFS_CS_PNFS, &cl_init->init_flags))
> > +             __set_bit(NFS_CS_PNFS, &clp->cl_flags);
>
> Won't this change cause the match in nfs_get_client() to fail?

At which stage? The problem was that nfs_match_client explicitly looks
for NFS_CS_DS for matching.

                /* Match request for a dedicated DS */
                if (test_bit(NFS_CS_DS, &data->init_flags) !=3D
                    test_bit(NFS_CS_DS, &clp->cl_flags))
                        continue;

We have pnfs flow creating client where NFS_CS_DS was set in
init_flags and yet the stored nfs_client didn't because we dont mark
the MDS exchange_id with DS flags.

In my testing the fixed way appropriately finds the MDS's nfs_client
for when MDS=3DDS and for when it's not there isn't one to begin with
but we still only mark USE_PNFS_DS on the pnfs path and not 4.1 mount.

>
>
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

