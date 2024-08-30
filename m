Return-Path: <linux-nfs+bounces-6060-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2900C96675E
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 18:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74C63B27843
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 16:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2CC1B81C3;
	Fri, 30 Aug 2024 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3aUvSVET";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uTxwFuwK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3aUvSVET";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uTxwFuwK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5FB13BAE2
	for <linux-nfs@vger.kernel.org>; Fri, 30 Aug 2024 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725036683; cv=none; b=jEIVy5+zXHRqfHKaIVthLJ+8WOYUCJ/8KNPxuqCPobPeXPrbICKZ6o9MoGUpkkwfAC8LvQVBk+IA22j2GR6moF9mSx29Knx7uHRZPyy5KwUtzriGzD+KaSfBMmqc+SLoo62kzYjVKl4FlBf6Wo3QpnOc9MFe2zG9o7N6MB3P2jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725036683; c=relaxed/simple;
	bh=vxO9mvdsUrAcpfjnlcqE0U9ie09Wxp/U2WPRBB5bmyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRS1vBrhyLcJzPythb+cY4DFfeaFQiKePriLDMyhbyNRhDpmoHhNpbQNMvb7TPtEqYVor7AbZuBqoZClx7agsY5hT59is3Q4KzHXV3Hl6SQyotE2GT9x6fIcHu4r1b5HBDGr809Y0+Qeme/3quxIgrSb8+SpbStc9toKLCN7XfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3aUvSVET; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uTxwFuwK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3aUvSVET; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uTxwFuwK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A33331F7DF;
	Fri, 30 Aug 2024 16:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725036678;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6tRnqXnlixcAS0gI7GS4Hf0iho6DnIse7v8q6km1rRw=;
	b=3aUvSVETx8laywZxRtcf2NQcbff0uvyD/YHfkSLpaJAqs7onfQ4KtXse75Xo+Z1yZVYdmZ
	nNyaKj9lY0UO7aXeXPy2ThrZNHwLys7Lp6S0vWwN0tS31fC/RQ2hT7EIjKJqbBf7Fn7aTm
	kDGrcat++TLXBTGE6C2oYT8xL3xb5p0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725036678;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6tRnqXnlixcAS0gI7GS4Hf0iho6DnIse7v8q6km1rRw=;
	b=uTxwFuwKPzlY97k4DKj3abJz7HjJc/fd4Y6E6TS+HVJaB7X3RZXfrPZvAAFQINjE4fBMW+
	UYi9ZWo8Gsx5CmCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3aUvSVET;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uTxwFuwK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725036678;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6tRnqXnlixcAS0gI7GS4Hf0iho6DnIse7v8q6km1rRw=;
	b=3aUvSVETx8laywZxRtcf2NQcbff0uvyD/YHfkSLpaJAqs7onfQ4KtXse75Xo+Z1yZVYdmZ
	nNyaKj9lY0UO7aXeXPy2ThrZNHwLys7Lp6S0vWwN0tS31fC/RQ2hT7EIjKJqbBf7Fn7aTm
	kDGrcat++TLXBTGE6C2oYT8xL3xb5p0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725036678;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6tRnqXnlixcAS0gI7GS4Hf0iho6DnIse7v8q6km1rRw=;
	b=uTxwFuwKPzlY97k4DKj3abJz7HjJc/fd4Y6E6TS+HVJaB7X3RZXfrPZvAAFQINjE4fBMW+
	UYi9ZWo8Gsx5CmCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C013113A3D;
	Fri, 30 Aug 2024 16:51:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pJI1JYX40WYoFQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 30 Aug 2024 16:51:17 +0000
Date: Fri, 30 Aug 2024 18:51:16 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org, libtirpc-devel@lists.sourceforge.net,
	Josue Ortega <josue@debian.org>, NeilBrown <neilb@suse.de>,
	Thomas Blume <Thomas.Blume@suse.com>,
	Yann Leprince <yann.leprince@ylep.fr>,
	Steve Langasek <steve.langasek@canonical.com>
Subject: Re: [RFC][PATCH rpcbind 4/4] systemd/rpcbind.service.in: Want/After
 systemd-tmpfiles-setup
Message-ID: <20240830165116.GA84900@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240823002322.1203466-1-pvorel@suse.cz>
 <20240823002322.1203466-5-pvorel@suse.cz>
 <20240823010143.GA1206597@pevik>
 <ab08bb95-7326-4570-b10d-12534be6488b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab08bb95-7326-4570-b10d-12534be6488b@redhat.com>
X-Rspamd-Queue-Id: A33331F7DF
X-Spam-Level: 
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_EQ_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[opensuse.org:url,suse.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.71
X-Spam-Flag: NO

Hi Steve,

> Hey!

> My apologies for taking so long to address these patches.
No problem, understand you're busy.

> On 8/22/24 9:01 PM, Petr Vorel wrote:
> > Hi Steve,

> > > Add Want/After systemd-tmpfiles-setup.service. This is taken from Fedora
> > > rpcbind-0.2.4-5.fc25 patch [1] which tried to handle bug #1401561 [2]
> > > where /var/run/rpcbind.lock cannot be created due missing /var/run/
> > > directory. But the suggestion to add RequiresMountFor=... was
> > > implemented in ee569be ("Fix boot dependency in systemd service file").

> > > But even with RequiresMountsFor=/run/rpcbind in rpcbind.service and
> > > /run/rpcbind.lock there is error on openSUSE Tumbleweed with rpcbind
> > > 1.2.6:

> > > rpcbind.service: Failed at step NAMESPACE spawning /usr/sbin/rpcbind: Read-only file system

> > > Adding systemd-tmpfiles-setup.service fixes it.

> > > NOTE: Debian uses for this purpose remote-fs-pre.target (also works, but
> > > systemd-tmpfiles-setup.service looks to me more specific).
> > > openSUSE uses only After=sysinit.target as a result of #1117217 [3]
> > > (also works).

> > Reading RH #1117217 once more I wonder if old Fedora patch [4], which places
> > rpcbind.lock into /var/run/rpcbind/ would be a better solution:

> > configure.ac
> > -  --with-statedir=ARG     use ARG as state dir [default=/var/run/rpcbind]
> > +  --with-statedir=ARG     use ARG as state dir [default=/run/rpcbind]
> > ...
> > -  with_statedir=/var/run/rpcbind
> > +  with_statedir=/run/rpcbind

> > src/rpcbind.c
> > -#define RPCBINDDLOCK "/var/run/rpcbind.lock"
> > +#define RPCBINDDLOCK RPCBIND_STATEDIR "/rpcbind.lock"

> > But I suppose other out-of-tree patch [5] is not a dependency for it, right?
> I don't like out-of-tree patch but sometimes they are necessary
> since I didn't what to force other distros to adapt what
> I made Fedora use.

Sure, let's drop this. I was also thinking to add this as a configuration issue,
but I suppose most of the distro maintainers are perfectly ok with this
directory patch.

> > Debian [6] and openSUSE [7] use more simpler version to move to /run. Maybe time
> > to upstream Fedora patch and distros will adopt it?
> It is time! :-) I'm all for distros to consolidate into one code
> base... it is much easier to find bugs and support. IMHO.

> Please send patches [6] and [7] in the correct patch form and
> I will commit them and mostly like create another release.

I'll do, thanks!

Kind regards,
Petr

> Thank you.. for point these differences out!!

> steved.


> > Kind regards,
> > Petr

> > > [1] https://src.fedoraproject.org/rpms/rpcbind/blob/rawhide/f/rpcbind-0.2.4-systemd-service.patch
> > > [2] https://bugzilla.redhat.com/show_bug.cgi?id=1401561
> > > [3] https://bugzilla.suse.com/show_bug.cgi?id=1117217

> > [4] https://src.fedoraproject.org/rpms/rpcbind/blob/f41/f/rpcbind-0.2.4-runstatdir.patch
> > [5] https://src.fedoraproject.org/rpms/rpcbind/blob/rawhide/f/rpcbind-0.2.4-systemd-rundir.patch
> > [6] https://salsa.debian.org/debian/rpcbind/-/blob/master/debian/patches/run-migration?ref_type=heads
> > [7] https://build.opensuse.org/projects/openSUSE:Factory/packages/rpcbind/files/0001-change-lockingdir-to-run.patch?expand=1

> > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > ---
> > >   systemd/rpcbind.service.in | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)

> > > diff --git a/systemd/rpcbind.service.in b/systemd/rpcbind.service.in
> > > index 272e55a..771b944 100644
> > > --- a/systemd/rpcbind.service.in
> > > +++ b/systemd/rpcbind.service.in
> > > @@ -7,7 +7,8 @@ RequiresMountsFor=@statedir@
> > >   # Make sure we use the IP addresses listed for
> > >   # rpcbind.socket, no matter how this unit is started.
> > >   Requires=rpcbind.socket
> > > -Wants=rpcbind.target
> > > +Wants=rpcbind.target systemd-tmpfiles-setup.service
> > > +After=systemd-tmpfiles-setup.service

> > >   [Service]
> > >   ProtectSystem=full



