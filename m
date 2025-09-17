Return-Path: <linux-nfs+bounces-14504-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1D1B7D304
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 14:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5438D1BC3D63
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 10:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B132EAB89;
	Wed, 17 Sep 2025 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bR4sv73W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6F22DAFA1
	for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 10:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758106634; cv=none; b=t1o3msYTh3sBuT+Wl9A/f9w0W1PPgNIIYZaJPaFJSJcPPPDIPiWMbii6+BdvhFfIcL21lr6697yTS3vpNA5DPfSPSHUN9YbUY0uqAv4edsYnxqo/FTZeXDfByKcWmiS/H2Usvhnhl7Rr5u/2ifUtwfel9cl4QsRdfD4M8PyzB9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758106634; c=relaxed/simple;
	bh=QmYrtoWSI1kIy/nJzwXJBLHjj0jj0mabKB7oxUIrXJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUmk8vPG3+Mou0H89sAJO0bhkGzKxCsBROAky4coMu6gLedN386q/lHaE4X23CzsHN5BsIe+L4l/vLwGMZzkHxjaNLYb3EWCDRLgmX8dI0DrMc4p4Im99+BPR6y0mLUXlEIOfWQFpBXquAj6wTDBgpFN9QgMDwrfN5VWhtJ8jWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bR4sv73W; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb7322da8so507321166b.0
        for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 03:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758106630; x=1758711430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwxczvPwBg4Uyzbb2S+36YkOcrWK5ImeOLTlbGUhTaE=;
        b=bR4sv73WBSutzyYADCMWCKSwFt1P57YfHqnR1MydAW8WaNykJzFMzOfFGrvFobjOQp
         HK8ItEw9x7mY+J6gsJfg4iH03IWix8hiGxV71Zy28mosp/9WTR5ZrVy3pqrYsjmHJ2op
         0/d4kHw+N6IaT7y2g/6qBn+bxaCgJOy6HA9uoBWMZgEkTN973Vs9B2dxiw2vyfPRDcVn
         5adZ8zg/519JEotfO7FEFQlZDHEL8RccuGSYcAhIvUu8g2EoDQ2uMHw0OBBYf+6QrHpR
         3sW04nWDsXcZfj0f59XSsgKQCJTWyNZqe8KBS7/CCQtp9SJweJxThm9FN17Me/Y2IF/V
         OjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758106630; x=1758711430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwxczvPwBg4Uyzbb2S+36YkOcrWK5ImeOLTlbGUhTaE=;
        b=QLpZBwdNZoN48cQ+mCq4oBk7THxHL9nEjjpFGDA/lHYDAnOOcYQ81zrt7l04Pi6woN
         dHmXq+DezJK5rw/0QTAEWSa3K/P/RCKg+oHG8m8y5luzb1hibBC2Pvvx9KbfABT5n6V0
         OOyeamM0NV548YTkMRvDsx+B1vmKTVjPIOHTl25UbshGTaHy+qgH3zBGgKDT+L9nO1bx
         7kKyaNc0LOWFA55yn4+miaSDIW5wq4aSeFWItcndKuM+WMFln5OqQzGfjVQP/FZpPVyH
         Iwc588h9F8d3HmpQpFDgBulnVvNacZp0xU8GDrUayRpgV7ybbEBxJiXWQGGyYUJywwde
         Lexw==
X-Forwarded-Encrypted: i=1; AJvYcCVUBJ4BJYJsOr0VhuJwcvMMAJzl9x2fzGjR54sgAL0G0CLyZxMf5o1wWhGbc+3l7WeV+4tScGsBSbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr8aGvw9z1zG170TUPwFAlTlcTXRjgZVhEOZ1+/1ixE/9yWhdL
	W6OGzyLiC1HGOrApPCmCKl3CbaoyIrgvIUIto7a9wxvDRJ2f0kNQFErTfMuY1fyJt8UNfS6cWz5
	Z3eZ29Dil2qvBBqjasydBSCjF+n/2KGA=
X-Gm-Gg: ASbGncviiNujtaW3TGSmL65YtwgcOKFQB41nQ/Yd1YBbEMMe8tPqVXq9i35PUclN+Rr
	oFHjP10WXfsW7pW6zjtnktmS03bFGmrGhlBGzhLt6h21bCokxADm6tAJCGVMBNreGEFGymcgg3P
	jCsP3qxIASqU0v1IdUh6xa/ANfrFSQg6xPqaD4ldXD60FRg4/mnBqAXC35bvRBNhkLsj+VBSyAn
	EaRgEdJ4xuzNUc6ryus4BduskrpoKSxQzobCw==
X-Google-Smtp-Source: AGHT+IFRxj/9mtl/X+fIrakzsiy5Ocq5giy1UUqC3+OR/MDKcOd65B6+Mg4kPuXc5cy2Khkk6gzSVw2BB+E/UtAWaGo=
X-Received: by 2002:a17:907:3cc9:b0:b12:162:8347 with SMTP id
 a640c23a62f3a-b1bb2d0f441mr214182466b.16.1758106630039; Wed, 17 Sep 2025
 03:57:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905024659.811386-1-alistair.francis@wdc.com>
 <20250905024659.811386-7-alistair.francis@wdc.com> <f1a7b0b5-65e3-4cd0-9c62-50bbb554e589@suse.de>
 <CAKmqyKM6_Fp9rc5Fz0qCsNq7yCGGb-o66XhycJez2nzcEs5GmA@mail.gmail.com> <e168255c-82a0-4b9a-b155-cb90e6162870@suse.de>
In-Reply-To: <e168255c-82a0-4b9a-b155-cb90e6162870@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 17 Sep 2025 20:56:42 +1000
X-Gm-Features: AS18NWCp6hE9_gHHY9RNWcNThlN_Ck6Xfvl_Pbkl6uhBvEylonTEL18YHTqIeJc
Message-ID: <CAKmqyKMLP7hOi4FNhBET9XfoNZv4MZ3OsSRA0=B42C3+Q7P1jA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] nvme-tcp: Support KeyUpdate
To: Hannes Reinecke <hare@suse.de>
Cc: chuck.lever@oracle.com, hare@kernel.org, 
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, kbusch@kernel.org, 
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 8:12=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 9/17/25 05:14, Alistair Francis wrote:
> > On Tue, Sep 16, 2025 at 11:04=E2=80=AFPM Hannes Reinecke <hare@suse.de>=
 wrote:
> >>
> [ .. ]
> >> Oh bugger. Seems like gnutls is generating the KeyUpdate message
> >> itself, and we have to wait for that.
> >
> > Yes, we have gnutls generate the message.
> >
> >> So much for KeyUpdate being transparent without having to stop I/O...
> >>
> >> Can't we fix gnutls to make sending the KeyUpdate message and changing
> >> the IV parameters an atomic operation? That would be a far better
> >
> > I'm not sure I follow.
> >
> > ktls-utils will first restore the gnutls session. Then have gnutls
> > trigger a KeyUpdate.gnutls will send a KeyUpdate and then tell the
> > kernel the new keys. The kernel cannot send or encrypt any data after
> > the KeyUpdate has been sent until the keys are updated.
> >
> > I don't see how we could make it an atomic operation. We have to stop
> > the traffic between sending a KeyUpdate and updating the keys.
> > Otherwise we will send invalid data.
> >
> Fully agree with that.
> But thing is, the KeyUpdate message is a unidirectional thing.
> Host A initiating a KeyUpdate must only change the _sender_ side
> keys after sending a KeyUpdate message to host B; the receiver
> side keys on host A can only be update once it received the
> corresponding KeyUpdate from host B. If both keys on host A
> are modified at the same time we cannot receive the KeyUpdate
> message from host B as that will be encoded with the old
> keys ...

Correct

>
> I wonder how that can be modeled in gnutls; I only see
> gnutls_session_key_update() which apparently will update both
> keys at once.

gnutls_session_key_update() only updates our keys [1]. You can use the
GNUTLS_KU_PEER flag to set `request_update` to update all keys.

> Which would fit perfectly for host B receiving the initial KeyUpdate,
> (and is probably the reason why you did that side first :-)
> but what to do for host A?

Patch has been sent and reviewed, just hasn't been merged yet:

https://gitlab.com/gnutls/gnutls/-/merge_requests/1965

>
> Looking at the code gnutls seem to expect to read the handshake
> message from the socket, but that message is already processed by
> the in-kernel TLS socket.
> So either we need to patch gnutls or push a fake handshake
> message onto the socket for gnutls to read. Bah.

Correct, patch is pending (see above)

1: https://gitlab.com/gnutls/gnutls/-/blob/master/lib/tls13/key_update.c#L2=
45

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

