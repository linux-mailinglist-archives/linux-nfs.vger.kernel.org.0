Return-Path: <linux-nfs+bounces-21939-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FUkCLFYFWqmUQcAu9opvQ
	(envelope-from <linux-nfs+bounces-21939-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 10:24:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E175D2686
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 10:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 93A163007AC9
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 08:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A11395AF2;
	Tue, 26 May 2026 08:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="t1SXhW59"
X-Original-To: linux-nfs@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBE2314B9A
	for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779783851; cv=none; b=KTZlMA3uMbT4HAa7pubNtirMbLqs5RWUqZq6HnsSRfkyah2nHz+kA+SKKYZWzW6gosR38kpa7nTQz/EHILyY/YrjLJWJH4SdE9MNaBPgQtSkeOhqxJr1uFBiMTPxmvE2/olA6AkxTO03fuQ8ZhZqbwFlmU2EU0jGi467WSMUhPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779783851; c=relaxed/simple;
	bh=/fKIRGc9nDd301poYatVU6asPuq8vJgSXymx2zvyf3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPlwZ/GMikX0eInBUZXJHjeva0TqW426VCznaCv32BMLRbBXQukaiLehpTZpdfBvEwYx9tSAuZMSUYnX1Em2QxaeU0/kIJ2AgSe9ejG7/E2nNWehzvvXq56S2bkOZrkHoI3cW3mB+LI1BqF5SR7YUDkuEYtqzy3fQMBPmwVZmrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=t1SXhW59; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 1a9a7074-58dc-11f1-92ad-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 1a9a7074-58dc-11f1-92ad-005056aba152;
	Tue, 26 May 2026 10:22:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=XcVYvFvkRjKvcJr/gFoZDk3bwojTNeyPeuRG2RUgC5g=;
	b=t1SXhW59qD8FpsQ3m+ibRoWdSbv26zxiSHyQT3gjK+XN/eaMwppyud7x+yX/oX/9veKHCYeOxxGch
	 CDhVyIah+a2bFaeHgWhdPt3CGr+edEM1w7LRNWCZUpmH5MkxsQ4lOAAbI+Ohg/tZHfxl+r/3Sa3+Xu
	 bWWMoCKe6HXmswLnQM0zkZE4DA3+bzg7J5PbjGqaQZgJeRarzTwgTz/DIF+jvlty1jElWm82iuO3lW
	 VObITt/IHlJ/6J9jD4NUsgNXZJM5HdWuEaqC7OY0lgEN5PeLkLSn8caqfVFfbBDxQvfzjXM64Zionj
	 6a8P3xdvmWAQ1Es5xtYkSfmi1P2pzGw==
X-KPN-MID: 33|r+P+6MpysRhjeDxajuacMbLzERvFhV7DSdo9od9EqR/XYii4/dUuI/S+Qrqi1yZ
 Lg8YATkwXsgz2FBCp35ie7Llt1SbBRktE8tgQCglWO18=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|tEyg/LwB4FNwBxgYLDxi+ojkPVyydTIdx7ykYjPaizTBxrKOlzyAx8fuh+cwuSg
 mA/y3D6CnQgci07qz32eUXw==
Received: from localhost (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 1a733819-58dc-11f1-8011-005056ab7447;
	Tue, 26 May 2026 10:22:58 +0200 (CEST)
Date: Tue, 26 May 2026 10:22:58 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Benjamin Coddington <bcodding@redhat.com>, 
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] VFS: fix possible failure to unlock in
 nfsd4_create_file()
Message-ID: <ahVXG28wpqDwZpFT@lt-jori.localdomain>
Mail-Followup-To: Jori Koolstra <jkoolstra@xs4all.nl>, 
	Mateusz Guzik <mjguzik@gmail.com>, NeilBrown <neil@brown.name>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Benjamin Coddington <bcodding@redhat.com>, 
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <177969022571.3379282.16448744624428323496@noble.neil.brown.name>
 <36bvv2anew3cegsd374uzwdgue2txpgnzo2357ye5pldqi4by6@lafavyjgevqo>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36bvv2anew3cegsd374uzwdgue2txpgnzo2357ye5pldqi4by6@lafavyjgevqo>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21939-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[xs4all.nl]
X-Rspamd-Queue-Id: 24E175D2686
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 09:13:28AM +0200, Mateusz Guzik wrote:
> On Mon, May 25, 2026 at 04:23:45PM +1000, NeilBrown wrote:
> > 
> > atomic_create() in fs/namei.c drops the reference to the dentry
> > when it returns an error.
> > This behaviour was imported into dentry_create() so that it
> > will drop the reference if an error is returned from atomic_create(),
> > though not if vfs_create() returns an error (in the case where
> > ->atomic_create is not supported).
> > 
> > The caller - nfsd4_create_file() - is made aware of this by checking
> > path->dentry, which will either be a counted reference to a dentry, or
> > an error pointer.
> > 
> > However the change to use start_creating()/end_creating() (which landed
> > shortly before the dentry_create() change landed, though was likely
> > developed around the same time) means that nfsd4_create_file() *needs* a
> > valid dentry so that it can unlock the parent.
> > 
> > The net result is that if NFSD exports a filesystem which uses
> > ->atomic_create, and if a call to ->atomic_create returns an error, then
> > nfsd4_create_file() will pass an error pointer to end_creating()
> > and the parent will not be unlocked.
> > 
> > Fix this by changing dentry_create() to make sure path->dentry is always
> > a valid dentry, never an error-pointer.  The actual error is already
> > returned a different way.
> > 
> [..]
> > +		/* atomic_open will dput(dentry) on error */
> > +		dget(orig_dentry);
> >  		dentry = atomic_open(path, dentry, file, flags, mode);
> >  		error = PTR_ERR_OR_ZERO(dentry);
> >  
> > +		if (IS_ERR(dentry))
> > +			/* keep the original */
> > +			dentry = orig_dentry;
> > +		else
> > +			/* Drop the extra reference */
> > +			dput(orig_dentry);
> > +
> 
> atomic_open() is a static func with only 2 callers. perhaps it would be
> better to change its semantics instead?
> 
> I'm asking because the vfs layer is very slow single-threaded and this
> here just adds even more slowdown due to avoidable 2 rmw atomics.
> 
> Granted the affected routine is only used by overlayfs and nfs, but even
> then this should not be necessary.

I only notice Neil's patch now. I found this same bug and submitted a
patch on the same day :) [1]. I think it is awkward that atomic_open()
dputs the dentry on failure, so that is the approach I chose. But
perhaps there are good reasons for it, although vfs_create() does not do
this for instance.

There are also some other things going on, including a stale docstring,
perhaps I should have separated that out.

[1]: https://lore.kernel.org/linux-fsdevel/20260525101544.195832-1-jkoolstra@xs4all.nl/T/#u

