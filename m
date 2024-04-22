Return-Path: <linux-nfs+bounces-2912-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9148AC31F
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Apr 2024 05:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE7C1F20F2D
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Apr 2024 03:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC88DF53;
	Mon, 22 Apr 2024 03:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Qm7wds+s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4SLATE9Z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Qm7wds+s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4SLATE9Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885B94C97;
	Mon, 22 Apr 2024 03:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713757023; cv=none; b=ONNkugn+m7hBbl7McgeLEIuC7E+vgr2kVqTYJM8hlcZK7WIoyaEMGgAC0RKKUimCbd6+4UzVA22stsxN1qfz/RLRQwjN3RyjdVBv5EHte5vUxnxvKyr7J+iZxtreVLdhseBWLinSWYtsy0Jep5V5ouJoGTPccykzfGr8sfbt6rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713757023; c=relaxed/simple;
	bh=qYFDMAJcDKDAHcovceq0j0xzYciZ1jZkcykqVc752Hg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=W8/VgSD+2wl0hXDDIeEg0QmTHejVPbc5gZxty1H8VUFDYD4K1C4bPQZDV4PSeTcX7BhjB0/lJtv0W3w7zCmysWM3LJ1B1Hq36qnS6CBZ3v1RUjxU6MSvQfGA1leVuLlCIq2p8frDEZMeeqzh3R8b23sznsw2KdnNLXiHxQ5V0uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Qm7wds+s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4SLATE9Z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Qm7wds+s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4SLATE9Z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8FB4A5C823;
	Mon, 22 Apr 2024 03:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713757018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DiLsxj1b3Rv+1AV/ikJh8iSUjiJip9tNujGIq8yix+M=;
	b=Qm7wds+sXhwRX6BXISk+cBlBszvn3mWanP6PZngGIOlnuW89fPRcQWo2KteSmkjfKj6aCp
	kmOOj3Sfa7v7oXssLkVW02/oLfkfKWNliYexfpMr8EssmjgzrNPNoaiFHh/QT5QACqAz0M
	KK4W6H1Er6cgnlWY+xwRo2QouAIZBVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713757018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DiLsxj1b3Rv+1AV/ikJh8iSUjiJip9tNujGIq8yix+M=;
	b=4SLATE9ZeOcRwmv+XVRuK/l1eJObvFtmlrKwIZ8ssiQPuSxvoxCqHZv0OWTgyelAOtn9GG
	+IEdhQW0SZS8MOCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713757018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DiLsxj1b3Rv+1AV/ikJh8iSUjiJip9tNujGIq8yix+M=;
	b=Qm7wds+sXhwRX6BXISk+cBlBszvn3mWanP6PZngGIOlnuW89fPRcQWo2KteSmkjfKj6aCp
	kmOOj3Sfa7v7oXssLkVW02/oLfkfKWNliYexfpMr8EssmjgzrNPNoaiFHh/QT5QACqAz0M
	KK4W6H1Er6cgnlWY+xwRo2QouAIZBVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713757018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DiLsxj1b3Rv+1AV/ikJh8iSUjiJip9tNujGIq8yix+M=;
	b=4SLATE9ZeOcRwmv+XVRuK/l1eJObvFtmlrKwIZ8ssiQPuSxvoxCqHZv0OWTgyelAOtn9GG
	+IEdhQW0SZS8MOCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94A0913687;
	Mon, 22 Apr 2024 03:36:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nexLDlfbJWYCLQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 22 Apr 2024 03:36:55 +0000
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
Cc: "Lorenzo Bianconi" <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
 lorenzo.bianconi@redhat.com, chuck.lever@oracle.com, netdev@vger.kernel.org,
 kuba@kernel.org
Subject: Re: [PATCH v8 3/6] NFSD: add write_version to netlink command
In-reply-to: <71465d57edc1799978e85b1bcfd1bb68b1f174ef.camel@kernel.org>
References: <>, <71465d57edc1799978e85b1bcfd1bb68b1f174ef.camel@kernel.org>
Date: Mon, 22 Apr 2024 13:36:47 +1000
Message-id: <171375700742.7600.2829467433799282531@noble.neil.brown.name>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Wed, 17 Apr 2024, Jeff Layton wrote:
> On Wed, 2024-04-17 at 10:43 +1000, NeilBrown wrote:
> > On Wed, 17 Apr 2024, Jeff Layton wrote:
> > > On Wed, 2024-04-17 at 09:05 +1000, NeilBrown wrote:
> > > > On Wed, 17 Apr 2024, Jeff Layton wrote:
> > > > > On Wed, 2024-04-17 at 07:48 +1000, NeilBrown wrote:
> > > > > > On Tue, 16 Apr 2024, Jeff Layton wrote:
> > > > > > > On Tue, 2024-04-16 at 13:16 +1000, NeilBrown wrote:
> > > > > > > > On Tue, 16 Apr 2024, Lorenzo Bianconi wrote:
> > > > > > > > > Introduce write_version netlink command through a "declarat=
ive" interface.
> > > > > > > > > This patch introduces a change in behavior since for versio=
n-set userspace
> > > > > > > > > is expected to provide a NFS major/minor version list it wa=
nts to enable
> > > > > > > > > while all the other ones will be disabled. (procfs write_ve=
rsion
> > > > > > > > > command implements imperative interface where the admin wri=
tes +3/-3 to
> > > > > > > > > enable/disable a single version.
> > > > > > > >=20
> > > > > > > > It seems a little weird to me that the interface always disab=
les all
> > > > > > > > version, but then also allows individual versions to be disab=
led.
> > > > > > > >=20
> > > > > > > > Would it be reasonable to simply ignore the "enabled" flag wh=
en setting
> > > > > > > > version, and just enable all versions listed??
> > > > > > > >=20
> > > > > > > > Or maybe only enable those with the flag, and don't disable t=
hose
> > > > > > > > without the flag?
> > > > > > > >=20
> > > > > > > > Those don't necessarily seem much better - but the current be=
haviour
> > > > > > > > still seems odd.
> > > > > > > >=20
> > > > > > >=20
> > > > > > > I think it makes sense.
> > > > > > >=20
> > > > > > > We disable all versions, and enable any that have the "enabled"=
 flag set
> > > > > > > in the call from userland. Userland technically needn't send do=
wn the
> > > > > > > versions that are disabled in the call, but the current userlan=
d program
> > > > > > > does.
> > > > > > >=20
> > > > > > > I worry about imperative interfaces that might only say -- "ena=
ble v4.1,
> > > > > > > but disable v3" and leave the others in their current state. Th=
at
> > > > > > > requires that both the kernel and userland keep state about what
> > > > > > > versions are currently enabled and disabled, and it's possible =
to get
> > > > > > > that wrong.
> > > > > >=20
> > > > > > I understand and support your aversion for imperative interfaces.
> > > > > > But this interface, as currently implemented, looks somewhat impe=
rative.
> > > > > > The message sent to the kernel could enable some interfaces and t=
hen
> > > > > > disable them.  I know that isn't the intent, but it is what the c=
ode
> > > > > > supports.  Hence "weird".
> > > > > >=20
> > > > > > We could add code to make that sort of thing impossible, but ther=
e isn't
> > > > > > much point.  Better to make it syntactically impossible.
> > > > > >=20
> > > > > > Realistically there will never be NFSv4.3 as there is no need - n=
ew
> > > > > > features can be added incrementally.=C2=A0
> > > > > >=20
> > > > >=20
> > > > > There is no need _so_far_. Who knows what the future will bring? Ma=
ybe
> > > > > we'll need v4.3 in order to add some needed feature?
> > > > >=20
> > > > > >  So we could just pass an array of
> > > > > > 5 active flags: 2,3,4.0,4.1,4.2.  I suspect you wouldn't like tha=
t and
> > > > > > I'm not sure that I do either.  A "read" would return the same ar=
ray
> > > > > > with 3 possible states: unavailable, disabled, enabled.  (Maybe t=
he
> > > > > > array could be variable length so 5.0 could be added one day...).
> > > > > >=20
> > > > >=20
> > > > > A set of flags is basically what this interface is. They just happe=
n to
> > > > > also be labeled with the major and minorversion. I think that's a g=
ood
> > > > > thing.
> > > >=20
> > > > Good for whom?  Labelling allows for labelling inconsistencies.
> > > >=20
> > >=20
> > > Now you're just being silly. You wanted a variable length array, but
> > > what if the next slot is not v4.3 but 5.0? A positional interpretation
> > > of a slot in an array is just as just as subject to problems.
> >=20
> > I don't think it could look like a imperative interface, which the
> > current one does a bit.
> >=20
> > >=20
> > > > Maybe the kernel should be able to provide an ordered list of labels,
> > > > and separately an array of which labels are enabled/disabled.
> > > > Userspace could send down a new set of enabled/disabled flags based on
> > > > the agreed set of labels.
> > > >=20
> > >=20
> > > How is this better than what's been proposed? One strength of netlink is
> > > that the data is structured. The already proposed interface takes
> > > advantage of that.
> > >=20
> > > > Here is a question that is a bit of a diversion, but might help us
> > > > understand the context more fully:
> > > >=20
> > > >   Why would anyone disable v4.2 separately from v4.1 ??
> > > >=20
> > >=20
> > > Furthermore, what does it mean to disable v4.1 but leave v4.2 enabled?
> >=20
> > Indeed!
> >=20
> > >=20
> > > > I understand that v2, v3, v4.0, v4.1 are effectively different protoc=
ols
> > > > and you might want to ensure that only the approved/tested protocol is
> > > > used.  But v4.2 is just a few enhancements on v4.1.  Why would you wa=
nt
> > > > to disable it?
> > > >=20
> > > > The answer I can think of that there might be bugs (perish the
> > > > thought!!) in some of those features so you might want to avoid using
> > > > them.
> > > > But in that case, it is really the features that you want to suppress,
> > > > not the protocol version.
> > > >=20
> > > > Maybe I might want to disable delegation - to just write delegation.
> > > > Can I do that?  What if I just want to disable server-side copy, but
> > > > keep fallocate and umask support?
> > > >=20
> > > > i.e.  is a list of versions really the granularity that we want to use
> > > > for this interface?
> > > >=20
> > >=20
> > > Our current goal is to replace rpc.nfsd with a new program that works
> > > via netlink. An important bit of what rpc.nfsd does is start the NFS
> > > server with the settings in /etc/nfs.conf. Some of those settings are
> > > vers3=3D, vers4.0=3D, etc. that govern how /proc/fs/nfsd/versions is se=
t.
> > > We have an immediate need to deal with those settings today, and
> > > probably will for quite some time.
> > >=20
> > > I'm not opposed to augmenting that with something more granular, but I
> > > don't think we should block this interface and wait on that. We can
> > > extend the interface at some point in the future to take a new feature
> > > bitmask or something, and just declare that (e.g.) declaring vers4.2=3Dn
> > > disables some subset of those features.
> >=20
> > I agree that we don't want to block "good" while we wait for "perfect".  I
> > just want to be sure that what we have is "good".
> >=20
> > The current /proc interface uses strings like "v3" and "v4.1".
> > The proposed netlink interface uses pairs on u32s - "major" and "minor".
> > So we lose some easy paths for extensibility.  Are we comfortable with
> > that?
> >=20
> > This isn't a big deal - certainly not a blocked.  I just don't feel
> > entirely comfortable about the current interface and I'm exploring to
> > see if there might be something better.
> >=20
> >=20
>=20
> Ok, I'm not convinced that anything you've proposed so far is better
> than what we have, but I'm open-minded.

Thanks.  I admit that I don't think anything I've come up with is better
either.

>=20
> At this point we have these to-dos:
>=20
> 1) make the threads interface accept an array of integers rather than a
> singleton. This is needed when sunrpc.pool_mode is not global.
>=20

While this I think probably still makes sense, I'm feeling less
enthusiastic about it and probably wouldn't complain if it didn't
happen.

I don't like that fact that we need to configure a number of threads.  I
would much rather it grow/shrink dynamically.  I've got more patches
that are heading in this direction but they aren't ready yet.

If we do land these and they prove to be effective, then configuring
per-pool threads would become extremely uninteresting.  The demand on
each pool would adjust each pool separately.

So if use an array here turns out to be problematic for some reason, I
won't complain.

> 2) have the interface pass down the scope string in the THREADS_SET
> instead of making userland change the UTS namespace before starting
> threads. This should just mean adding a new optional string attribute to
> the threads interfaces.
>=20
> ...anything else we're missing that needs doing here? We'd really like
> to see this in -next soon, so we can possibly make v6.10 with this.

I haven't yet found any obvious gaps.  I agree that we can and should
move forward promptly.

Thanks,
NeilBrown


>=20
> Thanks,
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20


