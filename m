Return-Path: <linux-nfs+bounces-11846-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76428ABECC9
	for <lists+linux-nfs@lfdr.de>; Wed, 21 May 2025 09:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938447A04B8
	for <lists+linux-nfs@lfdr.de>; Wed, 21 May 2025 07:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3F51B4F0F;
	Wed, 21 May 2025 07:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UW25oxAp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9C923504C
	for <linux-nfs@vger.kernel.org>; Wed, 21 May 2025 07:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747811275; cv=none; b=sCURjwMiHahTaSxC6B9fWsi64hkDZvxqM3ZfDuur/5ZZx7mXRYf2fJKiZTQ3TeAO2xMPCC7EUpdtHkFeq81hEHHqFFrlt6fYxG0wN/4eAMfqFmSs/0M/9UzpC82yStaO59UkO2cJSk8ULUHyvqtqqux+Wuj4OUSQpliQ2UMhAVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747811275; c=relaxed/simple;
	bh=ApLr7RdL+5vXBcFm9sJLZKE3UvHwmS3uJmHsS0dbah4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Kg/uUJMDmneRob4oVjuKCKBiBOzDTjGzn9cRMHI5u0AakI1SzsLx0WQ9kQVEIr9P0Psxo1MN3ewqOarfPXkNrvp2I/+2UHqMOADwSShUUxuFwxmAZuxDW9unA3Xg7/U5THSTksEui4ebPeRwUoCyDtTQE/VhO9LgCgfGOkaO0DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UW25oxAp; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad53a96baf9so722036366b.3
        for <linux-nfs@vger.kernel.org>; Wed, 21 May 2025 00:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747811272; x=1748416072; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApLr7RdL+5vXBcFm9sJLZKE3UvHwmS3uJmHsS0dbah4=;
        b=UW25oxApArwc2drBb0x1vuVgRP7KMpXPK6T17IHpBUT/ZnRMhroDMFqoCYISqLtJIb
         wyxnkA8PMxzP/RTre9IC5ZvXA220/Jn9VcZEdI3431SArp0o1kAVS3f4O2Wh8xULcwHE
         ne8vGfom421vSATWmaDzkI+1AsaNTJLzmRix1l1F5A3PPxbc0zIEP77umN1FbVrtyZH+
         u3VRYYosQnlg8qeOZrcMdoJkBNNCl9Il8XDnrhkfrMaKR5y1OuOCN0/SbdHYvMf3Zxrt
         MFPQ+s1VWJAL1MYhewxfsQ+su3JjtcaH0WjlWDXTeY1x8F9m7QP208DcN5PYnQBPVrB3
         /i7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747811272; x=1748416072;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApLr7RdL+5vXBcFm9sJLZKE3UvHwmS3uJmHsS0dbah4=;
        b=ePDQZQqT2iz436SbmTMdCH872A+HltKfDvtfmSqqqffrI3ukHOgtzxXVRRCkhUTXIh
         68hRIl1YGY9PSBfvlZ3v4HKpultmPF3OA5gjmqktDxeGycNg/kTVVTAhDYIryhg7YLe7
         bWyinzvTxLnLrEh8ZkJOlykVfpFbCDcDJKqe1hwSFMJLaEyz844rMYaankpibz5dSXHY
         kIv2ClkLPeNmK2p/3fWniC80ASonb16gaCY6/Htmd7V3vc1xvq3gA/ICnEpqUYk33R+k
         3h4kgIWY0LyOVQxX8utUeMJQF5AG9o/aBvgtqtQ0KoF+wxPvenOlJE4zeJgsqJRd9KFr
         p0ow==
X-Forwarded-Encrypted: i=1; AJvYcCUIMusNihQQXAHtVj9nURwaNs+3y9knPGTjs5GaOee7wGStX3sK9NrBPfqbJovnodXr+OzzJenvzhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo8r+t2ldJSfQgFaQ+gT0MnNXi9gNL+OBHIrxaFJMxWPEa3J4p
	AJYQO2/6te6sBrqjsWQmhGvi4MwQfgJL26WgetDKuw+rW7JsTrHrnYlY9gJrC3w2oHNO8g1cIdh
	LIU+PX8uKQZ7saIe2wxnIb6KpKayZtlo=
X-Gm-Gg: ASbGncsWDegczzMsvvaCuZ/7FVR/dRsu7lwQUmBP+1IszRBasjg9bPDEf56bBYa6Nm1
	emb6rUACkLupGbZ1gef1Q64fX8DRfKMSEeiRqV6Qgl4zBRxC+JQYd/trcGepe6nh5buMsmYGBZJ
	qBSby6+fLHxB6szX99bnRq9vq0a/mvn7c=
X-Google-Smtp-Source: AGHT+IGAWJFRZHzHjrpJdEJkgNRuQDwQn2rrz677P0fKR2CrYyJ2S+k1xI+bTs9dcvNFCG7JO+eGN8i+tAQDhgkSeaE=
X-Received: by 2002:a17:906:f593:b0:ad2:2569:696d with SMTP id
 a640c23a62f3a-ad52d48c3efmr1880718666b.15.1747811271826; Wed, 21 May 2025
 00:07:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANH4o6Pvc7wuB0Yh8sEQDRg59_=rUNtnpgJizZ5mmmGNgY5Qrg@mail.gmail.com>
 <CAM5tNy7MCKPgg7+fNJk3SkTp9Au6G=2XBK+8DfxKQQ8-GvaA=Q@mail.gmail.com>
 <CAPJSo4VU8UP1bzT=FssnBU2EAtLmVoKg4icxLA6bXmNUNtVF_A@mail.gmail.com> <CAM5tNy61mcXY8LoP-Ve2L7Qpb8pmtb=+MyfC5Q=otq7_Bc19CA@mail.gmail.com>
In-Reply-To: <CAM5tNy61mcXY8LoP-Ve2L7Qpb8pmtb=+MyfC5Q=otq7_Bc19CA@mail.gmail.com>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Wed, 21 May 2025 09:07:00 +0200
X-Gm-Features: AX0GCFus8Z9vhZse1J6DJe37cjCY5cuvBa_t1pUcMrnBnJwbCWa0WCogurWYMNE
Message-ID: <CAPJSo4UFPbwaO3=rwSOvG72EFrye8W3i3s+ztFJ8_DBY62zjjA@mail.gmail.com>
Subject: Re: NFS/TLS situation on Windows - Re: Why TLS and Kerberos are not
 useful for NFS security Re: [PATCH nfs-utils] exportfs: make "insecure" the
 default for all exports
To: Rick Macklem <rick.macklem@gmail.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, libtirpc-devel@lists.sourceforge.net, 
	ms-nfs41-client-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 20 May 2025 at 03:38, Rick Macklem <rick.macklem@gmail.com> wrote:
>
> On Mon, May 19, 2025 at 6:03=E2=80=AFAM Lionel Cons <lionelcons1972@gmail=
.com> wrote:
> >
> > CAUTION: This email originated from outside of the University of Guelph=
. Do not click links or open attachments unless you recognize the sender an=
d know the content is safe. If in doubt, forward suspicious emails to IThel=
p@uoguelph.ca.
> >
> >
> > On Thu, 15 May 2025 at 04:09, Rick Macklem <rick.macklem@gmail.com> wro=
te:
> > >
> > > On Wed, May 14, 2025 at 2:51=E2=80=AFPM Martin Wege <martin.l.wege@gm=
ail.com> wrote:
> > > What other clients are there out there? (Hummingbird's, now called
> > > OpenText's NFSv4.0 client. I was surprised to see it was still possib=
le
> > > to buy it. And it probably can be put in the same category as the Mac=
OS one.)
> >
> > Situation on Windows:
> > 1. OpenText NFSv4 client: We've talked to Opentext about TLS support,
> > and they do not know whether a market for NFS over TLS outside what
> > they call the "Linux bubble" will ever martialise. There is also risk,
> > both engineering and drastic performance degradation if the Windows
> > native TLS is used (this is a kernel driver, so only the Windows
> > native TLS can be used).
> > So this is not going to happen unless someone pays, and the
> > performance will not be great.
> >
> > 2. ms-nfs41-client NFSv4.2 client: I've talked to Roland Mainz, who is
> > working with Tigran Mkrtchyan on ms-nfs41-client (Windows NFSv4.2
> > client). Their RPC is based on libtirpc, and if steved-libtirpc gets
> > TLS support, then this can be easily ported. But Roland (didn't ask
> > Tigran yet) doesn't have time to implement TLS support in libtirpc.
> >
> > 3. Windows Server 20xx NFSv4.1 server: Other department went through a
> > cycle of meetings with Microsoft in 2024/2025, so far Microsoft wants
> > "market demand" (which doesn't seem to materialise), and cautions that
> > the performance might be below 50% of a similar SMB configuration,
> > because TLS is not considered to be a good match for network
> > filesystems.
> >
> > Summary:
> > Forget about NFS/TLS on Windows.
> Well, for #1 and #3 I'm not surprised and would agree.
> I would like to find a way forward for #2.
> I will take a look at the libtirpc sources and try and cobble to-gether
> a prototype using the OpenSSL libraries.

That would be awesome

>
> I am not sure how helpful that will be for Roland, but it might be a
> starting point. (It depends upon what Microsoft provides in the kernel
> w.r.t. TLS and whether the driver uses a libtirpc library built from sour=
ces.

If it works with steved-libtirpc on Linux, then it should work with
the libtirpc from ms-nfs41-client too.

Question is whether the openssl license is compatible to LGPL used by
ms-nfs41-client

>
> I do plan on posting to the mailing list for #2, since I did a short
> test drive of the driver.

Thank you



Lionel

