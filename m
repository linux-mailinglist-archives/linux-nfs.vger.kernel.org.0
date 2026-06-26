Return-Path: <linux-nfs+bounces-22867-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XoFABBfNPmrVLwkAu9opvQ
	(envelope-from <linux-nfs+bounces-22867-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 21:03:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAE26CFD7C
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 21:03:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Tw9iWJ3A;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22867-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22867-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB5D4300A582
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 19:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BE93B9DA9;
	Fri, 26 Jun 2026 19:03:34 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A95478F2F;
	Fri, 26 Jun 2026 19:03:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782500614; cv=none; b=JaZbmRDsZ6shVSgxzDlT4v5srXQUQJrCw9Kpuw1E+dYj+nRNr+jxfm93PkO8KmJ9myYHcEkGOjkmWySN8nR+td8LRDWUrGwjJRKgEsufL2adhqQDaSLBzb05FXA6KutV+rsCGcD68ovkDol0HaURJm86AKIWWv67hZbUduyuV3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782500614; c=relaxed/simple;
	bh=xgD+moCIk2s9p64pqwR5V1lvrLbSEMq1BO1aJJ5fuAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qwdr3UcRB5CEugn3LNBtMlbi0qE/Ce9LjL1kL4LQCb7TT6SsuZYTg0uh88H+O1P0KPaXxsHzzlLqlJbjqlSKhN56L+xDa6y8DXxNFQ50ldNxfjrpWAKbLo4Oci3BafhT077nA26lhqrZSHy7Wqud2imqToQeN/2+Fv5XXHyR0mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tw9iWJ3A; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10911F000E9;
	Fri, 26 Jun 2026 19:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782500612;
	bh=TyFl9GWmXNLl+QLk0gYGvkiIPobdLVhGYz9j6ia1saU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tw9iWJ3AW/qVhYN7KGc/ZTiaZzg/3oECz+DiP4VJfyn3QB4fPWwrgNuAJIGNxs+V2
	 gQMOySYXH+qHCB0JOy7ShmXUDJ864WlfuAmNSW4eC0jw1v5I1DDn/MBUmLRwI+Zmn+
	 Tvx68PQugVu+ljQ23TFRCcjPeBFQjWYKgQD+yv+Dj0NPAyY7KU1ce1064Yq2UJQHNh
	 7PCVds29NYJupkBRTBhXtnaGXQquqVp6AN7Xp9L5f6IxL0XEVKpAcZfxaTF8hC29A2
	 GZgsbwtmAy/ydDOu69TLhC+XE3g2v+Sxjbre9Fp/7W+UikRELgut2FYBWl4v+dv3IH
	 ZX2QubJjR77jQ==
Date: Fri, 26 Jun 2026 12:03:25 -0700
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
Message-ID: <20260626190325.GA3913132@ax162>
References: <20260625104007.041432666@kernel.org>
 <20260625104402.210473477@kernel.org>
 <20260625234158.GA261868@ax162>
 <20260626045119.659d1e6b@fedora>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626045119.659d1e6b@fedora>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22867-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rostedt@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:mhiramat@kernel.org,m:mark.rutland@arm.com,m:mathieu.desnoyers@efficios.com,m:akpm@linux-foundation.org,m:torvalds@linux-foundation.org,m:bigeasy@linutronix.de,m:john.ogness@linutronix.de,m:tglx@kernel.org,m:peterz@infradead.org,m:julia.lawall@inria.fr,m:yury.norov@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kbuild@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:dri-devel@lists.freedesktop.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-rdma@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-ext4@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:kvm@vger.kernel.org,m:intel-gfx@lists.freedesktop.org,m:yurynorov@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,arm.com,efficios.com,linux-foundation.org,linutronix.de,infradead.org,inria.fr,gmail.com,lists.ozlabs.org,lists.freedesktop.org,st-md-mailman.stormreply.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[nathan@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	SURBL_MULTI_FAIL(0.00)[vger.kernel.org:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_FAIL(0.00)[sin.lore.kernel.org:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	BLOCKLISTDE_FAIL(0.00)[100.103.45.18:query timed out];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ax162:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8EAE26CFD7C

On Fri, Jun 26, 2026 at 04:51:19AM -0400, Steven Rostedt wrote:
> On Thu, 25 Jun 2026 16:41:58 -0700
> Nathan Chancellor <nathan@kernel.org> wrote:
> 
> 
> > The following diff resolves it for me, should I send it as a separate
> > patch or do you want to just fold it in with a note?
> > 
> > diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> > index 621566345406..2301a701ffbb 100644
> > --- a/include/linux/lockdep.h
> > +++ b/include/linux/lockdep.h
> > @@ -10,6 +10,7 @@
> >  #ifndef __LINUX_LOCKDEP_H
> >  #define __LINUX_LOCKDEP_H
> >  
> > +#include <linux/instruction_pointer.h>
> 
> Ah, so the reason for this breakage is because lockdep was relying on
> instruction_pointer.h, that just happened to be included in kernel.h
> via trace_printk.h.

Correct.

> This is a separate issue, so it should be a separate patch. I'll add it
> as patch 1 of this series.

Sounds good, thanks!

> Can you send me the config you used. This didn't trigger in my tests.

It is a plain allmodconfig, for example on arm:

  $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- allmodconfig lib/test_context-analysis.o
  In file included from include/linux/local_lock_internal.h:8,
                   from include/linux/local_lock.h:5,
                   from lib/test_context-analysis.c:9:
  include/linux/local_lock_internal.h: In function 'local_lock_acquire':
  include/linux/lockdep.h:541:87: error: '_THIS_IP_' undeclared (first use in this function)
    541 | #define lock_map_acquire(l)                     lock_acquire_exclusive(l, 0, 0, NULL, _THIS_IP_)
        |                                                                                       ^~~~~~~~~
  include/linux/lockdep.h:509:88: note: in definition of macro 'lock_acquire_exclusive'
    509 | #define lock_acquire_exclusive(l, s, t, n, i)           lock_acquire(l, s, t, 0, 1, n, i)
        |                                                                                        ^
  include/linux/local_lock_internal.h:46:9: note: in expansion of macro 'lock_map_acquire'
     46 |         lock_map_acquire(&l->dep_map);
        |         ^~~~~~~~~~~~~~~~
  include/linux/lockdep.h:541:87: note: each undeclared identifier is reported only once for each function it appears in
  ...

I also reproduced it on top of allnoconfig:

  $ cat allno.config
  CONFIG_CONTEXT_ANALYSIS_TEST=y
  CONFIG_DEBUG_KERNEL=y
  CONFIG_DEBUG_LOCK_ALLOC=y
  CONFIG_EXPERT=y
  CONFIG_MMU=y
  CONFIG_RUNTIME_TESTING_MENU=y

  $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- KCONFIG_ALLCONFIG=1 clean allnoconfig lib/test_context-analysis.o
  <same error as above>

-- 
Cheers,
Nathan

