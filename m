Return-Path: <linux-nfs+bounces-5393-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAED95256B
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Aug 2024 00:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A591F25288
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 22:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F313143C5D;
	Wed, 14 Aug 2024 22:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jfu11j4e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V8n2L59U";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jfu11j4e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V8n2L59U"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E43222309;
	Wed, 14 Aug 2024 22:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723673892; cv=none; b=Pwah4sCQIhlJD3DmkODhI7ih8Z2i9PoTwdlHBJEOt/Y9IyuOejDjy7H+/gpyPrkIsm+MRwUu8b71Z2wwW+Tt0+IlfCkAVlwBH65jjArTkgWVXMaowgjc0jHQxPHDx27A0K9DjEXB91TMy59Gm02V4COkl2czaXL5868n/A6A59E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723673892; c=relaxed/simple;
	bh=FdTDOnsYydbaEH2nWmDTe1iGaqcdhYgdS+mvs4V5YXU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=JXMZGeWI1ROEMPsP4L81ttb68AbMWUH0LvA0C0w9K5iQnwXBHZwgyHHtg6XFxHN/I5jX5Vamx47vTzoFZLFq+J98LQJddyvz8hXIHmqbbm7YXcm1irlr2Kv+c/qEWQFZeNfvVcUQJ5k9Upfet+m/GhHiDcJ3C+PExWBANheM8M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jfu11j4e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=V8n2L59U; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jfu11j4e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=V8n2L59U; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2B73D1FF4D;
	Wed, 14 Aug 2024 22:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723673888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mgsbs6MgvDu9P60eUbpMp+vvP/KOYcWYiudaJDvVepg=;
	b=jfu11j4e1KmRXifh/nvBGvoKoHQxb2F3Jj8DADbVbVpTwlCZYtQbB5CCJMYicysCg2NUO9
	zwD20VS04ihRodGusbQPkiFtI2XF1891faRDXb0WveM1tfw44+v8sVthA1S/TvjiDV2DLf
	/3SdSzBn0OUgpiMlqg7amztYVkZhk6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723673888;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mgsbs6MgvDu9P60eUbpMp+vvP/KOYcWYiudaJDvVepg=;
	b=V8n2L59UVSay1GoTKNLc0qY8j+D88Z+8MKBlsmJQHPJxIaTtiJuakPMb3e4qbE+tjFsVMP
	KZOqWiwCP7RlfwDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723673888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mgsbs6MgvDu9P60eUbpMp+vvP/KOYcWYiudaJDvVepg=;
	b=jfu11j4e1KmRXifh/nvBGvoKoHQxb2F3Jj8DADbVbVpTwlCZYtQbB5CCJMYicysCg2NUO9
	zwD20VS04ihRodGusbQPkiFtI2XF1891faRDXb0WveM1tfw44+v8sVthA1S/TvjiDV2DLf
	/3SdSzBn0OUgpiMlqg7amztYVkZhk6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723673888;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mgsbs6MgvDu9P60eUbpMp+vvP/KOYcWYiudaJDvVepg=;
	b=V8n2L59UVSay1GoTKNLc0qY8j+D88Z+8MKBlsmJQHPJxIaTtiJuakPMb3e4qbE+tjFsVMP
	KZOqWiwCP7RlfwDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9B0D139B9;
	Wed, 14 Aug 2024 22:18:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SlqGFxstvWaAXQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 14 Aug 2024 22:18:03 +0000
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
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever III" <chuck.lever@oracle.com>, "Greg KH" <greg@kroah.com>,
 "Sherry Yang" <sherry.yang@oracle.com>,
 "Calum Mackay" <calum.mackay@oracle.com>,
 "linux-stable" <stable@vger.kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "Anna Schumaker" <anna@kernel.org>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "kernel-team@fb.com" <kernel-team@fb.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>, "Avinesh Kumar" <akumar@suse.de>,
 "Josef Bacik" <josef@toxicpanda.com>
Subject:
 Re: [LTP] [PATCH 1/1] nfsstat01: Update client RPC calls for kernel 6.9
In-reply-to: <20240814205519.GA550121@pevik>
References: <>, <20240814205519.GA550121@pevik>
Date: Thu, 15 Aug 2024 08:17:55 +1000
Message-id: <172367387549.6062.7078032983644586462@noble.neil.brown.name>
X-Spam-Flag: NO
X-Spam-Score: -8.30
X-Spam-Level: 
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)]

On Thu, 15 Aug 2024, Petr Vorel wrote:
> > On Fri, 12 Jul 2024, Jeff Layton wrote:
> > > On Fri, 2024-07-12 at 16:12 +1000, NeilBrown wrote:
>=20
> > > > My point is that if we are going to change the kernel to accommodate =
LTP
> > > > at all, we should accommodate LTP as it is today.  If we are going to
> > > > change LTP to accommodate the kernel, then it should accommodate the
> > > > kernel as it is today.
>=20
>=20
> > > The problem is that there is no way for userland tell the difference
> > > between the older and newer behavior. That was what I was suggesting we
> > > add.
>=20
> > To make sure I wasn't talking through my hat, I had a look at the ltp
> > code.
>=20
> > The test in question simply tests that the count of RPC calls increases.
>=20
> > It can get the count of RPC calls in one of 2 ways :
> >  1/ "lhost" - look directly in /proc/net/rpc/{nfs,nfsd}
> >  2/ "rhost" - ssh to the server and look in that file.
>=20
> FYI "rhost" in LTP can be either using namespaces (Single Host Configuratio=
n [1]),
> which is run by default, or SSH based (Two Host Configuration [2]). IMHO mo=
st of
> the testers (including myself run tests simply via network namespaces).
>=20
> NOTE: I suppose CONFIG_NAMESPACES=3Dy is a must for 'ip netns' to be workin=
g, thus
> tests would hopefully failed early on kernel having that disabled.
>=20
> > The current test to "fix" this for kernels -ge "6.9" is to force the use
> > of "rhost".
>=20
> > I'm guessing that always using "rhost" for the nfsd stats would always
> > work.
>=20
> FYI this old commit [3] allowed these tests to be working in network namesp=
aces.
> It reads for network namespaces both /proc/net/rpc/{nfs,nfsd} from non-name=
space
> ("lhost").  This is the subject of the change in 6.9, which now fails.
> And for SSH based we obviously look on "rhost" already.

That patch looks like a mistake.  The author noticed that the rpc stats
were not "namespacified" and instead of reporting the bug (and surely
the whole point of a test suite is to report bugs), they made a change
that seems completely unnecessary which had the effect of entrenching
the bug.  Unfortunately the commit message only says why it is same to
make the change, not why it us useful.

>=20
> > But if not, the code could get both the local and remote nfsd stats, and
> > check that at least one of them increases (and neither decrease).
>=20
> This sounds reasonable, thanks for a hint. I'll just look for client RPC ca=
lls
> (/proc/net/rpc/nfs) in both non-namespace and namespace. The only think is =
that
> we effectively give up checking where it should be (if it for whatever reas=
on in
> the future changes again, we miss that). I'm not sure if this would be trea=
ted
> the same as the current situation (Josef Bacik had obvious reasons for this=
 to
> be working).

Stats should always be visible in the relevant namespace.  server stats
should be visible in the name space where the server runs.  client stats
should be visible in the namespace where the filesystem is mounted.
This has always been true (as long as we have had stats) and if it ever
stops being true, that is a bug.
I think the test suite should test for precisely this case.  Testing if
the stats are visible from a different namespace is not likely to be an
interesting test - unless you want to guard against the possibility that
we will one day accidentally de-namespaceify the stats (stranger things
have happened).

Thanks,
NeilBrown

>=20
> @Josef @NFS maintainers: WDYT?
>=20
> Kind regards,
> Petr
>=20
> > So ltp doesn't need to know which kernel is being used - it can be
> > written to work safely on either.
>=20
> > NeilBrown
>=20
> [1] https://github.com/linux-test-project/ltp/tree/master/testcases/network=
#single-host-configuration
> [2] https://github.com/linux-test-project/ltp/tree/master/testcases/network=
#two-host-configuration
> [3] https://github.com/linux-test-project/ltp/commit/40958772f11d90e4b5052e=
7e772a3837d285cf89
>=20
> > > To be clear, I hold this opinion loosely. If the consensus is that we
> > > need to revert things then so be it. I just don't see the value of
> > > doing that in this particular situation.
> > > --=20
> > > Jeff Layton <jlayton@kernel.org>
>=20
>=20
>=20


