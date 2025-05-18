Return-Path: <linux-nfs+bounces-11791-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D8DABB17B
	for <lists+linux-nfs@lfdr.de>; Sun, 18 May 2025 22:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F61174D8A
	for <lists+linux-nfs@lfdr.de>; Sun, 18 May 2025 20:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31551800;
	Sun, 18 May 2025 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZ0VuRDo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A42D23CB
	for <linux-nfs@vger.kernel.org>; Sun, 18 May 2025 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747598445; cv=none; b=af2DOBkkTPmr9uzFuVYfVo8NSeTK317GYgnn7w489BiuLQ0L2U+k4dZcvH5FIWXGGpNSTwdp29WxpL9A6Db27EXdb/e18Umsq10H5zOJ5H8nQLjBxwAM2JXrsrJGchBXf09Z9KH7pL+9NHAgbVOSFTnyc2u5wZ92Ej++xYac97I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747598445; c=relaxed/simple;
	bh=qxFm+ggX0ol3K+dlVrOir661ycHij+bMj11b+DzAI9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=lkMqizAt85gGvRgM19XjRzOTYUr3h7OuNcy7b3OLStNNhs6qowVlytZZpC9zuyvVII3p9jCPnVSJmlbJyLaxzdxs9FtzBQfdFKD8WFtIUkbOzhjO9hqH5MLAIdAuxgwdfqwjoECIxkV1m2tup30Xb/Q+a1EQ1DeK6JcJIxO/Ut0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZ0VuRDo; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5f3f04b5dbcso5270156a12.1
        for <linux-nfs@vger.kernel.org>; Sun, 18 May 2025 13:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747598441; x=1748203241; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUrzu7sQ2vli6gWo/11YUjSUCqywFyOIfNC55tf80Sc=;
        b=VZ0VuRDoHCOCC+dGd5g4u+0oSid81HSly8ojiteEbjqBXCeldjIY3xku/HYIKd9UaW
         fvTUV0gN20rxTSCVbH0yj3F5wWTV+NGdIQOeYjOJT/IFWl9Bi+V5A0v3Q8tP9Q8jf1Nn
         tHWXz4btcuOouEWaPy9Frj28VdnOernv5CPj6rIvB5JvOnI1OnXebPAGrE6LbtQCpfoF
         2q+48DPjO1nt7EPuVcPMZYwmN/apH7ZUeJWAmkWNR+/A/9s1nEsZqpictMguwLZyWFBw
         4L+pA6wdaMW5/Bmb3WvdlUTXXyTsfAB2RPBEAfDTFn8nKsusiZ5k6RugoA/MK9f5uYr1
         7+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747598441; x=1748203241;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUrzu7sQ2vli6gWo/11YUjSUCqywFyOIfNC55tf80Sc=;
        b=smjq0AZIv8emXK29yL44J26TfsKygjbd9PEWWOSofW9Jmo0HslQYTQPM6/3erXQ0zV
         hwi1JnAQ6PXdKUwxkwVGv64hpADdg7FYDg45/yki/dwDUdSZWCLtTiJIVDJPNaySi+wt
         yt4Kz6X6LiKr2kCRtqjgQ6/HXaWYEaQhRWEzt4MV0mppwIfExLHVFBBK2gbufgiPjD5V
         pM5oq21C/JfaTw0RSUiK7ExdOJkDFvzSPfsxNdo7Tqom1pxcjymElFGuNfVtBDPvGUBk
         qfWvwzK4FZaDAfRcHGSMQvh7fyTjwyuxnIp8xSkRxSNtHCRqHBZS0D6m5jhOUUxCzgzl
         h9qA==
X-Gm-Message-State: AOJu0Yyq3T5cL72CCg7VfnM4CFJ5rZTFviQGAYNDxLmNOV9s9C9scYrG
	2ulqsfkEBXaguHjxmW9ORW7XMA9b1ihWqbJx23378mgFO79yVkf4GsrBIRsf7cwnZTZmWxnOOS3
	RwhvktG5KzQjoS4U5NrLVxgJc8dGymxMw66I/
X-Gm-Gg: ASbGncuwQ+bDkQvpmf8rx1OSmvJWJKLsvf342dnmtihjHvI2V2RvBfM1aevW773kPwZ
	zR1ElK8iaR4hE6sr1wTVvbIL0/ERF18WtPOejuv0NrglWAbhUK8Z1gEeQeJOaGWceJ9Df0sCUsi
	e8YBNENmOLmC0ohSxsdIpLV2mmlU6JKFE=
X-Google-Smtp-Source: AGHT+IHxRAx/PB/mXbHiSo0reKCZArpl41tiP3P+OkW7MM3YVMHWZqOXVaq4ZtFduKbDiWfuRAwNCbmPKx887iMsxPA=
X-Received: by 2002:a05:6402:5cd:b0:5fd:194e:9ee3 with SMTP id
 4fb4d7f45d1cf-600900de83fmr8262397a12.24.1747598440626; Sun, 18 May 2025
 13:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANH4o6Pvc7wuB0Yh8sEQDRg59_=rUNtnpgJizZ5mmmGNgY5Qrg@mail.gmail.com>
 <4ff815cc-6d9b-4af3-a53a-7700a8f85f08@oracle.com>
In-Reply-To: <4ff815cc-6d9b-4af3-a53a-7700a8f85f08@oracle.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Sun, 18 May 2025 22:00:02 +0200
X-Gm-Features: AX0GCFtd3pRIBzqoCBmyNzMIsr5gALyjYcSt0gWI_LcWEhO7srzrQy0eGsmxxIg
Message-ID: <CANH4o6OAPvm__cuhUcMEvsSRmHd-XwKYt_wdHYDCOozeho2rqg@mail.gmail.com>
Subject: Re: Why TLS and Kerberos are not useful for NFS security Re: [PATCH
 nfs-utils] exportfs: make "insecure" the default for all exports
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 2:29=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 5/14/25 5:50 PM, Martin Wege wrote:
> > On Wed, May 14, 2025 at 1:55=E2=80=AFPM NeilBrown <neil@brown.name> wro=
te:
> >>
> >> On Wed, 14 May 2025, Jeff Layton wrote:
> >> Ignoring source ports makes no sense at all unless you enforce some ot=
her
> >> authentication, like krb5 or TLS, or unless you *know* that there are =
no
> >> unprivileged processes running on any client machines.
> >
> > I don't like to ruin that party, but this is NOT realistic.
> >
> > 1. Kerberos5 support is HARD to set up, and fragile because not all
> > distributions test it on a regular basis. Config is hard, not all
> > distributions support all kinds of encryption methods, and Redhat's
> > crusade&maintainer mobbing to promote sssd at the expense of other
> > solutions left users with a half broken, overcomplicated Windows
> > Active Directory clone called sssd, which is an insane overkill for
> > most scenarios.
> > gssproxy is also a constant source of pain - just Google for the
> > Debian bug reports.
> >
> > Short: Lack of test coverage in distros, not working from time to
> > time, sssd and gssproxy are more of a problem than a solution.
> >
> > It really only makes sense for very big sites and a support contract
> > which covers support and bug fixes for Kerberos5 in NFS+gssproxy.
>
> Brief general comment: We are well aware of the administrative
> challenges presented by Kerberos. :-)

Well, the primary roadblock for development and TESTING seems to be
the absolute insane setup requirements. Every doc I find talks about
sssd, LDAP, Krb5.

I think what is needed for small scale testing is the so called
"grocery shop setup":
Two machines with local accounts (i.e. /etc/passwd), one NFS server
with Krb5 server, one NFS client with Krb5 client.
NO LDAP, NO TLS, NO Krb5 preauth

Unfortunately all docs describing that are GONE.

>
>
> > 2. TLS: Wanna make NFS even slower? Then use NFS with TLS.
> >
> > NFS filesystem over TLS support then feels like working with molasses.
>
> We'd like to hear quantitative evidence. In general, TLS with a NIC
> that has encryption offload is going to be faster than NFS/Kerberos with
> the privacy service.

You can test it yourself:
1. WAN config with 0.1s latency per hop, 2 hops, leads to "simple"
tasks like mkdir, mkfile, mknod to take > 1.6 seconds.
2. Parallelism is ruined by all traffic going through the TLS layer.
3. Latency is unbearable high, and [2] is not going to save the
situation this time (never was a solution anyway)
3. TLS layer does not respect RPC boundaries, a problem shared with
ssh and other encryption and compression programs. Simply said, TLS
has no concept or api similar to TCP CORK, or just flush. RPC packages
get "stuck" in the TLS layer, leading to excessive waiting times until
more data arrives. This might even not be fixable without a better TLS
protocol, or at least an API which handles message boundaries.

>  krb5p cannot be offloaded, full stop.

Sigh.

Who is claiming that? Same marketing gurus who "foresaw the rise of the TLS=
"?

>
> An increasing number of encryption-capable NICs are reaching the
> marketplace, and the selection of encryption algorithms available for
> TLS includes some CPU-efficient choices.

Poinnt [3]. TLS is just very poorly suited for RPC, and no hardware
acceleration will fix that.

TLS is designed for large chunk transfers. All the tiny bitsy RPC
packages don't work well over TLS, unless there is a lot of parallel
traffic, or large READ or WRITE transfers.

>
> Thus our expectation is that TLS will become a more performant
> solution than Kerberos.

Which marketing team came up with that "prediction"?

Judging from WAN experience, judging from the design and API deficits,
NFS over TLS is simply a failed experiment.

Just some statistics:
Our company is consulting 86 companies trying to deploy NFS over TLS
since the beginning of 2024, and NONE of them thinks it is usable,
ready for production or even close to something like that. Everyone is
pretty upset about latency spikes, lack of throughput, very high CPU
usage and other problems.

> In addition, the trend is towards always-on
> encryption (QUICv1). IMO you will not be able to avoid encryption-in-
> transit in the future.
>
>
> > Exacerbated by Linux's crazy desire to only support hyper-secure
> > post-quantum encryption method (so no fast arcfour, because that is
> > "insecure", and everyone is expected to only work with AMD
> > Threadripper 3995WX), lack of good threading through the TLS eye of
> > the needle, and LACK of support in NFS clients.
>
> I believe the IETF has also broadly discouraged the use of easy-to-
> defeat encryption algorithms.

Sometimes I think the IETF decisions are a) from Mars or b) done by
marketing, and not rooted in reality.

> Perhaps this desire is not limited to only
> Linux.

And how should the "small shops" (below what Oracle would call
multi-million enterprises) should deploy an usable NFS over TLS
configuration then? Basically you force them to either have ZERO
security, or a security they CANNOT AFFORD.
No middle ground.

Which brings us back to the debate of the secure/insecure export
option, and overkill Krb5 configs like sssd.

>
> Using a deprecated encryption algorithm means you get very little
> real security in addition to worse performance, so it's not a good
> choice.

Then please forget about using TLS. and don't recommend a
broken-by-design solution.

Thanks,
Martin

