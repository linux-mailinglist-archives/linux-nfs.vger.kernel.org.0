Return-Path: <linux-nfs+bounces-20440-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHK0HZ+1xWnEAwUAu9opvQ
	(envelope-from <linux-nfs+bounces-20440-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 23:39:27 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4522C33CA03
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 23:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC824308FA98
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 22:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE86133D503;
	Thu, 26 Mar 2026 22:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ZFPY8DVt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JK2V5cuJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A62329E49;
	Thu, 26 Mar 2026 22:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774564405; cv=none; b=PV0FDdPQmPY7dVs9i7CEWVSMK67KjUSlxO5Bifnrv0wpF4tKnclDVxtaDN4EQNXAGDKSVLiGGpKxZED9Z9jAm8xMrmPoCKdyIP+32Pp/hm2JHGGN8qDYoFmWKb/FHKuDakep/Exd9g8HlAXhxlyovo5kai2OoHIYHn8AqaO177E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774564405; c=relaxed/simple;
	bh=dvT0QjqTxSglOG0YLmRiHgenY55/5qto9Am1f/wHY18=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=t64DFyr0Q9d5C7z6FeWL3tZsLyrPP7uuL+v0sNvIadcdUZBHpZrrK37gmuf0d2j5/gntHFfO6y3oDmNmng586xVVrKz8muqtWew7HSkKNfEY9GKRkNj4wQg7fEDdcrlJ/ltSFdjo0zd11YYGx+RE72SwOhhywiTxDbx7G7VgtqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ZFPY8DVt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JK2V5cuJ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id CE53CEC0204;
	Thu, 26 Mar 2026 18:33:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 26 Mar 2026 18:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1774564403; x=1774650803; bh=PkYlU33uHlNKB92F0bwzHy7Iv/+QCbIt8IO
	K7/s9obA=; b=ZFPY8DVtNlteRQSL2gULrhj8qFzNaEy3p6Us9Fw1cV1/FMMMjrD
	jCpuk80POksqXv9GrnDcBVxIcdjUprFtDv/i/CuzViY8y8a0gOb0MN59v8+TL0XH
	G/pljyqWab+BMe+j1/5EoMU6ri5NNNErQ0suiJHsiOUVRK3wCvoXW2N+jHfcm8pd
	D7XJ/x7sQ8isBuZdjRv9Qhvu4zGnVmha1A8PkMBnspqnFIDr9HuXx/Or6LMRoApL
	70LTnuVg0yNBkYQ415bd1aCEbvEeweAM9pCdhLAZAocOiiA7IEtwBRpa4bwUn0gQ
	0Sjo452iAonQxmV8v7p9UEfNw1ebPoivBDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774564403; x=
	1774650803; bh=PkYlU33uHlNKB92F0bwzHy7Iv/+QCbIt8IOK7/s9obA=; b=J
	K2V5cuJVz6Xy+p9Vwn0r7gG95ri4s3vgmMkOpKREfPVdQvh8bIgTm/2XnBNRhWD/
	H7GDyAeFebGCxsNmTWOh40e2P2MaWzpdRLqDVYUHSRxrrTbanOSmUMfDvqawLOMd
	Z86TzNNMEmzFVPZS4lUM39UOgOPW4bRJTM/HzX2cradn2yWWDvMMO30pAKHzia4T
	MVQVpgElV0Vu8Q44tq4MSXDk3p9O/7BdxZOKRdvUVRQZ2luZMRpAfRpH3ZtSmHpf
	Z4CieoZ3JI/oyUsVbyev8WKSvaup80iKnE8FjTekkPCUpMlBVdesBB+tMGkaEOuV
	VvN97i5V4DtzoPnxO+0Hw==
X-ME-Sender: <xms:M7TFaXd5RVlN8kl2WhwZfJqwJ5jdbrT3V6TUAhDAMSAJ2deODw2MwA>
    <xme:M7TFaZOfIXqterc8X0dNRB-Akt0jyJfHbWaXS5ALLnzzBtAbq12F78RDI6Ueu9FHO
    ntBwqYiWSf6_qiNsc3uspCsDQ1GCM4zSTBOS-OY_SSx_ZKkzQ>
X-ME-Received: <xmr:M7TFaStU9k1XrD-8-aaXOQaMVNqwwGk-LthWH2AAF4pQuyoIZw57EotjvNwYi4OmJWy_r8uMtxohNs3f9FfqX88Ebi_dgZc36Becg8p6oHwG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekiedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:M7TFaaBY2JUU9buWBwHKWJ9DLeZJ6qL6aj3QONhgTBLSyuZzXWE_3w>
    <xmx:M7TFaRZRWycSSBHxiNy7QRS10YE6r0cfwtZUkWznhMaFPaH8DXLpfg>
    <xmx:M7TFadX_j67eGkvQmW54dq1ImxB7dwDdwH0ceA72xtlIlx5G0tGfjg>
    <xmx:M7TFaYN7BcOG9byuWgi0TrFdBQhEFqgTdWvbrPpKhgyRRe_xLw95-Q>
    <xmx:M7TFaauyDN2YZtmoSljf0XgXE2O9My3dWyZ8f6YOeSUZy3cZbncR0g4b>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 18:33:20 -0400 (EDT)
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
In-reply-to: <a6e6a731-2885-4510-87dd-45e6a8f4fbd7@app.fastmail.com>
References: <c0f15088-3fc0-487a-9f24-cf89c158420d@proton.me>,
 <177266540127.7472.3460090956713656639@noble.neil.brown.name>,
 <6ba41798-9c69-44f5-9a4e-09336c75a4b9@leemhuis.info>,
 <cf78feb7ffaee6ed478afb734d2ede149597de86.camel@kernel.org>,
 <177434721528.7102.13514118512738778346@noble.neil.brown.name>,
 <d4773958-5ae5-42d4-b785-6598b5c9b27a@app.fastmail.com>,
 <177442248735.2237155.773724155681455344@noble.neil.brown.name>,
 <a6e6a731-2885-4510-87dd-45e6a8f4fbd7@app.fastmail.com>
Date: Fri, 27 Mar 2026 09:33:18 +1100
Message-id: <177456439801.1851489.13361466107404119184@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20440-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,brown.name:email,brown.name:replyto,proton.me:email,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 4522C33CA03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026, Chuck Lever wrote:
>=20
> On Wed, Mar 25, 2026, at 3:08 AM, NeilBrown wrote:
> > On Wed, 25 Mar 2026, Chuck Lever wrote:
> >>=20
> >> On Tue, Mar 24, 2026, at 6:13 AM, NeilBrown wrote:
> >> > From: NeilBrown <neil@brown.name>
> >> >
> >> > The F_GETLK fcntl can work with either read access or write access or
> >> > both.  It can query F_RDLCK and F_WRLCK locks in either case.
> >> >
> >> > However lockd currently treats F_GETLK similar to F_SETLK in that read
> >> > access is required to query an F_RDLCK lock and write access is requir=
ed
> >> > to query a F_WRLCK lock.
> >> >
> >> > This is wrong and can cause problem - e.g.  when qemu accesses a
> >> > read-only (e.g. iso) filesystem image over NFS (though why it queries
> >> > if it can get a write lock - I don't know.  But it does, and this works
> >> > with local filesystems).
> >> >
> >> > So we need TEST requests to be handled differently.  To do this:
> >> >
> >> > - change nlm_do_fopen() to accept O_RDWR as a mode and in that case
> >> >   succeed if either a O_RDONLY or O_WRONLY file can be opened.
> >> > - change nlm_lookup_file() to accept a mode argument from caller,
> >> >   instead of deducing base on lock time, and pass that on to nlm_do_fo=
pen()
> >> > - change nlm4svc_retrieve_args() and nlmsvc_retrieve_args() to detect
> >> >   TEST requests and pass O_RDWR as a mode to nlm_lookup_file, passing
> >> >   the same mode as before for other requests.  Also set
> >> >    lock->fl.c.flc_file to whichever file is available for TEST request=
s.
> >> > - change nlmsvc_testlock() to also not calculate the mode, but to use
> >> >   whenever was stored in lock->fl.c.flc_file.
> >> >
> >> > Reported-by: Tj <tj.iam.tj@proton.me>
> >> > Link:  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1128861
> >> > Fixes: 7f024fcd5c97 ("Keep read and write fds with each nlm_file")
> >> > Signed-off-by: NeilBrown <neil@brown.name>
> >>=20
> >> Hi Neil, which kernels should this fix apply to?
> >>=20
> >
> > v6.13 and later. So linux-6.18.y and linux-6.19.y
>=20
> Assuming that includes upstream, I recommend that I take this
> into nfsd-testing / nfsd-next and let nature, ah, er, stable
> automation, take it's course.
>=20
>=20
> > The Fixes: tag is actually wrong.  This bug has been present forever.
> > However a different bug that=20
> >   Commit: 4cc9b9f2bf4d ("nfsd: refine and rename NFSD_MAY_LOCK")
> > fixed was hiding the bug.
> >
> > So it should probably be marked
> >   Fixes: 4cc9b9f2bf4d ("nfsd: refine and rename NFSD_MAY_LOCK")
> > with an explanation.
>=20
> IIUC, we want Fixes: to point to the commit that introduced
> the issue (Fixes: since forever) and then use a "# v6.13+"
> comment on the Cc: stable to control how far back to backport
> it.
>=20
> Commit message could mention that 4cc9b9f2bf4d uncovered the
> issue.

What you suggest is correct in a pure sense (and I like that) but as Ben
points out, it will miss older kernels that have backported
4cc9b9f2bf4d.
We know which kernel.org kernels that includes, but not what other
organisations might maintain for their own purposes.

So I think we meet the needs of automation best by saying:
  Fixes: 4cc9b9f2bf4d

even though that didn't introduce the bug but only expose the bug.

NeilBrown

