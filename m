Return-Path: <linux-nfs+bounces-22855-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /zqqK7Y9PmriBwkAu9opvQ
	(envelope-from <linux-nfs+bounces-22855-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 10:52:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A326CB7C7
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 10:52:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZuN86shS;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22855-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22855-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27675300CBE7
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 08:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33AD3E51F0;
	Fri, 26 Jun 2026 08:51:27 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC903E3DAB;
	Fri, 26 Jun 2026 08:51:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782463887; cv=none; b=OTd11UIZpvmCNVNUzzMXj6oCtpU4gRRQKuwXUnGTF/KaCh0ryE2pr4Z0mYVYJld9v9+L856+uC/f8SPR9FFwAIenswL9MUc3vHNPlZ68qa3A9Easa01HMZ3PlC9ml5dy1fv60jpGAbfeFnxLY1HeKBoB5Dcq5svG+XRJgip29no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782463887; c=relaxed/simple;
	bh=72LW1Sqy+CyJluT8dJ+TRAWGIYqhMfoj0D3AB5ay3hw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EqOoRqSNcWYnhnT9yQRZjaV08cPeRk7nSijS+easOoLCIpkZO5ydHJzsmT32rxIHXTjTbyJAqxPpUnJSr5KqlIKkq2WXS7rn79IOk+/KxtkVexSIJ0v6oxfQ3Ci8tlacvSD6G75y+qK7AXN41huxj1mNcTrjjxfWF9qCDwvWpzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuN86shS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C131F000E9;
	Fri, 26 Jun 2026 08:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782463886;
	bh=dczgg0EG8SzCmQOx10ra7Wu7tyi/QlMQ5W656css9gI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZuN86shSSyy0XeJHxDjAleAAh3O8h5DItrYs4TSav34bAuZW0MAx9ZBBE9S3nKp+q
	 JUucAqzuWIOp1XCgdpd9P3oFXnLbWNeWduuAN7d3BLmln+qoARZNZxKF2O06nPeYv4
	 1dAdVGA0JDyuC0sJVCZD2wvL+fK7VqCql7n7upa+dFP/qqyZ8tCeX05jqkcgPFDC5w
	 tFX0+2mg/DvZd1BW9undZCZbfHnid5R0fV0ghRYpjUgkCITPyYbrNbnJWUD3Su88Bu
	 iGHlEwHR4XUomu86ZdOshDLSTLNHrTMNbY7gs9BX+9uYtxaMeTpyySj/HlKZUt2HrK
	 5/RKab/63CQEw==
Date: Fri, 26 Jun 2026 04:51:19 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Thomas
 Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Julia
 Lawall <julia.lawall@inria.fr>, Yury Norov <yury.norov@gmail.com>,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v4 2/2] tracing: Remove trace_printk.h from kernel.h
Message-ID: <20260626045119.659d1e6b@fedora>
In-Reply-To: <20260625234158.GA261868@ax162>
References: <20260625104007.041432666@kernel.org>
	<20260625104402.210473477@kernel.org>
	<20260625234158.GA261868@ax162>
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
	TAGGED_FROM(0.00)[bounces-22855-lists,linux-nfs=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[rostedt@kernel.org,linux-nfs@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:nathan@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:mhiramat@kernel.org,m:mark.rutland@arm.com,m:mathieu.desnoyers@efficios.com,m:akpm@linux-foundation.org,m:torvalds@linux-foundation.org,m:bigeasy@linutronix.de,m:john.ogness@linutronix.de,m:tglx@kernel.org,m:peterz@infradead.org,m:julia.lawall@inria.fr,m:yury.norov@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kbuild@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:dri-devel@lists.freedesktop.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-rdma@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-ext4@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:kvm@vger.kernel.org,m:intel-gfx@lists.freedesktop.org,m:yurynorov@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,arm.com,efficios.com,linux-foundation.org,linutronix.de,infradead.org,inria.fr,gmail.com,lists.ozlabs.org,lists.freedesktop.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fedora:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30A326CB7C7

On Thu, 25 Jun 2026 16:41:58 -0700
Nathan Chancellor <nathan@kernel.org> wrote:


> The following diff resolves it for me, should I send it as a separate
> patch or do you want to just fold it in with a note?
> 
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 621566345406..2301a701ffbb 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -10,6 +10,7 @@
>  #ifndef __LINUX_LOCKDEP_H
>  #define __LINUX_LOCKDEP_H
>  
> +#include <linux/instruction_pointer.h>

Ah, so the reason for this breakage is because lockdep was relying on
instruction_pointer.h, that just happened to be included in kernel.h
via trace_printk.h.

This is a separate issue, so it should be a separate patch. I'll add it
as patch 1 of this series.

Can you send me the config you used. This didn't trigger in my tests.

Thanks,

-- Steve



>  #include <linux/lockdep_types.h>
>  #include <linux/smp.h>
>  #include <asm/percpu.h>


