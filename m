Return-Path: <linux-nfs+bounces-21309-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKC2Hodz82nQ2wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21309-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 17:21:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC6F4A4A13
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 17:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2C7A30B0FB3
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 15:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03592D949B;
	Thu, 30 Apr 2026 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0F59WiA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AD92D1F44;
	Thu, 30 Apr 2026 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561762; cv=none; b=AS88G/lVs8WdqKkTWrcLlE17Erx3rZk4fuEM0RxzYQNTmAD84OMxqby+JY8g+liOebkuRNmWvy+AFMuBwlzXW4sbP75QBNb5m9UeTfTV1C8fgqLO51fGWEkaorSLqeN+gumGbghUyTN2a2Ct9TIa8HXINI13oKim/BawuGIMFX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561762; c=relaxed/simple;
	bh=MNQxeylPSH85yof4drJJz0APWpKfXdNcE58Eu9f4KNw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jtCShPtz0KXPtYu1vnJGvNP+7i4qE7KFmIC3Boh3VMwu4NgQhVA6GvOa+wmXdXUHXVq3v4wDMexc741ePUSMaIOTuybTiG8II/7inEG/FTrcu1r+M5nFs7EaLLfOD8T1B8lNbcxkfUKZ0C3M0iUwBK/7kI/ohuPGGVbI+0bjj+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0F59WiA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68F8C4AF0B;
	Thu, 30 Apr 2026 15:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777561762;
	bh=MNQxeylPSH85yof4drJJz0APWpKfXdNcE58Eu9f4KNw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=p0F59WiABgO0n40imT/0NFQ1PvgEOqOJpErCQ5ywDB5ItiT2n0V0RfL4W9yq1Zfoi
	 Ll4YeoCsK7iGTpCGRzZJneQ7ZChS6r2r9YiO2rRYbvXaAFPoXBKTQthM65coJpeGNJ
	 TBqYVnYoTkRp0r6glbUihyk8q/m/vK3b+teqyDtHyr6GKCk39UziyGUiPfiFxKJuRr
	 JBo+TCm6wkDIIDJTE/K1mZ8GfKUL6ZwqLHOymVWYzVQV2tP1AjS6WAHwJOsb0LIF7U
	 zamPd+GWY3kXUCusjltuEAV3X+twM5eut9T2xNtNLMV6cyfZGwf8y7Rjlenf/yz5xC
	 oz3HER4FDvcqQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9FDE2F4006C;
	Thu, 30 Apr 2026 11:09:20 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 30 Apr 2026 11:09:20 -0400
X-ME-Sender: <xms:oHDzaUteTJwU0ifNxcR-mqak90bWHSlQ-V4XK46Fw_YL_SMN4tm-8Q>
    <xme:oHDzacRb7vvJ2AruWB-WpUDLYPfdCP6uEK3QKjrgyP8BvAc8Gxuv9o2o2jnqZsvXu
    eHLa_dpcQ9GoqsxkXhzEr6tKSK55t4_ZTcdANy-ry2nGz_Rbras3gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekjeeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epgffhgeeutdeiieevuefgvedtjeefudekvefggefguefgtefgledtteeuleelleetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopedvvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopegurghvvghmsegurg
    hvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepjhhirghnghhshhgrnhhlrghisehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopegrnhhnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhrvgguvghr
    ihgtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkuhgsrgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:oHDzadf_PQQscKrx2ZPYdNnX2P3ZRqVdFCHM16jCB9avE_z_IGTJiQ>
    <xmx:oHDzabrf4emvYIADYegvD7qH-HB7Q0c2yfVDIey0tyva-Z5la09BRA>
    <xmx:oHDzab-hY-SFePekJPOu5alvy0XrNCi7e5H-tYUccI1mYP74VxUOcQ>
    <xmx:oHDzaU7PCZamliF0xzlRIMEBTDQiIQLzVpmft7cyNNp3x7Reh8cPZg>
    <xmx:oHDzadjQDGq8zJdAAkL7BL1HIk4pQwOSA8HaKNVefq4JDwazsRivp9aV>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 780C5780076; Thu, 30 Apr 2026 11:09:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ak4FKvzB_QgF
Date: Thu, 30 Apr 2026 11:09:00 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Frederic Weisbecker" <frederic@kernel.org>
Cc: "Marco Crivellari" <marco.crivellari@suse.com>,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, "Tejun Heo" <tj@kernel.org>,
 "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 "Michal Hocko" <mhocko@suse.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>
Message-Id: <4edf7abf-8f48-4433-98f0-2ed2d97a32f5@app.fastmail.com>
In-Reply-To: <afNvZKtiQPLbi-3F@localhost.localdomain>
References: <20260430085412.96961-1-marco.crivellari@suse.com>
 <8d1eff7b-3712-4039-87d6-028a4118e210@app.fastmail.com>
 <afNguCraI6AvmZrR@localhost.localdomain>
 <1e220a70-4318-49de-aaac-332c0a1cfab4@app.fastmail.com>
 <afNvZKtiQPLbi-3F@localhost.localdomain>
Subject: Re: [RFC PATCH] xprtrdma: Move long delayed work on system_dfl_long_wq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1EC6F4A4A13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-21309-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.com,vger.kernel.org,kernel.org,gmail.com,linutronix.de,oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,app.fastmail.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]


On Thu, Apr 30, 2026, at 11:04 AM, Frederic Weisbecker wrote:
> Le Thu, Apr 30, 2026 at 10:05:52AM -0400, Chuck Lever a =C3=A9crit :

>> Does the patch address a bug (work isn't getting rescheduled at
>> all) or is it merely a minor optimization for certain platforms?
>>=20
>> What's the user-visible issue that will be improved with this
>> change?
>
> It's not a bug, it's an optimization power-wise and performance-wise
> and also part of a bigger sanity change:
>
> - Long works have no reason to stick to a single CPU. If they are conv=
erted to
>   be unbound, the scheduler can move them to relevant targets to optim=
ize
>   performances and power consumption. Hence the new system_unbound_lon=
g_wq.
>   The goal is to remove system_long_wq if none of its users rely on lo=
cality.
>
> - Using queue_delayed_work() with a bound workqueue doesn't make any s=
ense
>   since the target is completely random.

The light dawns (for me). That's what I'd like to see in the commit mess=
age.

I don't have any technical objections to the code change.


--=20
Chuck Lever

