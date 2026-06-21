Return-Path: <linux-nfs+bounces-22733-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FpRaG/ewN2qSPwcAu9opvQ
	(envelope-from <linux-nfs+bounces-22733-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 11:37:59 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBDB6AA83B
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 11:37:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CPvoIDGL;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22733-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22733-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB4B0300FEEE
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 09:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A234A271A94;
	Sun, 21 Jun 2026 09:37:53 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAC31B142D;
	Sun, 21 Jun 2026 09:37:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782034673; cv=none; b=sedt+oZdXS4+ZHLIqiIH4AgwJifPKKuoV/p8BG4FnQg/vFn3Y4BCvZVVuyqd5m5cmPmjEQjmGLgAmgr9HW3jMvjTNVZHeFHlmDiVAdqweKKrjshWHebgFVpZJqi1j2rCsXXwSSP8tytC7D7yoJeSIrQks9hIiixKRSjALAJeCgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782034673; c=relaxed/simple;
	bh=FisDdvqxIbXxqhaB8xtlu64gqtlFeZpgm6U7vK3Epcs=;
	h=Message-ID:Date:From:To:Cc:Subject; b=hpP1nvDOB+dDtQFV/JbVVyOL2ZQznLIAZUMex98kkRl0QDWxeMSpFvxaUVgeRlGHCkIxm/t61QdM6dYdlLJmITqqNbCtaMvvlSiHhcLAn01froQFrYc/Xunil8lgW6gUgYb5gK/khtr6ZTtHAwFM2Ckvt17Scc7Av0d5OLbymp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPvoIDGL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EEE1F000E9;
	Sun, 21 Jun 2026 09:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782034672;
	bh=3PM2SwKGUgQ1Wfor83rkZsilDOPTMWeMgpO7Hmp6Coc=;
	h=Date:From:To:Cc:Subject;
	b=CPvoIDGL14sCX5ylLaYUAhDC9lMcMiJh12IJzutGSGQKhhN/j3P7fMe1lw15m5Roc
	 tHpoEk8Aby4R7yyQzmUbl4hKAdLn06DdHEiYs3o1201v2up+FU7xKvnepQ/nPPwDCI
	 WFkQeLslfQ8Kj6y7aV8P00hG40B3FZDEvni22GswCCp3bAgMXKZfMgiJsONy+BOgVi
	 k0p/zCAiBS0MY4A0IhU6SDokj6lXppltL7JA3pcuCP15DKxW8Mk4X/xfQ3c3P97y2z
	 c5uOUbqO06EeOjVenm17mc5XrEaYLlP7aug5hC/9nFo5DtP/NtxZmsipMAfim8Ib+w
	 nCbGOugNardpA==
Received: from rostedt by gandalf with local (Exim 4.99.3)
	(envelope-from <rostedt@kernel.org>)
	id 1wbEd0-00000001qTd-46mY;
	Sun, 21 Jun 2026 05:38:10 -0400
Message-ID: <20260621093430.264983361@kernel.org>
User-Agent: quilt/0.69
Date: Sun, 21 Jun 2026 05:34:30 -0400
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
Subject: [PATCH 0/2] tracing: Move trace_printk.h out of kernel.h
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22733-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,efficios.com,linux-foundation.org,linutronix.de,infradead.org,inria.fr,gmail.com,vger.kernel.org,lists.ozlabs.org,lists.freedesktop.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:mhiramat@kernel.org,m:mark.rutland@arm.com,m:mathieu.desnoyers@efficios.com,m:akpm@linux-foundation.org,m:torvalds@linux-foundation.org,m:bigeasy@linutronix.de,m:john.ogness@linutronix.de,m:tglx@kernel.org,m:peterz@infradead.org,m:julia.lawall@inria.fr,m:yury.norov@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kbuild@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:dri-devel@lists.freedesktop.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-rdma@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-ext4@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:kvm@vger.kernel.org,m:intel-gfx@lists.freedesktop.org,m:yurynorov@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rostedt@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0EBDB6AA83B

There's been complaints about trace_printk() being defined in kernel.h as it
can increase the compilation time. As it is only used by some developers for
debugging purposes, it should not be in kernel.h causing lots of wasted CPU
cycles for those that do not ever care about it.

Instead, add a CONFIG_TRACE_PRINTK_DEBUGGING option that developers that do
use it can set and not have to always remember to add #include <linux/trace_printk.h>
to the files they add trace_printk() while debugging. It also means that
those that do not have that config set will not have to worry about wasted
CPU cycles as it is only include in the CFLAGS when the option is set, and
its completely ignored otherwise.

Steven Rostedt (2):
      tracing: Move non-trace_printk prototypes back to kernel.h
      tracing: Add CONFIG_TRACE_PRINTK_DEBUGGING to clean up kernel.h

----
 .../driver_development_debugging_guide.rst         |  2 +-
 Makefile                                           |  5 +++++
 arch/powerpc/kvm/book3s_xics.c                     |  1 +
 drivers/gpu/drm/i915/gt/intel_gtt.h                |  1 +
 drivers/gpu/drm/i915/i915_gem.h                    |  1 +
 drivers/hwtracing/stm/dummy_stm.c                  |  4 ++++
 drivers/infiniband/hw/hfi1/trace_dbg.h             |  1 +
 drivers/usb/early/xhci-dbc.c                       |  1 +
 fs/ext4/inline.c                                   |  1 +
 include/linux/kernel.h                             | 19 ++++++++++++++++++-
 include/linux/sunrpc/debug.h                       |  1 +
 include/linux/trace_printk.h                       | 22 +++-------------------
 kernel/trace/Kconfig                               | 10 ++++++++++
 kernel/trace/ring_buffer_benchmark.c               |  1 +
 kernel/trace/trace.h                               |  1 +
 samples/fprobe/fprobe_example.c                    |  1 +
 samples/ftrace/ftrace-direct-modify.c              |  1 +
 samples/ftrace/ftrace-direct-multi-modify.c        |  1 +
 samples/ftrace/ftrace-direct-multi.c               |  2 +-
 samples/ftrace/ftrace-direct-too.c                 |  2 +-
 samples/ftrace/ftrace-direct.c                     |  2 +-
 21 files changed, 56 insertions(+), 24 deletions(-)

