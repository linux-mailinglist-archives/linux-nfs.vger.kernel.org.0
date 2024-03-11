Return-Path: <linux-nfs+bounces-2258-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB571877B7C
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Mar 2024 08:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AA13B20C42
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Mar 2024 07:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885FE11182;
	Mon, 11 Mar 2024 07:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eg8A5ui/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E4F11181
	for <linux-nfs@vger.kernel.org>; Mon, 11 Mar 2024 07:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710143812; cv=none; b=rQPQCZVeEIqmzMj7g9+1kTVppwm87Ic+ksbtlUKSKQhPBhaWrV8rkbfrmpkNwcWnnqX/F9qx8P8iZAexQmvdVDANH30lj1K/4chgPrkOiE5fZAA+36jepsvyMzp983VtbRKU8sH5EKIM+NFKdiy0Dn4l9CIXaWV+frVfMW7osgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710143812; c=relaxed/simple;
	bh=qMRtzE7/bgXIcdW2uPoK0EwQ9XCVb2K25OhUFPgecAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qe/j4C+xU8yXy/j/bd2RCsovk/YuAgV6gtrKQh+fKvTyR5pALpwK7ywj7C6iOZYJ6MlIjkzL0JjFU9exPyoRQcqhpEtk7JjOTjwCcoR/eEN/AsFsvKU0MHEsNVdcAN2uSWcfwfcCZwjVahsrV33JwCi7ekNPBHtnD4fJXdthFgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eg8A5ui/; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5682ecd1f81so3330531a12.0
        for <linux-nfs@vger.kernel.org>; Mon, 11 Mar 2024 00:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710143809; x=1710748609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/oH/E0mBsmPysauaFOQ7ZiDJNX8D6gtUc85/nSYbHYc=;
        b=eg8A5ui/Sw6sWYnwwqraQWjc9AHCRq6enHmLYH3Fm/vV0B+lwW83bdv5CXTRiLNTbU
         h+nX59Dws7MJAQLZq4Ty7CwUEV6xGOdIST4jzI4lwkV+Q+j0y8jQsUUZWCUqYHYKtwmV
         FXiBwr5OHQuyUJXyxHX6cQ6IWZxzW4fxm/Cd11NJ8jH2hGarVzPtUx9DGgQSlX5OnLRO
         +8xuIJuvd4KsgiwcSl6EQcE3xILdvVbQOjEsSW745KhzUd+rAHXg5nxf1WahJNOe5jub
         U6LKqn0GDc5Fc+2hP2abzUi6Tm278YCxfW6k0RZWHchofzeme3iVWaM9NMsM/RUOFw42
         Km7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710143809; x=1710748609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/oH/E0mBsmPysauaFOQ7ZiDJNX8D6gtUc85/nSYbHYc=;
        b=Ouk43hYt81pW0NeWU8c2vcLyCbo1CficIIo8jGjr/UChvabAnHLJMcmgYtRVUwhlIW
         4bBI8cQDo/Svaky5ARUY2NT3Hwz1Z8NbU6p2cVfVVoUFXLCl6DCk4XWFQ18JTpKt6mWc
         U9vjm/vW1OtPFwz7Y22rrX6W0E5qSw9YHTgTEVFXwEF6gb3zZgeaXjC+cRu+7UzpSQZw
         E/daVdl20+BVY95QTlk7kwiyPJWKdc/gTmVmbPYhDLplrHBU2sUnb0l2PyMmAcaS735V
         iLbVPgXab6CKy8iKGHiejVH8LvGXuBAfdjkzhKLaPiYy6GTkBuWl2GRQULvBgJsJE8we
         eCcw==
X-Forwarded-Encrypted: i=1; AJvYcCUUimVaB9lHq8AOvOd1pcv0S/Vu6s5ydhHphXt5v8X3KyyMttDldgMPlsH+mLziKwRYy5LI/QDS9RXWL9Ew1jjhSqNwFPyBeNW2
X-Gm-Message-State: AOJu0YwIskcQWGf/iCovlzniKLv6vqYHP/ibtBts+LjksJ1zvP9vaurN
	MDIV2KibLPIzXLjjHk0nq2L/LA1f5oJpDCLk7UHZXAUHQe6tFN8GWsXhoJjGkqJ0Yl6080TuM3S
	M3knuyXOZAQ9CNI6nM4t8q3i7gqo=
X-Google-Smtp-Source: AGHT+IH19xXQObMhZEY+Vb1PG2dSa6jUS7Pr8+XGIHMZbdIURcBeYC+bcA0qHmjxP3o6VULCrmeYvByc6iKXPLPPRu8=
X-Received: by 2002:a50:cdc2:0:b0:565:dd87:9811 with SMTP id
 h2-20020a50cdc2000000b00565dd879811mr3748126edj.5.1710143809177; Mon, 11 Mar
 2024 00:56:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308180223.2965601-1-trond.myklebust@hammerspace.com> <Zetfc_UEkl02Gu3N@manet.1015granger.net>
In-Reply-To: <Zetfc_UEkl02Gu3N@manet.1015granger.net>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Mon, 11 Mar 2024 08:55:00 +0100
Message-ID: <CALXu0UcMPz=KWWjceNJdYyO_jzx9ssPmw2tYQKbJRf_jx8E1vg@mail.gmail.com>
Subject: Re: [PATCH v2] nfsd: allow more than 64 backlogged connections
To: Chuck Lever <chuck.lever@oracle.com>
Cc: trondmy@gmail.com, Steve Dickson <SteveD@redhat.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Could you please ACK this for 6.6-LTS too ?

Ced

On Fri, 8 Mar 2024 at 19:58, Chuck Lever <chuck.lever@oracle.com> wrote:
>
> On Fri, Mar 08, 2024 at 01:02:23PM -0500, trondmy@gmail.com wrote:
> > When creating a listener socket to be handed to /proc/fs/nfsd/portlist,
> > we currently limit the number of backlogged connections to 64. Since
> > that value was chosen in 2006, the scale at which data centres operate
> > has changed significantly. Given a modern server with many thousands of
> > clients, a limit of 64 connections can create bottlenecks, particularly
> > at at boot time.
> > Let's use the POSIX-sanctioned maximum value of SOMAXCONN.
> >
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > ---
> > v2: Use SOMAXCONN instead of a value of -1.
> >
> >  utils/nfsd/nfssvc.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/utils/nfsd/nfssvc.c b/utils/nfsd/nfssvc.c
> > index 46452d972407..9650cecee986 100644
> > --- a/utils/nfsd/nfssvc.c
> > +++ b/utils/nfsd/nfssvc.c
> > @@ -205,7 +205,8 @@ nfssvc_setfds(const struct addrinfo *hints, const char *node, const char *port)
> >                       rc = errno;
> >                       goto error;
> >               }
> > -             if (addr->ai_protocol == IPPROTO_TCP && listen(sockfd, 64)) {
> > +             if (addr->ai_protocol == IPPROTO_TCP &&
> > +                 listen(sockfd, SOMAXCONN)) {
> >                       xlog(L_ERROR, "unable to create listening socket: "
> >                               "errno %d (%m)", errno);
> >                       rc = errno;
> > --
> > 2.44.0
>
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
>
> --
> Chuck Lever
>


-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

