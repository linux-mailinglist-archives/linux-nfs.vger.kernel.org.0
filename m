Return-Path: <linux-nfs+bounces-20181-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG99B3D6t2n1XgEAu9opvQ
	(envelope-from <linux-nfs+bounces-20181-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 13:41:20 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAE32999BE
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 13:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98182302AE28
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 12:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36908395DB1;
	Mon, 16 Mar 2026 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8qZ7kQs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138ED3947BC
	for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773664789; cv=none; b=BGEg/560uuvITWT7IAL3KWWaFQSmxXHcRtbQnFsS7tHNf9ZRrqT27SVvdHdR8pxiNZCOQQ3v6dbkD63bSlaEm2nvsxAs7miYiEplDzJZXKG5jp6fB++0RRd10vWSp3l2mlgYi8AZsr9HH4yA3vaZP1Cif4bKuPGUG+4lJnwE5l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773664789; c=relaxed/simple;
	bh=1I0m0MS17xskY1jpOtGcVJRw0G/+p4DClJjuXodO5Kc=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=B6bSCktXPkYaIg4ZcxvmIVJ7DnZNGHGrR2aEansNGlMaAiwO/d1Aa+WSFsUge6EEtw67jhwuDKEjnZOi0ZA0rsBifcG95cloAyjn9Retbgoe3qXFyagVw/z0L8UqHussWtw/25ETVk0YrF84sQJL9SnLpqVT4+lBMks35dk40HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8qZ7kQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7A6C19424
	for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 12:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773664788;
	bh=1I0m0MS17xskY1jpOtGcVJRw0G/+p4DClJjuXodO5Kc=;
	h=Date:From:To:In-Reply-To:References:Subject:From;
	b=h8qZ7kQs90T9n+4kYJXPKzLbCXsLaREKRE8J4DsyT6s9hQPHzhkJ50Redgzx7C+J5
	 RrA+4opAVDBTt9pc6AaTU1lXbqS9N8Mp1YaO5H7S7+rXZkPEFC177HC+8jYqiw74fw
	 yK5otTem1ErdzbEqNTbhoe0K36HgqmxBDq6X1wErz4bFC6OWBc/z5QWa/puws1SUVa
	 yr9JyXRL7bohZmw3k5vkRDkGGd015i07aCbDsMQKU2Ei++k6MaJgkLacOsLc9LUspL
	 dGWd+ps9iPXIMOKjlebCok2D60D2ZsWER2EM2/+kooKaNsUvwMWTi7ZpoiwJz48QdJ
	 ZTVEGQurAD30g==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id AB182F40074;
	Mon, 16 Mar 2026 08:39:47 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 16 Mar 2026 08:39:47 -0400
X-ME-Sender: <xms:E_q3acnWDV-7BO7yXuaPaIRNStm4pxTFFcGbZMuXR_2GN24-FOp3Lg>
    <xme:E_q3aWrdtxJ_qlsUSCBcIY4KC_J2lvroQW3woJIp5-LAVaNFnU43iKwLHcdURtwPz
    EUmlnGkby8Y7pTixqUXWipnXSDCILOjpwdN9yQC4XljlmH6F1ItO9Nl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleekgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epheehjeelgeffffeihfduudevudeghfehheefhffgueeluedufeetjeduhfdukeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegtvggurhhitgdrsghlrghntghhvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:E_q3aTSCj-w3USup32-sj-o6hlFFzJfVsihfyHFWvwxM7jqaA-NOZw>
    <xmx:E_q3aStx3--JoHQDdOzsYV1gFJdRyZttknghJzw3I4SY8wH8DhbMNQ>
    <xmx:E_q3aQZPOmmPUoQQgXbURvQPDtdL7k5iIP5gBxOpAhbJDaKqVqHSRQ>
    <xmx:E_q3afv08tvDvnzqdeGG2_xWyW1vFGH2rb7wbFMP6KzfXSxsl8M5Pg>
    <xmx:E_q3aaGDhEs21crDHttLh4Y58ybrG--BBQcUrteAKWDurrRKuSF_oTMq>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 871AF780076; Mon, 16 Mar 2026 08:39:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AnK-AOf-hwWB
Date: Mon, 16 Mar 2026 08:39:26 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Cedric Blancher" <cedric.blancher@gmail.com>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Message-Id: <5acaa8e7-0691-4cbd-b501-c26831a7be81@app.fastmail.com>
In-Reply-To: 
 <CALXu0UdOR8mVr=8pwNP95FnOsOk1w1A2=DcayKk3YnDfS+PzUA@mail.gmail.com>
References: 
 <CALXu0UdOR8mVr=8pwNP95FnOsOk1w1A2=DcayKk3YnDfS+PzUA@mail.gmail.com>
Subject: Re: Increase default NFSv4 server size "max_block_size" to 4MB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-20181-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7BAE32999BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Mon, Mar 16, 2026, at 3:51 AM, Cedric Blancher wrote:
> As debated a while ago, can the default NFSv4 server size for
> "max_block_size" be increased to 4MB, please?

There is an administrative setting to raise this limit for
recent versions of the kernel. Can you report your experience
when you raise the limit? Hiccups, performance issues, etc? I
would kind of like this exercise to be data-driven.

What is still unknown to me is which NFS client implementations
can support 4MB or 8MB. Without client support, an increase in
the default in NFSD doesn't mean anything. Rick, Anna, Roland?

-- 
Chuck Lever

