Return-Path: <linux-nfs+bounces-2985-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BDA8B1743
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 01:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2D71F220A2
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Apr 2024 23:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8738416EC1E;
	Wed, 24 Apr 2024 23:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A/Y3/0rF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6zWxk48u";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A/Y3/0rF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6zWxk48u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB092901;
	Wed, 24 Apr 2024 23:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714001877; cv=none; b=RGar4a6mby8wZKYHTUoPMKSjzF3/n2uate0rUy3BhJDwBP2ZX0tBgOl3Yehsy68Fo1JAfWrMKmVcBo7ZgzVBpBKPQ5Hw+m7bBRW8+73yKLn21UON503EGO6Is9eZGyHmcvfyaoNFpcziJjgzZFumWBSwIvNxS/K2mwXQXlX+9jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714001877; c=relaxed/simple;
	bh=dlGWxTgg3NZ6ORKele2Vtua+TT2hu++V257pnckENVI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=AfFbo1Ri4JpjYnWAbMbRtsol6RWrvfe/A1asSiEJxnXNBfSLLwbLk3BvX2h46EludYiXL1AVN5Dz358tdEAo8lkPXbrh1teIcrGR2KTQ7pLL1T3ISwijUNcEuYW6+A9lO3BPz5pkec5HjhtmbArR1R1pfJRVxo9SKJQSjY620L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A/Y3/0rF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6zWxk48u; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A/Y3/0rF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6zWxk48u; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F389200FE;
	Wed, 24 Apr 2024 23:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714001868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JBJMhiXBluHuYzKWwAs9eb5ZP9BHoBEtmUFZU7lGuvI=;
	b=A/Y3/0rFMyU5p9LO0TfilvELBkb/cPg+gYCGk0iULy/BsEXVW+bNcUYaSJqEhcyR4z0JKG
	d3ij0fYxTXH7OW6hryypdsPa7FOVDqHh10RQut++rzEf2ahvZTuYoSCbwP/xfc7HPfi8t+
	smRVD9A8IWECBx00l6ONuvPf+Jz+EKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714001868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JBJMhiXBluHuYzKWwAs9eb5ZP9BHoBEtmUFZU7lGuvI=;
	b=6zWxk48uVQvfuC++8dufRjBi7ZYKFibKegxDwRHCB4Q0tgHxiM4nV6QlZSx3cGX4t+4sjC
	RRvVbu4feWt7aFBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="A/Y3/0rF";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6zWxk48u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714001868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JBJMhiXBluHuYzKWwAs9eb5ZP9BHoBEtmUFZU7lGuvI=;
	b=A/Y3/0rFMyU5p9LO0TfilvELBkb/cPg+gYCGk0iULy/BsEXVW+bNcUYaSJqEhcyR4z0JKG
	d3ij0fYxTXH7OW6hryypdsPa7FOVDqHh10RQut++rzEf2ahvZTuYoSCbwP/xfc7HPfi8t+
	smRVD9A8IWECBx00l6ONuvPf+Jz+EKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714001868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JBJMhiXBluHuYzKWwAs9eb5ZP9BHoBEtmUFZU7lGuvI=;
	b=6zWxk48uVQvfuC++8dufRjBi7ZYKFibKegxDwRHCB4Q0tgHxiM4nV6QlZSx3cGX4t+4sjC
	RRvVbu4feWt7aFBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C384D13690;
	Wed, 24 Apr 2024 23:37:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aiaRGciXKWawKQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 24 Apr 2024 23:37:44 +0000
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
Cc: "Chris Packham" <Chris.Packham@alliedtelesis.co.nz>,
 "Jeff Layton" <jlayton@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "netdev" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: kernel BUG at net/sunrpc/svc.c:570 after updating from v5.15.153
 to v5.15.155
In-reply-to: <5D19EAF8-0F65-4CD6-9378-67234D407B96@oracle.com>
References: <>, <5D19EAF8-0F65-4CD6-9378-67234D407B96@oracle.com>
Date: Thu, 25 Apr 2024 09:37:31 +1000
Message-id: <171400185158.7600.16163546434537681088@noble.neil.brown.name>
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2F389200FE
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]

On Thu, 25 Apr 2024, Chuck Lever III wrote:
>=20
> > On Apr 24, 2024, at 9:33=E2=80=AFAM, Chuck Lever III <chuck.lever@oracle.=
com> wrote:
> >=20
> >> On Apr 24, 2024, at 3:42=E2=80=AFAM, Chris Packham <Chris.Packham@allied=
telesis.co.nz> wrote:
> >>=20
> >> On 24/04/24 13:38, Chris Packham wrote:
> >>>=20
> >>> On 24/04/24 12:54, Chris Packham wrote:
> >>>> Hi Jeff, Chuck, Greg,
> >>>>=20
> >>>> After updating one of our builds along the 5.15.y LTS branch our=20
> >>>> testing caught a new kernel bug. Output below.
> >>>>=20
> >>>> I haven't dug into it yet but wondered if it rang any bells.
> >>>=20
> >>> A bit more info. This is happening at "reboot" for us. Our embedded=20
> >>> devices use a bit of a hacked up reboot process so that they come back =

> >>> faster in the case of a failure.
> >>>=20
> >>> It doesn't happen with a proper `systemctl reboot` or with a SYSRQ+B
> >>>=20
> >>> I can trigger it with `killall -9 nfsd` which I'm not sure is a=20
> >>> completely legit thing to do to kernel threads but it's probably close =

> >>> to what our customized reboot does.
> >>=20
> >> I've bisected between v5.15.153 and v5.15.155 and identified commit=20
> >> dec6b8bcac73 ("nfsd: Simplify code around svc_exit_thread() call in=20
> >> nfsd()") as the first bad commit. Based on the context that seems to=20
> >> line up with my reproduction. I'm wondering if perhaps something got=20
> >> missed out of the stable track? Unfortunately I'm not able to run a more=
=20
> >> recent kernel with all of the nfs related setup that is being used on =20
> >> the system in question.
> >=20
> > Thanks for bisecting, that would have been my first suggestion.
> >=20
> > The backport included all of the NFSD patches up to v6.2, but
> > there might be a missing server-side SunRPC patch.
>=20
> So dec6b8bcac73 ("nfsd: Simplify code around svc_exit_thread()
> call in  nfsd()") is from v6.6, so it was applied to v5.15.y
> only to get a subsequent NFSD fix to apply.
>=20
> The immediately previous upstream commit is missing:
>=20
>   390390240145 ("nfsd: don't allow nfsd threads to be signalled.")
>=20
> For testing, I've applied this to my nfsd-5.15.y branch here:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>=20
> However even if that fixes the reported crash, this suggests
> that after v6.6, nfsd threads are not going to respond to
> "killall -9 nfsd".

I think this likely is the problem.  The nfsd threads must be being
killed by a signal.
One only other cause for an nfsd thread to exit is if
svc_set_num_threads() is called, and all places that call that hold a
ref on the serv structure so the final put won't happen when the thread
exits.

Before the patch that bisect found, the nfsd thread would exit with

 svc_get();
 svc_exit_thread();
 nfsd_put();

This also holds a ref across the svc_exit_thread(), and ensures the
final 'put' happens from nfsD_put(), not svc_put() (in
svc_exit_thread()).

Chris: what was the context when the crash happened?  Could the nfsd
threads have been signalled?  That hasn't been the standard way to stop
nfsd threads for a long time, so I'm a little surprised that it is
happening.

NeilBrown

