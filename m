Return-Path: <linux-nfs+bounces-6352-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BAA97205F
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 19:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C3691F245A2
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 17:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A52117556B;
	Mon,  9 Sep 2024 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="Sv8zAjiU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DD41865C;
	Mon,  9 Sep 2024 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902643; cv=none; b=A0yOXWgF/Xwhi/kgz7AcU3ujcU1Tfl/D9vUj3NriozMma+g85/ZhiQCAJx/ImLAAAZFs2kaRs8heBTNHDKWDMmUTsRlJuyUAdx0sHT6glrQ95p13W9stOuYMcIxJeu4qc6J0s3BC/6YHh4xnGM+vUDxFTZgjeMQkW3UWtmsRJa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902643; c=relaxed/simple;
	bh=5qMUKIBrpr+qfmua466C+pCDFtS1UV+POsM6DOPF2S4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nwFTedGa+zKUa7DyUeZIwCY3Z9a4L2E9gNs5BZkdr1pE8Sy7Kuwd01xjKOuk3uraWstw3Y4zEFNnJwmSKIXZxVXidcGG3Azh7IU+zOmVJkIQzlVPm1z2J6WybpON8Wy2mX6uE0ZKkzwQm9LP/UYOEoywZ/Z1zuZodSDjhC+jNd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=Sv8zAjiU; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f760f7e25bso17700501fa.2;
        Mon, 09 Sep 2024 10:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1725902640; x=1726507440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x50KnwCqfXWFW8bmwgvpdcdT/VQCHrCJ+7RAYLNl1Jc=;
        b=Sv8zAjiUBMDrdhvPpZCgpNWM46qFn4vLNk2NC0UmgLhl43+jJzaa0/0hDDtXGf3kp/
         QBMM/6eIBveHvoNVNku1Kiya02EEizpGUWzej2YpITgw8Ks5Ni9zytT+8nAZpftgMAno
         mXUxNaFh3HFCIgKCKw4OEetllm0sYtj36Cc/ulugkpPKO8tEjqPcobg5nmHSpoM2DcyK
         q6VbaJCWNe8gvKF/lUOmCBupn2ireowUYYVP0u1+fHT+8pmt4BnkjLlGHF4Az82DYB97
         TjalQKb/lYV6x2ZdqLgk0QdbslUFSWGlYIcAUNJXUSYMKWMrRE95hKp07aFNtkCHY0SA
         cupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725902640; x=1726507440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x50KnwCqfXWFW8bmwgvpdcdT/VQCHrCJ+7RAYLNl1Jc=;
        b=Q5IUIKn9u4I/L6ah+colBqzFIenvTOe8o+nRratGH6hyW24C+HPfey+as9MxXN0at7
         Yw6/raeYIPZqgvC/LXo/QALe8kijv0m50mTf86d/vnSweqAGUV2UFQTZhAwGuHZwn/68
         ME9dYrsK2AtJektCgkVmlsscVxa5p6fhhJPLgLMBHR+Tice21OmcLqyHZ5GfiIbzBwwE
         TnthHQtGxcfvTtwmhogiLNFhpOT+xcfMAi5ioqW0z129/wZLIWjMXuLrMtA1QKsGJI/G
         P7GGoqU5ednxSWt18Dk3v5m4NKT3jPDqdKS7PLgEGVPZ9TTxxyECxT7ZKlMGCN4o1BRT
         svOQ==
X-Forwarded-Encrypted: i=1; AJvYcCViEfeDLxfSAa8e3nSTUfBC+N8geGLjx5WGqUcmevlsQ/rpRHOatbUS1MZ906XE5PLYZI1XT4ZB6x096z8=@vger.kernel.org, AJvYcCWM8+9sicCxhPNNJ3XAMsW7kbixRHU/iIPYePZVv5RDtJDNB9ejI8xdG+Aomb8BB2nvkQKitNnRWvhn@vger.kernel.org
X-Gm-Message-State: AOJu0YyJCgdUOAK2sAS2AYhovdeECgUiiwT6i9IWTbrd4BOehjlJES6T
	BF5VlE+6DNXxzm3d6hqAqNn6+zQqBg/kPyUQgSDxx8L4BMW9jEdsb0R71RHgqiuIIXySzTQEj0j
	VycspMaNVoODepFb+H1vPgS1rjgM=
X-Google-Smtp-Source: AGHT+IE6rCV/4aF114iDIj1kkIzkyn9wNoEOeAL2BBd+QL1ZEEYMwzMvVt2ZxZGLQfYfPoR9MpZQ5Xg9XLgqcD44um0=
X-Received: by 2002:a2e:f0a:0:b0:2f3:a06a:4c5 with SMTP id 38308e7fff4ca-2f754a6b7cbmr47255071fa.29.1725902639166;
 Mon, 09 Sep 2024 10:23:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826-nfsd-cb-v1-0-82d3a4e5913b@kernel.org> <20240826-nfsd-cb-v1-1-82d3a4e5913b@kernel.org>
In-Reply-To: <20240826-nfsd-cb-v1-1-82d3a4e5913b@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Mon, 9 Sep 2024 13:23:47 -0400
Message-ID: <CAN-5tyFQ9sdb-L8YQXiGsUXDbVR9QbdNNK7QOi5XVJaggnVFBg@mail.gmail.com>
Subject: Re: [PATCH 1/3] nfsd: add more info to WARN_ON_ONCE on failed callbacks
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 8:54=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Currently, you get the warning and stack trace, but nothing is printed
> about the relevant error codes. Add that in.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4callback.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index d756f443fc44..dee9477cc5b5 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1333,7 +1333,8 @@ static void nfsd4_cb_done(struct rpc_task *task, vo=
id *calldata)
>                 return;
>
>         if (cb->cb_status) {
> -               WARN_ON_ONCE(task->tk_status);
> +               WARN_ONCE(task->tk_status, "cb_status=3D%d tk_status=3D%d=
",
> +                         cb->cb_status, task->tk_status);
>                 task->tk_status =3D cb->cb_status;
>         }

Educational question: why is this warning there in the first place? I
can appreciate the value of information. Does knfsd expect that a
callback should never fail with an error and thus tries to always
catch it? A tracepoint can log an rpc tasks status but I realize that
it doesn't capture attention like a WARN_ON.

I have a report with this warn_on which I'm trying to figure out why
is happening but I was surprised to find nfsd cares so much about the
callback status.

Thank you.
>
>
> --
> 2.46.0
>
>

