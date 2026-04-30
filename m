Return-Path: <linux-nfs+bounces-21308-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HYNMWNw82m42gEAu9opvQ
	(envelope-from <linux-nfs+bounces-21308-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 17:08:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAA74A4724
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 17:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E74C2301CF87
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 15:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181E626B756;
	Thu, 30 Apr 2026 15:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJizXtey"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DC319D074;
	Thu, 30 Apr 2026 15:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561448; cv=none; b=avdcm7AVGHMqOKENJVhKH2+xf6ZfgcyHSjZazPRtksc9Q2ATsFvPsiGQOXlgVPzqNwezrhg0B2xTmZjbYR7fta4XNdvG9S47nGOakFxaVECBjv8qgN8TD1jOhaKRAMEHmtA9Oz6rQFr/Cp0oHBsSao97RCg1dRmueC0for3T07s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561448; c=relaxed/simple;
	bh=/O0CpJRysWYZda1keHG+1ZMsSYW/5zb6IS+USuBxsQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6YkyIRHuB1Jmnqr7zh+IAOlmwkEmBpALocrd6mmF2yN2Ppx0cRzh/rjvidk55gvY2/6bFCZYzswXRSiT1+c03kTJK5enxfrSWWAk7n9ETOexVJUJB1C9z4+GiRKbdonhnc3DdsIxW3+rDg4TYQHbYatScAGyezzHOB9NzMKRKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJizXtey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25258C2BCB3;
	Thu, 30 Apr 2026 15:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777561447;
	bh=/O0CpJRysWYZda1keHG+1ZMsSYW/5zb6IS+USuBxsQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TJizXteyODbb9obnaqnQjl7EuJy3CBoHg2bqOqcQ7YLBmtumqv06iGQkemV/Uclmr
	 eORvvsqhL0WBnnq5Omgc1F8wg+iUKPk4VqXUNZl6/SU7ET/z280dx8t60hOZlk59jX
	 nTyMvMs/iHh85O8Dk3aHq/byW64eEcIPNBX59SB5I9JT0DQzdOIeolpj6JngtZFmdc
	 58H9gy/wBt7B3R56XkUONZUpsmy2jfiQb7PTFM5RKu3qt75W/fTCb5ELkmriRj9R8L
	 0ip34/6YHRu7KAZ6amRcW0OzllheWRhxIdXVkPNE9cdTUkx7j+ctz8k9ZWZE9keGWG
	 aMtI3wfM8aLdg==
Date: Thu, 30 Apr 2026 17:04:04 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Marco Crivellari <marco.crivellari@suse.com>,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [RFC PATCH] xprtrdma: Move long delayed work on
 system_dfl_long_wq
Message-ID: <afNvZKtiQPLbi-3F@localhost.localdomain>
References: <20260430085412.96961-1-marco.crivellari@suse.com>
 <8d1eff7b-3712-4039-87d6-028a4118e210@app.fastmail.com>
 <afNguCraI6AvmZrR@localhost.localdomain>
 <1e220a70-4318-49de-aaac-332c0a1cfab4@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e220a70-4318-49de-aaac-332c0a1cfab4@app.fastmail.com>
X-Rspamd-Queue-Id: 6DAA74A4724
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21308-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,vger.kernel.org,kernel.org,gmail.com,linutronix.de,oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Le Thu, Apr 30, 2026 at 10:05:52AM -0400, Chuck Lever a écrit :
> 
> 
> On Thu, Apr 30, 2026, at 10:01 AM, Frederic Weisbecker wrote:
> > Le Thu, Apr 30, 2026 at 09:35:20AM -0400, Chuck Lever a écrit :
> >> 
> >> On Thu, Apr 30, 2026, at 4:54 AM, Marco Crivellari wrote:
> >> > Currently the code enqueue work items using {queue|mod}_delayed_work(),
> >> > using system_long_wq. This workqueue should be used when long works are
> >> > expected, but it is a per-cpu workqueue.
> >> >
> >> > This is important because queue_delayed_work() queue the work using:
> >> >
> >> >    queue_delayed_work_on(WORK_CPU_UNBOUND, ...);
> >> >
> >> > Note that WORK_CPU_UNBOUND = NR_CPUS.
> >> >
> >> > This would end up calling __queue_delayed_work() that does:
> >> >
> >> >     if (housekeeping_enabled(HK_TYPE_TIMER)) {
> >> >     //      [....]
> >> >     } else {
> >> >             if (likely(cpu == WORK_CPU_UNBOUND))
> >> >                     add_timer_global(timer);
> >> >             else
> >> >                     add_timer_on(timer, cpu);
> >> >     }
> >> >
> >> > So when cpu == WORK_CPU_UNBOUND the timer is global and is
> >> > not using a specific CPU. Later, when __queue_work() is called:
> >> >
> >> >     if (req_cpu == WORK_CPU_UNBOUND) {
> >> >             if (wq->flags & WQ_UNBOUND)
> >> >                     cpu = wq_select_unbound_cpu(raw_smp_processor_id());
> >> >             else
> >> >                     cpu = raw_smp_processor_id();
> >> >     }
> >> >
> >> > Because the wq is not unbound, it takes the CPU where the timer
> >> > fired and enqueue the work on that CPU.
> >> > The consequence of all of this is that the work can run anywhere,
> >> > depending on where the timer fired.
> >> >
> >> > Recently, a new unbound workqueue specific for long running work has
> >> > been added:
> >> >
> >> >    c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")
> >> >
> >> > So change system_long_wq with system_dfl_long_wq so that the work may
> >> > benefit from scheduler task placement.
> >> 
> >> The patch description confuses me.
> >> 
> >> The message ends with "the work can run anywhere, depending on where
> >> the timer fired." Read literally, "can run anywhere" sounds like a
> >> feature, not a bug
> >
> > A feature, but incomplete :)
> >
> >> — and the proposed fix (WQ_UNBOUND) also lets it
> >> run anywhere, just via a different selection path. Without a sentence
> >> saying "and that anywhere includes isolated CPUs, which we don't want,"
> >> the reader is left to fill in the gap.
> >
> > Not quite, global timers don't fire on isolated CPUs. And since it gets enqueued
> > on the CPU where it fired, it won't be enqueued on an isolated CPU.
> >
> >> 
> >> So, could the commit message lead with the motivation? My guess is that
> >> this is about respecting HK_TYPE_TIMER housekeeping on isolated systems,
> >> which system_long_wq cannot do because its per-CPU pool ignores the
> >> housekeeping mask once the global timer fires. If that is the case,
> >> please say so directly and the mechanism trace becomes a supporting
> >> argument rather than the whole argument.
> >
> > The purpose is explained on the last line:
> >
> > """
> > So change system_long_wq with system_dfl_long_wq so that the work may
> >  benefit from scheduler task placement.
> > """
> >
> > Arguably this could be elaborated. For example we can change that:
> >
> > """
> > The consequence of all of this is that the work can run anywhere,
> > depending on where the timer fired.
> > """
> >
> > into that:
> >
> > """
> > The consequence of all of this is that the work can run on any
> > housekeeping CPU, irrespective of the scheduler that knows better
> > about the best task placement, which would apply if the work were
> > to be queued on an unbound workqueue.
> > """
> >
> > Would that help?
> 
> It's still not clearing it up for me.
> 
> Does the patch address a bug (work isn't getting rescheduled at
> all) or is it merely a minor optimization for certain platforms?
> 
> What's the user-visible issue that will be improved with this
> change?

It's not a bug, it's an optimization power-wise and performance-wise
and also part of a bigger sanity change:

- Long works have no reason to stick to a single CPU. If they are converted to
  be unbound, the scheduler can move them to relevant targets to optimize
  performances and power consumption. Hence the new system_unbound_long_wq.
  The goal is to remove system_long_wq if none of its users rely on locality.

- Using queue_delayed_work() with a bound workqueue doesn't make any sense
  since the target is completely random.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

