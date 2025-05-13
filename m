Return-Path: <linux-nfs+bounces-11689-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9AEAB585F
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 17:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABAAB7B416B
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 15:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D0A2BCF6D;
	Tue, 13 May 2025 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtWYTTHv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73A3259CAB
	for <linux-nfs@vger.kernel.org>; Tue, 13 May 2025 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149299; cv=none; b=ke00DMKQpfVhkZ/Xeud7mWSCZMuYyhw59EcdJ6yTF1FBABm+MeprSZFqcubjcm/8vmM4hfc1cwgbattt0mNPcKz02f6YTAEzgBMird8sBHQrRO/lq9ZuXsAPzarPEPeuOWX8dA5uP5t/pUf+HmmXnwAXOuqIFgfmo4zGXLKRb04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149299; c=relaxed/simple;
	bh=WRIw3U5CqPTABNPMzN1EgIT4AMWbRZ/OTP3b2Vy7bzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=f/HCDjRCt44fTVd13Qvf3WK74gWj+UkRVuZlWUDbEmtN4JAbxffjLHpl5nosN4dA+89v+QHPduACaj+Hiq+tZECdGVCGwEBGocNKR8o5195FxABWAtMZrkbW0GmmfjJK+DGu+VhLdUlVDw2v1aoP5S5Wpu8ocOAkXc0oeWj0Qno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtWYTTHv; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ad1a87d93f7so874197466b.0
        for <linux-nfs@vger.kernel.org>; Tue, 13 May 2025 08:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747149295; x=1747754095; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WRIw3U5CqPTABNPMzN1EgIT4AMWbRZ/OTP3b2Vy7bzM=;
        b=JtWYTTHvKE7K17tPoMuYSYPTrN8ka8eDcIyweMCTfupmHKnyqtftKJeqQpH+58sV/Y
         zO+u6SzpMH29ljYgbsQN7KAF2iK2ynHruQGOWOJmYOleVh/fPPjKgAU13tHJZvoT3hvc
         zXwBy3s5A+rpPmc2CwVcte332b43pm70i0C0mWkcy6f4H7jm3Ol7G/qGW6XyzGXsC4eX
         79nddeaMfM9trBwYH2D+HiaBytVwFC93Ln1Onkuk6Dg+2E3lkDv5HjBb1NB94bZJMFqF
         C6lSrIArevGSCnWryBD6/p4ZNcfSe/dVv6O4afUurk4W8Cpxfbt5WRYJopfC1ewezLLS
         BVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747149295; x=1747754095;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WRIw3U5CqPTABNPMzN1EgIT4AMWbRZ/OTP3b2Vy7bzM=;
        b=b96FahgPuTipYP/l7lV3eD/fPk9ZJ5vyDaAk2iRl/iCF920IS3gjNnXR7VlhloRkta
         YC5LvjuQxv70qeLePAYySb1nU0Jtlz/FNUysYrwuwFt9+uIVTyNTnfZbo0glLRX0tjmo
         RD4aC6Igu5NCS7BwR7rR1K0aK8XzJPfVSz2w5MT7iQ+6LsIAlApVLtyg7xSBvf3/QbX7
         OpxAJJhVxnQDvcSqyH4UdcCfkPokMmqT+1ipYisBxCKX1GpTDck61Zll2iNqV5KMKlUz
         VOnZNS7ylkHLZi05orrzojbKlH1YAcQqw+FHXMEouSMOSSEQFzCGrmYHXklsLtYmiO86
         unsQ==
X-Gm-Message-State: AOJu0YxJnTL7DYz1Z3oK/X0ek6ne+/6MrukznOr6+ugf84A2FhiLITPd
	XCHq/qA+IQiu3VSOzUKMLduDZjWWsG+mcxXwgrWVF/etvt9YF1n/hPKCzKuNs10xttCc20pQRBb
	EsnfCwawYqKPDBVlvEGbKIe0LJWgrt79W
X-Gm-Gg: ASbGncvhyMV5gPOozjEnwv/B0YAEaawN/T/MdgPhVEm/5LoHEcHxKIAFMS9/LnV628V
	5W5FZSJe29qMZ6ANAjs5XhsxL7QPSio7pS/BT5/OVAyRkAje54esGptRQyS4SYctmOhL33yLs+W
	YNBNSKbEjGFhlN5MR2qNXmknUktddAw80k
X-Google-Smtp-Source: AGHT+IEOOH/NMJxpHt/GotFAosZgNMd6gZ4uumkFfTcwbbNN5dnsUi3vez8MZg6ibkIpTvhCuX5aZcsNfKPqNB7/UBY=
X-Received: by 2002:a17:907:399b:b0:ad4:f512:733 with SMTP id
 a640c23a62f3a-ad4f51257a7mr51225066b.45.1747149295183; Tue, 13 May 2025
 08:14:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513-master-v1-1-e845fe412715@kernel.org>
In-Reply-To: <20250513-master-v1-1-e845fe412715@kernel.org>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Tue, 13 May 2025 17:14:18 +0200
X-Gm-Features: AX0GCFt4mhnby6sS0r-iHBfm0cKfEY38d74kwVMpErtW9QusmT1WWfakFidpU-g
Message-ID: <CAPJSo4W8cN6ZGuFDs4Dda6KDs29ggCrBOq4CJC5FGrXh+bYGGQ@mail.gmail.com>
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all exports
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 May 2025 at 15:50, Jeff Layton <jlayton@kernel.org> wrote:
>
> Back in the 80's someone thought it was a good idea to carve out a set
> of ports that only privileged users could use. When NFS was originally
> conceived, Sun made its server require that clients use low ports.
> Since Linux was following suit with Sun in those days, exportfs has
> always defaulted to requiring connections from low ports.
>
> These days, anyone can be root on their laptop, so limiting connections
> to low source ports is of little value.
>
> Make the default be "insecure" when creating exports.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> In discussion at the Bake-a-thon, we decided to just go for making
> "insecure" the default for all exports.

This patch is one of the WORST ideas in recent times.

While your assessment might be half-true for the average home office,
sites like universities, scientific labs and enterprise networks
consider RPC traffic being restricted to a port below 1024 as a layer
of security.

The original idea was that only trusted people have "root" access, and
only uid=0/root can allocate TCP ports below 1024.
That is STILL TRUE for universities and other sides, and I think most
admins there will absolutely NOT appreciate that you disable a layer
of security just to please script kiddles and wanna-be hackers.

I am going to fight this patch, to the BITTER end, with blood and biting.

Lionel

