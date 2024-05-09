Return-Path: <linux-nfs+bounces-3222-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2BC8C1069
	for <lists+linux-nfs@lfdr.de>; Thu,  9 May 2024 15:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1E41C2293D
	for <lists+linux-nfs@lfdr.de>; Thu,  9 May 2024 13:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397E715CD75;
	Thu,  9 May 2024 13:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=poochiereds-net.20230601.gappssmtp.com header.i=@poochiereds-net.20230601.gappssmtp.com header.b="sarXgmjp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98681158DC5
	for <linux-nfs@vger.kernel.org>; Thu,  9 May 2024 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715261480; cv=none; b=UHlYUOFLaj4xwkhx15fTw7BXbihDRHcEsjB+xhre4tU0R9jU9ECieeHl304YbPwJzJX/1JSKFHW12/0p0d7y1qR96YjsJFNrQ7es8eW2sYSuPHiDlr8VSRuHNSIy6LgktkeOrNME95b4cVbMeZzKLXmYbb7fO/Schw04KAWjNhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715261480; c=relaxed/simple;
	bh=Pxq7m8xsVHvJvg/w6k1BjFgru9L7iEbAWEcZhrfwbio=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fqiW7wGhIltESYamQKLOdKUUOQfWWo+CetPg1bNJ50dRfw4/NlgpLq/BNNByq37DCDt7lyUTOdRDcQGg3aVoEh7TfWqpf3bRnooZBXImDVYXpvWAYWm8y5HiC7Vad2Toe53P42Lzsgr2jYg5HXm4pauH47lBNSVrax6zD6zhqXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poochiereds.net; spf=pass smtp.mailfrom=poochiereds.net; dkim=pass (2048-bit key) header.d=poochiereds-net.20230601.gappssmtp.com header.i=@poochiereds-net.20230601.gappssmtp.com header.b=sarXgmjp; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poochiereds.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poochiereds.net
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ecd3867556so7092805ad.0
        for <linux-nfs@vger.kernel.org>; Thu, 09 May 2024 06:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poochiereds-net.20230601.gappssmtp.com; s=20230601; t=1715261474; x=1715866274; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qyy4KfEUed3hd0FHNjpkWXdwLBXzmVHhHgdwLUHAUnw=;
        b=sarXgmjpuEmdk1VkWJf5a1VBDOEFeySoWQK4BDs2JIEvqTl+za9WP+AKhMjC+UUY64
         H3DeIDIwlyfsb6hZjVq30IRswg03O6XOgwoNxdVTx/u0qhWKYz6Zf+fLSDpWMkt8wY/B
         0WyjJAtktSWii7wVzSOC+Nh+V44atPkgseFpM+sKZDaKX1IMiLnSpp9iXQk+q3GsERK0
         8y5Vztn3RynIg2mszMGw8AGVew412XiA21kwS4DKeIFgUgpWcHNiCt+iUSVEbMvnX8pf
         nMBt+qbZU03GeokTI7uIs+4VS4PXIungE/0xyXyf7qTCFKyY0c3ujmi1neLBtWzaDkbm
         FLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715261474; x=1715866274;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qyy4KfEUed3hd0FHNjpkWXdwLBXzmVHhHgdwLUHAUnw=;
        b=QRISC+GZGQMKYb8HoFtnpIjXxHg8AisMJL01+WoiZOpOcGLHcPc+DtmZp+j30X7JQP
         PvZrLjuxzA2VgDZCDEFpHPykyCZp2F0V+xrR7BKuNO3qyVp4wnrfP2xfsNa5En47QMlb
         NeytuYCBNC0it/aea7yewrbXsxvDt2/Ce6o7q/veI4NN6i00nU3nbblX2Z/yjmYftfzQ
         RiZ6XaZa0cumJhnDZTCQujs79uRzZNJ4gF8G3jyMPtZgqb2ca4DfIwagJIs1FrhVHPbA
         AaSwr4iwxqpGlwOZ+cF7EwbDm3lt6ELJS0iajpa91eInb+gvBKxOss3RYSZ/MVqC5Moj
         1ljA==
X-Gm-Message-State: AOJu0YxUBz9pRkuebX58Hx2cZ0VR/+cHkOCSzUVP9dt297z8PosL2fht
	O0EswRs5JrIn0JQwk2feXLKgaSHZ78eTvfVcCQsQ673H7MbRG+9k549Xq9IFGP61nmb/n0zZbaO
	f
X-Google-Smtp-Source: AGHT+IFAYyX9jLu9j2N7Sp2dUQRaD/hjoaE+k30TO3xKqlunwNawkjbDodPqzEFsd+lxs2WtwTNi4g==
X-Received: by 2002:a17:902:6806:b0:1eb:1c47:50d1 with SMTP id d9443c01a7336-1eeb0797845mr52085595ad.69.1715261473699;
        Thu, 09 May 2024 06:31:13 -0700 (PDT)
Received: from [10.36.155.63] ([50.175.227.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf30fc7sm14052475ad.133.2024.05.09.06.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 06:31:13 -0700 (PDT)
Message-ID: <17b06a56223ab70ccf79a0e6b79eef54eddc6c2e.camel@poochiereds.net>
Subject: Re: [PATCH v2] nfsd: allow more than 64 backlogged connections
From: Jeff Layton <jlayton@poochiereds.net>
To: trondmy@gmail.com, Steve Dickson <SteveD@redhat.com>
Cc: linux-nfs@vger.kernel.org
Date: Thu, 09 May 2024 06:31:09 -0700
In-Reply-To: <20240308180223.2965601-1-trond.myklebust@hammerspace.com>
References: <20240308180223.2965601-1-trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-08 at 13:02 -0500, trondmy@gmail.com wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> When creating a listener socket to be handed to
> /proc/fs/nfsd/portlist,
> we currently limit the number of backlogged connections to 64. Since
> that value was chosen in 2006, the scale at which data centres
> operate
> has changed significantly. Given a modern server with many thousands
> of
> clients, a limit of 64 connections can create bottlenecks,
> particularly
> at at boot time.
> Let's use the POSIX-sanctioned maximum value of SOMAXCONN.
>=20
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
> v2: Use SOMAXCONN instead of a value of -1.
>=20
> =C2=A0utils/nfsd/nfssvc.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/utils/nfsd/nfssvc.c b/utils/nfsd/nfssvc.c
> index 46452d972407..9650cecee986 100644
> --- a/utils/nfsd/nfssvc.c
> +++ b/utils/nfsd/nfssvc.c
> @@ -205,7 +205,8 @@ nfssvc_setfds(const struct addrinfo *hints, const
> char *node, const char *port)
> =C2=A0			rc =3D errno;
> =C2=A0			goto error;
> =C2=A0		}
> -		if (addr->ai_protocol =3D=3D IPPROTO_TCP &&
> listen(sockfd, 64)) {
> +		if (addr->ai_protocol =3D=3D IPPROTO_TCP &&
> +		=C2=A0=C2=A0=C2=A0 listen(sockfd, SOMAXCONN)) {
> =C2=A0			xlog(L_ERROR, "unable to create listening
> socket: "
> =C2=A0				"errno %d (%m)", errno);
> =C2=A0			rc =3D errno;

Steve,

Is there some reason you've not committed this patch? It seems fairly
straightforward. I think I sent this earlier, but:

Reviewed-by: Jeffrey Layton <jlayton@kernel.org>

--=20
Jeff Layton <jlayton@poochiereds.net>

