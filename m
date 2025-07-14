Return-Path: <linux-nfs+bounces-13032-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23115B03C01
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 12:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410DB1884557
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 10:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2028D2441A0;
	Mon, 14 Jul 2025 10:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQU24HEG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EC4242D82
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489430; cv=none; b=CL/Sw1RQxBAPoJI9mt/0BYOf1Vqhc8P2mE5o59dc5ZSdWZsxepslFhvbdKpkrKk7JZ7z3Mb52NCjRZMV1OG3LVbXhaNsFs6Yo9oYTNQBNX8M288CnADXUL+X6CT87TlZlrCU1xU4c3BiDvC1ptiJtp6dDMvt3GZt/HgIxapZL+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489430; c=relaxed/simple;
	bh=YFZJyzp6VP2MfQRBo+jqXbFstnQqoRrfkBCH2qyU45E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=G/Zt3e2Nt4iid96AnGEEDoFgNoV7edFANtL1GLIGjqKzaLP3BbmkB0ZeSovfvUeorxcaqoOfboCbrPKTNmHT617Ym+ZxfT0XS6aKMtDQkiw2l9iD+rCcZOolsPqLnS5UA8Eylrcu15fGbcxuizFM2RfaKJCFkFPS2ZE2B3PdVgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQU24HEG; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-73ce08feeb2so2705163a34.3
        for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 03:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752489427; x=1753094227; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7w5+yNfGMnham7gbi9HDMG3AL4viWthlPAMjeNfmLc=;
        b=fQU24HEGqbpk9fXjBDCPsyv1gxRq2KhWsLYnRWI9mnCUz4HVyEYTUy3jiCH3B4Ewgh
         a4+gb00b7cD/O7Ho5gaFayojyUjr3oJemzDsAyOfAIBzYLiPcRrdB/TvFzc3pXtNkjN1
         8+PxkE6etcZwoap6nsjQLURPZewsKUfWJj8PNnyMhhfOr+m3sF9wJ/Ns3RuAXE898dUW
         HX+ihM2vdleua0EE1U3QXaXDj31I05t2Qa1PckHhVXmWpL8lZHfzE1CZE3b37IjXk0ev
         V+K5eEpq6GnONiRZWRbuoTIIjHvobFsi6mY9hq53//IDv2BOLQkqauuXXuHq7aCwmH7x
         9vug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752489427; x=1753094227;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7w5+yNfGMnham7gbi9HDMG3AL4viWthlPAMjeNfmLc=;
        b=ZYnUMvgFRhiwK2VGpvlG1iZ2OXG7zYiuY9p2l3UkOapbmOApicbWTRkZ/IRWXKqhPJ
         VaHIt85PZnviqHuPyZE5yntemUdsR93SJsUp1hxjH75QNELthLECDyo0XCTbUN0CFWj6
         AuXc5dUAHLpPNBpMSczEUtRYKlXI1qzkImcJLweyoD96ntam9nJkGwGFugT4fZc1jLhk
         8k7mybyt0gtpfvPmOWmin8dkHyc8dTC0fo0kFvwSVMKGUhQJM/nrCdLiGy7uLrINbgtm
         5j/ojHeGbNwBOJ2D7XqciKH4HT+hDBJQC5qUQd/uqIbxJh1iyqTzgQT8VQx+7dvcb5Jy
         Ui4g==
X-Gm-Message-State: AOJu0YymB6GhDcPkHMOa8kuRZuYDdil2LIthq3rKAZ8HWQtcSMuIsjXD
	zU3lvsW7UwkbjXK8+so4mtBCyShQNNKxiOH5JEEw6FI6iPbJDtmOjeZ4IBeQs1lY0Qzk1Jy2nwK
	Z9C7QFMVyqZ9JryDGOhR6CT+lKSzqGFS2nVoF
X-Gm-Gg: ASbGncvHiy3DCTG+uIcqMTwi25lLZP4zKrXdP1owG1uapZ9uQcAwt5EG/MXZkRCs660
	SKk78+o3I+SC9qpnW18v14WC8PaZh2Z4IaD1KQ/emfqPZ2ia8ubLJEOErpaV0SFKbmGfHklDn8d
	wy8Zg83K3jOVRnNQCpIFtac15VRqD0FZy72SsqX8b0jeuHDrkJ/pP8+2wsJhh/sxI6s/ltChGZw
	RKinsPorhGTojiz
X-Google-Smtp-Source: AGHT+IFoCzqUOi7TaC3lYWgX9EuRTP6BSqC93+7fwyh9mxmuAmN/zVUDsr4MuQLCXYjE3nuRTZLFWzmG0SxNjhX3vHM=
X-Received: by 2002:a05:6830:8008:b0:72b:aa94:6d26 with SMTP id
 46e09a7af769-73cfb1ce4ebmr5941125a34.18.1752489427464; Mon, 14 Jul 2025
 03:37:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618125803.1131150-1-cel@kernel.org> <CA+1jF5pJQePnFWWT7G5T3RXwcmwNyfo=phaXaUB0v7Br6yrgdw@mail.gmail.com>
 <CA+1jF5pP3MJQ6L8TBzfuBNRr-YZxefBpBrQSxRR2kJWSqjgYxQ@mail.gmail.com> <f6f3c22f-8c49-4f9a-937f-2103cd780f6e@kernel.org>
In-Reply-To: <f6f3c22f-8c49-4f9a-937f-2103cd780f6e@kernel.org>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Mon, 14 Jul 2025 12:36:31 +0200
X-Gm-Features: Ac12FXzBpqxPa3QhqEMb32yQowbX8pKzFYfdXsyxllXnIlczcENuNkr6adqUrss
Message-ID: <CA+1jF5qu31AjMpRxmZPVmWVvd_beXS=0egeCxbdthY13GDRiQg@mail.gmail.com>
Subject: Re: [RFC PATCH] Revert "NFSD: Force all NFSv4.2 COPY requests to be synchronous"
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2025 at 7:50=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> On 7/12/25 9:06 AM, Aur=C3=A9lien Couderc wrote:
> > ?
> >
> > On Wed, Jun 18, 2025 at 9:22=E2=80=AFPM Aur=C3=A9lien Couderc
> > <aurelien.couderc2002@gmail.com> wrote:
> >>
> >> On Wed, Jun 18, 2025 at 2:58=E2=80=AFPM Chuck Lever <cel@kernel.org> w=
rote:
> >>>
> >>> From: Chuck Lever <chuck.lever@oracle.com>
> >>>
> >>> In the past several kernel releases, we've made NFSv4.2 async copy
> >>> reliable:
> >>>  - The Linux NFS client and server now both implement and use the
> >>>    NFSv4.2 OFFLOAD_STATUS operation
> >>>  - The Linux NFS server keeps copy stateids around longer
> >>>  - The Linux NFS client and server now both implement referring call
> >>>    lists
> >>>
> >>> And resilient against DoS:
> >>>  - The Linux NFS server limits the number of concurrent async copy
> >>>    operations
> >>
> >> And how does an amin change that limit? There is zero documentation
> >> for admins, and zero training or reference material for COPY, CLONE,
> >> ALLOCATE, ...
> >>
> >> Aur=C3=A9lien
> >> --
> >> Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
> >> Big Data/Data mining expert, chess enthusiast
> >
> >
> >
>
> The tone of your original email suggested to me that it was a whine
> rather than a genuine request for more information.

Well, put it that way: I am not a native english speaker.

Imagine a world in the multiverse where the French retained their
colonies instead of the British empire. French would be the dominant
language of that blue marble. Programming languages would use french
words. Someone from the tiny leftover remnants of the British empire
would post in the linnaeus-sdfr@ (syst=C3=A8me de fichiers r=C3=A9seau, AKA=
 NFS)
mailing list, and that post would be called "a whine", because his
French is not perfect...

>
> Also the request for "training material" for individual NFSv4.2
> operations does not make sense. We do not have training material for
> the NFSv3 READDIRPLUS procedure, for example.
>
> Therefore I ignored the email.

OK, but as an analog: SMB is infamous for "too many" features, all
which can cause trouble. Over time SAMBA added controls to turn
features on/off or use different ways of emulation. So far NFSv4.2 has
no controls to turn specific features on/off, or even get statistics,
or put limits on certain features.

That IS a problem, which SAMBA and even Windows Server SMB have
solved. Otherwise you're at the mercy of whatever combination of NFS
client and NFS server you have, and that is NOT good.

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

