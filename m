Return-Path: <linux-nfs+bounces-15578-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CDEC039C3
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 23:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B896A3B1254
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 21:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FED191F91;
	Thu, 23 Oct 2025 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="AHbqozni";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fw+6mKhA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18D93D3B3;
	Thu, 23 Oct 2025 21:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761256159; cv=none; b=TFRb4lu4GTGpCyS65Zwhe/hBt/+3MgmBcJP+jtiPBcv66jXuEOjI4fJl0Cw/T/lcZwLbmjEFfSt0/FIoZGd7fXcSlHuDJ4iyDN6sIgrbJXDWjiR4LqVwKbk1sH8H/J2JZCxTPNTdiXKjC7gmdCWPS6UNMq9FnNPeIpZjXmmk9Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761256159; c=relaxed/simple;
	bh=vOneoA4ryy5ViSNd+B6LZSXF2J63XvrtWlsQCB6+J04=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=k3rYdKoUwannE1OOjd55thIRSTQHE/LkBS6cTQX15PzUIPlS4oibu7drRKMEBn8wpQPAxAMaNQhEHX1LXGuP8KCp5kF4wGO8TfmrH5hoGEUGhz1G+bFxRdt9puXgM6ZVbwjjyItnnRlfuH//j5+25KkjRd9BkzmapVomdVF6B1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=AHbqozni; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fw+6mKhA; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B37747A009B;
	Thu, 23 Oct 2025 17:49:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 23 Oct 2025 17:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1761256155; x=1761342555; bh=GrGPCCIiDORUZ1P11B6Ds8kLfvRBZ/hHZqc
	lA/whSjw=; b=AHbqozni5t5I5m+/OdoZPEY9RyeujnE+5Q5hxZDhIhNTyQkmnTH
	HtKyqn4G8pakYqzEXPYebnQMkrsxAovUxkRdNz1TlAUvUlrckRbL5kEPy9OZosZj
	mVktT2Zfdc7ls1SJIl8WXcaNbOQHl2zfYpUVVcnMQ/GOm9E02jMLAzxHjO+iMUb/
	efNtc+vYdlfJ153E9k+WP/RTc8tD278uVnW/28J2IpzonrF94iCXxBhb9ml7Fdgt
	u1Sf6X6o+hvnVIfdErnugKIMTreQDvCBaYQIkhcAo1i4GxxnsHpG5Qi/XIy4AFDc
	gotzEtVgCOe6s7yRQyE6Ps63Pp+ZzwXwJiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761256155; x=
	1761342555; bh=GrGPCCIiDORUZ1P11B6Ds8kLfvRBZ/hHZqclA/whSjw=; b=f
	w+6mKhApFTw22rye6Al0SfeVOaeUSy0aXKOV+JQBT9MPvjF30OHh9DHqouJjJEjW
	NF/w91kP0TORjLK14/HHSyHmG82REMjc8ZlF7RahUMrCndwi5CU+vPhTmhz3fpoe
	c/YwBpLQKCW+p/98BfYTObst143IEXagHtKvz5Z7dXMyytVZ/qrNvnrIWMdDH35G
	iVJegjK3F/Cj4PnVZ/4vamqveYZBDDYRY0pQiq8TH77UQMd+pHFlJH6JGr996GfI
	27ESgQWxyCppgfaEGvOz0IepzpPcCnjbtkZMWJX+jhTpWGG63lqfjBJN6lYh0Fqp
	q1HpV6X/FMf8Dno0j/gag==
X-ME-Sender: <xms:26L6aA-h8x7m9fNA5I1Rgxkh-ckXWgGPRkm7RMu19_sewVgsw42yag>
    <xme:26L6aLwOuLxyXqDdlsUVyb-ODK9tFFfu9kWXfoteVIxB3k6qoseBeIBltB_BPJKqJ
    Z0-CcBDeSsXXnzCM6bNqO14AZ-P9aTYNMkyA3kkoNqzC4Ty>
X-ME-Received: <xmr:26L6aAoGCbG_SQDOYcCRImGcsdV3JAJvS0Gr1A5UEdt2fjtoGdYH-aujXV_hlB6p_HXIjkYk1xoPu6bTkYW6MrxTmC3ZkX6IVp1fv3DJtL6j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeejheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepohhkoh
    hrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghr
    sehorhgrtghlvgdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtg
    homhdprhgtphhtthhopehtrhhonhgumhihsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsnhhithiivghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:26L6aMoFf5L7oQO29iOUwYBvT4LuTmdQJAWMYb3cbHvdtLOjqKy-Cw>
    <xmx:26L6aABcQZVi8lYe08v5g5SSHxcVXNyvxkb2aee4o4LvUT_cpvxzAg>
    <xmx:26L6aKs87tfvhFZ9kml-nAQxUdUnjxzZg97yZ7-YgWQ7kU5Ees90sA>
    <xmx:26L6aPI4ELwRSzkTDliU0ELUS_GP2JNYd1d9wy4mX0AnWjCRrROhXQ>
    <xmx:26L6aGdcYdbITYT3LM1NKc8inkFx3ziuVkwfFVpPXRIinq5ddHUHDBbx>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 17:49:12 -0400 (EDT)
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
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Mike Snitzer" <snitzer@kernel.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH] lockd: don't allow locking on reexported NFSv2/3
In-reply-to: <20251023-lockd-owner-v1-1-1d196b0183d1@kernel.org>
References: <20251023-lockd-owner-v1-1-1d196b0183d1@kernel.org>
Date: Fri, 24 Oct 2025 08:49:07 +1100
Message-id: <176125614781.1793333.13308972752606421183@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 24 Oct 2025, Jeff Layton wrote:
> Since commit 9254c8ae9b81 ("nfsd: disallow file locking and delegations
> for NFSv4 reexport"), file locking when reexporting an NFS mount via
> NFSv4 is expressly prohibited by nfsd. Do the same in lockd:
> 
> Add a new  nlmsvc_file_cannot_lock() helper that will test whether file
> locking is allowed for a given file, and return nlm_lck_denied_nolocks
> if it isn't.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Regardless of how we fix the bug that Olga found recently, I think we
> need to do this as well. We don't allow locking when reexporting via v4,
> and I don't think we want to allow it when reexporting via v2/3 either.

I would like to see more justification.  The two locking protocols have
substantial differences so it is not obvious that reasoning which
applies to one also applies to the other.

What is the reason that we disable locking for v4?  If we could state
that and justify that the same reasoning applies to v3, then certainly
this would be an appropriate fix.

My guess is that it relates to handling restart of the forwarding server
from the perspectives of both the ultimate client and the ultimate
server.  Restart handling is quite different in the two protocols, but
maybe they are equally unable to handle this situation?

Thanks,
NeilBrown

