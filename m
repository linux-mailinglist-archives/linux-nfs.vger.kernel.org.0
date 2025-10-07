Return-Path: <linux-nfs+bounces-15006-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1517ABBFEF8
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Oct 2025 03:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDA494F2A19
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Oct 2025 01:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C431F3BAE;
	Tue,  7 Oct 2025 01:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxBotesK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD4D1C5D7D
	for <linux-nfs@vger.kernel.org>; Tue,  7 Oct 2025 01:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759800180; cv=none; b=jAQwiETe2A6JqEO39zu+ROcy20wugQA1yVozt/qXF0EP6hjBadtqddCeYJOKvz0iETkyMmQ7qvBHKufMd52N0Mmj6rDiy4zTiIAWM8RT61WHTqKi3GY20qTaoggh1cy3lE93ccBbgkp84JZWfvh3jE5+2MwIvR861+vRqo4RxW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759800180; c=relaxed/simple;
	bh=00hx5O89+8fvzy4PkP6xQKJCZLvcQoPJKp5vdlCLTCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovt38MeiP7/ny6IOFBhtyb9xcVeiYd+ggt4aD8dn0k4RLlI7OcZrEeQDzUfdY3X1fqeCf+m4OI4oPbcpzEVa6voDfMuDmsWWvgd23LQwSnzaUBLg/YVKdvfV5+TatRLHzIDVZGd9j41BOedQ29O0QM/oUNcZRvkOSzxARF+Yfxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxBotesK; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-637ef0137f7so9256138a12.1
        for <linux-nfs@vger.kernel.org>; Mon, 06 Oct 2025 18:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759800175; x=1760404975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t47vpiwRUGgVZgrjR0ubmEzxDtialDVYBK5r+ezzR+E=;
        b=cxBotesKVT0kItaCi+pL79Rrdy7oHT/uuYEDZPxBFct+abfWG5d4HATokKErrW6Dov
         8LWvTC2r6AiCf/12ib4PyDnFYyo1rbz31IcEhzWeCLYpaSKEUVFq4CrOvMZcYr4gwbPH
         Rch5xtKR2oqwJ17lxy9L6RGmoGAb8ObcoCauAwoIW0IpqpzUe2Sni6rQnGMGgWvZ15tO
         FKv6HB/L4snlgopisxw6TsUTVEv4ItS6cxhYcXh7/Eh02tMMmtELMrwrTFJ4VNZmnNIH
         +w65691ilDaIiDGbzVQ0QX2hw5fXhO4qN25lkV5AUkqGod9x0m6/typnjfSkVxjdx92m
         rawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759800175; x=1760404975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t47vpiwRUGgVZgrjR0ubmEzxDtialDVYBK5r+ezzR+E=;
        b=noZ9VjPjsFqmy+ZNmIw7MSdBjabs7MzzT3QKjWMQ8wjwlhJzgsa/stD+4BZu/tyF4Q
         2PC587EIAu57qfqPx9w33HkTURJPQxXZeHjjzohEp7akSDGclZyQasUIu5q/bXcWemqF
         BgaSg/dYPZFLNhWWtNr3eONC45k4oaOD+16X+EEUlpfuSxPZok3QsCxcEuh6GNsUjFKl
         +jSZFg/5OJUWYDYWGMabon8OLxoGlcI49z6AtyHqRgrxuvtKc7qErohNGMKXewA5xYrx
         kcy5oelDq6e/GC/QM79CuAcG/7rFjN5pa2nYZVK/ZCjPNct25RGKKeylSLYQsOGImtJW
         ElmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR3hqyqxjOV9pxKH7tUfrHrDw0rmlmHbJtvGoDbd5UrOt7yF6lOACZPZmYm52GVA6peeP6WPr2yuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9OMEfhhbWMpv4tkoXCa5xg1/aCeQADfVmhc3YgEjOyeTmLcaV
	vqoHhfEMV+Z5MOofQEwH6wnq1EbjM05SFrqrxoenRFVmbB0T/WX8kUfh0hfuDm1ouWdmzRqy52j
	xB8Dqxbnyky0l+mGSQWAMH3DYgIKmC+1zmgq9
X-Gm-Gg: ASbGncuK3w2P14yhnJ75f+re3ag9HB03aMj9n5UMMoyVQgrsJYugEb2L/zcUuXw/dzT
	MMQNijsaH8cFzJm90LUlPnx3r0tIbDi4YS2I1EW96iJdIiMSKHpdWLyTGFzJNEmDcy/DV57YPqT
	haDDUfN0KNixFew/mzepXd3v5YorSsPnma9AYjNuC2NRgr6lMdqp7Y/RsuFZh6J6aTyX3GoVZxe
	/ELx+257HF3zzoGJ5KlREeMa1p7UrcfK9ATeuKtOTE+lq/42L1WEgj07fWGkQ==
X-Google-Smtp-Source: AGHT+IEqVioe1S+GxtMPUCva4kG5CmfdDTTGDPNdiniLUblABnKsGagheixLUyeC/Xqdz84Zg3zCalpzx4OwzsmlUYQ=
X-Received: by 2002:a05:6402:b0a:b0:638:d495:50a7 with SMTP id
 4fb4d7f45d1cf-639348fa973mr13226165a12.16.1759800175262; Mon, 06 Oct 2025
 18:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
 <20251003043140.1341958-4-alistair.francis@wdc.com> <05d7ba0e-fe39-4f86-9e46-7ba95fccdce9@suse.de>
In-Reply-To: <05d7ba0e-fe39-4f86-9e46-7ba95fccdce9@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 7 Oct 2025 11:22:29 +1000
X-Gm-Features: AS18NWA3ErD_gS2cWuFH4B1EU9R8Gp49Hxw1eP3L2D2MX2i73c7hEabcslLmzvQ
Message-ID: <CAKmqyKMRXKJTQciiqjPXYAFa6UUJ6xkTSdEfU+9HnyNTOx-BxA@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] net/handshake: Ensure the request is destructed on completion
To: Hannes Reinecke <hare@suse.de>
Cc: chuck.lever@oracle.com, hare@kernel.org, 
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, kbusch@kernel.org, 
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 4:16=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrote=
:
>
> On 10/3/25 06:31, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > To avoid future handshake_req_hash_add() calls failing with EEXIST when
> > performing a KeyUpdate let's make sure the old request is destructed
> > as part of the completion.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> > v3:
> >   - New patch
> >
> >   net/handshake/request.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/net/handshake/request.c b/net/handshake/request.c
> > index 0d1c91c80478..194725a8aaca 100644
> > --- a/net/handshake/request.c
> > +++ b/net/handshake/request.c
> > @@ -311,6 +311,8 @@ void handshake_complete(struct handshake_req *req, =
unsigned int status,
> >               /* Handshake request is no longer pending */
> >               sock_put(sk);
> >       }
> > +
> > +     handshake_sk_destruct_req(sk);
> >   }
> >   EXPORT_SYMBOL_IF_KUNIT(handshake_complete);
> >
> Curious.
> Why do we need it now? We had been happily using the handshake mechanism
> for quite some time now, so who had been destroying the request without
> this patch?

Until now a handshake would only be destroyed on a failure or when a
sock is freed (via the sk_destruct function pointer).
handshake_complete() is only called on errors, not a successful
handshake so it doesn't remove the request.

Note that destroying is mostly just removing the entry from the hash
table with rhashtable_remove_fast(). Which is what we need to be able
to submit it again.

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

