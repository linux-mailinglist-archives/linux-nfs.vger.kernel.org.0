Return-Path: <linux-nfs+bounces-21394-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFGzObsX+mkrJQMAu9opvQ
	(envelope-from <linux-nfs+bounces-21394-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 18:15:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2084D112F
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 18:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC65E308CC98
	for <lists+linux-nfs@lfdr.de>; Tue,  5 May 2026 16:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6139648AE37;
	Tue,  5 May 2026 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msF8jCeP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6FB48AE31
	for <linux-nfs@vger.kernel.org>; Tue,  5 May 2026 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997371; cv=none; b=Swk6c3Q1JrQronqekDyS6ddLMvgtoZLXnrSIxakigN5IG1Mx+1AHlSnfCYWgGGdAqbs7w8Hj3YUTUTxpCpmFYWKeBrjqG8c4SMwX/uhe2xufL72ruXDnqzLUOe4+QZedx5g6HSs8EzoeMpQo9s2u4z0CGi5FXxZ7jeSnnbF4f0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997371; c=relaxed/simple;
	bh=YEcJOZoFHbD16LBiRMK5FVinqBPMErS07YjWwPC4uCU=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TM0z2KKV+YMlg1pb4HKeb+rnl6EM4iFv60hkSKDyISfGsrykLYXqgOLHjwN8Y1/3fLTbtlnlX/lu6O8Msse6bWYU76CTcpTJX+V4KIUT0/6ziGN4+1YfeZ501HOBOGqfFfAi56uPV2r2rwxyAIbFxJeT60+XYDTjLRQ+UQ52d98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msF8jCeP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB028C2BCC7;
	Tue,  5 May 2026 16:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777997370;
	bh=YEcJOZoFHbD16LBiRMK5FVinqBPMErS07YjWwPC4uCU=;
	h=Date:From:To:In-Reply-To:References:Subject:From;
	b=msF8jCePne3hFFQXdUQ6WvjEiHrevkZykut0RQAvj8/lKWNzUhtiJqu3LkS+M/BwX
	 8rorEjxSvs6zIg1QP/mQZ99ULj6MOizBqEFTl/j3HJ74usd31zAk567wu4BGOEXM8Y
	 6ur5upbGLgyhAhDW0vhUilgugUGdtTct3MgwOG+2CMRx4kc9KcYWdQgMG+echwOk6X
	 T72my1y634LCRvFDK8GkcmFPOib0INzpelw0e6MrUxEv9jyzwO35pJJatEJqvq4Mc7
	 f06u4p/KCZQ+XcegMR7XLKB6U1Ix+JxwORp9sSYl4SMdmx1PcS3/t7+pWRf1+92iXp
	 +oPpl2gI+gYjw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 967BFF40068;
	Tue,  5 May 2026 12:09:29 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 05 May 2026 12:09:29 -0400
X-ME-Sender: <xms:ORb6aaUI8omw-ppI5tL7Quqy3D1uvmNEIxbc4Y9u7QuxBHcmuv0VQw>
    <xme:ORb6aRbAfBmzEN8TodNdqCJGFv3tPQ50-BvIzDqePbMunCTdBeJMi1YxfXEYk-CKb
    etyxqmTRxevmUWZ78RopaDKeta6GfV2KPAzuhvWAaZ0NZaQjs97LA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddvudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephefgvdetffdugfdvtdetieeiudffuefhleeuffdvgeduueehffffveejteeuhfdunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsrghgihesghhrihhmsggvrhhgrdhmvgdprhgtphhtthhopegthhhutghkrdhlvg
    hvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehsthgvvhgvugesrhgvughhrght
    rdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:ORb6aX-c1o5MyXt1D_At5klqKZjfkcMj4vVteKeXbSmF4cyk2eoLAw>
    <xmx:ORb6aRjKLuICLNfdWSeYK2R-xFWod8vZoaZaUWK-7yk0fEKQkkpBow>
    <xmx:ORb6affR3iIJYQzp0MH8VjuxKt9GFL6WKaS_VKlmywHM9fpTfgwJnQ>
    <xmx:ORb6aQqezRkYkyKMueMkZz0zgyDw0A7t1EBx63GhwZ3wdtW4QBHRzQ>
    <xmx:ORb6acBZrJ12WI_scNrUyoxvj7v6VgA83ZVY02MsvFmm2YHWqTS-Dt7R>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7846A780070; Tue,  5 May 2026 12:09:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 05 May 2026 18:09:08 +0200
From: "Chuck Lever" <cel@kernel.org>
To: "Sagi Grimberg" <sagi@grimberg.me>,
 "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 "Steve Dickson" <steved@redhat.com>
Message-Id: <f1a55c7d-6532-4738-b2ca-f2aea1b65d2d@app.fastmail.com>
In-Reply-To: <2934bfbb-c5df-423b-b246-f28da326d70a@grimberg.me>
References: <20260505142038.52921-1-sagi@grimberg.me>
 <de87d03d-a58b-43c0-8be2-997e8180339a@app.fastmail.com>
 <2934bfbb-c5df-423b-b246-f28da326d70a@grimberg.me>
Subject: Re: [PATCH] nfs.man: Document mtls mount parameters cert_serial and
 privkey_serial
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5D2084D112F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-21394-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On Tue, May 5, 2026, at 6:05 PM, Sagi Grimberg wrote:
> On 05/05/2026 17:26, Chuck Lever wrote:
>>
>> On Tue, May 5, 2026, at 4:20 PM, Sagi Grimberg wrote:
>>> Two new mount params for x.509 certificate and private key pair used
>>> for mTLS authentication. These have been added a while ago, document
>>> them officially.
>> NAK
>>
>> There is a very good reason they have not been added to nfs(5) alread=
y.
>> As I stated before, these are part of an internal kernel-user space A=
PI.
>> They are not intended to be user administrative controls.
>
> Ah ok, I guess I misunderstood the thread.
> So what do you think the user interface for this if not key serials?

I don=E2=80=99t have an answer for that question.
Again, I had no idea this capability was
a priority so I haven=E2=80=99t thought it through yet. When LSF is done=
 I will give
it some thought.


--=20
Chuck Lever

