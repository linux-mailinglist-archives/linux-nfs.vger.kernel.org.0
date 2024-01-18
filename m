Return-Path: <linux-nfs+bounces-1199-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 650F0831613
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jan 2024 10:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20151F24817
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jan 2024 09:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675F41F94C;
	Thu, 18 Jan 2024 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJJgBayC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E436C1F92D
	for <linux-nfs@vger.kernel.org>; Thu, 18 Jan 2024 09:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705571094; cv=none; b=dsZPMR26qDVOCcWR+AYVYVleK79GsKa98+a242/Uapro9yAEOESsHvi+UoBxA4wyvovu9WfK//rQAGvEcgtGRVuaAsjsYyHJNSWJFxpJn8WANuR6qbQBxMM+lIoSeFDP8fRC35N7ILhwLSKXEuKnlh2SG5wyjKylRixeFl+88EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705571094; c=relaxed/simple;
	bh=TrJZSiZXM+wAYHHCYMyRR6/W0komxk9HJdBhLEr5IVw=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=dkR/S0mrU5OKeRl0zxEE35Sx9VcW/GyKKZIgbvqSMe30JoOnwM/KXmflhxm+Sgw/XxtjaNVLZBJwJL5/DVUbfQwF2XubK5FQXHk9UUIZUUKyzgQZ3yZ187fpsEOURJAlyxH8w7DOzjV2E0RPkB0ydzu8HJnVCWkWp0BEQKRh45s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJJgBayC; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-205f223639fso7342077fac.2
        for <linux-nfs@vger.kernel.org>; Thu, 18 Jan 2024 01:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705571092; x=1706175892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrJZSiZXM+wAYHHCYMyRR6/W0komxk9HJdBhLEr5IVw=;
        b=hJJgBayC2YOKKnkVdyF15uGymPvj1edfVtRQA1ok8CbGgZCQV0xfVobqkWRFFYvLA5
         8l2XyFRTVgjjF3JaeTHZbhd0jeyMxzeASI2FBZbrb6ZeUncbby/mJygIyigHIvfIg0H+
         FuEeEW8Yr3QSxWl/yYcpRLg5VmsD9Z0bMkpNMPhxihJTqKikbRpCcLJ4xREMqRRd02Cj
         0sjnwY0SZGXFNz0ROQJdUd3mwtGBNcCvp/a6qWPaX3TW8YIzzCPCvC0LgxKyQwN2Ar/S
         NLKTHXeHmxu7yJ8KecCpd8NehEjzq7MGsQkUiuO847l3qbpXSPhlB1mxX28l4bzkG9zs
         pKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705571092; x=1706175892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TrJZSiZXM+wAYHHCYMyRR6/W0komxk9HJdBhLEr5IVw=;
        b=jmhd92kDD/1ThPCefZucJBl+F1GnEjTEvc+5hVfLwBefvC/AyykpsO3mMsEQUPpGVB
         oqh55iBNtTdKLWSwNkmGSV+YlY9rs9OwsD+KVpcfi269OZ0klC4Cyr27K0jANJwzJ//G
         HWTEP4DEC87/lauifF1Z8q1fULkVnwgLHbAvk6uLmCWLgrajKKOLf0UOn+Rvu+HfHYAA
         s0UOS86vW2/Cukc3mtTGDxegcUczKEMNsZ2AOhcPzloqPHaIllrxYcw+mDKD2H6/s/+P
         MeZ+kcfc16V3wTN1g6FbY2bma1VzJWKmlw6PpmCkNFmj++Sj8NVnQ4Rbtk5vhxfNoDMf
         beqw==
X-Gm-Message-State: AOJu0YyO6MPgKILTG24pucYV+3dP2aEZuqFaUgXUbcz2spIHVVnwzB52
	9Fb4CvD79LuHCmWX0v/twTX0NDPndFpOqyKXK8XBkVZwaDBeZm0uYyTzgjiPuTR60BBisg/c2oL
	flsEZSkxEUDsdO7PKAI4B+7qH94o=
X-Google-Smtp-Source: AGHT+IH5qu3xiQ4QtxAbhZCxcOJWFXVVxzhtRLTR6BYFq5WkEZV525SDDSc5h9lOn8m0kaG6W0QKqe2JRYBB3EstWSs=
X-Received: by 2002:a05:6871:33a1:b0:204:2ac1:87ee with SMTP id
 ng33-20020a05687133a100b002042ac187eemr587142oac.105.1705571092009; Thu, 18
 Jan 2024 01:44:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCNcDtTNDRvUVjUy4BE7eBCgmkb6hfkq3P0jaGDC=OXg0=6g@mail.gmail.com>
 <CAKAoaQmmEv+HRjmBMrSMGZn9RQr8C=2W4yeX4vNnohXFJPCV5A@mail.gmail.com>
 <65a29ca8.6b0a0220.ad415.d6d8.GMR@mx.google.com> <CAKAoaQkZ+b7NfrVi=gu1vCJBvv10=k85bG_kZV9G3jE45OOquw@mail.gmail.com>
 <0cd8fbfc707f86784dc7d88653b05cd355f89aad.camel@kernel.org>
 <24ACA376-5239-4941-BE53-70BF5E5E4683@oracle.com> <CAKAoaQny6G=JcKpJTYeLmNBEMgNkkc--T0Uvs1YbEX+JUD-PoA@mail.gmail.com>
In-Reply-To: <CAKAoaQny6G=JcKpJTYeLmNBEMgNkkc--T0Uvs1YbEX+JUD-PoA@mail.gmail.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Thu, 18 Jan 2024 10:44:40 +0100
Message-ID: <CANH4o6NcMbcNKxARcqhthXWkKk6_r31iKGjnS-RhFBB_AJFaJg@mail.gmail.com>
Subject: Re: RFE: Linux nfsd's |ca_maxoperations| should be at *least* |64|
 ... / was: Re: kernel.org list issues... / was: Fwd: Turn NFSD_MAX_* into
 tuneables ? / was: Re: Increasing NFSD_MAX_OPS_PER_COMPOUND to 96
To: Roland Mainz <roland.mainz@nrubsig.org>
Cc: Chuck Lever III <chuck.lever@oracle.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 2:57=E2=80=AFAM Roland Mainz <roland.mainz@nrubsig.=
org> wrote:
>
> On Sat, Jan 13, 2024 at 5:10=E2=80=AFPM Chuck Lever III <chuck.lever@orac=
le.com> wrote:
> > > On Jan 13, 2024, at 10:09=E2=80=AFAM, Jeff Layton <jlayton@kernel.org=
> wrote:
> > > On Sat, 2024-01-13 at 15:47 +0100, Roland Mainz wrote:
> > >> On Sat, Jan 13, 2024 at 1:19=E2=80=AFAM Dan Shelton <dan.f.shelton@g=
mail.com> wrote:
> [snip]
> > >> Is this the windows client?
> > > No, the ms-nfs41-client (see
> > > https://github.com/kofemann/ms-nfs41-client) uses a limit of |16|, bu=
t
> > > it is on our ToDo list to bump that to |128| (but honoring the limit
> > > set by the NFSv4.1 server during session negotiation) since it now
> > > supports very long paths ([1]) and this issue is a known performance
> > > bottleneck.
> >
> > A better way to optimize this case is to walk the path once
> > and cache the terminal component's file handle. This is what
> > Linux does, and it sounds like Dan's directory walker
> > optimizations do effectively the same thing.
>
> That assumes that no process does random access into deep subdirs. In
> that case the performance is absolutely terrible, unless you devote
> lots of memory to a giant cache (which is not feasible due to cache
> expiration limits, unless someone (please!) finally implements
> directory delegations).
>
> This also ignores the use case of WAN (wide-area-networks) and WLAN
> with the typical high latency and even higher amounts of network
> package loss&&retransmit, where the splitting of the requests comes
> with a HUGE latency penalty (you can reproduce this with network
> tools, just export a large tmpfs on the server, add a package delay of
> 400ms between client and server, use a path like
> "a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/0/1/2/3/4/5/6/7/8/9"=
,
> and compile gcc).
>
> And in the real world the Linux nfsd |ca_maxoperations| default of
> |16| is absolutely CRIPPELING.
> For example in the mfs-nfs41-client we need 4 compounds for initial
> setup for a file lookup, and then 3 per path component. That means
> that a defaut of 16 just fits (16-4)/3=3D4 path elements.
> Unfortunately the statistical average is not 4 - it's 11 (measured
> over five weeks with 81 clients in our company).
> Technically, in this scenario, a default of at least 11*3+4=3D37 would
> be MUCH better.
>
> That's why I think nfsd's |ca_maxoperations| should be at *least* |64|.
>

+1

I consider the default value of 16 even a bug, given the circumstances.

Thanks,
Martin

