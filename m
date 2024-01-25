Return-Path: <linux-nfs+bounces-1437-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD51583CE31
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 22:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2DCC1C23049
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 21:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0E8129A9E;
	Thu, 25 Jan 2024 21:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dlMOSpC7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bfFi7BDh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dlMOSpC7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bfFi7BDh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EB05B210
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 21:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706217127; cv=none; b=SVh3FHuwRKZ9I2UfdfqlBm+iHGJvny7pxAAcekI+acXZwJEb5cACkjJNJSIeu0KjT4N/tfPKwbFt7Wm6ZKnQkuZ+obf53H0/wNUtGfi4BJl6tGGvJwxFt2ZkQgrJYjW29aQIMUdCWVZO4ElSD0hGvYSimZayjU9qwLYMxIfTfPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706217127; c=relaxed/simple;
	bh=1oaq3ENAD4kjuIgS5g8DRWLEDJGNMw13FJkd0Ty4x7s=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=tnbfSDvHEQfysa2YdoZSUUqy8vu59NzEcAf63xjH7SRc36V6Hmha3/rWpN89XH773LHJ3AOlvKSLd/HUsa/aAOMvHU5unG8bwDf78vU7BuHjAxMcq4rAIekRfNAdQ0GmjrLmnAKiUykkPd35cE718u9hlxRBze09Nmq+kj1hBZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dlMOSpC7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bfFi7BDh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dlMOSpC7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bfFi7BDh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 283BA1FB3C;
	Thu, 25 Jan 2024 21:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706217123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ev2gS+opCR8przuk4xW0mS9quwNEgVF7Eat5JxPL9OA=;
	b=dlMOSpC79gYdWM+2Y33320tcg3x0PKO7iXJYlVfgQya62f/Odi9CyHdM6kiDiFdjQRj6tr
	ywlHPF5uR8/J8VL2VeF7DPy5/5u5ztauRFYM+8wVSUjPnNgq4tyllfMuIZ8us+Kg5KbTH6
	wx+bUKC0eOgS4kdYZu6kAymTth/by4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706217123;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ev2gS+opCR8przuk4xW0mS9quwNEgVF7Eat5JxPL9OA=;
	b=bfFi7BDhTYxEN7ZQiz3VFcIsZMUCaVT0Uq0KkTXcFRFfCXnUnTUVQl+KfzX/MW5YoJkSil
	9D5KEiIs66CWRnBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706217123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ev2gS+opCR8przuk4xW0mS9quwNEgVF7Eat5JxPL9OA=;
	b=dlMOSpC79gYdWM+2Y33320tcg3x0PKO7iXJYlVfgQya62f/Odi9CyHdM6kiDiFdjQRj6tr
	ywlHPF5uR8/J8VL2VeF7DPy5/5u5ztauRFYM+8wVSUjPnNgq4tyllfMuIZ8us+Kg5KbTH6
	wx+bUKC0eOgS4kdYZu6kAymTth/by4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706217123;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ev2gS+opCR8przuk4xW0mS9quwNEgVF7Eat5JxPL9OA=;
	b=bfFi7BDhTYxEN7ZQiz3VFcIsZMUCaVT0Uq0KkTXcFRFfCXnUnTUVQl+KfzX/MW5YoJkSil
	9D5KEiIs66CWRnBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C09AA134C3;
	Thu, 25 Jan 2024 21:12:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K6oGHaDOsmUaSwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 25 Jan 2024 21:12:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Lorenzo Bianconi" <lorenzo.bianconi@redhat.com>,
 "Dai Ngo" <dai.ngo@oracle.com>,
 "olga.kornievskaia" <olga.kornievskaia@gmail.com>,
 "Tom Talpey" <tom@talpey.com>, "linux-nfs" <linux-nfs@vger.kernel.org>
Subject: Re: Should we establish a new nfsdctl userland program?
In-reply-to: <8a7bbc05b6515109692cb88ad68374d14fc01eca.camel@kernel.org>
References: <8a7bbc05b6515109692cb88ad68374d14fc01eca.camel@kernel.org>
Date: Fri, 26 Jan 2024 08:11:57 +1100
Message-id: <170621711779.21664.12957469850987797917@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.58
X-Spamd-Result: default: False [0.58 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 NEURAL_SPAM_SHORT(2.18)[0.727];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 TO_DN_ALL(0.00)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 SUBJECT_ENDS_QUESTION(1.00)[];
	 FREEMAIL_CC(0.00)[oracle.com,redhat.com,gmail.com,talpey.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Fri, 26 Jan 2024, Jeff Layton wrote:
> The existing rpc.nfsd program was designed during a different time, when
> we just didn't require that much control over how it behaved. It's
> klunky to work with.

How is it clunky?

  rpc.nfsd

that starts the service.

  rpc.nfsd 0

that stops the service.

Ok, not completely elegant.  Maybe

  nfsdctl start
  nfsdctl stop

would be better.

>=20
> In a response to Chuck's recent RFC patch to add knob to disable
> READ_PLUS calls, I mentioned that it might be a good time to make a
> clean break from the past and start a new program for controlling nfsd.
>=20
> Here's what I'm thinking:
>=20
> Let's build a swiss-army-knife kind of interface like git or virsh:
>=20
> # nfsdctl=C2=A0stats			<--- fetch the new stats that got merged
> # nfsdctl add_listener		<--- add a new listen socket, by address or hostname
> # nfsdctl set v3 on		<--- enable NFSv3
> # nfsdctl set splice_read off	<--- disable splice reads (per Chuck's recent=
 patch)
> # nfsdctl set threads 128	<--- spin up the threads

Sure the "git" style would use

   nfsdctl version 3 on
   nfsdctl threads 128

Apart from "stats", "start", "stop", I suspect that we developers would
be the only people to actually use this functionality.  Until now,=20
  echo > /proc/sys/nfsd/foo
has been enough for most tweeking.  Having a proper tool would likely
lower the barrier to entry, which can only be a good thing.

>=20
> We could start with just the bare minimum for now (the stats interface),
> and then expand on it. Once we're at feature parity with rpc.nfsd, we'd
> want to have systemd preferentially use nfsdctl instead of rpc.nfsd to
> start and stop the server. systemd will also need to fall back to using
> rpc.nfsd if nfsdctl or the netlink program isn't present.

systemd doesn't need a fallback.  Systemd always activates
nfs-server.service.  We just need to make sure the installed
nfs-server.service matches the installed tools, and as they are
distributed as parts of the same package, that should be trivial.

>=20
> Note that I think this program will have to be a compiled binary vs. a
> python script or the like, given that it'll be involved in system
> startup.

Agreed.

>=20
> It turns out that Lorenzo already has a C program that has a lot of the
> plumbing we'd need:
>=20
>     https://github.com/LorenzoBianconi/nfsd-netlink
>=20
> I think it might be good to clean up the interface a bit, build a
> manpage and merge that into nfs-utils.
>=20
> Questions:
>=20
> 1/ one big binary, or smaller nfsdctl-* programs (like git uses)?

/usr/lib/git-core (on my laptop) has 168 entries.  Only 29 of them are
NOT symlinks to 'git'.

While I do like the "tool command args" interface, and I like the option
of adding commands by simply creating drop-in tools, I think that core
functionality should go in the core tool.
So: "one big binary" please - with call-out functionality if anyone can
be bothered implementing it.

>=20
> 2/ should it automagically read in nfs.conf? (I tend to think it should,
> but we might want an option to disable that)

Absolutely definitely.  I'm not convinced we need an option to disable
config, but allowing options to over-ride specific configs is sensible.

Most uses of this tool would come from nfs-server.service which would
presumably call
   nfsdctl start
which would set everything based on the nfs.conf and thus start the
server.  And
   nfsdctl stop
which would set the number of threads to zero.

>=20
> 3/ should "set threads" activate the server, or just set a count, and
> then we do a separate activation step to start it? If we want that, then
> we may want to twiddle the proposed netlink interface a bit.

It might be sensible to have "set max-threads" which doesn't actually
start the service.
I would really REALLY like a dynamic thread pool.  It would start at 1
(or maybe 2) and grow on demand up to the max, and idle threads
(inactive for 30 seconds?) would exit.  We could then default the max to
some function of memory size and people could mostly ignore the
num-threads setting.

I don't have patches today, but if we are re-doing the interfaces I
would like us to plan the interfaces to support a pool rather than a
fixed number.

>=20
> I'm sure other questions will arise as we embark on this too.
>=20
> Thoughts? Anyone have objections to this idea?

I think this is an excellent question to ask.  As you say it is a long
time since rpc.nfsd was created, and it has grown incrementally rather
then being clearly designed.

> --=20
> Jeff Layton <jlayton@kernel.org>
>=20

Thanks,
NeilBrown

