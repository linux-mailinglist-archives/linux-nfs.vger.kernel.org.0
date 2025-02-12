Return-Path: <linux-nfs+bounces-10061-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C46A330E6
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 21:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4374E168078
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 20:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649D8201017;
	Wed, 12 Feb 2025 20:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZGVtzHB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F146200BB2
	for <linux-nfs@vger.kernel.org>; Wed, 12 Feb 2025 20:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739392721; cv=none; b=Dh7Ys0sfOLpL6VhPRkB9lxK1m7lyEeKVhsSgAuxGF38Hxj/CwZ3jjNY6U5utBeU+40Zoao2P2IXHF/LhmjKlX6v9PHtIM7N9UCT+m5X758B98gfAgjNMFf/umhwOSVmLIPTYYKkwgVuVt18qPzXLzaMMwVaZUj8eD8w47Z5uKDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739392721; c=relaxed/simple;
	bh=kYZzEzUOzjvkOJkkIB8tUSrmdiB1tuh9gcSIMiz1Wxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhwGdbjeKZu0qu+/vUH0vyo3c/xXZUpc7NGLsKh3Ax83yibAumQdPMhKELgxO+PbNwEj5oUZu08zDya7cJz7PuaQwXtQjfIVVlEG6Vjvy1W2KwwOJXXs5dMurm7uzWCTTcCGGjGoNJe01KaPe6KGqAeiLE5warAWAPeKJfiKrK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZGVtzHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38AFC4AF09
	for <linux-nfs@vger.kernel.org>; Wed, 12 Feb 2025 20:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739392721;
	bh=kYZzEzUOzjvkOJkkIB8tUSrmdiB1tuh9gcSIMiz1Wxo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XZGVtzHB6hwAh2OOcjz/hfMRxaDKOPJmeqfWMuOqYBCAlcJ31/DfXRe6ziXn3qkMI
	 lStPB27AHTF/XoAZVCcpmG4KYf0WcoWqvVqVuSQUJHWAJRPZsACcnO5GU89CIJGxs4
	 cjGkAPlWVBn/lJptPOn7dzwql9t/o39qH7QyYw6nCKxvgDBhbsN21oHCSiTD0edl/l
	 3gNfclycJW6CVlq00Y7Izc/Bikl/0EnG+pYeWftm32jrOfHiRlOa0rmGDkpW5dWaMN
	 e3JcSMBnoCvw3COi6nRLI8UzJr8C/agsE5OUrWlWGuATIFhZbmOslps161V+CyBSS8
	 yanIDDJVcwznA==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5de6ff9643fso144655a12.3
        for <linux-nfs@vger.kernel.org>; Wed, 12 Feb 2025 12:38:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUA9IjtTc9H+6xQ30wzeNvF+2j9ocM89NbYKtQdqyCx6SuWovuDIUCecnwQ+9LT0nMGrZbmN5NhFKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpyDvhEjQwhbmEL6agXB/CoiMC67s88zG632VXLzMSVMXe+mIo
	6wWujw77RbQsYnn/BxaTjULvxXQNCQewjc9jhPZXoWEl0y4Q9mviYVlSvc6EGy/SRwbhA4JdEXj
	r0UuUgd/oDTWhlXpRD7JeDR71BQM=
X-Google-Smtp-Source: AGHT+IGiogAc1q7SS+pdzfIXxRd0/CjgcbVOzuiAdTjSv3aLB8/f0P/8x22suFF4MEMSpypb/ybRYuv+2MvpN4ByE/M=
X-Received: by 2002:a05:6402:1ecf:b0:5de:5063:f56a with SMTP id
 4fb4d7f45d1cf-5deaddb91ebmr4133154a12.19.1739392719724; Wed, 12 Feb 2025
 12:38:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <614d3c3bcceeedb933400bdc00f812518c05a4a6.1739294902.git.bcodding@redhat.com>
In-Reply-To: <614d3c3bcceeedb933400bdc00f812518c05a4a6.1739294902.git.bcodding@redhat.com>
From: Anna Schumaker <anna@kernel.org>
Date: Wed, 12 Feb 2025 15:38:22 -0500
X-Gmail-Original-Message-ID: <CAFX2JfnS1-LtjTSOYc7bOJMVxw4M4gyAH8MqruSekE_-KMVAEA@mail.gmail.com>
X-Gm-Features: AWEUYZk56P00Qk5lUyni1c8RJ4Vk6Kyduev4PKqau81BXWlPolwhcHT0sQnSwtQ
Message-ID: <CAFX2JfnS1-LtjTSOYc7bOJMVxw4M4gyAH8MqruSekE_-KMVAEA@mail.gmail.com>
Subject: Re: [PATCH] SUNRPC: Handle -ETIMEDOUT return from tlshd
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Tue, Feb 11, 2025 at 12:32=E2=80=AFPM Benjamin Coddington
<bcodding@redhat.com> wrote:
>
> If the TLS handshake attempt returns -ETIMEDOUT, we currently translate
> that error into -EACCES.  This becomes problematic for cases where the RP=
C
> layer is attempting to re-connect in paths that don't resonably handle
> -EACCES, for example: writeback.  The RPC layer can handle -ETIMEDOUT qui=
te
> well, however - so if the handshake returns this error let's just pass it
> along.

Do you think it would be reasonable to add:
        Fixes: 75eb6af7acdf ("SUNRPC: Add a TCP-with-TLS RPC transport clas=
s")
to this patch?

Thanks,
Anna

>
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  net/sunrpc/xprtsock.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index c60936d8cef7..6b80b2aaf763 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -2581,7 +2581,15 @@ static void xs_tls_handshake_done(void *data, int =
status, key_serial_t peerid)
>         struct sock_xprt *lower_transport =3D
>                                 container_of(lower_xprt, struct sock_xprt=
, xprt);
>
> -       lower_transport->xprt_err =3D status ? -EACCES : 0;
> +       switch (status) {
> +       case 0:
> +       case -EACCES:
> +       case -ETIMEDOUT:
> +               lower_transport->xprt_err =3D status;
> +               break;
> +       default:
> +               lower_transport->xprt_err =3D -EACCES;
> +       }
>         complete(&lower_transport->handshake_done);
>         xprt_put(lower_xprt);
>  }
>
> base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
> --
> 2.47.0
>

