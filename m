Return-Path: <linux-nfs+bounces-6212-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEE796CC55
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 03:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2B2F1C22153
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 01:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36C2BE5D;
	Thu,  5 Sep 2024 01:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drqHtij9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64530BE4A
	for <linux-nfs@vger.kernel.org>; Thu,  5 Sep 2024 01:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725500636; cv=none; b=KqFGyEiC5AFssQ67OaXcUJX7oqf2cf1jfiZqmIRlcVuXmNE+v8tLmMAOysKcpP9qclYVU9OIs8xWR07TiKGbtl9X0TEsWPXetui7WA+MfaFTLac3WKZYMyN68pkZKd0oZQSTWMZS6lYwJ9gzS/6dfvjGPx+RniDS9/kdgqS/TAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725500636; c=relaxed/simple;
	bh=2JU/C8YyROSVYhd/0IfQ3uOCdK3d1uLf7CDxEpX8iIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpZsZ6nC3n2DTbUBDt1GA8ohd8WsxzcvfCMiokNslszTnf6XPjpMj1pVUsE4i+6oz1PWULqlxZvBYafDKxIymTdFaVPzriGG10/1njhmCALeLCMQx2Tclh1HQfLKPeV4oeVwsO8GQ0EHx/JyPi+xFgcsRB9c8rW3q0nEqbGDHNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drqHtij9; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7d4f8a1626cso235570a12.3
        for <linux-nfs@vger.kernel.org>; Wed, 04 Sep 2024 18:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725500635; x=1726105435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Gzp2TVyS7vpHyIysPpBkRpbY3Nii4fvLJBt0foQ/AU=;
        b=drqHtij9i4JBMtO8ihX1KPa+l2mzl8lfhFdXpSVP8Vdrk7JeySQbZsxDKfZD4mLbAp
         7Dtxm118ElnRJX4PrJybZMpMmI2kYtP5U+aAOwYvE/BAtEbhhCe4KQWHE5/BT4vrgKa7
         1V5uaD6Pt2qU8G5zj8ICR311d0RxbNV313xYa+dcBpIr930MtSrnst4ohArFbNdF0KmQ
         i0A1H19rSLD09HD6mX7q0V0G2LsrUOA6ymt01OVtg/E04pPNK5/LYqSsN0sL7jQ/x79z
         /8kRvzRT6gJfyA4WHDy11f4iNsq266NGSCfj4ut13RATrRl+zRsFdPsaaQfwiEo9zMbm
         P5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725500635; x=1726105435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Gzp2TVyS7vpHyIysPpBkRpbY3Nii4fvLJBt0foQ/AU=;
        b=ebDg9pxEPDWawp8TNgv6+WpUJGKx3HZxchtGibHXQabF7TMmlEp101Tb62iCYzaHRE
         B5x7ec7uP7K0fZAzxTBnZRUwbeZLycFU5agaVEbihxu2vbJWZ5niamJqem2Agsal+wTm
         WWgF/lHFR67eID74mb/cnQ76L5doqlA2nydGMjcf3B+gKg/AwX+yCnI4ar5O1NzUtoBo
         Go0+fhSDss7DX2GI7clK084AQzC/mEhHDZudW9mXpMTPOO0GUBrMaiFZ6Uv6XTGT1/IO
         IlRA/alw5GcdEnq6ae5tv7B/Dt4g5cfn4X39NPK0Zia8b5ExLe6a86LMfDHlSwxrmIzn
         w1Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXXdGKDenf8tl6dgxQuRrBjKkp1XOjTopOIXaC+Qutd3IlxlJDRuNulV+8OQKRDOs0aWokC8f/Qz+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjPzuUb2yUIr0RGa4Wfu+1CJx1CG55xTeS6lyBGSvyAEilBiKl
	5u5wfuiyal+p1UySkV0U1aIAd7nLIfaQ6Tdm9sTpVanKrb3PPmy56fKDxXnoHye3WRlkSVc3iBZ
	m5C0pXRxrXAs6NN7pwISmMtv7nkundo0=
X-Google-Smtp-Source: AGHT+IHSxxSYnbCgN6s7QWT4HNEzOb7EHpxpLfDnFqToQ3bfLgcFM9lRYwONAaoSrj1QScB1i5b/oytAYu/PunRP+ps=
X-Received: by 2002:a17:902:ccc3:b0:203:8db4:4442 with SMTP id
 d9443c01a7336-2058422336cmr138281505ad.45.1725500634322; Wed, 04 Sep 2024
 18:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy6UmWngTqzy=YVQ_2x61+AdZp2uW90N8oGB1V73O-vDMA@mail.gmail.com>
 <babb9c0643d56a7aeee80bca7ec78f557f965081.camel@hammerspace.com>
 <CAM5tNy7_gv_Gp17X+rZmZ4t_UTKWSX=+zGHGKPuhtF+--xOp-w@mail.gmail.com>
 <0c4d1a086b2d453cfa9e62b88bc28c0cc5720d20.camel@hammerspace.com>
 <CAM5tNy5xXd2d8CZXEsUUFh-OjMnME92ce7YxCT3P7MAdutCFFg@mail.gmail.com> <2710EC77-51FF-43D4-9E88-BC04DF28952F@oracle.com>
In-Reply-To: <2710EC77-51FF-43D4-9E88-BC04DF28952F@oracle.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Wed, 4 Sep 2024 18:43:44 -0700
Message-ID: <CAM5tNy5XyvbzMq86Rh3A9A_fi59OurwL-U5xrTERqsVfn7pAKA@mail.gmail.com>
Subject: Re: Any idea how best to handle potentially large POSIX ACLs for getfacl?
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 8:28=E2=80=AFAM Chuck Lever III <chuck.lever@oracle.=
com> wrote:
>
>
>
> > On Sep 2, 2024, at 8:16=E2=80=AFPM, Rick Macklem <rick.macklem@gmail.co=
m> wrote:
> >
> > On Thu, Aug 29, 2024 at 6:41=E2=80=AFPM Trond Myklebust <trondmy@hammer=
space.com> wrote:
> >>
> >> On Thu, 2024-08-29 at 18:32 -0700, Rick Macklem wrote:
> >>> On Thu, Aug 29, 2024 at 5:33=E2=80=AFPM Trond Myklebust
> >>> <trondmy@hammerspace.com> wrote:
> >>>>
> >>>> On Thu, 2024-08-29 at 17:19 -0700, Rick Macklem wrote:
> >>>>> Hi,
> >>>>>
> >>>>> I have a rather crude patch that does the POSIX draft ACL
> >>>>> attributes
> >>>>> that my draft is suggesting for NFSv4.2 for the Linux client.
> >>>>> - It is working ok for small ACLs, but...
> >>>>>
> >>>>> The hassle is that the on-the-wire ACEs have a "who" field that
> >>>>> can
> >>>>> be up to 128bytes (IDMAP_NAMESZ).
> >>>>>
> >>>>> I think I have figured out the SETATTR side, which isn't too bad
> >>>>> because
> >>>>> it knows how many ACEs. (It does roughly what the NFSv3 NFSACL
> >>>>> code
> >>>>> did, which is allocate some pages for the large ones.)
> >>>>>
> >>>>> However, the getfacl side doesn't know how bug the ACL will be in
> >>>>> the reply. The NFSACL code allocates pages (7 of them) to handle
> >>>>> the
> >>>>> largest possible ACL. Unfortunately, for these NFSv4 attributes,
> >>>>> they
> >>>>> could be roughly 140Kbytes (140bytes assuming the largest "who"
> >>>>> times
> >>>>> 1024 ACEs).
> >>>>> --> Anyone have a better suggestion than just allocating 35pages
> >>>>> each
> >>>>> time
> >>>>>    (when 99.99% of them will fit in a fraction of a page)?
> >>>>>
> >>>>> Thanks for any suggestions, rick
> >>>>>
> >>>>
> >>>> See the NFSv3 posix acl client code.
> >>>>
> >>>> It allocates the 'pages[]' array of pointers to the page buffers to
> >>>> be
> >>>> of length NFSACL_MAXPAGES, but only allocates the first entry, and
> >>>> leaves the rest NULL.
> >>>> Then in the XDR encoder "nfs3_xdr_enc_getacl3args()" where it
> >>>> declares
> >>>> the length of that array, it sets the flag XDRBUF_SPARSE_PAGES on
> >>>> the
> >>>> reply buffer.
> >>>>
> >>>> That tells the RPC layer that if the incoming RPC reply needs to
> >>>> fill
> >>>> in more data than will fit into that single page, then it should
> >>>> allocate extra pages and add them to the 'pages' array.
> >>> Oh, ok thanks for the explanation.
> >>> It doesn't sound like a problem then.
> >>>
> >>> I'll just code things the same way.
> >>>
> >>> Maybe I can ask one more question??
> >>> There are a large # of XXX_decode_XXX functions. Are there any that
> >>> should/should not be used for the above case?
> >>> For example, there are:
> >>> - Ones that take a "struct xdr_stream *xdr" (usually with _stream_ in
> >>> the name)
> >>> vs
> >>> - Ones that take a "struct xdr_buf *buf" argument.
> >>>  (I ended up using these for the encode side and this looks like
> >>> what
> >>>   nfsacl_decode() uses, as well.)
> >>>
> >>> (I'll admit I have been wading around in the code, but haven't really
> >>> gotten to the point of understanding which ones should be used.)
> >>>
> >>
> >> The "struct xdr_stream' based code is the 'newer' way of doing things,
> >> and allows you to write code that abstracts away some of the ugliness
> >> in the RPC layer, particularly when you need to mix regular buffers an=
d
> >> page data.
> >> That said, there is definitely legacy code out there that works quite
> >> well and is not worth a lot of effort to convert.
> >>
> >> I'd recommend trying to use the xdr_stream if possible, just because o=
f
> >> the better abstraction, but if you have to fall back to manipulating
> >> the xdr_buf directly, then that API is there, and is still supported.
> > I haven't been able to figure out how to use the xdr_stream... stuff
> > when the attributes get large enough that they need pages.
> >
> > What I currently have (that seems to work) is...
> > For GETATTR, XDRBUF_SPARSE_PAGES is set, and then, once it
> > gets to the actual ACL (which can be pretty big), I use
> >   xdr_decode_word() and read_bytes_from_xdr_buf() to decode it
> >   (The stream calls worked until the ACL got too big for the non-page
> >    part, which I think is 2Kbytes?)
> >   - Maybe there is some trick I don't know to get the big ones to work
> >     with the xdr_stream_XXX() decode calls?
>
> See xdr_set_scratch_buffer() -- xdr_stream wants a scratch
> buffer for managing the transitions between the xdr_buf's
> head/page/tail components.
Thanks Chuck. That seems to work fine, rick

>
>
> --
> Chuck Lever
>
>

