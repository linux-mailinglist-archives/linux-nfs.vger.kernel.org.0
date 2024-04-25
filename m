Return-Path: <linux-nfs+bounces-3015-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6AB8B2D80
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Apr 2024 01:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBCA5B22076
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 23:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385F1156655;
	Thu, 25 Apr 2024 23:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zJuxruLY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bNdYA6J/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ckJTeLLE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="truHWJsK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F9684D0D;
	Thu, 25 Apr 2024 23:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714087137; cv=none; b=tMqAPFF6XR5E8yYKahh345NmoVeCBUBHeu6BfhekxPtjutwwLP+dPgti1SPjL6AiLmCvpYqv94eYPzw2mSo9e/Dftq9FFVSEF32iQHszqZMVqmlI5E0fDQ81h2wrvv52F84VCLdoRiHEae4JbZZIDnVeOaa1sq05z7yVAjvDq4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714087137; c=relaxed/simple;
	bh=f7B8+aI+858znS4N0tv3mXyDzuhtmEEsi7y/rHt+Ngg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=tcbDVVg7eJ1vIsBZlSwFNYxNfo2oSdf/8QkL+ovBUvF8hpTUlcpxHh7SuezgadklW6Kb6ttOSao2v2YV5RfeHD70CXGfl1eQ76PBYzzH6uH8h3MBTl4InB/RvfhNPKfsVSHPIOk+HrSqOkkNqZFRqr2ZtZJrLxnuMibxtcD3jwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zJuxruLY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bNdYA6J/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ckJTeLLE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=truHWJsK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D80BD345E7;
	Thu, 25 Apr 2024 23:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714087128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=52y5sBbq6yd4cZWzlgqBhsOglWePkg8NYEXLDnSj9n0=;
	b=zJuxruLY+3JmcsK93MONqBjx88QO12qF0HxR8MD+Dqt77S0gjupa3fk6GBCAeKLhFePGJF
	4D+rmmlZLXIy7Uf/7QX1Cd8MQZDNK49gmIIrhvOTVpvjamEGheBDcu1XpNTKh6KDA8QfND
	N7kRtQU+Fko8SOvbR3LBXB+mVB5+7gI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714087128;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=52y5sBbq6yd4cZWzlgqBhsOglWePkg8NYEXLDnSj9n0=;
	b=bNdYA6J/5fTjQwrU6+XbSnWrOQt1XJ35F8Zxe2Tf8he2hXyxVDQV2ZvWSsXOSNiZhGIFJd
	v5cm3xrTeI/OlcCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ckJTeLLE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=truHWJsK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714087127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=52y5sBbq6yd4cZWzlgqBhsOglWePkg8NYEXLDnSj9n0=;
	b=ckJTeLLE28orgl8rFbmFAyUy5dYrotZueK/jUcfFlThwyFmZ5SURkJfzzjFS3ctbP3kl2+
	p+LWAP010gsmbY6NZdys1NcFH3l6D2DFpBwm8busNpI6VYQjzS8C3V24XrdRdNRlGReySm
	720ayNBM3rCYieiUTxUAQO8klAvyT0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714087127;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=52y5sBbq6yd4cZWzlgqBhsOglWePkg8NYEXLDnSj9n0=;
	b=truHWJsKYvh1OjfIMk/frIJqe4Kbb5eJinIys2r56Unm1a0khg86+kviit8839ArDNpz1e
	th8hSwaTdyeiYaDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AD391393C;
	Thu, 25 Apr 2024 23:18:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oXnAC9TkKmbQCQAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 25 Apr 2024 23:18:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chris Packham" <Chris.Packham@alliedtelesis.co.nz>
Cc: "Chuck Lever III" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "netdev" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: kernel BUG at net/sunrpc/svc.c:570 after updating from v5.15.153
 to v5.15.155
In-reply-to: <141fbaa0-f8fa-4bfe-8c2d-7749fcf78ab3@alliedtelesis.co.nz>
References: <>, <141fbaa0-f8fa-4bfe-8c2d-7749fcf78ab3@alliedtelesis.co.nz>
Date: Fri, 26 Apr 2024 09:18:40 +1000
Message-id: <171408712052.7600.17665015984185673222@noble.neil.brown.name>
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D80BD345E7
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,oracle.com:email];
	DKIM_TRACE(0.00)[suse.de:+]

On Fri, 26 Apr 2024, Chris Packham wrote:
>=20
> On 25/04/24 11:37, NeilBrown wrote:
> > On Thu, 25 Apr 2024, Chuck Lever III wrote:
> >>> On Apr 24, 2024, at 9:33=E2=80=AFAM, Chuck Lever III <chuck.lever@oracl=
e.com> wrote:
> >>>
> >>>> On Apr 24, 2024, at 3:42=E2=80=AFAM, Chris Packham <Chris.Packham@alli=
edtelesis.co.nz> wrote:
> >>>>
> >>>> On 24/04/24 13:38, Chris Packham wrote:
> >>>>> On 24/04/24 12:54, Chris Packham wrote:
> >>>>>> Hi Jeff, Chuck, Greg,
> >>>>>>
> >>>>>> After updating one of our builds along the 5.15.y LTS branch our
> >>>>>> testing caught a new kernel bug. Output below.
> >>>>>>
> >>>>>> I haven't dug into it yet but wondered if it rang any bells.
> >>>>> A bit more info. This is happening at "reboot" for us. Our embedded
> >>>>> devices use a bit of a hacked up reboot process so that they come back
> >>>>> faster in the case of a failure.
> >>>>>
> >>>>> It doesn't happen with a proper `systemctl reboot` or with a SYSRQ+B
> >>>>>
> >>>>> I can trigger it with `killall -9 nfsd` which I'm not sure is a
> >>>>> completely legit thing to do to kernel threads but it's probably close
> >>>>> to what our customized reboot does.
> >>>> I've bisected between v5.15.153 and v5.15.155 and identified commit
> >>>> dec6b8bcac73 ("nfsd: Simplify code around svc_exit_thread() call in
> >>>> nfsd()") as the first bad commit. Based on the context that seems to
> >>>> line up with my reproduction. I'm wondering if perhaps something got
> >>>> missed out of the stable track? Unfortunately I'm not able to run a mo=
re
> >>>> recent kernel with all of the nfs related setup that is being used on
> >>>> the system in question.
> >>> Thanks for bisecting, that would have been my first suggestion.
> >>>
> >>> The backport included all of the NFSD patches up to v6.2, but
> >>> there might be a missing server-side SunRPC patch.
> >> So dec6b8bcac73 ("nfsd: Simplify code around svc_exit_thread()
> >> call in  nfsd()") is from v6.6, so it was applied to v5.15.y
> >> only to get a subsequent NFSD fix to apply.
> >>
> >> The immediately previous upstream commit is missing:
> >>
> >>    390390240145 ("nfsd: don't allow nfsd threads to be signalled.")
> >>
> >> For testing, I've applied this to my nfsd-5.15.y branch here:
> >>
> >>    https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
> >>
> >> However even if that fixes the reported crash, this suggests
> >> that after v6.6, nfsd threads are not going to respond to
> >> "killall -9 nfsd".
> > I think this likely is the problem.  The nfsd threads must be being
> > killed by a signal.
> > One only other cause for an nfsd thread to exit is if
> > svc_set_num_threads() is called, and all places that call that hold a
> > ref on the serv structure so the final put won't happen when the thread
> > exits.
> >
> > Before the patch that bisect found, the nfsd thread would exit with
> >
> >   svc_get();
> >   svc_exit_thread();
> >   nfsd_put();
> >
> > This also holds a ref across the svc_exit_thread(), and ensures the
> > final 'put' happens from nfsD_put(), not svc_put() (in
> > svc_exit_thread()).
> >
> > Chris: what was the context when the crash happened?  Could the nfsd
> > threads have been signalled?  That hasn't been the standard way to stop
> > nfsd threads for a long time, so I'm a little surprised that it is
> > happening.
>=20
> We use a hacked up version of shutdown from util-linux and which does a=20
> `kill (-1, SIGTERM);` then `kill (-1, SIGKILL);` (I don't think that=20
> particular behaviour is the hackery). I'm not sure if -1 will pick up=20
> kernel threads but based on the symptoms it appears to be doing so (or=20
> maybe something else is in it's SIGTERM handler). I don't think we were=20
> ever really intending to send the signals to nfsd so whether it actually=20
> terminates or not I don't think is an issue for us. I can confirm that=20
> applying 390390240145 resolves the symptom we were seeing.
>=20
>=20

Makes sense - thanks.
"kill -1 ..." does send the signal to *every* process including kernel
threads.  I'm glad you weren't depending on that to kill nfsd.
Hopefully no one else is.  I think the best way forward is to apply that
patch to 5.15-stable as Chuck plans to do.

Thanks,
NeilBrown

