Return-Path: <linux-nfs+bounces-20764-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JVmFzuI1mmwFwgAu9opvQ
	(envelope-from <linux-nfs+bounces-20764-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 18:54:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E19FD3BF241
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 18:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEB4230166D5
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 16:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE5F2EF67A;
	Wed,  8 Apr 2026 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVCtdPOW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CA58462
	for <linux-nfs@vger.kernel.org>; Wed,  8 Apr 2026 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775667014; cv=none; b=LLtzYH2ZRRnJ64hB7hD8lL9yrFWnmHCFUaoZoLbWfw/IPd+2A/kFFYplM8+TVHh9Er/kzCNfwyLeFRXa1WkNjNp33DTMt6KrGSSImDJyNkUDzyXa/s4MUdbSTkFP4Kdlo+IX07/MJsiUib1uwJKehDt0CPNDm6YuI5VVko67l6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775667014; c=relaxed/simple;
	bh=y8CH3sf3nXchs6EEVkAJ2e7wgtwJXLLZFHcgdD/kTcg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Jy2nJ3VCUq1fUDNVgjecesr0BkGUOTxzIzUkNaczhJtt4DEq4SVfHvn+lXvSj6w8uB+JW5lC3lnZojVboLdXKRNden8BDf/kvo5/InXKConA0my8HBjL7LgvdpEnf04WVfNHB4juSQWZ35lOYdi81HVh/dJiuUg/GkHd8bIRwqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVCtdPOW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86AAC19421;
	Wed,  8 Apr 2026 16:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775667013;
	bh=y8CH3sf3nXchs6EEVkAJ2e7wgtwJXLLZFHcgdD/kTcg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=JVCtdPOWweLQunk6MlsoNHhuQpBMIOxvy0tVakaFty4yXSVyAwKYWtj36EoG3G2c9
	 CdwQQMxzrFnlM/bBlixFLODXaDjZ7y2QeEx5K29mLuHwETb8QLKrbS7hrQqYfq4I5t
	 CFnrYGh7o3qj7nxmF6+4NENsO1IjIMHWNE3h9bEILrcxXZUPlaIldc0Rd6CbwyUvrr
	 oKROAU3UI/hOZh5WueUa/B1eunrsVbfiSG0MBhKp7Bnw/JuaZ2v8cdGGtuAWFb+12Y
	 YZSOeS90NJ+mFseiPpAP/YaeI4ia+yRKp9k/uAg7CwJ0WtLUymqhsq3aAqdM7k4jdL
	 rhcu/m07FXhDg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8F790F40084;
	Wed,  8 Apr 2026 12:50:12 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 08 Apr 2026 12:50:12 -0400
X-ME-Sender: <xms:RIfWaWCp0EJJHeGf6N7SzTptXuZLpXaGiqXxalzntlBorNqyNs1epQ>
    <xme:RIfWabUxEytRdSBlg699ZWjWXLa4QzfycraaPB9ddw2J_2BJ8tDkAK8UQnlU4fNvx
    VyJW_L0e05XFh3bOh2Z0lk3wVoI0ccqycq0IN0wT2POepXmJ9c3Wll0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epgffhgeeutdeiieevuefgvedtjeefudekvefggefguefgtefgledtteeuleelleetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvghilhgssegsrhhofihnrdhnrghmvgdprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtgho
    mhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtph
    htthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhomhes
    thgrlhhpvgihrdgtohhmpdhrtghpthhtoheprghglhhosehumhhitghhrdgvughupdhrtg
    hpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RIfWaYWZX_pIg7Zyr-wsQC2BzXh-WCjxIOr2Wt7Z4l-Az2T9SUhqBg>
    <xmx:RIfWaWn5JtA2_ZdhkU2NOcp_YPKcKNjCAdeuiLbrj39OscoI2Mnygg>
    <xmx:RIfWaTAWt8c2EmN5fp1CB4E2ZJLRhvCusXaJ6GxjkLXqH7OCfuSHww>
    <xmx:RIfWaViQ23t7De-yIzbt07HqtxBlSXMGADyiAhV_4zl7kluJDWDEYw>
    <xmx:RIfWaQzWDuSpiX7_MgFlYjumV4gm9vOC4lNwoPnsgkjDDoP5VyidNqu3>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 69220780070; Wed,  8 Apr 2026 12:50:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2ZwlfHVDfig
Date: Wed, 08 Apr 2026 12:49:52 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Olga Kornievskaia" <aglo@umich.edu>
Cc: "Olga Kornievskaia" <okorniev@redhat.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 linux-nfs@vger.kernel.org, neilb@brown.name, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Message-Id: <79484488-0f0b-4ddd-99f6-6ba15373573b@app.fastmail.com>
In-Reply-To: 
 <CAN-5tyG6JFJ=e9Jkmk0TnzvszWXVneDnDaceA_AOhDtK=ScVog@mail.gmail.com>
References: <20260407235038.55749-1-okorniev@redhat.com>
 <20260407235038.55749-3-okorniev@redhat.com>
 <c79b8e38-cc5c-436f-8145-2213dc1256c0@app.fastmail.com>
 <CAN-5tyG6JFJ=e9Jkmk0TnzvszWXVneDnDaceA_AOhDtK=ScVog@mail.gmail.com>
Subject: Re: [PATCH 2/3] nfsd: update mtime/ctime on synchronous COPY with delegated
 attributes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20764-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E19FD3BF241
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, Apr 8, 2026, at 11:24 AM, Olga Kornievskaia wrote:
> On Wed, Apr 8, 2026 at 9:59=E2=80=AFAM Chuck Lever <cel@kernel.org> wr=
ote:
>>
>> On Tue, Apr 7, 2026, at 7:50 PM, Olga Kornievskaia wrote:
>> > COPY should update destination file's mtime/ctime upon completion.
>> >
>> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>
>> Should 2/3 also carry a Fixes: tag?
>
> My bad. I guess it should be the same as the first patch. But I now
> also wonder if the update should be done based on the status of
> nfsd4_do_copy? But this is where I think nfsd4_do_copy can return say
> ENOSPC but it would have modified the file as well. So I'm not clear
> if we need to special case return values?

Thinking aloud:

If you updated the time stamps in _nfsd_copy_file_range() wouldn't
that take care of both the sync and async cases, and you could
determine precisely whether a data change had been made to the
destination file?


--=20
Chuck Lever

