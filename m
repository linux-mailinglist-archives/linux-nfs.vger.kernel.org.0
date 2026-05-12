Return-Path: <linux-nfs+bounces-21478-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIdVJvejAmrLvAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21478-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 05:52:23 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB40551971B
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 05:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A18230209C9
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 03:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A322825FA29;
	Tue, 12 May 2026 03:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="STrlW0w4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NF2hFCFe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5514C13AD05;
	Tue, 12 May 2026 03:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778557939; cv=none; b=Ydvt4J2Un9FYry5/Ev48RZIMLWPSTtgnRZuMkQwClpSaPNO/eFFKa+ZFNpZsYiEU/ONxz75hQk3mI9yD66r8mwnD7ioC+fJDOpK+Vq6UKoNw3yE7N/PG7HYo5iKirKtpRKugF1t7Ss5I3Cq12l7YW1eN3Fi0dCshiQYAB7QfZDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778557939; c=relaxed/simple;
	bh=X9JUtTv7zGhBbGLyYs2JZEV7jr/mRkijEcYHVvM1fKU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=r9tujHY57WyyitHLGSCAwwhS2EFv/Hp/Vy4HJw8oafMwh2qt9ljlXQzYEipqHZ8MAswDmOuiWVp3SzisnBtS47kN6Sm8uK4wc+/aeg5Ri9mMOUSEgVq2R23F+crO5AZ1aEwIfGLxGXeVf3s28Ssizz/iZfKzIBgNVB24JIQKhjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=STrlW0w4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NF2hFCFe; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 826C51D0007E;
	Mon, 11 May 2026 23:52:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 11 May 2026 23:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1778557936; x=1778644336; bh=FdOnsh8Yyk9Pf+2a/mxgpwL8oolReVdEPi6
	xLpGVgCY=; b=STrlW0w4rYjsM5dzipcOPaLMO0A4z++bbFrmvocNzwZnC6nfhDk
	Nh0cbFdvqvGwU9EDg4W+g6E4Y924lkCneTo/E1WTABfqtPGcMKRgMROeXEfADQjH
	sSG56pFdqvI93JIsMKZfcs534xI67r2t0izqOMjw3m4wwYHIqnAejd0S4/mvDqHa
	WJeP4eEJc8T2U7PiDBP95dhQGajSB3lovib0JtbJilIosle35/BZinEby+81jNk/
	Yi3gDzXMXu+Yg2wvvEGhMZ45XM8BL8EaR1BeyS5cW6mDvlDB3rf90YIRejasIvFa
	u4dnhweinBQp0H9kNoAqFOXkOq/SMWNo42g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778557936; x=
	1778644336; bh=FdOnsh8Yyk9Pf+2a/mxgpwL8oolReVdEPi6xLpGVgCY=; b=N
	F2hFCFeCiyjGa0UySiH3zFZlRGwMPg8LooddUO71/vM57TnhwUnIc+TSSLta/GeA
	iatvF9JyKSw8ZMCV7pKpufemz3vWHrGQuOLFPUEi4qc1Ls4oFAaMdYZyNqtcateP
	IOwRthe49tEiafFxE1JojwxGaQPLmJHJCGWrP7Jq1Fa/FtUXyLJX7mpn3sS5TiXD
	BspEQOircefKUe9FF3C92P8EijY7Yy3fkwcecsmGtlSAeeg0prDFrSwJ2Ar5ppQt
	yOPx6tN1g/Gajyf0ldQUbEHaRfgHbWkxYQeLUjH1QkosBVvyBGI5vcL/p7VCDbGM
	eGjPaJf6tF1N5LiwxGWag==
X-ME-Sender: <xms:8KMCarpx99huUXyEGeM-6JNHMMdd6_Mzzajxa9N6ybRd52AAtFeP5w>
    <xme:8KMCatYLy71EKff2Nm3xYhr6XquFjLlvcLWqnqssv9jHdKpsaffx1t78Xw-nMqz0Q
    etwIgFmXajzn2ibZXy04u6sgXnsA-wldxLXsrFEbQcGnYZE>
X-ME-Received: <xmr:8KMCarTJvyNk3FLbDnxqgF4eJVHbJ-3HSBxlT0bjBDG8mpaZeJcZ1F3b5vyZ_XD7uAFP5hl8bhOqulB0QnW6QKs4Ue4dphw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddtjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:8KMCas4aYpyezeP30W4o_m9r8XNqSTcEmW4riGQWf0OnGIAhCFyyZQ>
    <xmx:8KMCaoyHlYEbEAbmxO3rGdD8CHEybs-f514sIjWF0VtwfnAoHD-Fmg>
    <xmx:8KMCajQ_sUSdgxW80_E48PyMnr_anKJ6lfrawwvzgGvmKo4S8yc7Xg>
    <xmx:8KMCavWuGkiRlavrTqDnRRG566NOPXHJDA2szPdA4qEaCHhMCwWMrA>
    <xmx:8KMCaiKcJeultsZuY-qKgm6ARN4khZ8BYu_keCoH6Z1PDd43Su84eFjR>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 23:52:14 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: try_break_deleg() and atomic_open()
In-reply-to: <72c8e1e9c9212aeb8a0cb9f5321dd576685a4f7e.camel@kernel.org>
References: <177853810078.2788210.11836979435758859096@noble.neil.brown.name>
  <72c8e1e9c9212aeb8a0cb9f5321dd576685a4f7e.camel@kernel.org>
Date: Tue, 12 May 2026 13:52:11 +1000
Message-id: <177855793113.2788210.10945921479429705266@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Queue-Id: AB40551971B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21478-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:dkim,noble.neil.brown.name:mid]
X-Rspamd-Action: no action

On Tue, 12 May 2026, Jeff Layton wrote:
> On Tue, 2026-05-12 at 08:21 +1000, NeilBrown wrote:
> > Hi Jeff,
> >  quick question (I hope).
> > Should atomic_open() call try_break_deleg() on the directory
> > when a create is pending?
> > 
> > This seems a bit iffy because the VFS doesn't necessarily know if a
> > create will happen before it calls ->atomic_open, so it cannot know
> > if it needs to break the deleg or not.
> 
> Agreed, so I'm thinking no to doing that in generic code.
> 
> > So maybe the individual ->atomic_open functions should do it?
> > 
> 
> I think that's probably what has to happen:
> 
> atomic_open() is there to handle the non-trivial open cases (mostly
> network and clustered filesystems). Those, in general, also require
> non-trivial delegation/lease handling. I think we sort of need to leave
> it to the underlying fs in those cases since the kernel doesn't have
> enough info to do it.

I had a look and could only find gfs2/nolocks and NFSv4 as filesystems
which support leases on directories and use ->atomic_open.

I wonder if gfs2/nolocks should not advertise ->atomic_open.  The
implication of nolocks is (I assume) that there is only the one active
client, and in that case no special handling is needed for exclusive
create.

NFSv4 uses delegations to provide leases.  So the ->atomic_open
handler does have work to do to cancel any lease while keeping the
delegation.
We would need to either allow ->atomic_open to return the deleg_inode
somehow, or have ->atomic_open drop the parent lock so that it can
safely wait.

Or we could just ignore the issue until I manage to land my changed to
push locking down into the filesystem, and then locking/waiting becomes
much easier.


> 
> > I'm looking at dentry_create() which calls atomic_open() is quite a
> > different way to how lookup_open() calls it.  I'd like to change
> > nfsd4 so it calls something a lot more like lookup_open() and in
> > looking at what I would need to change, delegated_inode stood out.
> > 
> 
> Understood. I wish that were a bit less klunky, but I don't see a great
> way to make it so.

We could check for a lease and if one is present then do the lookup
separately from ->atomic_open.  If that finds a match then no create is
needed.  If it doesn't then there is justification to break the lease
before calling ->atomic_open.

This means that when there is a lease on an NFS directory, other apps
have to do a LOOKUP for uncached names before sending a creating OPEN.
Maybe that is an acceptable cost.

Should an O_CREAT open *always* break a directory lease, even if the
name happens to exist?
I note that man/man2const/F_GETLEASE.2const in man-pages.git doesn't
mention directories.

Thanks,
NeilBrown


> 
> Cheers,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 


