Return-Path: <linux-nfs+bounces-1797-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA0C84A71D
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 22:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 277A32873A0
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 21:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2B2634E4;
	Mon,  5 Feb 2024 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v4zkkRpH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Br1h8632";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v4zkkRpH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Br1h8632"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D44634E1
	for <linux-nfs@vger.kernel.org>; Mon,  5 Feb 2024 19:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162288; cv=none; b=UAPcWvRn9WpISGwUvwSXn4HD4FhUS1+QD3dkCYaqGzbi48fKpszXjr5QTdbaHJCZsg9Jjrq+m01KN37mqGY/SwkSHop5lB+iaE2niBF8Y2pYJ9HVTZXzrlRowjnfU+ZY8ZoPWWoLa2JzDtgWNSCO0tOqEX9Vyvbcq/YsI/3bpzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162288; c=relaxed/simple;
	bh=YhAlYY+/n5yxao5yfANITcVXoPtgA7LEbvMCI2RlYZ8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=O5Osbsw+cp9LGH1kdzV3xwpS5vmdaXhe7xX8HpTxw+c32OAr6Q3MIu2e7/nMLMTmCZR9n6l8cYB0rmKS7nFibSbdzvFfIIIYV1nBs8YGvd/ziR0RtRJw7SZ4LCQL9jWjffaDBlgQvmQ/vni2+pGPpyiCSuonZEQBYsm2maeOl7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v4zkkRpH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Br1h8632; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v4zkkRpH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Br1h8632; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3EBD71FB3E;
	Mon,  5 Feb 2024 19:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707162284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3OHX/aagxChTiVnx1kTF2kchDf59rpD6h1fAYXODfSg=;
	b=v4zkkRpHkF7efa2rF1EQa7na2uyskg5wUX2Tfzeb622JiHoWpQ1Yj3mlfMNguDaQZQigpS
	ZaFc1n3kxTefDpE5Yq9fe3gFeOO6o5Baoq2ZwpsTcJLj9bCKTIACN7SfvAfLn83mcZoddG
	f7wTmyS5GDGm769aMth/8cPoJDm2ipk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707162284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3OHX/aagxChTiVnx1kTF2kchDf59rpD6h1fAYXODfSg=;
	b=Br1h86325J0X41jKCUnU2cvvBQAcSjU9Fnd01gSmmlClKKfq3P5230ffImeRdu1YAF51ow
	KrcZNaaYwQPK0xAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707162284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3OHX/aagxChTiVnx1kTF2kchDf59rpD6h1fAYXODfSg=;
	b=v4zkkRpHkF7efa2rF1EQa7na2uyskg5wUX2Tfzeb622JiHoWpQ1Yj3mlfMNguDaQZQigpS
	ZaFc1n3kxTefDpE5Yq9fe3gFeOO6o5Baoq2ZwpsTcJLj9bCKTIACN7SfvAfLn83mcZoddG
	f7wTmyS5GDGm769aMth/8cPoJDm2ipk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707162284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3OHX/aagxChTiVnx1kTF2kchDf59rpD6h1fAYXODfSg=;
	b=Br1h86325J0X41jKCUnU2cvvBQAcSjU9Fnd01gSmmlClKKfq3P5230ffImeRdu1YAF51ow
	KrcZNaaYwQPK0xAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3181136F5;
	Mon,  5 Feb 2024 19:44:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2VNWJqk6wWWLPwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 05 Feb 2024 19:44:41 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Lorenzo Bianconi" <lorenzo.bianconi@redhat.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Dai Ngo" <dai.ngo@oracle.com>,
 "olga.kornievskaia" <olga.kornievskaia@gmail.com>,
 "Tom Talpey" <tom@talpey.com>, "linux-nfs" <linux-nfs@vger.kernel.org>
Subject: Re: Should we establish a new nfsdctl userland program?
In-reply-to: <ZcEQzyrZpyrMJGKg@lore-desk>
References: <8a7bbc05b6515109692cb88ad68374d14fc01eca.camel@kernel.org>,
 <Zb0hlnQmgVikeNpi@lore-rh-laptop>,
 <e706a77b4ddbceeb8b0ebac4dcbca03f8196e8a5.camel@kernel.org>,
 <ZcEQzyrZpyrMJGKg@lore-desk>
Date: Tue, 06 Feb 2024 06:44:39 +1100
Message-id: <170716227903.13976.3838162060222642711@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=v4zkkRpH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Br1h8632
X-Spamd-Result: default: False [-1.81 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_ALL(0.00)[];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 SUBJECT_ENDS_QUESTION(1.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[kernel.org,oracle.com,gmail.com,talpey.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3EBD71FB3E
X-Spam-Level: 
X-Spam-Score: -1.81
X-Spam-Flag: NO

On Tue, 06 Feb 2024, Lorenzo Bianconi wrote:
> > On Fri, 2024-02-02 at 18:08 +0100, Lorenzo Bianconi wrote:
> > > > The existing rpc.nfsd program was designed during a different time, w=
hen
> > > > we just didn't require that much control over how it behaved. It's
> > > > klunky to work with.
> > > >=20
> > > > In a response to Chuck's recent RFC patch to add knob to disable
> > > > READ_PLUS calls, I mentioned that it might be a good time to make a
> > > > clean break from the past and start a new program for controlling nfs=
d.
> > > >=20
> > > > Here's what I'm thinking:
> > > >=20
> > > > Let's build a swiss-army-knife kind of interface like git or virsh:
> > > >=20
> > > > # nfsdctl=C2=A0stats			<--- fetch the new stats that got merged
> > > > # nfsdctl add_listener		<--- add a new listen socket, by address or h=
ostname
> > > > # nfsdctl set v3 on		<--- enable NFSv3
> > > > # nfsdctl set splice_read off	<--- disable splice reads (per Chuck's =
recent patch)
> > > > # nfsdctl set threads 128	<--- spin up the threads
> > > >=20
> > > > We could start with just the bare minimum for now (the stats interfac=
e),
> > > > and then expand on it. Once we're at feature parity with rpc.nfsd, we=
'd
> > > > want to have systemd preferentially use nfsdctl instead of rpc.nfsd to
> > > > start and stop the server. systemd will also need to fall back to usi=
ng
> > > > rpc.nfsd if nfsdctl or the netlink program isn't present.
> > > >=20
> > > > Note that I think this program will have to be a compiled binary vs. a
> > > > python script or the like, given that it'll be involved in system
> > > > startup.
> > > >=20
> > > > It turns out that Lorenzo already has a C program that has a lot of t=
he
> > > > plumbing we'd need:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0https://github.com/LorenzoBianconi/nfsd-netli=
nk
> > >=20
> > > This is something I developed just for testing the new interface but I =
agree we
> > > could start from it.
> > >=20
> > > Regarding the kernel part I addressed the comments I received upstream =
on v6 and
> > > pushed the code here [0].
> > > How do you guys prefer to proceed? Is the better to post v7 upstream an=
d continue
> > > the discussion in order to have something usable to develop the user-sp=
ace part or
> > > do you prefer to have something for the user-space first?
> > > I do not have a strong opinion on it.
> > >=20
> > > Regards,
> > > Lorenzo
> > >=20
> > > [0] https://github.com/LorenzoBianconi/nfsd-next/tree/nfsd-next-netlink=
-new-cmds-public-v7
> > >=20
> > >=20
> >=20
> > My advice?
> >=20
> > Step back and spend some time working on the userland bits before
> > posting another revision. Experience has shown that you never realize
> > what sort of warts an interface like this has until you have to work
> > with it.
> >=20
> > You may find that you want to tweak it some once you do, and it's much
> > easier to do that before we merge anything. This will be part of the
> > kernel ABI, so once it's in a shipping kernel, we're sort of stuck with
> > it.
> >=20
> > Having a userland program ready to go will allow us to do things like
> > set up the systemd service for this too, which is primarily how this new
> > program will be called.
>=20
> I agree on it. In order to proceed I guess we should define a list of
> requirements/expected behaviour on this new user-space tool used to
> configure nfsd. I am not so familiar with the user-space requirements
> for nfsd so I am just copying what you suggested, something like:
>=20
> $ nfsdctl=C2=A0stats                                                 <--- f=
etch the new stats that got merged
> $ nfsdctl xprt add proto <udp|tcp> host <host> [port <port>]    <--- add a =
new listen socket, by address or hostname
> $ nfsdctl proto v3.0 v4.0 v4.1                                  <--- enable=
 NFSv3 and v4.1
> $ nfsdctl set threads 128                                       <--- spin u=
p the threads

My preference would be:

   nfsdctl start
and=20
   nfsdctl stop

where nfsdctl reads a config file to discover what setting are required.
I cannot see any credible use case for 'xprt' or 'proto' or 'threads'
commands.

Possibly nfsctl would accept config on the command line:
  nfsdctl start proto=3D3,4.1 threads=3D42 proto=3Dtcp:localhost:2049
or similar.

It would also be helpful to have "nfsdinfo" or similar which has "stats"
and "status" commands.  Maybe that could be combined with "nfsdctl", but
extracting info is not a form of "control".  Or we could find a more
generic verb.  For soft-raid I wrote "mdadm" "adm" for "administer"
which seemed less specific than "control" (mdctl).  Though probably the
main reason was that I like palindromes and "mdadm" was a bit easier to
say.  nfsdadm ??  (see also udevadm, drdbadm, fsadm ....) But maybe I'm
just too fuss.

In my experience working with our customers and support team, they are
not at all interested in fine control.  "systemctl restart nfs-server" is
their second preference when "reboot" isn't appropriate for some reason.

You might be able to convince me that "nfdctl reload" was useful - it
could be called from "systemctl reload nfs-server".  That would then
justify kernel interfaces to remove xprts.  But having all the
fine-control just increases the required testing needed with little
practical gain.

NeilBrown

