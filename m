Return-Path: <linux-nfs+bounces-22767-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K5bNDltoOWrLrwcAu9opvQ
	(envelope-from <linux-nfs+bounces-22767-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 18:52:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA62D6B14C3
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 18:52:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=C4kpffoq;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22767-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22767-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BED1C301A729
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 16:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2D233A9CB;
	Mon, 22 Jun 2026 16:52:05 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8E733CEA2;
	Mon, 22 Jun 2026 16:52:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782147125; cv=none; b=m7duQFja7eQHu4lW779ji7JgVH5TgtlQcj8WbybBHd8/8cZ3rBWlKt+9G1rVixO4zEPipVhkbFeqcQSrZ8reMChMhBS0taleu8jmMNt8HtS+1y/dZvryrGPNE8X8UQA9k0FZlfkcypGvWkr+/yXpzb2G7pblqcpSbLirgwl82ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782147125; c=relaxed/simple;
	bh=6+P9pSwfaRh/FJ2Ae5JWmxAni7SXDOgYmFtpbfKSAtY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPkpG1A6L6WLr8KWB1r6iY2fmfDeVx30ixsSRN58DUXcA1a/XkmG+Mi5AL5XnnBjwsD+pOkrrlyqHvQO1MaXb3i2aoLRoZsYkql6QPDsF60/m99eFthU7idN6zAgqozv/+SA0Df+51SQLmeG4YYt7ACjO+iQAKD6j9BUX08ates=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4kpffoq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0041F000E9;
	Mon, 22 Jun 2026 16:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782147124;
	bh=KXhjFgbhEvwE+7GGBfh7My0VIVq6OjTLQwMtEz0hufY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C4kpffoqKELHy6h2iIonBbM+lwHOlkqgrFXueJXDfdgl75fDx8nTrSA+oGiGyoeAm
	 8CCy0uyoOREJUge4zC6mq+dv0w+QL43toIPSNlcNAZyZKDjugsy6al/c7V2Nxly4Pl
	 B3u0wZw90AH5q2Vforbc/8novl4n4De9d7hKEY2j9fwmOHjRuuHlA8HYlkPOQSxTMr
	 w8OjFxrmzo3xN9JG3zdPXZhL02HItS9kysxEXgHLRRSGAVfOqOYr/WF7zxLGK20H2R
	 AQhZ61uSQFpPSM+xdZ5/Wi01z1P5qKOyIveeDb+LOtEbWIs/Vdg1dtFfhX3DZ+GRC2
	 IABQXBNVHhFSA==
Date: Mon, 22 Jun 2026 12:51:54 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Thomas
 Gleixner <tglx@kernel.org>, Julia Lawall <julia.lawall@inria.fr>, Yury
 Norov <yury.norov@gmail.com>, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 0/2] tracing: Move trace_printk.h out of kernel.h
Message-ID: <20260622125154.6f5b9b33@fedora>
In-Reply-To: <08b3c961-18bb-43d9-8d7f-8a87bcad0afa@infradead.org>
References: <20260621093430.264983361@kernel.org>
	<20260622083440.GX49951@noisy.programming.kicks-ass.net>
	<08b3c961-18bb-43d9-8d7f-8a87bcad0afa@infradead.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22767-lists,linux-nfs=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[rostedt@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:rdunlap@infradead.org,m:peterz@infradead.org,m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:mhiramat@kernel.org,m:mark.rutland@arm.com,m:mathieu.desnoyers@efficios.com,m:akpm@linux-foundation.org,m:torvalds@linux-foundation.org,m:bigeasy@linutronix.de,m:john.ogness@linutronix.de,m:tglx@kernel.org,m:julia.lawall@inria.fr,m:yury.norov@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kbuild@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:dri-devel@lists.freedesktop.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-rdma@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-ext4@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:kvm@vger.kernel.org,m:intel-gfx@lists.freedesktop.org,m:yurynorov@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[infradead.org,vger.kernel.org,kernel.org,arm.com,efficios.com,linux-foundation.org,linutronix.de,inria.fr,gmail.com,lists.ozlabs.org,lists.freedesktop.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,fedora:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA62D6B14C3

On Mon, 22 Jun 2026 09:40:45 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> > Did you forget your C 101 class? If you use a function, you gotta
> > include the relevant header.  
> 
> Also item #1 in Documentation/process/submit-checklist.rst.

What is that? Remove all trace_printk()s before you submit?

Because that is what you should do. But now you also need to remember
to remove the include <linux/trace_printk.h> too. Or, I guess if
someone uses it a lot, they may just keep it in their files without the
trace_printk()s.

-- Steve

