Return-Path: <linux-nfs+bounces-21302-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKYYB+Bh82le2AEAu9opvQ
	(envelope-from <linux-nfs+bounces-21302-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 16:06:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3B94A3D84
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 16:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA9FC30160F9
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 14:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FDB41B352;
	Thu, 30 Apr 2026 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrtZRd3w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA0140B6DE;
	Thu, 30 Apr 2026 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777557975; cv=none; b=My3Vr8wbt+5SKxeWj9swhKEaV0kFTy8BWE1nJmMBcbl6jLiyzEu7UNvubxYJYa53oU5FBmewPEQ/PIZTDKFJ60X0GPaIPmquxhYbrdPwgPOxOSTOTtUInn4EW45PJegOF5nlKV3fBXJ5m4ceBJ0qN817gELx7TRGHQ812mF7l64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777557975; c=relaxed/simple;
	bh=XWEsNmRSdX9WgGb2UIXr7POsHjtPCiMQMtr3RMrDXq4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kH/Dwl9+mhxuw/nzxjMd+k3ozs4lXD5qeifiPvQyEUDmRa8ifL0M6YleqLbNXyBfdoX4Y34C/mZ+i3mEVi0JIzhMAgB/CzZ+e78j0vr7K7WztPsYwuh/Cz3uFgUSzCFqC7Ad037XHRLaFm0UMbejD58iZs7WRQde/V6m5CfFWzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrtZRd3w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7A3C4AF0B;
	Thu, 30 Apr 2026 14:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777557975;
	bh=XWEsNmRSdX9WgGb2UIXr7POsHjtPCiMQMtr3RMrDXq4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=QrtZRd3wwgksGExz22wW7QleFHv32WWInSgz0SivBKsSzr7Y8n9oqQ3PnBjVpFAYe
	 9KDbj5L1INyrRjjpc24ihzw0WQfSXMVvYeiQpchLeQLYiNGfSSeDTknaYZBK/ZXh3U
	 hgctSEcPjDuh33a1ODhJqsao0JybJc5MMHws8lUPxl4bLbC6a7f1CyiO4/yE2UELYg
	 hMQ2IICEmGHrAiYchVEhdlEkVgy2ZUZ4uew5v/IWbvicBkkH3GBarbPdbEVtD4bMr4
	 t10N0wOtKKNX+r65KBv+s/xfQk7Yb/2kdLGGPwctUp6xqVwv7feqnfbebx++2Y/h3e
	 sVUlJgl2T01Sg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 75802F40075;
	Thu, 30 Apr 2026 10:06:13 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 30 Apr 2026 10:06:13 -0400
X-ME-Sender: <xms:1WHzaeUt0L1el-qeqEQsKWzDwHLWbbja6ThrdMhome6XwrLzEjyfyA>
    <xme:1WHzaVYcipu8zCcrGCd-9svv8gIf-wGCDyMoRxBmbyJKbnH_jYJcyQ19gAEbclNVx
    eeNY7XQgvpM-n2txWo11eOnm3gI4n4p3vX_b7-KffdXdiq9ndFTtwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekjeehudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:1WHzaVHw46XBLyJmpi7AXeNAra7Yt58uCIoEhNxjP154LP2Ja1wScA>
    <xmx:1WHzaazfDlDIun2DNyTQsOcXEcvWBbhUyT5eUfZR6mmphi1lkuUvSg>
    <xmx:1WHzackHmKK6p-PtjuxV2p_IvdKrZTpYatOUAIHoSQPLKPvGkYNgag>
    <xmx:1WHzaZA9PmPUklF2zRWQ4gcmWxAUO5DiAf20jQfpPCtmFXnzKjq0tA>
    <xmx:1WHzafIOR8V2GBv0OB-XtkgDUnde7FeBRHJAbFWhdepSO-UXGYISD-Ac>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4C62078006C; Thu, 30 Apr 2026 10:06:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ak4FKvzB_QgF
Date: Thu, 30 Apr 2026 10:05:52 -0400
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
Message-Id: <1e220a70-4318-49de-aaac-332c0a1cfab4@app.fastmail.com>
In-Reply-To: <afNguCraI6AvmZrR@localhost.localdomain>
References: <20260430085412.96961-1-marco.crivellari@suse.com>
 <8d1eff7b-3712-4039-87d6-028a4118e210@app.fastmail.com>
 <afNguCraI6AvmZrR@localhost.localdomain>
Subject: Re: [RFC PATCH] xprtrdma: Move long delayed work on system_dfl_long_wq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8C3B94A3D84
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
	TAGGED_FROM(0.00)[bounces-21302-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.com,vger.kernel.org,kernel.org,gmail.com,linutronix.de,oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid];
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



On Thu, Apr 30, 2026, at 10:01 AM, Frederic Weisbecker wrote:
> Le Thu, Apr 30, 2026 at 09:35:20AM -0400, Chuck Lever a =C3=A9crit :
>>=20
>> On Thu, Apr 30, 2026, at 4:54 AM, Marco Crivellari wrote:
>> > Currently the code enqueue work items using {queue|mod}_delayed_wor=
k(),
>> > using system_long_wq. This workqueue should be used when long works=
 are
>> > expected, but it is a per-cpu workqueue.
>> >
>> > This is important because queue_delayed_work() queue the work using:
>> >
>> >    queue_delayed_work_on(WORK_CPU_UNBOUND, ...);
>> >
>> > Note that WORK_CPU_UNBOUND =3D NR_CPUS.
>> >
>> > This would end up calling __queue_delayed_work() that does:
>> >
>> >     if (housekeeping_enabled(HK_TYPE_TIMER)) {
>> >     //      [....]
>> >     } else {
>> >             if (likely(cpu =3D=3D WORK_CPU_UNBOUND))
>> >                     add_timer_global(timer);
>> >             else
>> >                     add_timer_on(timer, cpu);
>> >     }
>> >
>> > So when cpu =3D=3D WORK_CPU_UNBOUND the timer is global and is
>> > not using a specific CPU. Later, when __queue_work() is called:
>> >
>> >     if (req_cpu =3D=3D WORK_CPU_UNBOUND) {
>> >             if (wq->flags & WQ_UNBOUND)
>> >                     cpu =3D wq_select_unbound_cpu(raw_smp_processor=
_id());
>> >             else
>> >                     cpu =3D raw_smp_processor_id();
>> >     }
>> >
>> > Because the wq is not unbound, it takes the CPU where the timer
>> > fired and enqueue the work on that CPU.
>> > The consequence of all of this is that the work can run anywhere,
>> > depending on where the timer fired.
>> >
>> > Recently, a new unbound workqueue specific for long running work has
>> > been added:
>> >
>> >    c116737e972e ("workqueue: Add system_dfl_long_wq for long unboun=
d works")
>> >
>> > So change system_long_wq with system_dfl_long_wq so that the work m=
ay
>> > benefit from scheduler task placement.
>>=20
>> The patch description confuses me.
>>=20
>> The message ends with "the work can run anywhere, depending on where
>> the timer fired." Read literally, "can run anywhere" sounds like a
>> feature, not a bug
>
> A feature, but incomplete :)
>
>> =E2=80=94 and the proposed fix (WQ_UNBOUND) also lets it
>> run anywhere, just via a different selection path. Without a sentence
>> saying "and that anywhere includes isolated CPUs, which we don't want=
,"
>> the reader is left to fill in the gap.
>
> Not quite, global timers don't fire on isolated CPUs. And since it get=
s enqueued
> on the CPU where it fired, it won't be enqueued on an isolated CPU.
>
>>=20
>> So, could the commit message lead with the motivation? My guess is th=
at
>> this is about respecting HK_TYPE_TIMER housekeeping on isolated syste=
ms,
>> which system_long_wq cannot do because its per-CPU pool ignores the
>> housekeeping mask once the global timer fires. If that is the case,
>> please say so directly and the mechanism trace becomes a supporting
>> argument rather than the whole argument.
>
> The purpose is explained on the last line:
>
> """
> So change system_long_wq with system_dfl_long_wq so that the work may
>  benefit from scheduler task placement.
> """
>
> Arguably this could be elaborated. For example we can change that:
>
> """
> The consequence of all of this is that the work can run anywhere,
> depending on where the timer fired.
> """
>
> into that:
>
> """
> The consequence of all of this is that the work can run on any
> housekeeping CPU, irrespective of the scheduler that knows better
> about the best task placement, which would apply if the work were
> to be queued on an unbound workqueue.
> """
>
> Would that help?

It's still not clearing it up for me.

Does the patch address a bug (work isn't getting rescheduled at
all) or is it merely a minor optimization for certain platforms?

What's the user-visible issue that will be improved with this
change?

--=20
Chuck Lever

