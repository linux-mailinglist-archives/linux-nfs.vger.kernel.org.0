Return-Path: <linux-nfs+bounces-1081-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C503482D1CF
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jan 2024 18:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6D31B21175
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jan 2024 17:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3176F4E0;
	Sun, 14 Jan 2024 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZafKOWf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14812EAF4
	for <linux-nfs@vger.kernel.org>; Sun, 14 Jan 2024 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so9649608a12.2
        for <linux-nfs@vger.kernel.org>; Sun, 14 Jan 2024 09:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705254668; x=1705859468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BU3jvUTHr8EpjEsepz5PKwFD5mSb7BoWjcIIqtdRz+g=;
        b=aZafKOWfDXHfVGFial43dWRXfViYdiRhfF5419/6SmOdKHEAD+Uf989CLc195XK5Pe
         ewGGSYmvTbvpRQKQEWHG26tvIbBKUKM9m4zYBQCzO/k7ZkABh529IumkowxR5ynCw4l3
         D8vs4AdGaO1MqG95u0MHIGdDoogJVXX/T6qSizG8rkcBd9caz9F1SsRbUkCizwOPCqH4
         vDwjw8m1Eje7ZLXgEP/lDNJAqBtrs2Gpeccp5C5NxOVJ9WiYmz4hIFMMZNz0h6vths85
         2/Q2SNIiXGKc+t5bj/KAA81zPjRZIhXqQ0wW2aT5zDJvqzB76qh8hL7Czn9OWduLtFhi
         JG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705254668; x=1705859468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BU3jvUTHr8EpjEsepz5PKwFD5mSb7BoWjcIIqtdRz+g=;
        b=Klz/zlTJdXBpFJY+zxf3gdIklrMsBwd1Oz7lXP+Gh2OYFrE2UHGO0xbKzlP0qOAW00
         NvSe11eQCCmI1WGIG7pTzS7Khx0Mn9489TWr/Sx7PwiSXUp/Fln48fXqYc8mg+xOSR2Q
         LDoQPvxb13B+9cQpKsrDzmtboTR1NQ1d30Jr1M6PQdAsu/Nqc3KgGfYBl8UKJfiXDrA8
         V4cXjWJ3HoZck9VPPWcxryQgMAhx97HtTCrlgIp+yNxQHHut0kx5OaNqba45sjrXBDsx
         pjIHqzi+Z3Dmv6L+nmNwM/gfofHc32ZivtocIGIJAS9N5JAF3rqnhYwCT7wMueb6dsK+
         TUcA==
X-Gm-Message-State: AOJu0YzNtsGLxMD/EFIP2lQ0wKnRCCg7OMLvSrLEM44TFh3CTdmRgvQc
	+Kg5nANN9ou/j/d6zKRFrn6Oo5VbT+kjIsQWglk=
X-Google-Smtp-Source: AGHT+IHhL+ZDJW5vOjJoX+nAhpvcgtoy71+BJyAP8M1bIgwVY5C2Foq/3k1jOcJJ3d0J5J6g2vRJypMdkfUnlPey50c=
X-Received: by 2002:aa7:d994:0:b0:557:c205:a38e with SMTP id
 u20-20020aa7d994000000b00557c205a38emr1426005eds.103.1705254668101; Sun, 14
 Jan 2024 09:51:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCNcDtTNDRvUVjUy4BE7eBCgmkb6hfkq3P0jaGDC=OXg0=6g@mail.gmail.com>
 <CAKAoaQmmEv+HRjmBMrSMGZn9RQr8C=2W4yeX4vNnohXFJPCV5A@mail.gmail.com>
 <65a29ca8.6b0a0220.ad415.d6d8.GMR@mx.google.com> <CAKAoaQkZ+b7NfrVi=gu1vCJBvv10=k85bG_kZV9G3jE45OOquw@mail.gmail.com>
 <0cd8fbfc707f86784dc7d88653b05cd355f89aad.camel@kernel.org> <24ACA376-5239-4941-BE53-70BF5E5E4683@oracle.com>
In-Reply-To: <24ACA376-5239-4941-BE53-70BF5E5E4683@oracle.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Sun, 14 Jan 2024 18:50:31 +0100
Message-ID: <CALXu0UeyKvDNx7uM5RDynT=V8YXa27AZ1YNH_A9bBCvBsjrXxw@mail.gmail.com>
Subject: Re: kernel.org list issues... / was: Fwd: Turn NFSD_MAX_* into
 tuneables ? / was: Re: Increasing NFSD_MAX_OPS_PER_COMPOUND to 96
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Roland Mainz <roland.mainz@nrubsig.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Jan 2024 at 17:11, Chuck Lever III <chuck.lever@oracle.com> wrot=
e:
>
>
>
> > On Jan 13, 2024, at 10:09=E2=80=AFAM, Jeff Layton <jlayton@kernel.org> =
wrote:
> >
> > On Sat, 2024-01-13 at 15:47 +0100, Roland Mainz wrote:
> >>
> >> On Sat, Jan 13, 2024 at 1:19=E2=80=AFAM Dan Shelton <dan.f.shelton@gma=
il.com> wrote:
> > Is there a problem with that (assuming NFSv4.1 session limits are honor=
ed) ?
>
> Yes: very clearly the client will hit a rather artificial
> path length limit. And the limit isn't based on the character
> length of the path: the limit is hit much sooner with a path
> that is constructed from a series of very short component
> names, for instance.
>
> Good client implementations keep the number of operations per
> COMPOUND limited to a small number, and break up operations
> like path walks to ensure that the protocol and server
> implementation do not impose any kind of application-visible
> constraint.

This is not "good client implementation", this is bad design to force
single operations into smaller pieces.

This has drastic implications, and all are BAD:
- increased latency, by adding more round trips to complete a single
vfs operation. Right now the NFSv4 Linux server implementation already
has enough issues with bad latency
- increased volume of network traffic
- decreased throughput
- worker threads have less to do per compound, but the number of
compounds goes up. But neither are there more server threads, and the
per compound overhead is static, and just multiples with the
additional requests

This is basically what ruined X11 in the long run. The protocol split
everything into little requests, but over 20 years the networks did
not scale with the increment in CPU power, making X11 less and less
capable over the network. No one added more complex and powerful X11
requests, dooming the X11 performance over network.

So the Linux NFSv4 implementation is now doing the same, but at least
the protocol has knobs to scale it better.

Ced
--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

