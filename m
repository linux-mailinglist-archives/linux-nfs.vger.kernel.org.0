Return-Path: <linux-nfs+bounces-20369-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCOFCJGKw2nJrQQAu9opvQ
	(envelope-from <linux-nfs+bounces-20369-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 08:11:13 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74384320856
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 08:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1322D303298C
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 07:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F983624A3;
	Wed, 25 Mar 2026 07:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="nv2BjE5c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S7AP5C9s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7343537F1;
	Wed, 25 Mar 2026 07:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774422496; cv=none; b=UMar9XF9S/dz0frMImgs9yDv7JGlvUr4fbQIUMe+oZu/6pPjPKud7EsRcsssmXGyemJqH++03yfEyce/aIvAxXdaMGupY/Nuo0TfZgOQIeaW0kNWIRmfcA3EV0OYAvC9nUDs5bPHbSGhwOEsrtsZA/eD04YHr6Si63Jhs6lvvJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774422496; c=relaxed/simple;
	bh=zgjxWS+RhrJIBmIISCNaRGFpIX+HWHmqf8NKfZWo2mI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=aeVKDHEgtTwZfpCMSWc2gsyNo6tjxn2jArDj+dQsNjZzamNnajAVV3xX24JYztQboNodhmi1RqyKajR1EkNIFRIpwHw9jLI4wWF5qc2vN2XVs4EdT6EWgoVFMCJ9/1y0f4cnk2qXel2EUqpmmc+zHbsv6xVVfcJ4EqCMQ2jxeWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=nv2BjE5c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S7AP5C9s; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 787D71D00210;
	Wed, 25 Mar 2026 03:08:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 25 Mar 2026 03:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1774422493; x=1774508893; bh=yDHYE19CFaQ1R6/fwC2mCz5lsesvfQOwcSs
	+b8LO3ho=; b=nv2BjE5cp9DCJInHCFLduVELnhTYa/jfVacFYwB4fUV5xLShMYS
	PDOTz8oNxvcH8SJdZem/hqGPST6SrHT2y6XUPMkWLjxNdDAy377OhRzskNfbxI9m
	5hZeZa7dGT3p0kHxnLM9iTOnJ9indDIQANMjvps7hGw29Q42CWZy+C96A0Su5PeK
	CHDsLBwN13TemTlq6KychN6mD4zz0PUEWozKVwyt4P/uruL5rJL8Cy6rXjPu7Jwm
	9OzmwPmsePEJZPk0gNlZzUQQYVpHo0zF5fVjiFcx0pMWkOVNutqgDOxefPi7x12v
	R4lxLCE4NCYccIvyB/nJJWkfnQvjHKInt9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774422493; x=
	1774508893; bh=yDHYE19CFaQ1R6/fwC2mCz5lsesvfQOwcSs+b8LO3ho=; b=S
	7AP5C9sXtd+P1xNM0F0ZUbH5yIr8xLXqmuspbavDeckTUh4NLJmSVZNtgrzbh+SL
	sQodz4m7Ill8z+aiLyaI8UykVe6K2af+HRqgy+7qT054saWURdUsuUBYV+q1NKYq
	PyYfJA4Z+P7wuHsiLMvbm7Iwi3ARDQkeFiNWFclbEfViFZqjhPQwp0IwHSKre4zD
	ppYcLEBe8vv/4QphEDnD3s02SF/5LQwWRWoURw4Q+QPQklw31MV11GcCFKlNkkFC
	DgmFLWjsQc54c+EVXLMZx6IWBFQZuClDQz6A1o7gRhYxtfoyiASdXDu58GeZMNPd
	GSgwxbarq6C8FnSk1JTSA==
X-ME-Sender: <xms:3YnDabGwNcLWsHzkVvYbfyK8iTP-_Yv5vanwLYEZmi4CgnN-Dtz5qw>
    <xme:3YnDaUU_fy8O0n2lJvNI1-mPqaP5TlBXSXYZAYH3pI_eA38N_mZpM7aN9mhtXNS2v
    mGL3SB7wPI2d8rPib_bxqRxiDdAXPGBGjVzdEZU2FKNZ7RMpA>
X-ME-Received: <xmr:3YnDafU-ZTgndwIwoQXEUdd_d_4pi3cNqNZST6sbkrhPigJbQ2b0HDeN-Lgj-EEjIZKVAlBsz7iDJSUOVEVy_6BLG9flPNOaG_sgvDf9AlR8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdefkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudefueefheejhfeuhfehvdfhgeeulefgfeehffekffduvdettdelheeftdethfdvnecu
    ffhomhgrihhnpeguvggsihgrnhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgrsghlvg
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfhhssehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhh
    grthdrtghomhdprhgtphhtthhopehtjhdrihgrmhdrthhjsehprhhothhonhdrmhgvpdhr
    tghpthhtoheprhgvghhrvghsshhiohhnsheslhgvvghmhhhuihhsrdhinhhfohdprhgtph
    htthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvghlsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopeduuddvkeekiedusegsuhhgshdruggvsghirg
    hnrdhorhhg
X-ME-Proxy: <xmx:3YnDaaLMO6xat5ypM4si0ppgdUPRI4fIo1iPi4K4lpBlRrG7fxOlVw>
    <xmx:3YnDafCBxbc4sQPLkaOOUXZK2GiN7NQmbenx68Q_2siWwB3HEYcjNw>
    <xmx:3YnDaaeooqj0HGI2iBQVbCFT8HLaNshPysGhRJbimInceEPPAq9wzw>
    <xmx:3YnDae0IPL41gf9aKm_ojn65Sg-juPaN8XRO1wWaFaEdJ2ECAEDszA>
    <xmx:3YnDaZVoSAXHqNiaewSzZco6CaquCW4o4vbNaGw5aWx3womiOLxc9QvQ>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 03:08:10 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Thorsten Leemhuis" <regressions@leemhuis.info>, 1128861@bugs.debian.org,
 "Tj" <tj.iam.tj@proton.me>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <okorniev@redhat.com>, stable@vger.kernel.org
Subject:
 Re: [PATCH] lockd: fix TEST handling when not all permissions are available.
In-reply-to: <d4773958-5ae5-42d4-b785-6598b5c9b27a@app.fastmail.com>
References: <c0f15088-3fc0-487a-9f24-cf89c158420d@proton.me>,
 <177266540127.7472.3460090956713656639@noble.neil.brown.name>,
 <6ba41798-9c69-44f5-9a4e-09336c75a4b9@leemhuis.info>,
 <cf78feb7ffaee6ed478afb734d2ede149597de86.camel@kernel.org>,
 <177434721528.7102.13514118512738778346@noble.neil.brown.name>,
 <d4773958-5ae5-42d4-b785-6598b5c9b27a@app.fastmail.com>
Date: Wed, 25 Mar 2026 18:08:07 +1100
Message-id: <177442248735.2237155.773724155681455344@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20369-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:dkim,proton.me:email,messagingengine.com:dkim,brown.name:email,brown.name:replyto,noble.neil.brown.name:mid]
X-Rspamd-Queue-Id: 74384320856
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 25 Mar 2026, Chuck Lever wrote:
>=20
> On Tue, Mar 24, 2026, at 6:13 AM, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> >
> > The F_GETLK fcntl can work with either read access or write access or
> > both.  It can query F_RDLCK and F_WRLCK locks in either case.
> >
> > However lockd currently treats F_GETLK similar to F_SETLK in that read
> > access is required to query an F_RDLCK lock and write access is required
> > to query a F_WRLCK lock.
> >
> > This is wrong and can cause problem - e.g.  when qemu accesses a
> > read-only (e.g. iso) filesystem image over NFS (though why it queries
> > if it can get a write lock - I don't know.  But it does, and this works
> > with local filesystems).
> >
> > So we need TEST requests to be handled differently.  To do this:
> >
> > - change nlm_do_fopen() to accept O_RDWR as a mode and in that case
> >   succeed if either a O_RDONLY or O_WRONLY file can be opened.
> > - change nlm_lookup_file() to accept a mode argument from caller,
> >   instead of deducing base on lock time, and pass that on to nlm_do_fopen=
()
> > - change nlm4svc_retrieve_args() and nlmsvc_retrieve_args() to detect
> >   TEST requests and pass O_RDWR as a mode to nlm_lookup_file, passing
> >   the same mode as before for other requests.  Also set
> >    lock->fl.c.flc_file to whichever file is available for TEST requests.
> > - change nlmsvc_testlock() to also not calculate the mode, but to use
> >   whenever was stored in lock->fl.c.flc_file.
> >
> > Reported-by: Tj <tj.iam.tj@proton.me>
> > Link:  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1128861
> > Fixes: 7f024fcd5c97 ("Keep read and write fds with each nlm_file")
> > Signed-off-by: NeilBrown <neil@brown.name>
>=20
> Hi Neil, which kernels should this fix apply to?
>=20

v6.13 and later. So linux-6.18.y and linux-6.19.y

The Fixes: tag is actually wrong.  This bug has been present forever.
However a different bug that=20
  Commit: 4cc9b9f2bf4d ("nfsd: refine and rename NFSD_MAY_LOCK")
fixed was hiding the bug.

So it should probably be marked
  Fixes: 4cc9b9f2bf4d ("nfsd: refine and rename NFSD_MAY_LOCK")
with an explanation.

NeilBrown

