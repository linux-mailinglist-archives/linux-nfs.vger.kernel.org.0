Return-Path: <linux-nfs+bounces-22827-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MdhBDHAGPWrfvwgAu9opvQ
	(envelope-from <linux-nfs+bounces-22827-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 12:44:00 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D50EE6C4C27
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 12:43:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=T44en6Na;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22827-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22827-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2133E303B192
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 10:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BA63D349A;
	Thu, 25 Jun 2026 10:43:35 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3003CF698;
	Thu, 25 Jun 2026 10:43:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384215; cv=none; b=igQXBHBclsMjgztqBe+FiFLISbambeptdRqT1oqGrH5TopU3eALjA5o3N3GlBjTO3JRwHTA32SWeLnRvuij1jnCLkr/uIiom4Y94rM+W+sY/JSfpc5Hd0G1lfurj2MbknQfS+5WDleKA+9dd9Rm9rZEmBO+NPEEKLQk5QKLHDe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384215; c=relaxed/simple;
	bh=lBuu39UbK68A8xrKG/Ns64hX/mqB5WWzuQz5XMfitXs=;
	h=Message-ID:Date:From:To:Cc:Subject; b=mZf9FEd82+0F71BJrAlS5OgcLW4/F1+fcWVqmPiEG82/dNocQ1YEnhR7vWR3o5H/bWHV+T353Xts6xZXkNi+nDfUgDrI/4Hdnb+w4EZ+pC1gHZcGKYPdGPirk/lbeA9MzHSnConLkHGwPBbDRTofP8jUjo46VqHHLekHfL8JlEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T44en6Na; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7681F00A3A;
	Thu, 25 Jun 2026 10:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782384214;
	bh=olDhkqtxI30UfcWJ97Za0LqCZRLOxs3Rv1WfiI82UaQ=;
	h=Date:From:To:Cc:Subject;
	b=T44en6NaGlPGuxRlGZBX7xnth52c5FHMZA7AOZVAPYNjd0/OrfRoLodTcHRiLQybk
	 YHPoJMZyP0iX25n7G9jANVJXXjT2z//aa7wnRevhkJ0bI3u0YaLzPgTwOLcAbRt64j
	 ACmhmjoVdR07WL1bwoDOgc/oadNP+3aEkFJFaDkjj9n69C6YXWcorpHXSRZwvWTuMo
	 /nSOIt8LzbsdCM6rRxySNy5v7RD5esp/F39Dz65F50D+Tmp5AncdllaYY7jVXX+xRH
	 LpczgNSv52PoLL5Oxla7W8wbkAlEz02czNEPjic5fmsZKO6KeFuPL++VV9MmCK/mlb
	 QVwtXegLzsm0A==
Received: from rostedt by gandalf with local (Exim 4.99.3)
	(envelope-from <rostedt@kernel.org>)
	id 1wchYw-00000002W9c-0A36;
	Thu, 25 Jun 2026 06:44:02 -0400
Message-ID: <20260625104007.041432666@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 25 Jun 2026 06:40:07 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Julia Lawall <julia.lawall@inria.fr>,
 Yury Norov <yury.norov@gmail.com>,
 linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,
 linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org,
 linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org,
 kvm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: [PATCH v4 0/2] tracing: Move non-trace_printk prototypes into trace_controls.h
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22827-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,efficios.com,linux-foundation.org,linutronix.de,infradead.org,inria.fr,gmail.com,vger.kernel.org,lists.ozlabs.org,lists.freedesktop.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:mhiramat@kernel.org,m:mark.rutland@arm.com,m:mathieu.desnoyers@efficios.com,m:akpm@linux-foundation.org,m:torvalds@linux-foundation.org,m:bigeasy@linutronix.de,m:john.ogness@linutronix.de,m:tglx@kernel.org,m:peterz@infradead.org,m:julia.lawall@inria.fr,m:yury.norov@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kbuild@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:dri-devel@lists.freedesktop.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-rdma@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-ext4@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:kvm@vger.kernel.org,m:intel-gfx@lists.freedesktop.org,m:yurynorov@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rostedt@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D50EE6C4C27

Remove trace_printk.h by creating a trace_controls.h for those places that
need access to tracing prototypes like tracing_off() and for the places that
need trace_printk() directly, to have it included directly.

Changse since v3: https://lore.kernel.org/all/20260624081806.120105649@kernel.org/

- Always include trace_controls.h in rcu.h (kernel test robot)

  There are other configs that may include tracing_off() in rcu.h besides
  the one that had the include of trace_controls.h. Just always include
  it in that header to be safe.

Steven Rostedt (2):
      tracing: Move non-trace_printk prototypes into trace_controls.h
      tracing: Remove trace_printk.h from kernel.h

----
 arch/powerpc/kvm/book3s_xics.c         |  1 +
 arch/powerpc/xmon/xmon.c               |  1 +
 arch/s390/kernel/ipl.c                 |  1 +
 arch/s390/kernel/machine_kexec.c       |  1 +
 drivers/gpu/drm/i915/gt/intel_gtt.h    |  1 +
 drivers/gpu/drm/i915/i915_gem.h        |  2 ++
 drivers/hwtracing/stm/dummy_stm.c      |  1 +
 drivers/infiniband/hw/hfi1/trace_dbg.h |  1 +
 drivers/tty/sysrq.c                    |  1 +
 drivers/usb/early/xhci-dbc.c           |  1 +
 fs/ext4/inline.c                       |  1 +
 include/linux/ftrace.h                 |  2 ++
 include/linux/kernel.h                 |  1 -
 include/linux/sunrpc/debug.h           |  1 +
 include/linux/trace_controls.h         | 54 ++++++++++++++++++++++++++++++++
 include/linux/trace_printk.h           | 56 ++--------------------------------
 kernel/debug/debug_core.c              |  1 +
 kernel/panic.c                         |  1 +
 kernel/rcu/rcu.h                       |  1 +
 kernel/rcu/rcutorture.c                |  1 +
 kernel/trace/ring_buffer_benchmark.c   |  1 +
 kernel/trace/trace.h                   |  1 +
 kernel/trace/trace_benchmark.c         |  1 +
 lib/sys_info.c                         |  1 +
 samples/fprobe/fprobe_example.c        |  1 +
 samples/ftrace/ftrace-direct-too.c     |  1 -
 samples/trace_printk/trace-printk.c    |  1 +
 27 files changed, 82 insertions(+), 55 deletions(-)
 create mode 100644 include/linux/trace_controls.h

