Return-Path: <linux-nfs+bounces-21299-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDnlI25b82mF0wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21299-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 15:38:54 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C2C4A3924
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 15:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF0A73047067
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 13:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFB6428485;
	Thu, 30 Apr 2026 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUJtDcp2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D759D428480;
	Thu, 30 Apr 2026 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777556142; cv=none; b=Rif5ZzBX8/Fj2XTn5hVGaUA6usaRVOlclI5tNFmNtKT/PZLuaXHpvJjXdsiY+yaO0/sxS4g0FwaDSyUhywf7WncgzlcGs7mRdss2l+3NSV5hmSUwgNRQmvkA9FjuOSQA8hn1MrCd/MMlCj2VripkUzFgsZwbdgpP73/yx6GH534=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777556142; c=relaxed/simple;
	bh=Jts2CoDuG9f7IQGE0LXf+uYfhKHe9oYIDMc2uUAcUOc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Dm3frb2eOHCy7LnNbJla8v3pmTHm8ND5dW58D2VB7yeEGDQJrKCtk86S6LLtUx1u+epZitqI86tsHOqushcWa6LnxIyFt2YXPeD/PLWQqU4DFrjdliplDqOH+vITBpZnYexm0hnXGkqn0Fa8m6oxCkXVx51f2lm6kiupeVqsm7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUJtDcp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC119C2BCB3;
	Thu, 30 Apr 2026 13:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777556142;
	bh=Jts2CoDuG9f7IQGE0LXf+uYfhKHe9oYIDMc2uUAcUOc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=aUJtDcp2ib2UzLUlQhYlq4hIhCPnq0JUJKFUobXZoK7Gp7dnmxfJcsGSdW20aY7ca
	 Sf40/QoY4edaJ6DRu4Q3p9+1K2xeGvJZFdHAElXgPa7BsUOjMjdVTOk2RRNIjOwoF1
	 sAuXsUhVg0g9sEAIrtBxDDqWz97NBhHSc2mKCAsGUKLRoynKqIY0VxwD6WpcYzBjBU
	 +I1icaMH7hJ550KyV2riIdZAG7Pz/IsUEGObKq2EGP9gjVgfIoppYQ1zf6LF2utnzj
	 IsiWYN2ZZxV3Ejb27Yb7+V0jXQmUjvx3o5G4Ynadgc/hjwmrn5Isna1MVNkZM+8/Es
	 cqU0cgU0ik2DA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id CD2EDF40074;
	Thu, 30 Apr 2026 09:35:40 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 30 Apr 2026 09:35:40 -0400
X-ME-Sender: <xms:rFrzaQbOgQeEQ8jYDth3sjPs8rE3idLCK4_olg4iq-bX6u7vN7FUgw>
    <xme:rFrzaWPwdM4JRT4tjbdFzG2DRUl-SvglcB1JgxA8t6HetQjZsS2Ep8OmQXFPOXrIM
    AyH5ziF2VOfmynid6WFEUT-trkJlIrGx2cV27HvNSJQ3jLfiyhZ3iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekjeeghecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:rFrzaaLYYZlejZSY3UT_lYlTXdpkyX5-3FCOC_izeZk2Mc3T-Avfug>
    <xmx:rFrzaSmQD4S2xu0YZFtxHn9UOHjUKx3yoFHykmmMiMbe5P1Qu1yOEQ>
    <xmx:rFrzaQJ7r35KiCA0Zw05fw0WccNlHSUBI3RQMJKhboafLtZZrV3Deg>
    <xmx:rFrzadWCS9H9PaBc75joe4daInB_rdyM2fkmz5qHh3gjhOiSv1fwbg>
    <xmx:rFrzaVOLxT6YcZh_segc0ADP3Emvyy8KbHubXeZAmKmvjdJtgQV9o70n>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A2456780070; Thu, 30 Apr 2026 09:35:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ak4FKvzB_QgF
Date: Thu, 30 Apr 2026 09:35:20 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Marco Crivellari" <marco.crivellari@suse.com>,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org
Cc: "Tejun Heo" <tj@kernel.org>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Frederic Weisbecker" <frederic@kernel.org>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 "Michal Hocko" <mhocko@suse.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>
Message-Id: <8d1eff7b-3712-4039-87d6-028a4118e210@app.fastmail.com>
In-Reply-To: <20260430085412.96961-1-marco.crivellari@suse.com>
References: <20260430085412.96961-1-marco.crivellari@suse.com>
Subject: Re: [RFC PATCH] xprtrdma: Move long delayed work on system_dfl_long_wq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 01C2C4A3924
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-21299-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]


On Thu, Apr 30, 2026, at 4:54 AM, Marco Crivellari wrote:
> Currently the code enqueue work items using {queue|mod}_delayed_work(),
> using system_long_wq. This workqueue should be used when long works are
> expected, but it is a per-cpu workqueue.
>
> This is important because queue_delayed_work() queue the work using:
>
>    queue_delayed_work_on(WORK_CPU_UNBOUND, ...);
>
> Note that WORK_CPU_UNBOUND =3D NR_CPUS.
>
> This would end up calling __queue_delayed_work() that does:
>
>     if (housekeeping_enabled(HK_TYPE_TIMER)) {
>     //      [....]
>     } else {
>             if (likely(cpu =3D=3D WORK_CPU_UNBOUND))
>                     add_timer_global(timer);
>             else
>                     add_timer_on(timer, cpu);
>     }
>
> So when cpu =3D=3D WORK_CPU_UNBOUND the timer is global and is
> not using a specific CPU. Later, when __queue_work() is called:
>
>     if (req_cpu =3D=3D WORK_CPU_UNBOUND) {
>             if (wq->flags & WQ_UNBOUND)
>                     cpu =3D wq_select_unbound_cpu(raw_smp_processor_id=
());
>             else
>                     cpu =3D raw_smp_processor_id();
>     }
>
> Because the wq is not unbound, it takes the CPU where the timer
> fired and enqueue the work on that CPU.
> The consequence of all of this is that the work can run anywhere,
> depending on where the timer fired.
>
> Recently, a new unbound workqueue specific for long running work has
> been added:
>
>    c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound w=
orks")
>
> So change system_long_wq with system_dfl_long_wq so that the work may
> benefit from scheduler task placement.

The patch description confuses me.

The message ends with "the work can run anywhere, depending on where
the timer fired." Read literally, "can run anywhere" sounds like a
feature, not a bug =E2=80=94 and the proposed fix (WQ_UNBOUND) also lets=
 it
run anywhere, just via a different selection path. Without a sentence
saying "and that anywhere includes isolated CPUs, which we don't want,"
the reader is left to fill in the gap.                               =20

So, could the commit message lead with the motivation? My guess is that
this is about respecting HK_TYPE_TIMER housekeeping on isolated systems,
which system_long_wq cannot do because its per-CPU pool ignores the
housekeeping mask once the global timer fires. If that is the case,
please say so directly and the mechanism trace becomes a supporting
argument rather than the whole argument.


--=20
Chuck Lever

