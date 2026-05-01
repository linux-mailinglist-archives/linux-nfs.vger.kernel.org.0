Return-Path: <linux-nfs+bounces-21323-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFeHH9YF9GlW9wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21323-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 03:45:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F244A9AF3
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 03:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA5CA300EAAA
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2026 01:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0637F19DF62;
	Fri,  1 May 2026 01:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="of2rTx+g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PyPgwvvA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B134440DFC5;
	Fri,  1 May 2026 01:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777599954; cv=none; b=uRqLBP/En2W4g+IdKisI3rbEbb+zrN1sTlbkj9CS0gWuQjVbQpyG4K0UBgC2bwY26TgXkm8xEYz9cRIHG2kYf8A+XRpkVHShRM0wO5UjRmjAPfv+eYDcKlfkV2j3OcN30xx37lWw5s/V6YjaFsE3hUdQJ04Gwql3HSlYgFssaAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777599954; c=relaxed/simple;
	bh=zEN2P2tJK2cUtMvg3p3zwT3dj9PVWW1FRCqgHS2YWBo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=C7ZSuGxAin81i2s9tM+6jwPpLYhVr9d2Xj4H7K1FMnxuJMIcj9HrDOv9W8n48ZDpJ748i7UG3m/FwcTgVq5ofdLi7AsGCVPFsyBKaV5Bf2kWw+nhliM8Oyts9mQDxynmn/82N63bJJDyd+HLGv51hgFF4yZPs+TTV0xhhF6TsOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=of2rTx+g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PyPgwvvA; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AD7F77A0106;
	Thu, 30 Apr 2026 21:45:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 30 Apr 2026 21:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1777599952; x=1777686352; bh=gQDZMNpELtcA4ElR5Dvaagz2/DdZVFyVL0R
	0Elv/XOg=; b=of2rTx+gXtH4PNSYINo6oU5fAv5ZyVlDzriicSo5CvsC4uHUI4t
	z71NSObuCc9Mv7klURao5G5IAAgL/Nj//4/Xa3U75aJHIATotTbi1jJ44hExB2Jo
	+dFphn2DTq/xXzaRh5NDk8sPaG3U7zebqTZA3hkT7B4hgrJAhr4qQPIvRlmET4TL
	jDQqbK50EEMfi3jlrmZ/yIgWQMph3wxpEZ2GsrmpCBdxHqKQz+ACIFOLIOJ219pP
	vyiHI3GJDR6fnpwCH9zXjCnhK/Bo0OMgcPelytEBcl+DBVal7DNHRY8pbQv7Jp5b
	ZL/EbjAXl3NaYzMKoEc8lBAtNfhN22oFcJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777599952; x=
	1777686352; bh=gQDZMNpELtcA4ElR5Dvaagz2/DdZVFyVL0R0Elv/XOg=; b=P
	yPgwvvAuWU66S99HUN7gC2NCr8OifsD1bwDr/kD0/l54JaXXY2UZi9pgnIg4T2vC
	LJ7xD3EE+6UO0u4W8LxaWdYsfiR2AvlqYHfPyO45btTF4IKFqnf3o+opSghIpYg+
	IC8Yd2zmmrZcip0DhLy8+rpSCcYqPDQ11EooKkdFfKuRIYDZCX8K78uNosfviQtX
	gwjQ17irSyvlhtXT4HxIBF2hLOsUuDEUW8wYdUW1BqiBxulOHdLFONujQd+aHfy5
	7MDrl3BNpOaMTC88wazjlQUBDZ0cgWuO/bZqTM1G+oB5iFdfH1nj/XjYCoku5WSq
	ggbKurHBAjiSBhp4M9M7g==
X-ME-Sender: <xms:zwX0afRj_M3RMrBvKeakWrIOE3Cg0x9FfuRv2icuknS5kEK_LxLYQg>
    <xme:zwX0adGQteAJA-cDWe1wnCx_U3JDvJ7vBdZdzoXDZE_qdRfrQpr_xumVBvt-tKVjX
    hKFY1kWKe7-HFYLzneSKYxE8T6h7otWgLbmKYK3MEGn6YUKKg>
X-ME-Received: <xmr:zwX0aWcRDEZHI3ViB7kpvGfEbW3Ar5B58lgvWAXn7GI9S7ye9MrgeV-H0QFqY1tDO90lX83kvZDHbyBwyvHxaBVRoRL7ALw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekkeeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhgrtg
    hksehsuhhsvgdrtgiipdhrtghpthhtohepjhhksehoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:0AX0acKx_lC5jwgFr3OP-6qgNjk9_8CrQxAEqyckQ6gM1gDQY1BhXw>
    <xmx:0AX0adqX3y23IqAmNI0SX0VDKBIRa-mzTw42nqS2lO2auGuPePbN0g>
    <xmx:0AX0aaVcP5ZDfLKFO6ryRJKiov58qJc5CY_swgCvl2ERFpTUl1G10Q>
    <xmx:0AX0aQ1jEnGPpv-yIR258zmKmJ307F5ThLYutVTZuPyr4dnBXWzdpg>
    <xmx:0AX0aSh-NrHx9cMVamO0-beGKPpRJGcJHB69kBQQFEcXDQLY2hRqz-A4>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 21:45:47 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Jeff Layton" <jlayton@kernel.org>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Miklos Szeredi" <miklos@szeredi.hu>,
 "Amir Goldstein" <amir73il@gmail.com>, "Jeremy Kerr" <jk@ozlabs.org>,
 "Ard Biesheuvel" <ardb@kernel.org>, linux-efi@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/19] VFS: use wait_var_event for waiting in
 d_alloc_parallel()
In-reply-to: <177759959922.1474915.14496442965390503813@noble.neil.brown.name>
References: <20260427040517.828226-1-neilb@ownmail.net>
  <20260427040517.828226-5-neilb@ownmail.net>
  <20260428033738.GV3518998@ZenIV>
  <177737511992.1474915.1952404144121931523@noble.neil.brown.name>
  <20260428142225.GX3518998@ZenIV>
  <177741881482.1474915.12527082398060370192@noble.neil.brown.name>
  <20260429052626.GY3518998@ZenIV>  <>, <20260429170731.GZ3518998@ZenIV>,
 <177759308866.1474915.9708613530229799376@noble.neil.brown.name>,
 <20260501011132.GA3518998@ZenIV>,
 <177759959922.1474915.14496442965390503813@noble.neil.brown.name>
Date: Fri, 01 May 2026 11:45:45 +1000
Message-id: <177759994594.1474915.12208704330740243979@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Queue-Id: B6F244A9AF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21323-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,suse.cz,szeredi.hu,gmail.com,ozlabs.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCPT_COUNT_TWELVE(0.00)[16];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:dkim,brown.name:replyto,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,noble.neil.brown.name:mid]

On Fri, 01 May 2026, NeilBrown wrote:
> On Fri, 01 May 2026, Al Viro wrote:
> >=20
> > Let's deal with d_alloc_parallel() first; it doesn't have to be tied
> > into the rest of patchset.  Does the variant I've posted + s/dentry/targe=
t/ in that
> > call of __d_wake_in_lookup_waiters() trigger any problems in your testing?
>=20
> I'll let you know.  Still building at present.

generic/467 now passes repeatedly.  I'm running the full set now.
Shall I post the patch once all the generic/ tests pass?  Or will you
just use what you already have?

NeilBrown


