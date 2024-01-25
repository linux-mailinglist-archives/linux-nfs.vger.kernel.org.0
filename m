Return-Path: <linux-nfs+bounces-1446-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC5183D045
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 00:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB3E428D045
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 23:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4D7125C2;
	Thu, 25 Jan 2024 23:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnz3eqcj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94A0125BD
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 23:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706223866; cv=none; b=WqnEUCWyEZEv7VDhdR2gUXB6cHm5Z5rJ0CJl6rB1dWHjrmB6viOOP1S4J7wyzgyrjmosOPdBK1Jh7PNdU6cGv3qPApR8SjMPgSqe9YvQzx/UL9Ifq7qSeBrvhXAQ1BmkjapmH0DRhXwPgWJweQ9bzUljQIYwn/7HC7vQuGYDFQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706223866; c=relaxed/simple;
	bh=Z57SyhUJ4wU5pyyb8zu3tz56azmoY+7XhtLa4g1s5Tw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OEQEWwwYftPz819ozIcnOnT4IuVrKVHO/uue7bjLt78rtKxYQUk0OPOOUkQInPPeZhnc8o8XMig+sCCYDQYBye2sVwr45WvKax85VLFIvYLmkKVzd0IDio+fEI2GDNau/E5EoazN9TJozi8IMuilAcLKQL54Z4+RXakWSqEuScs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnz3eqcj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43FCC433C7;
	Thu, 25 Jan 2024 23:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706223866;
	bh=Z57SyhUJ4wU5pyyb8zu3tz56azmoY+7XhtLa4g1s5Tw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=gnz3eqcj0j5X2vB0ruLRf/1BDraRi9SzVhjCLr+rwwxm/xixFOLHAHV4wpkw2+79G
	 2151+LSQQ/cznC7DyfdsW1TPo5YJPVQIHApHA/orznpNS/oekpw9pYhFv8ZVYiVU3/
	 CbAneD3lXh5wEOYpiaQ86jyL8OTk9gJGYJK94FBRCTPR9K/r2acZPT+UyQiky4TvZd
	 GtKvsB2+54kOrmvaD3Uj2+EQcepBr5BlJdIruEthjunWogB5Ti2HIRqaMSx94PiVrL
	 NNfcbFc87NfBSnIyam3rlDCwki3C8I6pUzRtKA22fTgbwuEry9xpnmcWeZeLtYUJHs
	 TKpx6YZnnjpcg==
Message-ID: <c3f4b19aeb16b1072b3ab907e1ab543f16830840.camel@kernel.org>
Subject: Re: Should we establish a new nfsdctl userland program?
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Lorenzo Bianconi
 <lorenzo.bianconi@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, 
 "olga.kornievskaia" <olga.kornievskaia@gmail.com>, Tom Talpey
 <tom@talpey.com>, linux-nfs <linux-nfs@vger.kernel.org>
Date: Thu, 25 Jan 2024 18:04:21 -0500
In-Reply-To: <170621711779.21664.12957469850987797917@noble.neil.brown.name>
References: <8a7bbc05b6515109692cb88ad68374d14fc01eca.camel@kernel.org>
	 <170621711779.21664.12957469850987797917@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-01-26 at 08:11 +1100, NeilBrown wrote:
> On Fri, 26 Jan 2024, Jeff Layton wrote:
> > The existing rpc.nfsd program was designed during a different time, whe=
n
> > we just didn't require that much control over how it behaved. It's
> > klunky to work with.
>=20
> How is it clunky?
>=20
>   rpc.nfsd
>=20
> that starts the service.
>=20
>   rpc.nfsd 0
>=20
> that stops the service.
>=20
> Ok, not completely elegant.  Maybe
>=20
>   nfsdctl start
>   nfsdctl stop
>=20
> would be better.
>=20

It's clunky if you have to script around it. Mostly it's an issue for
people doing clustering and that sort of thing.

> >=20
> > In a response to Chuck's recent RFC patch to add knob to disable
> > READ_PLUS calls, I mentioned that it might be a good time to make a

Sorry, not READ_PLUS calls here, I meant splice_reads...

> > clean break from the past and start a new program for controlling nfsd.
> >=20
> > Here's what I'm thinking:
> >=20
> > Let's build a swiss-army-knife kind of interface like git or virsh:
> >=20
> > # nfsdctl=A0stats			<--- fetch the new stats that got merged
> > # nfsdctl add_listener		<--- add a new listen socket, by address or hos=
tname
> > # nfsdctl set v3 on		<--- enable NFSv3
> > # nfsdctl set splice_read off	<--- disable splice reads (per Chuck's re=
cent patch)
> > # nfsdctl set threads 128	<--- spin up the threads
>=20
> Sure the "git" style would use
>=20
>    nfsdctl version 3 on
>    nfsdctl threads 128
>=20

I like following git's example syntactically.

> Apart from "stats", "start", "stop", I suspect that we developers would
> be the only people to actually use this functionality.=A0
>=20

Agreed, maybe alongside higher orchestration like containerization or
clustering tech.

>  Until now,=20
>   echo > /proc/sys/nfsd/foo
> has been enough for most tweeking.  Having a proper tool would likely
> lower the barrier to entry, which can only be a good thing.
>=20

I think so too. Also, we don't really have that option with netlink. We
need some sort of tool to drive the new interfaces.

> >=20
> > We could start with just the bare minimum for now (the stats interface)=
,
> > and then expand on it. Once we're at feature parity with rpc.nfsd, we'd
> > want to have systemd preferentially use nfsdctl instead of rpc.nfsd to
> > start and stop the server. systemd will also need to fall back to using
> > rpc.nfsd if nfsdctl or the netlink program isn't present.
>=20
> systemd doesn't need a fallback.  Systemd always activates
> nfs-server.service.  We just need to make sure the installed
> nfs-server.service matches the installed tools, and as they are
> distributed as parts of the same package, that should be trivial.
>=20

The problem is the transition period. There will come a time where
people will have kernels that don't support the new netlink interface,
but newer userland.

We could teach nfsdctl to work with nfsdfs, but I'd rather it just bail
out and say "Sorry, you have to use rpc.nfsd on this old kernel".

Maybe we don't need to worry about plumbing that logic into the systemd
service though, and just having distros do a hard cutover at some point
makes more sense.

> >=20
> > Note that I think this program will have to be a compiled binary vs. a
> > python script or the like, given that it'll be involved in system
> > startup.
>=20
> Agreed.
>=20
> >=20
> > It turns out that Lorenzo already has a C program that has a lot of the
> > plumbing we'd need:
> >=20
> >     https://github.com/LorenzoBianconi/nfsd-netlink
> >=20
> > I think it might be good to clean up the interface a bit, build a
> > manpage and merge that into nfs-utils.
> >=20
> > Questions:
> >=20
> > 1/ one big binary, or smaller nfsdctl-* programs (like git uses)?
>=20
> /usr/lib/git-core (on my laptop) has 168 entries.  Only 29 of them are
> NOT symlinks to 'git'.
>=20
> While I do like the "tool command args" interface, and I like the option
> of adding commands by simply creating drop-in tools, I think that core
> functionality should go in the core tool.
> So: "one big binary" please - with call-out functionality if anyone can
> be bothered implementing it.
>=20

Ok, sounds good to me.

> >=20
> > 2/ should it automagically read in nfs.conf? (I tend to think it should=
,
> > but we might want an option to disable that)
>=20
> Absolutely definitely.  I'm not convinced we need an option to disable
> config, but allowing options to over-ride specific configs is sensible.
>=20
> Most uses of this tool would come from nfs-server.service which would
> presumably call
>    nfsdctl start
> which would set everything based on the nfs.conf and thus start the
> server.  And
>    nfsdctl stop
> which would set the number of threads to zero.
>=20

Sensible.

> >=20
> > 3/ should "set threads" activate the server, or just set a count, and
> > then we do a separate activation step to start it? If we want that, the=
n
> > we may want to twiddle the proposed netlink interface a bit.
>=20
> It might be sensible to have "set max-threads" which doesn't actually
> start the service.
> I would really REALLY like a dynamic thread pool.  It would start at 1
> (or maybe 2) and grow on demand up to the max, and idle threads
> (inactive for 30 seconds?) would exit.  We could then default the max to
> some function of memory size and people could mostly ignore the
> num-threads setting.
>=20
> I don't have patches today, but if we are re-doing the interfaces I
> would like us to plan the interfaces to support a pool rather than a
> fixed number.
>=20

I like that idea too. A dynamic threadpool would be very nice to have.
Since we're dreaming:

Maybe we can set "threads" to a specific value (-1?) that makes it start
the pool at "min_threads" and dynamically size the pool up to
"max_threads" with the load.

> >=20
> > I'm sure other questions will arise as we embark on this too.
> >=20
> > Thoughts? Anyone have objections to this idea?
>=20
> I think this is an excellent question to ask.  As you say it is a long
> time since rpc.nfsd was created, and it has grown incrementally rather
> then being clearly designed.


Thanks. I think this is something that has the potential to really make
server administration simpler.

I also wouldn't mind a readline-style shell interface if you just run
nfsdctl without arguments. Like:

# nfsdctl
nfsdctl> threads 128
nfsdctl> version 3 off
nfsdctl> start
nfsdctl> ^d

...but that could be added later too.

--=20
Jeff Layton <jlayton@kernel.org>

