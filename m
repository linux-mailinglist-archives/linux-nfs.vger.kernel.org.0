Return-Path: <linux-nfs+bounces-18884-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDjrMT+TjGlIrQAAu9opvQ
	(envelope-from <linux-nfs+bounces-18884-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 15:33:35 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CE112545A
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 15:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F15A4301682F
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 14:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9B92C3266;
	Wed, 11 Feb 2026 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvGIYMkG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1692D7D2A
	for <linux-nfs@vger.kernel.org>; Wed, 11 Feb 2026 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770820407; cv=none; b=T49IAY0vIvgT+GjYy5wNtjgVPMCWT01UUSzvQbmeOLMjVvzvYxDmSD41Ix90ZkUL8bSxWR55yRsnBFo8XQBHDVCR2GDAn1KtsbaU6oUvzOqWjayy15+XPGjgo23z1hWE0DV4A350p8O/b1HqDQWcOY6OOn4BUUGZ+CNyJChXWy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770820407; c=relaxed/simple;
	bh=t2bJpXQc4AFVnX1fm0vsWVczpFog9jcuRtYBlYChLTs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Og+8h6/7JGS9uVE91ES/NgRNjln6ge9G+Xv2Y8h51foBf0XVc0LCqIIgLPaH6wPhGFvzCihwIBy70P/I7PB9w427bO+d6eJyQn/EVsG+SFPdnJs6hUeOIBQAPiSNN768hbQxlk5CXv9xvdEdIK+Y0jOcrLI3o/1RoCp1cbSQekc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvGIYMkG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE9EC19424
	for <linux-nfs@vger.kernel.org>; Wed, 11 Feb 2026 14:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770820406;
	bh=t2bJpXQc4AFVnX1fm0vsWVczpFog9jcuRtYBlYChLTs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=QvGIYMkG+mgNxBJkQFX/zttLS6CRcExyNAuoqr9AZfY+cM2G1Uy9ZFHpk0ii/kdpL
	 Bc20PIaJw03vw+GQlhC+B3ifSdJxHqELuEgegBwwz3HVgYH207yCoN/Amtne+Ofg7i
	 EjHlaXfxvUSSNQJRG1SReQb5H8RqssoBcNGnY1vbMS6Lp5Jf3hOyI4/4AWenVc/WU2
	 XpAlK1CYd9Kn4ckh4xXRBgavjSoAQ0vIrBvLvt6KGzQ+UnZ3In5FobXNINFdNQQ6Yt
	 8DmsY59u1BZaxfoKniHY+8QsYZd84Zv2AdCIE2hE9wJBKGhrJXHj+wCygFLpKb8l3T
	 gmavg8LuUfzUA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id CEFE0F40068;
	Wed, 11 Feb 2026 09:33:25 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 11 Feb 2026 09:33:25 -0500
X-ME-Sender: <xms:NZOMaehL4o_FrItSCcLHCJcnCUIlHiNoO7a4JDUlP2Uqe-BhdNq5QQ>
    <xme:NZOMaZ2V-5jTntAOd23hl9Xp5p5Kxosnd11fVF9n-F6iHX-j0IH0gYOlJpGcF8uOD
    6QEtmqbM3FO-lqmdpeJ9gUPtrd2C99gTic0snsO9GRzjNL5cdeyUls>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepuggrihhrvgesughnvghgrdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhfsh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:NZOMaRN9d60t9JqfdgR9DDt-WO1BkgdHHD6tpnRyntxPKu6FYVnF5w>
    <xmx:NZOMaR6cnSX7OyEfUqWaE1ipaiwirz4EbOMPLKygeg4sIRkiopyLEQ>
    <xmx:NZOMaX3qzHeoKJz7ausysZXXf0alLnRQjEHNr_1Bf2vZlR_e5e-y6A>
    <xmx:NZOMaaYQwEuFwx3qi5vV8WbXjB4iP6DECf5jiHf5gKusISDosmmONQ>
    <xmx:NZOMaXDtWPi0o7jhDHW5b6Bj6sDIlcYWp8neYWE5QRsB22_SRctK8OxS>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B44BB780070; Wed, 11 Feb 2026 09:33:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A7FasjyZ6tmc
Date: Wed, 11 Feb 2026 09:33:02 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Daire Byrne" <daire@dneg.com>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
Message-Id: <5ce9e049-1c6c-445d-8d02-44892db8760b@app.fastmail.com>
In-Reply-To: 
 <CAPt2mGNVMthai4J0QRSaJdWHP4X+K_mzqBxWQGUzdOihMyU_KQ@mail.gmail.com>
References: 
 <CAPt2mGNAGaO8hP9u4M+oH0_w0dbSNAmDF=g0jyb26ED5R_mhOA@mail.gmail.com>
 <a1b6c46f-e49d-4ae6-ae5e-3c08ed40e359@app.fastmail.com>
 <CAPt2mGNL4neF1NX7_1=9svnNz_iXhadHw0AEjZ_B-50-vwNtUg@mail.gmail.com>
 <723418cf-cec6-4afc-906e-b93a55e85fc9@app.fastmail.com>
 <CAPt2mGNkGbWujzTzxoTGTvAWoOL9aUUhN93SEJQYJTQyV4xu7Q@mail.gmail.com>
 <d9926f9e-50bf-46e7-9109-21b30dd695c1@app.fastmail.com>
 <CAPt2mGNbZm9YDjuCUwJHiJUQUUnKQtbf1ggYPzAytgWjMp68LA@mail.gmail.com>
 <CAPt2mGOsCLrG30s7mrOvd3N5t018T+gJhGWd88pw0WbOnagO=A@mail.gmail.com>
 <110b6190-ed55-41d0-a3ca-580ebc38c1e5@app.fastmail.com>
 <CAPt2mGPMvQMyMcNUnznqU=0pSZ4xVDB32Q61_gTkL9TvHyKXrA@mail.gmail.com>
 <d97b4a81-7fbe-405e-b5dd-82e74630c9d9@app.fastmail.com>
 <CAPt2mGNVMthai4J0QRSaJdWHP4X+K_mzqBxWQGUzdOihMyU_KQ@mail.gmail.com>
Subject: Re: knfsd read iops limits?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.15 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-18884-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 58CE112545A
X-Rspamd-Action: no action



On Wed, Feb 11, 2026, at 5:39 AM, Daire Byrne wrote:
> On Tue, 10 Feb 2026 at 21:21, Chuck Lever <cel@kernel.org> wrote:
>> Thanks. The two significant contention areas are the lwq idle
>> list in the SunRPC thread dispatcher and the group sort in
>> nfsd_setuser. I'll post some patches to test in a day or two.
>
> I'm not sure if it's relevant to nfsd_setuser, but we do use
> --manage-gids and have lots and lots of users and groups that the
> server needs to parse (sssd -> AD).
>
> For this workload, on the server, I am a member of 737 groups....

Right, the group_sort() done for every nfsd_setuser() will be a
significant overhead for you.


-- 
Chuck Lever

