Return-Path: <linux-nfs+bounces-5669-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E374895D8D7
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 00:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFC1CB2105B
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 22:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144511C86E8;
	Fri, 23 Aug 2024 22:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tGuMlhjb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8j2t1iHt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cbda3XDM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="l570JSo+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971311C86E1;
	Fri, 23 Aug 2024 22:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724450404; cv=none; b=egBwZJSQwsXkV4kGWb2rQPPaYUgKOpbZn9Rw0wGk1m/9VnmCpodLQw7bNOmHxzokvLnfVcAzLgMTBwjN5g4i6XU28rjS8HM1msaec5BvHABpfTjDKLAk+3Eu+kS/qwkqVTOYsmiGspl2hEDV3OQNQtS5texwi8pwk9eroexBIwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724450404; c=relaxed/simple;
	bh=0wfDGde7nRCgoshmPNwQrAI4PAZ2qgW7Z2q2JdpqpXg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=QBCjD06EobZL71TVY3QhtO/+ZWfc1MR9sDa47A/t8f117iU2omL6ySPgt35lsWpow7ze0rf7rbb4HW3goeyVxcyRr7vwJgAQTbiml+MNJP7SJj230Q6Q5xk5RWUEwssQXF4IIRy9Fj5ASADjBlurXvd7mifOXvyqtNY09qnGlIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tGuMlhjb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8j2t1iHt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cbda3XDM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=l570JSo+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 49D2522726;
	Fri, 23 Aug 2024 21:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724450399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yDHL5THQ9oZe4s+ltFvldSBSfUnI9O72ytyxKXsymW4=;
	b=tGuMlhjb7CnvfVU0MvsvnWIwv0y3/Gua5JbROZ2qaxSFMgv3ZNWLBkEImrXJi+kqxhURFl
	9kj+JAGzlf5KMKdHevYCnwN03nEarj9V1qIeMLZ9Y3AmPHLt87USCuyegSjydlUKIxugUr
	6lXhrXHt1VH8K+zlje+zgrNhFlSqxbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724450399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yDHL5THQ9oZe4s+ltFvldSBSfUnI9O72ytyxKXsymW4=;
	b=8j2t1iHtPs/5Vx9OVPWPWpsDeF7zCynLOCcZnD4C3Q7ihfOSVE4UuvjQQ3tqXvqaQgptOm
	eHKBKeZ3jlW/clBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724450398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yDHL5THQ9oZe4s+ltFvldSBSfUnI9O72ytyxKXsymW4=;
	b=cbda3XDMoD6/ANsRrOxfa8OHAgrh/pmv1CSt1HS9jDWLa3HPTR4rAyLtGXqHIRyAAlhf7C
	PuEanvVExwApuS1srLgnPupgeycfWvd0S6tPBPxjpZhdkVZ0yJSrRiNZzt2mRJawhJ51Rm
	NEMiLOyKV4rRTtQqFHB3iY0w6MDndRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724450398;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yDHL5THQ9oZe4s+ltFvldSBSfUnI9O72ytyxKXsymW4=;
	b=l570JSo+B+WTjGTj2QB2iy+SI5noUjZuMLNG0NqcdTQw4jEbgL2Egp3Oq25e1DkYJnfxj6
	ZWche639d3XPlVDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CF831398B;
	Fri, 23 Aug 2024 21:59:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7tIHBVsGyWbhcwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 23 Aug 2024 21:59:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Petr Vorel" <pvorel@suse.cz>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, ltp@lists.linux.it,
 "Li Wang" <liwang@redhat.com>, "Cyril Hrubis" <chrubis@suse.cz>,
 "Avinesh Kumar" <akumar@suse.de>, "Josef Bacik" <josef@toxicpanda.com>,
 stable@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/1] nfsstat01: Update client RPC calls for kernel 6.9
In-reply-to: <20240823064640.GA1217451@pevik>
References: <>, <20240823064640.GA1217451@pevik>
Date: Sat, 24 Aug 2024 07:59:44 +1000
Message-id: <172445038410.6062.6091007925280806767@noble.neil.brown.name>
X-Spam-Score: -8.30
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,noble.neil.brown.name:mid,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 23 Aug 2024, Petr Vorel wrote:
> Hi Chuck, Neil, all,
>=20
> > On Wed, Aug 14, 2024 at 10:57:21AM +0200, Petr Vorel wrote:
> > > 6.9 moved client RPC calls to namespace in "Make nfs stats visible in
> > > network NS" patchet.
>=20
> > > https://lore.kernel.org/linux-nfs/cover.1708026931.git.josef@toxicpanda=
.com/
>=20
> > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > ---
> > > Changes v1->v2:
> > > * Point out whole patchset, not just single commit
> > > * Add a comment about the patchset
>=20
> > > Hi all,
>=20
> > > could you please ack this so that we have fixed mainline?
>=20
> > > FYI Some parts has been backported, e.g.:
> > > d47151b79e322 ("nfs: expose /proc/net/sunrpc/nfs in net namespaces")
> > > to all stable/LTS: 5.4.276, 5.10.217, 5.15.159, 6.1.91, 6.6.31.
>=20
> > > But most of that is not yet (but planned to be backported), e.g.
> > > 93483ac5fec62 ("nfsd: expose /proc/net/sunrpc/nfsd in net namespaces")
> > > see Chuck's patchset for 6.6
> > > https://lore.kernel.org/linux-nfs/20240812223604.32592-1-cel@kernel.org/
>=20
> > > Once all kernels up to 5.4 fixed we should update the version.
>=20
> > > Kind regards,
> > > Petr
>=20
> > >  testcases/network/nfs/nfsstat01/nfsstat01.sh | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> > > diff --git a/testcases/network/nfs/nfsstat01/nfsstat01.sh b/testcases/n=
etwork/nfs/nfsstat01/nfsstat01.sh
> > > index c2856eff1f..1beecbec43 100755
> > > --- a/testcases/network/nfs/nfsstat01/nfsstat01.sh
> > > +++ b/testcases/network/nfs/nfsstat01/nfsstat01.sh
> > > @@ -15,7 +15,14 @@ get_calls()
> > >  	local calls opt
>=20
> > >  	[ "$name" =3D "rpc" ] && opt=3D"r" || opt=3D"n"
> > > -	! tst_net_use_netns && [ "$nfs_f" !=3D "nfs" ] && type=3D"rhost"
> > > +
> > > +	if tst_net_use_netns; then
> > > +		# "Make nfs stats visible in network NS" patchet
> > > +		# https://lore.kernel.org/linux-nfs/cover.1708026931.git.josef@toxic=
panda.com/
> > > +		tst_kvcmp -ge "6.9" && [ "$nfs_f" =3D "nfs" ] && type=3D"rhost"
>=20
> > Hello Petr-
>=20
> > My concern with this fix is it targets v6.9 specifically, yet we
> > know these fixes will appear in LTS/stable kernels as well.
>=20
> Great! I see you already fixed up to 5.15. I suppose the code is really
> backportable to the other still active branches (5.10, 5.4, 4.19).
>=20
> We discussed in v1 how to fix tests.  Neil suggested to fix the test the wa=
y so
> that it works on all kernels. As I note [1]
>=20
> 1) either we give up on checking the new functionality still works (if we
> fallback to old behavior)

I don't understand.  What exactly do you mean by "the new
functionality".
As I understand it there is no new functionality.  All there was was and
information leak between network namespaces, and we stopped the leak.
Do you consider that to be new functionality?

> 2) or we need to specify from which kernel we expect new functionality
> (so far it's 5.15, I suppose it will be older).
>=20
> I would prefer 2) to have new functionality always tested.
> Or am I missing something obvious?

As I understand it the primary purpose of the test is to confirm that
when an NFS request is made, the client sees an increase the the count
of RPC requests in the client statistics.  and the server sees an
increase in the count of RPC requests in the server statistics.
That test, if performed correctly, should always work.

Is there something else you want to test?
If you want to test that the server DOESN'T see and increase in the
CLIENT statistics, then that is a valid thing to test and it won't work
on early kernels.  I think we only need to test that for kernels since
the fix landed in mainline.

I'm sure one of us is missing something obvious because I am CONFIDENT
that a test for correct functionality can be written to work on all
kernels.  We didn't add any new functionality and didn't break any old
functionality.  We just fixed a bug.

NeilBrown


>=20
> Kind regards,
> Petr
>=20
> [1] https://lore.kernel.org/linux-nfs/172367387549.6062.7078032983644586462=
@noble.neil.brown.name/
>=20
> > Neil Brown suggested an alternative approach that might not depend
> > on knowing the specific kernel version:
>=20
> > https://lore.kernel.org/linux-nfs/172078283934.15471.13377048166707693692=
@noble.neil.brown.name/
>=20
> > HTH
>=20
>=20
> > > +	else
> > > +		[ "$nfs_f" !=3D "nfs" ] && type=3D"rhost"
> > > +	fi
>=20
> > >  	if [ "$type" =3D "lhost" ]; then
> > >  		calls=3D"$(grep $name /proc/net/rpc/$nfs_f | cut -d' ' -f$field)"
> > > --=20
> > > 2.45.2
>=20


