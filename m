Return-Path: <linux-nfs+bounces-1448-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F6D83D1B3
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 01:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6DC1C22229
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 00:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8D8EC3;
	Fri, 26 Jan 2024 00:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XD+f9wnY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229C8EBE
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 00:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706230265; cv=none; b=t7uQp2WVI5tyX58eWMp1B+H8e7HYzJXrCtXrg1JhQFd4mIEqz1Ed0M4gViYPUdXGWbM+mUwKaYx+WyH9uIu76Rwfe0UiOJoj1Ku8TbD2EKwP9GzCCSJITPVySsH99kAEnEcghH63UspFyvglpQy9TRJ7UCJON+F2dVpx7oAOH9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706230265; c=relaxed/simple;
	bh=LCg8pPjX9XQtamxlv1yLvyRFSg9i4GQAAKIKxgFGT6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jq21NhYctykeT5EW8cgz4HrHFEkwatXZ01eF8oYuSaXZcCamDEVK9GpQn31kn5myxOnaR5s2ir6TjyrJgbpVOH7ur7slQPMr8qCnUlbY4BlkLCgLcyumVPCuEE4xGaQCBhPyYF6PZvdDj276Lg0O7cIYzSnHCxw7vi7F2H94k2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XD+f9wnY; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e9e5c97e1so347045e87.0
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 16:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706230262; x=1706835062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwmZML1XEoo3mKFn3Rns19ycMh3Tc/+J1jUIvA0cSFs=;
        b=XD+f9wnYzQDet46pcL9hCreQhaTpqB1szSwLZKjIbsFZSzexTclFmgwUHQimqGsgbp
         tMKB0ZFRk9PxX1IR5qq1xAYudSP9yfPKSE0woACJL9+TFTjwEq77lppLjoNDCrTj5M/i
         10gO6bUkMmSzdFTU8cW+YQTj4obBnnjbISdiEuGzHXjZbm60ixDsPLi3EqhY6I8q0LB7
         /C4O8+5/XHYofIt+SWgu91EaNzM+Xkkk5rtyhgjuUG+MWTN1Guebo9D/EWe6RolHC8+U
         xDboLb+XsVhpZyci+Mv8gI40Fc2DKSBDkmJotHWWt6CtFIld78IIGbL1DdtdQgQk61ub
         dwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706230262; x=1706835062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OwmZML1XEoo3mKFn3Rns19ycMh3Tc/+J1jUIvA0cSFs=;
        b=myDthQyN2JI25A8vuhGZOEnEXH4JOpqz/pscQniC4EfWPImW3+Ge879Itv7wJEUYyj
         a9bXXAsqMxnfzd7S6GZMZLg6ELUOs9w4Zmk1b56HQVtgDvZuzs5gdywXGWaVQzKvcllx
         AotWvWUELZCYDDNHP8BC+IQY9QWh1gLDBSPG7zedrElVkjeSN5zmAackVvV0znNAwYh2
         6eXxrzwdQBHcuVRXOzAfDoDbiC8sN/J3Ic41pkI9utrnN7D+cjQm+yKnZbJQGCLMa3cH
         KVOU6Uh3DJm/f6HVOHmErHaCg3n5QXWG/cwzrSXIR73GuPQSnRk6Q/02TZuLWnrcQRiQ
         3L5w==
X-Gm-Message-State: AOJu0YyvK8en7g5HVXOW5ad1xe1GqyBquHj0YhXTrUAfJjj0SlBn1H5L
	v98iNuHy+qtVpjw0GTuOKbNrFVL9tP8FyzwWMsbCCDNButttk5nM5rDEFphESjWdxSXiJqIlGc2
	VKzJCHrxilFzB+7jlOmeunJeASWg=
X-Google-Smtp-Source: AGHT+IHh9nPCsEWhR4FpXxQGXI2AcUxyjtGUrnKyScfwq3Ggp0XTcMqgAwR0Alwq12D+pdKhCQg4obM4/uUNxAGTCq4=
X-Received: by 2002:a05:6512:33ca:b0:510:a2f:fc48 with SMTP id
 d10-20020a05651233ca00b005100a2ffc48mr357392lfg.138.1706230261748; Thu, 25
 Jan 2024 16:51:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8a7bbc05b6515109692cb88ad68374d14fc01eca.camel@kernel.org>
 <CALXu0UcV0b8OvH7_05tD7+GRgoXRcp9fd1aXuHjtF2OBDPmSJw@mail.gmail.com> <66892D4F-4721-48E5-A088-BD75500275AD@oracle.com>
In-Reply-To: <66892D4F-4721-48E5-A088-BD75500275AD@oracle.com>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Fri, 26 Jan 2024 01:50:34 +0100
Message-ID: <CAAvCNcA4x1vR2Bh0vTy+kc7tK0t7sdM0JPJa5-XfLhD+-mLQTg@mail.gmail.com>
Subject: Re: Should we establish a new nfsdctl userland program?
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Cedric Blancher <cedric.blancher@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, NeilBrown <neilb@suse.com>, 
	Dai Ngo <dai.ngo@oracle.com>, Olga Kornievskaia <olga.kornievskaia@gmail.com>, 
	Tom Talpey <tom@talpey.com>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Jan 2024 at 21:25, Chuck Lever III <chuck.lever@oracle.com> wrot=
e:
>
>
>
> > On Jan 25, 2024, at 2:54=E2=80=AFPM, Cedric Blancher <cedric.blancher@g=
mail.com> wrote:
> >
> > On Thu, 25 Jan 2024 at 20:41, Jeff Layton <jlayton@kernel.org> wrote:
> >>
> >> The existing rpc.nfsd program was designed during a different time, wh=
en
> >> we just didn't require that much control over how it behaved. It's
> >> klunky to work with.
> >>
> >> In a response to Chuck's recent RFC patch to add knob to disable
> >> READ_PLUS calls, I mentioned that it might be a good time to make a
> >> clean break from the past and start a new program for controlling nfsd=
.
> >>
> >> Here's what I'm thinking:
> >>
> >> Let's build a swiss-army-knife kind of interface like git or virsh:
> >>
> >> # nfsdctl stats                 <--- fetch the new stats that got merg=
ed
> >> # nfsdctl add_listener          <--- add a new listen socket, by addre=
ss or hostname
> >
> > Absolutely NOT "hostname". Please do not repeat the mistake AGAIN of
> > separating "host name" and "TCP port", as they are both required to
> > find the server. Every 10 or 15 years the same mistake is made by the
> > next generation of software engineers.
>
> I don't see how this is a mistake.
>
> >   port
> >      The port number to connect to. Most schemes designate
> >      protocols that have a default port number. Another port number
> >      may optionally be supplied, in decimal, separated from the
> >      host by a colon. If the port is omitted, the colon is as well.
>
> NFS has a default port number. Thus, even RFC 1738 states that
> "hostname" is just fine. It means "DNS label and default port".
>
> Most usage scenarios will prefer the shorthand of leaving off the
> port. So engineers seem to be designing interfaces for the most
> common usage, don't you think?

The most common usage? For small shops that might apply, but not for
big hosters where IPv4 addresses are a scarce resource.
>
>
> > https://datatracker.ietf.org/doc/html/rfc1738 clearly defined
> > "hostport", and that is what should be used here.
>
> RFC 1738 was published very clearly before the widespread use of
> IPv6 addresses,

Read below, you need [ and ] for IPv6 addresses, or be in parser hell.

> which use a : to separate the components of an
> IP address.

I think you take the syntax part too seriously, and not Cedric's
message: Address and port should be specified together, as they are
required to be used together to create the socket. It's part of the
address information.

Instead of fighting over syntax (hostname@port, hostname:port, ...) it
should seriously be considered to include the port.

Also, it might be good for hosters to allow more than one nfsd
instance with seperate exports file, each running on its own
address/port combination. And not force them to use a VM to bloat
resources.

> Certainly the add_listener subcommand can take a port, but there's
> plenty of room to add that in other ways.
>
> For example, we might want:
>
> # nfsdctl add_listener
>
>    xprt <udp|tcp|rdma>
>
>    host <DNS label>  |   addr <IPv4 or IPv6 address>
>
> and optionally
>
>    port <listener port>

Nope. Just hostname:port or hostname@port. For raw IPv6 addresses you
have to use square brackets anyway, or end up in parser hell.

Dan
--=20
Dan Shelton - Cluster Specialist Win/Lin/Bsd

