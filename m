Return-Path: <linux-nfs+bounces-21718-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ft1FsbZDGrhoQUAu9opvQ
	(envelope-from <linux-nfs+bounces-21718-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 23:44:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDD5585473
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 23:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA689301052D
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 21:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AE13B5306;
	Tue, 19 May 2026 21:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODnitlPS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FAC3438A0
	for <linux-nfs@vger.kernel.org>; Tue, 19 May 2026 21:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779227075; cv=none; b=dHsej9/16Pe6D0txX54vgLldaAQ8kv4pXJWNX23Wavw6OjxmfFg2Ffg2uf4tOIKDKq0xU6PPEzZFyHKV4DXscaOIlPyshh8NFfXzDmZ9bt/L2USxc12Yyg5c7CndR9Z3Zr2Z1HoamKQPmi5jqLLPtwMRjRbqk2694t2JAMaOcp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779227075; c=relaxed/simple;
	bh=sQGG1WIW+xuMTCO7SWBgbVWr8khfsFhgmEN8m8HGMgo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UQjDkHDpuJzzPjO9sjl+xojiH8LgSB0+QeLckJXSN6cg5WVRbnZ43pyh6O1g97WH6e8ZSanhvpjXdpWQqNnZb0OzBljjTosMChXKw5B8WwcdmgAjnjj6gmRnfCT67k7kZfk8ML8UeEObfQQybL7WCZT3qRd4gsAO6px4RqBqo/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODnitlPS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955671F000E9;
	Tue, 19 May 2026 21:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779227073;
	bh=JHA2fZRgZQ60cIrEzHsch810qLS6ZmnhPOAcGg9k6Hs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=ODnitlPSBqW1QDPfW5Fpsg/zNRUhtvrQ7XjEeKC0b+Lr4EzYvnaGgf/KPOqCvzGCF
	 pK/ynqzb8Bka1UTt5pdGAbkzDAJS3tbCLeUqCHbrKJBqS/FGg6QOohrffEO1CS+EDW
	 a3TfCAJ6Os1VIJowenXxxpAgjj3KmsEBlN7Z2oxpXlVoapZ/yCr3ikVU3hzRJixgHZ
	 Wo8A3nBWuYhqaF78p1f+LAoN8PwncOGZDlOmjkdkMoJOVDrOwQWmbHo2JvAWAX618V
	 YMxJGqNb8rKxuYPJ+O6Zd0ps+E4qFi78BRZCrRwoKivxOSXf2dbL7BAqpOCndE4PGH
	 tb5LakiCAA3Ug==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id CDF88F4006E;
	Tue, 19 May 2026 17:44:32 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 19 May 2026 17:44:32 -0400
X-ME-Sender: <xms:wNkMau1_ac1qQkwyAfUrq11U_-P1ehB-Z0gI6rVvWi_RLj3aejsNig>
    <xme:wNkMar455Y6uTvNFkAvhvyYSgykqhla8e3YLO-mKZjVlkHXPAWoOBhWpkCOiGYzP5
    VnE8cnbzxKOQr558tZApiGW7bTAqZFT8CN0Rgqa2aAAEcyRu4XRajg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedvkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsggvnhdrtghougguihhnghhtohhnsehhrghmmhgvrhhsphgrtggvrdgtohhmpd
    hrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgv
    ihhlsgesshhushgvrdguvgdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:wNkMakezvX6j9Sbz_iBWGAVZCWRF4v8c3Kro2AZQ2CdosNRnhn5lZQ>
    <xmx:wNkMakAtaxZ9sEo-8g_m7baEVbN_Mr_k9SMoIFcGkZes1vM1SwqWjQ>
    <xmx:wNkMav_5iroj2FmCwK2FxEXOIy1aqUOsG_mJ4cZqCkX3_lIiwMzTFw>
    <xmx:wNkManLZcTF1o8ts-3LWHvgWHMCZ9t32INbMe8FCepkHXd1Nriav0w>
    <xmx:wNkMaggV2S-hQS873wmgMTRRrH9YpOT5rdU7hAqyKfCgPnd_5EGtTAtZ>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AE708780076; Tue, 19 May 2026 17:44:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ABrU-SqmuE1V
Date: Tue, 19 May 2026 17:44:11 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <ben.coddington@hammerspace.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neilb@suse.de>,
 linux-nfs@vger.kernel.org
Message-Id: <4c5dbb98-0209-4572-8eac-1578536bbd78@app.fastmail.com>
In-Reply-To: <3AB7EB6A-B207-4B91-A695-66C4704D0E31@hammerspace.com>
References: <D33770A1-9098-4F1A-93EF-590E6C0B7638@hammerspace.com>
 <473e337b-fabc-4884-a6c4-0f04b6874d0b@app.fastmail.com>
 <3AB7EB6A-B207-4B91-A695-66C4704D0E31@hammerspace.com>
Subject: Re: [RFC] knfsd: per-client fair scheduling to prevent single-client
 starvation
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-21718-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: ACDD5585473
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, May 19, 2026, at 5:08 PM, Benjamin Coddington wrote:
> Just to be clear - the issue I'm exploring isn't the same as when all the
> kNFSD threads are slow due to their workload.  This is very much a
> multi-client dynamic where one client (or a group of automated client
> instances) are able to easily starve another simply because they create the
> most connections.
>
> That's different from the other problem that we've discussed a bunch at
> bakeathon and on the list previously.
>
> This is not so much a deadlock issue as it is an issue
> of per-client fairness.  I think this problem is in a different class.

Does dynamic svc thread creation have any impact?

If the issue is clients with multiple transports, wouldn't fairer
request scheduling across transports help?


-- 
Chuck Lever

