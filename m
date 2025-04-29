Return-Path: <linux-nfs+bounces-11345-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA731AA0D2A
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Apr 2025 15:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E21757B69B3
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Apr 2025 13:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D612C3756;
	Tue, 29 Apr 2025 13:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAr7LmjX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD8D2D1F57;
	Tue, 29 Apr 2025 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745932249; cv=none; b=kQcRHeCmGUuZ4CIvGLh9wqdt4Tby815cdaZriqQUuyfSqZjLzpdMAtZzZPDdK1GW3tDovSsyvl4inYMOnha325HmpwZFjUwtXcrbaKRXWaGVPk1NCMqu/hp4toBp7FcpTLCbC+MkHg1+TCwCpNV2mQ7v8ZSJZcFylI1jM8Q1vdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745932249; c=relaxed/simple;
	bh=mG/3cBPhWoZ4//uiwOPbYdE5LxoJHw8wteYclJkBm04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=SCMo6/oRzvWhP+/VrienVXiwstN2/WJtl02iKfB6yGeP1hpqtfGyGpJIYNQHzPdxCwSfqJGYCb4pyHwk3pekb+OJpUNy2Dlkm63NAmyVuUXzTeNhG94UPF3bZfBit6pknJmBl2Uv0lzDNdnpc3tu04iD2pxVqw+dyuongh2BKEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAr7LmjX; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e8be1c6ff8so162678a12.1;
        Tue, 29 Apr 2025 06:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745932246; x=1746537046; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mG/3cBPhWoZ4//uiwOPbYdE5LxoJHw8wteYclJkBm04=;
        b=MAr7LmjXKeSoUr4zpKea/OVmZqlaKbl9M2qmXxUFRFhHa74+9MPNU6I6+BjQKNg/p/
         fwpY3egsLUd/1/JOlSYQvxzjO8CKc8+e4TxZ8+eaoMEig+T4IGOdA3cB467WwtX03aHY
         FtPMp4ckgYlQTpyytbbJjXcFAbP08DGyFMshiY5IIIO4jd3EIl57Y75xlTCpgBcpVJj6
         V32MC5uSUqk/uxuuxVG87kpqBLjwvuqStUf756bvsq3p4OX47742udN2QOK1FVGL060l
         mmidICh6QmOWt51S19qojKuWgtq1RmjhkGyNEkxgxhHl1W5xcSEc1/SLENfMWsarOU60
         enHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745932246; x=1746537046;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mG/3cBPhWoZ4//uiwOPbYdE5LxoJHw8wteYclJkBm04=;
        b=YPS06ndWlhWNwJJxHmczZ1t+fzwYyJ3y9NbaNM/idqQVJ6iosvHNDUwJvyShwV2SlC
         k/9GnzSDdASpkUVlhQVHchJCTn+UAAppw+mFNoAPfdJlVXCkAlg7tiZD0tDYf80HSrQS
         o2NKFa8GRKuQnJ/VJw6mki8TyUW7LjDuFk5Ty8E9Netz19uDVUZrHHjRXfzwT0MZYUND
         40SiJTFkug9wn9WmbOE4c9sUItoFFe8zSvLOPBWqCkbyPkMJY+PsIIsgTu43bUe5w1+m
         ttOknR79rmrRSmWotVP+tr/ITpwRdNzwuG7U2OcYFLi1WQ+Lbw1K2snqQ7OEqJebweuF
         nRSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNkzTRuStlJ4sPT+y0z5l6qsbEksJg1ivOMR2yIZSe2CumPtd5W41tbYo0OWG8LrCP2ljOerK9P3SEMmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQLtGUDeC5B3v/va/4vlFjDHl6WpjQ1ccDLn3Dnd9pDDfD+4uy
	awIP6DpCEl8kepfIVHfjKkhdyvzvWQ0WRT23D+VlOXvdbKgBeTpWu8yd/fviO1t25xGAoZT9xpX
	sOkURNzMeJ8jIkkqenESFz/E7qPsJSA==
X-Gm-Gg: ASbGncttf6aXRfxTQ2icLNBrTwM48ubheF7tOemP5YRiv7zv3TFfSYQ4dcaZbOggj2k
	fqPwIQiNdhctiVJVmQH51lQkpGKhxuQsO2wXfchN5IU5sfBcYVZHVgNVuW8Ow4xy3pmP+N2KHXW
	eMC4ncopf/md2YkJoioaxXwg==
X-Google-Smtp-Source: AGHT+IHQL3YrPJ78P0Nn0UgfG6GQBhKUiP1vhNl4VHz6hEbH8sVpjgXhCCcqLmPt7HqeDGRnvC0+Uk72gKjgnAXLohM=
X-Received: by 2002:a05:6402:268d:b0:5f3:7fe3:6838 with SMTP id
 4fb4d7f45d1cf-5f838891c1emr3482576a12.22.1745932245672; Tue, 29 Apr 2025
 06:10:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHnbEGLHGX2rMnf=S6CasoNyc939DTe-whcsjt9WhSWG920OoA@mail.gmail.com>
 <434f6474-b960-4383-8d61-0705632b4c33@oracle.com>
In-Reply-To: <434f6474-b960-4383-8d61-0705632b4c33@oracle.com>
From: Sebastian Feld <sebastian.n.feld@gmail.com>
Date: Tue, 29 Apr 2025 15:10:08 +0200
X-Gm-Features: ATxdqUEzYJh-ZDH8rsCb57P0tiaf5FqyKuM1gdw0oyv9XhS5uDa8nJMbvwAKOEY
Message-ID: <CAHnbEGJq-w4CMS1dg8UBraV+6kLMkmC-hO4Dq7f4z8Af6maitA@mail.gmail.com>
Subject: Re: fattr4_hidden and fattr4_system r/w attributes in Linux NFSD?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 4:15=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> Hi Sebastian -
>
> On 4/28/25 7:06 AM, Sebastian Feld wrote:
> > I've been debating with Opentext support about their Windows NFS4.0
> > client about a problem that the Windows attributes HIDDEN and SYSTEM
> > work with a Solaris NFSD, but not with a Linux NFSD.
> >
> > Their support said it's a known bug in LInux NFSD that "fattr4_hidden
> > and fattr4_system, specified in RFC 3530, are broken in Linux NFSD".
>
> RFC 7530 updates and replaces RFC 3530.
>
> Section 5.7 lists "hidden" and "system" as RECOMMENDED attributes,
> meaning that NFSv4 servers are not required to implement them.
>
> So that tells me that both the Solaris NFS server and the Linux NFS
> server are spec compliant in this regard. This is NOTABUG, but rather it
> is a server implementation choice that is permitted by RFC.
>
> It is more correct to say that the Linux NFS server does not currently
> implement either of these attributes. The reason is that native Linux
> file systems do not support these attributes, and I believe that neither
> does the Linux VFS. So there is nowhere to store these, and no way to
> access them in filesystems (such as the Linux port of NTFS) that do
> implement them.
>
> We want to have a facility that can be used by native applications
> (such as Wine), Samba, and NFSD. So implementing side-car storage
> for such attributes that only NFSD can see and use is not really
> desirable.

I did a bit of digging, that debate started in 2002.

23 years later, nothing happened. No Solution.
Very depressing.

Sebi
--=20
Sebastian Feld - IT security consultant

