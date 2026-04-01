Return-Path: <linux-nfs+bounces-20583-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HKJCuIhzWlZaQYAu9opvQ
	(envelope-from <linux-nfs+bounces-20583-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 15:47:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3014237B812
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 15:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A66A2309774F
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Apr 2026 13:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD50429802;
	Wed,  1 Apr 2026 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUrVP3HD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5794242882D
	for <linux-nfs@vger.kernel.org>; Wed,  1 Apr 2026 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775050468; cv=none; b=mwHFxiyK9Vt89ONIUE8QRUyrAeu945sPpWOWe4hHNtUJAnoQI8oyKikdc1Rv0+j/SNDlIcsUsjreBEDknWV3T+/7Ic7+eeSeCuhzxND/m13iww17nx8d2cUvik0Jam9AivvmXTqNNzYr8PS2hrF1W0CD404hAhV2QvDaUCokXZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775050468; c=relaxed/simple;
	bh=ZgUeRnpR4DATl3Sbw883f5UTNjMmFhqtg9CURPQiQXM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sNUTj08kTd3KXxxYg524lLud+OhBmgYVnm3t7WvfOVXCtKFINDex8+6oDdjVsKjBONPoaGzzhw1Emo8heu/PAj3tA7ZiBOeGlFU57lQVQodSfW43Cyj9WPRl8oarb3/GSje4V0V7efGLTXub501rjQ3n63ZI+zYiNz9s5GHB0mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUrVP3HD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA3CC4CEF7;
	Wed,  1 Apr 2026 13:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775050468;
	bh=ZgUeRnpR4DATl3Sbw883f5UTNjMmFhqtg9CURPQiQXM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ZUrVP3HDWATxjX+UNJxVTmHekvvRwtN9LN+JW++iezUbDfU2aV0ukICgXJaFimRq5
	 Nlx5ojqFkVeSksxNi12dSpW00cU81KvcWXUE98/yOpZN47p0NleQJqKzEXmUjCcSVe
	 4LXJU8FzZLTNcIkRN5s+Orx0HFlV8nYB0I8MZFvRuZIZePVKfNpNKq5u8VP+SVqbAp
	 AKBNkfwWme8JuQh42wC9ag/2yJQtvmsPfWb/VJxR8XhpjMKiR962AHzF8kWfKrX42y
	 QAXhq4V13YPRv7H6Idwee2zBmtu6DIbiuIYxMy7iogcR468Eau+9BOiX/j11fMH1js
	 ZhQRQlKR1WIrQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id BF8E6F4007C;
	Wed,  1 Apr 2026 09:34:26 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 01 Apr 2026 09:34:26 -0400
X-ME-Sender: <xms:4h7Nafyx5c5Ox6zroyRUHQ79ixV3CoGkN-oMkA58x0jwtajmLJDvvg>
    <xme:4h7NaSEElO1zezXPWvItF_AKHkm2g7r-nP_f2Mz_pcusaSeO9-x2Dr-BeboDXACrU
    POjGyhgvy-ZeWUsSksNFoh6xAg7Benc-tKt2IjV9FRxD80EbIDxo8X2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgtkhcu
    nfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    fghfeguedtieeiveeugfevtdejfedukeevgfeggfeugfetgfeltdetueelleelteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutghklh
    gvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleelleeh
    ledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopeduuddvkeekiedusegsuh
    hgshdruggvsghirghnrdhorhhgpdhrtghpthhtohepuhhklhgvihhnvghkseguvggsihgr
    nhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehrvghgrhgvshhsihhonhhssehlvggvmhhhuhhishdrihhnfhhopdhrtghpthht
    ohepthhjrdhirghmrdhtjhesphhrohhtohhnrdhmvgdprhgtphhtthhopehokhhorhhnih
    gvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:4h7NaRQeQ18NF5vaHjDbeNzkQv0yRp_-B-LRxxF-kWcpXnlwZp44gw>
    <xmx:4h7NaXWt1WZdadTLftydoIAJ7HPjw54NayHtHUxu_9jQ5SPhCRrzAQ>
    <xmx:4h7NabQxVJQd81L_-g6JtKYWl7JW0xARWpJIg3y6kTOVQE_ps9bf6A>
    <xmx:4h7Naf3i5eaVv-evV5UsgFmtiwUN1yx9IT0zOq0VWkZn9X-0lIJKNA>
    <xmx:4h7NabfLKt0WHosy2lNz-Ukix0U8MGuiwdJHl-HggqmI_Tg9DYBPoNo2>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 993CA780070; Wed,  1 Apr 2026 09:34:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_jyC0Lb0WUR
Date: Wed, 01 Apr 2026 09:34:06 -0400
From: "Chuck Lever" <cel@kernel.org>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@debian.org>,
 1128861@bugs.debian.org
Cc: NeilBrown <neil@brown.name>, "Jeff Layton" <jlayton@kernel.org>,
 "Thorsten Leemhuis" <regressions@leemhuis.info>, Tj <tj.iam.tj@proton.me>,
 linux-nfs@vger.kernel.org, "Olga Kornievskaia" <okorniev@redhat.com>,
 stable@vger.kernel.org
Message-Id: <856a0051-131e-4847-9b8c-2c377c375da7@app.fastmail.com>
In-Reply-To: <ac0U4P92l-TkQvnh@monoceros>
References: <177266540127.7472.3460090956713656639@noble.neil.brown.name>
 <6ba41798-9c69-44f5-9a4e-09336c75a4b9@leemhuis.info>
 <cf78feb7ffaee6ed478afb734d2ede149597de86.camel@kernel.org>
 <177434721528.7102.13514118512738778346@noble.neil.brown.name>
 <d4773958-5ae5-42d4-b785-6598b5c9b27a@app.fastmail.com>
 <177442248735.2237155.773724155681455344@noble.neil.brown.name>
 <a6e6a731-2885-4510-87dd-45e6a8f4fbd7@app.fastmail.com>
 <177456522377.1851489.16395975485525163031@noble.neil.brown.name>
 <177187492815.425331.14320091315652332093.reportbug@nimble>
 <465012d6-c824-4d8d-b6f6-8a2d85e30154@app.fastmail.com>
 <ac0U4P92l-TkQvnh@monoceros>
Subject: Re: Bug#1128861: [PATCH v2] lockd: fix TEST handling when not all permissions
 are available.
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20583-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.979];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3014237B812
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, Apr 1, 2026, at 8:54 AM, Uwe Kleine-K=C3=B6nig wrote:
> Hello Chuck,
>
> On Fri, Mar 27, 2026 at 09:56:38AM -0400, Chuck Lever wrote:
>> I think the stable folks will insist on this fix going into
>> upstream first. However, this version of the fix does not
>> apply to nfsd-testing because that branch has the NLMv4
>> xdrgen rewrite.
>
> This is not the first time a bug is fixed by changes that are too
> intrusive for backport. Usually the stable maintainers can be talked to
> accept a small targeted fix even if it's not upstream. The discussion =
is
> simplified by people claiming to have tested the fix and confirm it
> helps.

Sorry I wasn't clear. Neil and I have also been down this road before
so I wasn't explicit about my request.

I'd like Neil to provide a patch for upstream against nfsd-testing.
Once that is merged, he can present the patch from this thread to
the stable/LTS maintainers.


--=20
Chuck Lever

