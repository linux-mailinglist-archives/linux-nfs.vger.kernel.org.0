Return-Path: <linux-nfs+bounces-16340-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8528CC56D0F
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 11:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8282F4ECDD4
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 10:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA8C2E611B;
	Thu, 13 Nov 2025 10:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQ90IUcC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1942E1FF7B3
	for <linux-nfs@vger.kernel.org>; Thu, 13 Nov 2025 10:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763029216; cv=none; b=Rdmx16b0Mr9QhE8LIo741nEdB2dog0ZvkFKx/AOuF80QiPo3dQOokRnKpKWHt0PqBRV2Lla+aVQdDjg1Nmq8Rux3jOGvJ7H0IvTDEJHPf7tZE49IkUMTbDNfN4Jzxe0mj9KrOObrwlTlSl2reEwR5fhyapt7//Rm9Ew4zoajL7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763029216; c=relaxed/simple;
	bh=DJZn8hUcr7qrXuuyp5TspC4wXrB7yMIW9ad/R+jXQq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2thK0EvtEo3Xya8Sv1NNPz7vvOiWWqEw985+u7+19jQ3X+Rso/THRnuJM3lSEF3AhDBxbpf+Jwwnw6+cU/IHwxHCn/UTZNDkzLhfu5uVNkrxZwKBfLpIYdYx5h1KlambzcWYRRu40pZ6uXoVf04OU0d3RfKNkj6A/EGarelRsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQ90IUcC; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b73301e6ab5so78895166b.1
        for <linux-nfs@vger.kernel.org>; Thu, 13 Nov 2025 02:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763029212; x=1763634012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaLuTVv6ogQrV7pgPnqPwD8BmOYnKQewjeQIkkX8Rks=;
        b=KQ90IUcCCH41by4dG9uXHjmxEo5GOXEmfOtimJWDiJwavXQuTtDnWq1if/VZ8HSypB
         2hUrhw6L+68gPf0/Z1ufmC9tBhHjiokV3HmlIc7qctyuRzsbs+R+ZHBft4RouFGgexwL
         bw0uWxKOofubjtRVFsTjr3fzJmS/QmERzmYsHYzQ1kL9sj+sDMI8DQv19V8arpNwZXqN
         ozFmniPWds1+k62xnGe9YZL/G+f9o4iDlKpVBNAo9J3FSmIHI2vkOfgy6fXSswnmp6qi
         skv0RtfKNocC3V6ly44SzP3Viot49KNOsaH4yEPBC6xNJ3JUPxuhHJg/CQFcqI+V+/Ie
         hWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763029212; x=1763634012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IaLuTVv6ogQrV7pgPnqPwD8BmOYnKQewjeQIkkX8Rks=;
        b=js2c3C9xgZiX/cRJiMapL4pHQ9bWvgx2OH/7v0/6NOZ05CubuY2WelM0UvLz8y+NUI
         7FowKiFOc4BmXp+NmHu4u6bH/PGwsIs0OnoMhuG55TIl7Zjg7x9l3Nd65ymDUQ9doH4t
         bIlHXnDNC7RxjLhcvQs6XxJu6TIQf/EbfJgZKhQzbgfAP1u+o8ZrbtVFBaBw+kivzmnk
         8bIY5Ldcm4UE7Ykwd0BTZHmZI1ZLvAfOm2/jzrWRpDtHuI26AghQDtExj5AD3q8JgZlV
         kNkW/dh21BLLoFfBr20/dRY+XU9qZ7YIqeXkAm3Kyl1LWzEcFTT9hXwy5Fxh1n58fum7
         3D/g==
X-Forwarded-Encrypted: i=1; AJvYcCUBXAxpNxhRomY3cb5Ynu/gTYDS+B4BP86d2E+obKO/GAIZjsyTCzksjFym8jMPPHy5KUN9SPdAQVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNsBWA4IKC2vUGrkMy9nxT6LZMImAaHsUXIosWNalrBZoi1WnW
	fp6DybkAumESHXIMXkfVFkU0gtuXOkk298iVJtUFVkxLKLcDH6XECL1pM6C8t5yRy/4AyOfZ2HY
	mYfrxgZdX1qhSCyB0H2wBWST99OzgTRI=
X-Gm-Gg: ASbGncuh4k7TJ5Y091B2kXzCMPU4dXErIHTcQS6Xu+NB5CZ+3Mm9f3LpDZHzLU+lwJD
	BRfAgoCQn4IKZiNIOmZN9YP240dJyRsWHMyaOLaH3pnN3whxIHmwEWTGRlpZ/rJ+UX2CXJky7qv
	mTKsQbj237ZTOJ8+x08N2weA7W5CoN3gLKuCEZcMWnR2BxXih9auRidLErC6emFEKhvwmrvx+Pd
	evxSIoZLVo39rt1Kgj+20os1DiwYoyJRNDcZqHlJ3JuHgQsmLmcJoz5zoC5kj6hmbdAanJqlaCs
	XbhxWkNT7teD+y4=
X-Google-Smtp-Source: AGHT+IHW+MEeffc/pTPQLmL7Dde2CnR8q/jO4iZvJp6R/AepiIuZRquQtp0We7AMZrEbstFQ9LYr74m01iZsJkJ+N6k=
X-Received: by 2002:a17:906:f58a:b0:b72:6d3e:848f with SMTP id
 a640c23a62f3a-b7331a372c0mr637454366b.19.1763029212208; Thu, 13 Nov 2025
 02:20:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-3-alistair.francis@wdc.com> <49bbe54a-4b55-48a7-bfb4-30a222cb7d4f@oracle.com>
In-Reply-To: <49bbe54a-4b55-48a7-bfb4-30a222cb7d4f@oracle.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 13 Nov 2025 20:19:45 +1000
X-Gm-Features: AWmQ_bkRDLojedW15PfOpNiK2JsU2DoevPnRuJfyF_0Rq1ckrKQa8VpTESFPsDE
Message-ID: <CAKmqyKN4SN6DkjaRMe4st23Xnc3gb6DcqUGHi72UTgaiE9EqGw@mail.gmail.com>
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

On Thu, Nov 13, 2025 at 1:47=E2=80=AFAM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 11/11/25 11:27 PM, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Define a `handshake_sk_destruct_req()` function to allow the destructio=
n
> > of the handshake req.
> >
> > This is required to avoid hash conflicts when handshake_req_hash_add()
> > is called as part of submitting the KeyUpdate request.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > ---
> > v5:
> >  - No change
> > v4:
> >  - No change
> > v3:
> >  - New patch
> >
> >  net/handshake/request.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/net/handshake/request.c b/net/handshake/request.c
> > index 274d2c89b6b2..0d1c91c80478 100644
> > --- a/net/handshake/request.c
> > +++ b/net/handshake/request.c
> > @@ -98,6 +98,22 @@ static void handshake_sk_destruct(struct sock *sk)
> >               sk_destruct(sk);
> >  }
> >
> > +/**
> > + * handshake_sk_destruct_req - destroy an existing request
> > + * @sk: socket on which there is an existing request
>
> Generally the kdoc style is unnecessary for static helper functions,
> especially functions with only a single caller.
>
> This all looks so much like handshake_sk_destruct(). Consider
> eliminating the code duplication by splitting that function into a
> couple of helpers instead of adding this one.
>
>
> > + */
> > +static void handshake_sk_destruct_req(struct sock *sk)
>
> Because this function is static, I imagine that the compiler will
> bark about the addition of an unused function. Perhaps it would
> be better to combine 2/6 and 3/6.
>
> That would also make it easier for reviewers to check the resource
> accounting issues mentioned below.
>
>
> > +{
> > +     struct handshake_req *req;
> > +
> > +     req =3D handshake_req_hash_lookup(sk);
> > +     if (!req)
> > +             return;
> > +
> > +     trace_handshake_destruct(sock_net(sk), req, sk);
>
> Wondering if this function needs to preserve the socket's destructor
> callback chain like so:
>
> +       void (sk_destruct)(struct sock sk);
>
>   ...
>
> +       sk_destruct =3D req->hr_odestruct;
> +       sk->sk_destruct =3D sk_destruct;
>
> then:
>
> > +     handshake_req_destroy(req);
>
> Because of the current code organization and patch ordering, it's
> difficult to confirm that sock_put() isn't necessary here.
>
>
> > +}
> > +
> >  /**
> >   * handshake_req_alloc - Allocate a handshake request
> >   * @proto: security protocol
>
> There's no synchronization preventing concurrent handshake_req_cancel()
> calls from accessing the request after it's freed during handshake
> completion. That is one reason why handshake_complete() leaves completed
> requests in the hash.

Ah, so you are worried that free-ing the request will race with
accessing the request after a handshake_req_hash_lookup().

Ok, makes sense. It seems like one answer to that is to add synchronisation

>
> So I'm thinking that removing requests like this is not going to work
> out. Would it work better if handshake_req_hash_add() could recognize
> that a KeyUpdate is going on, and allow replacement of a hashed
> request? I haven't thought that through.

I guess the idea would be to do something like this in
handshake_req_hash_add() if the entry already exists?

    if (test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags)) {
        /* Request already completed */
        rhashtable_replace_fast(...);
    }

I'm not sure that's better. That could possibly still race with
something that hasn't yet set HANDSHAKE_F_REQ_COMPLETED and overwrite
the request unexpectedly.

What about adding synchronisation and keeping the current approach?
From a quick look it should be enough to just edit
handshake_sk_destruct() and handshake_req_cancel()

Alistair

>
>
> As always, please double-check my questions and assumptions before
> revising this patch!
>
>
> --
> Chuck Lever

