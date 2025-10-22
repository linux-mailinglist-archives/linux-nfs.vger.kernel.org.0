Return-Path: <linux-nfs+bounces-15492-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B14FBF9F6B
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 06:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9649519C7B9C
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 04:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9AA199E9D;
	Wed, 22 Oct 2025 04:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHY9UCsM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553F52D7395
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 04:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761108002; cv=none; b=TXWhKfCQTK8MVBpRpPI46uIrhXKQs14xQWN/sfK7krrYPvcvuURHZUzwQPQzv5W3fWKgHREbqGK73KAPwm15R/FBIAMTOVClAAarPcRpVcb48uEO2cVNh2G9islMwkX36Fq2kQFhhHQQ04KC2KZMY5peeFGZ1AL7FJX5jTDuRYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761108002; c=relaxed/simple;
	bh=ld3/eNFPLY60lt+IfJihL1BDtR0im6CUyfF2eWumV4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8WqnYJzRf5QcNFjW/LhO7G060iypfkP4HFhqBoVkphqqqPG6jWQGDzNo5y16V0XpXM8+Zjs/hk4DKYdr3K4E4t5108LzWYO5EoZe2fTTjK60GoMPXY060PpBy5Cy8Wc8dNi3oKCWujKabZBabT00FI2k308F8jlazQxeL7AcBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHY9UCsM; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63c4f1e7243so6089357a12.3
        for <linux-nfs@vger.kernel.org>; Tue, 21 Oct 2025 21:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761107999; x=1761712799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gcIWpCfhJL6hBxoRz2avBVbdzuoekMr6bFmgI7HFrU=;
        b=RHY9UCsMxS1Ca9btNKQSfC7ykasuymUnNiCO38Ppoo0U0n1cqtfLBkAcPSIVUcnwTy
         3GwOhyh4XH3TiAfLPObiPMGSziQoIHybXSowXOIMGA5KnyBLtJ4Ummc7vMoosC2rceZo
         EdlQ5xX3A098Esibbo5hVoUKG8AqPWRoxPJppopTvAK5/Vnu5O3dItpmnCKrhf2B/UXN
         klzJfMsq/yc4s9jiaY+G2R4GTOIIGZtfodKmTvAPHWoWVb+KVqdu6FLqdJE1vJqqwcqE
         iuiu+rX35b8ABzTP7stnsdr4IqJYTrbU5pNBDdoTKVtFVwjV2R/LzD0hNuv+y0+lnyJf
         Z69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761107999; x=1761712799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gcIWpCfhJL6hBxoRz2avBVbdzuoekMr6bFmgI7HFrU=;
        b=ayKbc1CbAgefE3EVX9sjEKcCwdNnVVhImFH2CEO3fPmQJ0lcycu7JyDs6+WbCZKxGl
         CmhIlisfcuXwChgzIDdPUVZYPw1Z24uzHxYLpPSDx5IhGbZAwcCFKcEballgN2IMbc+O
         WP3e23XYE9y3vuEJbm8btmi9w9drOPG4ea4o5JqX/YzdkQfZrU7N6C8dIRWGO210bdoK
         IfcD7FLWmBqqvuxc5qj2pfK62/oRvjlEn28PlrXR+l8vXCXiOzNaGzshk5iqMj3WC9IG
         CHtO+wzGt6C7tEyU7RAa9jr+2eOpFsHA5rWm4V8y0iSnzGmWQuaNhHb53eH7X7IW+nxa
         cwOw==
X-Forwarded-Encrypted: i=1; AJvYcCXxzK28aNn+a80/FAUsOGkmdGFl9JALx8RaslTHXcMF4VTqyYwB5m1E5/CrfuxDM9/ejHatQewWp/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+7XQWTSvVrPY3RtZz8BAyZPukc1G3RJ/27vzPjp8TziihLCf9
	nfanMYUOhw6zA01tUS7X3bIUP4C0SkSxPKBI+iDBmipCoere7uI3kvGi9xvAIIhLqOqq5Wk113V
	Sb6NWgR0wMYnSdgRK25ffZ2sCRcvtg88=
X-Gm-Gg: ASbGncuAAtqR+hOht36LrhYX3H66YQdy+aTDuZzrmjAudAlRV2BuaNGnz5QwQwZqHGl
	9sILd6QRHEsqO6ke/2ZLvTcrHQqHVsFuxuxkQowNRGTOoSorGvohArIwL7pxC4w3KguhHM1+VPa
	XsFjDB6lJARml12/wVC2KU+iHtd7Fljm2AnyG65gMbSNs2S4EhojQeXjUzgvJfVpcv0DSnkxz2x
	yxuxuh6DyeHrNNwUfPdkPDMPAMlDQY3NkEaxVKP0Gjhy5YKPW0xwUnrwuNu3yBVsTFOcPZ+arao
	zFntVtr3b6p87C4=
X-Google-Smtp-Source: AGHT+IHSd/93IEd4Mf8dHK30aphVlqAdJCT0S+NEWOivhVENBOPgJ3/RAW4iofRgxNakg4DSTQa1CtVepWHOJJL4c04=
X-Received: by 2002:a05:6402:1ed6:b0:637:dfb1:3395 with SMTP id
 4fb4d7f45d1cf-63c1f62ac10mr20025277a12.8.1761107998484; Tue, 21 Oct 2025
 21:39:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
 <fe16288e-e3f2-4de3-838e-181bbb0ce3ee@suse.de> <CAKmqyKP0eB_WTZtMqtaNELPE4Bs9Ln-0U+_Oqk8fuJXTay_DPg@mail.gmail.com>
 <ddadb1f6-d7e9-427d-baf7-814d2288a407@suse.de>
In-Reply-To: <ddadb1f6-d7e9-427d-baf7-814d2288a407@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 22 Oct 2025 14:39:32 +1000
X-Gm-Features: AS18NWAoKKDrp8EpUQELmqxYplrpYxne55FmSrIQzh7JZ6Y-E7isTMxYgqwoeZA
Message-ID: <CAKmqyKOcuUtiv_9g07+8fU7VdAdsKZ2ufAtgarSz=j9H1YP4dA@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] nvme-tcp: Support receiving KeyUpdate requests
To: Hannes Reinecke <hare@suse.de>
Cc: chuck.lever@oracle.com, hare@kernel.org, 
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, kbusch@kernel.org, 
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 4:40=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 10/21/25 03:01, Alistair Francis wrote:
> > On Tue, Oct 21, 2025 at 3:46=E2=80=AFAM Hannes Reinecke <hare@suse.de> =
wrote:
> >>
> >> On 10/17/25 06:23, alistair23@gmail.com wrote:
> >>> From: Alistair Francis <alistair.francis@wdc.com>
> >>>
> >>> The TLS 1.3 specification allows the TLS client or server to send a
> >>> KeyUpdate. This is generally used when the sequence is about to
> >>> overflow or after a certain amount of bytes have been encrypted.
> >>>
> >>> The TLS spec doesn't mandate the conditions though, so a KeyUpdate
> >>> can be sent by the TLS client or server at any time. This includes
> >>> when running NVMe-OF over a TLS 1.3 connection.
> >>>
> >>> As such Linux should be able to handle a KeyUpdate event, as the
> >>> other NVMe side could initiate a KeyUpdate.
> >>>
> >>> Upcoming WD NVMe-TCP hardware controllers implement TLS support
> >>> and send KeyUpdate requests.
> >>>
> >>> This series builds on top of the existing TLS EKEYEXPIRED work,
> >>> which already detects a KeyUpdate request. We can now pass that
> >>> information up to the NVMe layer (target and host) and then pass
> >>> it up to userspace.
> >>>
> >>> Userspace (ktls-utils) will need to save the connection state
> >>> in the keyring during the initial handshake. The kernel then
> >>> provides the key serial back to userspace when handling a
> >>> KeyUpdate. Userspace can use this to restore the connection
> >>> information and then update the keys, this final process
> >>> is similar to the initial handshake.
> >>>
> >>
> >> I am rather sceptical at the current tlshd implementation.
> >> At which place do you update the sending keys?
> >
> > The sending keys are updated as part of gnutls_session_key_update().
> >
> > gnutls_session_key_update() calls update_sending_key() which updates
> > the sending keys.
> >
> > The idea is that when the sequence number is about to overflow the
> > kernel will request userspace to update the sending keys via the
> > HANDSHAKE_KEY_UPDATE_TYPE_SEND key_update_type. Userspace updates the
> > keys and initiates a KeyUpdate.
> >
> That's also what the spec says.
> But in order to do that we would need to get hold of the sequence
> number, which currently is internal to gnutls.

The sequence number is in the kernel. After the handshake the kernel
takes over the TLS connection, so it's up to the kernel to detect a
sequence number overflow. My sending KeyUpdate patches do this, but
they aren't included in this series.

> Can we extract it from the session information?

gnutls can export the sequence number, but as above it doesn't
actually know the correct value (after the handshake).

> And can we display it in sysfs, to give users information
> whether a KeyUpdate had happened?

I don't think that's a good idea. Writing the sequence number to sysfs
seems like extra overhead in the TLS fast path. On top of that I don't
see why userspace cares or what it can do with the number

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

