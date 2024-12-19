Return-Path: <linux-nfs+bounces-8668-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8359F7CC0
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2024 15:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DAFF1883C1D
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2024 14:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64053224AEA;
	Thu, 19 Dec 2024 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1NHWxmf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F93622075
	for <linux-nfs@vger.kernel.org>; Thu, 19 Dec 2024 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734616993; cv=none; b=U+vGogK6MDPHxj8lgi/0gw8A0xdJavfJg8AIPwpzGUvFqL6u/+ARDrdEXBaO+S7SfHwAxO3uSPJaN0FGV5qwVc2By87W2bj6bFhuje0btiWsJvtiU4fKxfpLgwsEG/rRGxAyHF06yzIq8VSKbAqqqzyL5aRWoOLWo5fWEMxN3Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734616993; c=relaxed/simple;
	bh=dY6P2xvN7cT9AeFu8wMMmJfhdOn6QdQ875zrHhKqB9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=tANPijc2fdegbHcHGJTrOecBxaYFwz8FT6xTtlBalATKw7tNhkyeTvrddo1ZSHrUn4AFcVIJoY++6slnCSaFPkszHPZLaIFWZLMTvGAbkwmUPNWgObqt3w2xqdu1bIrowM8+FpxVVzaglnxZom7vW7XsrxA92s2xTulN3n+S3Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1NHWxmf; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3d0205bd5so1076935a12.3
        for <linux-nfs@vger.kernel.org>; Thu, 19 Dec 2024 06:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734616990; x=1735221790; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z6YBwMJMddvxRF9GPeR4xF0qL9ao6RJrvEfrnQxymts=;
        b=b1NHWxmf0hC4IYn8p3YeAUeLBHRcxpfBDi0vi9E5VuRuqhDYX8KkNljtgEP+KXyGWv
         5qV97hAjBPl1YSAthICDedms6r9zoN+ZWd+ue74ncz6HBbA55xRS+wANY2q7O3DdMmOw
         WkXnt44o2DQKLfjimQmvYy5UuiVPmjwTuZiyOnRJBNERQswupi1mt8hV0SKyzScHbWkx
         9hdviyqXu6oCcyoiDndnyW6shkCT5t9o6gE4McBN2aHltpfm2STKyzYal3q5zVnwEDnT
         7PLDnu6DBF5C2UlQty1dRBOpHjMWDQ1Lg7qKSsDZJHckPg+6dUADCqK3808vOZuO4vJV
         cuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734616990; x=1735221790;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z6YBwMJMddvxRF9GPeR4xF0qL9ao6RJrvEfrnQxymts=;
        b=CjfddBjZMwd7efN0+ccv4iuAHu+B6ulHt++XIhRSBwHoSgCOmBJ9YhexZsgsClVrs9
         iEU9m9uo2IpWvcNfBpeWARghyiXBere7uLoF61TAVRuNaFyBM8QrJa3PE2JxKaT0N1bs
         xIKIscUIqydwufCWvXwd3fKbhD7UB6hTNQKUbPj/M4/gCPFsMTpTIF1DP3ERogzLzOkK
         l9TCdi5Qaw4dKrJATXa4wRDYwvrwnvXfBvWEkTBsL+5/RTYUcaeWD569bpvumw2t73p+
         XiKX6o6ajqdVktmb8pDVGPEizp4v4jRgMYoU96LwtD8pyiZeR1Lkyb7BrMt/wPjLvGl/
         9Ueg==
X-Gm-Message-State: AOJu0YwNP0SaC9OxU2oARt0kDmZ/Vb9Gk3ENBEPizApxeDyfgQBLIwY2
	INDPcGiM/WPSSA1hF9fJiOd9YRMJTaArGn7AC/BXjlQFHwef7ynEPflJqiNnUPUa2Y88cKZUigw
	OLGUZZWTwd9p3VMke6g/ROjgaPdJTlTR65L8=
X-Gm-Gg: ASbGncup9WtvWouv0V9+pSXcyTdAomcFsz4s4EAdYEH91m0oa8FXVSFTAIDiMZ9xTAJ
	n/8mIXOXQBvcEuZbxbI2/UJx0ZZ48zqi2uGBKZg==
X-Google-Smtp-Source: AGHT+IHEay6XMZv2U6TLKFYxf9NKSwMfMQxv1mIEqe2fpOtyo98Hmqa4XIojF1FXNb4mjP3j9tL9biH5jnB+Zm0oUHE=
X-Received: by 2002:a05:6402:430e:b0:5d0:c9e6:30bc with SMTP id
 4fb4d7f45d1cf-5d7ee3ba973mr7235255a12.10.1734616989185; Thu, 19 Dec 2024
 06:03:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0Udmn=AqRBAcBPf8=VAP3KN4f-vnEJFLg3OnkyRdT3b9rw@mail.gmail.com>
 <173389119653.1734440.2969556830872479972@noble.neil.brown.name>
In-Reply-To: <173389119653.1734440.2969556830872479972@noble.neil.brown.name>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Thu, 19 Dec 2024 15:03:00 +0100
Message-ID: <CALXu0UdNBHzLSXVVXOeH1sm6GvB5sqeL=2bRrY8nCxz1gunedA@mail.gmail.com>
Subject: Re: [patch] mount.nfs: Add support for nfs://-URLs ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Dec 2024 at 05:26, NeilBrown <neilb@suse.de> wrote:
>
> On Tue, 10 Dec 2024, Cedric Blancher wrote:
> > On Sun, 8 Dec 2024 at 23:12, NeilBrown <neilb@suse.de> wrote:
> > > > +
> > > > + /*
> > > > + * |pnu.uctx->path| is in UTF-8, but we need the data
> > > > + * in the current local locale's encoding, as mount(2)
> > > > + * does not have something like a |MS_UTF8_SPEC| flag
> > > > + * to indicate that the input path is in UTF-8,
> > > > + * independently of the current locale
> > > > + */
> > >
> > > I don't understand this comment at all.
> > > mount(2) doesn't care about locale (as far as I know).  The "source" is
> > > simply a string of bytes that it is up to the filesystem to interpret.
> > > NFS will always interpret it as utf8.  So no conversion is needed.
> >
> > Not all versions of NFS use UTF-8. For example if you have NFSv3 and
> > the server runs ISO8859-16 (French), then the filenames are encoded
> > using ISO8859-16, and the NFS client is assumed to use ISO8859-16 too.
> > mount(2) has options to do filename encoding conversion
> > NFSv4 is an improvement compared to NFSv3 because it uses UTF-8 on the
> > wire, but if you use the (ANSSI/Clip-OS) nls=/iocharset= mount option
> > you can enable filename encoding conversion there.
>
> I cannot find any evidence that nfs supports iocharset- or nls=
> Other filesystems do: fat, isofs, jfs, smb ntfs3 and others.
> But not NFS.
> nfs-utils doesn't appear to have any support either.

Gentoo-based ClipOS&RED FLAG Linux certainly support that, first one
for iso8859-16 mapping, and the second for GB18030. I don't know if
this is in mainline or not.
In either case mapping to local encoding is required, or as Roland's
comment indicates a mount syscall parameter to indicate the encoding
of the export path string.

>
> So I think that the string you pass on the mount command line, or in
> /etc/fstab, will be passed unchanged over-the-wire to mountd (For NFSv3)
> or passed to the kernel and thence to nfsd (for NFSv4).
>
> Do you have evidence to prove otherwise?  i.e.  can you demonstrate a
> case where changing the LOCALE causes a mount command that previously
> worked to stop working?

For SMB certainly yes. For NFSv3 certainly yes too, for example if the
NFS server runs on a filesystem with a different encoding than the
client. Might be even a subset or superset of the encoding used by the
other side, e.g. server uses Level GBK/5, but client only Level GBK/3.

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

