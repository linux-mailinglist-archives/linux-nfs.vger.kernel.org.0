Return-Path: <linux-nfs+bounces-1804-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABD584A87A
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 23:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE571C291F4
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 22:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F5F149006;
	Mon,  5 Feb 2024 21:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SGKUNzYm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pfB8GLSg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SGKUNzYm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pfB8GLSg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AE713B2AE
	for <linux-nfs@vger.kernel.org>; Mon,  5 Feb 2024 21:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707167385; cv=none; b=fB12Rrd47XiDnfNNnAVU1TT1/0CQrGzHjuYKREWuT1Q4IBsfgLjWdju4HVp4JhsORjvs+31ac+HOtUnu1JUMCGqnlPGaFMouLkkNFKkXw8VHf2xfk5fB0sd7m3/2ectKJuQzJ31lEU6FLWfUcQ+UxJwxu8geMskCW57BCAe8Lc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707167385; c=relaxed/simple;
	bh=/0hUH8bjs555e01Q1wBwrkmc5ygHqRRKjmRu6I3WuN8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=TDYt+Z/frRr6LzM+qge8u/qHa8MvX/pw20g9YzMZS6jEuZ+kXBl4BZZo0PhKhOn+bd+vBVvfKmiuRHd4+uldsqIsu8H0oGurt0PaxsH6LjF5zdVrgykgFCVmS0znQFALehkR7L1EPVNRAsJ8IaOmzu31ZnaCqv4U1qQwlSW9lVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SGKUNzYm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pfB8GLSg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SGKUNzYm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pfB8GLSg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0C39B21F00;
	Mon,  5 Feb 2024 21:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707167381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9WUCoGhEwHVtxs69bPFgN6Z9EaOvoISNgmOgtFG7EtU=;
	b=SGKUNzYmaUF52wxRjEHqe/GaVdBecvy8z/dxyP41/fPqgQPNrLIG7LGLc1f1XJb4Ava45N
	EbGbR43VWMLrRJE991BoRK6kM4xKwxuFUp/QXGTXccmnv6XpfiH9187JGQYGTz7dOv/9tH
	uIbeUJx9D3y5dnNVP9589ChO5lOFz8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707167381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9WUCoGhEwHVtxs69bPFgN6Z9EaOvoISNgmOgtFG7EtU=;
	b=pfB8GLSgo2AWJbKzSYi0GdRiRLvSPw7vNcLvbXyzylhQyPjopyFEqhuerTSsbthBGzR0PV
	f5Rs0g56Ed/iNuBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707167381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9WUCoGhEwHVtxs69bPFgN6Z9EaOvoISNgmOgtFG7EtU=;
	b=SGKUNzYmaUF52wxRjEHqe/GaVdBecvy8z/dxyP41/fPqgQPNrLIG7LGLc1f1XJb4Ava45N
	EbGbR43VWMLrRJE991BoRK6kM4xKwxuFUp/QXGTXccmnv6XpfiH9187JGQYGTz7dOv/9tH
	uIbeUJx9D3y5dnNVP9589ChO5lOFz8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707167381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9WUCoGhEwHVtxs69bPFgN6Z9EaOvoISNgmOgtFG7EtU=;
	b=pfB8GLSgo2AWJbKzSYi0GdRiRLvSPw7vNcLvbXyzylhQyPjopyFEqhuerTSsbthBGzR0PV
	f5Rs0g56Ed/iNuBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1494132DD;
	Mon,  5 Feb 2024 21:09:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1pY3GpJOwWUJUgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 05 Feb 2024 21:09:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever III" <chuck.lever@oracle.com>
Cc: "Lorenzo Bianconi" <lorenzo.bianconi@redhat.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Olga Kornievskaia" <olga.kornievskaia@gmail.com>,
 "Tom Talpey" <tom@talpey.com>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: Should we establish a new nfsdctl userland program?
In-reply-to: <DD7F51B6-B0BC-4412-BA19-164272120158@oracle.com>
References: <8a7bbc05b6515109692cb88ad68374d14fc01eca.camel@kernel.org>,
 <Zb0hlnQmgVikeNpi@lore-rh-laptop>,
 <e706a77b4ddbceeb8b0ebac4dcbca03f8196e8a5.camel@kernel.org>,
 <ZcEQzyrZpyrMJGKg@lore-desk>,
 <170716227903.13976.3838162060222642711@noble.neil.brown.name>,
 <DD7F51B6-B0BC-4412-BA19-164272120158@oracle.com>
Date: Tue, 06 Feb 2024 08:09:35 +1100
Message-id: <170716737553.13976.6482754936905658038@noble.neil.brown.name>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SGKUNzYm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pfB8GLSg
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_ALL(0.00)[];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 SUBJECT_ENDS_QUESTION(1.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[redhat.com,kernel.org,oracle.com,gmail.com,talpey.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 0C39B21F00
X-Spam-Flag: NO

On Tue, 06 Feb 2024, Chuck Lever III wrote:
>=20
>=20
> > On Feb 5, 2024, at 2:44=E2=80=AFPM, NeilBrown <neilb@suse.de> wrote:
> >=20
> > On Tue, 06 Feb 2024, Lorenzo Bianconi wrote:
> >>> On Fri, 2024-02-02 at 18:08 +0100, Lorenzo Bianconi wrote:
> >>>>> The existing rpc.nfsd program was designed during a different time, w=
hen
> >>>>> we just didn't require that much control over how it behaved. It's
> >>>>> klunky to work with.
> >>>>>=20
> >>>>> In a response to Chuck's recent RFC patch to add knob to disable
> >>>>> READ_PLUS calls, I mentioned that it might be a good time to make a
> >>>>> clean break from the past and start a new program for controlling nfs=
d.
> >>>>>=20
> >>>>> Here's what I'm thinking:
> >>>>>=20
> >>>>> Let's build a swiss-army-knife kind of interface like git or virsh:
> >>>>>=20
> >>>>> # nfsdctl stats <--- fetch the new stats that got merged
> >>>>> # nfsdctl add_listener <--- add a new listen socket, by address or ho=
stname
> >>>>> # nfsdctl set v3 on <--- enable NFSv3
> >>>>> # nfsdctl set splice_read off <--- disable splice reads (per Chuck's =
recent patch)
> >>>>> # nfsdctl set threads 128 <--- spin up the threads
> >>>>>=20
> >>>>> We could start with just the bare minimum for now (the stats interfac=
e),
> >>>>> and then expand on it. Once we're at feature parity with rpc.nfsd, we=
'd
> >>>>> want to have systemd preferentially use nfsdctl instead of rpc.nfsd to
> >>>>> start and stop the server. systemd will also need to fall back to usi=
ng
> >>>>> rpc.nfsd if nfsdctl or the netlink program isn't present.
> >>>>>=20
> >>>>> Note that I think this program will have to be a compiled binary vs. a
> >>>>> python script or the like, given that it'll be involved in system
> >>>>> startup.
> >>>>>=20
> >>>>> It turns out that Lorenzo already has a C program that has a lot of t=
he
> >>>>> plumbing we'd need:
> >>>>>=20
> >>>>>     https://github.com/LorenzoBianconi/nfsd-netlink
> >>>>=20
> >>>> This is something I developed just for testing the new interface but I=
 agree we
> >>>> could start from it.
> >>>>=20
> >>>> Regarding the kernel part I addressed the comments I received upstream=
 on v6 and
> >>>> pushed the code here [0].
> >>>> How do you guys prefer to proceed? Is the better to post v7 upstream a=
nd continue
> >>>> the discussion in order to have something usable to develop the user-s=
pace part or
> >>>> do you prefer to have something for the user-space first?
> >>>> I do not have a strong opinion on it.
> >>>>=20
> >>>> Regards,
> >>>> Lorenzo
> >>>>=20
> >>>> [0] https://github.com/LorenzoBianconi/nfsd-next/tree/nfsd-next-netlin=
k-new-cmds-public-v7
> >>>>=20
> >>>>=20
> >>>=20
> >>> My advice?
> >>>=20
> >>> Step back and spend some time working on the userland bits before
> >>> posting another revision. Experience has shown that you never realize
> >>> what sort of warts an interface like this has until you have to work
> >>> with it.
> >>>=20
> >>> You may find that you want to tweak it some once you do, and it's much
> >>> easier to do that before we merge anything. This will be part of the
> >>> kernel ABI, so once it's in a shipping kernel, we're sort of stuck with
> >>> it.
> >>>=20
> >>> Having a userland program ready to go will allow us to do things like
> >>> set up the systemd service for this too, which is primarily how this new
> >>> program will be called.
> >>=20
> >> I agree on it. In order to proceed I guess we should define a list of
> >> requirements/expected behaviour on this new user-space tool used to
> >> configure nfsd. I am not so familiar with the user-space requirements
> >> for nfsd so I am just copying what you suggested, something like:
> >>=20
> >> $ nfsdctl stats                                                 <--- fet=
ch the new stats that got merged
> >> $ nfsdctl xprt add proto <udp|tcp> host <host> [port <port>]    <--- add=
 a new listen socket, by address or hostname
> >> $ nfsdctl proto v3.0 v4.0 v4.1                                  <--- ena=
ble NFSv3 and v4.1
> >> $ nfsdctl set threads 128                                       <--- spi=
n up the threads
> >=20
> > My preference would be:
> >=20
> >   nfsdctl start
> > and=20
> >   nfsdctl stop
> >=20
> > where nfsdctl reads a config file to discover what setting are required.
> > I cannot see any credible use case for 'xprt' or 'proto' or 'threads'
> > commands.
> >=20
> > Possibly nfsctl would accept config on the command line:
> >  nfsdctl start proto=3D3,4.1 threads=3D42 proto=3Dtcp:localhost:2049
> > or similar.
>=20
> You've got proto=3D listed twice here.

Yep - the second was meant to be xprt=3D

>=20
> I'm more in favor of having more subcommands, each of which do
> something simple. Easier to understand, easier to test.

Fewer subcommands are easier to test than more.
OK - forget the "config on command line" idea.  Just read config from
/etc/nfs.conf and action that.

>=20
>=20
> > It would also be helpful to have "nfsdinfo" or similar which has "stats"
> > and "status" commands.  Maybe that could be combined with "nfsdctl", but
> > extracting info is not a form of "control".  Or we could find a more
> > generic verb.  For soft-raid I wrote "mdadm" "adm" for "administer"
> > which seemed less specific than "control" (mdctl).  Though probably the
> > main reason was that I like palindromes and "mdadm" was a bit easier to
> > say.  nfsdadm ??  (see also udevadm, drdbadm, fsadm ....) But maybe I'm
> > just too fuss.
> >=20
> > In my experience working with our customers and support team, they are
> > not at all interested in fine control.
>=20
> This is an interface to be used by systemctl. I don't think customers
> or support teams would ever need to make use of it directly.

If it's to be used by systemctl, then there is zero justification for
anything other than start/reload/stop.  We already have
/etc/nfs.conf.d/* for configuring nfsd.  Requiring tools to edit
systemctl unit files as well is a retrograde step.

NeilBrown


>=20
>=20
> > "systemctl restart nfs-server" is
> > their second preference when "reboot" isn't appropriate for some reason.
> >=20
> > You might be able to convince me that "nfdctl reload" was useful - it
> > could be called from "systemctl reload nfs-server".  That would then
> > justify kernel interfaces to remove xprts.  But having all the
> > fine-control just increases the required testing needed with little
> > practical gain.
> >=20
> > NeilBrown
>=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20


