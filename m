Return-Path: <linux-nfs+bounces-16221-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2171C4486B
	for <lists+linux-nfs@lfdr.de>; Sun, 09 Nov 2025 22:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7013AF9D1
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Nov 2025 21:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A17E2253EC;
	Sun,  9 Nov 2025 21:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="NllzbFc4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u1kfbyDq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF592230D1E;
	Sun,  9 Nov 2025 21:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762724755; cv=none; b=HVyZC7H3Urqm/j9BaRVe2K+kT+OOLMyP35tlVaxG4InWLfZjvyWyUvu6uGcilGITOr7O9LrReihyAvN3qCv6SwT3BZC3pvQElBLntAQ7KapW0iOy1VwwmEXaS864n0lXAW/tCdQzhsVZEd/QQgoe8+okAxQdw8kKD6J0DEkffhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762724755; c=relaxed/simple;
	bh=NnU2ufvvXI3MqSpcDavGPmCFQwyXOWgTa2I4APeHvIg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=FmffHqfZem+Ew76Bb0kw5Z8Jg/kzJFGeZ5UXbbY+wW4Fffxlatxhk6HEam1PQIWykINbAdHMmvwBjchSb5AS1i9Al2PpDSnn0+c9ldxddE5ybVGzOnW/3CRIjEAP9kXmmRXtYfMpM5Qa7VEJeXOhizFbaVfnBIiTY753cPOWfsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=NllzbFc4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u1kfbyDq; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8FEC07A01A5;
	Sun,  9 Nov 2025 16:45:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 09 Nov 2025 16:45:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm3; t=1762724750; x=
	1762811150; bh=liT/yxyFJ1Z6XtTqp7drM158Idp6SJXcN45Rd6moEIw=; b=N
	llzbFc4X0slEjHthDJ9vEAHAAXYYmaz2EccBCgJMV5nBoJku54dgNfVtfhDdjAor
	PYyEem+8x55l+iLJ1OmFnx8m9JqaAiq9jcxmmXbDA8oIaZjWlHD9Gp7N6jUkeoLx
	7dXRGu0kR27BAX/qTVUApyhiHZMWuoxld0r0C1LFGo3TClFQhJBBN3N5HIjMka49
	40Ztcz03HQtVpamyCdNp+gybnAhGDP2PqGv37Sup5qBIBDs9Gn4L6YK89SDXTBjL
	T5dOQF+j4AWFgiArPMvrURC+bDd69Lt7yi/s5XfnKISozMdwCEI6LZpDfmb7tIf4
	ndqmC1R8afs4sXbQCs7BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1762724750; x=1762811150; bh=liT/yxyFJ1Z6X
	tTqp7drM158Idp6SJXcN45Rd6moEIw=; b=u1kfbyDqv5szocPqclZJhld5cFb06
	n0Z/Qf5uEQdFgB0oVTfiFbD6Nmr33wnJd7z/b086+525Lpc58YiUZSgLStLvRgPD
	mL20XP3dDAxsY9BBZwOD67ZnEXDToX11eMDtdZeXDkUzW9/Uc/MGDDQRnJSllJkj
	QdJZfGKz9phUBpUrbHdpzTtYqnRRCztBVf5KAH9HmcjON0lFGSTcmQXqgbNFDljn
	ddfQp4c6U7PGyuyCAyo7n2toyEJlU0fBgSUcCbgdb8p2r8CASLxtIdhN5WTAWxQS
	bgoqqx+5spnaw9sjBj42DgQRCBmPV8d8ILijm02I4h7vZe5pQxzbky82A==
X-ME-Sender: <xms:jQsRaTdFVzOX_M8guSRt0HRmRhIOFv6Zx7EhMW_KaVU7fUbUIqWGag>
    <xme:jQsRaTRCWRdDe2saA-Sz5bm43YR0OFJ9kIii0cxN7UVJOW0p41scTX6I3WNuIf6nW
    svKCnXopZ85YIaJPDhf2fpnSuaXeBoj5FbF1CkjXZrOgmMMmug>
X-ME-Received: <xmr:jQsRacZDRrb4PNblmfZofdrJvcAEqA0j0tOLolW1zBanjg_nun65buXYR6wvjzxPaauT3epjsggcx1vhBb1JVdrN4tN7hFoGIaq8zqyKikVF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeiheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheurhho
    fihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhephe
    euhfffkeejvdeuhffggeetteekfffgteehiedvfffhteeiveeitdehgeffuefgnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgrsghlvgesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhr
    rggtlhgvrdgtohhmpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtih
    honhdrohhrghdprhgtphhtthhopehsphgvvggutghrrggtkhgvrheshhhothhmrghilhdr
    tghomhdprhgtphhtthhopegurghvihgurdhlrghighhhthesrggtuhhlrggsrdgtohhm
X-ME-Proxy: <xmx:jQsRaWe6v3k5pOnLflG-GsUGkJdw5mi3Amv6srU8B3cZDLiX2fKCGA>
    <xmx:jQsRadKlm9TyZOswhnPNA9pVQtEyph7AtL9T09aGJ6BZkNXcSfznlA>
    <xmx:jQsRaTJkwcslmJLiXNU2IxpUmuWlt6CpeHvOZMHt_tUDDwjS2HHhIw>
    <xmx:jQsRacUjs2NGkwf9SbvioLTxAWxUNSGIBtxOocRy6HrS9Envu8Fc9w>
    <xmx:jgsRaRIBnPS7FzaVDZ9grzVKGWuRHUGcwWLmx1mEVPtMghAZeJuq4B2g>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Nov 2025 16:45:47 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Laight <David.Laight@ACULAB.COM>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 speedcracker@hotmail.com
Subject: [PATCH stable 6.1.y] nfsd: use __clamp in nfsd4_get_drc_mem()
Date: Mon, 10 Nov 2025 08:45:35 +1100
Message-id: <176272473578.634289.16492611931438112048@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>


From: NeilBrown <neil@brown.name>

A recent change to clamp_t() in 6.1.y caused fs/nfsd/nfs4state.c to fail
to compile with gcc-9.

The code was written with the assumption that when "max < min",
   clamp(val, min, max)
would return max.  This assumption is not documented as an API promise
and the change cause a compile failure if it could be statically
determined that "max < min".

The relevant code was no longer present upstream when the clamp() change
landed there, so there is no upstream change to backport.

As there is no clear case that the code is functioning incorrectly, the
patch aims to restore the behaviour to exactly that before the clamp
change, and to match what compilers other than gcc-9 produce.

clamp_t(type,v,min,max) is replaced with
  __clamp((type)v, (type)min, (type)max)

Some of those type casts are unnecessary but they are included to make
the code obviously correct.
(__clamp() is the same as clamp(), but without the static API usage
test).

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220745#c0
Fixes: 1519fbc8832b ("minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test i=
n clamp()")
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4state.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 08bfc2b29b65..d485a140d36d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1822,8 +1822,9 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs=
 *ca, struct nfsd_net *nn
 	 */
 	scale_factor =3D max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
=20
-	avail =3D clamp_t(unsigned long, avail, slotsize,
-			total_avail/scale_factor);
+	avail =3D __clamp((unsigned long)avail,
+			(unsigned long)slotsize,
+			(unsigned long)(total_avail/scale_factor));
 	num =3D min_t(int, num, avail / slotsize);
 	num =3D max_t(int, num, 1);
 	nfsd_drc_mem_used +=3D num * slotsize;
--=20
2.50.0.107.gf914562f5916.dirty


