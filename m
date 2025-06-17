Return-Path: <linux-nfs+bounces-12514-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF44ADC3E1
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Jun 2025 10:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A76703B84BF
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Jun 2025 08:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C58C28F519;
	Tue, 17 Jun 2025 08:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIDbaZIA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CC728E59E;
	Tue, 17 Jun 2025 08:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750147235; cv=none; b=nHiigYuXeTXt9FPm1Om/8sbx6EjuHc2l39DstMJ7JcBbN2YG7MtGdZZsQIEDQK0sRJ+x3XNMVJTV4Eq5jNFXuUFWsak8o5tsqKNZ7JvNVXTqjnFjTtEdkDjULuyg69aIeILmxRSmKRallCupfU1xGZDxvhrchySK4wI9NAFeYfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750147235; c=relaxed/simple;
	bh=jvXWAS+XoKyjgR6Dpr49k5hO9jM/ljMWObx/URUPfog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQg4Y8uw5Kyyg/hcAAcjMrnfOVKuBg/kuQFQ3tCP+ZOywHpPyAAVPWkNVahJd4zU1wp6tEaYzCreF7g+LFHVeiQjtydvRqwBnj4uEbKr+QZ3/LPKCM7nemw5irg7OLXTlmC5BSbf1nEUlU2t+igPP/DQ6q+2SXk7zHSpgdnox3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIDbaZIA; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60497d07279so11115000a12.3;
        Tue, 17 Jun 2025 01:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750147231; x=1750752031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvXWAS+XoKyjgR6Dpr49k5hO9jM/ljMWObx/URUPfog=;
        b=RIDbaZIAPQRcChybgXJuycsRDpa9mGJYXpptHsjaFp4oWDbxY3ZwrAgJjZQXGz/AB5
         tXAY+FruL+l2B+ECYNSXRz8HLB6zH9sxMf603L6J9/WMB3mKNpB8AK2iQDnpOle1mlSW
         J0D8yazmc5fk8+YkJQQ1RJqQWn8NvJnys/cJypFl916JwLJCuJpUWWo9apdWKaRwiDnq
         yZ9rCgO0pSzc+Oh4WGBgcNAMm9GYBpWDLn3CR2cC8ktuCfA8dIQsqiwsYQAUQwMRXTSu
         rmosFlb7AI+fcWAK/UtkiKoCsppc2eOElxK61JPRzrnHoR3MNl5UKBBXiYaUoT809q3d
         2MeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750147231; x=1750752031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvXWAS+XoKyjgR6Dpr49k5hO9jM/ljMWObx/URUPfog=;
        b=N+5ZHK+9ki9Z84WiQrK3k9z5aF2WZKcms59x+Lrcz+WUXMgx+s4CUXhBfrB2+2oB2I
         Egacv6+loQpn2ulfFPLxG5l1c6ZociwUylkRqVbyhebZG5DWfs6cgpOcWEdrQyc0pZvi
         kdVK100DiYiTS5ZunbKZARbouvFYYIvRkRA+vibuv1sAxu6Ulp6SNbQU/w+iS+ZAgLt+
         KVT4lhAYLD8IjLfrcTWLKd645vO/gKuy3otzGd2kj0tL7Q0qnHDxy/z70/D+3VljGnxW
         YpxrozvzWTxQ6T5IS4wV1wMaIC/ViySWIYPKgIc+ALCQ7X23TGSt0kzn0kDSaF8lUY5F
         SNkQ==
X-Gm-Message-State: AOJu0YwrbrzAzUl5Petau02z0YgUR8x4wDVWfL9Z8pVAOjWm5FhrgBFU
	fjM4Ru6HWw6yF31coA0lmyJTrzbkW+Qz4zXPKjVvpspYLG/oroQDyrRt3Vdl/IIY6xefSGQTCLR
	owzfLNeNrWD0o+ZeEkXUTF62NhoMWWlrahA==
X-Gm-Gg: ASbGncsvYeFUixj/HNnXAUvtTJxBM7kLMThdSGuZ6GQsWXXPBDVbyuFCVa5IngUsZ6u
	hhT+jtYfuGbqV+8B1zKfVNgniytiZCPZR4k5Zr76ocGo9wQD3TL5Hwxt6vBLWGcbBd36bKrcGhI
	ix+qJtLSFibhoZbGHiUICIN7ETna8atZvMKoXVjrUiZLCWGgYe/zXHDw==
X-Google-Smtp-Source: AGHT+IHn8xOsl0QJPzdPuwCxzcbmEdIXRb2kUiv+YzDFkUoHjIa8NAxhuvpDQEAdAt6QboeMaTpCAJoCmoc8JUZ8Sv8=
X-Received: by 2002:a05:6402:909:b0:606:baba:79f2 with SMTP id
 4fb4d7f45d1cf-608d0a188bbmr10524044a12.33.1750147231323; Tue, 17 Jun 2025
 01:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHnbEGLHGX2rMnf=S6CasoNyc939DTe-whcsjt9WhSWG920OoA@mail.gmail.com>
 <434f6474-b960-4383-8d61-0705632b4c33@oracle.com> <CAHnbEGJq-w4CMS1dg8UBraV+6kLMkmC-hO4Dq7f4z8Af6maitA@mail.gmail.com>
 <41e9ed40-311d-42ee-9fe2-5af3ecda67d4@oracle.com>
In-Reply-To: <41e9ed40-311d-42ee-9fe2-5af3ecda67d4@oracle.com>
From: Sebastian Feld <sebastian.n.feld@gmail.com>
Date: Tue, 17 Jun 2025 09:59:53 +0200
X-Gm-Features: AX0GCFsHVhgscIbJDN0NHhQgPfuzjRi8G-BjDqpxvliHZk2cQ57ARBvCYufRKYo
Message-ID: <CAHnbEGLuYq6vYqq9M3w+W0iR-r0OOeCfSD3cEV-yekAbo-yAQw@mail.gmail.com>
Subject: Re: fattr4_hidden and fattr4_system r/w attributes in Linux NFSD?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Cc: open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 3:45=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 4/29/25 9:10 AM, Sebastian Feld wrote:
> > On Mon, Apr 28, 2025 at 4:15=E2=80=AFPM Chuck Lever <chuck.lever@oracle=
.com> wrote:
> >>
> >> Hi Sebastian -
> >>
> >> On 4/28/25 7:06 AM, Sebastian Feld wrote:
> >>> I've been debating with Opentext support about their Windows NFS4.0
> >>> client about a problem that the Windows attributes HIDDEN and SYSTEM
> >>> work with a Solaris NFSD, but not with a Linux NFSD.
> >>>
> >>> Their support said it's a known bug in LInux NFSD that "fattr4_hidden
> >>> and fattr4_system, specified in RFC 3530, are broken in Linux NFSD".
> >>
> >> RFC 7530 updates and replaces RFC 3530.
> >>
> >> Section 5.7 lists "hidden" and "system" as RECOMMENDED attributes,
> >> meaning that NFSv4 servers are not required to implement them.
> >>
> >> So that tells me that both the Solaris NFS server and the Linux NFS
> >> server are spec compliant in this regard. This is NOTABUG, but rather =
it
> >> is a server implementation choice that is permitted by RFC.
> >>
> >> It is more correct to say that the Linux NFS server does not currently
> >> implement either of these attributes. The reason is that native Linux
> >> file systems do not support these attributes, and I believe that neith=
er
> >> does the Linux VFS. So there is nowhere to store these, and no way to
> >> access them in filesystems (such as the Linux port of NTFS) that do
> >> implement them.
> >>
> >> We want to have a facility that can be used by native applications
> >> (such as Wine), Samba, and NFSD. So implementing side-car storage
> >> for such attributes that only NFSD can see and use is not really
> >> desirable.
> >
> > I did a bit of digging, that debate started in 2002.
> >
> > 23 years later, nothing happened. No Solution.
> > Very depressing.
>
> It's a hard problem.
>
> Focus on the recent work. It appears to be promising and there have
> been few objections to it.

Do you have any reference to that work? Are there status updates?

Sebi
--=20
Sebastian Feld - IT security consultant

