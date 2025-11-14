Return-Path: <linux-nfs+bounces-16374-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC58C5B3C9
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Nov 2025 04:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A43463590CE
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Nov 2025 03:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1063427E074;
	Fri, 14 Nov 2025 03:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmA8koHh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2761F248880
	for <linux-nfs@vger.kernel.org>; Fri, 14 Nov 2025 03:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763091891; cv=none; b=D8ILZbgLHUQ2uZVnnQCKfinrkebzTMwXltnHyWId5+kr0mae4Y/DTRD1IHbtxOwrRe9jRGMDA3lEa9PjHrvbdmDgfWnVbWv3FhsXr0kQvd+CzEDF7+4D1k8a4p9Kj+Es8zQAM5zRKHMdmVkdkvami7iAZfsG6bW9VXc4cDQctw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763091891; c=relaxed/simple;
	bh=HfUdRnYR5OSZGlucD4l0cXr2QpMS0rVTqK8miUgIcn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTRepmWoLRK/RhyLTz/55GuVb6Vazjw8zvqEsvKwVxALuRMMiDZHXlNR7WGIZzwUvVcTGcgcVBSkmoaT9XmHkbwSube2nRiMuotpZbmfDgyvnKwAaMyb+YH6i87zHtBLcpxIhRofXC1oSrhM177uwEDjhxTkifWWY1PztUDQRNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmA8koHh; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b72b495aa81so183828066b.2
        for <linux-nfs@vger.kernel.org>; Thu, 13 Nov 2025 19:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763091885; x=1763696685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6mtqdCrs5s13DdsY7nLARbcmjZ6uHESPgGUhdIcOCQ=;
        b=RmA8koHhFyOa5gROx+J0dDBz3pV8Xg9hDuGLe/MfAWCZ/h2tXajR1x5UrtuTa8MKXG
         GF7Ar1R63J4UKj43hxM7QJ++1zksASVYF1rOk2A4GSFO2ysovtaox8d/6A1SU3Q9J2ha
         DGGkn/Xa54tGcA0OCezkCqie/ixojp883Z0JXe2ytKO7ekCQqT6mSHYSRtOOka6oQiFC
         A4+GK5Usf8cduQEoAOfD66I0n8igrT7REx4/lniKrTRlmy/RyTUZbMZORg6tg13jtgvR
         3VsqexpAhqqb9gFjfn3J1iwBR/JcNBsnLBWpyirDupDzlZJzvTfcwY3oFMYEnWmGkggJ
         /aaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763091885; x=1763696685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W6mtqdCrs5s13DdsY7nLARbcmjZ6uHESPgGUhdIcOCQ=;
        b=W8wdTlSmqAapCmXCnOgvIxWeoSVNc46SRn8pib3OgQEwrH43zvy6FDkZQIXtXzbWuu
         IbZaXSFy9RLNgmtiso7q1eCIGNQi9TgjHD2GowTrqIFlkRP+gmp7RXhnOxTX2eQh53Tx
         dG7dsYUuXobZDYjbtsEGsfFaZs7Jhu9CvrT9ctX6ffBRC8+qSXkXrQia+E9FAcBx25r2
         K3+0x8o19dRDxOUfLZhxBfy/NHRJ1hHOzLqGObZZk/1KsMDnWHKUmkmym+/PD+UG4O6h
         q/xWHhFsJv5EBRisYWMiaZS/eb6MMCaxgTZXChjbOZ6i6ftVOQCfFlXQOsU7ppxwuXz2
         g4PQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3vAANk1a/V5SDJT24ys9x3zct9VMAla0VKkCrMW3aoWOfPrDMAiPCaO9ohNuSfgCsGdxiCK68wSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLZhp0Op7j64uEu1fVFjV4Pxbo9yeMRscRE4cTPZ4mbK1DzdLW
	ktPVq94LPs2Oixdpx3WXoFCknqUNE8gM2SHPN7SVvKQCjV9awUzbnPteVxvSQUGhsdL+BsQTg1q
	PaWDPrhwj5xw3HTEZcic4yAO+PYh7nNk=
X-Gm-Gg: ASbGncvAWd+R0aVtNM385JyrXwLXcPktEqKtrhXRE50+cbA2J3xTz/BEEKl4Obc7Tmq
	HA04ZInpDu0Ro7taKvGAvZ38kK53Fc0bUxUVL5ilTAMjey9935Gk9OaOqzCBuQSszsmO/vVTUkD
	K2vMOjx6vnsfKybzu85WMwN/Il35lTeWLZqriXmhXNeJ57XvrJIcmCplWYrXoSFNdecb5DSCeBc
	vHEs4N0Mio7tOQKJS8HHw7mZImRmSof0AtC7GLfbmVprc33w/ZPXy+8xqieIwuzAym1h9dvuGmC
	veweP0pw8mycNeY=
X-Google-Smtp-Source: AGHT+IFeY6ExbhnLix/V8V2HiLoJfg49zjUIkHAqrWQ16NjMplNdRqeUyyg/UCDy4n1WKY6+b/r4V6jK0pS5c2c7MTg=
X-Received: by 2002:a17:907:7fa9:b0:b70:7d61:b8a5 with SMTP id
 a640c23a62f3a-b7367b6f8afmr165505566b.62.1763091885372; Thu, 13 Nov 2025
 19:44:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-3-alistair.francis@wdc.com> <49bbe54a-4b55-48a7-bfb4-30a222cb7d4f@oracle.com>
 <CAKmqyKN4SN6DkjaRMe4st23Xnc3gb6DcqUGHi72UTgaiE9EqGw@mail.gmail.com>
 <0d77853e-7201-47c4-991c-bb492a12dd29@oracle.com> <13cf56a7-31fa-4903-9bc2-54f894fdc5ed@oracle.com>
In-Reply-To: <13cf56a7-31fa-4903-9bc2-54f894fdc5ed@oracle.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 14 Nov 2025 13:44:18 +1000
X-Gm-Features: AWmQ_bkh-hR1xTkgsN4bcSSt81jUJ1aCCzsHDAZD7xu3wz-1oUVwA9mDnPBItVQ
Message-ID: <CAKmqyKObzFKHoW3_wry6=8GuDBdJiKQPE6LWPOUHebwGOH2PJA@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] net/handshake: Define handshake_sk_destruct_req
To: Chuck Lever <chuck.lever@oracle.com>
Cc: hare@kernel.org, kernel-tls-handshake@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-nfs@vger.kernel.org, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, 
	sagi@grimberg.me, kch@nvidia.com, hare@suse.de, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 12:37=E2=80=AFAM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
>
> On 11/13/25 9:01 AM, Chuck Lever wrote:
> > On 11/13/25 5:19 AM, Alistair Francis wrote:
> >> On Thu, Nov 13, 2025 at 1:47=E2=80=AFAM Chuck Lever <chuck.lever@oracl=
e.com> wrote:
> >>>
> >>> On 11/11/25 11:27 PM, alistair23@gmail.com wrote:
> >>>> From: Alistair Francis <alistair.francis@wdc.com>
> >>>>
> >>>> Define a `handshake_sk_destruct_req()` function to allow the destruc=
tion
> >>>> of the handshake req.
> >>>>
> >>>> This is required to avoid hash conflicts when handshake_req_hash_add=
()
> >>>> is called as part of submitting the KeyUpdate request.
> >>>>
> >>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> >>>> Reviewed-by: Hannes Reinecke <hare@suse.de>
> >>>> ---
> >>>> v5:
> >>>>  - No change
> >>>> v4:
> >>>>  - No change
> >>>> v3:
> >>>>  - New patch
> >>>>
> >>>>  net/handshake/request.c | 16 ++++++++++++++++
> >>>>  1 file changed, 16 insertions(+)
> >>>>
> >>>> diff --git a/net/handshake/request.c b/net/handshake/request.c
> >>>> index 274d2c89b6b2..0d1c91c80478 100644
> >>>> --- a/net/handshake/request.c
> >>>> +++ b/net/handshake/request.c
> >>>> @@ -98,6 +98,22 @@ static void handshake_sk_destruct(struct sock *sk=
)
> >>>>               sk_destruct(sk);
> >>>>  }
> >>>>
> >>>> +/**
> >>>> + * handshake_sk_destruct_req - destroy an existing request
> >>>> + * @sk: socket on which there is an existing request
> >>>
> >>> Generally the kdoc style is unnecessary for static helper functions,
> >>> especially functions with only a single caller.
> >>>
> >>> This all looks so much like handshake_sk_destruct(). Consider
> >>> eliminating the code duplication by splitting that function into a
> >>> couple of helpers instead of adding this one.
> >>>
> >>>
> >>>> + */
> >>>> +static void handshake_sk_destruct_req(struct sock *sk)
> >>>
> >>> Because this function is static, I imagine that the compiler will
> >>> bark about the addition of an unused function. Perhaps it would
> >>> be better to combine 2/6 and 3/6.
> >>>
> >>> That would also make it easier for reviewers to check the resource
> >>> accounting issues mentioned below.
> >>>
> >>>
> >>>> +{
> >>>> +     struct handshake_req *req;
> >>>> +
> >>>> +     req =3D handshake_req_hash_lookup(sk);
> >>>> +     if (!req)
> >>>> +             return;
> >>>> +
> >>>> +     trace_handshake_destruct(sock_net(sk), req, sk);
> >>>
> >>> Wondering if this function needs to preserve the socket's destructor
> >>> callback chain like so:
> >>>
> >>> +       void (sk_destruct)(struct sock sk);
> >>>
> >>>   ...
> >>>
> >>> +       sk_destruct =3D req->hr_odestruct;
> >>> +       sk->sk_destruct =3D sk_destruct;
> >>>
> >>> then:
> >>>
> >>>> +     handshake_req_destroy(req);
> >>>
> >>> Because of the current code organization and patch ordering, it's
> >>> difficult to confirm that sock_put() isn't necessary here.
> >>>
> >>>
> >>>> +}
> >>>> +
> >>>>  /**
> >>>>   * handshake_req_alloc - Allocate a handshake request
> >>>>   * @proto: security protocol
> >>>
> >>> There's no synchronization preventing concurrent handshake_req_cancel=
()
> >>> calls from accessing the request after it's freed during handshake
> >>> completion. That is one reason why handshake_complete() leaves comple=
ted
> >>> requests in the hash.
> >>
> >> Ah, so you are worried that free-ing the request will race with
> >> accessing the request after a handshake_req_hash_lookup().
> >>
> >> Ok, makes sense. It seems like one answer to that is to add synchronis=
ation
> >>
> >>>
> >>> So I'm thinking that removing requests like this is not going to work
> >>> out. Would it work better if handshake_req_hash_add() could recognize
> >>> that a KeyUpdate is going on, and allow replacement of a hashed
> >>> request? I haven't thought that through.
> >>
> >> I guess the idea would be to do something like this in
> >> handshake_req_hash_add() if the entry already exists?
> >>
> >>     if (test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags)) {
> >>         /* Request already completed */
> >>         rhashtable_replace_fast(...);
> >>     }
> >>
> >> I'm not sure that's better. That could possibly still race with
> >> something that hasn't yet set HANDSHAKE_F_REQ_COMPLETED and overwrite
> >> the request unexpectedly.
> >>
> >> What about adding synchronisation and keeping the current approach?
> >> From a quick look it should be enough to just edit
> >> handshake_sk_destruct() and handshake_req_cancel()
> >
> > Or make the KeyUpdate requests somehow distinctive so they do not
> > collide with initial handshake requests.

Hmmm... Then each KeyUpdate needs to be distinctive, which will
indefinitely grow the hash table

>
> Another thought: expand the current _req structure to also manage
> KeyUpdates. I think there can be only one upcall request pending
> at a time, right?

There should only be a single request pending per queue.

I'm not sure I see what we could do to expand the _req structure.

What about adding `HANDSHAKE_F_REQ_CANCEL` to `hr_flags_bits` and
using that to ensure we don't free something that is currently being
cancelled and the other way around?

Alistair

>
>
> --
> Chuck Lever

