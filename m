Return-Path: <linux-nfs+bounces-22846-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kA/fKPK8PWpE6AgAu9opvQ
	(envelope-from <linux-nfs+bounces-22846-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 01:42:42 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3006D6C928D
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 01:42:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ERWk9tSf;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22846-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22846-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 067EF304C7D2
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 23:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACF634C9AD;
	Thu, 25 Jun 2026 23:42:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18BE13B7AE;
	Thu, 25 Jun 2026 23:42:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782430928; cv=none; b=LUz93YxxdARVhH4drYsSK1hwl3DPX3X2Jip6k0WL9ZwHfyUx6USkkvQ7ma+TZZzoZaIRLPG1QRiVBHn0y85mQsW8sugV9K52kKvlrscrMeN7f+kFpQQFVkbO1ZVBkHyWcbI/0xgdJS+b8jKQ2rQ8Y42YDhj4kfXzN3RHKoKtfT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782430928; c=relaxed/simple;
	bh=XLWncx6sAi2SL2n9opoom94BbjE0WreKNCFruJ4bcbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSX1vhnyPXqWCfZMe2VumjoUiaDOsXft3XSYjbcuLce5UiTdxVqCpP0eDgmAtJa84XpgBaU7gQXFhUH7S+jpcQBvWiUM1IJaCLir4dAViIP9ZA6d/qjEiGfi2WRQxfWXUfd5v6Ue1wRQNWvEkEy6VyPOTEXpi++zHqR7NMKS9hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERWk9tSf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DEF11F000E9;
	Thu, 25 Jun 2026 23:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782430926;
	bh=7rTeWGRC3qlYe3M/STi4OqC/ckIFBCcw0pmuKzcM+Ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ERWk9tSfkvUB3gpMoi+r8/npeOf+VTcK6LEcTQ+ydlZM4R04BnjE7NoxRlL2Y7oOp
	 HwEILF3l/MEtXv4l1oapXtPAddR7mVIcAbFM+/NzAauaraVXtWjthqV/7Xr9jV0rmP
	 iV/aTYKta1D6uPYRp+2hh9+GTlghECm8I505IDeByN96e5NV0eCKP7muVv5sc3JnQG
	 O3K8AFvvCi6QK5nN6WRqQQQyuO2ODeP0WbSkJkHgCIFXVq1+HVSkMdVsvtq4txrVyP
	 sezhtjuTBGj4tnd2fWtTX6Neebzlxe0449kNqUc5+ZQaEKrKtQDmJHaKYNRwLyfJcc
	 gFiMuxnkCmkKg==
Date: Thu, 25 Jun 2026 16:41:58 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Julia Lawall <julia.lawall@inria.fr>,
	Yury Norov <yury.norov@gmail.com>, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
	intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v4 2/2] tracing: Remove trace_printk.h from kernel.h
Message-ID: <20260625234158.GA261868@ax162>
References: <20260625104007.041432666@kernel.org>
 <20260625104402.210473477@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625104402.210473477@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rostedt@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:mhiramat@kernel.org,m:mark.rutland@arm.com,m:mathieu.desnoyers@efficios.com,m:akpm@linux-foundation.org,m:torvalds@linux-foundation.org,m:bigeasy@linutronix.de,m:john.ogness@linutronix.de,m:tglx@kernel.org,m:peterz@infradead.org,m:julia.lawall@inria.fr,m:yury.norov@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kbuild@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:dri-devel@lists.freedesktop.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-rdma@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-ext4@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:kvm@vger.kernel.org,m:intel-gfx@lists.freedesktop.org,m:yurynorov@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22846-lists,linux-nfs=lfdr.de];
	FORGED_SENDER(0.00)[nathan@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,arm.com,efficios.com,linux-foundation.org,linutronix.de,infradead.org,inria.fr,gmail.com,lists.ozlabs.org,lists.freedesktop.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,goodmis.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3006D6C928D

Hi Steve,

On Thu, Jun 25, 2026 at 06:40:09AM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> There have been complaints about trace_printk.h causing more build time
> for being in kernel.h if it changes. There is also an effort to clean up
> kernel.h to have it not include unneeded header files. Move trace_printk.h
> out of kernel.h and place it in the headers and C files that use it.
> 
> Link: https://lore.kernel.org/all/CAHk-=wikCBeVFjVXiY4o-oepdbjAoir5+TcAgtL12c4u1TpZLQ@mail.gmail.com/
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

This patch breaks lib/test_context-analysis.c for me in several
configurations:

  In file included from lib/test_context-analysis.c:9:
  In file included from include/linux/local_lock.h:5:
  include/linux/local_lock_internal.h:46:2: error: use of undeclared identifier '_THIS_IP_'
     46 |         lock_map_acquire(&l->dep_map);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  include/linux/lockdep.h:541:69: note: expanded from macro 'lock_map_acquire'
    541 | #define lock_map_acquire(l)                     lock_acquire_exclusive(l, 0, 0, NULL, _THIS_IP_)
        |                                                                                       ^~~~~~~~~
  In file included from lib/test_context-analysis.c:9:
  In file included from include/linux/local_lock.h:5:
  include/linux/local_lock_internal.h:53:2: error: use of undeclared identifier '_THIS_IP_'
     53 |         lock_map_acquire_try(&l->dep_map);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  include/linux/lockdep.h:542:73: note: expanded from macro 'lock_map_acquire_try'
    542 | #define lock_map_acquire_try(l)                 lock_acquire_exclusive(l, 0, 1, NULL, _THIS_IP_)
        |                                                                                       ^~~~~~~~~
  In file included from lib/test_context-analysis.c:9:
  In file included from include/linux/local_lock.h:5:
  include/linux/local_lock_internal.h:62:2: error: use of undeclared identifier '_THIS_IP_'
     62 |         lock_map_release(&l->dep_map);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  include/linux/lockdep.h:545:47: note: expanded from macro 'lock_map_release'
    545 | #define lock_map_release(l)                     lock_release(l, _THIS_IP_)
        |                                                                 ^~~~~~~~~
  3 errors generated.

The following diff resolves it for me, should I send it as a separate
patch or do you want to just fold it in with a note?

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 621566345406..2301a701ffbb 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -10,6 +10,7 @@
 #ifndef __LINUX_LOCKDEP_H
 #define __LINUX_LOCKDEP_H
 
+#include <linux/instruction_pointer.h>
 #include <linux/lockdep_types.h>
 #include <linux/smp.h>
 #include <asm/percpu.h>
-- 
Cheers,
Nathan

