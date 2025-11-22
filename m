Return-Path: <linux-nfs+bounces-16673-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AFDC7D7A7
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 21:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E04FB343880
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 20:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315E81F5858;
	Sat, 22 Nov 2025 20:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="KwFs8DZi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="001L70i9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E81D21C9E5
	for <linux-nfs@vger.kernel.org>; Sat, 22 Nov 2025 20:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763844517; cv=none; b=QurgGn/sWu3iIl95jeqJpLJNaqaCsTG8/VgHpohzNQipq3fqFxwNYiLlPg3NWuMfp+5v/vKJVo3jp75uOQRY4INN/WEaQOGrURpgO4wjLROxgn+tZKJPr6dEz4YB6KGWU+1vRBQuwa4vqiw227BpzuyFdfF9pA7N44dDarEZKKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763844517; c=relaxed/simple;
	bh=Jtu3q+VEcIIvGlKxdxaQakDd3e3oFG6EzIMbnWT3s/0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=tXa3UJ9+xRgMilHO3bR6PpyqwNDtoo2cistReKA8wgLQDotct2gkcwAqfsyXkCM2pUy7AF8dxFNDmLYPIKQIDchzI4H7heqwSRWkLOxkx138+b+fp1kRAS3C6q3QfOmzM1XOP2ND9OJdPG46k5XYk2wrHkfcVDfjiNen2pbECvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=KwFs8DZi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=001L70i9; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 9CBE6EC014C;
	Sat, 22 Nov 2025 15:48:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 22 Nov 2025 15:48:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1763844513; x=1763930913; bh=534dAUnMuWV1LQ/ehBekDc0zrNK1kyIogKY
	qAF8HpUM=; b=KwFs8DZidI5MWufiQpnHfAcN39FtyQ54YBDCs9BUoLN4293mJeT
	QzONiJbauNrYiqZDI4YBqnS2zqIkk+kYYPxZHaYpSGUAj7amPhpqUKjsYEBBLB3+
	bzjBtE5ZxPPfv4zRM1gyAe3bVNVgHbhLgJnjHEzesYkhXRU0CV7ddCK9sW8fWpfN
	q2AdpouZG+8wBx6zfy3Tz7hLOC8kzYtHLk3ZYRVC7QDZseJ/x2j/C198FmE7Rj2O
	PscQTm6XTrV6uGcrOZoHtDC4Cm5Xv7lWp8vRpSTuTZV23ix6eQLaGZOseDUwTTyp
	iHFUIBpeM2OCyxskeSSRlEbzsw2BKVOZNIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763844513; x=
	1763930913; bh=534dAUnMuWV1LQ/ehBekDc0zrNK1kyIogKYqAF8HpUM=; b=0
	01L70i9Zr1VVfoC6L4CBw1JFlwbjachyjTAfK9ZRI2bchCUOxoXe/MOgSR6LMxsU
	WhAqBM4yJ3jxxs1E5V9ZD83NUMIDkQAnGLi4mY+G1gvrRg89sTU79LSyNjcsbOZS
	AhJgqRj9l+mBWfDjVDOkvzPHmlgP9zIuntmzTmVOYnqbsTrXf2/DZf71tMhMLTfA
	JnMQie/lDZcCbYJl4pQPDcyB/thn/+faMZAncdE0nqBQ6CwEFiyGaL04+EfYCa4f
	LWK8cV8U7RHoaMJ8EmhZ3SYC/ySmpnOnYstZnRB3yETOS8RCBvNt6NqpZDzvGeEs
	Fkiogpuld672dQgyaLEzw==
X-ME-Sender: <xms:oSEiaePhyLD0328vgevM9sTnAAB4zzgGYwaMEr3gApyNb7-7P8tm5w>
    <xme:oSEiafMjjNYJR77Ho6QcB3ZZ5UNeUjdSgJGf0WvQ0ls1yFRZOkj8anwA_10bvtN8G
    l7quEy6MyAs_kDmSdb8d0UsEpj2vBOQ-Fk-tu_xsiEB1Gxm4Q>
X-ME-Received: <xmr:oSEiaXh8PwtnI6zbgmAUWXJC_HvgRV-aCGrf777PNjPEqa2pRLt-yX5vGn220Dpmx1yKMrp2WTKF68p_8a2YCn19vChLbYYUTS2hFPS0A0Wj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeefkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvdeuteelkeejkeevteetvedtkeegleduieeftdeftefgtddtleejgfelgfevffeinecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqd
    hnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhomhesthgrlhhp
    vgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprh
    gtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthho
    pegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhutghklhgvvhgvrhesfhgrshhtmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:oSEiaUs9KzH6iZr94l6JP2WUD9aMUDSZ0eyMXE7_PiQdoMoFNb6zBw>
    <xmx:oSEiaVRPU5s1sB1yMIFcoWvHe8YbaaxAxYUwns9MT5njwHD_lcTpTw>
    <xmx:oSEiaY2ee0fGBhuatwclQQ4J_7645upht6OeQo6v5xc4V_hYGl5BwQ>
    <xmx:oSEiaauL62NoYk1s4r6SxjuoTQ-4pdT8evyvIdg4gcHeCqqaX4jhww>
    <xmx:oSEiaeTfFJgZkSfeEEvLC_loySo7WlcVi08DSRVZKcjPTVvzRWfRRYIV>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Nov 2025 15:48:31 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <chucklever@fastmail.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] lockd: fix vfs_test_lock() calls
In-reply-to: <6149cfe6-3546-4f71-9da4-7cac12e09116@app.fastmail.com>
References: <20251122010253.3445570-1-neilb@ownmail.net>,
 <20251122010253.3445570-2-neilb@ownmail.net>,
 <6149cfe6-3546-4f71-9da4-7cac12e09116@app.fastmail.com>
Date: Sun, 23 Nov 2025 07:48:26 +1100
Message-id: <176384450696.634289.131833962229924725@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 23 Nov 2025, Chuck Lever wrote:
> On Fri, Nov 21, 2025, at 8:00 PM, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> >
> > Usage of vfs_test_lock() is somewhat confused.  Documentation suggests
> > it is given a "lock" but this is not the case.  It is given a struct
> > file_lock which contains some details of the sort of lock it should be
> > looking for.
> >
> > In particular passing a "file_lock" containing fl_lmops or fl_ops is
> > meaningless and possibly confusing.
> >
> > This is particularly problematic in lockd.  nlmsvc_testlock() receives
> > an initialised "file_lock" from xdr-decode, including manager ops and an
> > owner.  It then mistakenly passes this to vfs_test_lock() which might
> > replace the owner and the ops.  This can lead to confusion when freeing
> > the lock.
> >
> > The primary role of the 'struct file_lock' passed to vfs_test_lock() is
> > to report a conflicting lock that was found, so it makes more sense for
> > nlmsvc_testlock() to pass "conflock", which it uses for returning the
> > conflicting lock.
> >
> > With this change, freeing of the lock is not confused and code in
> > __nlm4svc_proc_test() and __nlmsvc_proc_test() can be simplified.
> >
> > Documentation for vfs_test_lock() is improved to reflect its real
> > purpose, and a WARN_ON_ONCE() is added to avoid a similar problem in the
> > future.
> >
> > Reported-by: Olga Kornievskaia <okorniev@redhat.com>
> > Closes: https://lore.kernel.org/all/20251021130506.45065-1-okorniev@redha=
t.com
> > Signed-off-by: NeilBrown <neil@brown.name>
>=20
> At a guess:
>=20
> Fixes: 5ea0d75037b9 ("lockd: handle test_lock deferrals")  ??

I think the problem is, in practice, more recent.
I think there is only a problem if the filesystem that lockd is
accessing sets fl_lmops on locks.

So maybe

Fixes: 20fa19027286 ("nfs: add export operations")

>=20
> I suspect this also needs a Cc: stable.

I think that would be appropriate - yes.

NeilBrown

