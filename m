Return-Path: <linux-nfs+bounces-12098-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC69FACE2D4
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 19:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7827816F290
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 17:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E147E1E5B9E;
	Wed,  4 Jun 2025 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7fm/E9P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5504832C85
	for <linux-nfs@vger.kernel.org>; Wed,  4 Jun 2025 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749057178; cv=none; b=Xy3lDY7h3//qE15lJqLnmWIBfIDTmDasxX4ZjkRcQbYHbtYYTgLjRCC1mCOcsoqEOTbmqIt6+HDmBivJzAbC2wqJ3otxwwgCCwrfpNRz00CLoWk9vtCWb21xURFS1yzR6DdWHzeYJ4qkzbd4l7U9UL0fIFkuRcrhGIRTWRfgUqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749057178; c=relaxed/simple;
	bh=PFexmqucUfE4MdqvJR/fKC1HbvlGAPSNUuaN946X5Rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=EvaqLwcVOKHt2jVnVBehoIlyNLZ2Zhm6EMA6w+1dGmxI1n5Cyfiql6nHBqcuNjUY+ZKoWnzbIHLrM47IeyE2VUPmSaIKq5Nokhx+8tCbNpu+QC4AK59B+rfiZUCVR6SKsn9Are5VtL/iVhg49rw8+kgV1Jv42PKaZ0a7VxHmhn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7fm/E9P; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3127cc662e2so163305a91.0
        for <linux-nfs@vger.kernel.org>; Wed, 04 Jun 2025 10:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749057176; x=1749661976; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9qzjkeHB0iXHoCJN/byI1FqAdaSPHFCE1ECtaDHuXL0=;
        b=d7fm/E9P/H+1SFWT5Q+Xp3DsaYjSeq5MwBmmAC3ed3U6FA/hE8vkko/cNaMqb9Vbhn
         8BgHvqj+wu3QnYN1+g3vZXWg7jiY6Jx0PWaBGw/2//e7gk9IrLhpuiBIflh9pkRZxpA9
         WqJgHHcR1I7humQuUSXtUT8yYLZBW9TRSdvYk3Xess+ABzdwar4/SKJUFPIJqDnW0hN2
         WZ1k5BqYtLpEW8QcjjpAmZSyHqcAprsrSuZ0Husr6wXNkwJQ9XgRr44JOS3sCjLp4S+Y
         GA2pBxKMrcGPrNvhewXs7egpAqfmv7J/koR6fNnRF8rtEYmzilG/0TNqcflnnW+GAwVu
         naMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749057176; x=1749661976;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qzjkeHB0iXHoCJN/byI1FqAdaSPHFCE1ECtaDHuXL0=;
        b=lHzyKRqIbXxa4f8vMHrfqM2979QoXbt6r2qOj5kF48R9vmcLxUIBESzg+JE/NjwlGD
         7OYA4qqhcsAiMtSOpFTUr9KgT6VZazYWee0L8OecYSgMsTAtSpsAUNJ0DiQwSv/4+mJd
         fiNSVLCLZCm1A4FD8DZ8Cg5DA6l4QPrYpVWVpmNVM42/dgWXCkB5s/EePiMlDec1AWwj
         AtMifn0hOWq6pUDNkTRCkIsljxYAINJgvR9ftGOs0P8FWsjHLeYqvMLSl6UhQsIt6ljv
         UrhdaLuJV8TAmo828Yknm9qjN0vzjATwafav5dPyucvO9jm8jmC5pwOBG2f3+uw/0X7F
         Ku0Q==
X-Gm-Message-State: AOJu0YwV/KCjb6tIjYjAwmzy/TYVVCTwxqT0q3f7srkfMaui485YGzgp
	d6QvvEWjCEYEKP+P7r8AO40rFYcSy7YUo700uYJBX2Ksqvl6iTkGljSr7nz9Nk9M0x3h7RBHaeC
	BBABe8waNlBgfGj3GZdbm/RqthRCcWiEMyQ==
X-Gm-Gg: ASbGncvxgcMXlNBRVOqV0kUpvSQjNHKRacGpgfvS0vbNG0erddW8ZTVOQD0hftrZ8iT
	iO7Q4FeXNmc08k8g7WnMvpUBeie3aRTUItkoIKojqqk9vNKvB0+Gaj8lzqbgdV5vqY+iFXOa19I
	eULCM843BfzyJl3Iwhdv8JmlA4cC/AiXc4
X-Google-Smtp-Source: AGHT+IEWhFmn+WvHt+NOKYdCbI/E7ZHkrP/nRI1n5ElLEVk81Ue89UcffsMdXuOHMvjvE6UhAH8IRyY+YtMkJ43OAIU=
X-Received: by 2002:a17:90b:4a0d:b0:30a:9feb:1e15 with SMTP id
 98e67ed59e1d1-31328f8c004mr431989a91.8.1749057176089; Wed, 04 Jun 2025
 10:12:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513-master-v1-1-e845fe412715@kernel.org> <CAPJSo4W8cN6ZGuFDs4Dda6KDs29ggCrBOq4CJC5FGrXh+bYGGQ@mail.gmail.com>
 <de3fb73c-04f0-4466-a776-c90794f214a0@oracle.com>
In-Reply-To: <de3fb73c-04f0-4466-a776-c90794f214a0@oracle.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Wed, 4 Jun 2025 19:12:19 +0200
X-Gm-Features: AX0GCFu-4k-_RjtK9UL-OCoVNNB7j2rvOdzuyje_qpcbJ9EM3APpqIs857b1Uy0
Message-ID: <CALXu0Ue404JV5+g8Vabm9zwr+9pnpux9TZ0Sa92brSWcXdPuOQ@mail.gmail.com>
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all exports
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 May 2025 at 18:12, Chuck Lever <chuck.lever@oracle.com> wrote:
>
> On 5/13/25 11:14 AM, Lionel Cons wrote:
> > On Tue, 13 May 2025 at 15:50, Jeff Layton <jlayton@kernel.org> wrote:
> >>
> >> Back in the 80's someone thought it was a good idea to carve out a set
> >> of ports that only privileged users could use. When NFS was originally
> >> conceived, Sun made its server require that clients use low ports.
> >> Since Linux was following suit with Sun in those days, exportfs has
> >> always defaulted to requiring connections from low ports.
> >>
> >> These days, anyone can be root on their laptop, so limiting connections
> >> to low source ports is of little value.
> >>
> >> Make the default be "insecure" when creating exports.
> >>
> >> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> >> ---
> >> In discussion at the Bake-a-thon, we decided to just go for making
> >> "insecure" the default for all exports.
> >
> > This patch is one of the WORST ideas in recent times.
> >
> > While your assessment might be half-true for the average home office,
> > sites like universities, scientific labs and enterprise networks
> > consider RPC traffic being restricted to a port below 1024 as a layer
> > of security.
> >
> > The original idea was that only trusted people have "root" access, and
> > only uid=0/root can allocate TCP ports below 1024.
> > That is STILL TRUE for universities and other sides, and I think most
> > admins there will absolutely NOT appreciate that you disable a layer
> > of security just to please script kiddles and wanna-be hackers.
> >
> > I am going to fight this patch, to the BITTER end, with blood and biting.
>
> Lionel, your combative attitude is not helpful. You clearly did not read
> Jeff's patch, nor do you understand how network security is implemented.
> Checking the source port was long ago deemed completely useless, no more
> secure than ROT13. Solaris NFS servers have not checked the client's
> source port for many many years, for example.
>
> Most of the contributors and maintainers here were first employed by
> universities. We're well aware of the security requirements in those
> environments and how university IT departments meet those requirements.
> Any environment that requires security uses a solution based on
> cryptography, such as Kerberos or TLS.

I wouldn't even dare to mention TLS here. TLS is mostly experimental
at best, and its performance is so bad that enforcing it might finally
ruin the Linux NFS client+server reputation.

In that context, TLS is not an option, unless performance, latency
sensitivity and CPU usage can be improved by at least a factor of 5.
Yes, factor FIVE, because TLS is that BAD.

I only agree to this change because Solaris did change it long ago,
but even then it was a highly disputed change, and today's
universities still prefer the "resvport"

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

