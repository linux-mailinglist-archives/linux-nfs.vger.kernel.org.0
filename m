Return-Path: <linux-nfs+bounces-7579-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C17C9B669B
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 15:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C921F21CCD
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 14:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95A626AD4;
	Wed, 30 Oct 2024 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQ0nNzxk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A8A1F12F5
	for <linux-nfs@vger.kernel.org>; Wed, 30 Oct 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300164; cv=none; b=cK40t0sxOZA59hNaRrOVxAbPiCyJed5ukg/f5fAzeLcTZvmNAl9EXY5nv+u+dshW3oDOw+ARX0TMx1RIZ4SIsBfgi0ocOBetnAF+QZ8JgKsrCYLMV13igGK/UJalGrcWcAcP3ul/4VMHR2RSnX6aX729Y90wyHoAbnVYqEZOca4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300164; c=relaxed/simple;
	bh=akEUNKt+XDmiUbdy1s0EoAGj/V07B9BxY7Ud5opE8pA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJw9t71IXvXYestgpgkqmWb3H/PDBqqGsr+vYBTxSoZuw1XVhuyW4ZUmPeGh5Qt6ZWDWpJZ1csMDs34VWfCr1sKnXHnfoBwnOIJ7CfYiNB2Q3n3yEulsdgRntARcn+EdbtVgwcet2dSxviYEsSe1WBvDbqw7RATtqqKCLNs8z/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQ0nNzxk; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99fa009adcso457536666b.0
        for <linux-nfs@vger.kernel.org>; Wed, 30 Oct 2024 07:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730300161; x=1730904961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akEUNKt+XDmiUbdy1s0EoAGj/V07B9BxY7Ud5opE8pA=;
        b=kQ0nNzxkRNaLsR61Hz9QUfSaV/q8mNHglCtI0GC9/6Bp6esg8f9f31QGr+uzb5/wbm
         vNw59ZBRk/fDVgljZuae7KRLz5xh6XK7HYRa2KXdetMizt2Asjb1std3+qa7ftW+YTvO
         zVEvZuYh6R0iCGLyqdsUL+99dsku+igfcoLdhYWed258jcmq/vRmExXM0ObD+QGfI4u1
         go8xl9T3j6Hv5XNGNsv2ufmZNJwen8KXaSBrLnugpbqx6W1dlfOlTE9NG43HeDNqtxZ3
         NMCOF4xvtG7Ot1C3/1dc6FBbnZNG1qWYWVJEY92O1wL+LkIKnuifP+x/EfGM1+lQzqKt
         bU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730300161; x=1730904961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=akEUNKt+XDmiUbdy1s0EoAGj/V07B9BxY7Ud5opE8pA=;
        b=K5QiLSz5eFlznpNpFtJpwOV6hyFkBwtWR48lmNoTwcmrBEwx1eSyHMo9iFibtUstJK
         MuWiItSr2I26MQ/Yq/7DuD7SK5wh4e7BS5f9HH1eD8frQ6iY5YI6FrHW3iNVfHoA6z5/
         07wE0F8uHUfI7nbN8aqdHKlIvJh8I86k7TB+1gA9Cr7WE93IUasNXbX7iZMYqPRvD3WH
         G1gSZUNit7jUWjvavp3/M2WPEiD5T/IXkQp5BuvbeV1bYywuHiv+oJei4nlBENO24vRU
         lGRQAm0h6qaIxHB+Q0y1uRQlFE9VAbCKXB/eqOjv3nX4zpTrZsNYVPBDZ46iyntC9ZOv
         wgOw==
X-Forwarded-Encrypted: i=1; AJvYcCU548PmuU4cty3NcMSmvMBT3hE/kQQUmKjrPQB2fDVy+9k1jOcwLG6gM2ILKeGhdehtmsutAXuQGIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmenL6ibT0kYtqs/lUGW8asARGsxu+bSXfwez6ut0UV3QKy7NL
	PznXCf6y3tHNlU5YKURTtUwLwOiCVewwqNcarWjuX8y6OU2oi/D/8oXA8f1WCm3fjqsHN/fgjfi
	NUoxxNZdTQb9/dSrHd1y//uCWH58=
X-Google-Smtp-Source: AGHT+IFVEBBMD5M+TUcpTZoLI76Z+B4U0TzmPZfaSQg9R6vzg7EFxTJcBeqMkS96pkSJcW6b5KLBuPYPKIA8nbJbVBI=
X-Received: by 2002:a05:6402:2345:b0:5ca:1598:15ad with SMTP id
 4fb4d7f45d1cf-5cbbf8899ccmr14711544a12.3.1730300160618; Wed, 30 Oct 2024
 07:56:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023152940.63479-1-snitzer@kernel.org> <20241023155846.63621-1-snitzer@kernel.org>
 <CANH4o6Pi13aEtQW5-vmuJiuCNzx6tjn1+v=pLUpVMuffX-WkPA@mail.gmail.com>
 <7FB2B261-48F9-4DA0-B4B5-E8E30EC31CD9@oracle.com> <CAGOwBeX7xw7cPRXGO5RmLQUgzOjqr-7Bh4EhV=hONpXCAqsX-g@mail.gmail.com>
 <91F0EACF-76BC-49EE-9340-AC60F641B8B2@oracle.com>
In-Reply-To: <91F0EACF-76BC-49EE-9340-AC60F641B8B2@oracle.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Wed, 30 Oct 2024 15:55:24 +0100
Message-ID: <CALXu0UcAw7xkObkVFFTi6d-F69_qrDwf9pTE+8We3k14CvywmA@mail.gmail.com>
Subject: Re: [PATCH v3] nfsd: disallow file locking and delegations for NFSv4 reexport
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Brian Cowan <brian.cowan@hcl-software.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Oct 2024 at 17:03, Chuck Lever III <chuck.lever@oracle.com> wrot=
e:
>
>
>
> > On Oct 29, 2024, at 11:54=E2=80=AFAM, Brian Cowan <brian.cowan@hcl-soft=
ware.com> wrote:
> >
> > Honestly, I don't know the usecase for re-exporting another server's
> > NFS export in the first place. Is this someone trying to share NFS
> > through a firewall? I've seen people share remote NFS exports via
> > Samba in an attempt to avoid paying their NAS vendor for SMB support.
> > (I think it's "standard equipment" now, but 10+ years ago? Not
> > always...) But re-exporting another server's NFS exports? Haven't seen
> > anyone do that in a while.
>
> The "re-export" case is where there is a central repository
> of data and branch offices that access that via a WAN. The
> re-export servers cache some of that data locally so that
> local clients have a fast persistent cache nearby.
>
> This is also effective in cases where a small cluster of
> clients want fast access to a pile of data that is
> significantly larger than their own caches. Say, HPC or
> animation, where the small cluster is working on a small
> portion of the full data set, which is stored on a central
> server.
>
Another use case is "isolation", IT shares a filesystem to your
department, and you need to re-export only a subset to another
department or homeoffice. Part of such a scenario might also be policy
related, e.g. IT shares you the full filesystem but will do NOTHING
else, and any further compartmentalization must be done in your own
department.
This is the typical use case for gov NFS re-export.

Of course no one needs the gov customers, so feel free to break locking.

Ced
--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

