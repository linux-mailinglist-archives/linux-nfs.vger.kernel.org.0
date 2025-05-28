Return-Path: <linux-nfs+bounces-11938-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC64AC5E96
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 02:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85353B8B0F
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 00:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F70C72634;
	Wed, 28 May 2025 00:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RENQXnJx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F7910FD
	for <linux-nfs@vger.kernel.org>; Wed, 28 May 2025 00:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748393866; cv=none; b=dgue6sFApz4/Awxe0PuUs2qYmFal3dDkh+a4lUh6MFmWeHMZJd1j00H9h2Ov8PpEbYlEVm+q5Pa42ylD5E+NI8zfQoPbf/pU/SK0aeYhjh8jPYtPPxBDmw0MuUYDYCQXYTtuIvrc2XcQ3OXZSnl81wNg9TS8PiAtN7tgYoGlGCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748393866; c=relaxed/simple;
	bh=zLbFnMFQXg0E5vXVI6xGdQmg3lIumC+gkVGNf1UA6y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3EmqvSmbXnhzhubBY4Vdy7ZYB4YJ3yS3KFnwiv72B31qKqlWSkYIbIc76uTcZBp2VjXj54CWzSHh2jqX0Fbp6OhI7PvTmgJfkHtCT0t4VzRNAvCf1GiNWSdhJsP6o/sFWlEVB5Pg6EsBscLG6hrbh2+caUQ1BQ+ArpdqwW47sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RENQXnJx; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad89d8a270fso69163366b.1
        for <linux-nfs@vger.kernel.org>; Tue, 27 May 2025 17:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748393861; x=1748998661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBLlFGekVXN25uY6dv5BuvCIHFLauYsVX6fqtD1q6Fc=;
        b=RENQXnJxEkGPiOUDGcVrhu65t+LRMFLwvgJVPvyZeZK0U/yDtlZN8wZK8qyIVI3F1u
         ukftGJiKH6mzFOIo9zgP3gEw4ZU5dXsAexaGIKDuBvmHSehbWVxK1mh9PMwO6zTjO7j+
         t2VFsCz5E1HWRLiYodpzowjGZ2X/ul6edZiBN06fPgzFRDFy7Pm2f3W+pWQbpN6MpBtZ
         BH2+whoqoYTJhzZ4tXANGQonrKV/j+DScEN/MYMNC2snUgqYB09kvnHeiPkQtkp68xr3
         DpOvcxNM262LSKA7nRvH2ZAi3qCpCRNcTMB4WiO1T1SEw5yFpyRJpQs4g/ehbYfzFBHw
         mskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748393861; x=1748998661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBLlFGekVXN25uY6dv5BuvCIHFLauYsVX6fqtD1q6Fc=;
        b=YGHPHe1UJo8CJ5kttWa5MNILIrwus5guqV6j9z0OZOVYDu8zkRtEdlA1Dpz1UIMjdE
         NhRvghvcTsxazmGsepvzItU/P+dPPvt8AxHXQz50toGFsVqBh8qcaL/poGDlzd9YuH6S
         c2RJinIiE9eYNqHiYEn2MvjyV4D6miY+yyooPTHatGceo9W0VmuFtUIMb+P+VaHX7Rjm
         LzcrXMVL+owOcQwZQC6wLfbVm1pE6MD6DZ6reReEAtk67J36Qm+GVcmJOT42RvI+9cqj
         Ueg4dGxer3n2Ap01Uf0XfbJYF6XyQhdbgygzvyqjwVDJk5lmCT/K6JOh9g1NcYUgqEy7
         /Tlg==
X-Forwarded-Encrypted: i=1; AJvYcCXV9VapkFXql4TX1vEpr/AJZhD9QBcKMdJJnWrSnRKlE3LlMxImoCqNHHChfSLW/e80uPUV7l9qwXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Y4OE3A5aRK9FhetVHBWu+Sb5uyzMKMYCTWpcKpPDSARP401O
	lSzckoV6MyyfT8rrs+YXf9vyYhfN/czOnxxsgCSLMxChJD5LNRLUdyntc7FLr3Xh0hhB+HBK8rT
	LQIbIpVvF/AAyxMOi3GcGSJy8ZYg8mQ==
X-Gm-Gg: ASbGncsN+0Z8GCZWRtLW7zBZM6okbO97VfAdSpNO0YzMdmz0UupjeN7epIkS5VBrnlv
	smQsBQkcdBf6luebG1HeV/cEwbgKJa/YyrQ09W2yUwhD8+HX/jyrrj8J1aOWsFwMkHibCxrsWvs
	Ihzy7HnbOCBRMKnH8EfdI8hz21zniPQWB8
X-Google-Smtp-Source: AGHT+IFG70UCQek3ji8b6qCisS9TzcPVGXNOiDsBqsy3U+1FQgC7i9W/FHh6zWUrQ/ujpSO2fKbctTFjAUyxu4ibhbo=
X-Received: by 2002:a17:907:d93:b0:ad8:5740:9932 with SMTP id
 a640c23a62f3a-ad898a1b625mr251880466b.26.1748393861002; Tue, 27 May 2025
 17:57:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy6ZJwSV9tmsyPHDjp3rLVFw6=dhs3ojxORqLNNnurGtFQ@mail.gmail.com>
 <174822657684.608730.17929019810730634619@noble.neil.brown.name>
In-Reply-To: <174822657684.608730.17929019810730634619@noble.neil.brown.name>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Tue, 27 May 2025 17:57:28 -0700
X-Gm-Features: AX0GCFtUDJbiy4EPCsRd0bKsTHLQu0IBbFDq29mjcbUa1u6Ozd1Mu-aDGIP8Yrc
Message-ID: <CAM5tNy71EoOKtZLE0Lpu9X-sNpQuhj8YfdUGheRPC3ZGFeOfYA@mail.gmail.com>
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all exports
To: NeilBrown <neil@brown.name>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Steve Dickson <steved@redhat.com>, Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 25, 2025 at 7:29=E2=80=AFPM NeilBrown <neil@brown.name> wrote:
>
> On Mon, 26 May 2025, Rick Macklem wrote:
> > On Sun, May 25, 2025 at 5:09=E2=80=AFPM NeilBrown <neil@brown.name> wro=
te:
> > >
> > > On Mon, 26 May 2025, Chuck Lever wrote:
> > > > On 5/20/25 9:20 AM, Chuck Lever wrote:
> > > > > Hiya Rick -
> > > > >
> > > > > On 5/19/25 9:44 PM, Rick Macklem wrote:
> > > > >
> > > > >> Do you also have some configurable settings for if/how the DNS
> > > > >> field in the client's X.509 cert is checked?
> > > > >> The range is, imho:
> > > > >> - Don't check it at all, so the client can have any IP/DNS name =
(a mobile
> > > > >>   device). The least secure, but still pretty good, since the er=
t. verified.
> > > > >> - DNS matches a wildcard like *.umich.edu for the reverse DNS na=
me for
> > > > >>    the client's IP host address.
> > > > >> - DNS matches exactly what reverse DNS gets for the client's IP =
host address.
> > > > >
> > > > > I've been told repeatedly that certificate verification must not =
depend
> > > > > on DNS because DNS can be easily spoofed. To date, the Linux
> > > > > implementation of RPC-with-TLS depends on having the peer's IP ad=
dress
> > > > > in the certificate's SAN.
> > > > >
> > > > > I recognize that tlshd will need to bend a little for clients tha=
t use
> > > > > a dynamically allocated IP address, but I haven't looked into it =
yet.
> > > > > Perhaps client certificates do not need to contain their peer IP
> > > > > address, but server certificates do, in order to enable mounting =
by IP
> > > > > instead of by hostname.
> > > > >
> > > > >
> > > > >> Wildcards are discouraged by some RFC, but are still supported b=
y OpenSSL.
> > > > >
> > > > > I would prefer that we follow the guidance of RFCs where possible=
,
> > > > > rather than a particular implementation that might have historica=
l
> > > > > reasons to permit a lack of security.
> > > >
> > > > Let me follow up on this.
> > > >
> > > > We have an open issue against tlshd that has suggested that, rather
> > > > than looking at DNS query results, the NFS server should authorize
> > > > access by looking at the client certificate's CN. The server's
> > > > administrator should be able to specify a list of one or more CN
> > > > wildcards that can be used to authorize access, much in the same wa=
y
> > > > that NFSD currently uses netgroups and hostnames per export.
> > > >
> > > > So, after validating the client's CA trust chain, an NFS server can
> > > > match the client certificate's CN against its list of authorized CN=
s,
> > > > and if the client's CN fails to match, fail the handshake (or whate=
ver
> > > > we need to do).
> > > >
> > > > I favor this approach over using DNS labels, which are often
> > > > untrustworthy, and IP addresses, which can be dynamically reassigne=
d.
> > > >
> > > > What do you think?
> > >
> > > I completely agree with this.  IP address and DNS identity of the cli=
ent
> > > is irrelevant when mTLS is used.  What matters is whether the client =
has
> > > authority to act as one of the the names given when the filesystem wa=
s
> > > exported (e.g. in /etc/exports).  His is exacly what you said.
> > Well, what happens when someone naughty copies the cert. to a different
> > system?
>
> Then you have already lost.  Certificates are like passwords.
True. But if the IP address must match that of the client's IP host address=
, it
limits where the cert. (or password, if you like) can be used.
(The subnet where the IP address is supported, for example.)

Without this, a compromised cert. can be used from anywhere.

>
> I guess 2FA is a thing and maybe it makes sense to check both IP and
> certificate.  But I certainly wouldn't want to trust only that the IP
> matches the certificate.  I would want to be able to check the
> certificate without even considering the IP.
> Maybe:
>  1/ Is the IP from a permitted subnet - if not, reject.
>  2/ is the certificate for an approved CN - if not, reject.
>  3/ Does the IP match the CN
>
> 1 and 3 could be optional.  2 shouldn't be.
I'm not sure #2 makes it stronger than just "it verified", since
verified means that the "password" is correct.

Now, I agree that the CN (or cert. serial# or anything else in the cert)
can be used to distinguish which certs. are allowed for which file system
exports. (Saves having different issuers to differentiate the certs.)
--> Put another way, the CN can be used to decide which file systems
      can be accessed and how, but it is not really useful to just say
      that the cert. is valid, since verification has already done that.

I also agree #1 and #3 are optional and their use really depends on
what the network topology for client->server is and ranges from useless
up to useful, I think?

rick

>
> Thanks,
> NeilBrown
>

