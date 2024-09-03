Return-Path: <linux-nfs+bounces-6131-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FBB96909C
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Sep 2024 02:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D55B1C227D3
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Sep 2024 00:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7109D63D5;
	Tue,  3 Sep 2024 00:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrbDR4gN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C836A63CB
	for <linux-nfs@vger.kernel.org>; Tue,  3 Sep 2024 00:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725322625; cv=none; b=IZKn13BmYg+L2jPMAqwaJEEzO9fvF1hTYlZ/KERWpFE5A9+27taYXU+wMVEmFnEIwZuXZvRuaO/3Z4pddHBNBjL5txR+h4E3F+uMYRwMuUQ/vxVC66G+CrgFPAbx0tTSENbFR6x8JwuhixtaDV02cWNlETUshdg4B6PvSpnOfVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725322625; c=relaxed/simple;
	bh=p7/Q1BM8xoZdy0pdmfWJsaGG6s3vmWGTyst6Lr+1tu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=le6LZ1rWA5uACmsqFy/1sejRATWpmcoIs21T7KW9olsU1VCTYVLNFzA3UZxs3Jc9zbiPdyab/ZHIiUi3mQCirgPrVkzdRlcEG/OytEFIhQDFGgjGOLOy8cOkXyRg1u2PYQmQZeBs+QaZ4XnYwxRmm7hvVmDbZLGQ+cfMdSiHJ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrbDR4gN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2068a7c9286so6111165ad.1
        for <linux-nfs@vger.kernel.org>; Mon, 02 Sep 2024 17:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725322623; x=1725927423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhDf8On6iGb8cqnM3gcLtNKr0NFWADF8t6W9hqvv1YA=;
        b=YrbDR4gNXLdaaBF20wcnIdn4CW+VsPhgIKnwNzYoSfTewQbfIQ/ogDVYk5UV5Ky3Of
         2XviH5UGrO3gtURmvrWu4GaIyMu2AUdQUOHPf7tcpOZUeHPBLKY4eMHKR3T4UTHEOV8k
         oFgG9Q8ltbHgd5kHzlNsVNmzUvhnt0ZY6d4BvEhy3+hpnC+jc2L1PDac0ykzVOx76cEc
         R0zKJXdwlAVpX7411qFd/EHmG3PsIwnfTrGu15jztxY1ItYbrdojqaK2YMWtcTTE95G3
         mbWtasVayJ/kIP/wr06is4mmcoK7cbz/FhHtCSewEIX/DhQnt13rjf68q+cPuZGJaM+b
         Ynjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725322623; x=1725927423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhDf8On6iGb8cqnM3gcLtNKr0NFWADF8t6W9hqvv1YA=;
        b=rmuFaLBsBlOIHP7128ZE8IKjzwZchA/pwHfMxYLloxdf95eUydcyvm5JQqVNSQoscs
         1HVuh203Z7lspFzo5YXuNx+APraId/33aaogl5EN2dBjhbNCRB014fpbuuWHvVAf5JBG
         O/dbFw+0FabQRKAULbt8E2p7TACVvxKShwN21iEEHPLUt1oidyVLvBo0XpHPtrY+ax6O
         0yuFFgOiFc7kqjxW2QWbq15AvWkY7D+7ia3X4np0qfrSuX3q1spw/EcwL7PQ/hMSMdGd
         JdVuYid51vLmk5MFPZqwsZxohVGuozssXpUApuVO1fjPvOgwjXASkQEKpwCYG7UPeShI
         dyZw==
X-Gm-Message-State: AOJu0Yw6SkmUpT3tE1sH3Gq5YGRCJgR46rwfx03sCCQxWVj4DXWNa7fX
	iUfDtW6e6Q+q+WLw4YV13XISxoX/dEYa9Qsdqz3xOeO/qkVixD1n4cBzehHFLxibSBslt9NjCDC
	ULLsoVa97iZPPsdtiDA1wy+s4O2riLzY=
X-Google-Smtp-Source: AGHT+IGFfzVn3Cu+AU5a+45mcfWPlKGfunYXDeRvNJ2/V2C8DpnbINqN0N+/7piWnawtrK6DwSeM+rtb7Zq8i9MTyXU=
X-Received: by 2002:a17:903:2306:b0:203:bbc9:2b93 with SMTP id
 d9443c01a7336-2058417b234mr45012155ad.1.1725322622683; Mon, 02 Sep 2024
 17:17:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy6UmWngTqzy=YVQ_2x61+AdZp2uW90N8oGB1V73O-vDMA@mail.gmail.com>
 <babb9c0643d56a7aeee80bca7ec78f557f965081.camel@hammerspace.com>
 <CAM5tNy7_gv_Gp17X+rZmZ4t_UTKWSX=+zGHGKPuhtF+--xOp-w@mail.gmail.com> <0c4d1a086b2d453cfa9e62b88bc28c0cc5720d20.camel@hammerspace.com>
In-Reply-To: <0c4d1a086b2d453cfa9e62b88bc28c0cc5720d20.camel@hammerspace.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Mon, 2 Sep 2024 17:16:51 -0700
Message-ID: <CAM5tNy5xXd2d8CZXEsUUFh-OjMnME92ce7YxCT3P7MAdutCFFg@mail.gmail.com>
Subject: Re: Any idea how best to handle potentially large POSIX ACLs for getfacl?
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 6:41=E2=80=AFPM Trond Myklebust <trondmy@hammerspac=
e.com> wrote:
>
> On Thu, 2024-08-29 at 18:32 -0700, Rick Macklem wrote:
> > On Thu, Aug 29, 2024 at 5:33=E2=80=AFPM Trond Myklebust
> > <trondmy@hammerspace.com> wrote:
> > >
> > > On Thu, 2024-08-29 at 17:19 -0700, Rick Macklem wrote:
> > > > Hi,
> > > >
> > > > I have a rather crude patch that does the POSIX draft ACL
> > > > attributes
> > > > that my draft is suggesting for NFSv4.2 for the Linux client.
> > > > - It is working ok for small ACLs, but...
> > > >
> > > > The hassle is that the on-the-wire ACEs have a "who" field that
> > > > can
> > > > be up to 128bytes (IDMAP_NAMESZ).
> > > >
> > > > I think I have figured out the SETATTR side, which isn't too bad
> > > > because
> > > > it knows how many ACEs. (It does roughly what the NFSv3 NFSACL
> > > > code
> > > > did, which is allocate some pages for the large ones.)
> > > >
> > > > However, the getfacl side doesn't know how bug the ACL will be in
> > > > the reply. The NFSACL code allocates pages (7 of them) to handle
> > > > the
> > > > largest possible ACL. Unfortunately, for these NFSv4 attributes,
> > > > they
> > > > could be roughly 140Kbytes (140bytes assuming the largest "who"
> > > > times
> > > > 1024 ACEs).
> > > > --> Anyone have a better suggestion than just allocating 35pages
> > > > each
> > > > time
> > > >     (when 99.99% of them will fit in a fraction of a page)?
> > > >
> > > > Thanks for any suggestions, rick
> > > >
> > >
> > > See the NFSv3 posix acl client code.
> > >
> > > It allocates the 'pages[]' array of pointers to the page buffers to
> > > be
> > > of length NFSACL_MAXPAGES, but only allocates the first entry, and
> > > leaves the rest NULL.
> > > Then in the XDR encoder "nfs3_xdr_enc_getacl3args()" where it
> > > declares
> > > the length of that array, it sets the flag XDRBUF_SPARSE_PAGES on
> > > the
> > > reply buffer.
> > >
> > > That tells the RPC layer that if the incoming RPC reply needs to
> > > fill
> > > in more data than will fit into that single page, then it should
> > > allocate extra pages and add them to the 'pages' array.
> > Oh, ok thanks for the explanation.
> > It doesn't sound like a problem then.
> >
> > I'll just code things the same way.
> >
> > Maybe I can ask one more question??
> > There are a large # of XXX_decode_XXX functions. Are there any that
> > should/should not be used for the above case?
> > For example, there are:
> > - Ones that take a "struct xdr_stream *xdr" (usually with _stream_ in
> > the name)
> > vs
> > - Ones that take a "struct xdr_buf *buf" argument.
> >   (I ended up using these for the encode side and this looks like
> > what
> >    nfsacl_decode() uses, as well.)
> >
> > (I'll admit I have been wading around in the code, but haven't really
> > gotten to the point of understanding which ones should be used.)
> >
>
> The "struct xdr_stream' based code is the 'newer' way of doing things,
> and allows you to write code that abstracts away some of the ugliness
> in the RPC layer, particularly when you need to mix regular buffers and
> page data.
> That said, there is definitely legacy code out there that works quite
> well and is not worth a lot of effort to convert.
>
> I'd recommend trying to use the xdr_stream if possible, just because of
> the better abstraction, but if you have to fall back to manipulating
> the xdr_buf directly, then that API is there, and is still supported.
I haven't been able to figure out how to use the xdr_stream... stuff
when the attributes get large enough that they need pages.

What I currently have (that seems to work) is...
For GETATTR, XDRBUF_SPARSE_PAGES is set, and then, once it
gets to the actual ACL (which can be pretty big), I use
   xdr_decode_word() and read_bytes_from_xdr_buf() to decode it
   (The stream calls worked until the ACL got too big for the non-page
    part, which I think is 2Kbytes?)
   - Maybe there is some trick I don't know to get the big ones to work
     with the xdr_stream_XXX() decode calls?

For SETATTR, it seemed to be similar. I actually have two ways that
seem to work:
(A) - Allocates the max # of pages (assuming 128byte who fields) and
        then in the enc function specified in PROC(xxx), it does a
         - xdr_write_pages()
         - fills the data in with xdr_encode_word() and write_bytes_to_xdr_=
buf()
         - trims the size to the correct (not maximum) length by setting
           xdr->buf->len and xdr->buf->page_len
         --> I don't like this one because it typically allocates more page=
s
               than needed and requires the len to be trimmed.
(B) - I wrote a couple of simple functions (I couldn't find ones that alrea=
dy
         did this) which encode the ACLs before the RPC call
(nfs4_do_call_sync())
         allocating page(s) as required. Then all the enc function in PROC(=
...)
         does is a xdr_write_pages().
I prefer (B), but they both seem to work. Small ACLs don't do (A) or (B) an=
d
are just encoded with the xdr_stream_XXX() functions.

Anyhow, if there are better ways to handle the big (up to 2 * 140Kbytes) AC=
Ls,
please let me know.
In the meantime, the above seems to be working.

Thanks for your comments, rick

>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

