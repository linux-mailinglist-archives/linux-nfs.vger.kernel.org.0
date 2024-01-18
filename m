Return-Path: <linux-nfs+bounces-1196-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C76831128
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jan 2024 02:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C3CC1F25ABE
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jan 2024 01:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3085665;
	Thu, 18 Jan 2024 01:56:41 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8E4568B
	for <linux-nfs@vger.kernel.org>; Thu, 18 Jan 2024 01:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705543000; cv=none; b=iTVhusESvPIYlSXJVOKI2LOfJsHZ9NJzxYvHU3vaIYXP9p/m9WuUGERyhCwohF+BETDKuOPX7LMx5LKtPpoLWs97v8hm1HQW52kIy0tczHDUtJkvMthHT42/GW4lDsgGcfJj11y1KqB+RUYw6SoL/mh3/aV9g9gNEDlyMpAF/+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705543000; c=relaxed/simple;
	bh=G6sblrRomRUJuU/UpJqtspdUT/zCqrJdOewNEz7xres=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:Message-ID:Subject:To:Content-Type:
	 Content-Transfer-Encoding; b=Jk3IYeryVnP+IH2Ke3BQTJxQkYUE7ccCK49vogLCDk7+Lf57gII5yhh/wTc4yKnSnznjJRMwzeQ2VM3U5nRUDKyFBx8O8LOKu4Bb5FAkegdbKLP6ichhsv3nsR3xg58RBZKTQjFTxRFSIo/7ynFZt29bkdqQUXjiJD7SmNh3EUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36091f4d8easo47181515ab.2
        for <linux-nfs@vger.kernel.org>; Wed, 17 Jan 2024 17:56:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705542998; x=1706147798;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhUXkCsYS2Z/RgTZ+8AEvmSZuFd+yFPWS43ZQyktNpE=;
        b=cRCzEexr6go33banHys47U2HCHqp2/zK1C0mcYzgHOeRj+RgbheXWSFpw5I580hod2
         r4loP8bu58tKJIuQBUfqXLEXqHkZjn3r54lffeVn3jwr5qlFC2+32G4sipD7OptAObSZ
         jfZpi0Qjqo6kjtA8M6GllamVhuwRQ9CDdn28Ai/aidDOLcvpXY5x2p4uVEuVPtTfjeIN
         4N1MJ6c7UYKC0kXJ5KNRUSiH86GeYFuRI4v6jnLZa4rlEzApI69E3pP+nAE9N2H/LSY0
         Xh9aHMyMudtQyING9HrnfalEjFKxi2DfPaYw5OCHUqZmio/mwk3LmCV7W/2Oa9hMypLN
         ZltQ==
X-Gm-Message-State: AOJu0YzNLG70u6+YP0eitDETDPqTHCBba2JlDX7s7UzknxGEysXTvK21
	4FLQj07wEGAMTXCQKnNtpT0Sc9OPVYeXmEVt4zQ4UYi6eriTsFsQtcq1X4L6/N+KhawB0L728aX
	esq+vI/Wp5ocWw6RyEKjGXyWI1FgG769D
X-Google-Smtp-Source: AGHT+IGFq7hclqzJBmENjZUHTOJUhmpCmqnA3GcBx+oqXIKZ98MtqePkk41PE/T+FZOrgMnvucD6gEtfB5N/xnZu+fU=
X-Received: by 2002:a92:ce42:0:b0:361:9249:5aed with SMTP id
 a2-20020a92ce42000000b0036192495aedmr232564ilr.52.1705542998547; Wed, 17 Jan
 2024 17:56:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCNcDtTNDRvUVjUy4BE7eBCgmkb6hfkq3P0jaGDC=OXg0=6g@mail.gmail.com>
 <CAKAoaQmmEv+HRjmBMrSMGZn9RQr8C=2W4yeX4vNnohXFJPCV5A@mail.gmail.com>
 <65a29ca8.6b0a0220.ad415.d6d8.GMR@mx.google.com> <CAKAoaQkZ+b7NfrVi=gu1vCJBvv10=k85bG_kZV9G3jE45OOquw@mail.gmail.com>
 <0cd8fbfc707f86784dc7d88653b05cd355f89aad.camel@kernel.org> <24ACA376-5239-4941-BE53-70BF5E5E4683@oracle.com>
In-Reply-To: <24ACA376-5239-4941-BE53-70BF5E5E4683@oracle.com>
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Thu, 18 Jan 2024 02:56:12 +0100
Message-ID: <CAKAoaQny6G=JcKpJTYeLmNBEMgNkkc--T0Uvs1YbEX+JUD-PoA@mail.gmail.com>
Subject: RFE: Linux nfsd's |ca_maxoperations| should be at *least* |64| ... /
 was: Re: kernel.org list issues... / was: Fwd: Turn NFSD_MAX_* into tuneables
 ? / was: Re: Increasing NFSD_MAX_OPS_PER_COMPOUND to 96
To: Chuck Lever III <chuck.lever@oracle.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 13, 2024 at 5:10=E2=80=AFPM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
> > On Jan 13, 2024, at 10:09=E2=80=AFAM, Jeff Layton <jlayton@kernel.org> =
wrote:
> > On Sat, 2024-01-13 at 15:47 +0100, Roland Mainz wrote:
> >> On Sat, Jan 13, 2024 at 1:19=E2=80=AFAM Dan Shelton <dan.f.shelton@gma=
il.com> wrote:
[snip]
> >> Is this the windows client?
> > No, the ms-nfs41-client (see
> > https://github.com/kofemann/ms-nfs41-client) uses a limit of |16|, but
> > it is on our ToDo list to bump that to |128| (but honoring the limit
> > set by the NFSv4.1 server during session negotiation) since it now
> > supports very long paths ([1]) and this issue is a known performance
> > bottleneck.
>
> A better way to optimize this case is to walk the path once
> and cache the terminal component's file handle. This is what
> Linux does, and it sounds like Dan's directory walker
> optimizations do effectively the same thing.

That assumes that no process does random access into deep subdirs. In
that case the performance is absolutely terrible, unless you devote
lots of memory to a giant cache (which is not feasible due to cache
expiration limits, unless someone (please!) finally implements
directory delegations).

This also ignores the use case of WAN (wide-area-networks) and WLAN
with the typical high latency and even higher amounts of network
package loss&&retransmit, where the splitting of the requests comes
with a HUGE latency penalty (you can reproduce this with network
tools, just export a large tmpfs on the server, add a package delay of
400ms between client and server, use a path like
"a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/0/1/2/3/4/5/6/7/8/9",
and compile gcc).

And in the real world the Linux nfsd |ca_maxoperations| default of
|16| is absolutely CRIPPELING.
For example in the mfs-nfs41-client we need 4 compounds for initial
setup for a file lookup, and then 3 per path component. That means
that a defaut of 16 just fits (16-4)/3=3D4 path elements.
Unfortunately the statistical average is not 4 - it's 11 (measured
over five weeks with 81 clients in our company).
Technically, in this scenario, a default of at least 11*3+4=3D37 would
be MUCH better.

That's why I think nfsd's |ca_maxoperations| should be at *least* |64|.

----

Bye,
Roland
--=20
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /=3D=3D\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)

