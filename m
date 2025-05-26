Return-Path: <linux-nfs+bounces-11910-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B792FAC3DAF
	for <lists+linux-nfs@lfdr.de>; Mon, 26 May 2025 12:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A70B7A1D12
	for <lists+linux-nfs@lfdr.de>; Mon, 26 May 2025 10:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3101F463C;
	Mon, 26 May 2025 10:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gj6NOAvl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8928B1A9B28;
	Mon, 26 May 2025 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748253997; cv=none; b=HD/ApUe1R/6An5Pz4vvTfuy//XRk9zHkXr5jcGUGEVurr91LaKzD7WJOsTYu/kPpBzC5njOzKTgsx9tDn0Nu+Y3WdjGTWq8DCPK9iNv6RpY1n/2VuR6UIF/ireBQE4k9rJOZRqngkAhXJ4gg1kFWP0IOJu+gnxO3H801BzaMUGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748253997; c=relaxed/simple;
	bh=wHuTCDqGbQazXhYURFiMHlcs6ZTg1HV4SgDfCGERDjo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbpY7paNuEal77OuQ477KuzUPabzyduhpwj3IiYEch8Vdx8GuaHZcpv9GEaZdY1AeaRdrsQd7k3d4rux4I0nQ2aWuDBSuEGk824+0vJ7AEg6TH67B+VxvLhIoSNRlKDVgID9s8fPLg5pzRPqq3glDH4FSn9JaZatHYGhrnGmefQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gj6NOAvl; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-442ec3ce724so17108795e9.0;
        Mon, 26 May 2025 03:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748253994; x=1748858794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPh1Ct6QshCKWmDEdMk7hCZKp6Jz8m7ODsFZr4dzpn0=;
        b=Gj6NOAvl3ndaXh1w0t5qvbCW3sveArO9S6ZMIWXiQaN3temLlg4BoWWMJpIbgcgLvC
         p1/2mqKtsm+UqXelEAC3dsYfFeTko1rQaBNRB6/hIonOiTWPJ3NRrD70EnQB5M+REtyz
         cBGrJBHQTVR/aUvNymlFnuOLZTLkREhSW+38SdoSV4YqOHP+0m70KUj32Ez05dBJPhx2
         YF1vgOcSbjdGkfaD+Yb+TJ7kvqCsX0bD3f5NAlmcZ7YSoZjufJjtySSB0vxazu5MIEBb
         2UZmSTvdrej5Hg7PGSgja0HOOhrgWwUFpjtouhhDyliR1uVR66tUqP/5OWD5ySqYoyQu
         AZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748253994; x=1748858794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPh1Ct6QshCKWmDEdMk7hCZKp6Jz8m7ODsFZr4dzpn0=;
        b=qYnREaR2a02RyHwXd7sgjyncEfutYAmpi3ZMFbYkMyaDFTMApTLMlDNcutPCCQ4h5R
         llpXLrwg0R3zADGJjLgJlrYhX/gVkr2B/DXKkkqaojA9HlaEYXpW3f2QYxo5ULAU9I+/
         RqK7cHU3y/XtfkxhadAAGCXyeYw8QQGjNhNZfnJvA9AXcGW3873WvfBCt623A6Y+UIr7
         L07JsgAdup70KCRgXxUw2DuCZPBEQrHYBxw5DKftJCitZsXuC+vYEvEx9iXrtttiz104
         +fl7LJowxVHt7I/cnuEcekR1bfQF7KAqKAe6c29BTKbc8i4GiGwASJqiqEV86B8qBjp0
         Utug==
X-Forwarded-Encrypted: i=1; AJvYcCVKnqAThd+GcD9aN1GM2RagO9YeTPkLdjufyZqHwxGg22C4uPGyE+lrJ50FIJqiq1707DIKeK/JB1IqkQ==@vger.kernel.org, AJvYcCX80qEOqiMsVwR+6b8l3lfN+KARm2FSOSihS0bvSiZlT60mgJwZmuxE5U1bw5RLrWlXjWnjDFVc@vger.kernel.org, AJvYcCXlLvDGPSHjhJRjUzCbSFgllUrvvSDkZzt19GOzY7ZHYnJ5dX/nrN5HYxBNO8ajddJKn7GPE992LsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGJMb6K+gQM/CRM1swoF8Kban2oo2iRNyhoZps2CVYhmlH5PsK
	YwfRX0uJY2V9oAtIndIadJY/uulMeOt9AAfLQ2Aa3rBrgwRWVT4nhloD
X-Gm-Gg: ASbGncusYoiTh/jlkl8CQ4BHt3HXp0gLwqNiVNWw4/aSLdhH8xwhW5YFRCLbDoFBp+Q
	tJN5W2h3FAW9dMbRtgOTnhmpZy4NnxRiBT6hKyCIjCMs/OsfCNHQgzF4/6KFXNRKPcOQX506JBh
	TkgiEr0RiHTnALd9WNtd+10u574ZkS+oWThwbqjjKl0LGkqKrhrb3sQCfMwYrckMdl2EVmW1/Yj
	JBIHdK8R4K4unFMtX/VO3w0xZSVR45/bE1+Xu/mJnQSGCmFsJJ2sBGy9jiyBxD6CA6sBdsq/QNV
	DkyLshMKV+9aTGA1iYz2MtqpztiDsBsYquhgPYaekYWUClqVl2QmV1llh5pIp0zw4d7eCAzHlx8
	1ncNBScrkibYBzA==
X-Google-Smtp-Source: AGHT+IFNZkvn3tGi7ARy4dpQ3TrKaZGPDzyR33srZYXPNzWELPLp52hjHD63j/jTAmYk0WDJMq4RNg==
X-Received: by 2002:a05:6000:238a:b0:3a4:d367:c5aa with SMTP id ffacd0b85a97d-3a4d367c798mr4219403f8f.20.1748253993614;
        Mon, 26 May 2025 03:06:33 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d67795eesm3561697f8f.86.2025.05.26.03.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 03:06:33 -0700 (PDT)
Date: Mon, 26 May 2025 11:06:32 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn
 <willemb@google.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton
 <jlayton@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, Keith Busch
 <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Wenjia Zhang
 <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, Steve French
 <sfrench@samba.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 net-next 1/7] socket: Un-export __sock_create().
Message-ID: <20250526110632.7ab3323e@pumpkin>
In-Reply-To: <20250526052907.GB11639@lst.de>
References: <20250523182128.59346-1-kuniyu@amazon.com>
	<20250523182128.59346-2-kuniyu@amazon.com>
	<20250526052907.GB11639@lst.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 26 May 2025 07:29:07 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Fri, May 23, 2025 at 11:21:07AM -0700, Kuniyuki Iwashima wrote:
> > Since commit eeb1bd5c40ed ("net: Add a struct net parameter to
> > sock_create_kern"), we no longer need to export __sock_create()
> > and can replace all non-core users with sock_create_kern().
> >=20
> > Let's convert them and un-export __sock_create(). =20
>=20
> The changes looks good, but the commit log including subject line
> is rather confusing.  What you do is to replace all uses of
> __sock_create with sock_create_kern, which works because
> sock_create_kern just calls __sock_create with the last argument set
> to 1 as those callers do it.  This then allows marking __sock_create
> static because all outside users are gone.
>=20
> Please state that, i.e.
>=20
> Subect: use sock_create_kern insteadf of opencoding it
>=20
> Replace all callers of __sock_create that set the kernel argument to 1
> with sock_create_kern, which is the improve interface for that.
> Mark __sock_create static now that all users outside of socket.c
> are gone.

I'd also like to see an explicit statement on all these patches
about whether the created sockets hold a reference to the namespace.

I know it is documented in the function definitions, but the issue
has always been that the callers get it wrong.

=46rom what I remember, as this point in the patch series sock_create_kern()
doesn't holds a reference, but by the end of the series it does.
That just has to be a recipe for disaster and pretty much requires the
changes all go through the same tree in one merge window.
But the code touches multiple areas and the changes would normally go throu=
gh
multiple trees.
So it's going to be hard to get all the acks and the patch accepted.
(Unless you persuade Linus to 'just apply the changes'.

I think you need to look at three merge windows.
1) Add new function(s) for creating user/kernel sockets with/without holding
   a namespace reference.
2) Update all the callers to use the new functions.
3) Delete the old functions.

There is no point modifying the callers twice, and the commits need to
explicitly state whether they want the namespace held or not.

	David


