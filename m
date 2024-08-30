Return-Path: <linux-nfs+bounces-6017-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D22CA9654B9
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 03:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D268B1C20DA9
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 01:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9633725569;
	Fri, 30 Aug 2024 01:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVgqc2ni"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198201D131C
	for <linux-nfs@vger.kernel.org>; Fri, 30 Aug 2024 01:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724981558; cv=none; b=niZ6+OTBn5K38fmjfpaS8334lguidlpkijTp8Q+EmscMX3/aNPwoYop3ok+5hVTl7SiaqyQkRzTCotoq7mNingZfEaFs5F9Fq62Fa5aLumN9Hzh7zjuNnOls+N9aXIP54V2MMc95dNmEn+trdmPGIVEeOrBtg4AIkp3+8N0T47Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724981558; c=relaxed/simple;
	bh=kF9R2aFokB3ygLlac6NUJ4aXYR3R1NKA6Q2ht4Ku96A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7KGVz8wHOBrPBHYlruTauKuwnhsW5l0BE06JSyB5INM6BH1NvGJDekv96EM78tRtx/HDVayw7L7/nvw96p1QAEdXlRy+0oulbNbRWW4qDPURojTOcupSvRg6iIgNpnAWAlJ5B4p+RrcfZtzYns3Y4l2koumnwG1wHnUKmXwYR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVgqc2ni; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7cf5e179b68so842208a12.1
        for <linux-nfs@vger.kernel.org>; Thu, 29 Aug 2024 18:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724981556; x=1725586356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYtOleRP6BX+Cy4F2ru65/6XU2YC6jFpX6Mi6xHZrPE=;
        b=mVgqc2ni+MXPQ6SC9voDzEouwBQDkGoPCKbRXx2j3/bDSoD7uLo0RJ72UNevg8O7C9
         pk77XmgvoeAXEmpUm5PyUvHMKhQQIgx5vvEcPiRSjHUyO/yovpHjXNktwuQPOhlp8K1E
         JfTz6KNOMyjcsmuzqjkiiUU6757ZUeQt31Q9nIRIwofEff4RIo8L6CiFcywYByvLZFsw
         m/YPRA0DxOB1vBFklWQjy70XDZY6QKsIVL6Gdypk0Jte5Zqq3NA3OUcsuM5v49i1oIK9
         GOe8zBiRp+/HGS7/wlNxuqtyUk7KixVY91gUklXba5piBufeW7LIuqMUVtpFQVBH62R5
         IY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724981556; x=1725586356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYtOleRP6BX+Cy4F2ru65/6XU2YC6jFpX6Mi6xHZrPE=;
        b=nHa4aYYl1qwvkwDqRVuxxOVjLcM90u7d2a531oumBvaJ1BjczTDS2ELC7slNY1PvFz
         QGuC1/+d6MDN+qp+jTjIOPKQO/Not6PI9QWwF/rOdfGe+1GALyrnNJlrdlmrPC5MQPWA
         8WZtUiLSuaXma8gGvQVRd033i4AAUDfqKgqn3GYT3JMjaclG8lXaeOzCfGbl/tQiS2rP
         R1UyLoc92p4a7QtzXrRdoN/fO5UB7pNU48/FPHFKVsJiD5ANqQGotQJr4GeILNLhhGkJ
         Lqv2sbpLkQ5G4Refj6FewJBEHZ2+SKvsttMrVo4GlDuUYS0tpjOmdhuf53gNThqJA9Pr
         a4Yw==
X-Gm-Message-State: AOJu0YwW8QaKlaL12B40By3BJyQ2qhvHMbX0QqEfKhIDyS4Z4tvHA+P9
	/1dyN0qsw8m4A5+wz5eGFpYJB4pVRcVtq8xS180b8VvfaTmkMmQu5QeXd2hvBEtgTBMxra0jMdp
	HwH9fu/rhDnOsj9cO/qegWfGr7EJI
X-Google-Smtp-Source: AGHT+IH52KMI5p8QP5xqOXCdFfrmEksj73K0JMXGGut1OHMlawVgkwy0WPc4Hnt+MvMKlbTsfNLFPpf5xrZdI3GkiFk=
X-Received: by 2002:a17:90b:4387:b0:2d4:27de:dc39 with SMTP id
 98e67ed59e1d1-2d856a5f271mr6123468a91.6.1724981556025; Thu, 29 Aug 2024
 18:32:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy6UmWngTqzy=YVQ_2x61+AdZp2uW90N8oGB1V73O-vDMA@mail.gmail.com>
 <babb9c0643d56a7aeee80bca7ec78f557f965081.camel@hammerspace.com>
In-Reply-To: <babb9c0643d56a7aeee80bca7ec78f557f965081.camel@hammerspace.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Thu, 29 Aug 2024 18:32:25 -0700
Message-ID: <CAM5tNy7_gv_Gp17X+rZmZ4t_UTKWSX=+zGHGKPuhtF+--xOp-w@mail.gmail.com>
Subject: Re: Any idea how best to handle potentially large POSIX ACLs for getfacl?
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 5:33=E2=80=AFPM Trond Myklebust <trondmy@hammerspac=
e.com> wrote:
>
> On Thu, 2024-08-29 at 17:19 -0700, Rick Macklem wrote:
> > Hi,
> >
> > I have a rather crude patch that does the POSIX draft ACL attributes
> > that my draft is suggesting for NFSv4.2 for the Linux client.
> > - It is working ok for small ACLs, but...
> >
> > The hassle is that the on-the-wire ACEs have a "who" field that can
> > be up to 128bytes (IDMAP_NAMESZ).
> >
> > I think I have figured out the SETATTR side, which isn't too bad
> > because
> > it knows how many ACEs. (It does roughly what the NFSv3 NFSACL code
> > did, which is allocate some pages for the large ones.)
> >
> > However, the getfacl side doesn't know how bug the ACL will be in
> > the reply. The NFSACL code allocates pages (7 of them) to handle the
> > largest possible ACL. Unfortunately, for these NFSv4 attributes, they
> > could be roughly 140Kbytes (140bytes assuming the largest "who" times
> > 1024 ACEs).
> > --> Anyone have a better suggestion than just allocating 35pages each
> > time
> >     (when 99.99% of them will fit in a fraction of a page)?
> >
> > Thanks for any suggestions, rick
> >
>
> See the NFSv3 posix acl client code.
>
> It allocates the 'pages[]' array of pointers to the page buffers to be
> of length NFSACL_MAXPAGES, but only allocates the first entry, and
> leaves the rest NULL.
> Then in the XDR encoder "nfs3_xdr_enc_getacl3args()" where it declares
> the length of that array, it sets the flag XDRBUF_SPARSE_PAGES on the
> reply buffer.
>
> That tells the RPC layer that if the incoming RPC reply needs to fill
> in more data than will fit into that single page, then it should
> allocate extra pages and add them to the 'pages' array.
Oh, ok thanks for the explanation.
It doesn't sound like a problem then.

I'll just code things the same way.

Maybe I can ask one more question??
There are a large # of XXX_decode_XXX functions. Are there any that
should/should not be used for the above case?
For example, there are:
- Ones that take a "struct xdr_stream *xdr" (usually with _stream_ in the n=
ame)
vs
- Ones that take a "struct xdr_buf *buf" argument.
  (I ended up using these for the encode side and this looks like what
   nfsacl_decode() uses, as well.)

(I'll admit I have been wading around in the code, but haven't really
gotten to the point of understanding which ones should be used.)

Thanks, rick

>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

