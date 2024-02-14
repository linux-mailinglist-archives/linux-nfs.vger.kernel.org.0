Return-Path: <linux-nfs+bounces-1919-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFD48542B1
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Feb 2024 07:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC42282EE1
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Feb 2024 06:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC97125BA;
	Wed, 14 Feb 2024 06:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFx07+sj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F2611C89
	for <linux-nfs@vger.kernel.org>; Wed, 14 Feb 2024 06:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707891203; cv=none; b=anDHFQlfg8sFBuUkcrjQLoIXUYV2+H2NATzN/YXd32EGrlxawjzkjJB6hhTt2qPBbWyoyAmm7jJ3vz8abFEOY8MvAYi600mH24POuNUDQ0VzLqJ5fagBjp7jpGfBDWMsoBSyyJ8r1DKPD/47HP37x50pbaa9x9L/s5WEfUcIEgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707891203; c=relaxed/simple;
	bh=jtU1iXSTS0wDcRgvhOAmVNcuILryJfUDNnkgPNKcFC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDU2PnyY6OwegNJH8SEhq94BBXzezmaikt6vqRaDugW4lrrpqKDov01mpKFLKbyBHFtBsRWAgwL37Lg37ZOlhWfo0Z+AWm/jbX36nj2yKKU0Ikv4/RbQJXO3jy/FakMr1G8YnyVgnOPSKIMMpQfygeZ5aUJGnEGkMEdg/BV6Hu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFx07+sj; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51167e470f7so6263197e87.2
        for <linux-nfs@vger.kernel.org>; Tue, 13 Feb 2024 22:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707891200; x=1708496000; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nwqSoUhFheOqzLaZL0JzDXIKSyin28/f1z7Q9ypHOMo=;
        b=cFx07+sj2947QYoMHw/ECII8Zssj+UUt4rKxHRZ9pSMJAi4DUFxH68hEILRjeutZ7S
         l3EbJVk+0OOhy451hSGBRpP+m6i8SBJmytqS3lQxeymu3ZuefkAmWp4e4lj6VvlDzwhs
         A6j39uppAaKBeCiTB84OvyNXhSd4qQpjQxKqzjNDskpJaSV0PPmO5GsG1y6F4h3Ce7OR
         XBY+iiDq3SuZCXhN0kiNcTuC4WzLUo2TKREgNP036s6A5VM+IhcUOD3IoQWmNyCeny00
         Pxq5HoUDpzqgLunhwNGZnSNkZRRjNaFAla73Ez1TzaKnJtINl5lQLaS53v5FRbVlKD4S
         6aAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707891200; x=1708496000;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nwqSoUhFheOqzLaZL0JzDXIKSyin28/f1z7Q9ypHOMo=;
        b=itMInxExhvkBAaeNglwv5ui8rtHTe5DRQgUyuXwEE2PEqyzsmzH9dVLqI5gVH4j/rw
         pqWbbTo+pzrhgkjmPqb3XpbLzdODJuVnpZ2ai/6DbW5WiPORzNaK8zN8qXoZQLV1OvF0
         GzPoFB4H7yfLlUexC4XZruXe0pfhxLMWOVa2jKSWioSY8BDbEXCfQkfzVuyNplr7O3XQ
         znTdYm7uE4C5bPGHwCBZWT9uTq9dGmvXjO05lW/rB5axcGWlDvIciJetMhA6XrWw89RY
         2s7s0ePt2oWSUz6QS60huMlepOCzmekq5MhoOfqh7tiav34mMs20tHwhJHcR95UgN1Ip
         lskg==
X-Forwarded-Encrypted: i=1; AJvYcCWF7NIsChYb7YF55HO1CMwITEvodrO94meSAymMV27isbeaFFPVZztwgwOwbeRt7Mtu3qkWRMlxLyX2vl97szW4w3rbUyVcPvBx
X-Gm-Message-State: AOJu0YyKRPFnzENiSfsf2QoB1JVWGPxPnYUa6uhdpK9L/quOssLgIwGE
	OvSc96U2u+JJXbVs8Z6VFSvzkQt617gyyZxWy8kF58+MQkDtx3BcRoAqQXSct3RqGt52Aokf/n7
	TYZPy2/3Ayv38xYGPGuso4P9B+zM=
X-Google-Smtp-Source: AGHT+IFpGY4mBmEkzyDKODWf8+q3y/yCh8Rg2lFA0B3xIZrVlx1eaTHOwpByLB3eP5YAErHwEJIusK9+bB1TXgM5kB4=
X-Received: by 2002:a05:6512:2313:b0:511:8dae:6e59 with SMTP id
 o19-20020a056512231300b005118dae6e59mr1396530lfu.38.1707891199882; Tue, 13
 Feb 2024 22:13:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCNcBvWjt13mBGoNZf-BGwn18_R6KAeMmA7NZOTifORLEANg@mail.gmail.com>
 <CAAvCNcAkZFkLU-XtmJy30AT7ad_MvSzZTMEk86PiZXLdcMg4fA@mail.gmail.com>
 <b14648b0-a2f7-451a-a56b-6bb626c4ffa8@talpey.com> <14e1e8c8613c74d07cb0cefbcebbf79a3a57311e.camel@kernel.org>
 <CAAvCNcAsow-QTPYLm0fUNX3K5X4Aci=aFi+hi4a0S8k19oa-KA@mail.gmail.com> <3fa863dc2c1ec75416704a9cdaa17bf1a2e447e4.camel@hammerspace.com>
In-Reply-To: <3fa863dc2c1ec75416704a9cdaa17bf1a2e447e4.camel@hammerspace.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Wed, 14 Feb 2024 07:12:00 +0100
Message-ID: <CALXu0UfuKEa8u-dz9aG8K--ULBe2yaZoYbEoR3Tyr2NG6a1_Rw@mail.gmail.com>
Subject: Re: Public NFSv4 handle?
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "jlayton@kernel.org" <jlayton@kernel.org>, "dan.f.shelton@gmail.com" <dan.f.shelton@gmail.com>, 
	"tom@talpey.com" <tom@talpey.com>, "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Feb 2024 at 21:59, Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Tue, 2024-02-13 at 21:28 +0100, Dan Shelton wrote:
> > [You don't often get email from dan.f.shelton@gmail.com. Learn why
> > this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > On Fri, 9 Feb 2024 at 16:32, Jeff Layton <jlayton@kernel.org> wrote:
> > >
> > > On Thu, 2024-02-08 at 21:37 -0500, Tom Talpey wrote:
> > > > On 2/8/2024 7:19 PM, Dan Shelton wrote:
> > > > > ?
> > > > >
> > > > > On Thu, 25 Jan 2024 at 02:48, Dan Shelton
> > > > > <dan.f.shelton@gmail.com> wrote:
> > > > > >
> > > > > > Hello!
> > > > > >
> > > > > > Do the Linux NFSv4 server and client support the NFS public
> > > > > > handle?
> > > >
> > > > Are you referring the the old WebNFS stuff? That was a v2/v3
> > > > thing,
> > > > and, I believe, only ever supported by Solaris.
> > > >
> > >
> > > One more try! I think my MUA was having issues this morning.
> > >
> > > NFSv4.1 supports the PUTPUBFH op:
> > >
> > > https://www.rfc-editor.org/rfc/rfc8881.html#name-operation-23-putpubfh-set-p
> > >
> > > ...but this op is only for backward compatibility. The Linux server
> > > returns the rootfh (as it SHOULD).
> >
> > No, I do not consider this "backward compatibility". The "public"
> > option is also intended for public servers, like package mirrors
> > (e.g.
> > Debian), to have a better solution than http or ftp.
> >
>
> PUTPUBFH offers no extra security features over PUTROOTFH. It is
> literally just a way to offer a second point of entry into the same
> exported filesystem.

Right. It doesn't expose your "private" filesystem hierarchy.

>
> A more modern approach would be to create 2 containers on the same
> host: one that shares the full namespace to be exported, and one that
> shares only the bits of the namespace that are considered "public".
> That approach requires no extra patches or customisation to existing
> kernels.

Oh for god's sake. Please don't call "containers" a "modern approach".
It's just a sad waste of resources, aside from the other shitload of
problems they cause.
Also in real life, we frog-eating backwards savages here in Europe do
not have so many public IPv4 addresses available to put everything
into containers, and changing everything to IPv6-only networks will
take another 2 or 3 decades here.

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

