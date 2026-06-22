Return-Path: <linux-nfs+bounces-22752-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uCb/E4ztOGqykAcAu9opvQ
	(envelope-from <linux-nfs+bounces-22752-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 10:08:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AFD6AD866
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 10:08:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WKhiDDUd;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22752-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22752-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97513301324D
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 08:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892D738E8B9;
	Mon, 22 Jun 2026 08:05:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787FA35BDC7;
	Mon, 22 Jun 2026 08:05:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115521; cv=none; b=BOHlFV2qfaWNeL/c6RcCoHApqOBTS0wHKxzCaDlMZuxDoml+sHbi8AeoMgZrPp9g9upRnjSL5+ynltYnWyvoovARZfj0a5Taaar+vbOvZdkYks0UT2mvyJGdPRRAFnfqpkBYAzLbwyZAuHlnj9TN+uDD3mOf7XyAuYVfOPeVqX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115521; c=relaxed/simple;
	bh=OlSbs9VLtf/8IxeWwRDXkTD/lKuu/eFujrA7c2e9KSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUigK4pukFvGY8vXstr72PGDapkVBkCkcIOQ0Aa0lzhhrGCoRHtv/L9ZOqlGiED9mSb6ZvdCr4I+wOFRe3vwsXy5K+MsZ/yj137d0ynbvJdujVruZXVAjubcvSXBNoiNKSzJLND1mkf5PHwRLI4QKQ9Dby+fYli3WZnO/1F8E9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKhiDDUd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B84C1F000E9;
	Mon, 22 Jun 2026 08:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782115519;
	bh=FAbpiNhKVqoEfhFmUfUdlxgESW8QuGiY+lhl+lA+T60=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WKhiDDUdL0KRgYXfe2WI9TPD1Fcz4Jm9ZEs4TCvppOjXgUFC4H1afMQFw+2v6sbYC
	 wyKQOW94sIC2JrNxh5T1XMUYBWAlDKC18spHzcXcYSeSIENbdvnOdBeIFeCRHU0wcr
	 GXhaSILwuzYrxIUKMomqoVtJ32rfzWA7jVghDLmfnz+BZrvg16SiSZpHTKMbep/4WK
	 cTRFBl6B2TwAUd1X5OjJrSj8wdRtwPxWGGAsp+lGM7jfcHoi8eTosbKCizRmGWHd0+
	 cQFh5OCUybibOIb31BzksIWMYD20OkhiGIxmv8Z+opVm7KScIv+rhlWvQYzzdL9N23
	 S4BwD770Utgzw==
Message-ID: <dbb5915e-6587-4de9-87f3-76bea5024da8@kernel.org>
Date: Mon, 22 Jun 2026 10:05:13 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] tracing: Move trace_printk.h out of kernel.h
To: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>, Thomas Gleixner <tglx@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Julia Lawall <julia.lawall@inria.fr>,
 Yury Norov <yury.norov@gmail.com>, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
References: <20260621093430.264983361@kernel.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260621093430.264983361@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22752-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rostedt@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:mhiramat@kernel.org,m:mark.rutland@arm.com,m:mathieu.desnoyers@efficios.com,m:akpm@linux-foundation.org,m:torvalds@linux-foundation.org,m:bigeasy@linutronix.de,m:john.ogness@linutronix.de,m:tglx@kernel.org,m:peterz@infradead.org,m:julia.lawall@inria.fr,m:yury.norov@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kbuild@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:dri-devel@lists.freedesktop.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-rdma@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-ext4@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:kvm@vger.kernel.org,m:intel-gfx@lists.freedesktop.org,m:yurynorov@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[chleroy@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,efficios.com,linux-foundation.org,linutronix.de,infradead.org,inria.fr,gmail.com,vger.kernel.org,lists.ozlabs.org,lists.freedesktop.org,st-md-mailman.stormreply.com,lists.infradead.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C9AFD6AD866



Le 21/06/2026 à 11:34, Steven Rostedt a écrit :
> There's been complaints about trace_printk() being defined in kernel.h as it
> can increase the compilation time. As it is only used by some developers for
> debugging purposes, it should not be in kernel.h causing lots of wasted CPU
> cycles for those that do not ever care about it.

Do we have a measurement of the increased compilation time ?

Christophe

> 
> Instead, add a CONFIG_TRACE_PRINTK_DEBUGGING option that developers that do
> use it can set and not have to always remember to add #include <linux/trace_printk.h>
> to the files they add trace_printk() while debugging. It also means that
> those that do not have that config set will not have to worry about wasted
> CPU cycles as it is only include in the CFLAGS when the option is set, and
> its completely ignored otherwise.
> 
> Steven Rostedt (2):
>        tracing: Move non-trace_printk prototypes back to kernel.h
>        tracing: Add CONFIG_TRACE_PRINTK_DEBUGGING to clean up kernel.h
> 
> ----
>   .../driver_development_debugging_guide.rst         |  2 +-
>   Makefile                                           |  5 +++++
>   arch/powerpc/kvm/book3s_xics.c                     |  1 +
>   drivers/gpu/drm/i915/gt/intel_gtt.h                |  1 +
>   drivers/gpu/drm/i915/i915_gem.h                    |  1 +
>   drivers/hwtracing/stm/dummy_stm.c                  |  4 ++++
>   drivers/infiniband/hw/hfi1/trace_dbg.h             |  1 +
>   drivers/usb/early/xhci-dbc.c                       |  1 +
>   fs/ext4/inline.c                                   |  1 +
>   include/linux/kernel.h                             | 19 ++++++++++++++++++-
>   include/linux/sunrpc/debug.h                       |  1 +
>   include/linux/trace_printk.h                       | 22 +++-------------------
>   kernel/trace/Kconfig                               | 10 ++++++++++
>   kernel/trace/ring_buffer_benchmark.c               |  1 +
>   kernel/trace/trace.h                               |  1 +
>   samples/fprobe/fprobe_example.c                    |  1 +
>   samples/ftrace/ftrace-direct-modify.c              |  1 +
>   samples/ftrace/ftrace-direct-multi-modify.c        |  1 +
>   samples/ftrace/ftrace-direct-multi.c               |  2 +-
>   samples/ftrace/ftrace-direct-too.c                 |  2 +-
>   samples/ftrace/ftrace-direct.c                     |  2 +-
>   21 files changed, 56 insertions(+), 24 deletions(-)
> 


