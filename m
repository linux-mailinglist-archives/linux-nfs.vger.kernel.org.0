Return-Path: <linux-nfs+bounces-10098-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0404BA34C72
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 18:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8B516B310
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 17:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4857223A9AD;
	Thu, 13 Feb 2025 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="hOuJE3u3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5FC23A9A6
	for <linux-nfs@vger.kernel.org>; Thu, 13 Feb 2025 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469211; cv=none; b=uzBnr7f54GiG9cP93S1a3kw4C8Mt3U/IlTS3liTbhu5KroLTgXJo72jy4wKLfi/NDAxZVnERY+x5mbDyvpKdP/94KkUnDJ0g5Xp5e590/4cHcFRyp9ixB+76GGm6aBvN5Dza2Ni4ZlEvhvteGnCschjzpKrAe6YHqFS/I9pJYYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469211; c=relaxed/simple;
	bh=7N5x63Cl0j4kdpv11hEaNZ0Um3DrAW/UcLLLL8TjpWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u0eETYl2v/EdYwO0OtDpdqLMjT5KA/JYyZtNE3gUi9FLOuLhGuxkzyZ+JceilctxhdKhzCvAIj2b98LGWLfK10ULB37sMCOpa3bQEdIhCV/w3MqfQWQ+b00sMjqW8Qf1cnNt0GRROzVAeijBb7F7RUc4AbsFpz2L0x7VL0W9MBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=hOuJE3u3; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-308dc0878dfso12372501fa.3
        for <linux-nfs@vger.kernel.org>; Thu, 13 Feb 2025 09:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1739469207; x=1740074007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7N5x63Cl0j4kdpv11hEaNZ0Um3DrAW/UcLLLL8TjpWc=;
        b=hOuJE3u3XXXFZ5uSG8ndfjdUj0eAlDPnrhk9tSti/cdrs+3kJlKCuYtqGFKnVY848N
         G/ZunOwlLKkYvmbZO5q0jNgE891avv8PnCZM61P87dK3A6CSy202lJKw/URelQHcuHqY
         3xpxdZrbAhZ13S61kewLoNZ2GVEAQ9bCMghIeSLdwmN2woXC3UopFTxTnUXSmWnn3zXY
         4X2415/LAltFfvJj4l/BM5hiMSFiTVaUDgWKivFor0WnmDlhD0goW8VnpyCHWTrmeqpF
         fi1/Xb1J7Ld3AONAQzUjhDTY6sFRglIXtiWeEpVvjKEN3BMPHEj3y7cMVPw2BpyGJ7/S
         DZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739469207; x=1740074007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7N5x63Cl0j4kdpv11hEaNZ0Um3DrAW/UcLLLL8TjpWc=;
        b=IMNqeF37q69wgAUHj/JnS7Jzd+Ez0CZF5agxYg6NJItDa0RdKcPrqJ0C+OK193Dqlm
         7PpXKBLR8yn9ShDD6c8M4HXZiOtkRJ6ITm9yi6TR354lCqAHeFJNx8hytcFoxJ/wfo74
         voDgK0fExOcjmPmu8KZQHTig7HD7cPnQ7YUZ9+LjHHD3nF0ii+LXfHM2/0qFI5JemT4a
         E+5uQJBXDG4W8/gkO2pyXt1+4kXmB0CyOBPCHBNnkkEH1n2Vdo9PumbKWDQTWhku23Hh
         2hULIYV4QuNvY3PTF+hpGjv/kjbGAMez+pAk4BqCEYF5gjL9CiMqOJNJiKNv3GHkepQG
         fKcg==
X-Forwarded-Encrypted: i=1; AJvYcCXtnyzZAkqrbxuPmOQ/29b5LRBKS2ay6z66BEBJw2yQEfVsyOi3nckGsKuX0fIHx3p0jIO0AjjHUZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNOlDuJEbcW0HO6zTbNNzwmOR2dL3K27AVnNy7XcQbNrZ2QsiH
	tWlgCYLlTtjgV5MboNpZuSjfYkgLWnm5cHB9gccXJ5DUuK9xEfW8pDiimBl5YTJQGnDsaq3K9d/
	KMp0EZ6Oz/I3vywHHbsD9oV64aj6anw==
X-Gm-Gg: ASbGncuOvtTTRJS/tASlv29XUo2QdPjuDFukCHool3qYrf/ONt9u8ERHfAtOeRWPwD3
	cGSOzlKOvKtq4UzPXFdV8JVXdf/nXMUGDHsFoWzXEz4jtsIFevGrAo4rrtZDrS7THvmajPIYQUA
	teFr0C22vKOIJUVCfrTGq1kbZM8IWgh/s=
X-Google-Smtp-Source: AGHT+IGw8eNYDzqQ13MKEkacWqv2bN0uezmDf5LtqysOXzL4lrf9PqmDieePDtDFIXr8vB9D0ZSEbu01TKqKYOSLPKE=
X-Received: by 2002:a2e:b1d7:0:b0:308:f4a6:b006 with SMTP id
 38308e7fff4ca-309036eb918mr23667991fa.36.1739469206808; Thu, 13 Feb 2025
 09:53:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213161555.4914-1-cel@kernel.org> <df999d533683548ba91b69b017bf2b4acc0add52.camel@hammerspace.com>
In-Reply-To: <df999d533683548ba91b69b017bf2b4acc0add52.camel@hammerspace.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Thu, 13 Feb 2025 12:53:13 -0500
X-Gm-Features: AWEUYZkkXbIb3UCu10zZCkh8x2zZv9MnkjuLoetIbsqWqUo0AZ5eEgd4Wn7O0K0
Message-ID: <CAN-5tyGt4OhqZbzzADe9OumbaThrefZ1nTw=_wrrxy7FWfWK9A@mail.gmail.com>
Subject: Re: [RFC PATCH] NFS: CB_OFFLOAD should return DELAY when no copy
 state ID matches
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "okorniev@redhat.com" <okorniev@redhat.com>, "cel@kernel.org" <cel@kernel.org>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "jlayton@kernel.org" <jlayton@kernel.org>, 
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 11:59=E2=80=AFAM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
> On Thu, 2025-02-13 at 11:15 -0500, cel@kernel.org wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > The NFSv4.2 protocol requires that a client match a CB_OFFLOAD
> > callback to a COPY reply containing the same copy state ID. However,
> > it's possible that the order of the callback and reply processing on
> > the client can cause the CB_OFFLOAD to be received and processed
> > /before/ the client has dealt with the COPY reply.
> >
> > Currently, in this case, the Linux NFS client will queue a fresh
> > struct nfs4_copy_state in the CB_OFFLOAD handler.
> > handle_async_copy() then checks for a matching nfs4_copy_state
> > before settling down to wait for a CB_OFFLOAD reply.
> >
> > But it would be simpler for the client's callback service to respond
> > to such a CB_OFFLOAD with "I'm not ready yet" and have the server
> > send the CB_OFFLOAD again later. This avoids the need for the
> > client's CB_OFFLOAD processing to allocate an extra struct
> > nfs4_copy_state -- in most cases that allocation will be tossed
> > immediately, and it's one less memory allocation that we have to
> > worry about accidentally leaking or accumulating over time.
>
> Why can't the server just fill an appropriate entry for
> csa_referring_call_lists<> in the CB_SEQUENCE operation for the
> CB_OFFLOAD callback? That's the mechanism that is intended to be used
> to avoid the above kind of race.

Let's say the linux server does implement the list but what about
other implementations that will not. The client still needs an
approach to handle CB_OFFLOAD/COPY reply.

> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

