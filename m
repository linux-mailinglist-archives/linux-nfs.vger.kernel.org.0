Return-Path: <linux-nfs+bounces-22745-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8+csOsDtN2rmVgcAu9opvQ
	(envelope-from <linux-nfs+bounces-22745-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 15:57:20 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B126AB00E
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 15:57:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=IDsgn9Lb;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22745-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22745-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D789B300E388
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 13:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB41A369970;
	Sun, 21 Jun 2026 13:57:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FC2367B83
	for <linux-nfs@vger.kernel.org>; Sun, 21 Jun 2026 13:57:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782050228; cv=none; b=n710li9qGPa+iJizXvyT7XQOLeIMjeSqp5gIPGCnVZSwln3SZBoejw9OLg8TTZ3V/enY0TbSK9EqQRMhCWDYt8GlF0cbF8I2pSlFrtueCMQXF/GFhSrdJINgFxJ/OhZ327+xM/VPiezuoSTaPXMch2WCf4Wk5JkQbBzv5sxtNkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782050228; c=relaxed/simple;
	bh=fvPxhb+XWNbU46fPY8gMPSLeWrRsc2z5sSGUBkotAr0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwkDkRQ06RZAterPvPgX5IGt75HgeX7hTkzS5PyiCp4i5RcG3U7DJ7BhY81IPTy6eAUNJrtifkcjDf4P2lzgCh57x+D0D7ZSTok71ShXmmX78PREQq7JF+8Wf5Nr6dJP/HUgpRniIx1JEhT6dPVyN6MTMMCI8l2NelL3BZXkkeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDsgn9Lb; arc=none smtp.client-ip=209.85.128.175
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-80236b44a1dso12485667b3.0
        for <linux-nfs@vger.kernel.org>; Sun, 21 Jun 2026 06:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782050226; x=1782655026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sv1dki/80aNeWwp+36abGEnVJza7FGEeP7NOY9gPTvc=;
        b=IDsgn9Lb23KedjXNwjRfloquBvpRj0dwvFPGPAQDtjR5tCjOlIZyxGX8LZYKD7D22S
         +fP0YJVtDS6L66zOfEcfzPolWDTcyfNlcNO1LSEJnD92yZGoL/OCS9MzcPtB9YHA5uaX
         MGlL7tW7+31ijgJzSFwabHABzodNxMxv+oEctyDgfvXJiw6HowI/qHOxN7oS0+xh7Ke6
         7VlPJ3ja67RAZVkdDMP+SpeVM0/uL6ruLNMY+JzszK4GcENw/vay9RFT/XolJrMFGBFO
         UB7ig/YBSzOPqaDSD35HVVMbr01R4ktSpk0esy3xlU7S83jBukJBPPHRDXIXxUwgoA23
         n22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782050226; x=1782655026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sv1dki/80aNeWwp+36abGEnVJza7FGEeP7NOY9gPTvc=;
        b=nKPB59EfChS8RBG+79bi/EYtZilPnQeIn4qQeKIgepfnWpkMfNTNpNvrU4BRCntarJ
         hfrq3Ut65TWIZvnmAhU6dVJeHrzAZyxP7L/Ml3uflq16O4OgXZtC2OFitBunxN9IhDnC
         OEg5H8wuOthRg/POWY3NBCaV2+tRS2XqMWJri/YG9Fr3Cwf5luyMYeT08T0HYvQiUYEy
         VVXppfhF9ptU5crxolfKS6ygatUNRTMsCN1GSt1KRtnbE0h+Mj8LganT8QIw4kBlfgGO
         NFAvVCWItr9Uftq5ATfdEs94j2eKenF23FyPtkNSho3pMZcl8Xa7ZuGcmYZde9hG9UKi
         FNng==
X-Forwarded-Encrypted: i=1; AHgh+RpmsKA2p1iGAYNH7BY+Tjyyp7X1mENdZAcLYlEFqXx62pm3C9PVWEm/xuYs1PT6iYvUwjxgbQG23Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ1LQDIglWG2225BbYmjz3qiTxKBkFGWN04anJiAvsB5GWf6fr
	y77FbgZFmoBwFH5+7pK4tqFvPGLhnzUfQHi9dJ94r9niEEABHA5m1q47
X-Gm-Gg: AfdE7cnCJ0pWXXvupK20qKgCax3zraXS5jLvBlNLsyzE5vci5cuWTGpPnjO9cY4KZnB
	lPoEdKGjHdd6MQuoPTM4wwwx2hYgSD24aou9RQHMcWG3vV7Y8lVkZIk4vgqTzDqADBU3aiwvIj+
	QLZIVNawxd+1lKmj/iKS888jCvxm3GuCwfIK4eHwhtfcjJTcxUfx5O/CMAsiUH6qOrnmRVnd53l
	/N9Z9AMGLOGmdkmPrvqY5jaldYi7mEDh0Tzz5mzP0/ZAuAjqdsL/ENWItloMf/ufRk6owhGntJx
	WVJSEfGm3DChHRK/mFlupwHfUurbk25yFLD6yfaTkRD5g0km/KJ36mN8BKp68i0/gILmRBCY8gp
	i8O+ZJcJVSR2NrZe/Ku1z3AcSeBFOERkbiqzD+yQPzcFUU+07eMgdgJhOc8W7rWJltsLJr7z+06
	9ORr8YV5o6RLu7AXJbxdujqZs6E75U2Qa0IHs=
X-Received: by 2002:a05:690c:4b8b:b0:7c5:f6c:d311 with SMTP id 00721157ae682-80131d97bdamr100779827b3.13.1782050226417;
        Sun, 21 Jun 2026 06:57:06 -0700 (PDT)
Received: from localhost (user-24-214-85-55.knology.net. [24.214.85.55])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025c96fdb3sm21073127b3.1.2026.06.21.06.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 06:57:06 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
Date: Sun, 21 Jun 2026 09:57:05 -0400
To: Yury Norov <yury.norov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Julia Lawall <julia.lawall@inria.fr>, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
	intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] tracing: Add CONFIG_TRACE_PRINTK_DEBUGGING to clean
 up kernel.h
Message-ID: <ajftsRwe19fPTP1r@yury>
References: <20260621093430.264983361@kernel.org>
 <20260621093811.168514984@kernel.org>
 <20260621054721.7cde38f0@fedora>
 <ajfphe4Z8BrfYoUX@yury>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajfphe4Z8BrfYoUX@yury>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22745-lists,linux-nfs=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[yurynorov@gmail.com,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_RECIPIENTS(0.00)[m:yury.norov@gmail.com,m:rostedt@goodmis.org,m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:mhiramat@kernel.org,m:mark.rutland@arm.com,m:mathieu.desnoyers@efficios.com,m:akpm@linux-foundation.org,m:torvalds@linux-foundation.org,m:bigeasy@linutronix.de,m:john.ogness@linutronix.de,m:tglx@kernel.org,m:peterz@infradead.org,m:julia.lawall@inria.fr,m:linux-doc@vger.kernel.org,m:linux-kbuild@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:dri-devel@lists.freedesktop.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-rdma@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-ext4@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:kvm@vger.kernel.org,m:intel-gfx@lists.freedesktop.org,m:yurynorov@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yurynorov@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44B126AB00E

On Sun, Jun 21, 2026 at 09:39:17AM -0400, Yury Norov wrote:
> On Sun, Jun 21, 2026 at 05:47:21AM -0400, Steven Rostedt wrote:
> > On Sun, 21 Jun 2026 05:34:32 -0400
> > Steven Rostedt <rostedt@kernel.org> wrote:
> > 
> > > Instead of having trace_printk.h included in kernel.h, create a config
> > > TRACE_PRINTK_DEBUGGING that when set will update the CFLAGS in the
> > > Makefile to allow developers to add trace_printk() without the need to add
> > > the include for it. Having it included in the Makefile keeps it from being
> > > in the dependency chain and it will not waste extra CPU cycles for those
> > > building the kernel without using trace_printk.
> > 
> > Bah, I only tested with the config option enabled, and missed some
> > dependencies with it disabled.
> 
> Yes you did.
>  
> > For instance, rcu.h also uses ftrace_dump() so that too needs to go
> > into kernel.h.
> 
> No, it shouldn't.
> 
> > I also need to add a few more includes to trace_printk.h.
> 
> > OK, I need to run this through all my tests to find where else I missed
> > adding the includes. But the idea should hopefully satisfy everyone.
> 
> If you include it under config in kernel.h, to make the kernel buildable,

I mean: in kernel.h or in Makefile.

> you need to include trace_printk.h explicitly where it's actually used.
> IOW, apply my patch v4-7.
> 
> Then, developers who use trace_printk() on their development machine,
> will be really frustrated when their debugging code will break client
> build just because CONFIG_TRACE_PRINTK_DEBUGGING is disabled there.
> They will spend a day, at best, communicating with remote managers,
> and end up with adding #include <linux/trace_printk.h> in the files
> they touch. Is that your plan?
> 
> If I was one of those developers, the solution would be simple for me:
> don't use trace_printk() at all.
> 
> Thanks,
> Yury

