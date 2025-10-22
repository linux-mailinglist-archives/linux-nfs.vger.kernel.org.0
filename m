Return-Path: <linux-nfs+bounces-15556-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4344BBFE9AE
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 01:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8AA819C4D2C
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 23:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE72229617D;
	Wed, 22 Oct 2025 23:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efeT9fCl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFA32737E7
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 23:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761176887; cv=none; b=YxUOTXIsDbGCeWBb7DGNBmye/nAqmX987rri1TjerR7t2SgNgERcQ0WREZqCcDMzH0wm0CQAKy6GN9fAx/UKlkXTDOMvfxb4r8ZFzg6FAjtxQ+BbK+/O2OIFCgj4PHpIUAFTBpI8/dvK7wZXjyc+tIkllPRJ0AS97NBlgjDJuAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761176887; c=relaxed/simple;
	bh=5WC3d0KpMF9e1+s5VMDuJD8IYrVBfMCqdA+27vs3t+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1yG6N8mlhde0LWtEkWBNKGFJvv6UxHa1gbemxrhVdz5PORaBRJUf7FR7NYMGS1yg/hiYyEPZAiiIgG0DMd8GgsnhPyNfXSSbrWSpfb8chegMn1H6HCHe3+UAovXUovsnmk1lmneZRyllEKCzhs8OiUA2EufU36kVqT4n7x1xdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efeT9fCl; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63e18829aa7so198356a12.3
        for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 16:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761176883; x=1761781683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8mc7PEqKOdaKhhTWaiaacMdTM34oWGDw4sC0YwwFDk=;
        b=efeT9fCldGu0FwWHmP7IoseAh2X8ED0TgpvCaR2jNVypdAdHLS/v3lWwHoINELvbOy
         LRR+w87P2RaxwbZ1VwlWkcvttIv+l6sVyGH6plEM1oUhzQ+sbcr1rbj0fqOZVccgW2TG
         J4SWKbFCiwHI+Rirn9tT03g5d+P01HrJfnp26Q2TLB+TVOVEP3a2qJmB7CYvIhPu2V4r
         4+QpZQ7WpkqUrrVbjs0S+o8WSRal+Ykxl+7aEqSiU2esr3LTNu3J5235+awk1tpCG5ZG
         cUFsPukSzk5Uc1jCLTJtovhhqLzRZl+hta6BJmByyZrhIheT3jVy3pQwINcvuAqdc4Em
         7cuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761176883; x=1761781683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8mc7PEqKOdaKhhTWaiaacMdTM34oWGDw4sC0YwwFDk=;
        b=oWZU5KkzLcBW36Sa7Qt6NStEbEDD3NJgvab9TPfypQbjWmISb59Y5wgNZCNGyttjoQ
         +eRNyZSt/OzQC9v3raQKra0OQLEaa57T4EyzeCt3TYdCyQw73lu+bVNgHHZm+jsun0W0
         LovRrFpJ2DX6n2a3BXhmoghnQy4MKtAM8YzWSO24zo+z1WrZ3b6zZH7MtzWkX7hbNFIV
         C3X4mOXWJw9Pa3bJ/FmnDcEt9QOU0p5WoKKu/qs+R51x9cEnRbM7Wss/u6IwMibKA0tH
         hlTdLrYRdKEXAyMLY2/R++jVWkJJdVv0mkv1ejMO+f/np+7c41cXT7auf9xxyd16cNfq
         G8oQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5t/VX7+GCCNgOv+tXMiMm1scAogYC56JT9DjoKg6rLdVgbS+Tm7gliu2XJMJXAdZcOBZGv2nN6eA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzB6GHvjkgi+Uyc+rVhQ47ypfmtlvlfZU/MmNHuTiiN6qrPhbh
	CviqwO8j7cCJkVnDU/NuCvXtkRrsupgINXUypnPNwFbTR4JgQQHS12MLyrQ2IOYwyNYXck4/3ey
	MfmweKvpYQytdNwFX4SFeLpQCFfOtl2I=
X-Gm-Gg: ASbGncu2TRVOMJqo1iWH1RzZyVEDJg7jIx6l+RsdY9iUFDdKApFe7HMKu/VbfCP55ww
	rSv8zqjBRIctvsC+DjwcYh5PRWkncD06tooNV15lw0G/LyjaeVs2wFzkrUaqThFNC40tTE1kQvM
	2J6Po3t/GnZkud9yYGvVDWMzoU4HnU5L5FP8SErbC+eLpx56t/5QkYB5KiMQwY90MZLYlVgkN2O
	z3UWQVWFondPBS7d4Jwv+ESsm1qkny0rlZ7YUOb41bL/DvTK0ubw3LAzPufzXGTKKsmivREl8aU
	XiVzzt102cIvmjA=
X-Google-Smtp-Source: AGHT+IFPvjCt3lhgdIMR/r39w4zk8tY3v7Ryh/JdZW1xA1CBJlkaCdErToOC3Wg0Fzc0bAc9ofaTJC6DzyBMlI3b854=
X-Received: by 2002:aa7:c958:0:b0:636:a789:beb9 with SMTP id
 4fb4d7f45d1cf-63c1f6dc078mr15321500a12.37.1761176882672; Wed, 22 Oct 2025
 16:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
 <20251017042312.1271322-5-alistair.francis@wdc.com> <e7d46c17-5ffd-4816-acd2-2125ca259d20@suse.de>
 <CAKmqyKMsYUPLz9hVmM_rjXKSo52cMEtn8qVwbSs=UknxRWaQUw@mail.gmail.com>
 <CAKmqyKNSV1GdipOrOs3csyoTMKX1+mxTgxnOq9xnb3vmRN0RgA@mail.gmail.com> <7afb2fc0-0da5-4539-a1a4-87360186cf65@suse.de>
In-Reply-To: <7afb2fc0-0da5-4539-a1a4-87360186cf65@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 23 Oct 2025 09:47:36 +1000
X-Gm-Features: AS18NWAK6TMWNZNySx8pysumGySsDeNzwXFu97eObXc75NSy-iZ6pjnX1U1P9V0
Message-ID: <CAKmqyKPuESAp3nGJNDSw13_TnQLtfjSEAUdFyKrtww46ytJdEw@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] net/handshake: Support KeyUpdate message types
To: Hannes Reinecke <hare@suse.de>
Cc: chuck.lever@oracle.com, hare@kernel.org, 
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, kbusch@kernel.org, 
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 5:03=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 10/22/25 06:40, Alistair Francis wrote:
> > On Tue, Oct 21, 2025 at 1:19=E2=80=AFPM Alistair Francis <alistair23@gm=
ail.com> wrote:
> >>
> >> On Mon, Oct 20, 2025 at 4:09=E2=80=AFPM Hannes Reinecke <hare@suse.de>=
 wrote:
> >>>
> >>> On 10/17/25 06:23, alistair23@gmail.com wrote:
> >>>> From: Alistair Francis <alistair.francis@wdc.com>
> >>>>
> [ .. ]>>>> @@ -372,6 +384,44 @@ int tls_client_hello_psk(const struct
> tls_handshake_args *args, gfp_t flags)
> >>>>    }
> >>>>    EXPORT_SYMBOL(tls_client_hello_psk);
> >>>>
> >>>> +/**
> >>>> + * tls_client_keyupdate_psk - request a PSK-based TLS handshake on =
a socket
> >>>> + * @args: socket and handshake parameters for this request
> >>>> + * @flags: memory allocation control flags
> >>>> + * @keyupdate: specifies the type of KeyUpdate operation
> >>>> + *
> >>>> + * Return values:
> >>>> + *   %0: Handshake request enqueue; ->done will be called when comp=
lete
> >>>> + *   %-EINVAL: Wrong number of local peer IDs
> >>>> + *   %-ESRCH: No user agent is available
> >>>> + *   %-ENOMEM: Memory allocation failed
> >>>> + */
> >>>> +int tls_client_keyupdate_psk(const struct tls_handshake_args *args,=
 gfp_t flags,
> >>>> +                          handshake_key_update_type keyupdate)
> >>>> +{
> >>>> +     struct tls_handshake_req *treq;
> >>>> +     struct handshake_req *req;
> >>>> +     unsigned int i;
> >>>> +
> >>>> +     if (!args->ta_num_peerids ||
> >>>> +         args->ta_num_peerids > ARRAY_SIZE(treq->th_peerid))
> >>>> +             return -EINVAL;
> >>>> +
> >>>> +     req =3D handshake_req_alloc(&tls_handshake_proto, flags);
> >>>> +     if (!req)
> >>>> +             return -ENOMEM;
> >>>> +     treq =3D tls_handshake_req_init(req, args);
> >>>> +     treq->th_type =3D HANDSHAKE_MSG_TYPE_CLIENTKEYUPDATE;
> >>>> +     treq->th_key_update_request =3D keyupdate;
> >>>> +     treq->th_auth_mode =3D HANDSHAKE_AUTH_PSK;
> >>>> +     treq->th_num_peerids =3D args->ta_num_peerids;
> >>>> +     for (i =3D 0; i < args->ta_num_peerids; i++)
> >>>> +             treq->th_peerid[i] =3D args->ta_my_peerids[i];
> >>> Hmm?
> >>> Do we use the 'peerids'?
> >>
> >> We don't, this is just copied from the
> >> tls_client_hello_psk()/tls_server_hello_psk() to provide the same
> >> information to keep things more consistent.
> >>
> >> I can remove setting these
> >
> > Actually, ktls-utils (tlshd) expects these to be set, so I think we
> > should leave them as is
> >
>
> Can't we rather fix up tlshd?
> It feels really pointless, erroring out on values which are completely
> irrelevant for the operation...

It's not that simple.

For example when we call "done" for a handshake or KeyUpdate we call
tls_handshake_done() in the kernel, which calls
tls_handshake_remote_peerids(). So the kernel expects the remote
peerids to be set.

I think there's a lot of value in re-using the existing flows (as a
KeyUpdate is similar to a handshake), but the existing flows expect
remote peerids to be set. We could duplicate everything just to remove
that requirement, but I don't think that's the right approach.

Alistair

>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

