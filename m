Return-Path: <linux-nfs+bounces-21301-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNhZBONg82lT1wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21301-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 16:02:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2314A3CD8
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 16:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19CF5301A29C
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 14:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CBC426D35;
	Thu, 30 Apr 2026 14:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmX+75RE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C9D364028;
	Thu, 30 Apr 2026 14:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777557691; cv=none; b=uEsIJO7uJP/pOTILjNPweXyinriqkyuKWHiyRs2vyx/JCqxh5YWc5Mdu/UwBa1fTd69AxE6AQ+XzJPvIx7P3ZFpkL/QdZQIOEkoXZtcfuLKJxFUsXJm1Z9gybVVkJH+xYeXraJBcscw2qQMo77UKSG+BbFROOj5H5Ac5GN5kdfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777557691; c=relaxed/simple;
	bh=tNrp1D3CtHv2mQWxtU+ukHKoE/X+FkZHstE+5Mc1gDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUlY3R3yn8IVd6l5FjRMgazWCekQtDsEi0ASehw5oidHja5W/MgX8q70wiOZDFo6ZXjCa8RxXAhHlh8Rm56uszXMf9ZyZGE662AHmJMtpUp23rgHuQCGsGItoASZGQORlZqBZ9UwfzTPqolYVBJewABn0gJmsf69EEGCDi3s5fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmX+75RE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E5CC2BCB8;
	Thu, 30 Apr 2026 14:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777557691;
	bh=tNrp1D3CtHv2mQWxtU+ukHKoE/X+FkZHstE+5Mc1gDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nmX+75RELzybgZKKEFxx5nl/CakoeuK/3Lf5HOLRPxHYC6/AgfhfYMWyjdvfIJCgQ
	 Lv5N2/r6EtP6MjaFIjouvel4FIk+fPXvsInPUUU4NwaM0tpbY67D1PuWnAB/XWp52t
	 S7gFo2XDGZevPFRSGHLtCnLrOBdbeq9ra/ohhaGukHQKjPU8riurDeElEngRVknyO3
	 AZ/Y2P33oGv6Z98BHSaL05OSrnhB2u4TiUEIQ5yCdpnseh5A8FZVH5G6yQBKFo5w/f
	 sUlHLVYNF+UcAkgbM1J7Xic1lnalFCopy5ml/e7ABSJDzVnDhOZDvYBVzsH+q/FPZQ
	 axF9t7FUO0Lxw==
Date: Thu, 30 Apr 2026 16:01:28 +0200
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
Message-ID: <afNguCraI6AvmZrR@localhost.localdomain>
References: <20260430085412.96961-1-marco.crivellari@suse.com>
 <8d1eff7b-3712-4039-87d6-028a4118e210@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d1eff7b-3712-4039-87d6-028a4118e210@app.fastmail.com>
X-Rspamd-Queue-Id: AD2314A3CD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21301-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,localhost.localdomain:mid]

Le Thu, Apr 30, 2026 at 09:35:20AM -0400, Chuck Lever a écrit :
> 
> On Thu, Apr 30, 2026, at 4:54 AM, Marco Crivellari wrote:
> > Currently the code enqueue work items using {queue|mod}_delayed_work(),
> > using system_long_wq. This workqueue should be used when long works are
> > expected, but it is a per-cpu workqueue.
> >
> > This is important because queue_delayed_work() queue the work using:
> >
> >    queue_delayed_work_on(WORK_CPU_UNBOUND, ...);
> >
> > Note that WORK_CPU_UNBOUND = NR_CPUS.
> >
> > This would end up calling __queue_delayed_work() that does:
> >
> >     if (housekeeping_enabled(HK_TYPE_TIMER)) {
> >     //      [....]
> >     } else {
> >             if (likely(cpu == WORK_CPU_UNBOUND))
> >                     add_timer_global(timer);
> >             else
> >                     add_timer_on(timer, cpu);
> >     }
> >
> > So when cpu == WORK_CPU_UNBOUND the timer is global and is
> > not using a specific CPU. Later, when __queue_work() is called:
> >
> >     if (req_cpu == WORK_CPU_UNBOUND) {
> >             if (wq->flags & WQ_UNBOUND)
> >                     cpu = wq_select_unbound_cpu(raw_smp_processor_id());
> >             else
> >                     cpu = raw_smp_processor_id();
> >     }
> >
> > Because the wq is not unbound, it takes the CPU where the timer
> > fired and enqueue the work on that CPU.
> > The consequence of all of this is that the work can run anywhere,
> > depending on where the timer fired.
> >
> > Recently, a new unbound workqueue specific for long running work has
> > been added:
> >
> >    c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")
> >
> > So change system_long_wq with system_dfl_long_wq so that the work may
> > benefit from scheduler task placement.
> 
> The patch description confuses me.
> 
> The message ends with "the work can run anywhere, depending on where
> the timer fired." Read literally, "can run anywhere" sounds like a
> feature, not a bug

A feature, but incomplete :)

> — and the proposed fix (WQ_UNBOUND) also lets it
> run anywhere, just via a different selection path. Without a sentence
> saying "and that anywhere includes isolated CPUs, which we don't want,"
> the reader is left to fill in the gap.

Not quite, global timers don't fire on isolated CPUs. And since it gets enqueued
on the CPU where it fired, it won't be enqueued on an isolated CPU.

> 
> So, could the commit message lead with the motivation? My guess is that
> this is about respecting HK_TYPE_TIMER housekeeping on isolated systems,
> which system_long_wq cannot do because its per-CPU pool ignores the
> housekeeping mask once the global timer fires. If that is the case,
> please say so directly and the mechanism trace becomes a supporting
> argument rather than the whole argument.

The purpose is explained on the last line:

"""
So change system_long_wq with system_dfl_long_wq so that the work may
 benefit from scheduler task placement.
"""

Arguably this could be elaborated. For example we can change that:

"""
The consequence of all of this is that the work can run anywhere,
depending on where the timer fired.
"""

into that:

"""
The consequence of all of this is that the work can run on any
housekeeping CPU, irrespective of the scheduler that knows better
about the best task placement, which would apply if the work were
to be queued on an unbound workqueue.
"""

Would that help?

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

