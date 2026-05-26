Return-Path: <linux-nfs+bounces-21952-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0H2MFmeHFWpXWQcAu9opvQ
	(envelope-from <linux-nfs+bounces-21952-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 13:43:35 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB685D5113
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 13:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 212843007235
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 11:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56733E170B;
	Tue, 26 May 2026 11:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="d5QG5IPf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BPNnm0N6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-c8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E31E3E6392;
	Tue, 26 May 2026 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779795758; cv=none; b=fq9rBX0i5s3zp+bpxD57RkxmtFiWXWyNlSykTQ2DsgE2RsZexbjCHZ0mdkGWz0gYQk8OACt595hDR9Ubc7UDuNky3mqNi+ITXyJv9TkFNpDLHMFabzVONvjBTRnGtT02XPiXg1jknC+roq2Q4ILcndb25Q6awaiedTIUjyPM7Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779795758; c=relaxed/simple;
	bh=SQZKVDWD1KdqpDeH030yQ/YBIkFX3jvk9Yn2AZ4pwG8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=npL+x33UH/v14fISjPzYcBtwc5F4JBN0p8TRqUAnWRzGZsrtXUezh6j7eqsreznsYdQCHzOBhljNj/8ckOvo/nFUelXCEN6U52mPx5LH5EcuesUmwQtbYO4rDWCk4wy3q99UEQ1clG1JdgTdZDiSqlvQu9OdiSuFFXfrLWyTVRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=d5QG5IPf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BPNnm0N6; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A78041D000EE;
	Tue, 26 May 2026 07:42:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 26 May 2026 07:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1779795746; x=1779882146; bh=61i4wIC4Tn5iEmlHns5NVSjEXBu1i37B6tm
	sjHpNh0A=; b=d5QG5IPfM1gH/un9kCSsYVkveVXDWaHQnnbuEQdDtRN59I1qMk1
	I9WQMQ6J6Xp4TvbUj2g614nK3XB4GgMH/B1cj+SvMEqV/t6w5LnS0zvvpA6hSa8Q
	XI6VSBoQ5KrWO84LGj1GI3ZbgiEdJFy8NkkTFf7IxirQwEeu6LqdkxRJLdbB50Ng
	pUHIomsARc/jhM9z/MrJ8bCTfSWDFfKKWZqeh+Z4G1Ie7LmZnKZHCACQ2Or+6o5Z
	iBav0xvcCRjvZq2C6mK9KtvcEqWcMvECGWbRA+K07mJx4D1q9i20N1wIumAiNurQ
	D235A0+mDiNtAlIOWhg0YZVy3pcAlDJrJ6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779795746; x=
	1779882146; bh=61i4wIC4Tn5iEmlHns5NVSjEXBu1i37B6tmsjHpNh0A=; b=B
	PNnm0N6Oz259omGQKh3jJHUSXX6IvcoxzB5s9BN/cGgXPV+B0OfAV8FQQMiphRD9
	bJ70k+aVV02pQ/dUMzkNznxv5anb6PqfG66d39WxAHiWdMhiakGjiFxZJzGtBcAP
	qLULTFR/GtY6dQWVrs9eJ6OrmDvSmfLLmkwHbs0WZ71OidEjOWmUo/9hh+gxs6s+
	f51T/MzbXYp4PK47BX1sG5d/tdOOvnwu35LBIKrmkWREOm9O4GIYwWz4P3tqXcWr
	x2FG/RiZzrwegSmWC1/UoYphe58BfggMHltTcdR/sz/9z+CMNiIWSU1f0H5X+dPF
	ah2DA2fOSLyH7bts3KWWQ==
X-ME-Sender: <xms:IocVak5_5J5mA4nRnGbTfFa45pNSqZq4XQ2yK6hQyUAi5y6saHDX6Q>
    <xme:IocVaicvXmkGNjW5NP7HrzilR7aBT3PZIYHHcjRwS5v8V6uOZTpQWvylfYkAZdTDr
    zeHSXFhYN9dApUDtz64RcoBWLOSs0rZdIWQI8YtU1nVOwFagw>
X-ME-Received: <xmr:IocVan5WETl1LgsBgs0NffID5KQBV5HCbWphCMKRsZLVNiq_vS9qJD_AP4iPYolktMAd0xzXjP5mzzQCxOw5WcBcmwW1E24>
X-ME-Proxy-Cause: dmFkZTE4UPrZN2LNi+9rTN/RWq4bh6Pz6wdzUFG46Q3sYKoVYe91zrqN1s1aUS/CYaH8UU
    vu6g96UwE8fz3eoE2/JFVW3LackT+AGlwtWcVD3mp+Dk21XzAtskx4ZBoax+iGOI0TINiJ
    ko4YdrqElIFwT+0P4OMpyyenj90gIFbEpNcN0NFH938ODmaQgySwvCND4SMOsfcrMAUJjH
    2eXOltxZLA00XoH9TLJa+i0Ws6P0IfxM9KMezL1P0bv2i7ZLZ02sNHv2oVgVaVmSWs6Dij
    4+lKHI+ImZMdCKxvD+fnJMdgEYySlhDrGZZ7ZnkO+uaNAkLm0PPo1jj4gS6i7uMoXfFSMF
    fj46g6GLQf99TbIf5Ad4WBNlIGINLs5Vjj6+CdbJ2db129wpay+++bAWideeS0pUC/eBmR
    z2KyUzt/NrllmLIGxRuLGxy6tVvcxPyj2WORpGXghK7n0JBZNNN6eQux5YrCn/CNyFRdJh
    ByqUEJOE6Hd2uVxRvkAjaQaFp9UQiBHrOqz4bnNgbaLJiyBeLiPaaxB5cY9Ql8bUBe7Var
    /gUYu8gFMZjC8C9XhsWusHbNsb75Dc30LIiOP9Y3MVGXHEh4HowxgH54K7rzfRo5xLWcW4
    LgCJF4OHOXHoPHoWSrF6bv34IMW6DVpioLE1nUxDgKJRZWthWTpNMxjx9mEQ
X-ME-Proxy: <xmx:IocVav8ItBCJC1V1KcLZbfEAqKaU6Yx6q6Kze1wapVcWMGO-UZ9itA>
    <xmx:IocVapHG7qVx9UOS2qcfKCM2Syt8H4cTIXU1EE9WcD9e20NG_Gz5NQ>
    <xmx:IocVakVJv9Eiq3f_75dJW_sA6bscOvCiBFOeW0hCw6GGC94CoRRw7Q>
    <xmx:IocVal-Zoh_dsQiNhqrzuTOsUjeaYTzqkWHHbZ_rhHtrKk4Lil4lHg>
    <xmx:IocVarJ8K-RG_eJypLuZ1h0YzyTCfxkvcZBFnO_OtyieJsGVaOQ-46ul>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 07:42:23 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Mateusz Guzik" <mjguzik@gmail.com>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Benjamin Coddington" <bcodding@redhat.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject:
 Re: [PATCH] VFS: fix possible failure to unlock in nfsd4_create_file()
In-reply-to: <36bvv2anew3cegsd374uzwdgue2txpgnzo2357ye5pldqi4by6@lafavyjgevqo>
References: <177969022571.3379282.16448744624428323496@noble.neil.brown.name>
  <36bvv2anew3cegsd374uzwdgue2txpgnzo2357ye5pldqi4by6@lafavyjgevqo>
Date: Tue, 26 May 2026 21:42:20 +1000
Message-id: <177979574027.3379282.15340720667866455874@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21952-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[ownmail.net];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[neil@brown.name]
X-Rspamd-Queue-Id: 5BB685D5113
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026, Mateusz Guzik wrote:
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
> 

My plan is to get rid of dentry_create() completely so I don't think
there is any point trying to optimise it.

I have patches to modify lookup_open() to give it a cleaner interface,
then to call that from nfsd (after similar code clean up in nfsd).
I hope to have these patches ready to patch soon.  I'll include you on
the cc: list.

Thanks,
NeilBrown

