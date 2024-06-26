Return-Path: <linux-nfs+bounces-4324-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C18918A2D
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 19:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607881F23CE8
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 17:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E47818FDC5;
	Wed, 26 Jun 2024 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="a01vH0Fl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D58B13B5BB
	for <linux-nfs@vger.kernel.org>; Wed, 26 Jun 2024 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719423218; cv=none; b=nEm0lyRnQ0NTJwREZl+3+6fp2cGXBDRlyXnMRO+0j5hKZ78Zxp2wdMLSzuDs9TmM212w41iEmDtOybDbSd/CD8PeMXG06CYxa4B0t914K1VFXb3AQl6TytFV7f0QT+At+g4HMZjlzFOe+5fIxDQrSYjrTatLl+8ddsOoH38K9rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719423218; c=relaxed/simple;
	bh=YLg4M/U9uNYkOAj3lbxNxuZ1Z6v4+G2aGpA0HKOEwZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUUhkWTsCSapmrs85dMo0cHgMzbQBobx5DcJFaG/MqG3gDOXPumlsAmkmHEXZ6pgWVIbD77xTBFhbkek04mmPKi0q1nlcOOzZL/337Eswnbk64zPSqH+Fr+m8kyQXoNCsY3ClZXiN7UQZp3ykIStDRfdyFuR5DHysAJTYdAYEBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=a01vH0Fl; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ec89b67b95so1821401fa.1
        for <linux-nfs@vger.kernel.org>; Wed, 26 Jun 2024 10:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1719423214; x=1720028014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvbmO0cWcSQflU7yGSkNZiQdKXQzBeCyzud6YiZaSzg=;
        b=a01vH0FlD5qbpxZK5AAZyGYoQSnZ4V2cY5K9mXbozja1W35wBxx6dmoS2xj8275lb5
         5zzYWzuCfn7tJFx33xnh1T8H7X2DMoVZVqDv3LzPVS+/eap4N8OtiGPeRD978yZoKfnw
         zZ1kBNlXH2j2jmuo4QrYPilAz8vrSV+9aeYgAOsyYgx4puM/nR/J3Ml+NC/q3pY4TFjS
         Pk50GBdot6FA7dg6zIEHU8RsX3SOJYk5+FkiuObehvzoewsjKCenMdtZ+ybW2yYSUovG
         n6LJoww3raI3Bpoe91tW7EKydJ9+9gsCM5/vC07T6FLLOgr9tyR9SIyWoTkaslwTWfvt
         /hpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719423214; x=1720028014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NvbmO0cWcSQflU7yGSkNZiQdKXQzBeCyzud6YiZaSzg=;
        b=jaKJv1VubaSGZ4rwvOy/chMpm9+Eesar+7qQmsbFI55HZA+0bKKWPxVs3YQEjqbrg2
         PYKiN/+N/tAFii1kffETiW5mUw1PWZni5WYNU6Q7a7XkBUgkL1FMTZOl/GOErg7gRgik
         b92nCpuBpKkbx8H+Pxv7hH58xY4FXlv7VyaP1c6t+oF1J6qiwuyWsXTxFVBQ0Qv1ZNMP
         QtUL5fV3lUGM7PZ5kIx4Q7BpecsjDjjNXAC3EavIXg9H9Nm5/jxfn6cHzNevyfiCO0xT
         vuxc1aXoSihxPrz2dZWiDuzSxPFFv47Z5imR0OAEUy81BvD+XwQuORreaoDjBiF39eC9
         4YhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtXQwFpfrVCB0lcujbbnZZeZbI+USHZtWvniuTQRgJKRO7/bY/cwNw9qIdqwyUbbLUaPl7431iBQmbZbAwyXinUrVWALyaPUa/
X-Gm-Message-State: AOJu0YwXGkCKFGd+CqkfhhznxhG8CrxhwXJ4YYY0livmPNGuGY0GC251
	h/OG7B1JeYTkqM3nU85QpSnyGOItbQyBaU401gbDzzqzEJfowicKaUzJ5eglapNoPURMpSB6BJK
	3avcrLav0jH13PSPMl/TFgQMhp+Q=
X-Google-Smtp-Source: AGHT+IFdi6SYYoaMlmAhLt4T+yes3PRBNLdvzLgzrLYC8z5/oQFDzsQicOlkffq/qUJjMupL8prh8q1Fns8AFL02fp0=
X-Received: by 2002:a05:651c:b0a:b0:2ec:4287:26ac with SMTP id
 38308e7fff4ca-2ec561d845fmr91296211fa.4.1719423214041; Wed, 26 Jun 2024
 10:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d489e2d7-d4ed-424b-8994-6abf36a01e06@oracle.com>
 <CAN-5tyFQpEdSnco8SZWY_nsZVdYhAg+x_EAMmbWW5uYutyDA9g@mail.gmail.com>
 <2f5cb9b7-3d8e-4ec6-a357-557c484431c4@oracle.com> <CAN-5tyE5XpM750=9rG0cfp4WHRxOtXAwvViVmc4kQEVnA1dmTw@mail.gmail.com>
 <fdd4e4ce-65eb-438e-88c0-2688b7fa196b@oracle.com> <CAM5tNy6eLnWd7vLU-K00OJsFxLpWr_S2g8fhbE0ZMMVgonBZZw@mail.gmail.com>
 <e839cc9e-ea5d-43b1-bada-5fc6a9971837@oracle.com>
In-Reply-To: <e839cc9e-ea5d-43b1-bada-5fc6a9971837@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 26 Jun 2024 13:33:22 -0400
Message-ID: <CAN-5tyEjD6TiiJBe1CPcEn1pQoe087p3evfhO2BVWXuhm3WuFg@mail.gmail.com>
Subject: Re: ktls-utils: question about certificate verification
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Rick Macklem <rick.macklem@gmail.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 9:29=E2=80=AFAM Calum Mackay <calum.mackay@oracle.c=
om> wrote:
>
> On 26/06/2024 2:04 am, Rick Macklem wrote:
> > On Tue, Jun 25, 2024 at 12:48=E2=80=AFPM Calum Mackay <calum.mackay@ora=
cle.com> wrote:
> >>
> >> On 25/06/2024 6:31 pm, Olga Kornievskaia wrote:
> >>> On Fri, Jun 21, 2024 at 1:39=E2=80=AFPM Calum Mackay <calum.mackay@or=
acle.com> wrote:
> >>>>
> >>>> On 21/06/2024 4:33 pm, Olga Kornievskaia wrote:
> >>>>> Hi Calum,
> >>>>>
> >>>>> My surprise was to find that having the DNS name in CN was not
> >>>>> sufficient when a SAN (with IP) is present. Apparently it's the old
> >>>>> way of automatically putting the DNS name in CN and these days it's
> >>>>> preferred to have it in the SAN.
> >>>>>
> >>>>> If the infrastructure doesn't require pnfs (ie mounting by IP) then=
 it
> >>>>> doesn't matter where the DNS name is put in the certificate whether=
 it
> >>>>> is in CN or the SAN. However, I found out that for pnfs server like
> >>>>> ONTAP, the certificate must contain SAN with ipAddress and dnsName
> >>>>
> >>>> Noted, thanks very much Olga, that's useful.
> >>>>
> >>>>> extensions regardless of having DNS in CN. I have not tried doing
> >>>>> wildcards (in SAN for the DNS name) but I assumed gnuTLS would acce=
pt
> >>>>> them. I should try it.
> >>>>
> >>>> Wildcard didn't seem to work for me in CN, but I may not have tried =
it
> >>>> in SAN; I'll do that too.
> >>>
> >>> I have tried to use a wildcard in the SAN and that didn't work for me=
.
> >>> How about you? Specifically, I tried in the SAN
> >>> "DS:netapp*.linux.fake" and tried to mount netapp119.linux.fake which
> >>> failed with "certificate owner unexpected" (meaning certificate didnt
> >>> find anything match to netapp119.linux.fake.
> > I don't know if this helps, but at least for the OpenSSL libraries, wil=
dcards
> > can optionally match a component in a DNS name or multiple components.
> > For example:
> > *.linux.fake could match netapp119.linux.fake, but not
> > netapp119.subnet.linux.fake
> > OR
> > *.linux.fake could match both netapp119.linux.fake and
> > netapp119.subnet.linux.fake
> > OR
> > *.linux.fake does not match anything.
> >
> > Which of the above is true depends on whether an argument to X509_check=
_host()
> > is set to X509_CHECK_FLAG_MULTI_LABEL_WILDCARDS, 0, or
> > X509_CHECK_FLAG_NO_WILDCARDS.
> > - I made X509_CHECK_FLAG_NO_WILDCARDS the default in FreeBSD, but it
> >    can optionally be set to either of the other values.
> >
> > I don't know if you guys use a similar call? rick
>
> Thanks Rick.
>
> The Linux handshake implementation (tlshd, in pkg ktls-utils) uses the
> gnutls library, rather than openssl. gnutls does consider wildcards when
> hostname matching by default, and tlshd doesn't disable that.
>
>
> I've just noticed, in the gnutls docs:
>
> https://gnutls.org/manual/gnutls.html#X509-certificate-API
> > gnutls_x509_crt_check_hostname2
> > =E2=80=A6 [wildcards] are only considered if the domain name consists o=
f three components or more, and the wildcard starts at the leftmost positio=
n
>
> tlshd uses gnutls_certificate_verify_peers3() rather than
> gnutls_x509_crt_check_hostname2(), and the =E2=80=A6peers3() function doe=
s check
> the hostname, so presumably the same restriction applies.

Right. the man page for gnutls_certificate_verify_peers3 does say it
follows RFC 6125 for hostname checking.

> That would suggest that Olga's example ["netapp*.linux.fake"] wouldn't
> be expected to work, since the wildcard isn't at the leftmost position.

Interesting note! Thanks for getting it. I was looking at the rfc 6125
and  it has this for the matching rules which to me seemed to mean
that my netapp*.linux.fake should have been accepted (but it's a MAY
in the RFC so there is that):

The client MAY match a presented identifier in which the wildcard
       character is not the only character of the label (e.g.,
       baz*.example.net and *baz.example.net and b*z.example.net would
       be taken to match baz1.example.net and foobaz.example.net and
       buzz.example.net, respectively).

> However, my testing was using "*.dept.domain.com", which appears to
> follow the rule above.

I also tried having a cert with DNS: *.linux.fake and that worked.

> gnutls doesn't seem to have quite the same level of option granularity
> that you show above for openssl.
>
>
> I'll test further later today.
>
> cheers,
> calum.
>
> >
> >>
> >> hi Olga, yes, exactly the same here. Wildcards don't work for me in
> >> either CN or SAN.
> >>
> >> What I've been doing in my testing, when the host full DNS name is > 6=
4
> >> chars, is to use the simple hostname as the CN (for ease of
> >> identification in e.g. "trust list") and the full DNS name in a SAN DN=
S:
> >> extension, and that is working well.
> >>
> >> thanks,
> >> calum.
> >>
> >>
>
> --
> Calum Mackay
> Linux Kernel Engineering
> Oracle Linux and Virtualisation
>

